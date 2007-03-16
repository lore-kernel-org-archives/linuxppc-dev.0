Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 06AC8DE810
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:29:16 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2GHTDGF025633
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:29:13 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHTCSa019462
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:13 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH9V86001460
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:31 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 05A8BAEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:29:12 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHTBHi029857
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:29:11 -0500
Date: Fri, 16 Mar 2007 12:29:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/17] bootwrapper: Add cmd_wrap_dt.
Message-ID: <20070316172911.GO29784@ld0162-tx32.am.freescale.net>
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

This provides a function to call the wrapper script with a device tree
source file, as specified by CONFIG_DEVICE_TREE.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig       |   16 ++++++++++++++++
 arch/powerpc/boot/Makefile |    6 ++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e720527..2f8f05b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -967,6 +967,22 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config DEVICE_TREE
+	string "Static device tree source file"
+	help
+	  This specifies the device tree source (.dts) file to be
+	  compiled and included when building the bootwrapper.
+	  If a relative filename is given, then it will be relative
+	  to arch/powerpc/boot/dts.
+
+	  This is required when building a cuImage target for an
+	  older U-Boot, which cannot pass a device tree itself.
+	  Such a kernel will not work with a newer U-Boot that
+	  tries to pass a device tree (unless you tell it not to).
+	  If your U-Boot does not mention a device tree in
+	  "help bootm", then use the cuImage target and specify
+	  a device tree here.  Otherwise, use the uImage target.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 55da383..1cdabb2 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -120,6 +120,12 @@ quiet_cmd_wrap_initrd = WRAP    $@
       cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
 
+dts = $(if $(shell echo $(CONFIG_) | grep '^/'),\
+       ,$(srctree)/$(src)/dts/)$(CONFIG_DEVICE_TREE)
+quiet_cmd_wrap_dt = WRAP    $@
+      cmd_wrap_dt = $(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+                    -s "$(dts)" vmlinux
+
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
 	$(call cmd,wrap,chrp)
 
-- 
1.5.0.3
