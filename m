Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D4A81B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jul 2009 07:55:07 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0935DDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Jul 2009 07:55:07 +1000 (EST)
Date: Sat, 25 Jul 2009 01:55:05 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] sdhci: Get rid of "frequency too high" flood when using eSDHC
Message-ID: <20090724215505.GA5726@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Dooks <ben@fluff.org>, sdhci-devel@lists.ossman.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Pierre Ossman <pierre@ossman.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit 8dfd0374be84793360db7fff2e635d2cd3bbcb21 ("MMC core: limit
minimum initialization frequency to 400kHz") MMC core checks for minimum
frequency, and that causes following messages flood when using eSDHC
controllers:

  ...
  mmc0: Minimum clock frequency too high for identification mode
  mmc0: Minimum clock frequency too high for identification mode
  ...

The warnings are legitimate, since if we'd use 133 MHz clocks for
standard SDHCI controllers, we'd not able to scale frequency down
to 400 kHz.

But eSDHC controllers have a non-standard SD clock management, so
we can divide clock by 256 * 16, not just 256.

This patch introduces get_min_clock() callback for sdhci core and
implements it for sdhci-of driver, and thus fixes the issue.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-of.c |    8 ++++++++
 drivers/mmc/host/sdhci.c    |    5 ++++-
 drivers/mmc/host/sdhci.h    |    1 +
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
index d79fa55..9088443 100644
--- a/drivers/mmc/host/sdhci-of.c
+++ b/drivers/mmc/host/sdhci-of.c
@@ -158,6 +158,13 @@ static unsigned int esdhc_get_max_clock(struct sdhci_host *host)
 	return of_host->clock;
 }
 
+static unsigned int esdhc_get_min_clock(struct sdhci_host *host)
+{
+	struct sdhci_of_host *of_host = sdhci_priv(host);
+
+	return of_host->clock / 256 / 16;
+}
+
 static unsigned int esdhc_get_timeout_clock(struct sdhci_host *host)
 {
 	struct sdhci_of_host *of_host = sdhci_priv(host);
@@ -184,6 +191,7 @@ static struct sdhci_of_data sdhci_esdhc = {
 		.set_clock = esdhc_set_clock,
 		.enable_dma = esdhc_enable_dma,
 		.get_max_clock = esdhc_get_max_clock,
+		.get_min_clock = esdhc_get_min_clock,
 		.get_timeout_clock = esdhc_get_timeout_clock,
 	},
 };
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6779b4e..62041c7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1766,7 +1766,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
-	mmc->f_min = host->max_clk / 256;
+	if (host->ops->get_min_clock)
+		mmc->f_min = host->ops->get_min_clock(host);
+	else
+		mmc->f_min = host->max_clk / 256;
 	mmc->f_max = host->max_clk;
 	mmc->caps = MMC_CAP_SDIO_IRQ;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 831ddf7..c77e9ff 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -302,6 +302,7 @@ struct sdhci_ops {
 
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
+	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 };
 
-- 
1.6.3.3
