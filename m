Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1D5F1A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 10 Mar 2015 00:09:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A6FBD2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:12 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29E946k34144340
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:09:12 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29E8d6p022687
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:08:39 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 17/29] powerpc/powernv/ioda/ioda2: Rework
 tce_build()/tce_free()
Date: Tue, 10 Mar 2015 01:07:13 +1100
Message-Id: <1425910045-26167-18-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pnv_pci_ioda_tce_invalidate() helper invalidates TCE cache. It is
supposed to be called on IODA1/2 and not called on p5ioc2. It receives
start and end host addresses of TCE table. This approach makes it possible
to get pnv_pci_ioda_tce_invalidate() unintentionally called on p5ioc2.
Another issue is that IODA2 needs PCI addresses to invalidate the cache
and those can be calculated from host addresses but since we are going
to implement multi-level TCE tables, calculating PCI address from
a host address might get either tricky or ugly as TCE table remains flat
on PCI bus but not in RAM.

This defines separate iommu_table_ops callbacks for p5ioc2 and IODA1/2
PHBs. They all call common pnv_tce_build/pnv_tce_free/pnv_tce_get helpers
but call PHB specific TCE invalidation helper (when needed).

This changes pnv_pci_ioda2_tce_invalidate() to receives TCE index and
number of pages which are PCI addresses shifted by IOMMU page shift.

The patch is pretty mechanical and behaviour is not expected to change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c   | 92 ++++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |  9 ++-
 arch/powerpc/platforms/powernv/pci.c        | 76 +++++++++---------------
 arch/powerpc/platforms/powernv/pci.h        |  7 ++-
 4 files changed, 111 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 67a3fe4..43a7cce 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1067,18 +1067,20 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	}
 }
 
-static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
-					 struct iommu_table *tbl,
-					 __be64 *startp, __be64 *endp, bool rm)
+static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
 {
+	struct pnv_ioda_pe *pe = container_of(tbl->it_group,
+			struct pnv_ioda_pe, table_group);
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
 		(__be64 __iomem *)tbl->it_index;
 	unsigned long start, end, inc;
 	const unsigned shift = tbl->it_page_shift;
 
-	start = __pa(startp);
-	end = __pa(endp);
+	start = __pa((__be64 *)tbl->it_base + index - tbl->it_offset);
+	end = __pa((__be64 *)tbl->it_base + index - tbl->it_offset +
+			npages - 1);
 
 	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
 	if (tbl->it_busno) {
@@ -1114,10 +1116,40 @@ static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
 	 */
 }
 
-static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
-					 struct iommu_table *tbl,
-					 __be64 *startp, __be64 *endp, bool rm)
+static int pnv_ioda1_tce_build_vm(struct iommu_table *tbl, long index,
+		long npages, unsigned long uaddr,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
+	long ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
+			attrs);
+
+	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
+		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
+
+	return ret;
+}
+
+static void pnv_ioda1_tce_free_vm(struct iommu_table *tbl, long index,
+		long npages)
+{
+	pnv_tce_free(tbl, index, npages);
+
+	if (tbl->it_type & TCE_PCI_SWINV_FREE)
+		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
+}
+
+struct iommu_table_ops pnv_ioda1_iommu_ops = {
+	.set = pnv_ioda1_tce_build_vm,
+	.clear = pnv_ioda1_tce_free_vm,
+	.get = pnv_tce_get,
+};
+
+static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
+{
+	struct pnv_ioda_pe *pe = container_of(tbl->it_group,
+			struct pnv_ioda_pe, table_group);
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
@@ -1130,9 +1162,9 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	end = start;
 
 	/* Figure out the start, end and step */
-	inc = tbl->it_offset + (((u64)startp - tbl->it_base) / sizeof(u64));
+	inc = tbl->it_offset + index / sizeof(u64);
 	start |= (inc << shift);
-	inc = tbl->it_offset + (((u64)endp - tbl->it_base) / sizeof(u64));
+	inc = tbl->it_offset + (index + npages - 1) / sizeof(u64);
 	end |= (inc << shift);
 	inc = (0x1ull << shift);
 	mb();
@@ -1146,19 +1178,35 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	}
 }
 
-void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-				 __be64 *startp, __be64 *endp, bool rm)
+static int pnv_ioda2_tce_build_vm(struct iommu_table *tbl, long index,
+		long npages, unsigned long uaddr,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl->it_group, struct pnv_ioda_pe,
-					      table_group);
-	struct pnv_phb *phb = pe->phb;
-
-	if (phb->type == PNV_PHB_IODA1)
-		pnv_pci_ioda1_tce_invalidate(pe, tbl, startp, endp, rm);
-	else
-		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
+	long ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
+			attrs);
+
+	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
+		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
+
+	return ret;
 }
 
+static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
+		long npages)
+{
+	pnv_tce_free(tbl, index, npages);
+
+	if (tbl->it_type & TCE_PCI_SWINV_FREE)
+		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
+}
+
+static struct iommu_table_ops pnv_ioda2_iommu_ops = {
+	.set = pnv_ioda2_tce_build_vm,
+	.clear = pnv_ioda2_tce_free_vm,
+	.get = pnv_tce_get,
+};
+
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				      struct pnv_ioda_pe *pe, unsigned int base,
 				      unsigned int segs)
@@ -1238,7 +1286,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				 TCE_PCI_SWINV_FREE   |
 				 TCE_PCI_SWINV_PAIR);
 	}
-	tbl->it_ops = &pnv_iommu_ops;
+	tbl->it_ops = &pnv_ioda1_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
@@ -1389,7 +1437,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				8);
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
-	tbl->it_ops = &pnv_iommu_ops;
+	tbl->it_ops = &pnv_ioda2_iommu_ops;
 	iommu_init_table(tbl, phb->hose->node);
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index ff68cac..6906a9c 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -83,11 +83,18 @@ static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb)
 static void pnv_pci_init_p5ioc2_msis(struct pnv_phb *phb) { }
 #endif /* CONFIG_PCI_MSI */
 
+static struct iommu_table_ops pnv_p5ioc2_iommu_ops = {
+	.set = pnv_tce_build,
+	.clear = pnv_tce_free,
+	.get = pnv_tce_get,
+};
+
 static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 					 struct pci_dev *pdev)
 {
 	if (phb->p5ioc2.table_group.tables[0].it_map == NULL) {
-		phb->p5ioc2.table_group.tables[0].it_ops = &pnv_iommu_ops;
+		phb->p5ioc2.table_group.tables[0].it_ops =
+				&pnv_p5ioc2_iommu_ops;
 		iommu_init_table(&phb->p5ioc2.table_group.tables[0],
 				phb->hose->node);
 		iommu_register_group(&phb->p5ioc2.table_group,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 3050cc8..a8c05de 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -589,70 +589,48 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
-static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
-			 unsigned long uaddr, enum dma_data_direction direction,
-			 struct dma_attrs *attrs, bool rm)
+static __be64 *pnv_tce(struct iommu_table *tbl, long index)
+{
+	__be64 *tmp = ((__be64 *)tbl->it_base);
+
+	return tmp + index;
+}
+
+int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
 	u64 proto_tce = iommu_direction_to_tce_perm(direction);
-	__be64 *tcep, *tces;
-	u64 rpn;
+	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
+	long i;
 
-	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
-	rpn = __pa(uaddr) >> tbl->it_page_shift;
+	for (i = 0; i < npages; i++) {
+		unsigned long newtce = proto_tce |
+				((rpn + i) << tbl->it_page_shift);
+		unsigned long idx = index - tbl->it_offset + i;
 
-	while (npages--)
-		*(tcep++) = cpu_to_be64(proto_tce |
-				(rpn++ << tbl->it_page_shift));
-
-	/* Some implementations won't cache invalid TCEs and thus may not
-	 * need that flush. We'll probably turn it_type into a bit mask
-	 * of flags if that becomes the case
-	 */
-	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+		*(pnv_tce(tbl, idx)) = cpu_to_be64(newtce);
+	}
 
 	return 0;
 }
 
-static int pnv_tce_build_vm(struct iommu_table *tbl, long index, long npages,
-			    unsigned long uaddr,
-			    enum dma_data_direction direction,
-			    struct dma_attrs *attrs)
+void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
-	return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs,
-			false);
-}
-
-static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
-		bool rm)
-{
-	__be64 *tcep, *tces;
-
-	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
+	long i;
 
-	while (npages--)
-		*(tcep++) = cpu_to_be64(0);
+	for (i = 0; i < npages; i++) {
+		unsigned long idx = index - tbl->it_offset + i;
 
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, rm);
+		*(pnv_tce(tbl, idx)) = cpu_to_be64(0);
+	}
 }
 
-static void pnv_tce_free_vm(struct iommu_table *tbl, long index, long npages)
+unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 {
-	pnv_tce_free(tbl, index, npages, false);
+	return *(pnv_tce(tbl, index));
 }
 
-static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
-{
-	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
-}
-
-struct iommu_table_ops pnv_iommu_ops = {
-	.set = pnv_tce_build_vm,
-	.clear = pnv_tce_free_vm,
-	.get = pnv_tce_get,
-};
-
 void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 			       void *tce_mem, u64 tce_size,
 			       u64 dma_offset, unsigned page_shift)
@@ -685,7 +663,7 @@ static struct iommu_table *pnv_pci_setup_bml_iommu(struct pci_controller *hose)
 		return NULL;
 	pnv_pci_setup_iommu_table(tbl, __va(be64_to_cpup(basep)),
 				  be32_to_cpup(sizep), 0, IOMMU_PAGE_SHIFT_4K);
-	tbl->it_ops = &pnv_iommu_ops;
+	tbl->it_ops = &pnv_ioda1_iommu_ops;
 	iommu_init_table(tbl, hose->node);
 	iommu_register_group(tbl->it_group, pci_domain_nr(hose->bus), 0);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 762d906..0d4df32 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -216,7 +216,12 @@ extern struct pci_ops pnv_pci_ops;
 #ifdef CONFIG_EEH
 extern struct pnv_eeh_ops ioda_eeh_ops;
 #endif
-extern struct iommu_table_ops pnv_iommu_ops;
+extern int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
+		unsigned long uaddr, enum dma_data_direction direction,
+		struct dma_attrs *attrs);
+extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
+extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
+extern struct iommu_table_ops pnv_ioda1_iommu_ops;
 
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
-- 
2.0.0
