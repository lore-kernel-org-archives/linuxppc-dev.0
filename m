Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9510B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 19:56:00 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/2] mmc: Use mmc_delay() instead of mdelay() for time delay
Date: Thu, 25 Aug 2011 16:53:34 +0800
Message-ID: <1314262414-31787-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <b36685@freescale.com>, kumar.gala@freescale.com,
	Chris Ball <cjb@laptop.org>, linuxppc-dev@lists.ozlabs.org,
	Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mmc_delay() is a wrapper function for mdelay() and msleep().

    o mdelay() -- block the system when busy-waiting.
    o msleep() -- suspend the currently running task to enable CPU
                  to process other tasks, so it is non-blocking
                  regarding the whole system.

When the desired delay time is more than a period of timer interrupt,
just use msleep(). Change mdelay() to mmc_delay() to avoid chewing
CPU when busy wait.

Signed-off-by: Shengzhou Liu <b36685@freescale.com>
Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-esdhc.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c3b08f1..42b1d9eb 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver generics for OF and pltfm.
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2011 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  * Copyright (c) 2010 Pengutronix e.K.
  *   Author: Wolfram Sang <w.sang@pengutronix.de>
@@ -14,6 +14,8 @@
 #ifndef _DRIVERS_MMC_SDHCI_ESDHC_H
 #define _DRIVERS_MMC_SDHCI_ESDHC_H
 
+#include "../core/core.h"
+
 /*
  * Ops and quirks for the Freescale eSDHC controller.
  */
@@ -73,7 +75,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(100);
+	mmc_delay(100);
 out:
 	host->clock = clock;
 }
-- 
1.7.5.1
