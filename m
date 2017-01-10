Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyK9r29xGzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 15:41:52 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, ruscur@russell.cc,
 bsingharora@gmail.com, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: Use OPAL call for TCE kill on NVLink2
Date: Tue, 10 Jan 2017 15:41:44 +1100
Message-Id: <1484023304-17244-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add detection of NPU2 PHBs. NPU2/NVLink2 has a different register
layout for the TCE kill register therefore TCE invalidation should be
done via the OPAL call rather than using the register directly as it
is for PHB3 and NVLink1. This changes TCE invalidation to use the OPAL
call in the case of a NPU2 PHB model.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 ++++++++-
 arch/powerpc/platforms/powernv/pci.c      | 7 +++++++
 arch/powerpc/platforms/powernv/pci.h      | 1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d4b33dd..5908c37 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1950,7 +1950,12 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 		struct pnv_phb *phb = pe->phb;
 		unsigned int shift = tbl->it_page_shift;
 
-		if (phb->type == PNV_PHB_NPU) {
+		/*
+		 * NVLink1 can use the TCE kill register directly as
+		 * it's the same as PHB3. NVLink2 is different and
+		 * should go via the OPAL call.
+		 */
+		if (phb->model == PNV_PHB_MODEL_NPU) {
 			/*
 			 * The NVLink hardware does not support TCE kill
 			 * per TCE entry so we have to invalidate
@@ -3671,6 +3676,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		phb->model = PNV_PHB_MODEL_PHB3;
 	else if (of_device_is_compatible(np, "ibm,power8-npu-pciex"))
 		phb->model = PNV_PHB_MODEL_NPU;
+	else if (of_device_is_compatible(np, "ibm,power9-npu-pciex"))
+		phb->model = PNV_PHB_MODEL_NPU2;
 	else
 		phb->model = PNV_PHB_MODEL_UNKNOWN;
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index db7b802..4b22fde 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -940,6 +940,13 @@ void __init pnv_pci_init(void)
 	for_each_compatible_node(np, NULL, "ibm,ioda2-npu-phb")
 		pnv_pci_init_npu_phb(np);
 
+	/*
+	 * Look for NPU2 PHBs which we treat mostly as NPU PHBs with
+	 * the exception of TCE kill which requires an OPAL call.
+	 */
+	for_each_compatible_node(np, NULL, "ibm,ioda2-npu2-phb")
+		pnv_pci_init_npu_phb(np);
+
 	/* Configure IOMMU DMA hooks */
 	set_pci_dma_ops(&dma_iommu_ops);
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index e64df78..e1d3e55 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -19,6 +19,7 @@ enum pnv_phb_model {
 	PNV_PHB_MODEL_P7IOC,
 	PNV_PHB_MODEL_PHB3,
 	PNV_PHB_MODEL_NPU,
+	PNV_PHB_MODEL_NPU2,
 };
 
 #define PNV_PCI_DIAG_BUF_SIZE	8192
-- 
2.1.4
