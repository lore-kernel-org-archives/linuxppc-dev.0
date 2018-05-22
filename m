Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qqfX6Q4WzDqFj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:12:20 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4M99657113095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:12:18 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4fx095tf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 05:12:17 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 22 May 2018 03:12:17 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] powerpc/mm/hugetlb: Use the correct page size when flushing
 hugepage tlb
Date: Tue, 22 May 2018 14:42:09 +0530
Message-Id: <20180522091209.9084-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We used wrong page size (mmu_virtual_psize) when doing a tlbflush after
pte update. This patch update the flush to use hugetlb page size.
The page size is derived from hugetlb hstate.

Now that ptep_set_access_flags won't be called for hugetlb remove
the is_vm_hugetlb_page() check and add the assert of pte lock
unconditionally.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/hugetlb.h | 19 +++--------------
 arch/powerpc/mm/pgtable.c          | 33 ++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 78540c074d70..b4404a6da74f 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -166,22 +166,9 @@ static inline pte_t huge_pte_wrprotect(pte_t pte)
 	return pte_wrprotect(pte);
 }
 
-static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
-					     unsigned long addr, pte_t *ptep,
-					     pte_t pte, int dirty)
-{
-#ifdef HUGETLB_NEED_PRELOAD
-	/*
-	 * The "return 1" forces a call of update_mmu_cache, which will write a
-	 * TLB entry.  Without this, platforms that don't do a write of the TLB
-	 * entry in the TLB miss handler asm will fault ad infinitum.
-	 */
-	ptep_set_access_flags(vma, addr, ptep, pte, dirty);
-	return 1;
-#else
-	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
-#endif
-}
+extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *ptep,
+				      pte_t pte, int dirty);
 
 static inline pte_t huge_ptep_get(pte_t *ptep)
 {
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9f361ae571e9..e70af9939379 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -221,14 +221,43 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	entry = set_access_flags_filter(entry, vma, dirty);
 	changed = !pte_same(*(ptep), entry);
 	if (changed) {
-		if (!is_vm_hugetlb_page(vma))
-			assert_pte_locked(vma->vm_mm, address);
+		assert_pte_locked(vma->vm_mm, address);
 		__ptep_set_access_flags(vma->vm_mm, ptep, entry, address);
 		flush_tlb_page(vma, address);
 	}
 	return changed;
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
+extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+				      unsigned long addr, pte_t *ptep,
+				      pte_t pte, int dirty)
+{
+#ifdef HUGETLB_NEED_PRELOAD
+	/*
+	 * The "return 1" forces a call of update_mmu_cache, which will write a
+	 * TLB entry.  Without this, platforms that don't do a write of the TLB
+	 * entry in the TLB miss handler asm will fault ad infinitum.
+	 */
+	ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+	return 1;
+#else
+	int changed;
+
+	pte = set_access_flags_filter(pte, vma, dirty);
+	changed = !pte_same(*(ptep), pte);
+	if (changed) {
+#ifdef CONFIG_DEBUG_VM
+		assert_spin_locked(&vma->vm_mm->page_table_lock);
+#endif
+		__ptep_set_access_flags(vma->vm_mm, ptep, pte, addr);
+		flush_hugetlb_page(vma, addr);
+	}
+	return changed;
+#endif
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #ifdef CONFIG_DEBUG_VM
 void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 {
-- 
2.17.0
