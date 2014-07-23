Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CFF21A01E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:16 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:13 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9C3492BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N2hKCC51249246
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:43:20 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N36Bx2018431
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 07/18] powerpc/powernv: Add a page size parameter to
 pnv_pci_setup_iommu_table()
Date: Wed, 23 Jul 2014 13:05:53 +1000
Message-Id: <1406084764-24685-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since a TCE page size can be other than 4K, make it configurable for
P5IOC2 and IODA PHBs.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c   | 5 +++--
 arch/powerpc/platforms/powernv/pci-p5ioc2.c | 3 ++-
 arch/powerpc/platforms/powernv/pci.c        | 6 +++---
 arch/powerpc/platforms/powernv/pci.h        | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 40f968e..9f28e18 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -656,7 +656,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	/* Setup linux iommu table */
 	tbl = &pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
-				  base << 28);
+				  base << 28, IOMMU_PAGE_SHIFT_4K);
 
 	/* OPAL variant of P7IOC SW invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
@@ -786,7 +786,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 	/* Setup linux iommu table */
 	tbl = &pe->tce32_table;
-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0);
+	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
+			IOMMU_PAGE_SHIFT_4K);
 
 	/* OPAL variant of PHB3 invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index e3807d6..94ce348 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -172,7 +172,8 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
 	pnv_pci_setup_iommu_table(&phb->p5ioc2.iommu_table,
-				  tce_mem, tce_size, 0);
+				  tce_mem, tce_size, 0,
+				  IOMMU_PAGE_SHIFT_4K);
 }
 
 void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b6cb996..4dff552 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -628,11 +628,11 @@ static void pnv_tce_free_rm(struct iommu_table *tbl, long index, long npages)
 
 void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 			       void *tce_mem, u64 tce_size,
-			       u64 dma_offset)
+			       u64 dma_offset, unsigned page_shift)
 {
 	tbl->it_blocksize = 16;
 	tbl->it_base = (unsigned long)tce_mem;
-	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
+	tbl->it_page_shift = page_shift;
 	tbl->it_offset = dma_offset >> tbl->it_page_shift;
 	tbl->it_index = 0;
 	tbl->it_size = tce_size >> 3;
@@ -657,7 +657,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 	if (WARN_ON(!tbl))
 		return NULL;
 	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
-				  be32_to_cpup(sizep), 0);
+				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
 	iommu_init_table(tbl, hose->node);
 	iommu_register_group(tbl, pci_domain_nr(hose->bus), 0);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 676232c..6f5ff69 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -198,7 +198,7 @@ int pnv_pci_cfg_write(struct device_node *dn,
 		      int where, int size, u32 val);
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      void *tce_mem, u64 tce_size,
-				      u64 dma_offset);
+				      u64 dma_offset, unsigned page_shift);
 extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
 extern void pnv_pci_init_ioda2_phb(struct device_node *np);
-- 
2.0.0
