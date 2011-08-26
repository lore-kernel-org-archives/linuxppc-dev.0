Return-Path: <B25806@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC64AB6F92
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 18:58:02 +1000 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linux-mmc@vger.kernel.org>
Subject: [PATCH 3/3 v2] mmc: Use mmc_delay() instead of mdelay() for time delay
Date: Fri, 26 Aug 2011 15:55:10 +0800
Message-ID: <1314345310-15041-1-git-send-email-Chunhe.Lan@freescale.com>
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
 drivers/mmc/host/sdhci.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e02cc1..b0cf79f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -186,7 +186,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	if (host->ops->platform_reset_exit)
@@ -957,7 +957,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	mod_timer(&host->timer, jiffies + 10 * HZ);
@@ -1127,7 +1127,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			return;
 		}
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1192,7 +1192,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * can apply clock after applying power
 	 */
 	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
-		mdelay(10);
+		mmc_delay(10);
 }
 
 /*****************************************************************************\
@@ -1712,7 +1712,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
 		timeout--;
-		mdelay(1);
+		mmc_delay(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.7.5.1
