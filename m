Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vqDHW19HSzDq95
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 17:37:26 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH guest kernel] powerpc/pseries: Enable VFIO
Date: Fri, 24 Mar 2017 17:37:21 +1100
Message-Id: <20170324063721.16887-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables VFIO on pseries host in order to allow VFIO in nested guest
under PR KVM or DPDK in a HV guest. This adds support of
the VFIO_SPAPR_TCE_IOMMU type.

This adds exchange() callback to allow TCE updates by the SPAPR TCE IOMMU
driver in VFIO.

This initializes DMA32 window parameters in iommu_table_group as
as this does not implement VFIO_SPAPR_TCE_v2_IOMMU and
VFIO_SPAPR_TCE_IOMMU just reuses the existing DMA32 window.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 40 ++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 4d757eaa46bf..7c8ed68d727e 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -550,6 +550,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct device_node *dn,
 				      struct iommu_table *tbl,
+				      struct iommu_table_group *table_group,
 				      const __be32 *dma_window)
 {
 	unsigned long offset, size;
@@ -563,6 +564,9 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
 	tbl->it_type = TCE_PCI;
 	tbl->it_offset = offset >> tbl->it_page_shift;
 	tbl->it_size = size >> tbl->it_page_shift;
+
+	table_group->tce32_start = offset;
+	table_group->tce32_size = size;
 }
 
 struct iommu_table_ops iommu_table_pseries_ops = {
@@ -651,8 +655,38 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pr_debug("ISA/IDE, window size is 0x%llx\n", pci->phb->dma_window_size);
 }
 
+#ifdef CONFIG_IOMMU_API
+static int tce_exchange_pSeries(struct iommu_table *tbl, long index,
+		unsigned long *tce, enum dma_data_direction *direction)
+{
+	long rc;
+	unsigned long ioba = (unsigned long) index << tbl->it_page_shift;
+	unsigned long flags, oldtce = 0;
+	u64 proto_tce = iommu_direction_to_tce_perm(*direction);
+	unsigned long newtce = *tce | proto_tce;
+
+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
+
+	rc = plpar_tce_get((u64)tbl->it_index, ioba, &oldtce);
+	if (!rc)
+		rc = plpar_tce_put((u64)tbl->it_index, ioba, newtce);
+
+	if (!rc) {
+		*direction = iommu_tce_direction(oldtce);
+		*tce = oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
+	}
+
+	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
+
+	return rc;
+}
+#endif
+
 struct iommu_table_ops iommu_table_lpar_multi_ops = {
 	.set = tce_buildmulti_pSeriesLP,
+#ifdef CONFIG_IOMMU_API
+	.exchange = tce_exchange_pSeries,
+#endif
 	.clear = tce_freemulti_pSeriesLP,
 	.get = tce_get_pSeriesLP
 };
@@ -689,7 +723,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	if (!ppci->table_group) {
 		ppci->table_group = iommu_pseries_alloc_group(ppci->phb->node);
 		tbl = ppci->table_group->tables[0];
-		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
+		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
+				ppci->table_group, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		iommu_init_table(tbl, ppci->phb->node);
 		iommu_register_group(ppci->table_group,
@@ -1143,7 +1178,8 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	if (!pci->table_group) {
 		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
 		tbl = pci->table_group->tables[0];
-		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
+		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
+				pci->table_group, dma_window);
 		tbl->it_ops = &iommu_table_lpar_multi_ops;
 		iommu_init_table(tbl, pci->phb->node);
 		iommu_register_group(pci->table_group,
-- 
2.11.0
