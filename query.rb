$: << File.join(File.dirname(__FILE__), "vendor/json_pure")
require 'net/http'
require "uri"
require "json/pure"

def search(gem)
  if gem.length > 2
    $stderr.puts "Searching for #{gem}\n"
    response = Net::HTTP.get "rubygems.org", '/api/v1/search.json?query='+gem
    json = JSON.parse response
    $stderr.puts "Got response: #{json}\n"
    return json
  else
    return []
  end
end

begin
  result = search(ARGV[0])
  puts '<?xml version="1.0"?>'
  puts '<items>'
  result.each_with_index do |gem,index|
    puts "  <item uid='#{index}' arg='#{gem["project_uri"]}'>"
    puts "    <title>#{gem['name']}</title>"
    puts "    <subtitle>#{gem['name']}</subtitle>"
    puts "    <icon>icon.png</icon>"
    puts "  </item>"
  end
  puts '</items>'
  exit 0
end
