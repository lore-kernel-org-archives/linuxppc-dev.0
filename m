Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AAB9EB7B73
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 02:50:17 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E173DDDD04
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 02:50:16 +1000 (EST)
Date: Fri, 7 Aug 2009 20:50:15 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] sdhci-of: Fix high-speed cards recognition
Message-ID: <20090807165015.GB524@oksana.dev.rtsoft.ru>
References: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090807163940.GA29192@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org,
	sdhci-devel@lists.ossman.eu, linuxppc-dev@ozlabs.org,
	Pierre Ossman <pierre@ossman.eu>
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

This patch fixes the issue by introducing and implementing
DYNAMIC_TIMEOUT_CLOCK quirk for sdhci-of driver.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-of.c |    5 ++---
 drivers/mmc/host/sdhci.c    |    4 ++++
 drivers/mmc/host/sdhci.h    |    2 ++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index 8440fd9..b6ff2e8 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -174,9 +174,7 @@ static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
 
 static unsigned int esdhc_get_timeout_clock(struct sdhci_host *host)
 {
-	struct sdhci_of_host *of_host = sdhci_priv(host);
-
-	return of_host->clock / 1000;
+	return host->clock / 1000;
 }
 
 static struct sdhci_of_data sdhci_esdhc = {
@@ -185,6 +183,7 @@ static struct sdhci_of_data sdhci_esdhc = {
 		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_NONSTANDARD_CLOCK |
+		  SDHCI_QUIRK_DYNAMIC_TIMEOUT_CLOCK |
 		  SDHCI_QUIRK_PIO_NEEDS_DELAY |
 		  SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET |
 		  SDHCI_QUIRK_NO_CARD_NO_RESET,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fc96f8c..0f273fe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -591,6 +591,10 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
 	target_timeout = data->timeout_ns / 1000 +
 		data->timeout_clks / host->clock;
 
+	if (host->quirks & SDHCI_QUIRK_DYNAMIC_TIMEOUT_CLOCK &&
+			host->ops->get_timeout_clock)
+		host->timeout_clk = host->ops->get_timeout_clock(host);
+
 	/*
 	 * Figure out needed cycles.
 	 * We do this in steps in order to fit inside a 32 bit int.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c77e9ff..44b1dcc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -232,6 +232,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
 /* Controller needs 10ms delay between applying power and clock */
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
+/* Controller has dynamic timeout clock management */
+#define SDHCI_QUIRK_DYNAMIC_TIMEOUT_CLOCK		(1<<24)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.6.3.3
