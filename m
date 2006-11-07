Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:59 +1100
Subject: [PATCH 26/31] powerpc: Make direct DMA use node local allocations
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072416.F17DC688E9@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes dma_alloc_coherent() use node local allocation when
using the direct DMA ops. The node is obtained from the new device
extension. If no such extension is present, the current node is used.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/dma_64.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

Index: linux-cell/arch/powerpc/kernel/dma_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/dma_64.c	2006-11-07 16:59:46.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/dma_64.c	2006-11-07 17:00:01.000000000 +1100
@@ -143,14 +143,22 @@ unsigned long dma_direct_offset;
 static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
 {
+	struct device_ext *dext = device_get_ext(dev);
+	struct page *page;
 	void *ret;
+	int node = -1;
+
+	if (dext != NULL)
+		node = dext->numa_node;
 
 	/* TODO: Maybe use the numa node here too ? */
-	ret = (void *)__get_free_pages(flag, get_order(size));
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_abs(ret) | dma_direct_offset;
-	}
+	page = alloc_pages_node(node, flag, get_order(size));
+	if (page == NULL)
+		return NULL;
+	ret = page_address(page);
+	memset(ret, 0, size);
+	*dma_handle = virt_to_abs(ret) | dma_direct_offset;
+
 	return ret;
 }
 
