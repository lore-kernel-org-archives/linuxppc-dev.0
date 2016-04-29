Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx77r6dHZzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:05:12 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 19:05:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E8F8F3578060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:05:04 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T94pLI43778174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:04:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T94Rh1005298
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 19:04:27 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v4 10/11] powerpc/powernv/npu: Rework TCE Kill handling
Date: Fri, 29 Apr 2016 18:55:23 +1000
Message-Id: <1461920124-21719-11-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pnv_ioda_pe struct keeps an array of peers. At the moment it is only
used to link GPU and NPU for 2 purposes:

1. Access NPU quickly when configuring DMA for GPU - this was addressed
in the previos patch by removing use of it as DMA setup is not what
the kernel would constantly do.

2. Invalidate TCE cache for NPU when it is invalidated for GPU.
GPU and NPU are in different PE. There is already a mechanism to
attach multiple iommu_table_group to the same iommu_table (used for VFIO),
we can reuse it here so does this patch.

This gets rid of peers[] array and PNV_IODA_PE_PEER flag as they are
not needed anymore.

While we are here, add TCE cache invalidation after enabling bypass.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v4:
* reworked as "powerpc/powernv/npu: Add set/unset window helpers" has been
added
---
 arch/powerpc/platforms/powernv/npu-dma.c  | 69 +++++++++----------------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 57 ++++---------------------
 arch/powerpc/platforms/powernv/pci.h      |  6 ---
 3 files changed, 26 insertions(+), 106 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 800d70f..cb2d1da 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -136,22 +136,17 @@ static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct pnv_ioda_pe *npe,
 	struct pnv_ioda_pe *pe;
 	struct pci_dn *pdn;
 
-	if (npe->flags & PNV_IODA_PE_PEER) {
-		pe = npe->peers[0];
-		pdev = pe->pdev;
-	} else {
-		pdev = pnv_pci_get_gpu_dev(npe->pdev);
-		if (!pdev)
-			return NULL;
+	pdev = pnv_pci_get_gpu_dev(npe->pdev);
+	if (!pdev)
+		return NULL;
 
-		pdn = pci_get_pdn(pdev);
-		if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
-			return NULL;
+	pdn = pci_get_pdn(pdev);
+	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+		return NULL;
 
-		hose = pci_bus_to_host(pdev->bus);
-		phb = hose->private_data;
-		pe = &phb->ioda.pe_array[pdn->pe_number];
-	}
+	hose = pci_bus_to_host(pdev->bus);
+	phb = hose->private_data;
+	pe = &phb->ioda.pe_array[pdn->pe_number];
 
 	if (gpdev)
 		*gpdev = pdev;
@@ -186,6 +181,10 @@ static long pnv_npu_set_window(struct pnv_ioda_pe *npe,
 	}
 	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
 
+	/* Add the table to the list so its TCE cache will get invalidated */
+	pnv_pci_link_table_and_group(phb->hose->node, 0,
+			tbl, &npe->table_group);
+
 	return 0;
 }
 
@@ -206,45 +205,12 @@ static long pnv_npu_unset_window(struct pnv_ioda_pe *npe)
 	}
 	pnv_pci_ioda2_tce_invalidate_entire(phb, false);
 
+	pnv_pci_unlink_table_and_group(npe->table_group.tables[0],
+			&npe->table_group);
+
 	return 0;
 }
 
-void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
-{
-	struct pnv_ioda_pe *gpe;
-	struct pci_dev *gpdev;
-	int i, avail = -1;
-
-	if (!npe->pdev || !(npe->flags & PNV_IODA_PE_DEV))
-		return;
-
-	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
-	if (!gpe)
-		return;
-
-	for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
-		/* Nothing to do if the PE is already connected. */
-		if (gpe->peers[i] == npe)
-			return;
-
-		if (!gpe->peers[i])
-			avail = i;
-	}
-
-	if (WARN_ON(avail < 0))
-		return;
-
-	gpe->peers[avail] = npe;
-	gpe->flags |= PNV_IODA_PE_PEER;
-
-	/*
-	 * We assume that the NPU devices only have a single peer PE
-	 * (the GPU PCIe device PE).
-	 */
-	npe->peers[0] = gpe;
-	npe->flags |= PNV_IODA_PE_PEER;
-}
-
 /*
  * Enables 32 bit DMA on NPU.
  */
@@ -302,6 +268,9 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 			npe->pe_number, npe->pe_number,
 			0 /* bypass base */, top);
 
+	if (rc == OPAL_SUCCESS)
+		pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+
 	return rc;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index db7695f..922c74c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1816,23 +1816,12 @@ static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
 	/* 01xb - invalidate TCEs that match the specified PE# */
 	unsigned long val = TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
 	struct pnv_phb *phb = pe->phb;
-	struct pnv_ioda_pe *npe;
-	int i;
 
 	if (!phb->ioda.tce_inval_reg)
 		return;
 
 	mb(); /* Ensure above stores are visible */
 	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
-
-	if (pe->flags & PNV_IODA_PE_PEER)
-		for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
-			npe = pe->peers[i];
-			if (!npe || npe->phb->type != PNV_PHB_NPU)
-				continue;
-
-			pnv_pci_ioda2_tce_invalidate_entire(npe->phb, false);
-		}
 }
 
 static void pnv_pci_ioda2_do_tce_invalidate(unsigned pe_number, bool rm,
@@ -1867,33 +1856,24 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 	struct iommu_table_group_link *tgl;
 
 	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
-		struct pnv_ioda_pe *npe;
 		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 				struct pnv_ioda_pe, table_group);
 		__be64 __iomem *invalidate = rm ?
 			(__be64 __iomem *)pe->phb->ioda.tce_inval_reg_phys :
 			pe->phb->ioda.tce_inval_reg;
-		int i;
 
-		pnv_pci_ioda2_do_tce_invalidate(pe->pe_number, rm,
-			invalidate, tbl->it_page_shift,
-			index, npages);
-
-		if (pe->flags & PNV_IODA_PE_PEER)
+		if (pe->phb->type == PNV_PHB_NPU) {
 			/*
 			 * The NVLink hardware does not support TCE kill
 			 * per TCE entry so we have to invalidate
 			 * the entire cache for it.
 			 */
-			for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
-				npe = pe->peers[i];
-				if (!npe || npe->phb->type != PNV_PHB_NPU ||
-						!npe->phb->ioda.tce_inval_reg)
-					continue;
-
-				pnv_pci_ioda2_tce_invalidate_entire(npe->phb,
-						rm);
-			}
+			pnv_pci_ioda2_tce_invalidate_entire(pe->phb, rm);
+			continue;
+		}
+		pnv_pci_ioda2_do_tce_invalidate(pe->pe_number, rm,
+			invalidate, tbl->it_page_shift,
+			index, npages);
 	}
 }
 
@@ -3061,26 +3041,6 @@ static void pnv_pci_ioda_create_dbgfs(void)
 #endif /* CONFIG_DEBUG_FS */
 }
 
-static void pnv_npu_ioda_fixup(void)
-{
-	bool enable_bypass;
-	struct pci_controller *hose, *tmp;
-	struct pnv_phb *phb;
-	struct pnv_ioda_pe *pe;
-
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		phb = hose->private_data;
-		if (phb->type != PNV_PHB_NPU)
-			continue;
-
-		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
-			enable_bypass = dma_get_mask(&pe->pdev->dev) ==
-				DMA_BIT_MASK(64);
-			pnv_npu_init_dma_pe(pe);
-		}
-	}
-}
-
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
@@ -3093,9 +3053,6 @@ static void pnv_pci_ioda_fixup(void)
 	eeh_init();
 	eeh_addr_cache_build();
 #endif
-
-	/* Link NPU IODA tables to their PCI devices. */
-	pnv_npu_ioda_fixup();
 }
 
 /*
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 485e5b1..e117bd8 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -24,7 +24,6 @@ enum pnv_phb_model {
 #define PNV_IODA_PE_MASTER	(1 << 3)	/* Master PE in compound case	*/
 #define PNV_IODA_PE_SLAVE	(1 << 4)	/* Slave PE in compound case	*/
 #define PNV_IODA_PE_VF		(1 << 5)	/* PE for one VF 		*/
-#define PNV_IODA_PE_PEER	(1 << 6)	/* PE has peers			*/
 
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_phb;
@@ -32,9 +31,6 @@ struct pnv_ioda_pe {
 	unsigned long		flags;
 	struct pnv_phb		*phb;
 
-#define PNV_IODA_MAX_PEER_PES	8
-	struct pnv_ioda_pe	*peers[PNV_IODA_MAX_PEER_PES];
-
 	/* A PE can be associated with a single device or an
 	 * entire bus (& children). In the former case, pdev
 	 * is populated, in the later case, pbus is.
@@ -246,8 +242,6 @@ extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 	pe_level_printk(pe, KERN_INFO, fmt, ##__VA_ARGS__)
 
 /* Nvlink functions */
-extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
-extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 
-- 
2.5.0.rc3
