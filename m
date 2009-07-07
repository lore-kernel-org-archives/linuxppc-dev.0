Return-Path: <Kexin.Hao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 22FC4B7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 13:23:50 +1000 (EST)
From: Kevin Hao <kexin.hao@windriver.com>
To: avorontsov@ru.mvista.com, pierre@ossman.eu, sdhci-devel@lists.ossman.eu,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] mmc: add quirk for controller that doesn't have highspeed bit
	in host control reg
Date: Tue,  7 Jul 2009 10:04:52 +0800
Message-Id: <1246932292-17766-1-git-send-email-kexin.hao@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FSL eSDHC controller doesn't have highspeed bit in its host control reg.
And the corresponding bit is used to set up the bus width. So add a
quirk to avoid set this bit. Tested on a mpc8377 RDB board.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
---
 drivers/mmc/host/sdhci-of.c |    3 ++-
 drivers/mmc/host/sdhci.c    |   10 ++++++----
 drivers/mmc/host/sdhci.h    |    2 ++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index d79fa55..1377ec8 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -173,7 +173,8 @@ static struct sdhci_of_data sdhci_esdhc = {
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
 		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
 		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
-		  SDHCI_QUIRK_NO_CARD_NO_RESET,
+		  SDHCI_QUIRK_NO_CARD_NO_RESET |
+		  SDHCI_QUIRK_NO_HIGHSPEED_BIT,
 	.ops = {
 		.readl = esdhc_readl,
 		.readw = esdhc_readw,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6779b4e..a08fa28 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1143,10 +1143,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 
-	if (ios->timing == MMC_TIMING_SD_HS)
-		ctrl |= SDHCI_CTRL_HISPD;
-	else
-		ctrl &= ~SDHCI_CTRL_HISPD;
+	if (!(host->quirks | SDHCI_QUIRK_NO_HIGHSPEED_BIT)) {
+		if (ios->timing == MMC_TIMING_SD_HS)
+			ctrl |= SDHCI_CTRL_HISPD;
+		else
+			ctrl &= ~SDHCI_CTRL_HISPD;
+	}
 
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 831ddf7..404bb5f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -232,6 +232,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
 /* Controller needs 10ms delay between applying power and clock */
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+/* Controller doesn't have highspeed bit in host control reg */
+#define SDHCI_QUIRK_NO_HIGHSPEED_BIT			(1<<24)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.6.2.5
