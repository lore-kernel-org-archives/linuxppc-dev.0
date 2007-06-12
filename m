Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 8545DDDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:44:30 +1000 (EST)
Message-Id: <20070612163750.563548670@arndb.de>
References: <20070612163016.253915076@arndb.de>
Date: Tue, 12 Jun 2007 18:30:18 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 02/13] powerpc: move 82xx/83xx/86xx Kconfig options to
	platform selection
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The cores used in the MPC82xx/83xx/86xx embedded controllers are very similar
to those in the 32 bit general-purpose processors, so it makes sense to
treat them as the same CPU family.

Choosing between the embedded platforms and the multiplatform code is
now done in the platform menu, but functionally everything stays the
same.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -2,7 +2,7 @@ menu "Platform support"
 
 choice
 	prompt "Machine type"
-	depends on PPC64 || CLASSIC32
+	depends on PPC64 || 6xx
 	default PPC_MULTIPLATFORM
 
 config PPC_MULTIPLATFORM
@@ -23,8 +23,32 @@ config APUS
 	  Select APUS if configuring for a PowerUP Amiga.
 	  More information is available at:
 	  <http://linux-apus.sourceforge.net/>.
+
+config PPC_82xx
+	bool "Freescale 82xx"
+	depends on 6xx
+
+config PPC_83xx
+	bool "Freescale 83xx"
+	depends on 6xx
+	select FSL_SOC
+	select 83xx
+	select WANT_DEVICE_TREE
+
+config PPC_86xx
+	bool "Freescale 86xx"
+	depends on 6xx
+	select FSL_SOC
+	select FSL_PCIE
+	select ALTIVEC
+	help
+	  The Freescale E600 SoCs have 74xx cores.
 endchoice
 
+config CLASSIC32
+	def_bool y
+	depends on 6xx && PPC_MULTIPLATFORM
+
 source "arch/powerpc/platforms/pseries/Kconfig"
 source "arch/powerpc/platforms/iseries/Kconfig"
 source "arch/powerpc/platforms/chrp/Kconfig"
Index: linux-2.6/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig.cputype
+++ linux-2.6/arch/powerpc/platforms/Kconfig.cputype
@@ -10,41 +10,20 @@ choice
 	prompt "Processor Type"
 	depends on PPC32
 	default 6xx
-
-config CLASSIC32
-	bool "52xx/6xx/7xx/74xx"
-	select PPC_FPU
-	select 6xx
 	help
-	  There are four families of PowerPC chips supported.  The more common
-	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
-	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
-	  embedded versions (403 and 405) and the high end 64 bit Power
-	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
-
-	  This option is the catch-all for 6xx types, including some of the
-	  embedded versions.  Unless there is see an option for the specific
-	  chip family you are using, you want this option.
-
-	  You do not want this if you are building a kernel for a 64 bit
-	  IBM RS/6000 or an Apple G5, choose 6xx.
-
-	  If unsure, select this option
-
-	  Note that the kernel runs in 32-bit mode even on 64-bit chips.
-
-config PPC_82xx
-	bool "Freescale 82xx"
-	select 6xx
-	select PPC_FPU
+	  There are five families of 32 bit PowerPC chips supported.
+	  The most common ones are the desktop and server CPUs (601, 603,
+	  604, 740, 750, 74xx) CPUs from Freescale and IBM, with their
+	  embedded 52xx/82xx/83xx/86xx counterparts.
+	  The other embeeded parts, namely 4xx, 8xx, e200 (55xx) and e500
+	  (85xx) each form a family of their own that is not compatible
+	  with the others.
 
-config PPC_83xx
-	bool "Freescale 83xx"
-	select 6xx
-	select FSL_SOC
-	select 83xx
+	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
+
+config 6xx
+	bool "52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
-	select WANT_DEVICE_TREE
 
 config PPC_85xx
 	bool "Freescale 85xx"
@@ -53,16 +32,6 @@ config PPC_85xx
 	select 85xx
 	select WANT_DEVICE_TREE
 
-config PPC_86xx
-	bool "Freescale 86xx"
-	select 6xx
-	select FSL_SOC
-	select FSL_PCIE
-	select PPC_FPU
-	select ALTIVEC
-	help
-	  The Freescale E600 SoCs have 74xx cores.
-
 config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC

--
