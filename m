Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09E08B6EF2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 08:39:08 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, vinod.koul@intel.com,
 dan.j.williams@intel.com
Subject: [RFC] dmaengine/dma_slave: add context parameter to prep_slave_sg
 callback
Date: Thu, 26 Jan 2012 16:22:26 -0500
Message-Id: <1327612946-29397-1-git-send-email-alexandre.bounine@idt.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we agreed during our discussion about adding DMA Engine support for RapidIO
subsystem, RapidIO and similar clients may benefit from adding an extra context
parameter to device_prep_slave_sg() callback.
See https://lkml.org/lkml/2011/10/24/275 for more details.

Adding the context parameter will allow to pass client/target specific
information associated with an individual data transfer request.

In the case of RapidIO support this additional information consists of target
destination ID and its buffer address (which is not mapped into the local CPU
memory space). Because a single RapidIO-capable DMA channel may queue data
transfer requests to different target devices, the per-request configuration
is required.

The proposed change eliminates need for new subsystem-specific API.
Existing DMA_SLAVE clients will ignore the new parameter.

This RFC only demonstrates the API change and does not include corresponding
changes to existing DMA_SLAVE clients. Complete set of patches will be provided
after (if) this API change is accepted.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Russell King <rmk@arm.linux.org.uk> 
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
---
 include/linux/dmaengine.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 679b349..79d71bb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -575,7 +575,7 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
-		unsigned long flags);
+		unsigned long flags, void *context);
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction);
@@ -607,12 +607,13 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
 	struct dma_chan *chan, void *buf, size_t len,
-	enum dma_transfer_direction dir, unsigned long flags)
+	enum dma_transfer_direction dir, unsigned long flags, void *context)
 {
 	struct scatterlist sg;
 	sg_init_one(&sg, buf, len);
 
-	return chan->device->device_prep_slave_sg(chan, &sg, 1, dir, flags);
+	return chan->device->device_prep_slave_sg(chan, &sg, 1, dir, flags,
+						  context);
 }
 
 static inline int dmaengine_terminate_all(struct dma_chan *chan)
-- 
1.7.8.4
