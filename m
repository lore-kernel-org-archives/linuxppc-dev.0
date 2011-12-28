Return-Path: <B21989@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 03CF7B6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 21:30:30 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH] mmc:sdhci: restore the enabled dma when do reset all
Date: Wed, 28 Dec 2011 17:41:21 +0800
Message-ID: <1325065281-17785-1-git-send-email-Shaohui.Xie@freescale.com>
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

 drivers/mmc/host/sdhci.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 19ed580..22033c3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/host.h>
 
 #include "sdhci.h"
+#include "sdhci-esdhc.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -176,6 +177,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
 	u32 uninitialized_var(ier);
+	u32 uninitialized_var(dma);
 
 	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
 		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
@@ -189,6 +191,8 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (host->ops->platform_reset_enter)
 		host->ops->platform_reset_enter(host, mask);
 
+	dma = sdhci_readl(host, ESDHC_DMA_SYSCTL);
+
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 
 	if (mask & SDHCI_RESET_ALL)
@@ -214,6 +218,9 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
+
+	if ((dma & ESDHC_DMA_SNOOP) && (mask & SDHCI_RESET_ALL))
+		sdhci_writel(host, dma, ESDHC_DMA_SYSCTL);
 }
 
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
-- 
1.6.4
