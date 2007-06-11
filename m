Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 712EDDDECE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:36:26 +1000 (EST)
Message-Id: <20070611233354.142076324@arndb.de>
References: <20070611232824.489103547@arndb.de>
Date: Tue, 12 Jun 2007 01:28:29 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 05/10] powerpc: Multiplatformize 8{2,3,6}xx configuration
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All platforms based on 6xx compatible cores should be able to
coexisting in a single kernel image and do all necessary configuration
based on the device tree.

This moves the missing 8{2,3,6}xx platforms under
CONFIG_PPC_MULTIPLATFORM to make that possible to configure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-2.6/arch/powerpc/platforms/82xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/82xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/82xx/Kconfig
@@ -1,10 +1,10 @@
-choice
-	prompt "Machine Type"
-	depends on PPC_82xx
-	default MPC82xx_ADS
+config PPC_82xx
+	bool "Freescale 82xx"
+	depends on PPC_MULTIPLATFORM && 6xx
 
 config MPC82xx_ADS
 	bool "Freescale MPC82xx ADS"
+	depends on PPC_82xx
 	select DEFAULT_UIMAGE
 	select PQ2ADS
 	select 8272
@@ -13,8 +13,6 @@ config MPC82xx_ADS
 	help
 	This option enables support for the MPC8272 ADS board
 
-endchoice
-
 config PQ2ADS
 	bool
 	default n
Index: linux-2.6/arch/powerpc/platforms/83xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/83xx/Kconfig
@@ -1,16 +1,20 @@
-choice
-	prompt "Machine Type"
-	depends on PPC_83xx
-	default MPC834x_MDS
+config PPC_83xx
+	bool "Freescale 83xx"
+	depends on PPC_MULTIPLATFORM && 6xx
+	select FSL_SOC
+	select 83xx
+	select WANT_DEVICE_TREE
 
 config MPC8313_RDB
 	bool "Freescale MPC8313 RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8313 RDB board.
 
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	help
@@ -18,6 +22,7 @@ config MPC832x_MDS
 
 config MPC832x_RDB
 	bool "Freescale MPC832x RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	help
@@ -25,6 +30,7 @@ config MPC832x_RDB
 
 config MPC834x_MDS
 	bool "Freescale MPC834x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC 834x MDS evaluation board.
@@ -36,6 +42,7 @@ config MPC834x_MDS
 
 config MPC834x_ITX
 	bool "Freescale MPC834x ITX"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC 834x ITX evaluation board.
@@ -45,13 +52,12 @@ config MPC834x_ITX
 
 config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
-endchoice
-
 config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
Index: linux-2.6/arch/powerpc/platforms/86xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/86xx/Kconfig
@@ -1,17 +1,20 @@
-choice
-	prompt "Machine Type"
-	depends on PPC_86xx
-	default MPC8641_HPCN
+config PPC_86xx
+	bool "Freescale 86xx"
+	depends on PPC_MULTIPLATFORM && 6xx
+	select FSL_SOC
+	select FSL_PCIE
+	select ALTIVEC
+	help
+	  The Freescale E600 SoCs have 74xx cores.
 
 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
+	depends on PPC_86xx
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
-endchoice
-
 config MPC8641
 	bool
 	select PPC_INDIRECT_PCI
Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -24,25 +24,6 @@ config APUS
 	  More information is available at:
 	  <http://linux-apus.sourceforge.net/>.
 
-config PPC_82xx
-	bool "Freescale 82xx"
-	depends on 6xx
-
-config PPC_83xx
-	bool "Freescale 83xx"
-	depends on 6xx
-	select FSL_SOC
-	select 83xx
-	select WANT_DEVICE_TREE
-
-config PPC_86xx
-	bool "Freescale 86xx"
-	depends on 6xx
-	select FSL_SOC
-	select FSL_PCIE
-	select ALTIVEC
-	help
-	  The Freescale E600 SoCs have 74xx cores.
 endchoice
 
 config CLASSIC32

--
