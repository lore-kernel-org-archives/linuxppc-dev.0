Return-Path: <peter.griffin@linaro.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPJjl0G6GzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 03:39:55 +1000 (AEST)
Received: by mail-wm0-f47.google.com with SMTP id k204so79273003wmk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 10:39:54 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, vinod.koul@intel.com, linus.walleij@linaro.org,
 dan.j.williams@intel.com, leoli@freescale.com, zw@zh-kernel.org,
 baohua@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
 ldewangan@nvidia.com, jonathanh@nvidia.com, swarren@wwwdotorg.org,
 thierry.reding@gmail.com, gnurou@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] dmaengine: s3c24xx: Simplify code in
 s3c24xx_dma_tx_status()
Date: Tue,  7 Jun 2016 18:38:37 +0100
Message-Id: <1465321121-22238-5-git-send-email-peter.griffin@linaro.org>
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

Doing so saves a few lines of code in the driver.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/s3c24xx-dma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 17ccdfd..f7d2c7a 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -768,16 +768,12 @@ static enum dma_status s3c24xx_dma_tx_status(struct dma_chan *chan,
 
 	spin_lock_irqsave(&s3cchan->vc.lock, flags);
 	ret = dma_cookie_status(chan, cookie, txstate);
-	if (ret == DMA_COMPLETE) {
-		spin_unlock_irqrestore(&s3cchan->vc.lock, flags);
-		return ret;
-	}
 
 	/*
 	 * There's no point calculating the residue if there's
 	 * no txstate to store the value.
 	 */
-	if (!txstate) {
+	if (ret == DMA_COMPLETE || !txstate) {
 		spin_unlock_irqrestore(&s3cchan->vc.lock, flags);
 		return ret;
 	}
-- 
1.9.1
