Return-Path: <maxime.ripard@free-electrons.com>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by lists.ozlabs.org (Postfix) with ESMTP id E1E261A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 20:05:14 +1100 (AEDT)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 04/11] dmaengine: fsldma: Remove chancnt affectations
Date: Thu, 16 Oct 2014 11:00:56 +0200
Message-Id: <1413450063-23829-5-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linuxppc-dev@lists.ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

chanctnt is already filled by dma_async_device_register, which uses the channel
list to know how much channels there is.

Since it's already filled, we can safely remove it from the drivers' probe
function.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/fsldma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index d5d6885ab341..75ae6405a5ee 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1332,7 +1332,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&chan->common.device_node, &fdev->common.channels);
-	fdev->common.chancnt++;
 
 	dev_info(fdev->dev, "#%d (%s), irq %d\n", chan->id, compatible,
 		 chan->irq != NO_IRQ ? chan->irq : fdev->irq);
-- 
2.1.1
