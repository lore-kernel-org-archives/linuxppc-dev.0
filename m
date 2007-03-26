Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id EFB28DDF19
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 06:52:35 +1000 (EST)
Date: Mon, 26 Mar 2007 15:52:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/5] bootwrapper: Add CONFIG_DEVICE_TREE
Message-ID: <20070326205226.GB2931@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070326205145.GA2868@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 20a8fdc..3b458e1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -590,6 +590,22 @@ config SECCOMP
 
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
-- 
1.5.0.3
