Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id E1800DDE30
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:44:27 +1000 (EST)
Message-Id: <20070612163751.124207337@arndb.de>
References: <20070612163016.253915076@arndb.de>
Date: Tue, 12 Jun 2007 18:30:22 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 06/13] powerpc: multiplatformize 52xx configuration
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Efika and Lite5200 can both coexist with other 6xx compatible
configurations, so change the Kconfig allow selecting both
at the same time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/52xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/52xx/Kconfig
@@ -1,11 +1,26 @@
 config PPC_MPC52xx
-	bool
+	bool "Freescale 52xx"
 	select FSL_SOC
+
+config PPC_EFIKA
+	bool "bPlan Efika 5k2. MPC5200B based computer"
+	depends on PPC_MULTIPLATFORM && PPC32
+	depends on PPC_MPC52xx
+	select PPC_RTAS
+	select RTAS_PROC
+	select PPC_NATIVE
+	default n
+
+config PPC_LITE5200
+	bool "Freescale Lite5200 Eval Board"
+	depends on PPC_MULTIPLATFORM && PPC32
+	depends on PPC_MPC52xx
+	select PPC_MPC5200
 	default n
 
 config PPC_MPC5200
 	bool
-	select PPC_MPC52xx
+	depends on PPC_MPC52xx
 	default n
 
 config PPC_MPC5200_BUGFIX
@@ -18,19 +33,4 @@ config PPC_MPC5200_BUGFIX
 
 	  It is safe to say 'Y' here
 
-config PPC_EFIKA
-	bool "bPlan Efika 5k2. MPC5200B based computer"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_RTAS
-	select RTAS_PROC
-	select PPC_MPC52xx
-	select PPC_NATIVE
-	default n
-
-config PPC_LITE5200
-	bool "Freescale Lite5200 Eval Board"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_MPC5200
-	default n
-
 

--
