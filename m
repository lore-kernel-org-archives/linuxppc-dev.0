Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 138CD1A0D2D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:55:08 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 15:55:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 127683578063
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:55:05 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBM5t2Na26083524
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:55:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBM5t30F020897
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 16:55:04 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V10 11/17] powerpc/powernv: Allocate pe->iommu_table
 dynamically
Date: Mon, 22 Dec 2014 13:54:31 +0800
Message-Id: <1419227677-12312-12-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1419227677-12312-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current iommu_table of a PE is a static field. This will have a problem when
iommu_free_table is called.

This patch allocate iommu_table dynamically.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/iommu.h          |    3 +++
 arch/powerpc/platforms/powernv/pci-ioda.c |   26 ++++++++++++++------------
 arch/powerpc/platforms/powernv/pci.h      |    2 +-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 9cfa370..5574eeb 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -78,6 +78,9 @@ struct iommu_table {
 	struct iommu_group *it_group;
 #endif
 	void (*set_bypass)(struct iommu_table *tbl, bool enable);
+#ifdef CONFIG_PPC_POWERNV
+	void           *data;
+#endif
 };
 
 /* Pure 2^n version of get_order */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 42b168f..be0c31a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -890,6 +890,10 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 		return;
 	}
 
+	pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
+			GFP_KERNEL, hose->node);
+	pe->tce32_table->data = pe;
+
 	/* Associate it with all child devices */
 	pnv_ioda_setup_same_PE(bus, pe);
 
@@ -978,7 +982,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_iommu_table_base_and_group(&pdev->dev, &pe->tce32_table);
+	set_iommu_table_base_and_group(&pdev->dev, pe->tce32_table);
 }
 
 static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
@@ -1005,7 +1009,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	} else {
 		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
-		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
+		set_iommu_table_base(&pdev->dev, pe->tce32_table);
 	}
 	*pdev->dev.dma_mask = dma_mask;
 	return 0;
@@ -1042,9 +1046,9 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (add_to_iommu_group)
 			set_iommu_table_base_and_group(&dev->dev,
-						       &pe->tce32_table);
+						       pe->tce32_table);
 		else
-			set_iommu_table_base(&dev->dev, &pe->tce32_table);
+			set_iommu_table_base(&dev->dev, pe->tce32_table);
 
 		if (dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
@@ -1134,8 +1138,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 				 __be64 *startp, __be64 *endp, bool rm)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
+	struct pnv_ioda_pe *pe = tbl->data;
 	struct pnv_phb *phb = pe->phb;
 
 	if (phb->type == PNV_PHB_IODA1)
@@ -1201,7 +1204,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
 				  base << 28, IOMMU_PAGE_SHIFT_4K);
 
@@ -1239,8 +1242,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 
 static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
+	struct pnv_ioda_pe *pe = tbl->data;
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
 	int64_t rc;
 
@@ -1285,10 +1287,10 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 	pe->tce_bypass_base = 1ull << 59;
 
 	/* Install set_bypass callback for VFIO */
-	pe->tce32_table.set_bypass = pnv_pci_ioda2_set_bypass;
+	pe->tce32_table->set_bypass = pnv_pci_ioda2_set_bypass;
 
 	/* Enable bypass by default */
-	pnv_pci_ioda2_set_bypass(&pe->tce32_table, true);
+	pnv_pci_ioda2_set_bypass(pe->tce32_table, true);
 }
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
@@ -1336,7 +1338,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	tbl = &pe->tce32_table;
+	tbl = pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
 			IOMMU_PAGE_SHIFT_4K);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index e5b75b2..7317777 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -53,7 +53,7 @@ struct pnv_ioda_pe {
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
 	int			tce32_seg;
 	int			tce32_segcount;
-	struct iommu_table	tce32_table;
+	struct iommu_table	*tce32_table;
 	phys_addr_t		tce_inval_reg_phys;
 
 	/* 64-bit TCE bypass region */
-- 
1.7.9.5
