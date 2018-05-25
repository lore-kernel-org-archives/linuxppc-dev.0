Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40srKS137HzF1yq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 01:49:31 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4PFivCe126684
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:49:29 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j6jw4ft1y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 11:49:29 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 25 May 2018 09:49:28 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/mm/radix: Change pte relax sequence to handle
 nest MMU hang
Date: Fri, 25 May 2018 21:19:17 +0530
In-Reply-To: <20180525154917.23163-1-aneesh.kumar@linux.ibm.com>
References: <20180525154917.23163-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180525154917.23163-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When relaxing access (read -> read_write update), pte need to be marked invalid
to handle a nest MMU bug. We also need to do a tlb flush after the pte is
marked invalid before updating the pte with new access bits.

We also move tlb flush to platform specific __ptep_set_access_flags. This will
help us to gerid of unnecessary tlb flush on BOOK3S 64 later. We don't do that
in this patch. This also helps in avoiding multiple tlbies with coprocessor
attached.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  8 ++++++--
 arch/powerpc/include/asm/book3s/64/pgtable.h |  8 +++++---
 arch/powerpc/include/asm/book3s/64/radix.h   |  5 +++--
 arch/powerpc/include/asm/nohash/32/pgtable.h |  7 +++++--
 arch/powerpc/include/asm/nohash/64/pgtable.h |  7 +++++--
 arch/powerpc/mm/pgtable-book3s64.c           |  9 ++++++---
 arch/powerpc/mm/pgtable-radix.c              | 20 +++++++++++++-------
 arch/powerpc/mm/pgtable.c                    | 11 ++++++-----
 8 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c615abdce119..9b4e95f3070b 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -235,15 +235,19 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
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
 	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
 
 	pte_update(ptep, clr, set);
+
+	flush_tlb_page(vma, address);
+
 }
 
 #define __HAVE_ARCH_PTE_SAME
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
index ff642441aaf6..9fec7724751d 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -127,8 +127,9 @@ extern void radix__mark_initmem_nx(void);
 extern unsigned long radix__pte_update(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep, unsigned long clr,
 				       unsigned long set, int huge);
-extern void radix__ptep_set_access_flags(struct mm_struct *mm, pte_t *ptep,
-					 pte_t entry, unsigned long address);
+extern void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
+					 pte_t entry, unsigned long address,
+					 int psize);
 
 static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 					       unsigned long set)
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 987a658b18e1..7c46a98cc7f4 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -256,15 +256,18 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
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
 	unsigned long clr = ~pte_val(entry) & (_PAGE_RO | _PAGE_NA);
 
 	pte_update(ptep, clr, set);
+
+	flush_tlb_page(vma, address);
 }
 
 static inline int pte_young(pte_t pte)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index de78eda5f841..dd0c7236208f 100644
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
@@ -303,6 +304,8 @@ static inline void __ptep_set_access_flags(struct mm_struct *mm,
 	unsigned long old = pte_val(*ptep);
 	*ptep = __pte(old | bits);
 #endif
+
+	flush_tlb_page(vma, address);
 }
 
 #define __HAVE_ARCH_PTE_SAME
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index abda2b92f1ba..82fed87289de 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -46,9 +46,12 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 #endif
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
-		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
-					pmd_pte(entry), address);
-		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+		/*
+		 * We can use MMU_PAGE_2M here, because only radix
+		 * path look at the psize.
+		 */
+		__ptep_set_access_flags(vma, pmdp_ptep(pmdp),
+					pmd_pte(entry), address, MMU_PAGE_2M);
 	}
 	return changed;
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 68931ca549f7..5073a2efa123 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1111,14 +1111,18 @@ unsigned long radix__pte_update(struct mm_struct *mm, unsigned long addr,
 	return old_pte;
 }
 
-void radix__ptep_set_access_flags(struct mm_struct *mm,
-				  pte_t *ptep, pte_t entry,
-				  unsigned long address)
+void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
+				  pte_t entry, unsigned long address, int psize)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
 					      _PAGE_RW | _PAGE_EXEC);
-
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	/*
+	 * To avoid NMMU hang while relaxing access, we need mark
+	 * the pte invalid in between.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1) ||
+	    atomic_read(&mm->context.copros) > 0) {
 		unsigned long old_pte, new_pte;
 
 		old_pte = __radix_pte_update(ptep, ~0, 0);
@@ -1126,9 +1130,11 @@ void radix__ptep_set_access_flags(struct mm_struct *mm,
 		 * new value of pte
 		 */
 		new_pte = old_pte | set;
-		radix__flush_tlb_pte_p9_dd1(old_pte, mm, address);
+		radix__flush_tlb_page_psize(mm, address, psize);
 		__radix_pte_update(ptep, 0, new_pte);
-	} else
+	} else {
 		__radix_pte_update(ptep, 0, set);
+		radix__flush_tlb_page_psize(mm, address, psize);
+	}
 	asm volatile("ptesync" : : : "memory");
 }
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index e70af9939379..6954b7fb144a 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -222,8 +222,8 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	changed = !pte_same(*(ptep), entry);
 	if (changed) {
 		assert_pte_locked(vma->vm_mm, address);
-		__ptep_set_access_flags(vma->vm_mm, ptep, entry, address);
-		flush_tlb_page(vma, address);
+		__ptep_set_access_flags(vma, ptep, entry,
+					address, mmu_virtual_psize);
 	}
 	return changed;
 }
@@ -242,7 +242,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 	return 1;
 #else
-	int changed;
+	int changed, psize;
+	struct hstate *hstate = hstate_file(vma->vm_file);
 
 	pte = set_access_flags_filter(pte, vma, dirty);
 	changed = !pte_same(*(ptep), pte);
@@ -250,8 +251,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 #ifdef CONFIG_DEBUG_VM
 		assert_spin_locked(&vma->vm_mm->page_table_lock);
 #endif
-		__ptep_set_access_flags(vma->vm_mm, ptep, pte, addr);
-		flush_hugetlb_page(vma, addr);
+		psize = hstate_get_psize(hstate);
+		__ptep_set_access_flags(vma, ptep, pte, addr, psize);
 	}
 	return changed;
 #endif
-- 
2.17.0
