Return-Path: <vincent.yang.fujitsu@gmail.com>
Received: from mail-pb0-x22b.google.com (mail-pb0-x22b.google.com
 [IPv6:2607:f8b0:400e:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69A011A00EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 19:35:46 +1000 (EST)
Received: by mail-pb0-f43.google.com with SMTP id um1so2684619pbc.16
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 02:35:43 -0700 (PDT)
From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
To: chris@printf.net,
	linux-mmc@vger.kernel.org
Subject: [RFC PATCH 4/7] mmc: sdhci: add quirk for single block transactions
Date: Fri, 20 Jun 2014 17:35:25 +0800
Message-Id: <1403256928-11359-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
In-Reply-To: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Cc: andy.green@linaro.org, anton@enomsg.org, linuxppc-dev@lists.ozlabs.org,
 Vincent.Yang@tw.fujitsu.com, patches@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch defines a quirk to disable the block count
for single block transactions.
It is a preparation and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
---
 drivers/mmc/host/sdhci.c  | 8 +++++---
 include/linux/mmc/sdhci.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fe69cc5..21a29ae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -876,7 +876,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
-	u16 mode;
+	u16 mode = 0;
 	struct mmc_data *data = cmd->data;
 
 	if (data == NULL) {
@@ -889,9 +889,11 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	WARN_ON(!host->data);
 
-	mode = SDHCI_TRNS_BLK_CNT_EN;
+	if (!(host->quirks2 & SDHCI_QUIRK2_SUPPORT_SINGLE))
+		mode = SDHCI_TRNS_BLK_CNT_EN;
+
 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
-		mode |= SDHCI_TRNS_MULTI;
+		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
 		/*
 		 * If we are sending CMD23, CMD12 never gets sent
 		 * on successful completion (so no Auto-CMD12).
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 5690a1f..ac645b9 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -104,6 +104,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_VOLTAGE_SWITCH			(1<<9)
 /* forced tuned clock */
 #define SDHCI_QUIRK2_TUNING_WORK_AROUND		(1<<10)
+/* disable the block count for single block transactions */
+#define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<11)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.0
