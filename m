Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 22C7ADE291
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 04:53:58 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so968391eyi.15
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Sep 2008 11:53:56 -0700 (PDT)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] bootwrapper: support u-boot multi component images
Date: Mon, 15 Sep 2008 20:53:53 +0200
Message-Id: <1221504833-5096-1-git-send-email-jacmet@sunsite.dk>
Sender: Peter Korsgaard <jacmet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: peter Korsgaard <jacmet@sunsite.dk>

Support uImage.<platform>, which are U-Boot multi component images
containing a kernel, dtb and possibly an initrd.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Documentation/powerpc/bootwrapper.txt |    4 ++++
 arch/powerpc/boot/Makefile            |   11 +++++++++--
 arch/powerpc/boot/wrapper             |   20 +++++++++++++++++++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/powerpc/bootwrapper.txt b/Documentation/powerpc/bootwrapper.txt
index d60fced..f0b34b3 100644
--- a/Documentation/powerpc/bootwrapper.txt
+++ b/Documentation/powerpc/bootwrapper.txt
@@ -91,6 +91,10 @@ Currently, the following image format targets exist:
 			a device tree to the kernel at boot.  If using an older
 			version of U-Boot, then you need to use a cuImage
 			instead.
+   uImage.thinx:	U-Boot multi component image. Similar to uImage,
+			except device tree blob is embedded inside the
+			image together with the kernel (and potentially
+			an initrd).
    zImage.%:		Image format which does not embed a device tree.
 			Used by OpenFirmware and other firmware interfaces
 			which are able to supply a device tree.  This image
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 717a3bc..41ab6aa 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -282,8 +282,9 @@ image-y	+= $(subst ",,$(CONFIG_EXTRA_TARGETS))
 initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, \
 		$(patsubst dtbImage%, dtbImage.initrd%, \
+		$(patsubst uImage.%, uImage.initrd.%, \
 		$(patsubst simpleImage%, simpleImage.initrd%, \
-		$(patsubst treeImage%, treeImage.initrd%, $(image-y)))))
+		$(patsubst treeImage%, treeImage.initrd%, $(image-y))))))
 initrd-y := $(filter-out $(image-y), $(initrd-y))
 targets	+= $(image-y) $(initrd-y)
 
@@ -316,6 +317,12 @@ $(obj)/zImage.iseries: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+$(obj)/uImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb
+	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+
+$(obj)/uImage.%: vmlinux $(wrapperbits) $(obj)/%.dtb
+	$(call if_changed,wrap,uboot-$*,,$(obj)/$*.dtb)
+
 $(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
 
@@ -352,7 +359,7 @@ install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 	zImage zImage.initrd zImage.chrp zImage.coff zImage.holly \
 	zImage.iseries zImage.miboot zImage.pmac zImage.pseries \
-	otheros.bld *.dtb
+	otheros.bld uImage.* *.dtb
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 965c237..b7c0b23 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -153,7 +153,7 @@ coff)
     lds=$object/zImage.coff.lds
     link_address='0x500000'
     ;;
-miboot|uboot)
+miboot|uboot|uboot-*)
     # miboot and U-boot want just the bare bits, not an ELF binary
     ext=bin
     objflags="-O binary"
@@ -262,6 +262,24 @@ uboot)
     fi
     exit 0
     ;;
+uboot-*)
+    rm -f "$ofile"
+    # we always need an initrd - create a dummy initrd if none provided
+    if [ ! -f "initrd" ]; then
+	initrd="$tmpdir/dummy.initrd"
+	echo -n fill >$initrd
+    fi
+    mkimage -A ppc -O linux -T multi -C gzip -a $membase -e $membase \
+	$uboot_version -d "$vmz:$initrd:$dtb" "$ofile"
+    if [ "$initrd" == "$tmpdir/dummy.initrd" ]; then
+	rm $initrd;
+    fi
+    if [ -z "$cacheit" ]; then
+	rm -f "$vmz"
+    fi
+    exit 0
+    ;;
+
 esac
 
 addsec() {
-- 
1.5.6.3
