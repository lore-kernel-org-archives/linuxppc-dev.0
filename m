Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 218831A0490
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1D3703578056
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGCAS41156716
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFk1f014045
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:46 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 15/32] powerpc/powernv/ioda/ioda2: Rework TCE
 invalidation in tce_build()/tce_free()
Date: Sat, 25 Apr 2015 22:14:39 +1000
Message-Id: <1429964096-11524-16-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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
start and end host addresses of TCE table.

IODA2 actually needs PCI addresses to invalidate the cache. Those
can be calculated from host addresses but since we are going
to implement multi-level TCE tables, calculating PCI address from
a host address might get either tricky or ugly as TCE table remains flat
on PCI bus but not in RAM.

This moves pnv_pci_ioda_tce_invalidate() from generic pnv_tce_build/
pnt_tce_free and defines IODA1/2-specific callbacks which call generic
ones and do PHB-model-specific TCE cache invalidation. P5IOC2 keeps
using generic callbacks as before.

This changes pnv_pci_ioda2_tce_invalidate() to receives TCE index and
number of pages which are PCI addresses shifted by IOMMU page shift.

No change in behaviour is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v9:
* removed confusing comment from commit log about unintentional calling of
pnv_pci_ioda_tce_invalidate()
* moved mechanical changes away to "powerpc/iommu: Move tce_xxx callbacks from ppc_md to iommu_table"
* fixed bug with broken invalidation in pnv_pci_ioda2_tce_invalidate -
@index includes @tbl->it_offset but old code added it anyway which later broke
DDW
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 86 +++++++++++++++++++++----------
 arch/powerpc/platforms/powernv/pci.c      | 17 ++----
 2 files changed, 64 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 718d5cc..f070c44 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1665,18 +1665,20 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	}
 }
 
-static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
-					 struct iommu_table *tbl,
-					 __be64 *startp, __be64 *endp, bool rm)
+static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
 {
+	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
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
@@ -1712,16 +1714,40 @@ static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
 	 */
 }
 
+static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
+		long npages, unsigned long uaddr,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
+{
+	long ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
+			attrs);
+
+	if (!ret && (tbl->it_type & TCE_PCI_SWINV_CREATE))
+		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
+
+	return ret;
+}
+
+static void pnv_ioda1_tce_free(struct iommu_table *tbl, long index,
+		long npages)
+{
+	pnv_tce_free(tbl, index, npages);
+
+	if (tbl->it_type & TCE_PCI_SWINV_FREE)
+		pnv_pci_ioda1_tce_invalidate(tbl, index, npages, false);
+}
+
 static struct iommu_table_ops pnv_ioda1_iommu_ops = {
-	.set = pnv_tce_build,
-	.clear = pnv_tce_free,
+	.set = pnv_ioda1_tce_build,
+	.clear = pnv_ioda1_tce_free,
 	.get = pnv_tce_get,
 };
 
-static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
-					 struct iommu_table *tbl,
-					 __be64 *startp, __be64 *endp, bool rm)
+static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
 {
+	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
+			struct pnv_ioda_pe, table_group);
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
@@ -1734,10 +1760,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	end = start;
 
 	/* Figure out the start, end and step */
-	inc = tbl->it_offset + (((u64)startp - tbl->it_base) / sizeof(u64));
-	start |= (inc << shift);
-	inc = tbl->it_offset + (((u64)endp - tbl->it_base) / sizeof(u64));
-	end |= (inc << shift);
+	start |= (index << shift);
+	end |= ((index + npages - 1) << shift);
 	inc = (0x1ull << shift);
 	mb();
 
@@ -1750,22 +1774,32 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	}
 }
 
-void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-				 __be64 *startp, __be64 *endp, bool rm)
+static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
+		long npages, unsigned long uaddr,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
-	struct pnv_ioda_pe *pe = container_of(tbl->it_table_group,
-			struct pnv_ioda_pe, table_group);
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
+}
+
+static void pnv_ioda2_tce_free(struct iommu_table *tbl, long index,
+		long npages)
+{
+	pnv_tce_free(tbl, index, npages);
+
+	if (tbl->it_type & TCE_PCI_SWINV_FREE)
+		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
 }
 
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
-	.set = pnv_tce_build,
-	.clear = pnv_tce_free,
+	.set = pnv_ioda2_tce_build,
+	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
 };
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4c3bbb1..84b4ea4 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -577,37 +577,28 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		struct dma_attrs *attrs)
 {
 	u64 proto_tce = iommu_direction_to_tce_perm(direction);
-	__be64 *tcep, *tces;
+	__be64 *tcep;
 	u64 rpn;
 
-	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
+	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
 	rpn = __pa(uaddr) >> tbl->it_page_shift;
 
 	while (npages--)
 		*(tcep++) = cpu_to_be64(proto_tce |
 				(rpn++ << tbl->it_page_shift));
 
-	/* Some implementations won't cache invalid TCEs and thus may not
-	 * need that flush. We'll probably turn it_type into a bit mask
-	 * of flags if that becomes the case
-	 */
-	if (tbl->it_type & TCE_PCI_SWINV_CREATE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
 
 	return 0;
 }
 
 void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
-	__be64 *tcep, *tces;
+	__be64 *tcep;
 
-	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
+	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
 
 	while (npages--)
 		*(tcep++) = cpu_to_be64(0);
-
-	if (tbl->it_type & TCE_PCI_SWINV_FREE)
-		pnv_pci_ioda_tce_invalidate(tbl, tces, tcep - 1, false);
 }
 
 unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
-- 
2.0.0
