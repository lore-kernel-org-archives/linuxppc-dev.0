Return-Path: <yangbo.lu@nxp.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0093.outbound.protection.outlook.com [157.56.111.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqdS808kgzDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 20:30:15 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <scott.wood@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 2/2] mmc: sdhci-pltfm: get clock through the common clk APIs
Date: Wed, 20 Apr 2016 18:20:44 +0800
Message-ID: <1461147644-18041-2-git-send-email-yangbo.lu@nxp.com>
In-Reply-To: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
References: <1461147644-18041-1-git-send-email-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Get the sdhc clock through the common clk APIs. If the APIs fail, try
to get the clock through 'clock-frequency' property. We could remove
the clock fixup in u-boot by adding the common clk APIs support.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 072bb27..383fa49 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/clk.h>
 #ifdef CONFIG_PPC
 #include <asm/machdep.h>
 #endif
@@ -71,6 +72,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct clk *sdhci_clk;
 	u32 bus_width;
 
 	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
@@ -99,7 +101,11 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
+	sdhci_clk = of_clk_get(np, 0);
+	if (!IS_ERR(sdhci_clk))
+		pltfm_host->clock = clk_get_rate(sdhci_clk);
+	else
+		of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
 
 	if (of_find_property(np, "keep-power-in-suspend", NULL))
 		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
-- 
2.1.0.27.g96db324
