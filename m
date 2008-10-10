Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Oct 2008 13:52:29 +1100
Subject: [PATCH] powerpc: Fix DMA offset for non-coherent DMA
Message-Id: <20081010025257.9E08CDDEFB@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After Becky's work we can almost have different DMA offsets
between on-chip devices and PCI. Almost because there's a
problem with the non-coherent DMA code that basically ignores
the programmed offset to use the global one for everything.
This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/dma.c          |    7 ++++++-
 arch/powerpc/lib/dma-noncoherent.c |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/dma.c	2008-10-10 10:51:22.000000000 +1100
+++ linux-work/arch/powerpc/kernel/dma.c	2008-10-10 10:51:57.000000000 +1100
@@ -30,8 +30,13 @@ static unsigned long get_dma_direct_offs
 void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t flag)
 {
+	void *ret;
 #ifdef CONFIG_NOT_COHERENT_CACHE
-	return __dma_alloc_coherent(size, dma_handle, flag);
+	ret = __dma_alloc_coherent(size, dma_handle, flag);
+	if (ret == NULL)
+		return NULL;
+	*dma_handle += get_dma_direct_offset(dev);
+	return ret;
 #else
 	struct page *page;
 	void *ret;
Index: linux-work/arch/powerpc/lib/dma-noncoherent.c
===================================================================
--- linux-work.orig/arch/powerpc/lib/dma-noncoherent.c	2008-10-10 10:52:17.000000000 +1100
+++ linux-work/arch/powerpc/lib/dma-noncoherent.c	2008-10-10 10:52:21.000000000 +1100
@@ -203,7 +203,7 @@ __dma_alloc_coherent(size_t size, dma_ad
 		/*
 		 * Set the "dma handle"
 		 */
-		*handle = page_to_bus(page);
+		*handle = page_to_phys(page);
 
 		do {
 			BUG_ON(!pte_none(*pte));
