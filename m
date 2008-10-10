Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Oct 2008 14:06:24 +1100
Subject: [PATCH] powerpc: Fix DMA offset for non-coherent DMA
Message-Id: <20081010030653.5AE1CDDEF9@ozlabs.org>
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

v2. This one fixes a typo that I introduced when rebasing/cleaning
    up a larger patch to produce this one that causes void *ret to
    be defined twice for coherent platforms


 arch/powerpc/kernel/dma.c          |    8 ++++++--
 arch/powerpc/lib/dma-noncoherent.c |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/dma.c	2008-10-10 14:04:08.000000000 +1100
+++ linux-work/arch/powerpc/kernel/dma.c	2008-10-10 14:04:30.000000000 +1100
@@ -30,11 +30,15 @@ static unsigned long get_dma_direct_offs
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
-	void *ret;
 	int node = dev_to_node(dev);
 
 	/* ignore region specifiers */
Index: linux-work/arch/powerpc/lib/dma-noncoherent.c
===================================================================
--- linux-work.orig/arch/powerpc/lib/dma-noncoherent.c	2008-10-10 14:04:08.000000000 +1100
+++ linux-work/arch/powerpc/lib/dma-noncoherent.c	2008-10-10 14:04:12.000000000 +1100
@@ -203,7 +203,7 @@ __dma_alloc_coherent(size_t size, dma_ad
 		/*
 		 * Set the "dma handle"
 		 */
-		*handle = page_to_bus(page);
+		*handle = page_to_phys(page);
 
 		do {
 			BUG_ON(!pte_none(*pte));
