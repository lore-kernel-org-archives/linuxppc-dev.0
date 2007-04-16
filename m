Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E45E0DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 09:25:04 +1000 (EST)
Date: Mon, 16 Apr 2007 18:24:51 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 1/4] bootwrapper: Add CONFIG_DEVICE_TREE
Message-ID: <20070416232451.GA26667@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This provides a way to tell the bootwrapper makefile which device tree to
include by default.  The wrapper can still be invoked standalone to wrap
with a different device tree without reconfiguring the kernel, if that is
desired.

The user will only be asked to provide a device tree if the platform
selects CONFIG_WANT_DEVICE_TREE.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Note that Kumar has said he's in favor of always asking (at least when
not on true OF) so that the dts name can be used from external build
scripts.  I'm not convinced that that's a good idea (after all, such
scripts will need other parameters (e.g. the u-boot target name) which
definitely should not go in the kernel .config); however, I don't care
all that much whether you pull this patch or the previous version (which
asked unconditionally).

 arch/powerpc/Kconfig |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 740892a..9fe636d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -162,6 +162,7 @@ config PPC_83xx
 	select FSL_SOC
 	select 83xx
 	select PPC_FPU
+	select WANT_DEVICE_TREE
 
 config PPC_85xx
 	bool "Freescale 85xx"
@@ -591,6 +592,29 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config WANT_DEVICE_TREE
+	bool
+	default n
+
+config DEVICE_TREE
+	string "Static device tree source file"
+	depends on WANT_DEVICE_TREE
+	help
+	  This specifies the device tree source (.dts) file to be
+	  compiled and included when building the bootwrapper.  If a
+	  relative filename is given, then it will be relative to
+	  arch/powerpc/boot/dts.  If you are not using the bootwrapper,
+	  or do not need to build a dts into the bootwrapper, this
+	  field is ignored.
+
+	  For example, this is required when building a cuImage target
+	  for an older U-Boot, which cannot pass a device tree itself.
+	  Such a kernel will not work with a newer U-Boot that tries to
+	  pass a device tree (unless you tell it not to).  If your U-Boot
+	  does not mention a device tree in "help bootm", then use the
+	  cuImage target and specify a device tree here.  Otherwise, use
+	  the uImage target and leave this field blank.
+
 endmenu
 
 config ISA_DMA_API
-- 
1.5.0.3
