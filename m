Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52DA1B70D4
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 03:21:26 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o72HLMAQ030440
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 12:21:23 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Dont require a dma_ops struct to set dma mask
Date: Mon,  2 Aug 2010 12:21:22 -0500
Message-Id: <1280769682-2839-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only reason to require a dma_ops struct is to see if it has
implemented set_dma_mask.  If not we can fall back to setting the mask
directly.

This resolves an issue with how to sequence the setting of a DMA mask
for platform devices.  Before we had an issue in that we have no way of
setting the DMA mask before the various low level bus notifiers get
called that might check it (swiotlb).

So now we can do:

	pdev = platform_device_alloc("foobar", 0);
	dma_set_mask(&pdev->dev, DMA_BIT_MASK(37));
	platform_device_register(pdev);

And expect the right thing to happen with the bus notifiers get called
via platform_device_register.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-mapping.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index c85ef23..17d5c17 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -131,9 +131,7 @@ static inline int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
-	if (unlikely(dma_ops == NULL))
-		return -EIO;
-	if (dma_ops->set_dma_mask != NULL)
+	if (unlikely(dma_ops == NULL) && (dma_ops->set_dma_mask != NULL))
 		return dma_ops->set_dma_mask(dev, dma_mask);
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
-- 
1.6.0.6
