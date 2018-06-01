Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xy6s23sGzF0Tj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 18:24:37 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w518JWkJ133890
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2018 04:24:35 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jayhwfeqx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 04:24:34 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 1 Jun 2018 02:24:34 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/mm/hugetlb: Update hugetlb related locks
Date: Fri,  1 Jun 2018 13:54:24 +0530
Message-Id: <20180601082424.17393-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With split pmd page table lock enabled, we don't use mm->page_table_lock when
updating pmd entries. This patch update hugetlb path to use the right lock
when inserting huge page directory entries into page table.

ex: if we are using hugepd and inserting hugepd entry at the pmd level, we
use pmd_lockptr, which based on config can be split pmd lock.

For update huge page directory entries itself we use mm->page_table_lock. We
do have a helper huge_pte_lockptr() for that.

Fixes: 675d99529 ("powerpc/book3s64: Enable split pmd ptlock")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 33 +++++++++++++++++++++++----------
 arch/powerpc/mm/pgtable.c     | 12 +++++++-----
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 2a4b1bf8bde6..7c5f479c5c00 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -52,7 +52,8 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr, unsigned long s
 }
 
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
-			   unsigned long address, unsigned pdshift, unsigned pshift)
+			   unsigned long address, unsigned int pdshift,
+			   unsigned int pshift, spinlock_t *ptl)
 {
 	struct kmem_cache *cachep;
 	pte_t *new;
@@ -82,8 +83,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	 */
 	smp_wmb();
 
-	spin_lock(&mm->page_table_lock);
-
+	spin_lock(ptl);
 	/*
 	 * We have multiple higher-level entries that point to the same
 	 * actual pte location.  Fill in each as we go and backtrack on error.
@@ -113,7 +113,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			*hpdp = __hugepd(0);
 		kmem_cache_free(cachep, new);
 	}
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock(ptl);
 	return 0;
 }
 
@@ -138,6 +138,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	hugepd_t *hpdp = NULL;
 	unsigned pshift = __ffs(sz);
 	unsigned pdshift = PGDIR_SHIFT;
+	spinlock_t *ptl;
 
 	addr &= ~(sz-1);
 	pg = pgd_offset(mm, addr);
@@ -146,39 +147,46 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	if (pshift == PGDIR_SHIFT)
 		/* 16GB huge page */
 		return (pte_t *) pg;
-	else if (pshift > PUD_SHIFT)
+	else if (pshift > PUD_SHIFT) {
 		/*
 		 * We need to use hugepd table
 		 */
+		ptl = &mm->page_table_lock;
 		hpdp = (hugepd_t *)pg;
-	else {
+	} else {
 		pdshift = PUD_SHIFT;
 		pu = pud_alloc(mm, pg, addr);
 		if (pshift == PUD_SHIFT)
 			return (pte_t *)pu;
-		else if (pshift > PMD_SHIFT)
+		else if (pshift > PMD_SHIFT) {
+			ptl = pud_lockptr(mm, pu);
 			hpdp = (hugepd_t *)pu;
-		else {
+		} else {
 			pdshift = PMD_SHIFT;
 			pm = pmd_alloc(mm, pu, addr);
 			if (pshift == PMD_SHIFT)
 				/* 16MB hugepage */
 				return (pte_t *)pm;
-			else
+			else {
+				ptl = pmd_lockptr(mm, pm);
 				hpdp = (hugepd_t *)pm;
+			}
 		}
 	}
 #else
 	if (pshift >= HUGEPD_PGD_SHIFT) {
+		ptl = &mm->page_table_lock;
 		hpdp = (hugepd_t *)pg;
 	} else {
 		pdshift = PUD_SHIFT;
 		pu = pud_alloc(mm, pg, addr);
 		if (pshift >= HUGEPD_PUD_SHIFT) {
+			ptl = pud_lockptr(mm, pu);
 			hpdp = (hugepd_t *)pu;
 		} else {
 			pdshift = PMD_SHIFT;
 			pm = pmd_alloc(mm, pu, addr);
+			ptl = pmd_lockptr(mm, pm);
 			hpdp = (hugepd_t *)pm;
 		}
 	}
@@ -188,7 +196,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
 
-	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr, pdshift, pshift))
+	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr,
+						  pdshift, pshift, ptl))
 		return NULL;
 
 	return hugepte_offset(*hpdp, addr, pdshift);
@@ -499,6 +508,10 @@ struct page *follow_huge_pd(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 retry:
+	/*
+	 * hugepage directory entries are protected by mm->page_table_lock
+	 * Use this instead of huge_pte_lockptr
+	 */
 	ptl = &mm->page_table_lock;
 	spin_lock(ptl);
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 5281c2c064af..d71c7777669c 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -249,17 +249,19 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (changed) {
 
 #ifdef CONFIG_PPC_BOOK3S_64
-		struct hstate *hstate = hstate_file(vma->vm_file);
-		psize = hstate_get_psize(hstate);
+		struct hstate *h = hstate_vma(vma);
+
+		psize = hstate_get_psize(h);
+#ifdef CONFIG_DEBUG_VM
+		assert_spin_locked(huge_pte_lockptr(h, vma->vm_mm, ptep));
+#endif
+
 #else
 		/*
 		 * Not used on non book3s64 platforms. But 8xx
 		 * can possibly use tsize derived from hstate.
 		 */
 		psize = 0;
-#endif
-#ifdef CONFIG_DEBUG_VM
-		assert_spin_locked(&vma->vm_mm->page_table_lock);
 #endif
 		__ptep_set_access_flags(vma, ptep, pte, addr, psize);
 	}
-- 
2.17.0
