Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 8FC47DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 05:23:37 +1100 (EST)
Received: from pd2mr2so.prod.shaw.ca
	(pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JV20011W5Q52940@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 22 Jan 2008 11:22:53 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JV200MV15Q3XYJ7@pd2mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 22 Jan 2008 11:22:53 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JV200H5S5Q2RV30@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 22 Jan 2008 11:22:51 -0700 (MST)
Date: Tue, 22 Jan 2008 11:22:22 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc52xx: clean up Kconfig
To: linuxppc-dev@ozlabs.org
Message-id: <20080122182222.7748.46082.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Put all the mpc5200 board config option behind a menu item to get them
out of the top level of the platform support list

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/Kconfig |   41 +++++++++++++----------------------
 1 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/Kconfig b/arch/powerpc/platforms/52xx/Kconfig
index 733a806..515f244 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,31 +1,14 @@
 config PPC_MPC52xx
-	bool
+	bool "52xx-based boards"
+	depends on PPC_MULTIPLATFORM && PPC32
 	select FSL_SOC
 	select PPC_CLOCK
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
 
 config PPC_MPC5200_SIMPLE
 	bool "Generic support for simple MPC5200 based boards"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_MPC5200
+	depends on PPC_MPC52xx
 	select DEFAULT_UIMAGE
 	select WANT_DEVICE_TREE
-	default n
 	help
 	  This option enables support for a simple MPC52xx based boards which
 	  do not need a custom platform specific setup. Such boards are
@@ -43,17 +26,23 @@ config PPC_MPC5200_SIMPLE
 
 config PPC_EFIKA
 	bool "bPlan Efika 5k2. MPC5200B based computer"
-	depends on PPC_MULTIPLATFORM && PPC32
+	depends on PPC_MPC52xx
 	select PPC_RTAS
 	select RTAS_PROC
-	select PPC_MPC52xx
 	select PPC_NATIVE
-	default n
 
 config PPC_LITE5200
 	bool "Freescale Lite5200 Eval Board"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_MPC5200
+	depends on PPC_MPC52xx
 	select DEFAULT_UIMAGE
 	select WANT_DEVICE_TREE
-	default n
+
+config PPC_MPC5200_BUGFIX
+	bool "MPC5200 (L25R) bugfix support"
+	depends on PPC_MPC52xx
+	help
+	  Enable workarounds for original MPC5200 errata.  This is not required
+	  for MPC5200B based boards.
+
+	  It is safe to say 'Y' here
+
