Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 6C539DDEC7
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:44:31 +1000 (EST)
Message-Id: <20070612163751.413256993@arndb.de>
References: <20070612163016.253915076@arndb.de>
Date: Tue, 12 Jun 2007 18:30:24 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 08/13] powerpc: autoselect PPC_MULTIPLATFORM
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The multiplatform option has become pointless since all
platforms types are multiplatform by definition.
Keep the symbol around in case some code still uses it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -1,30 +1,12 @@
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
-config APUS
-	bool "Amiga-APUS"
-	depends on PPC32 && BROKEN
-	help
-	  Select APUS if configuring for a PowerUP Amiga.
-	  More information is available at:
-	  <http://linux-apus.sourceforge.net/>.
-
-endchoice
+	def_bool y
+	depends on 6xx || PPC64
 
 config CLASSIC32
 	def_bool y
-	depends on 6xx && PPC_MULTIPLATFORM
+	depends on 6xx
 
 source "arch/powerpc/platforms/pseries/Kconfig"
 source "arch/powerpc/platforms/iseries/Kconfig"
@@ -43,6 +25,7 @@ source "arch/powerpc/platforms/83xx/Kcon
 source "arch/powerpc/platforms/85xx/Kconfig"
 source "arch/powerpc/platforms/86xx/Kconfig"
 source "arch/powerpc/platforms/embedded6xx/Kconfig"
+source "arch/powerpc/platforms/apus/Kconfig"
 source "arch/powerpc/platforms/44x/Kconfig"
 #source "arch/powerpc/platforms/4xx/Kconfig
 
Index: linux-2.6/arch/powerpc/platforms/apus/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/apus/Kconfig
+++ linux-2.6/arch/powerpc/platforms/apus/Kconfig
@@ -1,3 +1,12 @@
+config APUS
+	bool "Amiga-APUS"
+	depends on PPC32 && BROKEN
+	help
+	  Select APUS if configuring for a PowerUP Amiga.
+	  More information is available at:
+	  <http://linux-apus.sourceforge.net/>.
+
+if APUS
 
 config AMIGA
 	bool
@@ -128,3 +137,5 @@ source "drivers/zorro/Kconfig"
 config PCI_PERMEDIA
 	bool "PCI for Permedia2"
 	depends on !4xx && !8xx && APUS
+
+endif

--
