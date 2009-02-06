Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6B0EFDDEDD
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 05:07:00 +1100 (EST)
Date: Fri, 6 Feb 2009 21:06:57 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 08/11] sdhci: Add support for hosts that don't specify
	clocks in the cap. register
Message-ID: <20090206180657.GH11548@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FSL eSDHC hosts don't provide clocks bits in the capabilities register,
instead we're getting clocks values from the device tree.

There is somewhat similar change[1] from Ben Dooks, the change adds
callbacks for getting the clocks. But for eSDHC the callbacks are
superfluous, since the clocks are static.

[1] http://lkml.org/lkml/2008/12/2/157

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ede3790..0293368 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1703,24 +1703,23 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
 	}
 
-	host->max_clk =
-		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
-	if (host->max_clk == 0) {
-		printk(KERN_ERR "%s: Hardware doesn't specify base clock "
-			"frequency.\n", mmc_hostname(mmc));
-		return -ENODEV;
+	if (!host->max_clk) {
+		host->max_clk = (caps & SDHCI_CLOCK_BASE_MASK) >>
+						SDHCI_CLOCK_BASE_SHIFT;
+		if (host->max_clk == 0) {
+			printk(KERN_ERR "%s: Hardware doesn't specify base "
+				"clock frequency.\n", mmc_hostname(mmc));
+			return -ENODEV;
+		}
+		host->max_clk *= 1000000;
 	}
-	host->max_clk *= 1000000;
 
-	host->timeout_clk =
-		(caps & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
-	if (host->timeout_clk == 0) {
-		printk(KERN_ERR "%s: Hardware doesn't specify timeout clock "
-			"frequency.\n", mmc_hostname(mmc));
-		return -ENODEV;
+	if (!host->timeout_clk) {
+		host->timeout_clk = (caps & SDHCI_TIMEOUT_CLK_MASK) >>
+						SDHCI_TIMEOUT_CLK_SHIFT;
+		if (caps & SDHCI_TIMEOUT_CLK_UNIT)
+			host->timeout_clk *= 1000;
 	}
-	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
-		host->timeout_clk *= 1000;
 
 	/*
 	 * Set host parameters.
-- 
1.5.6.5
