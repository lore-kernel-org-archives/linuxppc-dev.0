Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EB241A0D66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D8998357805A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kEv064946420
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:22 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jmQk004865
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 15/34] powerpc/powernv/ioda/ioda2: Rework TCE
 invalidation in tce_build()/tce_free()
Date: Fri, 29 May 2015 18:44:39 +1000
Message-Id: <1432889098-22924-16-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
Changes:
v11:
* changed type of some "ret" to int as everywhere else

v10:
* moved before "Switch from iommu_table to new iommu_table_group" as it adds
list of groups to iommu_table and tce invalidation depends on it

v9:
* removed confusing comment from commit log about unintentional calling of
pnv_pci_ioda_tce_invalidate()
* moved mechanical changes away to "powerpc/iommu: Move tce_xxx callbacks from ppc_md to iommu_table"
* fixed bug with broken invalidation in pnv_pci_ioda2_tce_invalidate -
@index includes @tbl->it_offset but old code added it anyway which later broke
DDW
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 81 ++++++++++++++++++++++---------
 arch/powerpc/platforms/powernv/pci.c      | 17 ++-----
 2 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2924abe..3d32c37 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1678,18 +1678,19 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 	}
 }
 
-static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
-					 struct iommu_table *tbl,
-					 __be64 *startp, __be64 *endp, bool rm)
+static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
+		unsigned long index, unsigned long npages, bool rm)
 {
+	struct pnv_ioda_pe *pe = tbl->data;
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
 		(__be64 __iomem *)tbl->it_index;
 	unsigned long start, end, inc;
 	const unsigned shift = tbl->it_page_shift;
 
-	start = __pa(startp);
-	end = __pa(endp);
+	start = __pa(((__be64 *)tbl->it_base) + index - tbl->it_offset);
+	end = __pa(((__be64 *)tbl->it_base) + index - tbl->it_offset +
+			npages - 1);
 
 	/* BML uses this case for p6/p7/galaxy2: Shift addr and put in node */
 	if (tbl->it_busno) {
@@ -1725,16 +1726,39 @@ static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
 	 */
 }
 
+static int pnv_ioda1_tce_build(struct iommu_table *tbl, long index,
+		long npages, unsigned long uaddr,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
+{
+	int ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
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
+	struct pnv_ioda_pe *pe = tbl->data;
 	unsigned long start, end, inc;
 	__be64 __iomem *invalidate = rm ?
 		(__be64 __iomem *)pe->tce_inval_reg_phys :
@@ -1747,10 +1771,8 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
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
 
@@ -1763,21 +1785,32 @@ static void pnv_pci_ioda2_tce_invalidate(struct pnv_ioda_pe *pe,
 	}
 }
 
-void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
-				 __be64 *startp, __be64 *endp, bool rm)
+static int pnv_ioda2_tce_build(struct iommu_table *tbl, long index,
+		long npages, unsigned long uaddr,
+		enum dma_data_direction direction,
+		struct dma_attrs *attrs)
 {
-	struct pnv_ioda_pe *pe = tbl->data;
-	struct pnv_phb *phb = pe->phb;
+	int ret = pnv_tce_build(tbl, index, npages, uaddr, direction,
+			attrs);
 
-	if (phb->type == PNV_PHB_IODA1)
-		pnv_pci_ioda1_tce_invalidate(pe, tbl, startp, endp, rm);
-	else
-		pnv_pci_ioda2_tce_invalidate(pe, tbl, startp, endp, rm);
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
2.4.0.rc3.8.gfb3e7d5
