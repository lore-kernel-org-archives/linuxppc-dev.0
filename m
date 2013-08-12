Return-Path: <B42677@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2099F2C01CC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 12:33:13 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/3 V3] mmc:sdhc: get voltage from sdhc host
Date: Mon, 12 Aug 2013 09:39:06 +0800
Message-ID: <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: X.Xie@freescale.com, cbouatmailru@gmail.com, scottwood@freescale.com,
 cjb@laptop.org, Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use host->ocr_mask to hold the voltage get from device-tree
node, In case host->ocr_mask was available, we use host->ocr_mask
as the final available voltage can be used by MMC/SD/SDIO card.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for V3:
	- changed the type of mask

 drivers/mmc/host/sdhci.c  | 3 +++
 include/linux/mmc/sdhci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a78bd4f..57541e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3119,6 +3119,9 @@ int sdhci_add_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 
+	if (host->ocr_mask)
+		ocr_avail = host->ocr_mask;
+
 	mmc->ocr_avail = ocr_avail;
 	mmc->ocr_avail_sdio = ocr_avail;
 	if (host->ocr_avail_sdio)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e3c6a74..3e781b8 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -171,6 +171,7 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sdio;	/* OCR bit masks */
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
+	u32 ocr_mask;		/* available voltages */
 
 	wait_queue_head_t	buf_ready_int;	/* Waitqueue for Buffer Read Ready interrupt */
 	unsigned int		tuning_done;	/* Condition flag set when CMD19 succeeds */
-- 
1.8.0
