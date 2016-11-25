Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQLTS6qKwzDvy0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 03:03:24 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAPFwilM141696
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:22 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26xpmt9ab1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 11:03:22 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 25 Nov 2016 11:03:21 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v6 5/7] powerpc/mm: update radix__ptep_set_access_flag to not
 do full mm tlb flush
Date: Fri, 25 Nov 2016 21:32:55 +0530
In-Reply-To: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161125160257.9158-6-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we are updating pte, we just need to flush the tlb mapping for
that pte. Right now we do a full mm flush because we don't track page
size. Now that we have page size details in pte use that to do the
optimized flush

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  3 ++-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  5 +++--
 arch/powerpc/include/asm/book3s/64/radix.h   | 11 +++--------
 arch/powerpc/include/asm/nohash/32/pgtable.h |  3 ++-
 arch/powerpc/include/asm/nohash/64/pgtable.h |  3 ++-
 arch/powerpc/mm/pgtable-book3s64.c           |  3 ++-
 arch/powerpc/mm/pgtable.c                    |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 6b8b2d57fdc8..dc58980f3ad9 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -224,7 +224,8 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 
 static inline void __ptep_set_access_flags(struct mm_struct *mm,
-					   pte_t *ptep, pte_t entry)
+					   pte_t *ptep, pte_t entry,
+					   unsigned long address)
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e05028894a8e..7f4356de5ce1 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -590,10 +590,11 @@ static inline bool check_pte_access(unsigned long access, unsigned long ptev)
  */
 
 static inline void __ptep_set_access_flags(struct mm_struct *mm,
-					   pte_t *ptep, pte_t entry)
+					   pte_t *ptep, pte_t entry,
+					   unsigned long address)
 {
 	if (radix_enabled())
-		return radix__ptep_set_access_flags(mm, ptep, entry);
+		return radix__ptep_set_access_flags(mm, ptep, entry, address);
 	return hash__ptep_set_access_flags(ptep, entry);
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index de009387e258..08eaceb430ee 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -167,7 +167,8 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
  * function doesn't need to invalidate tlb.
  */
 static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
-						pte_t *ptep, pte_t entry)
+						pte_t *ptep, pte_t entry,
+						unsigned long address)
 {
 
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
@@ -183,13 +184,7 @@ static inline void radix__ptep_set_access_flags(struct mm_struct *mm,
 		 * new value of pte
 		 */
 		new_pte = old_pte | set;
-
-		/*
-		 * For now let's do heavy pid flush
-		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
-		 */
-		radix__flush_tlb_mm(mm);
-
+		radix__flush_tlb_pte(old_pte, mm, address);
 		__radix_pte_update(ptep, 0, new_pte);
 	} else
 		__radix_pte_update(ptep, 0, set);
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index c219ef7be53b..65073fbc6707 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -268,7 +268,8 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 
 static inline void __ptep_set_access_flags(struct mm_struct *mm,
-					   pte_t *ptep, pte_t entry)
+					   pte_t *ptep, pte_t entry,
+					   unsigned long address)
 {
 	unsigned long set = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 653a1838469d..ea1c0123b85c 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -301,7 +301,8 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
  * function doesn't need to flush the hash entry
  */
 static inline void __ptep_set_access_flags(struct mm_struct *mm,
-					   pte_t *ptep, pte_t entry)
+					   pte_t *ptep, pte_t entry,
+					   unsigned long address)
 {
 	unsigned long bits = pte_val(entry) &
 		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index f4f437cbabf1..ebf9782bacf9 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -35,7 +35,8 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 #endif
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
-		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp), pmd_pte(entry));
+		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
+					pmd_pte(entry), address);
 		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 911fdfb63ec1..cb39c8bd2436 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -224,7 +224,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	if (changed) {
 		if (!is_vm_hugetlb_page(vma))
 			assert_pte_locked(vma->vm_mm, address);
-		__ptep_set_access_flags(vma->vm_mm, ptep, entry);
+		__ptep_set_access_flags(vma->vm_mm, ptep, entry, address);
 		flush_tlb_page(vma, address);
 	}
 	return changed;
-- 
2.10.2
