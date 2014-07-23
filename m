Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BB2F1A01C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:16 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 23 Jul 2014 13:06:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 886053578023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N35u9c2359562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:05:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N36BJU018441
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:06:12 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/18] powerpc/powernv: Make invalidate() callback an
 iommu_table callback
Date: Wed, 23 Jul 2014 13:05:54 +1000
Message-Id: <1406084764-24685-9-git-send-email-aik@ozlabs.ru>
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

This implements pnv_pci_ioda(1|2)_tce_invalidate as a callback
of iommu_table to simplify code structure. The callbacks receive
iommu_table only and cast it to PE, the specific callback knows how.

This registers invalidate() callbacks for IODA1 and IODA2:
- pnv_pci_ioda1_tce_invalidate;
- pnv_pci_ioda2_tce_invalidate_32.

There will be another pnv_pci_ioda2_tce_invalidate_64() callback for
huge DMA windows.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |  4 ++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 19 +++++++++----------
 arch/powerpc/platforms/powernv/pci.c      | 27 +++++++++++++++++++--------
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 42632c7..d8fb3fa 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -60,6 +60,9 @@ struct iommu_pool {
 	spinlock_t lock;
 } ____cacheline_aligned_in_smp;
 
+typedef void (*iommu_invalidate_fn)(struct iommu_table *tbl,
+		__be64 *startp, __be64 *endp, bool rm);
+
 struct iommu_table {
 	unsigned long  it_busno;     /* Bus number this table belongs to */
 	unsigned long  it_size;      /* Size of iommu table in entries */
@@ -77,6 +80,7 @@ struct iommu_table {
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *it_group;
 #endif
+	iommu_invalidate_fn invalidate;
 	void (*set_bypass)(struct iommu_table *tbl, bool enable);
 };
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9f28e18..48e2358 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -505,10 +505,11 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 	}
 }
 
-static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
-					 struct iommu_table *tbl,
+static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
 					 __be64 *startp, __be64 *endp, bool rm)
 {
+	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
+					      tce32_table);
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
 		(__be64 __iomem *)tbl->it_index;
@@ -584,17 +585,13 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	}
 }
 
-void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-				 __be64 *startp, __be64 *endp, bool rm)
+static void pnv_pci_ioda2_tce_invalidate_32(struct iommu_table *tbl,
+		__be64 *startp, __be64 *endp, bool rm)
 {
 	struct pnv_ioda_pe *pe = container_of(tbl, struct pnv_ioda_pe,
-					      tce32_table);
-	struct pnv_phb *phb = pe->phb;
+			tce32_table);
 
-	if (phb->type == PNV_PHB_IODA1)
-		pnv_pci_ioda1_tce_invalidate(pe, tbl, startp, endp, rm);
-	else
-		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
+	pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
 }
 
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
@@ -657,6 +654,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	tbl = &pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
 				  base << 28, IOMMU_PAGE_SHIFT_4K);
+	tbl->invalidate = pnv_pci_ioda1_tce_invalidate;
 
 	/* OPAL variant of P7IOC SW invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
@@ -788,6 +786,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	tbl = &pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
 			IOMMU_PAGE_SHIFT_4K);
+	tbl->invalidate = pnv_pci_ioda2_tce_invalidate_32;
 
 	/* OPAL variant of PHB3 invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4dff552..1ab0f62 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -550,6 +550,23 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
+static void pnv_tce_invalidate(struct iommu_table *tbl, __be64 *startp,
+	__be64 *endp, bool rm)
+{
+	/*
+	 * Some implementations won't cache invalid TCEs and thus may not
+	 * need that flush. We'll probably turn it_type into a bit mask
+	 * of flags if that becomes the case
+	 */
+	if (!(tbl->it_type & TCE_PCI_SWINV_FREE))
+		return;
+
+	if (!tbl->invalidate)
+		return;
+
+	tbl->invalidate(tbl, startp, endp, rm);
+}
+
 static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			 unsigned long uaddr, enum dma_data_direction direction,
 			 struct dma_attrs *attrs, bool rm)
@@ -570,12 +587,7 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		*(tcep++) = cpu_to_be64(proto_tce |
 				(rpn++ << tbl->it_page_shift));
 
-	/* Some implementations won't cache invalid TCEs and thus may not
-	 * need that flush. We'll probably turn it_type into a bit mask
-	 * of flags if that becomes the case
-	 */
-	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+	pnv_tce_invalidate(tbl, tces, tcep - 1, rm);
 
 	return 0;
 }
@@ -599,8 +611,7 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
 	while (npages--)
 		*(tcep++) = cpu_to_be64(0);
 
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+	pnv_tce_invalidate(tbl, tces, tcep - 1, rm);
 }
 
 static void pnv_tce_free_vm(struct iommu_table *tbl, long index, long npages)
-- 
2.0.0
