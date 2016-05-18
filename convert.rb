require "csv"
require "uri"


unless ARGV[0]
  puts "Argument required for CSV file"
  exit
end

input_file_name = ARGV[0]
converted_file_name = input_file_name.gsub(/\.csv$/, '-converted.csv')

CSV.open(converted_file_name, "wb") do |csv_writer|
  CSV.open(ARGV[0]).read.each do |url|
    original_url = url[0]
    if 'http' == URI.parse(original_url).scheme
      https_url = original_url.gsub(/^http/, 'https')
      csv_writer << [original_url, https_url]
    end
  end
end
