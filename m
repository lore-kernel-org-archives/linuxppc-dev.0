Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id EE8B4DE092
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:49:33 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2MJnTsT008103
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:49:30 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2MJnTio025157
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:29 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2MJTXBK004522
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:29:33 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 560A9AEFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 14:49:28 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2MJnS5G031997
	for linuxppc-dev@ozlabs.org; Thu, 22 Mar 2007 14:49:28 -0500
Date: Thu, 22 Mar 2007 14:49:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6] bootwrapper: Add a cuImage target.
Message-ID: <20070322194928.GE31965@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322194627.GA31926@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cuImage target calls the wrapper with a cuboot platform chosen
based on the kernel config, as opposed to the uboot platform.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Makefile        |    2 +-
 arch/powerpc/boot/.gitignore |    3 +++
 arch/powerpc/boot/Makefile   |   13 +++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

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
index 43179b4..93c25f8 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -43,7 +43,8 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c $(zlib) devtree.c
-src-plat := of.c
+cuboot-plats :=
+src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -129,7 +130,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
-image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
@@ -162,6 +163,14 @@ $(obj)/zImage.initrd.ps3: vmlinux
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
-- 
1.5.0.3
