#!/bin/zsh

SOURCE_DIR=/Users/coreygrone/Downloads
OUTPUT_DIR=/Users/coreygrone/Downloads

iso_files=(
	"$SOURCE_DIR"/*.iso
	"$SOURCE_DIR"/*.ISO
)

for (( i = 1; i <= ${#iso_files[@]}; i++ )); do
	echo "Mounting $iso_files[i]"
	FILE_NAME=$(basename "$iso_files[i]")
	FILE_NAME="${FILE_NAME%.*}"
	MOUNT_POINT=$(hdiutil mount $iso_files[i])
	MOUNT_POINT=${MOUNT_POINT#*"/Volumes/"}
	echo "Encoding /Volumes/$MOUNT_POINT to $OUTPUT_DIR/$FILE_NAME.mkv"
#	echo "/Applications/HandBrakeCLI --preset ""H.265 MKV 720p30"" --main-feature --format ""av_mkv"" --input ""/Volumes/$MOUNT_POINT"" --output ""$OUTPUT_DIR/$FILE_NAME.mkv"" >> handbrake.log"
	/Applications/HandBrakeCLI --preset "H.265 MKV 720p30" --main-feature --format "av_mkv" --input "/Volumes/$MOUNT_POINT" --output "$OUTPUT_DIR/$FILE_NAME.mkv" >> handbrake.log
	echo "Unmounting /Volumes/$MOUNT_POINT"
	hdiutil unmount "/Volumes/$MOUNT_POINT"
done