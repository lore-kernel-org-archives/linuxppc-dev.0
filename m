Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 8414FDDFC2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 07:28:35 +1100 (EST)
Date: Thu, 5 Mar 2009 23:28:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 04/11] sdhci: Add support for card-detection polling
Message-ID: <20090305202834.GD28709@oksana.dev.rtsoft.ru>
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

This patch adds SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk. When specified,
sdhci driver will set MMC_CAP_NEEDS_POLL MMC host capability, and won't
enable card insert/remove interrupts.

This is needed for hosts with unreliable card detection, such as FSL
eSDHC. The original eSDHC driver was tring to "debounce" card-detection
IRQs by reading present state and disabling particular interrupts. But
with this debouncing scheme I noticed that sometimes we miss card
insertion/removal events.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |   17 +++++++++++++++--
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0cbde8e..d71c877 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -167,6 +167,9 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 irqs = SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT;
 
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+		return;
+
 	if (enable)
 		sdhci_unmask_irqs(host, irqs);
 	else
@@ -1096,6 +1099,7 @@ out:
 static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host;
+	bool present;
 	unsigned long flags;
 
 	host = mmc_priv(mmc);
@@ -1110,8 +1114,14 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host->mrq = mrq;
 
-	if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)
-		|| (host->flags & SDHCI_DEVICE_DEAD)) {
+	/* If polling, assume that the card is always present. */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+		present = true;
+	else
+		present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
+				SDHCI_CARD_PRESENT;
+
+	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		host->mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
 	} else
@@ -1745,6 +1755,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
 
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+
 	mmc->ocr_avail = 0;
 	if (caps & SDHCI_CAN_VDD_330)
 		mmc->ocr_avail |= MMC_VDD_32_33|MMC_VDD_33_34;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1c29895..09a4363 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -212,6 +212,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_BROKEN_SMALL_PIO			(1<<13)
 /* Controller does not provide transfer-complete interrupt when not busy */
 #define SDHCI_QUIRK_NO_BUSY_IRQ				(1<<14)
+/* Controller has unreliable card detection */
+#define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5
