Return-Path: <tie-fei.zang@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id 3EA9E1007D4
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 13:41:50 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linux-mmc@vger.kernel.org
Subject: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Tue, 3 Aug 2010 11:11:10 +0800
Message-ID: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Add auto CMD12 command support for eSDHC driver.
This is needed by P4080 and P1022 for block read/write.
Manual asynchronous CMD12 abort operation causes protocol violations on
these silicons.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mmc/host/sdhci-of-core.c |    4 ++++
 drivers/mmc/host/sdhci.c         |   14 ++++++++++++--
 drivers/mmc/host/sdhci.h         |    2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index a2e9820..dd1bdd1 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -154,6 +154,10 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 		host->ops = &sdhci_of_data->ops;
 	}
 
+	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
+
 	if (of_get_property(np, "sdhci,1-bit-only", NULL))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..a92566e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -817,8 +817,12 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	WARN_ON(!host->data);
 
 	mode = SDHCI_TRNS_BLK_CNT_EN;
-	if (data->blocks > 1)
-		mode |= SDHCI_TRNS_MULTI;
+	if (data->blocks > 1) {
+		if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+			mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
+		else
+			mode |= SDHCI_TRNS_MULTI;
+	}
 	if (data->flags & MMC_DATA_READ)
 		mode |= SDHCI_TRNS_READ;
 	if (host->flags & SDHCI_REQ_USE_DMA)
@@ -1108,6 +1112,12 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 #ifndef SDHCI_USE_LEDS_CLASS
 	sdhci_activate_led(host);
 #endif
+	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12) {
+		if (mrq->stop) {
+			mrq->data->stop = NULL;
+			mrq->stop = NULL;
+		}
+	}
 
 	host->mrq = mrq;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c846813..8fb088c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -240,6 +240,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
 /* Controller cannot support End Attribute in NOP ADMA descriptor */
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
+/* Controller uses Auto CMD12 command to stop the transfer */
+#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5
