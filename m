Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 20:58:08 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: node local IOMMU tables
Message-ID: <20060610105808.GN23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Allocate IOMMU tables node local.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/iommu.c
===================================================================
--- build.orig/arch/powerpc/kernel/iommu.c	2006-05-27 10:01:01.000000000 +1000
+++ build/arch/powerpc/kernel/iommu.c	2006-05-27 10:05:56.000000000 +1000
@@ -418,10 +418,11 @@ void iommu_unmap_sg(struct iommu_table *
  * Build a iommu_table structure.  This contains a bit map which
  * is used to manage allocation of the tce space.
  */
-struct iommu_table *iommu_init_table(struct iommu_table *tbl)
+struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 {
 	unsigned long sz;
 	static int welcomed = 0;
+	struct page *page;
 
 	/* Set aside 1/4 of the table for large allocations. */
 	tbl->it_halfpoint = tbl->it_size * 3 / 4;
@@ -429,10 +430,10 @@ struct iommu_table *iommu_init_table(str
 	/* number of bytes needed for the bitmap */
 	sz = (tbl->it_size + 7) >> 3;
 
-	tbl->it_map = (unsigned long *)__get_free_pages(GFP_ATOMIC, get_order(sz));
-	if (!tbl->it_map)
+	page = alloc_pages_node(nid, GFP_ATOMIC, get_order(sz));
+	if (!page)
 		panic("iommu_init_table: Can't allocate %ld bytes\n", sz);
-
+	tbl->it_map = page_address(page);
 	memset(tbl->it_map, 0, sz);
 
 	tbl->it_hint = 0;
Index: build/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/iommu.c	2006-05-27 10:02:39.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/iommu.c	2006-05-27 10:08:16.000000000 +1000
@@ -368,10 +368,11 @@ static void iommu_bus_setup_pSeries(stru
 	pci->phb->dma_window_size = 0x8000000ul;
 	pci->phb->dma_window_base_cur = 0x8000000ul;
 
-	tbl = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
+	tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+			   pci->phb->node);
 
 	iommu_table_setparms(pci->phb, dn, tbl);
-	pci->iommu_table = iommu_init_table(tbl);
+	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -414,12 +415,12 @@ static void iommu_bus_setup_pSeriesLP(st
 
 		ppci->bussubno = bus->number;
 
-		tbl = (struct iommu_table *)kmalloc(sizeof(struct iommu_table),
-						    GFP_KERNEL);
+		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+				   ppci->phb->node);
 
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 
-		ppci->iommu_table = iommu_init_table(tbl);
+		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
 	}
 
 	if (pdn != dn)
@@ -442,9 +443,11 @@ static void iommu_dev_setup_pSeries(stru
 	 */
 	if (!dev->bus->self) {
 		DBG(" --> first child, no bridge. Allocating iommu table.\n");
-		tbl = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
+		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+				   PCI_DN(dn)->phb->node);
 		iommu_table_setparms(PCI_DN(dn)->phb, dn, tbl);
-		PCI_DN(mydn)->iommu_table = iommu_init_table(tbl);
+		PCI_DN(dn)->iommu_table = iommu_init_table(tbl,
+						PCI_DN(dn)->phb->node);
 
 		return;
 	}
@@ -526,12 +529,12 @@ static void iommu_dev_setup_pSeriesLP(st
 		/* iommu_table_setparms_lpar needs bussubno. */
 		pci->bussubno = pci->phb->bus->number;
 
-		tbl = (struct iommu_table *)kmalloc(sizeof(struct iommu_table),
-						    GFP_KERNEL);
+		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
+				   pci->phb->node);
 
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 
-		pci->iommu_table = iommu_init_table(tbl);
+		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
 	}
 
 	if (pdn != dn)
Index: build/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- build.orig/arch/powerpc/sysdev/dart_iommu.c	2006-05-27 10:01:01.000000000 +1000
+++ build/arch/powerpc/sysdev/dart_iommu.c	2006-05-27 10:05:56.000000000 +1000
@@ -246,7 +246,7 @@ static void iommu_table_dart_setup(void)
 	iommu_table_dart.it_base = (unsigned long)dart_vbase;
 	iommu_table_dart.it_index = 0;
 	iommu_table_dart.it_blocksize = 1;
-	iommu_init_table(&iommu_table_dart);
+	iommu_init_table(&iommu_table_dart, -1);
 
 	/* Reserve the last page of the DART to avoid possible prefetch
 	 * past the DART mapped area
Index: build/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- build.orig/arch/powerpc/platforms/iseries/iommu.c	2006-05-27 10:02:39.000000000 +1000
+++ build/arch/powerpc/platforms/iseries/iommu.c	2006-05-27 10:05:56.000000000 +1000
@@ -173,7 +173,7 @@ void iommu_devnode_init_iSeries(struct d
 	/* Look for existing tce table */
 	pdn->iommu_table = iommu_table_find(tbl);
 	if (pdn->iommu_table == NULL)
-		pdn->iommu_table = iommu_init_table(tbl);
+		pdn->iommu_table = iommu_init_table(tbl, -1);
 	else
 		kfree(tbl);
 }
Index: build/include/asm-powerpc/iommu.h
===================================================================
--- build.orig/include/asm-powerpc/iommu.h	2006-05-27 10:01:01.000000000 +1000
+++ build/include/asm-powerpc/iommu.h	2006-05-27 10:05:56.000000000 +1000
@@ -67,7 +67,8 @@ extern void iommu_free_table(struct devi
 /* Initializes an iommu_table based in values set in the passed-in
  * structure
  */
-extern struct iommu_table *iommu_init_table(struct iommu_table * tbl);
+extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
+					    int nid);
 
 extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		struct scatterlist *sglist, int nelems, unsigned long mask,
Index: build/arch/powerpc/kernel/vio.c
===================================================================
--- build.orig/arch/powerpc/kernel/vio.c	2006-05-27 10:02:39.000000000 +1000
+++ build/arch/powerpc/kernel/vio.c	2006-05-27 10:09:21.000000000 +1000
@@ -60,9 +60,9 @@ static void __init iommu_vio_init(void)
 	vio_iommu_table = veth_iommu_table;
 	vio_iommu_table.it_offset += veth_iommu_table.it_size;
 
-	if (!iommu_init_table(&veth_iommu_table))
+	if (!iommu_init_table(&veth_iommu_table, -1))
 		printk("Virtual Bus VETH TCE table failed.\n");
-	if (!iommu_init_table(&vio_iommu_table))
+	if (!iommu_init_table(&vio_iommu_table, -1))
 		printk("Virtual Bus VIO TCE table failed.\n");
 }
 #endif
@@ -98,7 +98,7 @@ static struct iommu_table *vio_build_iom
 		tbl->it_busno = 0;
 		tbl->it_type = TCE_VB;
 
-		return iommu_init_table(tbl);
+		return iommu_init_table(tbl, -1);
 	}
 }
 
