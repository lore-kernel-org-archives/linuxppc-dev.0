Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04181DDE2F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 09:16:20 +1000 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1Hc8WW-0002to-Oi
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 18:16:16 -0500
Date: Thu, 12 Apr 2007 18:12:23 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] Convert 85xx platform to unified platform Kconfig
In-Reply-To: <Pine.LNX.4.64.0704121806330.28324@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0704121811500.28324@localhost.localdomain>
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

Moved 85xx platform Kconfig over to being sourced by the unified
arch/powerpc/platforms/Kconfig.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                |    1 -
 arch/powerpc/platforms/85xx/Kconfig |   29 ++++-------------------------
 arch/powerpc/platforms/Kconfig      |    3 ++-
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 89e9c85..033666c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -377,7 +377,6 @@ source "arch/powerpc/platforms/Kconfig"

 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
-source arch/powerpc/platforms/85xx/Kconfig

 menu "Kernel options"

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 124e2c5..c79ae86 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -1,8 +1,6 @@
-menu "Platform support"
-	depends on PPC_85xx
-
 choice
 	prompt "Machine Type"
+	depends on PPC_85xx
 	default MPC8540_ADS

 config MPC8540_ADS
@@ -46,33 +44,14 @@ config MPC8540

 config MPC8560
 	bool
-	select PPC_INDIRECT_PCI
+	select CPM2
 	default y if MPC8560_ADS

 config MPC85xx
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select PPC_INDIRECT_PCI_BE
+	select MPIC
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
 		|| MPC85xx_MDS || MPC8544_DS
-
-config PPC_INDIRECT_PCI_BE
-	bool
-	depends on PPC_85xx
-	default y
-
-config MPIC
-	bool
-	default y
-
-config CPM2
-	bool
-	depends on MPC8560
-	default y
-	help
-	  The CPM2 (Communications Processor Module) is a coprocessor on
-	  embedded CPUs made by Motorola.  Selecting this option means that
-	  you wish to build a kernel for a machine with a CPM2 coprocessor
-	  on it.
-
-endmenu
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index eb69e72..e173fd4 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,6 +1,6 @@
 menu "Platform support"
 	depends on PPC64 || CLASSIC32 || PPC_8xx || PPC_82xx || PPC_83xx || \
-			PPC_86xx
+			PPC_85xx || PPC_86xx

 choice
 	prompt "Machine type"
@@ -49,6 +49,7 @@ source arch/powerpc/platforms/cell/Kconfig
 source "arch/powerpc/platforms/8xx/Kconfig"
 source "arch/powerpc/platforms/82xx/Kconfig"
 source "arch/powerpc/platforms/83xx/Kconfig"
+source "arch/powerpc/platforms/85xx/Kconfig"
 source "arch/powerpc/platforms/86xx/Kconfig"

 config PPC_NATIVE
-- 
1.5.0.6
