Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 40xxph4FLlzF0Vt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 18:10:36 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell Currey <ruscur@russell.cc>
Subject: [PATCH kernel 2/2] powerpc/powernv: Define PHB4 type and enable
 sketchy bypass on POWER9
Date: Fri,  1 Jun 2018 18:10:28 +1000
Message-Id: <20180601081028.29401-3-aik@ozlabs.ru>
In-Reply-To: <20180601081028.29401-1-aik@ozlabs.ru>
References: <20180601081028.29401-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are found in POWER9 chips. Right now these PHBs have unknown type
so changing it to PHB4 won't make much of a difference except enabling
sketchy bypass for POWER9 as this does below.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.h      | 1 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index eada4b6..1408247 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -23,6 +23,7 @@ enum pnv_phb_model {
 	PNV_PHB_MODEL_UNKNOWN,
 	PNV_PHB_MODEL_P7IOC,
 	PNV_PHB_MODEL_PHB3,
+	PNV_PHB_MODEL_PHB4,
 	PNV_PHB_MODEL_NPU,
 	PNV_PHB_MODEL_NPU2,
 };
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9239142..66c2804 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1882,7 +1882,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 		if (dma_mask >> 32 &&
 		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
 		    pnv_pci_ioda_pe_single_vendor(pe) &&
-		    phb->model == PNV_PHB_MODEL_PHB3) {
+		    (phb->model == PNV_PHB_MODEL_PHB3 ||
+		     phb->model == PNV_PHB_MODEL_PHB4)) {
 			/* Configure the bypass mode */
 			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
 			if (rc)
@@ -3930,6 +3931,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 		phb->model = PNV_PHB_MODEL_P7IOC;
 	else if (of_device_is_compatible(np, "ibm,power8-pciex"))
 		phb->model = PNV_PHB_MODEL_PHB3;
+	else if (of_device_is_compatible(np, "ibm,power9-pciex"))
+		phb->model = PNV_PHB_MODEL_PHB4;
 	else if (of_device_is_compatible(np, "ibm,power8-npu-pciex"))
 		phb->model = PNV_PHB_MODEL_NPU;
 	else if (of_device_is_compatible(np, "ibm,power9-npu-pciex"))
-- 
2.11.0
