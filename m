Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57BDADE1C9
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:14:31 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	avorontsov@ru.mvista.com
Subject: [PATCH v2] powerpc: make Freescale QE support a selectable Kconfig
	option
Date: Fri,  3 Oct 2008 11:14:10 -0500
Message-Id: <1223050450-32234-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Modify the Kconfig so that Freescale QUICC Engine (QE) support is a selectable
option, thereby allowing users to compile kernels without any QE support.

The drawback is that QE support is now disabled by default on platforms that
have a QE, and so a defconfig is needed to enable QE and QE devices (like
UCC GETH).  Fortunately, all the current relevant defconfigs do that already.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch should be applied to Kumar's branch for 2.6.28 patches.

 arch/powerpc/platforms/83xx/Kconfig |    5 -----
 arch/powerpc/platforms/85xx/Kconfig |    1 -
 arch/powerpc/platforms/Kconfig      |    3 ++-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 6159c5d..83c664a 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -19,7 +19,6 @@ config MPC831x_RDB
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	select PPC_MPC832x
 	help
 	  This option enables support for the MPC832x MDS evaluation board.
@@ -27,7 +26,6 @@ config MPC832x_MDS
 config MPC832x_RDB
 	bool "Freescale MPC832x RDB"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	select PPC_MPC832x
 	help
 	  This option enables support for the MPC8323 RDB board.
@@ -57,15 +55,12 @@ config MPC834x_ITX
 config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
 config MPC836x_RDK
 	bool "Freescale/Logic MPC836x RDK"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
-	select QE_GPIO
 	select FSL_GTM
 	select FSL_LBC
 	help
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 291675b..b79dc71 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -33,7 +33,6 @@ config MPC85xx_CDS
 config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
-	select QUICC_ENGINE
 	select PHYLIB
 	help
 	  This option enables support for the MPC85xx MDS board
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 9578c45..6cf517f 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -239,7 +239,8 @@ config TAU_AVERAGE
 	  If in doubt, say N here.
 
 config QUICC_ENGINE
-	bool
+	bool "Freescale QUICC Engine (QE) Support"
+	depends on FSL_SOC
 	select PPC_LIB_RHEAP
 	select CRC32
 	help
-- 
1.5.5
