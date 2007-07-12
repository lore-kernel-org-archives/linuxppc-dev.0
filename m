Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id CEB75DE201
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:53:08 +1000 (EST)
Message-Id: <20070712210909.607171957@arndb.de>
References: <20070712210156.973038514@arndb.de>
Date: Thu, 12 Jul 2007 23:02:01 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 5/5] move 83xx into multiplatform
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC83xx based machines don't need their own kernel,
but can run one that is shared with the other 6xx
compatible machines, so we should allow that
in Kconfig.

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Index: linux-2.6/arch/powerpc/platforms/83xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/83xx/Kconfig
@@ -1,10 +1,13 @@
-choice
-	prompt "83xx Board Type"
-	depends on PPC_83xx
-	default MPC834x_MDS
+config PPC_83xx
+	bool "Freescale 83xx based boards"
+	depends on 6xx
+	select FSL_SOC
+	select 83xx
+	select WANT_DEVICE_TREE
 
 config MPC8313_RDB
 	bool "Freescale MPC8313 RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select CPU_603e
 	help
@@ -12,6 +15,7 @@ config MPC8313_RDB
 
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	select CPU_603e
@@ -20,6 +24,7 @@ config MPC832x_MDS
 
 config MPC832x_RDB
 	bool "Freescale MPC832x RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	select CPU_603e
@@ -28,6 +33,7 @@ config MPC832x_RDB
 
 config MPC834x_MDS
 	bool "Freescale MPC834x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select CPU_603e
 	help
@@ -40,6 +46,7 @@ config MPC834x_MDS
 
 config MPC834x_ITX
 	bool "Freescale MPC834x ITX"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select CPU_603e
 	help
@@ -50,14 +57,13 @@ config MPC834x_ITX
 
 config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	select CPU_603e
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
-endchoice
-
 config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -16,13 +16,6 @@ config PPC_82xx
 	bool "Freescale 82xx"
 	depends on 6xx
 
-config PPC_83xx
-	bool "Freescale 83xx"
-	depends on 6xx
-	select FSL_SOC
-	select 83xx
-	select WANT_DEVICE_TREE
-
 endchoice
 
 config CLASSIC32

--
