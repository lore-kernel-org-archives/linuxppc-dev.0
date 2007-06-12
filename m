Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id CEC2CDDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:44:27 +1000 (EST)
Message-Id: <20070612163750.988227241@arndb.de>
References: <20070612163016.253915076@arndb.de>
Date: Tue, 12 Jun 2007 18:30:21 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 05/13] powerpc: multiplatformize embedded6xx configuration
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The existing embedded 6xx platforms will happily coexist
with each other in a single kernel if you let them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -12,10 +12,6 @@ config PPC_MULTIPLATFORM
 	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
 	  Maple or Cell-based machine.
 
-config EMBEDDED6xx
-	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
-
 config APUS
 	bool "Amiga-APUS"
 	depends on PPC32 && BROKEN
@@ -33,7 +29,6 @@ config CLASSIC32
 source "arch/powerpc/platforms/pseries/Kconfig"
 source "arch/powerpc/platforms/iseries/Kconfig"
 source "arch/powerpc/platforms/chrp/Kconfig"
-source "arch/powerpc/platforms/52xx/Kconfig"
 source "arch/powerpc/platforms/powermac/Kconfig"
 source "arch/powerpc/platforms/prep/Kconfig"
 source "arch/powerpc/platforms/maple/Kconfig"
@@ -42,6 +37,7 @@ source "arch/powerpc/platforms/celleb/Kc
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
@@ -1,9 +1,10 @@
-choice
-	prompt "Machine Type"
-	depends on EMBEDDED6xx
+config EMBEDDED6xx
+	bool "Embedded 6xx"
 
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
+	depends on EMBEDDED6xx
+	depends on (BROKEN || BROKEN_ON_SMP)
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
@@ -17,6 +18,8 @@ config LINKSTATION
 
 config MPC7448HPC2
 	bool "Freescale MPC7448HPC2(Taiga)"
+	depends on EMBEDDED6xx
+	depends on (BROKEN || BROKEN_ON_SMP)
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
@@ -26,6 +29,7 @@ config MPC7448HPC2
 
 config PPC_HOLLY
 	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
+	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
 	help
@@ -34,12 +38,12 @@ config PPC_HOLLY
 
 config PPC_PRPMC2800
 	bool "Motorola-PrPMC2800"
+	depends on EMBEDDED6xx
 	select MV64X60
 	select NOT_COHERENT_CACHE
 	select WANT_DEVICE_TREE
 	help
 	  This option enables support for the Motorola PrPMC2800 board
-endchoice
 
 config TSI108_BRIDGE
 	bool

--
