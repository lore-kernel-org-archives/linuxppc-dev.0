Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4E975DDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 09:36:26 +1000 (EST)
Message-Id: <20070611233353.868146215@arndb.de>
References: <20070611232824.489103547@arndb.de>
Date: Tue, 12 Jun 2007 01:28:27 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 03/10] powerpc: move 82xx/83xx/86xx Kconfig options to
	platform selection
Cc: linuxppc-dev@ozlabs.org
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
@@ -15,24 +15,10 @@ config PPC64
 	bool "any 64 bit PowerPC"
 	select PPC_FPU
 
-config CLASSIC32
-	bool "52xx/6xx/7xx/74xx"
-	select PPC_FPU
-	select 6xx
-
-config PPC_82xx
-	bool "Freescale 82xx"
-	select 6xx
+config 6xx
+	bool "52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 
-config PPC_83xx
-	bool "Freescale 83xx"
-	select 6xx
-	select FSL_SOC
-	select 83xx
-	select PPC_FPU
-	select WANT_DEVICE_TREE
-
 config PPC_85xx
 	bool "Freescale 85xx"
 	select E500
@@ -40,16 +26,6 @@ config PPC_85xx
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
