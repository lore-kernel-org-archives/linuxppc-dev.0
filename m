Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EF581A032F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:22 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:22 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6FDD13578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:19 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F92b3a11207142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:02:37 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PIuh026043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:19 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/7] powerpc/iommu: Support real mode
Date: Tue, 15 Jul 2014 19:25:06 +1000
Message-Id: <1405416311-12429-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
References: <1405416311-12429-1-git-send-email-aik@ozlabs.ru>
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

The TCE tables handling differs for real (MMU off) and virtual modes
(MMU on) so additional set of realmode-capable TCE callbacks has
been added to ppc_md:
* tce_build_rm
* tce_free_rm
* tce_flush_rm

This makes use of new ppc_md calls in iommu_clear_tces_and_put_pages.

This changes iommu_tce_build() to handle multiple pages at once under
the same lock. tce_flush() is called once per call.

This adds a memory barrier after flushing TCE table changes.

This removes comment about "hwaddr" as now it is an array called "hpas"
and "hpa" is descriptive enough acronym.

This does not clear TCE for a huge page in real mode and passes handling
of this to virtual mode.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 107 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 8771b73..dd68569 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1021,53 +1021,108 @@ int iommu_clear_tces_and_put_pages(struct iommu_table *tbl,
 		unsigned long entry, unsigned long pages,
 		bool realmode)
 {
-	unsigned long oldtce;
-	struct page *page;
+	int i, ret = 0, to_free = 0;
 
-	for ( ; pages; --pages, ++entry) {
-		oldtce = iommu_clear_tce(tbl, entry);
-		if (!oldtce)
+	if (realmode && !ppc_md.tce_free_rm)
+		return -EAGAIN;
+
+	for (i = 0; i < pages; ++i) {
+		unsigned long oldtce = ppc_md.tce_get(tbl, entry + i);
+
+		if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
 			continue;
 
-		page = pfn_to_page(oldtce >> PAGE_SHIFT);
-		WARN_ON(!page);
-		if (page) {
-			if (oldtce & TCE_PCI_WRITE)
-				SetPageDirty(page);
-			put_page(page);
+		if (realmode) {
+			struct page *pg = realmode_pfn_to_page(
+					oldtce >> PAGE_SHIFT);
+			if (!pg) {
+				ret = -EAGAIN;
+			} else if (PageCompound(pg)) {
+				ret = -EAGAIN;
+			} else {
+				if (oldtce & TCE_PCI_WRITE)
+					SetPageDirty(pg);
+				if (!put_page_unless_one(pg))
+					ret = -EAGAIN;
+			}
+		} else {
+			struct page *pg = pfn_to_page(oldtce >> PAGE_SHIFT);
+
+			if (!pg) {
+				ret = -EAGAIN;
+			} else {
+				if (oldtce & TCE_PCI_WRITE)
+					SetPageDirty(pg);
+				put_page(pg);
+			}
 		}
+		if (ret)
+			break;
+		to_free = i + 1;
 	}
 
-	return 0;
+	if (to_free) {
+		if (realmode)
+			ppc_md.tce_free_rm(tbl, entry, to_free);
+		else
+			ppc_md.tce_free(tbl, entry, to_free);
+
+		if (realmode && ppc_md.tce_flush_rm)
+			ppc_md.tce_flush_rm(tbl);
+		else if (!realmode && ppc_md.tce_flush)
+			ppc_md.tce_flush(tbl);
+	}
+
+	/* Make sure updates are seen by hardware */
+	mb();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_clear_tces_and_put_pages);
 
-/*
- * hwaddr is a kernel virtual address here (0xc... bazillion),
- * tce_build converts it to a physical address.
- */
 int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 		unsigned long *hpas, unsigned long npages, bool realmode)
 {
-	int ret = -EBUSY;
-	unsigned long oldtce;
-	struct iommu_pool *pool = get_pool(tbl, entry);
-	enum dma_data_direction direction = iommu_tce_direction(*hpas);
+	int i, ret = 0;
 
-	spin_lock(&(pool->lock));
+	if (realmode && !ppc_md.tce_build_rm)
+		return -EAGAIN;
 
-	ret = ppc_md.tce_build(tbl, entry, 1, *hpas, &oldtce,
-			direction, NULL);
+	for (i = 0; i < npages; ++i) {
+		unsigned long hva = (unsigned long) __va(hpas[i]);
+		enum dma_data_direction dir = iommu_tce_direction(hva);
+		unsigned long oldtce = 0;
 
-	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
-		put_page(pfn_to_page(__pa(oldtce)));
+		if (realmode) {
+			ret = ppc_md.tce_build_rm(tbl, entry + i, 1,
+					hva, &oldtce, dir, NULL);
+			if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)) {
+				ppc_md.tce_build_rm(tbl, entry + i, 1,
+						oldtce, &hva, dir, NULL);
+				ret = -EAGAIN;
+			}
+		} else {
+			ret = ppc_md.tce_build(tbl, entry + i, 1,
+					hva, &oldtce, dir, NULL);
 
-	spin_unlock(&(pool->lock));
+			if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
+				put_page(pfn_to_page(__pa(oldtce)));
+		}
+		if (ret)
+			break;
+	}
+
+	if (realmode && ppc_md.tce_flush_rm)
+		ppc_md.tce_flush_rm(tbl);
+	else if (!realmode && ppc_md.tce_flush)
+		ppc_md.tce_flush(tbl);
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
 			__func__, hwaddr, entry << tbl->it_page_shift,
 				hwaddr, ret); */
+	/* Make sure updates are seen by hardware */
+	mb();
 
 	return ret;
 }
-- 
2.0.0
