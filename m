Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06F13DDEDC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 15:31:26 +1000 (EST)
Date: Tue, 1 Jul 2008 00:31:21 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][RESEND] powerpc: Add 82xx/83xx/86xx to 6xx Multiplatform
Message-ID: <Pine.LNX.4.64.0807010030240.23830@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There isn't any reason at this point that we can't build 82xx, 83xx & 86xx
support in with the other 6xx based boards.  Twiddle the Kconfigs to allow
this.

This allows us to remove the machine type selection for related to 6xx.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Rebased against latest powerpc-next tree.

- k

 arch/powerpc/platforms/82xx/Kconfig |   11 ++++++-----
 arch/powerpc/platforms/83xx/Kconfig |   10 ++++++----
 arch/powerpc/platforms/86xx/Kconfig |   16 +++++++++++-----
 arch/powerpc/platforms/Kconfig      |   33 +++------------------------------
 4 files changed, 26 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 917ac88..1c8034b 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -1,7 +1,8 @@
-choice
-	prompt "82xx Board Type"
-	depends on PPC_82xx
-	default MPC8272_ADS
+menuconfig PPC_82xx
+	bool "82xx-based boards (PQ II)"
+	depends on 6xx && PPC_MULTIPLATFORM
+
+if PPC_82xx

 config MPC8272_ADS
 	bool "Freescale MPC8272 ADS"
@@ -36,7 +37,7 @@ config EP8248E
 	  This board is also resold by Freescale as the QUICCStart
 	  MPC8248 Evaluation System and/or the CWH-PPC-8248N-VE.

-endchoice
+endif

 config PQ2ADS
 	bool
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
index 87454c5..690c1f4 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,36 +1,9 @@
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
-config PPC_82xx
-	bool "Freescale 82xx"
-	depends on 6xx
-
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
-endchoice
+	bool
+	depends on PPC64 || 6xx
+	default y

 config CLASSIC32
 	def_bool y
-- 
1.5.5.1
