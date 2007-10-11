Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E29E3DDFFB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:00:33 +1000 (EST)
Date: Thu, 11 Oct 2007 14:55:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 4/7] [POWERPC] Remove more iSeries specific stuff from vio.c
Message-Id: <20071011145502.49a16436.sfr@canb.auug.org.au>
In-Reply-To: <20071011145332.e3638c2e.sfr@canb.auug.org.au>
References: <20071011144824.a5e3de59.sfr@canb.auug.org.au>
	<20071011145055.1de13742.sfr@canb.auug.org.au>
	<20071011145332.e3638c2e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c              |   78 ++++++++++---------------------
 arch/powerpc/platforms/iseries/iommu.c |   24 +++++++++-
 include/asm-powerpc/iseries/iommu.h    |    4 ++
 3 files changed, 52 insertions(+), 54 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index eaf7f69..b7c9e44 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -48,61 +48,33 @@ static struct vio_dev vio_bus_device  = { /* fake "parent" device */
 	.dev.bus = &vio_bus_type,
 };
 
-#ifdef CONFIG_PPC_ISERIES
-static struct iommu_table veth_iommu_table;
-struct iommu_table vio_iommu_table;
-
-static void __init iommu_vio_init(void)
-{
-	iommu_table_getparms_iSeries(255, 0, 0xff, &veth_iommu_table);
-	veth_iommu_table.it_size /= 2;
-	vio_iommu_table = veth_iommu_table;
-	vio_iommu_table.it_offset += veth_iommu_table.it_size;
-
-	if (!iommu_init_table(&veth_iommu_table, -1))
-		printk("Virtual Bus VETH TCE table failed.\n");
-	if (!iommu_init_table(&vio_iommu_table, -1))
-		printk("Virtual Bus VIO TCE table failed.\n");
-}
-#else
-static void __init iommu_vio_init(void)
-{
-}
-#endif
-
 static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 {
-#ifdef CONFIG_PPC_ISERIES
-	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
-		if (strcmp(dev->type, "network") == 0)
-			return &veth_iommu_table;
-		return &vio_iommu_table;
-	} else
-#endif
-	{
-		const unsigned char *dma_window;
-		struct iommu_table *tbl;
-		unsigned long offset, size;
-
-		dma_window = of_get_property(dev->dev.archdata.of_node,
-					  "ibm,my-dma-window", NULL);
-		if (!dma_window)
-			return NULL;
-
-		tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
-
-		of_parse_dma_window(dev->dev.archdata.of_node, dma_window,
-				    &tbl->it_index, &offset, &size);
-
-		/* TCE table size - measured in tce entries */
-		tbl->it_size = size >> IOMMU_PAGE_SHIFT;
-		/* offset for VIO should always be 0 */
-		tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
-		tbl->it_busno = 0;
-		tbl->it_type = TCE_VB;
-
-		return iommu_init_table(tbl, -1);
-	}
+	const unsigned char *dma_window;
+	struct iommu_table *tbl;
+	unsigned long offset, size;
+
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return vio_build_iommu_table_iseries(dev);
+
+	dma_window = of_get_property(dev->dev.archdata.of_node,
+				  "ibm,my-dma-window", NULL);
+	if (!dma_window)
+		return NULL;
+
+	tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
+
+	of_parse_dma_window(dev->dev.archdata.of_node, dma_window,
+			    &tbl->it_index, &offset, &size);
+
+	/* TCE table size - measured in tce entries */
+	tbl->it_size = size >> IOMMU_PAGE_SHIFT;
+	/* offset for VIO should always be 0 */
+	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
+	tbl->it_busno = 0;
+	tbl->it_type = TCE_VB;
+
+	return iommu_init_table(tbl, -1);
 }
 
 /**
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 3281f10..49e9c66 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 
 #include <asm/iommu.h>
+#include <asm/vio.h>
 #include <asm/tce.h>
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
@@ -191,7 +192,8 @@ void iommu_devnode_init_iSeries(struct pci_dev *pdev, struct device_node *dn)
 }
 #endif
 
-extern struct iommu_table vio_iommu_table;
+static struct iommu_table veth_iommu_table;
+static struct iommu_table vio_iommu_table;
 
 void *iseries_hv_alloc(size_t size, dma_addr_t *dma_handle, gfp_t flag)
 {
@@ -219,6 +221,26 @@ void iseries_hv_unmap(dma_addr_t dma_handle, size_t size,
 	iommu_unmap_single(&vio_iommu_table, dma_handle, size, direction);
 }
 
+void __init iommu_vio_init(void)
+{
+	iommu_table_getparms_iSeries(255, 0, 0xff, &veth_iommu_table);
+	veth_iommu_table.it_size /= 2;
+	vio_iommu_table = veth_iommu_table;
+	vio_iommu_table.it_offset += veth_iommu_table.it_size;
+
+	if (!iommu_init_table(&veth_iommu_table, -1))
+		printk("Virtual Bus VETH TCE table failed.\n");
+	if (!iommu_init_table(&vio_iommu_table, -1))
+		printk("Virtual Bus VIO TCE table failed.\n");
+}
+
+struct iommu_table *vio_build_iommu_table_iseries(struct vio_dev *dev)
+{
+	if (strcmp(dev->type, "network") == 0)
+		return &veth_iommu_table;
+	return &vio_iommu_table;
+}
+
 void iommu_init_early_iSeries(void)
 {
 	ppc_md.tce_build = tce_build_iSeries;
diff --git a/include/asm-powerpc/iseries/iommu.h b/include/asm-powerpc/iseries/iommu.h
index 6e323a1..c59ee7e 100644
--- a/include/asm-powerpc/iseries/iommu.h
+++ b/include/asm-powerpc/iseries/iommu.h
@@ -22,6 +22,7 @@
  */
 
 struct pci_dev;
+struct vio_dev;
 struct device_node;
 struct iommu_table;
 
@@ -34,4 +35,7 @@ extern void iommu_table_getparms_iSeries(unsigned long busno,
 		unsigned char slotno, unsigned char virtbus,
 		struct iommu_table *tbl);
 
+extern struct iommu_table *vio_build_iommu_table_iseries(struct vio_dev *dev);
+extern void iommu_vio_init(void);
+
 #endif /* _ASM_POWERPC_ISERIES_IOMMU_H */
-- 
1.5.3.4
