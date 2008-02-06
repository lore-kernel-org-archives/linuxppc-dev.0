Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id E55ABDDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 03:51:08 +1100 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JVT007M4TF58760@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 06 Feb 2008 09:49:53 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JVT00ERUTEWBH00@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 06 Feb 2008 09:49:54 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JVT00LTFTEP3G30@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 06 Feb 2008 09:49:43 -0700 (MST)
Date: Wed, 06 Feb 2008 09:48:52 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3] [POWERPC] bootwrapper: build multiple cuImages
To: paulus@samba.org, jwboyer@gmail.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, galak@kernel.crashing.org,
	geoffrey.levand@am.sony.com, arnd@arndb.de
Message-id: <20080206164656.10079.15210.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Currently, the kernel uses CONFIG_DEVICE_TREE to wrap a kernel image
with a fdt blob which means for any given configuration only one dts
file can be selected and so support for only one board can be built

This patch moves the selection of the default .dts file out of the kernel
config and into the bootwrapper makefile.  The makefile chooses which
images to build based on the kernel config and the dts source file
name is taken directly from the image name.  For example "cuImage.ebony"
will use "ebony.dts" as the device tree source file.

In addition, this patch allows a specific image to be requested from the
command line by adding "cuImage.%" and "treeImage.%" targets to the list
of valid built targets in arch/powerpc/Makefile.  This allows the default
dts selection to be overridden.

Another advantage to this change is it allows a single defconfig to be
supplied for all boards using the same chip family and only differing in
the device tree.

Important note: This patch adds two new zImage targets; zImage.dtb.% and
zImage.dtb.initrd.% for zImages with embedded dtb files.  Currently
there are 5 platforms which require this: ps3, ep405, mpc885ads, ep88xc,
adder875-redboot and ep8248e.  This patch *changes the zImage filenames*
for those platforms.  ie. 'zImage.ps3' is now 'zImage.dtb.ps3'.

This new zImage.dtb targets were added so that the .dts file could be
part of the dependancies list for building them.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

---
v3: I think this patch is complete.  Renamed zImage.dtb.% targets to
zImage-dtb.% to avoid make choosing the wrong rule if the dts file is missing.
Please test to make sure nothing is broken.  I'd like to see this one get
picked up for .25

v2: This version fixes some bugs and adds new zImage.dtb and
zImage.initrd.dtb targets.

v1: Please review and comment.  I have not exhaustively tested this patch
and I'm sure to have missed some boards.  However, I think the concept
is sound and will be a good change.
---

 arch/powerpc/Kconfig                   |   19 -----
 arch/powerpc/Makefile                  |    9 +-
 arch/powerpc/boot/Makefile             |  130 ++++++++++++++++++++------------
 arch/powerpc/boot/cuboot-hpc2.c        |   48 ------------
 arch/powerpc/boot/cuboot-mpc7448hpc2.c |   48 ++++++++++++
 arch/powerpc/boot/wrapper              |   23 ++++++
 6 files changed, 155 insertions(+), 122 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2bf2f3f..4903796 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -415,25 +415,6 @@ config WANT_DEVICE_TREE
 	bool
 	default n
 
-config DEVICE_TREE
-	string "Static device tree source file"
-	depends on WANT_DEVICE_TREE
-	help
-	  This specifies the device tree source (.dts) file to be
-	  compiled and included when building the bootwrapper.  If a
-	  relative filename is given, then it will be relative to
-	  arch/powerpc/boot/dts.  If you are not using the bootwrapper,
-	  or do not need to build a dts into the bootwrapper, this
-	  field is ignored.
-
-	  For example, this is required when building a cuImage target
-	  for an older U-Boot, which cannot pass a device tree itself.
-	  Such a kernel will not work with a newer U-Boot that tries to
-	  pass a device tree (unless you tell it not to).  If your U-Boot
-	  does not mention a device tree in "help bootm", then use the
-	  cuImage target and specify a device tree here.  Otherwise, use
-	  the uImage target and leave this field blank.
-
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f70df9b..6845482 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -151,14 +151,11 @@ core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
 # Default to zImage, override when needed
-defaultimage-y			:= zImage
-defaultimage-$(CONFIG_DEFAULT_UIMAGE) := uImage
-KBUILD_IMAGE := $(defaultimage-y)
-all: $(KBUILD_IMAGE)
+all: zImage
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage
+BOOT_TARGETS = zImage zImage.initrd uImage treeImage.% cuImage.%
 
 PHONY += $(BOOT_TARGETS)
 
@@ -180,7 +177,7 @@ define archhelp
 endef
 
 install: vdso_install
-	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
+	$(Q)$(MAKE) $(build)=$(boot) install
 
 vdso_install:
 ifeq ($(CONFIG_PPC64),y)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 122a270..dc9952a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -60,8 +60,9 @@ src-wlib := string.S crt0.S stdio.c main.c \
 src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
-		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
-		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
+		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
+		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
+		fixed-head.S ep88xc.c ep405.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c
 src-boot := $(src-wlib) $(src-plat) empty.c
@@ -123,6 +124,8 @@ targets		+= $(patsubst $(obj)/%,%,$(obj-boot) wrapper.a)
 extra-y		:= $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
 		   $(obj)/zImage.lds $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds
 
+dtstree		:= $(srctree)/$(src)/dts
+
 wrapper		:=$(srctree)/$(src)/wrapper
 wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree dtc) \
 			$(wrapper) FORCE
@@ -181,7 +184,7 @@ quiet_cmd_wrap	= WRAP    $@
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
-image-$(CONFIG_PPC_PS3)			+= zImage.ps3
+image-$(CONFIG_PPC_PS3)			+= zImage-dtb.ps3
 image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
@@ -191,33 +194,73 @@ image-$(CONFIG_PPC_PRPMC2800)		+= zImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
-ifneq ($(CONFIG_DEVICE_TREE),"")
-image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
-image-$(CONFIG_PPC_EP88XC)		+= zImage.ep88xc
-image-$(CONFIG_EP405)			+= zImage.ep405
-image-$(CONFIG_8260)			+= cuImage.pq2
-image-$(CONFIG_EP8248E)			+= zImage.ep8248e
-image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
-image-$(CONFIG_STORCENTER)		+= cuImage.824x
-image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
-image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
-ifeq ($(CONFIG_CPM2),y)
-image-$(CONFIG_PPC_85xx)		+= cuImage.85xx-cpm2
-endif
-image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
+#
+# Targets which embed a device tree blob
+#
+# Theses are default targets to build images which embed device tree blobs.
+# They are only required on boards which do not have FDT support in firmware.
+# Boards with newish u-boot firmare can use the uImage target above
+#
+
+# Board ports in arch/powerpc/platform/40x/Kconfig
+image-$(CONFIG_EP405)			+= zImage-dtb.ep405
+image-$(CONFIG_WALNUT)			+= treeImage.walnut
+
+# Board ports in arch/powerpc/platform/44x/Kconfig
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
 image-$(CONFIG_BAMBOO)			+= treeImage.bamboo cuImage.bamboo
 image-$(CONFIG_SEQUOIA)			+= cuImage.sequoia
 image-$(CONFIG_RAINIER)			+= cuImage.rainier
-image-$(CONFIG_WALNUT)			+= treeImage.walnut
 image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
 image-$(CONFIG_WARP)			+= cuImage.warp
-endif
 
-ifneq ($(CONFIG_REDBOOT),"")
-image-$(CONFIG_PPC_8xx)			+= zImage.redboot-8xx
-endif
+# Board ports in arch/powerpc/platform/8xx/Kconfig
+image-$(CONFIG_PPC_MPC86XADS)		+= cuImage.mpc866ads
+image-$(CONFIG_PPC_MPC885ADS)		+= zImage-dtb.mpc885ads
+image-$(CONFIG_PPC_EP88XC)		+= zImage-dtb.ep88xc
+image-$(CONFIG_PPC_ADDER875)		+= cuImage.adder875-uboot \
+					   zImage-dtb.adder875-redboot
+
+# Board ports in arch/powerpc/platform/52xx/Kconfig
+image-$(CONFIG_PPC_LITE5200)		+= cuImage.lite5200 cuImage.lite5200b
+
+# Board ports in arch/powerpc/platform/82xx/Kconfig
+image-$(CONFIG_MPC8272_ADS)		+= cuImage.mpc8272ads
+image-$(CONFIG_PQ2FADS)			+= cuImage.pq2fads
+image-$(CONFIG_EP8248E)			+= zImage-dtb.ep8248e
+
+# Board ports in arch/powerpc/platform/83xx/Kconfig
+image-$(CONFIG_MPC8313_RDB)		+= cuImage.mpc8313erdb
+image-$(CONFIG_MPC832x_MDS)		+= cuImage.mpc832x_mds
+image-$(CONFIG_MPC832x_RDB)		+= cuImage.mpc832x_rdb
+image-$(CONFIG_MPC834x_ITX)		+= cuImage.mpc8349emitx \
+					   cuImage.mpc8349emitxgp
+image-$(CONFIG_MPC834x_MDS)		+= cuImage.mpc834x_mds
+image-$(CONFIG_MPC836x_MDS)		+= cuImage.mpc836x_mds
+image-$(CONFIG_MPC837x_MDS)		+= cuImage.mpc8377_mds \
+					   cuImage.mpc8378_mds \
+					   cuImage.mpc8379_mds
+
+# Board ports in arch/powerpc/platform/85xx/Kconfig
+image-$(CONFIG_MPC8540_ADS)		+= cuImage.mpc8540ads
+image-$(CONFIG_MPC8560_ADS)		+= cuImage.mpc8560ads
+image-$(CONFIG_MPC85xx_CDS)		+= cuImage.mpc8541cds \
+					   cuImage.mpc8548cds \
+					   cuImage.mpc8555cds
+image-$(CONFIG_MPC85xx_MDS)		+= cuImage.mpc8568mds
+image-$(CONFIG_MPC85xx_DS)		+= cuImage.mpc8544ds \
+					   cuImage.mpc8572ds
+image-$(CONFIG_TQM8540)			+= cuImage.tqm8540
+image-$(CONFIG_TQM8541)			+= cuImage.tqm8541
+image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
+image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
+image-$(CONFIG_SBC8548)			+= cuImage.tqm8548
+image-$(CONFIG_SBC8560)			+= cuImage.tqm8560
+
+# Board ports in arch/powerpc/platform/embedded6xx/Kconfig
+image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
+image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
@@ -233,24 +276,20 @@ targets	+= $(image-y) $(initrd-y)
 
 $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 
-# If CONFIG_WANT_DEVICE_TREE is set and CONFIG_DEVICE_TREE isn't an
-# empty string, define 'dts' to be path to the dts
-# CONFIG_DEVICE_TREE will have "" around it, make sure to strip them
-ifeq ($(CONFIG_WANT_DEVICE_TREE),y)
-ifneq ($(CONFIG_DEVICE_TREE),"")
-dts = $(if $(shell echo $(CONFIG_DEVICE_TREE) | grep '^/'),\
-	,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE:"%"=%)
-endif
-endif
-
 # Don't put the ramdisk on the pattern rule; when its missing make will try
 # the pattern rule with less dependencies that also matches (even with the
 # hard dependency listed).
-$(obj)/zImage.initrd.%: vmlinux $(wrapperbits) $(dts)
-	$(call if_changed,wrap,$*,$(dts),,$(obj)/ramdisk.image.gz)
+$(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
-$(obj)/zImage.%: vmlinux $(wrapperbits) $(dts)
-	$(call if_changed,wrap,$*,$(dts))
+$(obj)/zImage.%: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$*)
+
+$(obj)/zImage-dtb.initrd.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
+	$(call if_changed,wrap,$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
+
+$(obj)/zImage-dtb.%: vmlinux $(wrapperbits) $(dtstree)/%.dts
+	$(call if_changed,wrap,$*,$(dtstree)/$*.dts)
 
 # This cannot be in the root of $(src) as the zImage rule always adds a $(obj)
 # prefix
@@ -260,24 +299,17 @@ $(obj)/vmlinux.strip: vmlinux
 $(obj)/zImage.iseries: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
 
-$(obj)/zImage.ps3: vmlinux  $(wrapper) $(wrapperbits) $(srctree)/$(src)/dts/ps3.dts
-	$(STRIP) -s -R .comment $< -o vmlinux.strip
-	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,)
-
-$(obj)/zImage.initrd.ps3: vmlinux  $(wrapper) $(wrapperbits) $(srctree)/$(src)/dts/ps3.dts $(obj)/ramdisk.image.gz
-	$(call cmd,wrap,ps3,$(srctree)/$(src)/dts/ps3.dts,,$(obj)/ramdisk.image.gz)
-
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
-$(obj)/cuImage.%: vmlinux $(dts) $(wrapperbits)
-	$(call if_changed,wrap,cuboot-$*,$(dts))
+$(obj)/cuImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
+	$(call if_changed,wrap,cuboot-$*,$(dtstree)/$*.dts)
 
-$(obj)/treeImage.initrd.%: vmlinux $(dts) $(wrapperbits)
-	$(call if_changed,wrap,treeboot-$*,$(dts),,$(obj)/ramdisk.image.gz)
+$(obj)/treeImage.initrd.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
+	$(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts,,$(obj)/ramdisk.image.gz)
 
-$(obj)/treeImage.%: vmlinux $(dts) $(wrapperbits)
-	$(call if_changed,wrap,treeboot-$*,$(dts))
+$(obj)/treeImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
+	$(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts)
 
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
diff --git a/arch/powerpc/boot/cuboot-hpc2.c b/arch/powerpc/boot/cuboot-mpc7448hpc2.c
similarity index 100%
rename from arch/powerpc/boot/cuboot-hpc2.c
rename to arch/powerpc/boot/cuboot-mpc7448hpc2.c
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 763a0c4..c317815 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -158,6 +158,29 @@ miboot|uboot)
 cuboot*)
     binary=y
     gzip=
+    case "$platform" in
+    *-mpc885ads|*-adder875*|*-ep88xc)
+        platformo=$object/cuboot-8xx.o
+        ;;
+    *5200*|*-motionpro)
+        platformo=$object/cuboot-52xx.o
+        ;;
+    *-pq2fads|*-ep8248e|*-mpc8272*|*-storcenter)
+        platformo=$object/cuboot-pq2.o
+        ;;
+    *-mpc824*)
+        platformo=$object/cuboot-824x.o
+        ;;
+    *-mpc83*)
+        platformo=$object/cuboot-83xx.o
+        ;;
+    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555*)
+        platformo=$object/cuboot-85xx-cpm2.o
+        ;;
+    *-mpc85*)
+        platformo=$object/cuboot-85xx.o
+        ;;
+    esac
     ;;
 ps3)
     platformo="$object/ps3-head.o $object/ps3-hvcall.o $object/ps3.o"
