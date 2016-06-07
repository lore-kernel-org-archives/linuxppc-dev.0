Return-Path: <peter.griffin@linaro.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPJjr1FXczDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 03:40:00 +1000 (AEST)
Received: by mail-wm0-f54.google.com with SMTP id n184so147711040wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 10:40:00 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, vinod.koul@intel.com, linus.walleij@linaro.org,
 dan.j.williams@intel.com, leoli@freescale.com, zw@zh-kernel.org,
 baohua@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
 ldewangan@nvidia.com, jonathanh@nvidia.com, swarren@wwwdotorg.org,
 thierry.reding@gmail.com, gnurou@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] dmaengine: tegra20-apb-dma: Only calculate residue if
 txstate exists.
Date: Tue,  7 Jun 2016 18:38:40 +0100
Message-Id: <1465321121-22238-8-git-send-email-peter.griffin@linaro.org>
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

There is no point calculating the residue if there is
no txstate to store the value.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 01e316f..7f4af8c 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -814,7 +814,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
 	unsigned int residual;
 
 	ret = dma_cookie_status(dc, cookie, txstate);
-	if (ret == DMA_COMPLETE)
+	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
 	spin_lock_irqsave(&tdc->lock, flags);
-- 
1.9.1
