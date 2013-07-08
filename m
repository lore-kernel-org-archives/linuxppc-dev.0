Return-Path: <B42677@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 174822C02B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 13:02:17 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4] mmc: eSDHC: Some eSDHC host need long time to generate
 command interrupt
Date: Mon, 8 Jul 2013 10:12:25 +0800
Message-ID: <1373249545-23928-4-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
References: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, cjb@laptop.org, AFLEMING@freescale.com,
 Haijun Zhang <haijun.zhang@freescale.com>, cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Command complete interrupt not always generate within 10 * HZ. Sometimes
500 * HZ or more. So enlarge this detecting value to ensure the host had
sufficient time to generate command complete interrupt.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |  3 +++
 drivers/mmc/host/sdhci.c          | 10 +++++++++-
 include/linux/mmc/sdhci.h         |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index b22cab0..b616b03 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -331,6 +331,9 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 
 	if (vvn > VENDOR_V_22)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
+
+	if (fsl_svr_is(SVR_B4860) || fsl_svr_is(SVR_T4240))
+		host->quirks2 |= SDHCI_QUIRK2_LONG_TM_CMD_COMPLETE_IRQ;
 }
 
 static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index de7fa81..35015ba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -986,6 +986,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	int flags;
 	u32 mask;
 	unsigned long timeout;
+	int timer = 10;
 
 	WARN_ON(host->cmd);
 
@@ -1014,7 +1015,14 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	mod_timer(&host->timer, jiffies + 10 * HZ);
+	/*
+	 * Some eSDHC controller need long time to generate command complete
+	 * interrupt, 1000 * HZ will be enough.
+	 */
+	if (host->quirks2 & SDHCI_QUIRK2_LONG_TM_CMD_COMPLETE_IRQ)
+		timer = 1000;
+
+	mod_timer(&host->timer, jiffies + timer * HZ);
 
 	host->cmd = cmd;
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dc608d7..68e7dd1 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -100,6 +100,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
 /* The host support VS300 even if the capacity detailed not */
 #define SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30		(1<<6)
+/* Some controller need long time to generate command complete interrupt */
+#define SDHCI_QUIRK2_LONG_TM_CMD_COMPLETE_IRQ		(1<<7)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.0
