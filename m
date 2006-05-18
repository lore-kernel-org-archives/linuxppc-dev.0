Return-Path: <jk@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 18 May 2006 18:06:37 +1000
Subject: [PATCH] powerpc: pseries: Use generic dma-window parsing function
In-Reply-To: <1147933975.516311.850847048300.qpush@pokey>
Message-Id: <1147939597.732602.287255038873.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the pseries iommu init code to use the new of_parse_dma_window()
to parse the ibm,dma-window and ibm,my-dma-window properties of pci and
virtual device nodes.

Also, clean up vio_build_iommu_table() a little.

Tested on pseries, with both vio and pci devices.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
Update: rebase to current powerpc head: vio driver has been merged

 arch/powerpc/kernel/vio.c              |   36 ++++++++++++---------------------
 arch/powerpc/platforms/pseries/iommu.c |   29 +++++++++-----------------
 2 files changed, 24 insertions(+), 41 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/iommu.c
+++ linux-2.6/arch/powerpc/platforms/pseries/iommu.c
@@ -281,30 +281,22 @@ static void iommu_table_setparms(struct 
  * iommu_table_setparms_lpar
  *
  * Function: On pSeries LPAR systems, return TCE table info, given a pci bus.
- *
- * ToDo: properly interpret the ibm,dma-window property.  The definition is:
- *	logical-bus-number	(1 word)
- *	phys-address		(#address-cells words)
- *	size			(#cell-size words)
- *
- * Currently we hard code these sizes (more or less).
  */
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct device_node *dn,
 				      struct iommu_table *tbl,
-				      unsigned int *dma_window)
+				      unsigned char *dma_window)
 {
+	unsigned long offset, size;
+
 	tbl->it_busno  = PCI_DN(dn)->bussubno;
+	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
 
-	/* TODO: Parse field size properties properly. */
-	tbl->it_size   = (((unsigned long)dma_window[4] << 32) |
-			   (unsigned long)dma_window[5]) >> PAGE_SHIFT;
-	tbl->it_offset = (((unsigned long)dma_window[2] << 32) |
-			   (unsigned long)dma_window[3]) >> PAGE_SHIFT;
 	tbl->it_base   = 0;
-	tbl->it_index  = dma_window[0];
 	tbl->it_blocksize  = 16;
 	tbl->it_type = TCE_PCI;
+	tbl->it_offset = offset >> PAGE_SHIFT;
+	tbl->it_size = size >> PAGE_SHIFT;
 }
 
 static void iommu_bus_setup_pSeries(struct pci_bus *bus)
@@ -396,7 +388,7 @@ static void iommu_bus_setup_pSeriesLP(st
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	unsigned int *dma_window = NULL;
+	unsigned char *dma_window = NULL;
 
 	DBG("iommu_bus_setup_pSeriesLP, bus %p, bus->self %p\n", bus, bus->self);
 
@@ -404,7 +396,7 @@ static void iommu_bus_setup_pSeriesLP(st
 
 	/* Find nearest ibm,dma-window, walking up the device tree */
 	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
-		dma_window = (unsigned int *)get_property(pdn, "ibm,dma-window", NULL);
+		dma_window = get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window != NULL)
 			break;
 	}
@@ -498,7 +490,7 @@ static void iommu_dev_setup_pSeriesLP(st
 {
 	struct device_node *pdn, *dn;
 	struct iommu_table *tbl;
-	int *dma_window = NULL;
+	unsigned char *dma_window = NULL;
 	struct pci_dn *pci;
 
 	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, pci_name(dev));
@@ -513,8 +505,7 @@ static void iommu_dev_setup_pSeriesLP(st
 
 	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
 	     pdn = pdn->parent) {
-		dma_window = (unsigned int *)
-			get_property(pdn, "ibm,dma-window", NULL);
+		dma_window = get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window)
 			break;
 	}
Index: linux-2.6/arch/powerpc/kernel/vio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/vio.c
+++ linux-2.6/arch/powerpc/kernel/vio.c
@@ -77,36 +77,28 @@ static struct iommu_table *vio_build_iom
 	} else
 #endif
 	{
-		unsigned int *dma_window;
-		struct iommu_table *newTceTable;
-		unsigned long offset;
-		int dma_window_property_size;
-
-		dma_window = (unsigned int *)get_property(
-				dev->dev.platform_data, "ibm,my-dma-window",
-				&dma_window_property_size);
+		unsigned char *dma_window;
+		struct iommu_table *tbl;
+		unsigned long offset, size;
+
+		dma_window = get_property(dev->dev.platform_data,
+				"ibm,my-dma-window", NULL);
 		if (!dma_window)
 			return NULL;
 
-		newTceTable = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
+		tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
 
-		/*
-		 * There should be some code to extract the phys-encoded
-		 * offset using prom_n_addr_cells(). However, according to
-		 * a comment on earlier versions, it's always zero, so we
-		 * don't bother
-		 */
-		offset = dma_window[1] >>  PAGE_SHIFT;
+		of_parse_dma_window(dev->dev.platform_data, dma_window,
+				&tbl->it_index, &offset, &size);
 
 		/* TCE table size - measured in tce entries */
-		newTceTable->it_size = dma_window[4] >> PAGE_SHIFT;
+		tbl->it_size = size >> PAGE_SHIFT;
 		/* offset for VIO should always be 0 */
-		newTceTable->it_offset = offset;
-		newTceTable->it_busno = 0;
-		newTceTable->it_index = (unsigned long)dma_window[0];
-		newTceTable->it_type = TCE_VB;
+		tbl->it_offset = offset >> PAGE_SHIFT;
+		tbl->it_busno = 0;
+		tbl->it_type = TCE_VB;
 
-		return iommu_init_table(newTceTable);
+		return iommu_init_table(tbl);
 	}
 }
 
