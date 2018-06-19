Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 419D3P2MxHzF0wf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:30:41 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: York Sun <york.sun@nxp.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] spi/fsl-espi: Add missing cell-index OF property
Date: Tue, 19 Jun 2018 18:23:04 +0200
Message-Id: <20180619162304.20125-1-joakim.tjernlund@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

espi does not look for a OF cell-index property which
makes the bus numbering dynamic only. This add an
optional cell-index.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
---
 drivers/spi/spi-fsl-espi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1d332e23f6ed..56b71c5e2f10 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -672,6 +672,14 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 
 	dev_set_drvdata(dev, master);
 
+	if (dev->of_node) {
+		u32 cell_index;
+
+		if (!of_property_read_u32(dev->of_node, "cell-index",
+					  &cell_index))
+			master->bus_num = cell_index;
+	}
+
 	master->mode_bits = SPI_RX_DUAL | SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
 			    SPI_LSB_FIRST | SPI_LOOP;
 	master->dev.of_node = dev->of_node;
-- 
2.13.6
