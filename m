Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 89C0ADE118
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:35:53 +1100 (EST)
Date: Wed, 19 Dec 2007 23:38:05 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/4] [POWERPC][SPI] use brg-frequency for SPI in QE
Message-ID: <20071219203805.GC20861@localhost.localdomain>
References: <20071219203447.GA18285@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071219203447.GA18285@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In case of QE we can use brg-frequency (which is qeclk/2).
Thus no need to divide sysclk in the spi_mpc83xx.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   18 +++++++++++-------
 drivers/spi/spi_mpc83xx.c     |    6 +-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 044dd7f..3cf84d0 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1227,15 +1227,19 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 
 	/* SPI controller is either clocked from QE or SoC clock */
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!np)
+	if (np) {
+		sysclk = of_get_property(np, "brg-frequency", NULL);
+		if (!sysclk)
+			return -ENODEV;
+	} else {
 		np = of_find_node_by_type(NULL, "soc");
+		if (!np)
+			return -ENODEV;
 
-	if (!np)
-		return -ENODEV;
-
-	sysclk = of_get_property(np, "bus-frequency", NULL);
-	if (!sysclk)
-		return -ENODEV;
+		sysclk = of_get_property(np, "bus-frequency", NULL);
+		if (!sysclk)
+			return -ENODEV;
+	}
 
 	for (np = NULL, i = 1;
 	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 4580b9c..04f7cd9 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -436,11 +436,7 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
 	mpc83xx_spi->qe_mode = pdata->qe_mode;
 	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
 	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
-
-	if (mpc83xx_spi->qe_mode)
-		mpc83xx_spi->spibrg = pdata->sysclk / 2;
-	else
-		mpc83xx_spi->spibrg = pdata->sysclk;
+	mpc83xx_spi->spibrg = pdata->sysclk;
 
 	mpc83xx_spi->rx_shift = 0;
 	mpc83xx_spi->tx_shift = 0;
-- 
1.5.2.2
