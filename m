Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHk6q11KBzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 13:24:51 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev,
	mpe@ellerman.id.au
Cc: sbaskaran@nvidia.com, linux-kernel@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>, stable@vger.kernel.org
Subject: [PATCH] powerpc/powernv: Fix TCE kill on NVLink2
Date: Wed,  3 May 2017 13:24:08 +1000
Message-Id: <1493781848-5826-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 616badd2fb49 ("powerpc/powernv: Use OPAL call for TCE kill on
NVLink2") forced all TCE kills to go via the OPAL call for
NVLink2. However the PHB3 implementation of TCE kill was still being
called directly from some functions which in some circumstances caused
a machine check.

This patch adds an equivalent IODA2 version of the function which uses
the correct invalidation method depending on PHB model and changes all
external callers to use it instead.

Fixes: 616badd2fb49 ("powerpc/powernv: Use OPAL call for TCE kill on NVLink2")
Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/powernv/npu-dma.c  |  8 ++++----
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 +++++++++-
 arch/powerpc/platforms/powernv/pci.h      |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 4c88c3e..067defe 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -203,7 +203,7 @@ long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		pe_err(npe, "Failed to configure TCE table, err %lld\n", rc);
 		return rc;
 	}
-	pnv_pci_phb3_tce_invalidate_entire(phb, false);
+	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
 
 	/* Add the table to the list so its TCE cache will get invalidated */
 	pnv_pci_link_table_and_group(phb->hose->node, num,
@@ -227,7 +227,7 @@ long pnv_npu_unset_window(struct pnv_ioda_pe *npe, int num)
 		pe_err(npe, "Unmapping failed, ret = %lld\n", rc);
 		return rc;
 	}
-	pnv_pci_phb3_tce_invalidate_entire(phb, false);
+	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
 
 	pnv_pci_unlink_table_and_group(npe->table_group.tables[num],
 			&npe->table_group);
@@ -293,7 +293,7 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 			0 /* bypass base */, top);
 
 	if (rc == OPAL_SUCCESS)
-		pnv_pci_phb3_tce_invalidate_entire(phb, false);
+		pnv_pci_ioda2_tce_invalidate_entire(phb, false);
 
 	return rc;
 }
@@ -357,7 +357,7 @@ void pnv_npu_take_ownership(struct pnv_ioda_pe *npe)
 		pe_err(npe, "Failed to disable bypass, err %lld\n", rc);
 		return;
 	}
-	pnv_pci_phb3_tce_invalidate_entire(npe->phb, false);
+	pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
 }
 
 struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 93ce3f9..dfbc94a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1895,7 +1895,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 #define PHB3_TCE_KILL_INVAL_PE		PPC_BIT(1)
 #define PHB3_TCE_KILL_INVAL_ONE		PPC_BIT(2)
 
-void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
+static void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
 {
 	__be64 __iomem *invalidate = pnv_ioda_get_inval_reg(phb, rm);
 	const unsigned long val = PHB3_TCE_KILL_INVAL_ALL;
@@ -1991,6 +1991,14 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 	}
 }
 
+void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
+{
+	if (phb->model == PNV_PHB_MODEL_NPU || phb->model == PNV_PHB_MODEL_PHB3)
+		pnv_pci_phb3_tce_invalidate_entire(phb, rm);
+	else
+		opal_pci_tce_kill(phb->opal_id, OPAL_PCI_TCE_KILL, 0, 0, 0, 0);
+}
+
 static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
 		long npages, unsigned long uaddr,
 		enum dma_data_direction direction,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 4eab713..18c8a2f 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -242,7 +242,7 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 
 /* Nvlink functions */
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
-extern void pnv_pci_phb3_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
+extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 extern struct pnv_ioda_pe *pnv_pci_npu_setup_iommu(struct pnv_ioda_pe *npe);
 extern long pnv_npu_set_window(struct pnv_ioda_pe *npe, int num,
 		struct iommu_table *tbl);
-- 
2.1.4
