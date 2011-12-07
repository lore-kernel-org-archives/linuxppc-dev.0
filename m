Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC6C61007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 04:19:54 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pB7HJper026547
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Dec 2011 11:19:51 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix swiotlb ops for ppc64
Date: Wed,  7 Dec 2011 11:19:51 -0600
Message-Id: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We assumed before that alloc_coherent & free_coherent ops would always
be direct because of 32-bit systems and how we utilize highmem & lowmem.
However, on 64-bit systems we typically treat all memory as lowmem so
the same assumptions are not valid.  We need to utilze the swiotlb
versions of alloc_coherent & free_coherent on 64-bit systems.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/dma-swiotlb.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 1ebc918..5000fd4 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -40,15 +40,20 @@ static u64 swiotlb_powerpc_get_required(struct device *dev)
 }
 
 /*
- * At the moment, all platforms that use this code only require
- * swiotlb to be used if we're operating on HIGHMEM.  Since
+ * We assume that 32-bit systems will utilize HIGHMEM and that we're
+ * able to DMA directly to anything in the LOWMEM region. Since
  * we don't ever call anything other than map_sg, unmap_sg,
  * map_page, and unmap_page on highmem, use normal dma_ops
  * for everything else.
  */
 struct dma_map_ops swiotlb_dma_ops = {
+#ifdef CONFIG_PPC64
+	.alloc_coherent = swiotlb_alloc_coherent,
+	.free_coherent = swiotlb_free_coherent,
+#else
 	.alloc_coherent = dma_direct_alloc_coherent,
 	.free_coherent = dma_direct_free_coherent,
+#endif
 	.map_sg = swiotlb_map_sg_attrs,
 	.unmap_sg = swiotlb_unmap_sg_attrs,
 	.dma_supported = swiotlb_dma_supported,
-- 
1.7.3.4
