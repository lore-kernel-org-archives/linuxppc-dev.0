Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vS4fD4H5bzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 13:47:16 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel] powerpc/powernv/npu: Remove dead iommu code
Date: Tue, 21 Feb 2017 13:40:20 +1100
Message-Id: <20170221024020.47631-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PNV_IODA_PE_DEV is only used for NPU devices (emulated PCI bridges
representing NVLink). These are added to IOMMU groups with corresponding
NVIDIA devices after all non-NPU PEs are setup; a special helper -
pnv_pci_ioda_setup_iommu_api() - handles this in pnv_pci_ioda_fixup().

The pnv_pci_ioda2_setup_dma_pe() helper sets up DMA for a PE. It is called
for VFs (so it does not handle NPU case) and PCI bridges but only
IODA1 and IODA2 types. An NPU bridge has its own type id (PNV_PHB_NPU)
so pnv_pci_ioda2_setup_dma_pe() cannot be called on NPU and therefore
(pe->flags & PNV_IODA_PE_DEV) is always "false".

This removes not used iommu_add_device(). This should not cause any
behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5fcae29107e1..51ec0dc1dfde 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2724,9 +2724,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	if (rc)
 		return;
 
-	if (pe->flags & PNV_IODA_PE_DEV)
-		iommu_add_device(&pe->pdev->dev);
-	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
+	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
-- 
2.11.0
