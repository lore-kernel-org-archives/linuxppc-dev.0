Return-Path: <peter.griffin@linaro.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPJjp25n8zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 03:39:58 +1000 (AEST)
Received: by mail-wm0-f51.google.com with SMTP id k204so79274611wmk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 10:39:58 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, vinod.koul@intel.com, linus.walleij@linaro.org,
 dan.j.williams@intel.com, leoli@freescale.com, zw@zh-kernel.org,
 baohua@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
 ldewangan@nvidia.com, jonathanh@nvidia.com, swarren@wwwdotorg.org,
 thierry.reding@gmail.com, gnurou@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/8] dmaengine: sun6i-dma: Only calculate residue if state
 exists.
Date: Tue,  7 Jun 2016 18:38:39 +0100
Message-Id: <1465321121-22238-7-git-send-email-peter.griffin@linaro.org>
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

There is no point in calculating the residue if state does not
exist to store the value.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/sun6i-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 5065ca4..3835fcd 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -865,7 +865,7 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	size_t bytes = 0;
 
 	ret = dma_cookie_status(chan, cookie, state);
-	if (ret == DMA_COMPLETE)
+	if (ret == DMA_COMPLETE || !state)
 		return ret;
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
-- 
1.9.1
