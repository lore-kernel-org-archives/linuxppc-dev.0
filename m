Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0D868DDEB8
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 09:25:58 +1000 (EST)
Date: Mon, 16 Apr 2007 18:25:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/4] bootwrapper: Add a cuboot platform and a cuImage target.
Message-ID: <20070416232550.GA26693@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416232451.GA26667@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cuImage target will build a uImage with bootwrapper code and a device
tree.  The default device tree and platform file are determined by the
kernel configuration.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This version of the patch handles "make clean" correctly.

 arch/powerpc/Makefile        |    2 +-
 arch/powerpc/boot/.gitignore |    3 +++
 arch/powerpc/boot/Makefile   |   13 +++++++++++--
 arch/powerpc/boot/wrapper    |   21 +++++++++++++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a00fe72..e6c3add 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -148,7 +148,7 @@ all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage
+BOOT_TARGETS = zImage zImage.initrd uImage cuImage
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 0734b2f..eec7af7 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -18,6 +18,9 @@ kernel-vmlinux.strip.c
 kernel-vmlinux.strip.gz
 mktree
 uImage
+cuImage
+cuImage.bin.gz
+cuImage.elf
 zImage
 zImage.chrp
 zImage.coff
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 928b88a..d602b7c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -129,7 +129,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
-image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
@@ -162,6 +162,14 @@ $(obj)/zImage.initrd.ps3: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+cuboot-plat-y += unknown-platform
+
+dts = $(if $(shell echo $(CONFIG_) | grep '^/'),\
+       ,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE)
+
+$(obj)/cuImage: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,cuboot-$(word 1,$(cuboot-plat-y)),$(dts))
+
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 	@rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
@@ -171,7 +179,8 @@ install: $(CONFIGURE) $(image-y)
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $<
 
 # anything not in $(targets)
-clean-files += $(image-) $(initrd-) zImage zImage.initrd
+clean-files += $(image-) $(initrd-) zImage zImage.initrd \
+               cuImage.elf cuImage.bin.gz
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index e4566bd..5cedd90 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -141,6 +141,9 @@ miboot|uboot)
     ksection=image
     isection=initrd
     ;;
+cuboot*)
+    gzip=
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
@@ -161,13 +164,17 @@ fi
 vmz="$vmz$gzip"
 
 case "$platform" in
-uboot)
-    rm -f "$ofile"
+uboot|cuboot*)
     version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
 	cut -d' ' -f3`
     if [ -n "$version" ]; then
 	version="-n Linux-$version"
     fi
+esac
+
+case "$platform" in
+uboot)
+    rm -f "$ofile"
     mkimage -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
 	$version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
@@ -216,4 +223,14 @@ pmaccoff)
     ${CROSS}objcopy -O aixcoff-rs6000 --set-start "$entry" "$ofile"
     $object/hack-coff "$ofile"
     ;;
+cuboot*)
+    base=`${CROSS}nm "$ofile" | grep ' _start$' | cut -d' ' -f1`
+    entry=`${CROSS}objdump -f "$ofile" | grep '^start address ' | \
+           cut -d' ' -f3`
+    mv "$ofile" "$ofile".elf
+    ${CROSS}objcopy -O binary "$ofile".elf "$ofile".bin
+    gzip -f -9 "$ofile".bin
+    mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
+            $version -d "$ofile".bin.gz "$ofile"
+    ;;
 esac
-- 
1.5.0.3
