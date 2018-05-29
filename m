Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wGLt6zYzzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 00:29:10 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TENtkH046889
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 10:29:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j97n7u8s2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 10:29:07 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 29 May 2018 10:29:06 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 3/4] powerpc/mm: Change function prototype
Date: Tue, 29 May 2018 19:58:40 +0530
In-Reply-To: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
References: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180529142841.19428-3-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In later patch, we use the vma and psize to do tlb flush. Do the prototype
update in separate patch to make the review easy.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  5 +++--
 arch/powerpc/include/asm/book3s/64/pgtable.h |  8 +++++---
 arch/powerpc/include/asm/book3s/64/radix.h   |  5 +++--
 arch/powerpc/include/asm/nohash/32/pgtable.h |  5 +++--
 arch/powerpc/include/asm/nohash/64/pgtable.h |  5 +++--
 arch/powerpc/mm/pgtable-book3s64.c           |  8 ++++++--
 arch/powerpc/mm/pgtable-radix.c              |  6 +++---
 arch/powerpc/mm/pgtable.c                    | 18 +++++++++++++++---
 8 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c615abdce119..39d3a4245694 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -235,9 +235,10 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 
-static inline void __ptep_set_access_flags(struct mm_struct *mm,
+static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
-					   unsigned long address)
+					   unsigned long address,
+					   int psize)
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c233915abb68..42fe7c2ff2df 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -767,12 +767,14 @@ static inline bool check_pte_access(unsigned long access, unsigned long ptev)
  * Generic functions with hash/radix callbacks
  */
 
-static inline void __ptep_set_access_flags(struct mm_struct *mm,
+static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
-					   unsigned long address)
+					   unsigned long address,
+					   int psize)
 {
 	if (radix_enabled())
-		return radix__ptep_set_access_flags(mm, ptep, entry, address);
+		return radix__ptep_set_access_flags(vma, ptep, entry,
+						    address, psize);
 	return hash__ptep_set_access_flags(ptep, entry);
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 36ed025b4e13..62a73a7a78a4 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -124,8 +124,9 @@ extern void radix__mark_rodata_ro(void);
 extern void radix__mark_initmem_nx(void);
 #endif
 
-extern void radix__ptep_set_access_flags(struct mm_struct *mm, pte_t *ptep,
-					 pte_t entry, unsigned long address);
+extern void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
+					 pte_t entry, unsigned long address,
+					 int psize);
 
 static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 					       unsigned long set)
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 987a658b18e1..c2471bac86b9 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -256,9 +256,10 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 
-static inline void __ptep_set_access_flags(struct mm_struct *mm,
+static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
-					   unsigned long address)
+					   unsigned long address,
+					   int psize)
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index de78eda5f841..180161d714fb 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -281,9 +281,10 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 /* Set the dirty and/or accessed bits atomically in a linux PTE, this
  * function doesn't need to flush the hash entry
  */
-static inline void __ptep_set_access_flags(struct mm_struct *mm,
+static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
-					   unsigned long address)
+					   unsigned long address,
+					   int psize)
 {
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index abda2b92f1ba..4a8150481a88 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -46,8 +46,12 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 #endif
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
-		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
-					pmd_pte(entry), address);
+		/*
+		 * We can use MMU_PAGE_2M here, because only radix
+		 * path look at the psize.
+		 */
+		__ptep_set_access_flags(vma, pmdp_ptep(pmdp),
+					pmd_pte(entry), address, MMU_PAGE_2M);
 		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index a6eec41dd347..2034cbc9aa56 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1085,10 +1085,10 @@ int radix__has_transparent_hugepage(void)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-void radix__ptep_set_access_flags(struct mm_struct *mm,
-				  pte_t *ptep, pte_t entry,
-				  unsigned long address)
+void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
+				  pte_t entry, unsigned long address, int psize)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
 					      _PAGE_RW | _PAGE_EXEC);
 
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index e70af9939379..20cacd33e5be 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -222,7 +222,8 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	changed = !pte_same(*(ptep), entry);
 	if (changed) {
 		assert_pte_locked(vma->vm_mm, address);
-		__ptep_set_access_flags(vma->vm_mm, ptep, entry, address);
+		__ptep_set_access_flags(vma, ptep, entry,
+					address, mmu_virtual_psize);
 		flush_tlb_page(vma, address);
 	}
 	return changed;
@@ -242,15 +243,26 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 	return 1;
 #else
-	int changed;
+	int changed, psize;
 
 	pte = set_access_flags_filter(pte, vma, dirty);
 	changed = !pte_same(*(ptep), pte);
 	if (changed) {
+
+#ifdef CONFIG_PPC_BOOK3S_64
+		struct hstate *hstate = hstate_file(vma->vm_file);
+		psize = hstate_get_psize(hstate);
+#else
+		/*
+		 * Not used on non book3s64 platforms. But 8xx
+		 * can possibly use tsize derived from hstate.
+		 */
+		psize = 0;
+#endif
 #ifdef CONFIG_DEBUG_VM
 		assert_spin_locked(&vma->vm_mm->page_table_lock);
 #endif
-		__ptep_set_access_flags(vma->vm_mm, ptep, pte, addr);
+		__ptep_set_access_flags(vma, ptep, pte, addr, psize);
 		flush_hugetlb_page(vma, addr);
 	}
 	return changed;
-- 
2.17.0
