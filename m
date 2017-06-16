Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq7jV1YKLzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 04:11:26 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 03/44] dmaengine: ioat: don't use DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:18 +0200
Message-Id: <20170616181059.19206-4-hch@lst.de>
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DMA_ERROR_CODE is not a public API and will go away.  Instead properly
unwind based on the loop counter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/ioat/init.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 6ad4384b3fa8..ed8ed1192775 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -839,8 +839,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 		goto free_resources;
 	}
 
-	for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
-		dma_srcs[i] = DMA_ERROR_CODE;
 	for (i = 0; i < IOAT_NUM_SRC_TEST; i++) {
 		dma_srcs[i] = dma_map_page(dev, xor_srcs[i], 0, PAGE_SIZE,
 					   DMA_TO_DEVICE);
@@ -910,8 +908,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 
 	xor_val_result = 1;
 
-	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
-		dma_srcs[i] = DMA_ERROR_CODE;
 	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
 		dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
 					   DMA_TO_DEVICE);
@@ -965,8 +961,6 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 	op = IOAT_OP_XOR_VAL;
 
 	xor_val_result = 0;
-	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
-		dma_srcs[i] = DMA_ERROR_CODE;
 	for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++) {
 		dma_srcs[i] = dma_map_page(dev, xor_val_srcs[i], 0, PAGE_SIZE,
 					   DMA_TO_DEVICE);
@@ -1017,18 +1011,14 @@ static int ioat_xor_val_self_test(struct ioatdma_device *ioat_dma)
 	goto free_resources;
 dma_unmap:
 	if (op == IOAT_OP_XOR) {
-		if (dest_dma != DMA_ERROR_CODE)
-			dma_unmap_page(dev, dest_dma, PAGE_SIZE,
-				       DMA_FROM_DEVICE);
-		for (i = 0; i < IOAT_NUM_SRC_TEST; i++)
-			if (dma_srcs[i] != DMA_ERROR_CODE)
-				dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
-					       DMA_TO_DEVICE);
+		while (--i >= 0)
+			dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
+				       DMA_TO_DEVICE);
+		dma_unmap_page(dev, dest_dma, PAGE_SIZE, DMA_FROM_DEVICE);
 	} else if (op == IOAT_OP_XOR_VAL) {
-		for (i = 0; i < IOAT_NUM_SRC_TEST + 1; i++)
-			if (dma_srcs[i] != DMA_ERROR_CODE)
-				dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
-					       DMA_TO_DEVICE);
+		while (--i >= 0)
+			dma_unmap_page(dev, dma_srcs[i], PAGE_SIZE,
+				       DMA_TO_DEVICE);
 	}
 free_resources:
 	dma->device_free_chan_resources(dma_chan);
-- 
2.11.0
