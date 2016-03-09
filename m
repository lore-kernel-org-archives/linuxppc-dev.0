Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA7471A0313
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:31:04 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:31:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0B5C62CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:31:00 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296UqiS15269904
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:31:00 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296URJ2011889
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:27 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 04/10] powerpc/powernv/npu: TCE Kill helpers cleanup
Date: Wed,  9 Mar 2016 17:29:00 +1100
Message-Id: <1457504946-40649-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NPU PHB TCE Kill register is exactly the same as in the rest of POWER8
so let's reuse the existing code for NPU. The only bit missing is
a helper to reset the entire TCE cache so this moves such a helper
from NPU code and renames it.

Since pnv_npu_tce_invalidate() does really invalidate the entire cache,
this uses pnv_pci_ioda2_tce_invalidate_entire() directly for NPU.
This adds an explicit comment for workaround for invalidating NPU TCE
cache.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c  | 41 -------------------------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 29 ++++++++++++++++++----
 arch/powerpc/platforms/powernv/pci.h      |  7 +-----
 3 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 7229acd..778570c 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -25,8 +25,6 @@
  * Other types of TCE cache invalidation are not functional in the
  * hardware.
  */
-#define TCE_KILL_INVAL_ALL PPC_BIT(0)
-
 static struct pci_dev *get_pci_dev(struct device_node *dn)
 {
 	return PCI_DN(dn)->pcidev;
@@ -161,45 +159,6 @@ static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct pnv_ioda_pe *npe,
 	return pe;
 }
 
-void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe)
-{
-	struct pnv_phb *phb = npe->phb;
-
-	if (WARN_ON(phb->type != PNV_PHB_NPU ||
-		    !phb->ioda.tce_inval_reg ||
-		    !(npe->flags & PNV_IODA_PE_DEV)))
-		return;
-
-	mb(); /* Ensure previous TCE table stores are visible */
-	__raw_writeq(cpu_to_be64(TCE_KILL_INVAL_ALL),
-		phb->ioda.tce_inval_reg);
-}
-
-void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
-				struct iommu_table *tbl,
-				unsigned long index,
-				unsigned long npages,
-				bool rm)
-{
-	struct pnv_phb *phb = npe->phb;
-
-	/* We can only invalidate the whole cache on NPU */
-	unsigned long val = TCE_KILL_INVAL_ALL;
-
-	if (WARN_ON(phb->type != PNV_PHB_NPU ||
-		    !phb->ioda.tce_inval_reg ||
-		    !(npe->flags & PNV_IODA_PE_DEV)))
-		return;
-
-	mb(); /* Ensure previous TCE table stores are visible */
-	if (rm)
-		__raw_rm_writeq(cpu_to_be64(val),
-		  (__be64 __iomem *) phb->ioda.tce_inval_reg_phys);
-	else
-		__raw_writeq(cpu_to_be64(val),
-			phb->ioda.tce_inval_reg);
-}
-
 void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
 {
 	struct pnv_ioda_pe *gpe;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 33e9489..90cdf49 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1824,9 +1824,23 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
+#define TCE_KILL_INVAL_ALL  PPC_BIT(0)
 #define TCE_KILL_INVAL_PE   PPC_BIT(1)
 #define TCE_KILL_INVAL_TCE  PPC_BIT(2)
 
+void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm)
+{
+	const unsigned long val = TCE_KILL_INVAL_ALL;
+
+	mb(); /* Ensure previous TCE table stores are visible */
+	if (rm)
+		__raw_rm_writeq(cpu_to_be64(val),
+				(__be64 __iomem *)
+				phb->ioda.tce_inval_reg_phys);
+	else
+		__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
+}
+
 static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 {
 	/* 01xb - invalidate TCEs that match the specified PE# */
@@ -1847,7 +1861,7 @@ static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 			if (!npe || npe->phb->type != PNV_PHB_NPU)
 				continue;
 
-			pnv_npu_tce_invalidate_entire(npe);
+			pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
 		}
 }
 
@@ -1896,14 +1910,19 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 			index, npages);
 
 		if (pe->flags & PNV_IODA_PE_PEER)
-			/* Invalidate PEs using the same TCE table */
+			/*
+			 * The NVLink hardware does not support TCE kill
+			 * per TCE entry so we have to invalidate
+			 * the entire cache for it.
+			 */
 			for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
 				npe = pe->peers[i];
-				if (!npe || npe->phb->type != PNV_PHB_NPU)
+				if (!npe || npe->phb->type != PNV_PHB_NPU ||
+						!npe->phb->ioda.tce_inval_reg)
 					continue;
 
-				pnv_npu_tce_invalidate(npe, tbl, index,
-							npages, rm);
+				pnv_pci_ioda2_tce_invalidate_entire(npe->phb,
+						rm);
 			}
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3f814f3..0b89a4c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -237,15 +237,10 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 
 /* Nvlink functions */
-extern void pnv_npu_tce_invalidate_entire(struct pnv_ioda_pe *npe);
-extern void pnv_npu_tce_invalidate(struct pnv_ioda_pe *npe,
-				       struct iommu_table *tbl,
-				       unsigned long index,
-				       unsigned long npages,
-				       bool rm);
 extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
 extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
 extern int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enabled);
 extern int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask);
+extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 
 #endif /* __POWERNV_PCI_H */
-- 
2.5.0.rc3
