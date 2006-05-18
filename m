Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 18 May 2006 16:20:51 +1000
Subject: [PATCH 1/2] powerpc: Add of_parse_dma_window()
Message-Id: <1147933251.463191.267166640873.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a function for generic parsing of dma-window properties (ie,
ibm,dma-window and ibm,my-dma-window) of pci and virtual device nodes.

This function will also be used by cell.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

 arch/powerpc/kernel/prom_parse.c |   23 +++++++++++++++++++++++
 include/asm-powerpc/prom.h       |    6 ++++++
 2 files changed, 29 insertions(+)

Index: linux-2.6/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom_parse.c
+++ linux-2.6/arch/powerpc/kernel/prom_parse.c
@@ -548,3 +548,26 @@ int of_pci_address_to_resource(struct de
 	return __of_address_to_resource(dev, addrp, size, flags, r);
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
+
+void of_parse_dma_window(struct device_node *dn, unsigned char *dma_window_prop,
+		unsigned long *busno, unsigned long *phys, unsigned long *size)
+{
+	u32 *dma_window, cells;
+	unsigned char *prop;
+
+	dma_window = (u32 *)dma_window_prop;
+
+	/* busno is always one cell */
+	*busno = *(dma_window++);
+
+	prop = get_property(dn, "ibm,#dma-address-cells", NULL);
+	cells = prop ? *(u32 *)prop : prom_n_addr_cells(dn);
+	*phys = of_read_addr(dma_window, cells);
+
+	dma_window += cells;
+
+	prop = get_property(dn, "ibm,#dma-size-cells", NULL);
+	cells = prop ? *(u32 *)prop : prom_n_size_cells(dn);
+	*size = of_read_addr(dma_window, cells);
+}
+EXPORT_SYMBOL_GPL(of_parse_dma_window);
Index: linux-2.6/include/asm-powerpc/prom.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/prom.h
+++ linux-2.6/include/asm-powerpc/prom.h
@@ -230,6 +230,12 @@ extern int of_address_to_resource(struct
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
 
+/* Parse the ibm,dma-window property of an OF node into the busno, phys and
+ * size parameters.
+ */
+void of_parse_dma_window(struct device_node *dn, unsigned char *dma_window_prop,
+		unsigned long *busno, unsigned long *phys, unsigned long *size);
+
 extern void kdump_move_device_tree(void);
 
 #endif /* __KERNEL__ */

To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 18 May 2006 16:20:51 +1000
Subject: [PATCH 2/2] powerpc: pseries: Use generic dma-window parsing function
Message-Id: <1147933251.472945.297063284077.qpush@pokey>

Change the pseries iommu init code to use the new of_parse_dma_window()
to parse the ibm,dma-window and ibm,my-dma-window properties of pci and
virtual device nodes.

Also, clean up vio_build_iommu_table() a little.

Tested on pseries, with both vio and pci devices.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

 arch/powerpc/platforms/pseries/iommu.c |   29 ++++++++++-------------------
 arch/powerpc/platforms/pseries/vio.c   |   32 ++++++++++++++------------------
 2 files changed, 24 insertions(+), 37 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/iommu.c
+++ linux-2.6/arch/powerpc/platforms/pseries/iommu.c
@@ -299,30 +299,22 @@ static void iommu_table_setparms(struct 
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
@@ -414,7 +406,7 @@ static void iommu_bus_setup_pSeriesLP(st
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	unsigned int *dma_window = NULL;
+	unsigned char *dma_window = NULL;
 
 	DBG("iommu_bus_setup_pSeriesLP, bus %p, bus->self %p\n", bus, bus->self);
 
@@ -422,7 +414,7 @@ static void iommu_bus_setup_pSeriesLP(st
 
 	/* Find nearest ibm,dma-window, walking up the device tree */
 	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
-		dma_window = (unsigned int *)get_property(pdn, "ibm,dma-window", NULL);
+		dma_window = get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window != NULL)
 			break;
 	}
@@ -516,7 +508,7 @@ static void iommu_dev_setup_pSeriesLP(st
 {
 	struct device_node *pdn, *dn;
 	struct iommu_table *tbl;
-	int *dma_window = NULL;
+	unsigned char *dma_window = NULL;
 	struct pci_dn *pci;
 
 	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, pci_name(dev));
@@ -531,8 +523,7 @@ static void iommu_dev_setup_pSeriesLP(st
 
 	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
 	     pdn = pdn->parent) {
-		dma_window = (unsigned int *)
-			get_property(pdn, "ibm,dma-window", NULL);
+		dma_window = get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window)
 			break;
 	}
Index: linux-2.6/arch/powerpc/platforms/pseries/vio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/vio.c
+++ linux-2.6/arch/powerpc/platforms/pseries/vio.c
@@ -108,32 +108,28 @@ __initcall(vio_bus_init_pseries);
 */
 static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 {
-	unsigned int *dma_window;
-	struct iommu_table *newTceTable;
-	unsigned long offset;
-	int dma_window_property_size;
+	unsigned char *dma_window;
+	struct iommu_table *tbl;
+	unsigned long offset, size;
 
-	dma_window = (unsigned int *) get_property(dev->dev.platform_data, "ibm,my-dma-window", &dma_window_property_size);
-	if(!dma_window) {
+	dma_window = get_property(dev->dev.platform_data,
+			"ibm,my-dma-window", NULL);
+	if (!dma_window)
 		return NULL;
-	}
 
-	newTceTable = (struct iommu_table *) kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
+	tbl = (struct iommu_table *)kmalloc(sizeof(*tbl), GFP_KERNEL);
 
-	/*  There should be some code to extract the phys-encoded offset
-		using prom_n_addr_cells(). However, according to a comment
-		on earlier versions, it's always zero, so we don't bother */
-	offset = dma_window[1] >>  PAGE_SHIFT;
+	of_parse_dma_window(dev->dev.platform_data, dma_window,
+			&tbl->it_index, &offset, &size);
 
 	/* TCE table size - measured in tce entries */
-	newTceTable->it_size		= dma_window[4] >> PAGE_SHIFT;
+	tbl->it_size	= size >> PAGE_SHIFT;
 	/* offset for VIO should always be 0 */
-	newTceTable->it_offset		= offset;
-	newTceTable->it_busno		= 0;
-	newTceTable->it_index		= (unsigned long)dma_window[0];
-	newTceTable->it_type		= TCE_VB;
+	tbl->it_offset	= offset >> PAGE_SHIFT;
+	tbl->it_busno	= 0;
+	tbl->it_type	= TCE_VB;
 
-	return iommu_init_table(newTceTable);
+	return iommu_init_table(tbl);
 }
 
 /**
