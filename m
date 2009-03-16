Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 958A9DE0A2
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:13:58 +1100 (EST)
Date: Tue, 17 Mar 2009 00:13:57 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-sdhci@drzeus.cx>
Subject: [PATCH 06/11] sdhci: Add get_{max,timeout}_clock callbacks
Message-ID: <20090316211357.GF9375@oksana.dev.rtsoft.ru>
References: <20090316211306.GA1736@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090316211306.GA1736@oksana.dev.rtsoft.ru>
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

From: Ben Dooks <ben-linux@fluff.org>

Some controllers do not provide clock information in their capabilities
(in the Samsung case, it is because there are multiple clock sources
available to the controller). Add hooks to allow the system to supply
clock information.

p.s.
In the original Ben's patch there was a bug that makes sdhci_add_host()
return -ENODEV even if callbacks were specified. This is fixed now.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci.c |   22 +++++++++++++++-------
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c814220..34ab77b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1674,19 +1674,27 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	host->max_clk =
 		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
+	host->max_clk *= 1000000;
 	if (host->max_clk == 0) {
-		printk(KERN_ERR "%s: Hardware doesn't specify base clock "
-			"frequency.\n", mmc_hostname(mmc));
-		return -ENODEV;
+		if (!host->ops->get_max_clock) {
+			printk(KERN_ERR
+			       "%s: Hardware doesn't specify base clock "
+			       "frequency.\n", mmc_hostname(mmc));
+			return -ENODEV;
+		}
+		host->max_clk = host->ops->get_max_clock(host);
 	}
-	host->max_clk *= 1000000;
 
 	host->timeout_clk =
 		(caps & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
 	if (host->timeout_clk == 0) {
-		printk(KERN_ERR "%s: Hardware doesn't specify timeout clock "
-			"frequency.\n", mmc_hostname(mmc));
-		return -ENODEV;
+		if (!host->ops->get_timeout_clock) {
+			printk(KERN_ERR
+			       "%s: Hardware doesn't specify timeout clock "
+			       "frequency.\n", mmc_hostname(mmc));
+			return -ENODEV;
+		}
+		host->timeout_clk = host->ops->get_timeout_clock(host);
 	}
 	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6980f27..aab0652 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -285,6 +285,8 @@ struct sdhci_ops {
 #endif
 
 	int		(*enable_dma)(struct sdhci_host *host);
+	unsigned int	(*get_max_clock)(struct sdhci_host *host);
+	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.5.6.5
