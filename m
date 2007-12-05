Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ed0aab681311a3c6d53354d39a6c4aea5b77b133.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/7] Use archdata.dma_data in dma_direct_ops
Date: Wed,  5 Dec 2007 18:21:00 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that all platforms using dma_direct_offset setup the archdata.dma_data
correctly, we can change the dma_direct_ops to retrieve the offset from
the dma_data, rather than directly from the global.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/dma_64.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
index 14206e3..19d5fb0 100644
--- a/arch/powerpc/kernel/dma_64.c
+++ b/arch/powerpc/kernel/dma_64.c
@@ -117,6 +117,18 @@ EXPORT_SYMBOL(dma_iommu_ops);
  */
 unsigned long dma_direct_offset;
 
+static unsigned long get_dma_direct_offset(struct device *dev)
+{
+	unsigned long *offset;
+
+	offset = dev->archdata.dma_data;
+
+	if (offset)
+		return *offset;
+
+	return 0;
+}
+
 static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
 {
@@ -130,7 +142,7 @@ static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	ret = page_address(page);
 	memset(ret, 0, size);
-	*dma_handle = virt_to_abs(ret) | dma_direct_offset;
+	*dma_handle = virt_to_abs(ret) | get_dma_direct_offset(dev);
 
 	return ret;
 }
@@ -145,7 +157,7 @@ static dma_addr_t dma_direct_map_single(struct device *dev, void *ptr,
 					size_t size,
 					enum dma_data_direction direction)
 {
-	return virt_to_abs(ptr) | dma_direct_offset;
+	return virt_to_abs(ptr) | get_dma_direct_offset(dev);
 }
 
 static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
@@ -161,7 +173,7 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg) | dma_direct_offset;
+		sg->dma_address = sg_phys(sg) | get_dma_direct_offset(dev);
 		sg->dma_length = sg->length;
 	}
 
-- 
1.5.3.7.1.g4e596e
