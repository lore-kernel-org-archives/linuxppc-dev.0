Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A3C0DDE2B
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:15:01 +1000 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hc8VF-0002he-KA
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 18:14:57 -0500
Date: Thu, 12 Apr 2007 18:11:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/7] Convert 82xx platform to unified platform Kconfig
In-Reply-To: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0704121810310.28324@localhost.localdomain>
References: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved 82xx platform Kconfig over to being sourced by the unified
arch/powerpc/platforms/Kconfig.  Also, cleaned up whitespace issues in 82xx
Kconfig.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                |    1 -
 arch/powerpc/platforms/82xx/Kconfig |   50 ++++++++++------------------------
 arch/powerpc/platforms/Kconfig      |   12 +++++++-
 3 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8576ff3..659b41f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -377,7 +377,6 @@ source "arch/powerpc/platforms/Kconfig"

 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
-source arch/powerpc/platforms/82xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 4110716..de7fce9 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -1,56 +1,36 @@
-menu "Platform support"
-       depends on PPC_82xx
-
 choice
-       prompt "Machine Type"
-       default MPC82xx_ADS
+	prompt "Machine Type"
+	depends on PPC_82xx
+	default MPC82xx_ADS

 config MPC82xx_ADS
-       bool "Freescale MPC82xx ADS"
-       select DEFAULT_UIMAGE
-       select PQ2ADS
-       select 8272
-       select 8260
-       select CPM2
-       select FSL_SOC
-       help
-         This option enables support for the MPC8272 ADS board
+	bool "Freescale MPC82xx ADS"
+	select DEFAULT_UIMAGE
+	select PQ2ADS
+	select 8272
+	select 8260
+	select FSL_SOC
+	help
+	This option enables support for the MPC8272 ADS board

 endchoice

 config PQ2ADS
 	bool
-	depends on ADS8272
-	default y
-
-config ADS8272
-	bool
+	default n

 config 8260
-	bool "CPM2 Support" if WILLOW
+	bool
 	depends on 6xx
-	default y if PQ2FADS
+	select CPM2
 	help
-	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
+	  The MPC8260 is a typical embedded CPU made by Freescale.  Selecting
 	  this option means that you wish to build a kernel for a machine with
 	  an 8260 class CPU.

 config 8272
 	bool
-	depends on 6xx
-	default y if ADS8272
 	select 8260
 	help
 	  The MPC8272 CPM has a different internal dpram setup than other CPM2
 	  devices
-
-config CPM2
-	bool
-	depends on 8260 || MPC8560 || MPC8555
-	default y
-	help
-	  The CPM2 (Communications Processor Module) is a coprocessor on
-	  embedded CPUs made by Motorola.  Selecting this option means that
-	  you wish to build a kernel for a machine with a CPM2 coprocessor
-	  on it (826x, 827x, 8560).
-endmenu
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d686806..efa3a03 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,5 +1,5 @@
 menu "Platform support"
-	depends on PPC64 || CLASSIC32 || PPC_83xx || PPC_86xx
+	depends on PPC64 || CLASSIC32 || PPC_82xx || PPC_83xx || PPC_86xx

 choice
 	prompt "Machine type"
@@ -45,6 +45,7 @@ source "arch/powerpc/platforms/pasemi/Kconfig"
 source arch/powerpc/platforms/celleb/Kconfig
 source arch/powerpc/platforms/ps3/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
+source "arch/powerpc/platforms/82xx/Kconfig"
 source "arch/powerpc/platforms/83xx/Kconfig"
 source "arch/powerpc/platforms/86xx/Kconfig"

@@ -221,4 +222,13 @@ config TAU_AVERAGE

 	  If in doubt, say N here.

+config CPM2
+	bool
+	default n
+	help
+	  The CPM2 (Communications Processor Module) is a coprocessor on
+	  embedded CPUs made by Freescale.  Selecting this option means that
+	  you wish to build a kernel for a machine with a CPM2 coprocessor
+	  on it (826x, 827x, 8560).
+
 endmenu
-- 
1.5.0.6
