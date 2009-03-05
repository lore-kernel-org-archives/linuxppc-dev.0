Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C94D4DDF2A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 07:28:33 +1100 (EST)
Date: Thu, 5 Mar 2009 23:28:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 03/11] sdhci: Enable only relevant (DMA/PIO) interrupts
	during transfers
Message-ID: <20090305202832.GC28709@oksana.dev.rtsoft.ru>
References: <20090305202737.GA24166@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090305202737.GA24166@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some hosts (that is, FSL eSDHC) throw PIO interrupts during DMA
transfers, this causes tons of unneeded interrupts, and thus highly
degraded speed.

This patch modifies the driver so that now we only enable relevant
(DMA or PIO) interrupts during transfers.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ba9f95f..0cbde8e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -222,9 +222,7 @@ static void sdhci_init(struct sdhci_host *host)
 		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
 		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
-		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL |
-		SDHCI_INT_DMA_END | SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE |
-		SDHCI_INT_ADMA_ERROR);
+		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
 }
 
 static void sdhci_reinit(struct sdhci_host *host)
@@ -658,6 +656,17 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
 	return count;
 }
 
+static void sdhci_set_transfer_irqs(struct sdhci_host *host)
+{
+	u32 pio_irqs = SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL;
+	u32 dma_irqs = SDHCI_INT_DMA_END | SDHCI_INT_ADMA_ERROR;
+
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		sdhci_clear_set_irqs(host, pio_irqs, dma_irqs);
+	else
+		sdhci_clear_set_irqs(host, dma_irqs, pio_irqs);
+}
+
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 {
 	u8 count;
@@ -806,6 +815,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 		host->blocks = data->blocks;
 	}
 
+	sdhci_set_transfer_irqs(host);
+
 	/* We do not handle DMA boundaries, so set it to max (512 KiB) */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, data->blksz), SDHCI_BLOCK_SIZE);
 	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
-- 
1.5.6.5
