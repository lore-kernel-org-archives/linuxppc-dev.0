Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0139.outbound.protection.outlook.com [157.56.110.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E24521A0072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 19:49:58 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
CC: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH 1/3] mmc: sdhci-of-esdhc: convert to use esdhc_get_property()
Date: Tue, 21 Jul 2015 17:44:54 +0800
Message-ID: <1437471894-34110-1-git-send-email-yangbo.lu@freescale.com>
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

Move sdhci_get_of_property and other getting property code from
sdhci_esdhc_probe into esdhc_get_property.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 797be75..1295a96 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -348,19 +348,17 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
-static int sdhci_esdhc_probe(struct platform_device *pdev)
+static void esdhc_get_property(struct platform_device *pdev)
 {
-	struct sdhci_host *host;
-	struct device_node *np;
-	int ret;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
-	if (IS_ERR(host))
-		return PTR_ERR(host);
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
 
 	sdhci_get_of_property(pdev);
 
-	np = pdev->dev.of_node;
+	/* call to generic mmc_of_parse to support additional capabilities */
+	mmc_of_parse(host->mmc);
+	mmc_of_parse_voltage(np, &host->ocr_mask);
+
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
@@ -375,13 +373,18 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		 */
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
+}
 
-	/* call to generic mmc_of_parse to support additional capabilities */
-	ret = mmc_of_parse(host->mmc);
-	if (ret)
-		goto err;
+static int sdhci_esdhc_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	int ret;
 
-	mmc_of_parse_voltage(np, &host->ocr_mask);
+	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	esdhc_get_property(pdev);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-- 
2.1.0.27.g96db324
