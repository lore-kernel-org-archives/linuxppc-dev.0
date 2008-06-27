Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F601DDDEF
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 02:36:42 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m5RGaagN010027
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 11:36:37 -0500
Date: Fri, 27 Jun 2008 11:36:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add 83xx and 86xx to 6xx Multiplatform
Message-ID: <Pine.LNX.4.64.0806271136240.20344@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There isn't any reason at this point that we can't build 83xx & 86xx support
in with the other 6xx based boards.  Twiddle the Kconfigs to allow this.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/83xx/Kconfig |   10 ++++++----
 arch/powerpc/platforms/86xx/Kconfig |   16 +++++++++++-----
 arch/powerpc/platforms/Kconfig      |   14 --------------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index fe75b2a..27d9bf8 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -1,10 +1,12 @@
-menuconfig MPC83xx
-	bool "83xx Board Type"
-	depends on PPC_83xx
+menuconfig PPC_83xx
+	bool "83xx-based boards"
+	depends on 6xx && PPC_MULTIPLATFORM
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select FSL_SOC
+	select IPIC

-if MPC83xx
+if PPC_83xx

 config MPC831x_RDB
 	bool "Freescale MPC831x RDB"
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 053f49a..80a81e0 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -1,7 +1,13 @@
-choice
-	prompt "86xx Board Type"
-	depends on PPC_86xx
-	default MPC8641_HPCN
+config PPC_86xx
+menuconfig PPC_86xx
+	bool "86xx-based boards"
+	depends on 6xx && PPC_MULTIPLATFORM
+	select FSL_SOC
+	select ALTIVEC
+	help
+	  The Freescale E600 SoCs have 74xx cores.
+
+if PPC_86xx

 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
@@ -24,7 +30,7 @@ config MPC8610_HPCD
 	help
 	  This option enables support for the MPC8610 HPCD board.

-endchoice
+endif

 config MPC8641
 	bool
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 87454c5..3e2b645 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -16,20 +16,6 @@ config PPC_82xx
 	bool "Freescale 82xx"
 	depends on 6xx

-config PPC_83xx
-	bool "Freescale 83xx"
-	depends on 6xx
-	select FSL_SOC
-	select MPC83xx
-	select IPIC
-
-config PPC_86xx
-	bool "Freescale 86xx"
-	depends on 6xx
-	select FSL_SOC
-	select ALTIVEC
-	help
-	  The Freescale E600 SoCs have 74xx cores.
 endchoice

 config CLASSIC32
-- 
1.5.5.1
