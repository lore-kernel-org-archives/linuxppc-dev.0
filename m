Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id C15A2DDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 05:59:04 +1100 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JWL001ZCRD7YU20@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 21 Feb 2008 11:58:19 -0700 (MST)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JWL002R7RD6BW50@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 21 Feb 2008 11:58:20 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JWL00NUCRCV5B80@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 21 Feb 2008 11:58:07 -0700 (MST)
Date: Thu, 21 Feb 2008 11:57:07 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] Fix zImage-dtb.initrd build error
To: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org
Message-id: <20080221185651.6893.78700.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Cc: miltonm@bga.com, paulus@samba.org, Hiroaki_Fuse@hq.scei.sony.co.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The pattern substitution rules were failing when used with zImage-dtb
targets.  if zImage-dtb.initrd was selected, the pattern substitution
would generate "zImage.initrd-dtb" instead of "zImage-dtb.initrd" which
caused the build to fail.

This patch renames zImage-dtb to dtbImage to avoid the problem entirely.
By not using the zImage prefix then is no potential for namespace
collisions.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

---
Note to reviewers.  Please consider this change carefully.  I saw two
options for fixing this bug;
1) rework the pattern substitution to handle zImage-dtb correctly
2) avoid using the zImage prefix

I chose option 2 because it avoids increasing the complexity of the
pattern substitution code for generating initrd names.  However, doing
so will have an impact on distributors because it changes the name of
the generated image.  If this is a problem for anyone, or if you have
a better name suggestion than "dtbImage", then please speak up.

Cheers,
g.
---

 arch/powerpc/Makefile      |    2 +-
 arch/powerpc/boot/Makefile |   18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1c6ce35..ab5cfe8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -155,7 +155,7 @@ all: zImage
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage treeImage.% cuImage.%
+BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.%
 
 PHONY += $(BOOT_TARGETS)
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 63d07cc..d57a67d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -186,7 +186,7 @@ quiet_cmd_wrap	= WRAP    $@
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
-image-$(CONFIG_PPC_PS3)			+= zImage-dtb.ps3
+image-$(CONFIG_PPC_PS3)			+= dtbImage.ps3
 image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
@@ -205,7 +205,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 #
 
 # Board ports in arch/powerpc/platform/40x/Kconfig
-image-$(CONFIG_EP405)			+= zImage-dtb.ep405
+image-$(CONFIG_EP405)			+= dtbImage.ep405
 image-$(CONFIG_WALNUT)			+= treeImage.walnut
 
 # Board ports in arch/powerpc/platform/44x/Kconfig
@@ -220,9 +220,9 @@ image-$(CONFIG_WARP)			+= cuImage.warp
 # Board ports in arch/powerpc/platform/8xx/Kconfig
 image-$(CONFIG_PPC_MPC86XADS)		+= cuImage.mpc866ads
 image-$(CONFIG_PPC_MPC885ADS)		+= cuImage.mpc885ads
-image-$(CONFIG_PPC_EP88XC)		+= zImage-dtb.ep88xc
+image-$(CONFIG_PPC_EP88XC)		+= dtbImage.ep88xc
 image-$(CONFIG_PPC_ADDER875)		+= cuImage.adder875-uboot \
-					   zImage-dtb.adder875-redboot
+					   dtbImage.adder875-redboot
 
 # Board ports in arch/powerpc/platform/52xx/Kconfig
 image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 cuImage.lite5200b
@@ -230,7 +230,7 @@ image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 cuImage.lite5200b
 # Board ports in arch/powerpc/platform/82xx/Kconfig
 image-$(CONFIG_MPC8272_ADS)		+= cuImage.mpc8272ads
 image-$(CONFIG_PQ2FADS)			+= cuImage.pq2fads
-image-$(CONFIG_EP8248E)			+= zImage-dtb.ep8248e
+image-$(CONFIG_EP8248E)			+= dtbImage.ep8248e
 
 # Board ports in arch/powerpc/platform/83xx/Kconfig
 image-$(CONFIG_MPC832x_MDS)		+= cuImage.mpc832x_mds
@@ -268,7 +268,8 @@ endif
 
 initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, \
-		$(patsubst treeImage%, treeImage.initrd%, $(image-y)))
+		$(patsubst dtbImage%, dtbImage.initrd%, \
+		$(patsubst treeImage%, treeImage.initrd%, $(image-y))))
 initrd-y := $(filter-out $(image-y), $(initrd-y))
 targets	+= $(image-y) $(initrd-y)
 
@@ -283,10 +284,11 @@ $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 $(obj)/zImage.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*)
 
-$(obj)/zImage-dtb.initrd.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
+# dtbImage% - a dtbImage is a zImage with an embedded device tree blob
+$(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
 	$(call if_changed,wrap,$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
 
-$(obj)/zImage-dtb.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
+$(obj)/dtbImage.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
 	$(call if_changed,wrap,$*,$(dtstree)/$*.dts)
 
 # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
