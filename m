Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B63CB6F76
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 14:00:51 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Subject: [PATCH v4 3/3] powerpc: Dont require a dma_ops struct to set dma mask
Date: Thu,  7 Jul 2011 23:00:43 -0500
Message-Id: <1310097643-8414-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1310097643-8414-2-git-send-email-galak@kernel.crashing.org>
References: <1310097643-8414-1-git-send-email-galak@kernel.crashing.org>
	<1310097643-8414-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
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
	platform_device_add(pdev);

And expect the right thing to happen with the bus notifiers get called
via platform_device_add.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/dma.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index d238c08..4f0959f 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -161,9 +161,7 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 
 	if (ppc_md.dma_set_mask)
 		return ppc_md.dma_set_mask(dev, dma_mask);
-	if (unlikely(dma_ops == NULL))
-		return -EIO;
-	if (dma_ops->set_dma_mask != NULL)
+	if ((dma_ops != NULL) && (dma_ops->set_dma_mask != NULL))
 		return dma_ops->set_dma_mask(dev, dma_mask);
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
-- 
1.7.3.4
