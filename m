Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 697F3DE2E0
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 04:18:26 +1000 (EST)
Date: Fri, 15 May 2009 20:18:13 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Matt Sealey <matt@genesi-usa.com>
Subject: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090515181813.GA28132@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LinuxPPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since PPC_MUTIPLATFORM was removed, it was impossible to select the
driver for mv643xx_eth on the Pegasos. Fix by allowing to select
the driver on CHRP platforms; Pegasos is a CHRP platform and the driver
will not work wihtout arch/powerpc/platforms/chrp/pegasos_eth.

The patch also removes all references to MV64360 config option which 
no more exists.

Signed-off-by: Gabriel Paubert <paubert@iram.es> 

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a0d1146..1dfeb62 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -360,7 +360,7 @@ config PPCBUG_NVRAM
 
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
-	depends on SMP && !MV64360
+	depends on SMP 
 	help
 	  This option gives the kernel permission to distribute IRQs across
 	  multiple CPUs.  Saying N here will route all IRQs to the first
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 214a92d..6fc0ff4 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2351,7 +2351,7 @@ config UGETH_TX_ON_DEMAND
 
 config MV643XX_ETH
 	tristate "Marvell Discovery (643XX) and Orion ethernet support"
-	depends on MV64360 || MV64X60 || (PPC_MULTIPLATFORM && PPC32) || PLAT_ORION
+	depends on MV64X60 || PPC_CHRP || PLAT_ORION
 	select INET_LRO
 	select PHYLIB
 	help
