Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4BD1ADDF15
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 13:00:37 +1100 (EST)
Date: Thu, 22 Jan 2009 05:00:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 07/10] sdhci: Add support for hosts that don't specify
	clocks in the cap. register
Message-ID: <20090122020035.GG11492@oksana.dev.rtsoft.ru>
References: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090122015649.GA6835@oksana.dev.rtsoft.ru>
Cc: sdhci-devel@list.drzeus.cx, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, Liu Dave <DaveLiu@freescale.com>,
	Joe D'Abbraccio <Joe.D'abbraccio@freescale.com>,
	linuxppc-dev@ozlabs.org, Konjin Lai <Konjin.Lai@freescale.com>,
	Ben Dooks <ben-linux@fluff.org>, Xie Xiaobo <X.Xie@freescale.com>
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
index 57b8ffe..9ac088a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1693,24 +1693,23 @@ int sdhci_add_host(struct sdhci_host *host)
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
