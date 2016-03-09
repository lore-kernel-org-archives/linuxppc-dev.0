Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C2431A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:35 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:30:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 317D42BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:30:30 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296UMhR36634654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296TvFi010531
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:29:57 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 07/10] powerpc/powernv/npu: Rework TCE Kill handling
Date: Wed,  9 Mar 2016 17:29:03 +1100
Message-Id: <1457504946-40649-8-git-send-email-aik@ozlabs.ru>
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

The pnv_ioda_pe struct keeps an array of peers. At the moment it is only
used to link GPU and NPU for 2 purposes:

1. Access NPU _quickly_ when configuring DMA for GPU - this was addressed
in the previos patch by removing use of it as DMA setup is not what
the kernel would constantly do.

2. Invalidate TCE cache for NPU when it is invalidated for GPU.
GPU and NPU are in different PE. There is already a mechanism to
attach multiple iommu_table_group to the same iommu_table (used for VFIO),
we can reuse it here so does this patch.

This gets rid of peers[] array and PNV_IODA_PE_PEER flag as they are
not needed anymore.

While we are here, add TCE cache invalidation after changing TVT.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c  | 75 +++++++++----------------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 57 +++--------------------
 arch/powerpc/platforms/powernv/pci.h      |  6 ---
 3 files changed, 29 insertions(+), 109 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 8960e46..866d3d3 100644
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
@@ -159,42 +154,6 @@ static struct pnv_ioda_pe *get_gpu_pci_dev_and_pe(struct pnv_ioda_pe *npe,
 	return pe;
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
@@ -225,6 +184,13 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
 	if (rc != OPAL_SUCCESS)
 		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
 			__func__, rc, phb->hose->global_number, npe->pe_number);
+	else
+		pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+
+	/* Add the table to the list so its TCE cache will get invalidated */
+	npe->table_group.tables[0] = tbl;
+	pnv_pci_link_table_and_group(phb->hose->node, 0,
+			tbl, &npe->table_group);
 
 	/*
 	 * We don't initialise npu_pe->tce32_table as we always use
@@ -245,10 +211,10 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 	int64_t rc = 0;
 	phys_addr_t top = memblock_end_of_DRAM();
 
-	if (phb->type != PNV_PHB_NPU || !npe->pdev)
-		return -EINVAL;
-
 	/* Enable the bypass window */
+	pnv_pci_unlink_table_and_group(npe->table_group.tables[0],
+			&npe->table_group);
+	npe->table_group.tables[0] = NULL;
 
 	npe->tce_bypass_base = 0;
 	top = roundup_pow_of_two(top);
@@ -258,6 +224,9 @@ static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 			npe->pe_number, npe->pe_number,
 			npe->tce_bypass_base, top);
 
+	if (rc == OPAL_SUCCESS)
+		pnv_pci_ioda2_tce_invalidate_entire(phb, false);
+
 	return rc;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 47085b7..5a6cf2e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1836,23 +1836,12 @@ static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
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
@@ -1887,33 +1876,24 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 	struct iommu_table_group_link *tgl;
 
 	list_for_each_entry_lockless(tgl, &tbl->it_group_list, next) {
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
 
@@ -3094,26 +3074,6 @@ static void pnv_pci_ioda_create_dbgfs(void)
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
@@ -3126,9 +3086,6 @@ static void pnv_pci_ioda_fixup(void)
 	eeh_init();
 	eeh_addr_cache_build();
 #endif
-
-	/* Link NPU IODA tables to their PCI devices. */
-	pnv_npu_ioda_fixup();
 }
 
 /*
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index d574a9d..06405fd 100644
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
@@ -237,8 +233,6 @@ extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 
 /* Nvlink functions */
-extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
-extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
 extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 
-- 
2.5.0.rc3
