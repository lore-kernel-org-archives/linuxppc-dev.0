Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yL8Bk1SlXzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:07:09 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel] powerpc/powernv/idoa: Remove unnecessary pcidev from
 pci_dn
Date: Mon, 23 Oct 2017 19:07:02 +1100
Message-Id: <20171023080702.23479-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pcidev value stored in pci_dn is only used for NPU/NPU2
initialization. We can easily drop the cached pointer and
use an ancient helper - pci_get_domain_bus_and_slot() instead in order
to reduce complexity.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h     | 2 --
 arch/powerpc/platforms/powernv/npu-dma.c  | 5 ++++-
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 0b8aa1fe2d5f..752718a2949d 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -197,8 +197,6 @@ struct pci_dn {
 	struct	iommu_table_group *table_group;	/* for phb's or bridges */
 
 	int	pci_ext_config_space;	/* for pci devices */
-
-	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;		/* eeh device */
 #endif
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 2cb6cbea4b3b..b5844a950852 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -39,7 +39,10 @@
  */
 static struct pci_dev *get_pci_dev(struct device_node *dn)
 {
-	return PCI_DN(dn)->pcidev;
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(pdn->phb->bus),
+					   pdn->busno, pdn->devfn);
 }
 
 /* Given a NPU device get the associated PCI device. */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index bc60faa9f6c2..269f119e4b3c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1047,7 +1047,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 	 * At some point we want to remove the PDN completely anyways
 	 */
 	pci_dev_get(dev);
-	pdn->pcidev = dev;
 	pdn->pe_number = pe->pe_number;
 	pe->flags = PNV_IODA_PE_DEV;
 	pe->pdev = dev;
@@ -1094,7 +1093,6 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 			continue;
 
 		pe->device_count++;
-		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_same_PE(dev->subordinate, pe);
@@ -1209,7 +1207,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
 			pci_dev_get(npu_pdev);
 			npu_pdn = pci_get_pdn(npu_pdev);
 			rid = npu_pdev->bus->number << 8 | npu_pdn->devfn;
-			npu_pdn->pcidev = npu_pdev;
 			npu_pdn->pe_number = pe_num;
 			phb->ioda.pe_rmap[rid] = pe->pe_number;
 
-- 
2.11.0
