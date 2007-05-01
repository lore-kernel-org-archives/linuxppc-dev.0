Return-Path: <dgibson@ozlabs.org>
Date: Tue, 1 May 2007 10:20:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Small cleanups to the cuboot bootwrapper code
Message-ID: <20070501002020.GA29172@localhost.localdomain>
References: <20070430034202.GB6436@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070430034202.GB6436@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes a few small cleanups to the cuboot code.
	- It removes the double layered selection of images, via
cuboot-plat-y, instead having the cuboot platforms directly select a
suitable image-y (this changes the name of the final cuboot image from
plain cuImage to cuImage.<platform>).
	- Factors out some code in the wrapper that's potentially
useful to platforms other than uboot.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---

Revised to fix a small breakage due to another fix which was merged.

 arch/powerpc/Makefile      |    2 +-
 arch/powerpc/boot/Makefile |   15 ++++++---------
 arch/powerpc/boot/wrapper  |   28 +++++++++++++---------------
 3 files changed, 20 insertions(+), 25 deletions(-)

Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-01 10:04:58.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-01 10:13:52.000000000 +1000
@@ -129,7 +129,9 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.ps
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
-image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
+image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
+image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
+image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
@@ -162,15 +164,11 @@ $(obj)/zImage.initrd.ps3: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
-cuboot-plat-$(CONFIG_83xx) += 83xx
-cuboot-plat-$(CONFIG_85xx) += 85xx
-cuboot-plat-y += unknown-platform
-
 dts = $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
        ,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE)
 
-$(obj)/cuImage: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,cuboot-$(word 1,$(cuboot-plat-y)),$(dts))
+$(obj)/cuImage.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,cuboot-$*,$(dts))
 
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
@@ -181,8 +179,7 @@ install: $(CONFIGURE) $(addprefix $(obj)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd \
-               cuImage.elf cuImage.bin.gz
+clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.*
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
Index: working-2.6/arch/powerpc/boot/wrapper
===================================================================
--- working-2.6.orig/arch/powerpc/boot/wrapper	2007-04-26 13:57:24.000000000 +1000
+++ working-2.6/arch/powerpc/boot/wrapper	2007-05-01 10:13:03.000000000 +1000
@@ -163,20 +163,19 @@ fi
 
 vmz="$vmz$gzip"
 
-case "$platform" in
-uboot|cuboot*)
-    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
-	cut -d' ' -f3`
-    if [ -n "$version" ]; then
-	version="-n Linux-$version"
-    fi
-esac
+# Extract kernel version information, some platforms want to include
+# it in the image header
+version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
+    cut -d' ' -f3`
+if [ -n "$version" ]; then
+    uboot_version="-n Linux-$version"
+fi
 
 case "$platform" in
 uboot)
     rm -f "$ofile"
     mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
-	$version -d "$vmz" "$ofile"
+	$uboot_version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
     fi
@@ -212,25 +211,24 @@ if [ "$platform" != "miboot" ]; then
     rm $tmp
 fi
 
+# Some platforms need the zImage's entry point and base address
+base=0x`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
+entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | cut -d' ' -f3`
+
 # post-processing needed for some platforms
 case "$platform" in
 pseries|chrp)
     $object/addnote "$ofile"
     ;;
 pmaccoff)
-    entry=`objdump -f "$ofile" | grep '^start address ' | \
-	cut -d' ' -f3`
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $object/hack-coff "$ofile"
     ;;
 cuboot*)
-    base=`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
-    entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | \
-           cut -d' ' -f3`
     mv "$ofile" "$ofile".elf
     ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
     gzip -f -9 "$ofile".bin
     mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
-            $version -d "$ofile".bin.gz "$ofile"
+            $uboot_version -d "$ofile".bin.gz "$ofile"
     ;;
 esac
Index: working-2.6/arch/powerpc/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/Makefile	2007-04-30 10:57:46.000000000 +1000
+++ working-2.6/arch/powerpc/Makefile	2007-05-01 10:13:03.000000000 +1000
@@ -148,7 +148,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage cuImage
+BOOT_TARGETS = zImage zImage.initrd uImage
 
 PHONY += $(BOOT_TARGETS)
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
