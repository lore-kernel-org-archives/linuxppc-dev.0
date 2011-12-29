Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E41D3B6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2011 20:22:40 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH][v2] mmc:sdhci: restore the enabled dma when do reset all
Date: Thu, 29 Dec 2011 16:33:00 +0800
Message-ID: <1325147580-31281-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If dma is enabled, it'll be cleared when reset all is performed, this can
be observed on some platforms, such as P2041 which has a version 2.3
controller, but platform like P4080 which has a version 2.2 controller,
does not suffer this, so we will check if the dma is enabled, we should
restore it after reset all.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
based on http://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git,
branch 'for-linus'.

changes for v2:
call the wrapper API instead of access the register directly.

 drivers/mmc/host/sdhci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 19ed580..cf6a048 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -214,6 +214,11 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
+
+	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
+		if ((host->ops->enable_dma) && (mask & SDHCI_RESET_ALL))
+			host->ops->enable_dma(host);
+	}
 }
 
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
-- 
1.6.4
