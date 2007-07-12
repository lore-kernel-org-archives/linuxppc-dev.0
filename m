Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 402C6DE208
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:53:09 +1000 (EST)
Message-Id: <20070712210909.315449461@arndb.de>
References: <20070712210156.973038514@arndb.de>
Date: Thu, 12 Jul 2007 23:01:59 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 3/5] move embedded6xx into multiplatform
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The various embedded 6xx systems can easily coexist
in one kernel together with the other 6xx based systems,
so there is no strict reason to keep them separate.

This also fixes a problem introduced in one earlier
patch, where the embedded 74xx based systems could
not automatically select altivec any more.

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
 config PPC_82xx
 	bool "Freescale 82xx"
 	depends on 6xx
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -1,9 +1,10 @@
-choice
-	prompt "Machine Type"
-	depends on EMBEDDED6xx
+config EMBEDDED6xx
+	bool "Embedded 6xx/7xx/7xxx-based boards"
+	depends on PPC32 && (BROKEN||BROKEN_ON_SMP) && PPC_MULTIPLATFORM
 
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
+	depends on EMBEDDED6xx
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
@@ -18,6 +19,7 @@ config LINKSTATION
 
 config MPC7448HPC2
 	bool "Freescale MPC7448HPC2(Taiga)"
+	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
@@ -28,6 +30,7 @@ config MPC7448HPC2
 
 config PPC_HOLLY
 	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
+	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
 	select WANT_DEVICE_TREE
@@ -38,13 +41,13 @@ config PPC_HOLLY
 
 config PPC_PRPMC2800
 	bool "Motorola-PrPMC2800"
+	depends on EMBEDDED6xx
 	select MV64X60
 	select NOT_COHERENT_CACHE
 	select WANT_DEVICE_TREE
 	select CPU_7450
 	help
 	  This option enables support for the Motorola PrPMC2800 board
-endchoice
 
 config TSI108_BRIDGE
 	bool

--
