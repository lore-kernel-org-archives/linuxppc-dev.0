Return-Path: <ptyser@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3C78B6F1C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 12:50:50 +1100 (EST)
From: Peter Tyser <ptyser@xes-inc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/3] powerpc: Add support for creating FIT uImages
Date: Mon, 21 Dec 2009 19:50:42 -0600
Message-Id: <1261446643-21714-3-git-send-email-ptyser@xes-inc.com>
In-Reply-To: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent U-Boot versions support booting a Flattened Image Tree (FIT)
image format.  The FIT uImage format uses a tree structure to describe a
kernel image as well as supporting device tree blobs, ramdisks, etc.
The 'mkimage' and 'dtc' utilities convert this tree description into a
binary blob that bootloaders such as U-Boot can execute.

This patch adds support for automatically creating a U-Boot FIT image
using the "make uImage.fit.<boardname>" command where <boardname> is
one of arch/powerpc/boot/dts/<boardname>.dts.  The resulting
arch/powerpc/boot/uImage.fit.<boardname> file will contain a kernel
image as well as a device tree blob.  U-Boot versions compiled with FIT
support can directly boot this image using the "bootm" command.

Additional information about the FIT format and its uses can be found in
doc/uImage.FIT/howto.txt of U-Boot's source tree.

Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
---
Changes since v1:
- Add 'dts-v1' header to scripts/mkits.sh output
- Don't strip leading 0x from dts addresses
- Default to using kernel dtc if the user doesn't have it in their path

 arch/powerpc/Makefile        |    4 +-
 arch/powerpc/boot/.gitignore |    1 +
 arch/powerpc/boot/Makefile   |    5 ++-
 arch/powerpc/boot/wrapper    |   20 +++++++-
 scripts/mkits.sh             |  111 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 3 deletions(-)
 create mode 100755 scripts/mkits.sh

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1a54a3b..459aed5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -158,7 +158,8 @@ drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 # Default to zImage, override when needed
 all: zImage
 
-BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
+BOOT_TARGETS = zImage zImage.initrd uImage uImage.fit.% zImage% dtbImage% \
+	       treeImage.% cuImage.% simpleImage.%
 
 PHONY += $(BOOT_TARGETS)
 
@@ -185,6 +186,7 @@ define archhelp
   @echo '* zImage          - Build default images selected by kernel config'
   @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
   @echo '  uImage          - U-Boot native image format'
+  @echo '  uImage.fit.<dt> - U-Boot Flattened Image Tree image format'
   @echo '  cuImage.<dt>    - Backwards compatible U-Boot image for older'
   @echo '                    versions which do not support device trees'
   @echo '  dtbImage.<dt>   - zImage with an embedded device tree blob'
diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 3d80c3e..a443f1c 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -19,6 +19,7 @@ kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
 uImage
+uImage.fit.*
 cuImage.*
 dtbImage.*
 treeImage.*
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index bb2465b..e56ec21 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -310,6 +310,9 @@ $(obj)/zImage.iseries: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+$(obj)/uImage.fit.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,uboot.fit,,$(obj)/$*.dtb)
+
 $(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
 
@@ -349,7 +352,7 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
-	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
+	uImage.* zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
 	zImage.iseries zImage.miboot zImage.pmac zImage.pseries \
 	simpleImage.* otheros.bld *.dtb
 
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index f4594ed..1f35b66 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -46,6 +46,9 @@ CROSS=
 # mkimage wrapper script
 MKIMAGE=$srctree/scripts/mkuboot.sh
 
+# script to generate an .its file for uImage.fit.* images
+MKITS=$srctree/scripts/mkits.sh
+
 # directory for object and other files used by this script
 object=arch/powerpc/boot
 objbin=$object
@@ -157,7 +160,7 @@ coff)
     lds=$object/zImage.coff.lds
     link_address='0x500000'
     ;;
-miboot|uboot)
+miboot|uboot|uboot.fit)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
     objflags="-O binary"
@@ -277,6 +280,21 @@ uboot)
     fi
     exit 0
     ;;
+uboot.fit)
+    rm -f "$ofile"
+    ${MKITS} -A ppc -C gzip -a $membase -e $membase -v $version \
+	-d "$srctree/$dtb" -k "$srctree/$vmz" -o "$object/uImage.its"
+
+    # mkimage calls dtc for FIT images so use kernel dtc if necessary
+    export PATH=$PATH:$srctree/scripts/dtc
+
+    ${MKIMAGE} -f "$object/uImage.its" "$ofile"
+    rm "$object/uImage.its"
+    if [ -z "$cacheit" ]; then
+	rm -f "$vmz"
+    fi
+    exit 0
+    ;;
 esac
 
 addsec() {
diff --git a/scripts/mkits.sh b/scripts/mkits.sh
new file mode 100755
index 0000000..fae43dd
--- /dev/null
+++ b/scripts/mkits.sh
@@ -0,0 +1,111 @@
+#!/bin/bash
+#
+# Licensed under the terms of the GNU GPL License version 2 or later.
+#
+# Author: Peter Tyser <ptyser@xes-inc.com>
+#
+# U-Boot firmware supports the booting of images in the Flattened Image
+# Tree (FIT) format.  The FIT format uses a device tree structure to
+# describe a kernel image, device tree blob, ramdisk, etc.  This script
+# creates an Image Tree Source (.its file) which can be passed to the
+# 'mkimage' utility to generate an Image Tree Blob (.itb file).  The .itb
+# file can then be booted by U-Boot (or other bootloaders which support
+# FIT images).  See doc/uImage.FIT/howto.txt in U-Boot source code for
+# additional information on FIT images.
+#
+
+usage() {
+	echo "Usage: `basename $0` -A arch -C comp -a addr -e entry" \
+		"-v version -k kernel [-d dtb] -o its_file"
+	echo -e "\t-A ==> set architecture to 'arch'"
+	echo -e "\t-C ==> set compression type 'comp'"
+	echo -e "\t-a ==> set load address to 'addr' (hex)"
+	echo -e "\t-e ==> set entry point to 'entry' (hex)"
+	echo -e "\t-v ==> set kernel version to 'version'"
+	echo -e "\t-k ==> include kernel image 'kernel'"
+	echo -e "\t-d ==> include Device Tree Blob 'dtb'"
+	echo -e "\t-o ==> create output file 'its_file'"
+	exit 1
+}
+
+while getopts ":A:C:a:d:e:k:o:v:" OPTION
+do
+	case $OPTION in
+		A ) ARCH=$OPTARG;;
+		C ) COMPRESS=$OPTARG;;
+		a ) LOAD_ADDR=$OPTARG;;
+		d ) DTB=$OPTARG;;
+		e ) ENTRY_ADDR=$OPTARG;;
+		k ) KERNEL=$OPTARG;;
+		o ) OUTPUT=$OPTARG;;
+		v ) VERSION=$OPTARG;;
+		* ) echo "Invalid option passed to '$0' (options:$@)"
+		usage;;
+	esac
+done
+
+# Make sure user entered all required parameters
+if [ -z "${ARCH}" ] || [ -z "${COMPRESS}" ] || [ -z "${LOAD_ADDR}" ] || \
+	[ -z "${ENTRY_ADDR}" ] || [ -z "${VERSION}" ] || [ -z "${KERNEL}" ] || \
+	[ -z "${OUTPUT}" ]; then
+	usage
+fi
+
+# Create a default, fully populated DTS file
+DATA="/dts-v1/;
+
+/ {
+	description = \"Linux kernel ${VERSION}\";
+	#address-cells = <1>;
+
+	images {
+		kernel@1 {
+			description = \"Linux Kernel ${VERSION}\";
+			data = /incbin/(\"${KERNEL}\");
+			type = \"kernel\";
+			arch = \"${ARCH}\";
+			os = \"linux\";
+			compression = \"${COMPRESS}\";
+			load = <${LOAD_ADDR}>;
+			entry = <${ENTRY_ADDR}>;
+			hash@1 {
+				algo = \"crc32\";
+			};
+			hash@2 {
+				algo = \"sha1\";
+			};
+		};
+
+		fdt@1 { /* start fdt */
+			description = \"Flattened Device Tree blob\";
+			data = /incbin/(\"${DTB}\");
+			type = \"flat_dt\";
+			arch = \"${ARCH}\";
+			compression = \"none\";
+			hash@1 {
+				algo = \"crc32\";
+			};
+			hash@2 {
+				algo = \"sha1\";
+			};
+		}; /* end fdt */
+
+	configurations {
+		default = \"config@1\";
+		config@1 {
+			description = \"Default Linux kernel\";
+			kernel = \"kernel@1\";
+			fdt = \"fdt@1\";
+			ramdisk = \"ramdisk@1\";
+		};
+	};
+};"
+
+# Conditionally strip fdt information out of tree
+if [ -z "${DTB}" ]; then
+	DATA=`echo "$DATA" | sed '/start fdt/,/end fdt/d'`
+	DATA=`echo "$DATA" | sed '/fdt/d'`
+fi
+
+# Write .its file to disk
+echo "$DATA" > ${OUTPUT}
-- 
1.6.2.1
