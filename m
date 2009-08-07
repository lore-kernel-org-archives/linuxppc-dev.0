Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D9577B7DB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 05:58:10 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1B710DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 05:58:10 +1000 (EST)
Date: Fri, 7 Aug 2009 23:58:08 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/7] sdhci-of: Fix high-speed cards recognition
Message-ID: <20090807195808.GC2735@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben@fluff.org>, sdhci-devel@lists.ossman.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Pierre Ossman <pierre@ossman.eu>, David Vrabel <david.vrabel@csr.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eSDHC fails to recognize some SDHS cards, throwing timeout errors:

  mmc0: error -110 whilst initialising SD card

That's because we calculate timeout value in a wrong way: on eSDHC
hosts the timeout clock is derivied from the SD clock, which is set
dynamically.

As David Vrabel suggested, deriving timeout clock from SD clock is
a common scheme, so let's implement DATA_TIMEOUT_USES_SDCLK quirk
and use it for eSDHC hosts.

Also, from now on we don't need esdhc_get_timeout_clock() callback,
so remove it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-of.c |    9 +--------
 drivers/mmc/host/sdhci.c    |    9 +++++++--
 drivers/mmc/host/sdhci.h    |    2 ++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 8440fd9..004f24d 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -172,19 +172,13 @@ static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
 	return of_host->clock / 256 / 16;
 }
 
-static unsigned int esdhc_get_timeout_clock(struct sdhci_host *host)
-{
-	struct sdhci_of_host *of_host = sdhci_priv(host);
-
-	return of_host->clock / 1000;
-}
-
 static struct sdhci_of_data sdhci_esdhc = {
 	.quirks = SDHCI_QUIRK_FORCE_BLK_SZ_2048 |
 		  SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
 		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
 		  SDHCI_QUIRK_NO_CARD_NO_RESET,
@@ -199,7 +193,6 @@ static struct sdhci_of_data sdhci_esdhc = {
 		.enable_dma = esdhc_enable_dma,
 		.get_max_clock = esdhc_get_max_clock,
 		.get_min_clock = esdhc_get_min_clock,
-		.get_timeout_clock = esdhc_get_timeout_clock,
 	},
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fc96f8c..288e40b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -591,6 +591,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
 	target_timeout = data->timeout_ns / 1000 +
 		data->timeout_clks / host->clock;
 
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		host->timeout_clk = host->clock / 1000;
+
 	/*
 	 * Figure out needed cycles.
 	 * We do this in steps in order to fit inside a 32 bit int.
@@ -1757,13 +1760,15 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->timeout_clk =
 		(caps & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
 	if (host->timeout_clk == 0) {
-		if (!host->ops->get_timeout_clock) {
+		if (host->ops->get_timeout_clock) {
+			host->timeout_clk = host->ops->get_timeout_clock(host);
+		} else if (!(host->quirks &
+				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
 			printk(KERN_ERR
 			       "%s: Hardware doesn't specify timeout clock "
 			       "frequency.\n", mmc_hostname(mmc));
 			return -ENODEV;
 		}
-		host->timeout_clk = host->ops->get_timeout_clock(host);
 	}
 	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c77e9ff..afda7f1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -232,6 +232,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
 /* Controller needs 10ms delay between applying power and clock */
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+/* Controller uses SDCLK instead of TMCLK for data timeouts */
+#define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.6.3.3
