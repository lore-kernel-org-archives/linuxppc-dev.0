Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRsTS1Q2KzDqbr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 19:24:12 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G9NwkT109385
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:24:00 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afv7bf24h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:24:00 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 May 2017 03:23:49 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 2/9] mm/follow_page_mask: Split follow_page_mask to smaller
 functions.
Date: Tue, 16 May 2017 14:53:25 +0530
In-Reply-To: <1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1494926612-23928-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Makes code reading easy. No functional changes in this patch. In a followup
patch, we will be updating the follow_page_mask to handle hugetlb hugepd format
so that archs like ppc64 can switch to the generic version. This split helps
in doing that nicely.

Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/gup.c | 148 +++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 91 insertions(+), 57 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 04aa405350dc..73d46f9f7b81 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -208,68 +208,16 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	return no_page_table(vma, flags);
 }
 
-/**
- * follow_page_mask - look up a page descriptor from a user-virtual address
- * @vma: vm_area_struct mapping @address
- * @address: virtual address to look up
- * @flags: flags modifying lookup behaviour
- * @page_mask: on output, *page_mask is set according to the size of the page
- *
- * @flags can have FOLL_ flags set, defined in <linux/mm.h>
- *
- * Returns the mapped (struct page *), %NULL if no mapping exists, or
- * an error pointer if there is a mapping to something not represented
- * by a page descriptor (see also vm_normal_page()).
- */
-struct page *follow_page_mask(struct vm_area_struct *vma,
-			      unsigned long address, unsigned int flags,
-			      unsigned int *page_mask)
+static struct page *follow_pmd_mask(struct vm_area_struct *vma,
+				    unsigned long address, pud_t *pudp,
+				    unsigned int flags, unsigned int *page_mask)
 {
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
 	pmd_t *pmd;
 	spinlock_t *ptl;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
-	*page_mask = 0;
-
-	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
-	if (!IS_ERR(page)) {
-		BUG_ON(flags & FOLL_GET);
-		return page;
-	}
-
-	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		return no_page_table(vma, flags);
-	p4d = p4d_offset(pgd, address);
-	if (p4d_none(*p4d))
-		return no_page_table(vma, flags);
-	BUILD_BUG_ON(p4d_huge(*p4d));
-	if (unlikely(p4d_bad(*p4d)))
-		return no_page_table(vma, flags);
-	pud = pud_offset(p4d, address);
-	if (pud_none(*pud))
-		return no_page_table(vma, flags);
-	if (pud_huge(*pud) && vma->vm_flags & VM_HUGETLB) {
-		page = follow_huge_pud(mm, address, pud, flags);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
-	if (pud_devmap(*pud)) {
-		ptl = pud_lock(mm, pud);
-		page = follow_devmap_pud(vma, address, pud, flags);
-		spin_unlock(ptl);
-		if (page)
-			return page;
-	}
-	if (unlikely(pud_bad(*pud)))
-		return no_page_table(vma, flags);
-
-	pmd = pmd_offset(pud, address);
+	pmd = pmd_offset(pudp, address);
 	if (pmd_none(*pmd))
 		return no_page_table(vma, flags);
 	if (pmd_huge(*pmd) && vma->vm_flags & VM_HUGETLB) {
@@ -319,13 +267,99 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
 		return ret ? ERR_PTR(ret) :
 			follow_page_pte(vma, address, pmd, flags);
 	}
-
 	page = follow_trans_huge_pmd(vma, address, pmd, flags);
 	spin_unlock(ptl);
 	*page_mask = HPAGE_PMD_NR - 1;
 	return page;
 }
 
+
+static struct page *follow_pud_mask(struct vm_area_struct *vma,
+				    unsigned long address, p4d_t *p4dp,
+				    unsigned int flags, unsigned int *page_mask)
+{
+	pud_t *pud;
+	spinlock_t *ptl;
+	struct page *page;
+	struct mm_struct *mm = vma->vm_mm;
+
+	pud = pud_offset(p4dp, address);
+	if (pud_none(*pud))
+		return no_page_table(vma, flags);
+	if (pud_huge(*pud) && vma->vm_flags & VM_HUGETLB) {
+		page = follow_huge_pud(mm, address, pud, flags);
+		if (page)
+			return page;
+		return no_page_table(vma, flags);
+	}
+	if (pud_devmap(*pud)) {
+		ptl = pud_lock(mm, pud);
+		page = follow_devmap_pud(vma, address, pud, flags);
+		spin_unlock(ptl);
+		if (page)
+			return page;
+	}
+	if (unlikely(pud_bad(*pud)))
+		return no_page_table(vma, flags);
+
+	return follow_pmd_mask(vma, address, pud, flags, page_mask);
+}
+
+
+static struct page *follow_p4d_mask(struct vm_area_struct *vma,
+				    unsigned long address, pgd_t *pgdp,
+				    unsigned int flags, unsigned int *page_mask)
+{
+	p4d_t *p4d;
+
+	p4d = p4d_offset(pgdp, address);
+	if (p4d_none(*p4d))
+		return no_page_table(vma, flags);
+	BUILD_BUG_ON(p4d_huge(*p4d));
+	if (unlikely(p4d_bad(*p4d)))
+		return no_page_table(vma, flags);
+
+	return follow_pud_mask(vma, address, p4d, flags, page_mask);
+}
+
+/**
+ * follow_page_mask - look up a page descriptor from a user-virtual address
+ * @vma: vm_area_struct mapping @address
+ * @address: virtual address to look up
+ * @flags: flags modifying lookup behaviour
+ * @page_mask: on output, *page_mask is set according to the size of the page
+ *
+ * @flags can have FOLL_ flags set, defined in <linux/mm.h>
+ *
+ * Returns the mapped (struct page *), %NULL if no mapping exists, or
+ * an error pointer if there is a mapping to something not represented
+ * by a page descriptor (see also vm_normal_page()).
+ */
+struct page *follow_page_mask(struct vm_area_struct *vma,
+			      unsigned long address, unsigned int flags,
+			      unsigned int *page_mask)
+{
+	pgd_t *pgd;
+	struct page *page;
+	struct mm_struct *mm = vma->vm_mm;
+
+	*page_mask = 0;
+
+	/* make this handle hugepd */
+	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
+	if (!IS_ERR(page)) {
+		BUG_ON(flags & FOLL_GET);
+		return page;
+	}
+
+	pgd = pgd_offset(mm, address);
+
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		return no_page_table(vma, flags);
+
+	return follow_p4d_mask(vma, address, pgd, flags, page_mask);
+}
+
 static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		unsigned int gup_flags, struct vm_area_struct **vma,
 		struct page **page)
-- 
2.7.4
