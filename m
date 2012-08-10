Return-Path: <B25806@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 251832C00B4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 20:24:41 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH v3 2/2] mmc: Use mmc_delay() instead of mdelay() for time delay
Date: Fri, 10 Aug 2012 18:26:33 -0400
Message-ID: <1344637593-29461-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <b36685@freescale.com>, kumar.gala@freescale.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
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
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-esdhc.h |    4 ++--
 drivers/mmc/host/sdhci.c       |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index b97b2f5..272cea0 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -1,7 +1,7 @@
 /*
  * Freescale eSDHC controller driver generics for OF and pltfm.
  *
- * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2007, 2012 Freescale Semiconductor, Inc.
  * Copyright (c) 2009 MontaVista Software, Inc.
  * Copyright (c) 2010 Pengutronix e.K.
  *   Author: Wolfram Sang <w.sang@pengutronix.de>
@@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(1);
+	mmc_delay(1);
 out:
 	host->clock = clock;
 }
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a11dc3..6e67bc4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -205,7 +205,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	if (host->ops->platform_reset_exit)
@@ -997,7 +997,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
@@ -1178,7 +1178,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1243,7 +1243,7 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * can apply clock after applying power
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		mmc_delay(10);
 
 	return power;
 }
@@ -1850,7 +1850,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.7.6.5
