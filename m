Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 19/63] powerpc: of_parse_dma_window should take a __be32
 *dma_window
Date: Wed,  7 Aug 2013 02:01:36 +1000
Message-Id: <1375804940-22050-20-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We pass dma_window to of_parse_dma_window as a void * and then
run through hoops to cast it back to a u32 array. In the process
we lose endian annotation.

Simplify it by just passing a __be32 * down.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/prom.h        |  5 +++--
 arch/powerpc/kernel/prom_parse.c       | 17 ++++++++---------
 arch/powerpc/kernel/vio.c              |  2 +-
 arch/powerpc/platforms/cell/iommu.c    |  2 +-
 arch/powerpc/platforms/pseries/iommu.c |  8 ++++----
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index bc2da15..fa2f30c 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -38,8 +38,9 @@ extern unsigned long pci_address_to_pio(phys_addr_t address);
 /* Parse the ibm,dma-window property of an OF node into the busno, phys and
  * size parameters.
  */
-void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
-		unsigned long *busno, unsigned long *phys, unsigned long *size);
+void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,
+			 unsigned long *busno, unsigned long *phys,
+			 unsigned long *size);
 
 extern void kdump_move_device_tree(void);
 
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 4e1331b..6295e64 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -7,28 +7,27 @@
 #include <linux/of_address.h>
 #include <asm/prom.h>
 
-void of_parse_dma_window(struct device_node *dn, const void *dma_window_prop,
-		unsigned long *busno, unsigned long *phys, unsigned long *size)
+void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,
+			 unsigned long *busno, unsigned long *phys,
+			 unsigned long *size)
 {
-	const u32 *dma_window;
 	u32 cells;
-	const unsigned char *prop;
-
-	dma_window = dma_window_prop;
+	const __be32 *prop;
 
 	/* busno is always one cell */
-	*busno = *(dma_window++);
+	*busno = of_read_number(dma_window, 1);
+	dma_window++;
 
 	prop = of_get_property(dn, "ibm,#dma-address-cells", NULL);
 	if (!prop)
 		prop = of_get_property(dn, "#address-cells", NULL);
 
-	cells = prop ? *(u32 *)prop : of_n_addr_cells(dn);
+	cells = prop ? of_read_number(prop, 1) : of_n_addr_cells(dn);
 	*phys = of_read_number(dma_window, cells);
 
 	dma_window += cells;
 
 	prop = of_get_property(dn, "ibm,#dma-size-cells", NULL);
-	cells = prop ? *(u32 *)prop : of_n_size_cells(dn);
+	cells = prop ? of_read_number(prop, 1) : of_n_size_cells(dn);
 	*size = of_read_number(dma_window, cells);
 }
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 536016d..31875a6 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1153,7 +1153,7 @@ EXPORT_SYMBOL(vio_h_cop_sync);
 
 static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 {
-	const unsigned char *dma_window;
+	const __be32 *dma_window;
 	struct iommu_table *tbl;
 	unsigned long offset, size;
 
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 946306b..b535606 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -697,7 +697,7 @@ static int __init cell_iommu_get_window(struct device_node *np,
 					 unsigned long *base,
 					 unsigned long *size)
 {
-	const void *dma_window;
+	const __be32 *dma_window;
 	unsigned long index;
 
 	/* Use ibm,dma-window if available, else, hard code ! */
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 23fc1dc..9087f97 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -530,7 +530,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct device_node *dn,
 				      struct iommu_table *tbl,
-				      const void *dma_window)
+				      const __be32 *dma_window)
 {
 	unsigned long offset, size;
 
@@ -630,7 +630,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
-	const void *dma_window = NULL;
+	const __be32 *dma_window = NULL;
 
 	dn = pci_bus_to_OF_node(bus);
 
@@ -1152,7 +1152,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
 	struct device_node *pdn, *dn;
 	struct iommu_table *tbl;
-	const void *dma_window = NULL;
+	const __be32 *dma_window = NULL;
 	struct pci_dn *pci;
 
 	pr_debug("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
@@ -1201,7 +1201,7 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 	bool ddw_enabled = false;
 	struct device_node *pdn, *dn;
 	struct pci_dev *pdev;
-	const void *dma_window = NULL;
+	const __be32 *dma_window = NULL;
 	u64 dma_offset;
 
 	if (!dev->dma_mask)
-- 
1.8.1.2
