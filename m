Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E1F5DDE81F
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:29:17 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2GHTEIT004500
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:29:15 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHTEYe028188
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:14 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9WSO001467
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:32 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 4EF8AAEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:13 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHTDrj029861
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:29:13 -0500
Date: Fri, 16 Mar 2007 12:29:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/17] bootwrapper: Add a cuImage target.
Message-ID: <20070316172913.GP29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/boot/Makefile   |   10 ++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

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
index 1cdabb2..a51fe08 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -43,7 +43,8 @@ $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) \
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c devtree.c $(zlib)
-src-plat := of.c
+cuboot-plats :=
+src-plat := of.c $(cuboot-plats:%=cuboot-%.c)
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -165,6 +166,11 @@ $(obj)/zImage.initrd.ps3: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
+cuboot-plat-y += unknown-platform
+
+$(obj)/cuImage: vmlinux $(wrapperbits)
+	$(call cmd,wrap_dt,cuboot-$(word 1,$(cuboot-plat-y)))
+
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
@@ -173,7 +179,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
-image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage cuImage
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
-- 
1.5.0.3
