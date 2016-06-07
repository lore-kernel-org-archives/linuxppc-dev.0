Return-Path: <peter.griffin@linaro.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPJjf3jgnzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 03:39:50 +1000 (AEST)
Received: by mail-wm0-f43.google.com with SMTP id k204so79270328wmk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 10:39:50 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, vinod.koul@intel.com, linus.walleij@linaro.org,
 dan.j.williams@intel.com, leoli@freescale.com, zw@zh-kernel.org,
 baohua@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
 ldewangan@nvidia.com, jonathanh@nvidia.com, swarren@wwwdotorg.org,
 thierry.reding@gmail.com, gnurou@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] dmaengine: fsl-edma: Fix clock handling error paths
Date: Tue,  7 Jun 2016 18:38:34 +0100
Message-Id: <1465321121-22238-2-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently fsl-edma doesn't clk_disable_unprepare()
its clocks on error conditions. This patch adds a
fsl_disable_clocks helper for this, and also only
disables clocks which were enabled if encountering
an error whilst enabling clocks.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/fsl-edma.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index be2e62b..7208fc9 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -852,6 +852,14 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 	return 0;
 }
 
+static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma)
+{
+	int i;
+
+	for (i = 0; i < DMAMUX_NR; i++)
+		clk_disable_unprepare(fsl_edma->muxclk[i]);
+}
+
 static int fsl_edma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -897,6 +905,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 		ret = clk_prepare_enable(fsl_edma->muxclk[i]);
 		if (ret) {
+			/* disable only clks which were enabled on error */
+			for (; i >= 0; i--)
+				clk_disable_unprepare(fsl_edma->muxclk[i]);
+
 			dev_err(&pdev->dev, "DMAMUX clk block failed.\n");
 			return ret;
 		}
@@ -952,6 +964,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&fsl_edma->dma_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't register Freescale eDMA engine.\n");
+		fsl_disable_clocks(fsl_edma);
 		return ret;
 	}
 
@@ -959,6 +972,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Can't register Freescale eDMA of_dma.\n");
 		dma_async_device_unregister(&fsl_edma->dma_dev);
+		fsl_disable_clocks(fsl_edma);
 		return ret;
 	}
 
@@ -972,13 +986,10 @@ static int fsl_edma_remove(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_edma_engine *fsl_edma = platform_get_drvdata(pdev);
-	int i;
 
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_edma->dma_dev);
-
-	for (i = 0; i < DMAMUX_NR; i++)
-		clk_disable_unprepare(fsl_edma->muxclk[i]);
+	fsl_disable_clocks(fsl_edma);
 
 	return 0;
 }
-- 
1.9.1
