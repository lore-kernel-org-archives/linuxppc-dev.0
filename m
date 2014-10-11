Return-Path: <vinod.koul@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 5989F1A0A1B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Oct 2014 03:20:50 +1100 (EST)
From: Vinod Koul <vinod.koul@intel.com>
To: dmaengine@vger.kernel.org
Subject: [PATCH 1/6] dmaengine: add dmaengine_prep_dma_sg() helper
Date: Sat, 11 Oct 2014 21:16:43 +0530
Message-Id: <1413042408-28491-2-git-send-email-vinod.koul@intel.com>
In-Reply-To: <1413042408-28491-1-git-send-email-vinod.koul@intel.com>
References: <1413042408-28491-1-git-send-email-vinod.koul@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Zhang Wei <zw@zh-kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This was only prep API which didnt have an helper

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/linux/dmaengine.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 3d291f5..ce8a08e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -757,6 +757,16 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
 	return chan->device->device_prep_interleaved_dma(chan, xt, flags);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
+		struct dma_chan *chan,
+		struct scatterlist *dst_sg, unsigned int dst_nents,
+		struct scatterlist *src_sg, unsigned int src_nents,
+		unsigned long flags)
+{
+	return chan->device->device_prep_dma_sg(chan, dst_sg, dst_nents,
+			src_sg, src_nents, flags);
+}
+
 static inline int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 {
 	if (!chan || !caps)
-- 
1.7.0.4
