Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C4D8EDDEFC
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:33:41 +1000 (EST)
Date: Tue, 25 Sep 2007 18:35:31 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx: allow use on MPC85xx
Message-ID: <20070925143531.GG5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070925143126.GA30013@localhost.localdomain>
Cc: spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC85xx's QE SPI controller is almost the same comparing to MPC83xx.
Thus lets use that driver. Tested to work in loopback mode.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b915711..14f0d0d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -125,7 +125,7 @@ config SPI_MPC52xx_PSC
 
 config SPI_MPC83xx
 	tristate "Freescale MPC83xx SPI controller"
-	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
+	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This enables using the Freescale MPC83xx SPI controller in master
-- 
1.5.0.6
