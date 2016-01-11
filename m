Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D3031A0BC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:59:14 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com, ruscur@russell.cc,
 benh@kernel.crashing.org, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 1/2] powerpc/powernv: Change NPU PE# assignment
Date: Mon, 11 Jan 2016 16:53:49 +1100
Message-Id: <1452491630-22690-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The P8+ hardware supports four partitionable endpoints (PEs) however
the hardware reports all errors as occurring on PE#0. This means we
need to reserve this PE for error handling (EEH) and not assign it to
a NPU device, implying that some devices will need to share PEs.

This patch changes the PE assignment for NPU devices such that NPU
devices which connect to the same GPU are assigned to the same
PE#.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 73 ++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 458133f..0b625272 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1074,16 +1074,75 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 	pnv_ioda_link_pe_by_weight(phb, pe);
 }
 
-static void pnv_ioda_setup_dev_PEs(struct pci_bus *bus)
+static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
+{
+	int pe_num, found_pe = false, rc;
+	long rid;
+	struct pnv_ioda_pe *pe;
+	struct pci_dev *gpu_pdev;
+	struct pci_dn *npu_pdn;
+	struct pci_controller *hose = pci_bus_to_host(npu_pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	/*
+	 * Due to a hardware errata PE#0 on the NPU is reserved for
+	 * error handling. This means we only have three PEs remaining
+	 * which need to be assigned to four links, implying some
+	 * links must share PEs.
+	 *
+	 * To achieve this we assign PEs such that NPUs linking the
+	 * same GPU get assigned the same PE.
+	 */
+	gpu_pdev = pnv_pci_get_gpu_dev(npu_pdev);
+	for (pe_num = 0; pe_num < phb->ioda.total_pe; pe_num++) {
+		pe = &phb->ioda.pe_array[pe_num];
+		if (!pe->pdev)
+			continue;
+
+		if (pnv_pci_get_gpu_dev(pe->pdev) == gpu_pdev) {
+			/*
+			 * This device has the same peer GPU so should
+			 * be assigned the same PE as the existing
+			 * peer NPU.
+			 */
+			dev_info(&npu_pdev->dev,
+				"Associating to existing PE %d\n", pe_num);
+			pci_dev_get(npu_pdev);
+			npu_pdn = pci_get_pdn(npu_pdev);
+			rid = npu_pdev->bus->number << 8 | npu_pdn->devfn;
+			npu_pdn->pcidev = npu_pdev;
+			npu_pdn->pe_number = pe_num;
+			pe->dma_weight += pnv_ioda_dma_weight(npu_pdev);
+			phb->ioda.pe_rmap[rid] = pe->pe_number;
+
+			/* Map the PE to this link */
+			rc = opal_pci_set_pe(phb->opal_id, pe_num, rid,
+					OpalPciBusAll,
+					OPAL_COMPARE_RID_DEVICE_NUMBER,
+					OPAL_COMPARE_RID_FUNCTION_NUMBER,
+					OPAL_MAP_PE);
+			WARN_ON(rc != OPAL_SUCCESS);
+			found_pe = true;
+			break;
+		}
+	}
+
+	if (!found_pe)
+		/*
+		 * Could not find an existing PE so allocate a new
+		 * one.
+		 */
+		return pnv_ioda_setup_dev_PE(npu_pdev);
+	else
+		return pe;
+}
+
+static void pnv_ioda_setup_npu_PEs(struct pci_bus *bus)
 {
-	struct pci_bus *child;
 	struct pci_dev *pdev;
 
 	list_for_each_entry(pdev, &bus->devices, bus_list)
-		pnv_ioda_setup_dev_PE(pdev);
-
-	list_for_each_entry(child, &bus->children, node)
-		pnv_ioda_setup_dev_PEs(child);
+		pnv_ioda_setup_npu_PE(pdev);
 }
 
 static void pnv_ioda_setup_PEs(struct pci_bus *bus)
@@ -1128,7 +1187,7 @@ static void pnv_pci_ioda_setup_PEs(void)
 		 * remaining types of PHBs.
 		 */
 		if (phb->type == PNV_PHB_NPU)
-			pnv_ioda_setup_dev_PEs(hose->bus);
+			pnv_ioda_setup_npu_PEs(hose->bus);
 		else
 			pnv_ioda_setup_PEs(hose->bus);
 	}
-- 
2.1.4
