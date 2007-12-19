Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F4D0DDF3E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 03:43:59 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBJGhsWv029895
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 11:43:54 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBJGhsaV202366
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 09:43:54 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBJGhjDw011969
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 09:43:45 -0700
Received: from zod.rchland.ibm.com (wecm-9-67-132-88.wecm.ibm.com
	[9.67.132.88])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lBJGhisW011908
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 09:43:44 -0700
Date: Wed, 19 Dec 2007 10:38:26 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [PATCH 2/3] Rework arch specific Makefiles to use mkimage
Message-ID: <20071219103826.1b5c02a3@zod.rchland.ibm.com>
In-Reply-To: <20071219103351.6c4468f4@zod.rchland.ibm.com>
References: <20071219103351.6c4468f4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rework the architecture specific Makefiles to use the in-kernel version
of the mkimage tool.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/arm/boot/Makefile          |    4 ++--
 arch/avr32/boot/images/Makefile |    4 ++--
 arch/blackfin/boot/Makefile     |    4 ++--
 arch/powerpc/boot/Makefile      |    8 ++++++--
 arch/powerpc/boot/wrapper       |    2 +-
 arch/ppc/boot/images/Makefile   |    4 ++--
 arch/sh/boot/Makefile           |    4 ++--
 7 files changed, 17 insertions(+), 13 deletions(-)

--- linux-2.6.orig/arch/arm/boot/Makefile
+++ linux-2.6/arch/arm/boot/Makefile
@@ -11,7 +11,7 @@
 # Copyright (C) 1995-2002 Russell King
 #
 
-MKIMAGE         := $(srctree)/scripts/mkuboot.sh
+MKIMAGE         := $(srctree)/scripts/mkimage/mkimage
 
 ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
@@ -60,7 +60,7 @@ $(obj)/zImage:	$(obj)/compressed/vmlinux
 endif
 
 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T
kernel \
+      cmd_uimage = $(MKIMAGE) -A arm -O linux -T kernel \
 		   -C none -a $(ZRELADDR) -e $(ZRELADDR) \
 		   -n 'Linux-$(KERNELRELEASE)' -d $< $@
 
--- linux-2.6.orig/arch/avr32/boot/images/Makefile
+++ linux-2.6/arch/avr32/boot/images/Makefile
@@ -6,7 +6,7 @@
 # for more details.
 #
 
-MKIMAGE		:= $(srctree)/scripts/mkuboot.sh
+MKIMAGE		:= $(srctree)/scripts/mkimage/mkimage
 
 extra-y		:= vmlinux.bin vmlinux.gz
 
@@ -18,7 +18,7 @@ $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FO
 	$(call if_changed,gzip)
 
 quiet_cmd_uimage = UIMAGE $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A avr32 -O linux -T
kernel	\
+      cmd_uimage = $(MKIMAGE) -A avr32 -O linux -T kernel	\
 		-C gzip -a $(CONFIG_LOAD_ADDRESS) -e
$(CONFIG_ENTRY_ADDRESS)	\ -n 'Linux-$(KERNELRELEASE)' -d $< $@
 
--- linux-2.6.orig/arch/blackfin/boot/Makefile
+++ linux-2.6/arch/blackfin/boot/Makefile
@@ -6,13 +6,13 @@
 # for more details.
 #
 
-MKIMAGE := $(srctree)/scripts/mkuboot.sh
+MKIMAGE := $(srctree)/scripts/mkimage/mkimage
 
 targets := vmImage
 extra-y += vmlinux.bin vmlinux.gz
 
 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A $(ARCH) -O linux -T
kernel \
+      cmd_uimage = $(MKIMAGE) -A $(ARCH) -O linux -T kernel \
                    -C gzip -n 'Linux-$(KERNELRELEASE)' -a
$(CONFIG_BOOT_LOAD) \ -e $(shell $(NM) vmlinux | awk '$$NF ==
"__start" {print $$1}') \ -d $< $@
--- linux-2.6.orig/arch/ppc/boot/images/Makefile
+++ linux-2.6/arch/ppc/boot/images/Makefile
@@ -2,7 +2,7 @@
 # This dir holds all of the images for PPC machines.
 # Tom Rini	January 2001
 
-MKIMAGE		:= $(srctree)/scripts/mkuboot.sh
+MKIMAGE		:= $(srctree)/scripts/mkimage/mkimage
 
 extra-y		:= vmlinux.bin vmlinux.gz
 
@@ -19,7 +19,7 @@ $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FO
 	$(call if_changed,mygzip)
 
 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A ppc -O linux -T
kernel \
+      cmd_uimage = $(MKIMAGE) -A ppc -O linux -T kernel \
                -C gzip -a 00000000 -e 00000000 -n
'Linux-$(KERNELRELEASE)' \ -d $< $@
 
--- linux-2.6.orig/arch/sh/boot/Makefile
+++ linux-2.6/arch/sh/boot/Makefile
@@ -8,7 +8,7 @@
 # Copyright (C) 1999 Stuart Menefy
 #
 
-MKIMAGE := $(srctree)/scripts/mkuboot.sh
+MKIMAGE := $(srctree)/scripts/mkimage/mkimage
 
 #
 # Assign safe dummy values if these variables are not defined,
@@ -38,7 +38,7 @@ KERNEL_LOAD	:= $(shell /bin/bash -c 'pri
 			$(CONFIG_ZERO_PAGE_OFFSET)+0x1000]')
 
 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A sh -O linux -T kernel
\
+      cmd_uimage = $(MKIMAGE) -A sh -O linux -T kernel \
 		   -C none -a $(KERNEL_LOAD) -e $(KERNEL_LOAD) \
 		   -n 'Linux-$(KERNELRELEASE)' -d $< $@
 
--- linux-2.6.orig/arch/powerpc/boot/wrapper
+++ linux-2.6/arch/powerpc/boot/wrapper
@@ -259,7 +259,7 @@ coff)
     ;;
 cuboot*)
     gzip -f -9 "$ofile"
-    mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e "$entry" \
+    $objbin/mkimage -A ppc -O linux -T kernel -C gzip -a "$base" -e
"$entry" \ $uboot_version -d "$ofile".gz "$ofile"
     ;;
 treeboot*)
--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -123,7 +123,7 @@ extra-y		:= $(obj)/wrapper.a
$(obj-plat) $(obj)/zImage.lds $(obj)/zImage.coff.lds
$(obj)/zImage.ps3.lds 
 wrapper		:=$(srctree)/$(src)/wrapper
-wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff
mktree) \ +wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote
hack-coff mktree mkimage) \ $(wrapper) FORCE
 
 #############
@@ -197,6 +197,7 @@ dts = $(if $(shell echo $(CONFIG_DEVICE_
 endif
 endif
 
+
 # Don't put the ramdisk on the pattern rule; when its missing make
will try # the pattern rule with less dependencies that also matches
(even with the # hard dependency listed).
@@ -246,9 +247,12 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux
System.map "$(INSTALL_PATH)" $< 
+$(obj)/mkimage:
+	ln -s $(srctree)/scripts/mkimage/mkimage $(obj)/mkimage
+
 # anything not in $(targets)
 clean-files += $(image-) $(initrd-) zImage zImage.initrd cuImage.*
treeImage.* \
-	otheros.bld
+	otheros.bld mkimage
 
 # clean up files cached by wrapper
 clean-kernel := vmlinux.strip vmlinux.bin
