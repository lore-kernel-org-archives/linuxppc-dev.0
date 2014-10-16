Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8EC41A02B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 17:47:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2] powerpc: Only do dynamic DMA zone limits on platforms that
 need it
Date: Thu, 16 Oct 2014 17:47:48 +1100
Message-Id: <1413442068-5957-1-git-send-email-mpe@ellerman.id.au>
Cc: scottwood@freescale.com, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott's patch 1c98025c6c95 "Dynamic DMA zone limits" changed
dma_direct_alloc_coherent() to start using dev->coherent_dma_mask.

That seems fair enough, but it exposes the fact that some of the drivers
we care about on IBM platforms aren't setting the coherent mask.

The proper fix is to have drivers set the coherent mask and also have
the platform code honor it.

For now, just restrict the dynamic DMA zone limits to the platforms that
need it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

v2: Use FSL_SOC.

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index adac9dc54aee..484b2d4462c1 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -53,9 +53,16 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 #else
 	struct page *page;
 	int node = dev_to_node(dev);
+#ifdef CONFIG_FSL_SOC
 	u64 pfn = get_pfn_limit(dev);
 	int zone;
 
+	/*
+	 * This code should be OK on other platforms, but we have drivers that
+	 * don't set coherent_dma_mask. As a workaround we just ifdef it. This
+	 * whole routine needs some serious cleanup.
+	 */
+
 	zone = dma_pfn_limit_to_zone(pfn);
 	if (zone < 0) {
 		dev_err(dev, "%s: No suitable zone for pfn %#llx\n",
@@ -73,6 +80,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 		break;
 #endif
 	};
+#endif /* CONFIG_FSL_SOC */
 
 	/* ignore region specifiers */
 	flag  &= ~(__GFP_HIGHMEM);
-- 
1.9.1
