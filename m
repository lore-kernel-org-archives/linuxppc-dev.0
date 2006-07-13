Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: simplify dma_ops bug conditions
Message-Id: <20060713063252.1D35867B58@ozlabs.org>
Date: Thu, 13 Jul 2006 16:32:52 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use BUG_ON rather than BUG to simplify the dma_ops handing,
and remove the now-unnecessary return cases.

Booted on pseries.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---

 dma_64.c |   65 +++++++++++++++++++++++++++------------------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/dma_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/dma_64.c
+++ linux-2.6/arch/powerpc/kernel/dma_64.c
@@ -35,10 +35,9 @@ int dma_supported(struct device *dev, u6
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		return dma_ops->dma_supported(dev, mask);
-	BUG();
-	return 0;
+	BUG_ON(!dma_ops);
+
+	return dma_ops->dma_supported(dev, mask);
 }
 EXPORT_SYMBOL(dma_supported);
 
@@ -66,10 +65,9 @@ void *dma_alloc_coherent(struct device *
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		return dma_ops->alloc_coherent(dev, size, dma_handle, flag);
-	BUG();
-	return NULL;
+	BUG_ON(!dma_ops);
+
+	return dma_ops->alloc_coherent(dev, size, dma_handle, flag);
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
 
@@ -78,10 +76,9 @@ void dma_free_coherent(struct device *de
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
-	else
-		BUG();
+	BUG_ON(!dma_ops);
+
+	dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
 }
 EXPORT_SYMBOL(dma_free_coherent);
 
@@ -90,10 +87,9 @@ dma_addr_t dma_map_single(struct device 
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		return dma_ops->map_single(dev, cpu_addr, size, direction);
-	BUG();
-	return (dma_addr_t)0;
+	BUG_ON(!dma_ops);
+
+	return dma_ops->map_single(dev, cpu_addr, size, direction);
 }
 EXPORT_SYMBOL(dma_map_single);
 
@@ -102,10 +98,9 @@ void dma_unmap_single(struct device *dev
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		dma_ops->unmap_single(dev, dma_addr, size, direction);
-	else
-		BUG();
+	BUG_ON(!dma_ops);
+
+	dma_ops->unmap_single(dev, dma_addr, size, direction);
 }
 EXPORT_SYMBOL(dma_unmap_single);
 
@@ -115,11 +110,10 @@ dma_addr_t dma_map_page(struct device *d
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		return dma_ops->map_single(dev,
-				(page_address(page) + offset), size, direction);
-	BUG();
-	return (dma_addr_t)0;
+	BUG_ON(!dma_ops);
+
+	return dma_ops->map_single(dev, page_address(page) + offset, size,
+			direction);
 }
 EXPORT_SYMBOL(dma_map_page);
 
@@ -128,10 +122,9 @@ void dma_unmap_page(struct device *dev, 
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		dma_ops->unmap_single(dev, dma_address, size, direction);
-	else
-		BUG();
+	BUG_ON(!dma_ops);
+
+	dma_ops->unmap_single(dev, dma_address, size, direction);
 }
 EXPORT_SYMBOL(dma_unmap_page);
 
@@ -140,10 +133,9 @@ int dma_map_sg(struct device *dev, struc
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		return dma_ops->map_sg(dev, sg, nents, direction);
-	BUG();
-	return 0;
+	BUG_ON(!dma_ops);
+
+	return dma_ops->map_sg(dev, sg, nents, direction);
 }
 EXPORT_SYMBOL(dma_map_sg);
 
@@ -152,9 +144,8 @@ void dma_unmap_sg(struct device *dev, st
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	if (dma_ops)
-		dma_ops->unmap_sg(dev, sg, nhwentries, direction);
-	else
-		BUG();
+	BUG_ON(!dma_ops);
+
+	dma_ops->unmap_sg(dev, sg, nhwentries, direction);
 }
 EXPORT_SYMBOL(dma_unmap_sg);
