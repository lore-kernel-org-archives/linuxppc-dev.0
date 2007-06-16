Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 1FFD2DDFFC
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 10:09:15 +1000 (EST)
Message-Id: <20070616000619.225463944@arndb.de>
References: <20070616000511.712667424@arndb.de>
Date: Sat, 16 Jun 2007 02:05:20 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 9/9] enable multiplatform support for embedded boards
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes it possible to build kernels for any combination of
board types that can coexisting in the same binary. It is for
reference only right now, because there are still concerns
that it might make future optimizations harder to implement.

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/52xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/52xx/Kconfig
@@ -1,38 +1,35 @@
 config PPC_MPC52xx
-	bool
+	bool "Freescale 52xx"
 	select FSL_SOC
-	default n
-
-config PPC_MPC5200
-	bool
-	select PPC_MPC52xx
-	default n
-
-config PPC_MPC5200_BUGFIX
-	bool "MPC5200 (L25R) bugfix support"
-	depends on PPC_MPC5200
-	default n
-	help
-	  Enable workarounds for original MPC5200 errata.  This is not required
-	  for MPC5200B based boards.
-
-	  It is safe to say 'Y' here
+	depends on 6xx
 
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
-	depends on PPC_MULTIPLATFORM && PPC32
+	depends on PPC_MPC52xx
 	select PPC_RTAS
 	select RTAS_PROC
-	select PPC_MPC52xx
 	select PPC_NATIVE
 	select CPU_603e
 	default n
 
 config PPC_LITE5200
 	bool "Freescale Lite5200 Eval Board"
-	depends on PPC_MULTIPLATFORM && PPC32
+	depends on PPC_MPC52xx
 	select PPC_MPC5200
 	select CPU_603e
 	default n
 
+config PPC_MPC5200
+	bool
+	depends on PPC_MPC52xx
+	default n
+
+config PPC_MPC5200_BUGFIX
+	bool "MPC5200 (L25R) bugfix support"
+	depends on PPC_MPC5200
+	default n
+	help
+	  Enable workarounds for original MPC5200 errata.  This is not required
+	  for MPC5200B based boards.
 
+	  It is safe to say 'Y' here
Index: linux-2.6/arch/powerpc/platforms/82xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/82xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/82xx/Kconfig
@@ -1,21 +1,19 @@
-choice
-	prompt "82xx Board Type"
-	depends on PPC_82xx
-	default MPC82xx_ADS
+config PPC_82xx
+	bool "Freescale 82xx"
+	depends on PPC_MULTIPLATFORM && 6xx
+	select CPU_603e
 
 config MPC82xx_ADS
 	bool "Freescale MPC82xx ADS"
+	depends on PPC_82xx
 	select DEFAULT_UIMAGE
 	select PQ2ADS
 	select 8272
 	select 8260
 	select FSL_SOC
-	select CPU_603e
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
@@ -1,35 +1,38 @@
-choice
-	prompt "83xx Board Type"
-	depends on PPC_83xx
-	default MPC834x_MDS
+config PPC_83xx
+	bool "Freescale 83xx"
+	depends on PPC_MULTIPLATFORM && 6xx
+	select FSL_SOC
+	select 83xx
+	select WANT_DEVICE_TREE
+	select CPU_603e
 
 config MPC8313_RDB
 	bool "Freescale MPC8313 RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
-	select CPU_603e
 	help
 	  This option enables support for the MPC8313 RDB board.
 
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
-	select CPU_603e
 	help
 	  This option enables support for the MPC832x MDS evaluation board.
 
 config MPC832x_RDB
 	bool "Freescale MPC832x RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
-	select CPU_603e
 	help
 	  This option enables support for the MPC8323 RDB board.
 
 config MPC834x_MDS
 	bool "Freescale MPC834x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
-	select CPU_603e
 	help
 	  This option enables support for the MPC 834x MDS evaluation board.
 
@@ -40,8 +43,8 @@ config MPC834x_MDS
 
 config MPC834x_ITX
 	bool "Freescale MPC834x ITX"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
-	select CPU_603e
 	help
 	  This option enables support for the MPC 834x ITX evaluation board.
 
@@ -50,14 +53,12 @@ config MPC834x_ITX
 
 config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
-	select CPU_603e
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
-endchoice
-
 config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
Index: linux-2.6/arch/powerpc/platforms/85xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/85xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/85xx/Kconfig
@@ -1,28 +1,27 @@
-choice
-	prompt "Machine Type"
-	depends on PPC_85xx
-	default MPC8540_ADS
-
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC 8540 ADS board
 
 config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC 8560 ADS board
 
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC85xx CDS board
 
 config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 #	select QUICC_ENGINE
 	help
@@ -30,12 +29,11 @@ config MPC85xx_MDS
 
 config MPC8544_DS
 	bool "Freescale MPC8544 DS"
+	depends on PPC_85xx
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8544 DS board
 
-endchoice
-
 config MPC8540
 	bool
 	select PPC_UDBG_16550
Index: linux-2.6/arch/powerpc/platforms/86xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/86xx/Kconfig
@@ -1,18 +1,21 @@
-choice
-	prompt "86xx Board Type"
-	depends on PPC_86xx
-	default MPC8641_HPCN
+config PPC_86xx
+	bool "Freescale 86xx"
+	depends on PPC_MULTIPLATFORM && 6xx
+	select FSL_SOC
+	select FSL_PCIE
+	select ALTIVEC
+	select CPU_74xx
+	help
+	  The Freescale E600 SoCs have 74xx cores.
 
 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
+	depends on PPC_86xx
 	select PPC_I8259
 	select DEFAULT_UIMAGE
-	select CPU_74xx
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
@@ -1,50 +1,16 @@
 menu "Platform support"
 
-choice
-	prompt "Machine type"
-	depends on PPC64 || 6xx
-	default PPC_MULTIPLATFORM
-
 config PPC_MULTIPLATFORM
-	bool "Generic desktop/server/laptop"
-	help
-	  Select this option if configuring for an IBM pSeries or
-	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
-	  Maple or Cell-based machine.
-
-config EMBEDDED6xx
-	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
-
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
-endchoice
+	def_bool y
+	depends on 6xx || PPC64
 
 config CLASSIC32
 	def_bool y
-	depends on 6xx && PPC_MULTIPLATFORM
+	depends on 6xx
 
 source "arch/powerpc/platforms/pseries/Kconfig"
 source "arch/powerpc/platforms/iseries/Kconfig"
 source "arch/powerpc/platforms/chrp/Kconfig"
-source "arch/powerpc/platforms/52xx/Kconfig"
 source "arch/powerpc/platforms/powermac/Kconfig"
 source "arch/powerpc/platforms/prep/Kconfig"
 source "arch/powerpc/platforms/maple/Kconfig"
@@ -53,6 +19,7 @@ source "arch/powerpc/platforms/celleb/Kc
 source "arch/powerpc/platforms/ps3/Kconfig"
 source "arch/powerpc/platforms/cell/Kconfig"
 source "arch/powerpc/platforms/8xx/Kconfig"
+source "arch/powerpc/platforms/52xx/Kconfig"
 source "arch/powerpc/platforms/82xx/Kconfig"
 source "arch/powerpc/platforms/83xx/Kconfig"
 source "arch/powerpc/platforms/85xx/Kconfig"
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -1,9 +1,11 @@
-choice
-	prompt "Machine Type"
-	depends on EMBEDDED6xx
+config EMBEDDED6xx
+	bool "Embedded 6xx"
+	depends on 6xx
 
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
+	depends on EMBEDDED6xx
+	depends on (BROKEN || BROKEN_ON_SMP)
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
@@ -18,6 +20,8 @@ config LINKSTATION
 
 config MPC7448HPC2
 	bool "Freescale MPC7448HPC2(Taiga)"
+	depends on EMBEDDED6xx
+	depends on (BROKEN || BROKEN_ON_SMP)
 	select PCI
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
@@ -29,6 +33,7 @@ config MPC7448HPC2
 
 config PPC_HOLLY
 	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
+	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
 	select CPU_7xx
@@ -39,13 +44,13 @@ config PPC_HOLLY
 
 config PPC_PRPMC2800
 	bool "Motorola-PrPMC2800"
+	depends on EMBEDDED6xx
 	select MV64X60
 	select NOT_COHERENT_CACHE
 	select WANT_DEVICE_TREE
 	select CPU_74xx
 	help
 	  This option enables support for the Motorola PrPMC2800 board
-endchoice
 
 config TSI108_BRIDGE
 	bool

--
