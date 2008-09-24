Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9DC09DDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 14:38:49 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Move 8xxx GPIO Kconfig under the platform menu
Date: Tue, 23 Sep 2008 23:38:45 -0500
Message-Id: <1222231125-24632-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The initial patch had the option at the top level which wasn't
quite right.  Moving under the platform options is a bit better.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/Kconfig |    9 +++++++++
 arch/powerpc/sysdev/Kconfig    |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 4c900ef..9578c45 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -293,4 +293,13 @@ config OF_RTC
 
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
+config MPC8xxx_GPIO
+	bool "MPC8xxx GPIO support"
+	depends on PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || PPC_85xx || PPC_86xx
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  MPC831x/834x/837x/8572/8610 GPIOs.
+
 endmenu
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index d0e7bb0..3965828 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -7,15 +7,6 @@ config PPC4xx_PCI_EXPRESS
 	depends on PCI && 4xx
 	default n
 
-config MPC8xxx_GPIO
-	bool "MPC8xxx GPIO support"
-	depends on PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || PPC_85xx || PPC_86xx
-	select GENERIC_GPIO
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Say Y here if you're going to use hardware that connects to the
-	  MPC831x/834x/837x/8572/8610 GPIOs.
-
 config PPC_MSI_BITMAP
 	bool
 	depends on PCI_MSI
-- 
1.5.5.1
