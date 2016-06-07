Return-Path: <peter.griffin@linaro.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPJjg6K62zDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 03:39:51 +1000 (AEST)
Received: by mail-wm0-f44.google.com with SMTP id m124so124420280wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 10:39:51 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, vinod.koul@intel.com, linus.walleij@linaro.org,
 dan.j.williams@intel.com, leoli@freescale.com, zw@zh-kernel.org,
 baohua@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
 ldewangan@nvidia.com, jonathanh@nvidia.com, swarren@wwwdotorg.org,
 thierry.reding@gmail.com, gnurou@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] dmaengine: fsl-edma: print error code in error messages.
Date: Tue,  7 Jun 2016 18:38:35 +0100
Message-Id: <1465321121-22238-3-git-send-email-peter.griffin@linaro.org>
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

It is useful to print the error code as part of the error
message.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/fsl-edma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 7208fc9..cc06eea 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -963,14 +963,16 @@ static int fsl_edma_probe(struct platform_device *pdev)
 
 	ret = dma_async_device_register(&fsl_edma->dma_dev);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't register Freescale eDMA engine.\n");
+		dev_err(&pdev->dev,
+			"Can't register Freescale eDMA engine. (%d)\n", ret);
 		fsl_disable_clocks(fsl_edma);
 		return ret;
 	}
 
 	ret = of_dma_controller_register(np, fsl_edma_xlate, fsl_edma);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't register Freescale eDMA of_dma.\n");
+		dev_err(&pdev->dev,
+			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
 		dma_async_device_unregister(&fsl_edma->dma_dev);
 		fsl_disable_clocks(fsl_edma);
 		return ret;
-- 
1.9.1
