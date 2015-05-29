Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E5801A0C69
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:46:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B1C5B2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8kbM861604004
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8kD4P005783
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:13 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 22/34] powerpc/powernv: Implement accessor to TCE
 entry
Date: Fri, 29 May 2015 18:44:46 +1000
Message-Id: <1432889098-22924-23-git-send-email-aik@ozlabs.ru>
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

This replaces direct accesses to TCE table with a helper which
returns an TCE entry address. This does not make difference now but will
when multi-level TCE tables get introduces.

No change in behavior is expected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
Changes:
v9:
* new patch in the series to separate this mechanical change from
functional changes; this is not right before
"powerpc/powernv: Implement multilevel TCE tables" but here in order
to let the next patch - "powerpc/iommu/powernv: Release replaced TCE" -
use pnv_tce() and avoid changing the same code twice
---
 arch/powerpc/platforms/powernv/pci.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4b4c583..b2a32d0 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -572,38 +572,46 @@ struct pci_ops pnv_pci_ops = {
 	.write = pnv_pci_write_config,
 };
 
+static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
+{
+	__be64 *tmp = ((__be64 *)tbl->it_base);
+
+	return tmp + idx;
+}
+
 int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction,
 		struct dma_attrs *attrs)
 {
 	u64 proto_tce = iommu_direction_to_tce_perm(direction);
-	__be64 *tcep;
-	u64 rpn;
+	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
+	long i;
 
-	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
-	rpn = __pa(uaddr) >> tbl->it_page_shift;
-
-	while (npages--)
-		*(tcep++) = cpu_to_be64(proto_tce |
-				(rpn++ << tbl->it_page_shift));
+	for (i = 0; i < npages; i++) {
+		unsigned long newtce = proto_tce |
+			((rpn + i) << tbl->it_page_shift);
+		unsigned long idx = index - tbl->it_offset + i;
 
+		*(pnv_tce(tbl, idx)) = cpu_to_be64(newtce);
+	}
 
 	return 0;
 }
 
 void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 {
-	__be64 *tcep;
+	long i;
 
-	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
+	for (i = 0; i < npages; i++) {
+		unsigned long idx = index - tbl->it_offset + i;
 
-	while (npages--)
-		*(tcep++) = cpu_to_be64(0);
+		*(pnv_tce(tbl, idx)) = cpu_to_be64(0);
+	}
 }
 
 unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 {
-	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
+	return *(pnv_tce(tbl, index - tbl->it_offset));
 }
 
 struct iommu_table *pnv_pci_table_alloc(int nid)
-- 
2.4.0.rc3.8.gfb3e7d5
