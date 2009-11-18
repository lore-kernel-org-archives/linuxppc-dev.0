Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0503FB7CF1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 08:06:42 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc: Add support for ram filesystems in FIT uImages
Date: Wed, 18 Nov 2009 14:57:14 -0600
Message-Id: <1258577834-26006-4-git-send-email-ptyser@xes-inc.com>
In-Reply-To: <1258577834-26006-1-git-send-email-ptyser@xes-inc.com>
References: <1258577834-26006-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PowerPC architecture has the ability to embed the ramdisk located
at arch/powerpc/boot/ramdisk.image.gz into a bootable kernel image.  If
the bootable kernel is in the Flattened Image Tree (FIT) format, the
ramdisk should be a node in the tree instead of being embedded directly
in the kernel executable.

A FIT uImage with a ram filesystem can be generated using the command:
"make uImage.fit.initrd.<boardname>" where <boardname> is one of
arch/powerpc/boot/dts/<boardname>.dts.  The command will generate a FIT
uImage at arch/powerpc/boot/uImage.fit.initrd.<boardname> that contains
a kernel image, device tree blob, and a ram filesystem.

The ramdisk at arch/powerpc/boot/ramdisk.image.gz can either be an older
style "ramdisk" or a newer "ramfs" gzipped cpio archive.

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
---
 arch/powerpc/boot/Makefile |    3 +++
 arch/powerpc/boot/wrapper  |   20 ++++++++++++++++----
 scripts/mkits.sh           |   35 +++++++++++++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 57e4eee..c2b6c25 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -310,6 +310,9 @@ $(obj)/uImage: vmlinux $(wrapperbits)
 $(obj)/uImage.fit.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,uboot.fit,,$(obj)/$*.dtb)
 
+$(obj)/uImage.fit.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,uboot.fit,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+
 $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 26a971e..8027ef9 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -266,6 +266,9 @@ fi
 # physical offset of kernel image
 membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
 
+# Size of uncompressed kernel is needed to calculate ramdisk location in RAM
+kernsize=`${CROSS}objdump -p "$kernel" | grep -m 1 rwx | awk '{print $4}'`
+
 case "$platform" in
 uboot)
     rm -f "$ofile"
@@ -278,8 +281,14 @@ uboot)
     ;;
 uboot.fit)
     rm -f "$ofile"
-    ${MKITS} -A ppc -C gzip -a $membase -e $membase -v $version \
-	-d "$srctree/$dtb" -k "$srctree/$vmz" -o "$object/uImage.its"
+    if [ -n "$initrd" ]; then
+	${MKITS} -A ppc -C gzip -a $membase -e $membase -v $version \
+	    -d "$srctree/$dtb" -k "$srctree/$vmz" -r "$srctree/$initrd" \
+	    -l $kernsize -o "$object/uImage.its"
+    else
+	${MKITS} -A ppc -C gzip -a $membase -e $membase -v $version \
+	    -d "$srctree/$dtb" -k "$srctree/$vmz" -o "$object/uImage.its"
+    fi
     ${MKIMAGE} -f "$object/uImage.its" "$ofile"
     rm "$object/uImage.its"
     if [ -z "$cacheit" ]; then
@@ -300,8 +309,11 @@ if [ -z "$cacheit" ]; then
     rm -f "$vmz"
 fi
 
-if [ -n "$initrd" ]; then
-    addsec $tmp "$initrd" $isection
+# FIT images have the initrd in the image tree structure
+if [ "$platform" != "uboot.fit" ]; then
+    if [ -n "$initrd" ]; then
+	addsec $tmp "$initrd" $isection
+    fi
 fi
 
 if [ -n "$dtb" ]; then
diff --git a/scripts/mkits.sh b/scripts/mkits.sh
index a438cac..88411dd 100755
--- a/scripts/mkits.sh
+++ b/scripts/mkits.sh
@@ -16,7 +16,8 @@
 
 usage() {
 	echo "Usage: `basename $0` -A arch -C comp -a addr -e entry" \
-		"-v version -k kernel [-d dtb] -o its_file"
+		"-v version -k kernel [-d dtb] [-r ramfs -l ramfs_addr]" \
+		"-o its_file"
 	echo -e "\t-A ==> set architecture to 'arch'"
 	echo -e "\t-C ==> set compression type 'comp'"
 	echo -e "\t-a ==> set load address to 'addr' (hex)"
@@ -24,11 +25,13 @@ usage() {
 	echo -e "\t-v ==> set kernel version to 'version'"
 	echo -e "\t-k ==> include kernel image 'kernel'"
 	echo -e "\t-d ==> include Device Tree Blob 'dtb'"
+	echo -e "\t-r ==> include initrd/initramfs 'ramfs'"
+	echo -e "\t-l ==> load initrd/initramfs at 'ramfs_addr'"
 	echo -e "\t-o ==> create output file 'its_file'"
 	exit 1
 }
 
-while getopts ":A:C:a:d:e:k:o:v:" OPTION
+while getopts ":A:C:a:d:e:k:l:o:r:v:" OPTION
 do
 	case $OPTION in
 		A ) ARCH=$OPTARG;;
@@ -37,7 +40,9 @@ do
 		d ) DTB=$OPTARG;;
 		e ) ENTRY_ADDR=$OPTARG;;
 		k ) KERNEL=$OPTARG;;
+		l ) RAMFS_ADDR=$OPTARG;;
 		o ) OUTPUT=$OPTARG;;
+		r ) RAMFS=$OPTARG;;
 		v ) VERSION=$OPTARG;;
 		* ) echo "Invalid option passed to '$0' (options:$@)"
 		usage;;
@@ -49,11 +54,14 @@ if [ -z "${ARCH}" ] || [ -z "${COMPRESS}" ] || [ -z "${LOAD_ADDR}" ] || \
 	[ -z "${ENTRY_ADDR}" ] || [ -z "${VERSION}" ] || [ -z "${KERNEL}" ] || \
 	[ -z "${OUTPUT}" ]; then
 	usage
+elif [ -n "${RAMFS}" ] && [ -z "${RAMFS_ADDR}" ]; then
+	usage
 fi
 
 # Device trees need the leading '0x' stripped for hex numbers
 LOAD_ADDR=`echo $LOAD_ADDR | sed 's/0x//'`
 ENTRY_ADDR=`echo $ENTRY_ADDR | sed 's/0x//'`
+RAMFS_ADDR=`echo $RAMFS_ADDR | sed 's/0x//'`
 
 # Create a default, fully populated DTS file
 DATA="/ {
@@ -92,6 +100,23 @@ DATA="/ {
 			};
 		}; /* end fdt */
 
+		ramdisk@1 { /* start ramdisk */
+			description = \"ramdisk\";
+			data = /incbin/(\"${RAMFS}\");
+			type = \"ramdisk\";
+			arch = \"${ARCH}\";
+			os = \"linux\";
+			load = <${RAMFS_ADDR}>;
+			compression = \"none\";
+			hash@1 {
+				algo = \"crc32\";
+			};
+			hash@2 {
+				algo = \"sha1\";
+			};
+		}; /* end ramdisk */
+	};
+
 	configurations {
 		default = \"config@1\";
 		config@1 {
@@ -103,6 +128,12 @@ DATA="/ {
 	};
 };"
 
+# Conditionally strip ramfs information out of tree
+if [ -z "${RAMFS}" ]; then
+	DATA=`echo "$DATA" | sed '/start ramdisk/,/end ramdisk/d'`
+	DATA=`echo "$DATA" | sed '/ramdisk/d'`
+fi
+
 # Conditionally strip fdt information out of tree
 if [ -z "${DTB}" ]; then
 	DATA=`echo "$DATA" | sed '/start fdt/,/end fdt/d'`
-- 
1.6.2.1
