Return-Path: <b04825@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2C1D7DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:40:36 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] powerpc: automatically select QE options
Date: Mon, 12 Mar 2007 15:40:27 -0500
Message-Id: <1173732027723-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the Kconfig files so that the Freescale QE options are automatically
selected if a QE device is selected.  Previously, you'd need to manually
select UCC_FAST if you want any "fast" UCC devices, such as Gigabit Ethernet.
Now, the QE Gigabit Ethernet option is always available if the device has a
QE, and UCC_FAST is automatically enabled.  A side-effect is that the
"QE Options" menu no longer exists.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/Kconfig               |    2 --
 arch/powerpc/sysdev/qe_lib/Kconfig |   10 ++--------
 drivers/net/Kconfig                |    9 +++++----
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6dfbd52..54dd66c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -396,8 +396,6 @@ endchoice
 
 config QUICC_ENGINE
 	bool
-	depends on PPC_MPC836x || PPC_MPC832x
-	default y
 	help
 	  The QUICC Engine (QE) is a new generation of communications
 	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index a725e80..887739f 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -2,11 +2,8 @@
 # QE Communication options
 #
 
-menu "QE Options"
-	depends on QUICC_ENGINE
-
 config UCC_SLOW
-	bool "UCC Slow Protocols Support"
+	bool
 	default n
 	select UCC
 	help
@@ -14,10 +11,9 @@ config UCC_SLOW
 	  protocols: UART, BISYNC, QMC
 
 config UCC_FAST
-	bool "UCC Fast Protocols Support"
+	bool
 	default n
 	select UCC
-	select UCC_SLOW
 	help
 	  This option provides qe_lib support to UCC fast
 	  protocols: HDLC, Ethernet, ATM, transparent
@@ -26,5 +22,3 @@ config UCC
 	bool
 	default y if UCC_FAST || UCC_SLOW
 
-endmenu
-
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d9400ef..b92a4e6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2272,11 +2272,12 @@ config GFAR_NAPI
 	depends on GIANFAR
 
 config UCC_GETH
-	tristate "Freescale QE UCC GETH"
-	depends on QUICC_ENGINE && UCC_FAST
+	tristate "Freescale QE Gigabit Ethernet"
+	depends on QUICC_ENGINE
+	select UCC_FAST
 	help
-	  This driver supports the Gigabit Ethernet mode of QE UCC.
-	  QE can be found on MPC836x CPUs.
+	  This driver supports the Gigabit Ethernet mode of the QUICC Engine,
+	  which is available on some Freescale SOCs.
 
 config UGETH_NAPI
 	bool "NAPI Support"
-- 
1.5.0.2.260.g2eb065
