Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [IPv6:2001:470:1f05:998::1])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3C2A1A033B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 06:52:44 +1100 (AEDT)
Date: Wed, 28 Jan 2015 14:52:36 -0500
From: Martin Hicks <mort@bork.org>
To: chris@printf.net, Anton Vorontsov <anton@enomsg.org>
Subject: [PATCH] mmc: sdhci: Apply FSL ESDHC reset handling quirk to OF
Message-ID: <20150128195236.GA31422@darwin.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-mmc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The reset code was pushed into the esdhc-imx driver, but missed being
pushed into the FSL OF driver at the same time.  The commit that broke
the OF ESDHC driver was 0718e59ae259f7c48155b4e852d8b0632d59028e

Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8872c85..4a654d4 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -276,6 +276,14 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
 }
 
+static void esdhc_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
 static const struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -290,7 +298,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_init = esdhc_of_platform_init,
 	.adma_workaround = esdhci_of_adma_workaround,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
-	.reset = sdhci_reset,
+	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-- 
1.7.10.4


-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
