Return-Path: <tie-fei.zang@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 95251B70A5
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 16:08:38 +1000 (EST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linux-mmc-approval@vger.kernel.org
Subject: [PATCH 3/3] mmc: Add ESDHC weird register workaround
Date: Wed, 28 Jul 2010 13:54:21 +0800
Message-ID: <1280296461-17077-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P4080 ESDHC controller induces weird register setting.
This patch adds the workaround to correct the weird register setting.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 drivers/mmc/host/sdhci-of-core.c |    5 +++++
 drivers/mmc/host/sdhci.c         |   13 +++++++++++++
 drivers/mmc/host/sdhci.h         |    2 ++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index 0c30242..1b6945a 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -164,6 +164,11 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
 	if (sdhci_of_wp_inverted(np))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+	if (of_device_is_compatible(np, "fsl,p4080-esdhc")) {
+		host->quirks |= SDHCI_QUIRK_QORIQ_REG_WEIRD;
+		host->quirks &= ~SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+	}
+
 	clk = of_get_property(np, "clock-frequency", &size);
 	if (clk && size == sizeof(*clk) && *clk)
 		of_host->clock = *clk;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1424d08..b5b3627 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -788,6 +788,15 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 	}
 
+	/* The default value of DMAS bits of Protocol Control Register is not
+	 * correct. clear these two bits to use simple DMA */
+#define  ESDHCI_CTRL_DMAS_MASK		0xFFFFFCFF
+	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD) {
+		ctrl = sdhci_readl(host, SDHCI_HOST_CONTROL);
+		ctrl = ctrl & ESDHCI_CTRL_DMAS_MASK;
+		sdhci_writel(host, ctrl, SDHCI_HOST_CONTROL);
+	}
+
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
 
@@ -1699,6 +1708,10 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
 
+	 /* Workaround for P4080 host controller capabilities */
+	if (host->quirks & SDHCI_QUIRK_QORIQ_REG_WEIRD)
+		caps &= ~(SDHCI_CAN_VDD_180 | SDHCI_CAN_VDD_330);
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps & SDHCI_CAN_DO_SDMA))
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index aa112aa..33d5613 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -243,6 +243,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
 /* Controller uses Auto CMD12 command to stop the transfer */
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<27)
+/* Controller has weird bit setting for some registers due to errata */
+#define SDHCI_QUIRK_QORIQ_REG_WEIRD			(1<<28)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.5.6.5
