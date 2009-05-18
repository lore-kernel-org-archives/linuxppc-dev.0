Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 2AE82DE077
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 03:38:09 +1000 (EST)
Date: Mon, 18 May 2009 19:37:56 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090518173756.GA11805@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tbm@cyrius.com, LinuxPPC <linuxppc-dev@ozlabs.org>, pacman@kosh.dhis.org,
	netdev@vger.kernel.org, David Miller <davem@davemloft.net>
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
will not work without arch/powerpc/platforms/chrp/pegasos_eth.

Signed-off-by: Gabriel Paubert <paubert@iram.es> 

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
