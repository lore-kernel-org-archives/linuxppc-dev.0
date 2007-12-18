Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 19E30DDEE1
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 05:15:07 +1100 (EST)
Message-Id: <20071218175104.638243000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:48:58 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 06/18] Use archdata.dma_data in dma_direct_ops
Cc: linuxppc-dev@ozlabs.org
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/dma_64.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

Index: linux-2.6-new/arch/powerpc/kernel/dma_64.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/kernel/dma_64.c
+++ linux-2.6-new/arch/powerpc/kernel/dma_64.c
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
@@ -130,7 +142,7 @@ static void *dma_direct_alloc_coherent(s
 		return NULL;
 	ret = page_address(page);
 	memset(ret, 0, size);
-	*dma_handle = virt_to_abs(ret) | dma_direct_offset;
+	*dma_handle = virt_to_abs(ret) | get_dma_direct_offset(dev);
 
 	return ret;
 }
@@ -145,7 +157,7 @@ static dma_addr_t dma_direct_map_single(
 					size_t size,
 					enum dma_data_direction direction)
 {
-	return virt_to_abs(ptr) | dma_direct_offset;
+	return virt_to_abs(ptr) | get_dma_direct_offset(dev);
 }
 
 static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
@@ -161,7 +173,7 @@ static int dma_direct_map_sg(struct devi
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg) | dma_direct_offset;
+		sg->dma_address = sg_phys(sg) | get_dma_direct_offset(dev);
 		sg->dma_length = sg->length;
 	}
 

-- 
