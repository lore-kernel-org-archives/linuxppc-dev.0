Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vS4fD4l9bzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 13:47:16 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel] powerpc/powernv/ioda2: Update iommu table base on
 ownership change
Date: Tue, 21 Feb 2017 13:41:31 +1100
Message-Id: <20170221024131.47753-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWERNV platform, in order to do DMA via IOMMU (i.e. 32bit DMA in
our case), a device needs an iommu_table pointer set via
set_iommu_table_base().

The codeflow is:
- pnv_pci_ioda2_setup_dma_pe()
	- pnv_pci_ioda2_setup_default_config()
	- pnv_ioda_setup_bus_dma() [1]

pnv_pci_ioda2_setup_dma_pe() creates IOMMU groups,
pnv_pci_ioda2_setup_default_config() does default DMA setup,
pnv_ioda_setup_bus_dma() takes a bus PE (on IODA2, all physical function
PEs as bus PEs except NPU), walks through all underlying buses and
devices, adds all devices to an IOMMU group and sets iommu_table.

On IODA2, when VFIO is used, it takes ownership over a PE which means it
removes all tables and creates new ones (with a possibility of sharing
them among PEs). So when the ownership is returned from VFIO to
the kernel, the iommu_table pointer written to a device at [1] is
stale and needs an update.

This adds an "add_to_group" parameter to pnv_ioda_setup_bus_dma()
(in fact re-adds as it used to be there a while ago for different
reasons) to tell the helper if a device needs to be added to
an IOMMU group with an iommu_table update or just the latter.

This calls pnv_ioda_setup_bus_dma(..., false) from
pnv_ioda2_release_ownership() so when the ownership is restored,
32bit DMA can work again for a device. This does the same thing
on obtaining ownership as the iommu_table point is stale at this point
anyway and it is safer to have NULL there.

We did not hit this earlier as all tested devices in recent years were
only using 64bit DMA; the rare exception for this is MPT3 SAS adapter
which uses both 32bit and 64bit DMA access and it has not been tested
with VFIO much.

Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

If this is applied before "powerpc/powernv/npu: Remove dead iommu code",
there will be a minor conflict.
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 51ec0dc1dfde..f5a2421bf164 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1774,17 +1774,20 @@ static u64 pnv_pci_ioda_dma_get_required_mask(struct pci_dev *pdev)
 }
 
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
-				   struct pci_bus *bus)
+				   struct pci_bus *bus,
+				   bool add_to_group)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
 		set_dma_offset(&dev->dev, pe->tce_bypass_base);
-		iommu_add_device(&dev->dev);
+		if (add_to_group)
+			iommu_add_device(&dev->dev);
 
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
-			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
+			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
+					add_to_group);
 	}
 }
 
@@ -2190,7 +2193,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 		set_iommu_table_base(&pe->pdev->dev, tbl);
 		iommu_add_device(&pe->pdev->dev);
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
-		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 
 	return;
  fail:
@@ -2425,6 +2428,8 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 
 	pnv_pci_ioda2_set_bypass(pe, false);
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+	if (pe->pbus)
+		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
 	pnv_ioda2_table_free(tbl);
 }
 
@@ -2434,6 +2439,8 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 						table_group);
 
 	pnv_pci_ioda2_setup_default_config(pe);
+	if (pe->pbus)
+		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
 }
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
@@ -2725,7 +2732,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		return;
 
 	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
-		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 }
 
 #ifdef CONFIG_PCI_MSI
-- 
2.11.0
