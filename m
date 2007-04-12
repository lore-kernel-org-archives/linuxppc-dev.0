Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E834DDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:15:42 +1000 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hc8Vu-0002l7-Af
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 18:15:38 -0500
Date: Thu, 12 Apr 2007 18:11:45 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] Convert 8xx platform to unified platform Kconfig
In-Reply-To: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0704121811180.28324@localhost.localdomain>
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

Moved 8xx platform Kconfig over to being sourced by the unified
arch/powerpc/platforms/Kconfig.  Also, cleaned up whitespace issues in 8xx
Kconfig.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig               |    1 -
 arch/powerpc/platforms/8xx/Kconfig |   67 ++++++++++++++++-------------------
 arch/powerpc/platforms/Kconfig     |    4 ++-
 3 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 659b41f..89e9c85 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -378,7 +378,6 @@ source "arch/powerpc/platforms/Kconfig"
 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
-source arch/powerpc/platforms/8xx/Kconfig

 menu "Kernel options"

diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index beea683..39bb8c5 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -1,6 +1,3 @@
-menu "Platform support"
-        depends on PPC_8xx
-
 config FADS
 	bool

@@ -9,6 +6,7 @@ config CPM1

 choice
 	prompt "8xx Machine Type"
+	depends on PPC_8xx
 	depends on 8xx
 	default MPC885ADS

@@ -36,38 +34,36 @@ config MPC885ADS
 endchoice

 menu "Freescale Ethernet driver platform-specific options"
-        depends on (FS_ENET && MPC885ADS)
-
-        config MPC8xx_SECOND_ETH
-        bool "Second Ethernet channel"
-        depends on MPC885ADS
-        default y
-        help
-          This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
-          The latter will use SCC1, for 885ADS you can select it below.
-
-        choice
-                prompt "Second Ethernet channel"
-                depends on MPC8xx_SECOND_ETH
-                default MPC8xx_SECOND_ETH_FEC2
-
-                config MPC8xx_SECOND_ETH_FEC2
-                bool "FEC2"
-                depends on MPC885ADS
-                help
-                  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2
-                  (often 2-nd UART) will not work if this is enabled.
-
-                config MPC8xx_SECOND_ETH_SCC3
-                bool "SCC3"
-                depends on MPC885ADS
-                help
-                  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC1
-                  (often 1-nd UART) will not work if this is enabled.
-
-        endchoice
+	depends on (FS_ENET && MPC885ADS)

-endmenu
+	config MPC8xx_SECOND_ETH
+	bool "Second Ethernet channel"
+	depends on MPC885ADS
+	default y
+	help
+	  This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
+	  The latter will use SCC1, for 885ADS you can select it below.
+
+	choice
+		prompt "Second Ethernet channel"
+		depends on MPC8xx_SECOND_ETH
+		default MPC8xx_SECOND_ETH_FEC2
+
+		config MPC8xx_SECOND_ETH_FEC2
+		bool "FEC2"
+		depends on MPC885ADS
+		help
+		  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2
+		  (often 2-nd UART) will not work if this is enabled.
+
+		config MPC8xx_SECOND_ETH_SCC3
+		bool "SCC3"
+		depends on MPC885ADS
+		help
+		  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC1
+		  (often 1-nd UART) will not work if this is enabled.
+
+	endchoice

 endmenu

@@ -98,7 +94,7 @@ config 8xx_CPU6
 	  require workarounds for Linux (and most other OSes to work).  If you
 	  get a BUG() very early in boot, this might fix the problem.  For
 	  more details read the document entitled "MPC860 Family Device Errata
-	  Reference" on Motorola's website.  This option also incurs a
+	  Reference" on Freescale's website.  This option also incurs a
 	  performance hit.

 	  If in doubt, say N here.
@@ -135,4 +131,3 @@ config UCODE_PATCH
 	depends on !NO_UCODE_PATCH

 endmenu
-
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index efa3a03..eb69e72 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,5 +1,6 @@
 menu "Platform support"
-	depends on PPC64 || CLASSIC32 || PPC_82xx || PPC_83xx || PPC_86xx
+	depends on PPC64 || CLASSIC32 || PPC_8xx || PPC_82xx || PPC_83xx || \
+			PPC_86xx

 choice
 	prompt "Machine type"
@@ -45,6 +46,7 @@ source "arch/powerpc/platforms/pasemi/Kconfig"
 source arch/powerpc/platforms/celleb/Kconfig
 source arch/powerpc/platforms/ps3/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
+source "arch/powerpc/platforms/8xx/Kconfig"
 source "arch/powerpc/platforms/82xx/Kconfig"
 source "arch/powerpc/platforms/83xx/Kconfig"
 source "arch/powerpc/platforms/86xx/Kconfig"
-- 
1.5.0.6
