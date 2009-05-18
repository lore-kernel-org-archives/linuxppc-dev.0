Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 2C207DE086
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 09:21:26 +1000 (EST)
Date: Tue, 19 May 2009 01:21:13 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Subject: [PATCH v2] Allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090518232113.GA18469@iram.es>
References: <20090518173756.GA11805@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D323@az33exm24.fsl.freescale.net>
	<20090518184752.GA12972@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D3A5@az33exm24.fsl.freescale.net>
	<20090518221847.GA17348@iram.es>
	<598D5675D34BE349929AF5EDE9B03E2702C2D459@az33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2702C2D459@az33exm24.fsl.freescale.net>
Cc: netdev@vger.kernel.org, tbm@cyrius.com, LinuxPPC <linuxppc-dev@ozlabs.org>,
	pacman@kosh.dhis.org, David Miller <davem@davemloft.net>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since PPC_MUTIPLATFORM was removed, it was impossible to select the
driver for mv643xx_eth on the Pegasos. Fix it and take the opportunity
to remove the stale MV64360 config option.

Signed-off-by: Gabriel Paubert <paubert@iram.es>

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 214a92d..aff4f8c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2351,7 +2351,7 @@ config UGETH_TX_ON_DEMAND
 
 config MV643XX_ETH
 	tristate "Marvell Discovery (643XX) and Orion ethernet support"
-	depends on MV64360 || MV64X60 || (PPC_MULTIPLATFORM && PPC32) || PLAT_ORION
+	depends on MV64X60 || PPC32 || PLAT_ORION
 	select INET_LRO
 	select PHYLIB
 	help
