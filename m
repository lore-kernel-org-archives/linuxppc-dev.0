Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E59C2DDE08
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 00:27:55 +1000 (EST)
Date: Thu, 2 Aug 2007 18:26:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: spi-devel-general@lists.sourceforge.net
Subject: [PATCH] [SPI][POWERPC] spi_mpc83xx: in "QE mode" spiclk is sysclk/2
Message-ID: <20070802142641.GA6309@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For MPC8349E input to SPIBRG is SYSCLK, but it's SYSCLK/2 for
MPC8323E (running in so-called "QE mode").

This fixes clocking issues I've noticed recently.

Probably someday mpc83xx_spi->sysclk should be renamed to
mpc83xx_spi->spiclk to be less confusing.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/spi/spi_mpc83xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 0c16a2b..55230f7 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -429,13 +429,17 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
 	mpc83xx_spi->bitbang.chipselect = mpc83xx_spi_chipselect;
 	mpc83xx_spi->bitbang.setup_transfer = mpc83xx_spi_setup_transfer;
 	mpc83xx_spi->bitbang.txrx_bufs = mpc83xx_spi_bufs;
-	mpc83xx_spi->sysclk = pdata->sysclk;
 	mpc83xx_spi->activate_cs = pdata->activate_cs;
 	mpc83xx_spi->deactivate_cs = pdata->deactivate_cs;
 	mpc83xx_spi->qe_mode = pdata->qe_mode;
 	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
 	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
 
+	if (mpc83xx_spi->qe_mode)
+		mpc83xx_spi->sysclk = pdata->sysclk / 2;
+	else
+		mpc83xx_spi->sysclk = pdata->sysclk;
+
 	mpc83xx_spi->rx_shift = 0;
 	mpc83xx_spi->tx_shift = 0;
 	if (mpc83xx_spi->qe_mode) {
-- 
1.5.0.6
