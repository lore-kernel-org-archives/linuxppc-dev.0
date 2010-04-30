Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8BC6FB6ED0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 06:30:59 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/mpc512x: Group mpc512x board's selection menu
Date: Fri, 30 Apr 2010 22:30:47 +0200
Message-Id: <1272659448-23302-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow board selection in a drop-down board sub-menu
like many other platforms do.

Before the patch:
...
[ ] Freescale MPC5121E ADS
[ ] Generic support for simple MPC5121 based boards
[ ] 52xx-based boards
...

Patched:
...
[*] 512x-based boards
[ ]   Freescale MPC5121E ADS
[ ]   Generic support for simple MPC5121 based boards
[ ] 52xx-based boards
...

This is a cleanup before adding new board selection entry.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/512x/Kconfig |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 4dac9b0..e9dca28 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -1,29 +1,24 @@
 config PPC_MPC512x
-	bool
+	bool "512x-based boards"
+	depends on 6xx
 	select FSL_SOC
 	select IPIC
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
 
-config PPC_MPC5121
-	bool
-	select PPC_MPC512x
-
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
-	depends on 6xx
+	depends on PPC_MPC512x
 	select DEFAULT_UIMAGE
-	select PPC_MPC5121
 	select MPC5121_ADS_CPLD
 	help
 	  This option enables support for the MPC5121E ADS board.
 
 config MPC5121_GENERIC
 	bool "Generic support for simple MPC5121 based boards"
-	depends on 6xx
+	depends on PPC_MPC512x
 	select DEFAULT_UIMAGE
-	select PPC_MPC5121
 	help
 	  This option enables support for simple MPC5121 based boards
 	  which do not need custom platform specific setup.
-- 
1.6.3.3
