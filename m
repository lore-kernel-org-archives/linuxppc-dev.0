Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP04R6DcmzDw3p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 22:10:31 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uANB8ust121404
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:10:29 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26w81eqnmu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:10:29 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 04:10:28 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v5 6/7] powerpc/mm: update pte_update to not do full mm tlb
 flush
Date: Wed, 23 Nov 2016 16:40:02 +0530
In-Reply-To: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161123111003.459-6-aneesh.kumar@linux.vnet.ibm.com>
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
size. Update the interface to track the page size and use that to
do the right tlb flush.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 16 ++++++++++------
 arch/powerpc/include/asm/book3s/64/radix.h   | 19 ++++++++-----------
 arch/powerpc/mm/pgtable-radix.c              |  2 +-
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 4a2bd260eec0..7789ce64beb1 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -301,12 +301,16 @@ extern unsigned long pci_io_base;
 
 static inline unsigned long pte_update(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep, unsigned long clr,
-				       unsigned long set, int huge)
+				       unsigned long set,
+				       unsigned long page_size)
 {
+	bool huge = (page_size != PAGE_SIZE);
+
 	if (radix_enabled())
-		return radix__pte_update(mm, addr, ptep, clr, set, huge);
+		return radix__pte_update(mm, addr, ptep, clr, set, page_size);
 	return hash__pte_update(mm, addr, ptep, clr, set, huge);
 }
+
 /*
  * For hash even if we have _PAGE_ACCESSED = 0, we do a pte_update.
  * We currently remove entries from the hashtable regardless of whether
@@ -324,7 +328,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 
 	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_ACCESSED | H_PAGE_HASHPTE)) == 0)
 		return 0;
-	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
+	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, PAGE_SIZE);
 	return (old & _PAGE_ACCESSED) != 0;
 }
 
@@ -343,21 +347,21 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
-	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
+	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, PAGE_SIZE);
 }
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pte_t *ptep)
 {
-	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, 0);
+	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, PAGE_SIZE);
 	return __pte(old);
 }
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t * ptep)
 {
-	pte_update(mm, addr, ptep, ~0UL, 0, 0);
+	pte_update(mm, addr, ptep, ~0UL, 0, PAGE_SIZE);
 }
 
 static inline int pte_write(pte_t pte)
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index e104004bf2b1..da94bdae1f88 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -129,15 +129,16 @@ static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 
 
 static inline unsigned long radix__pte_update(struct mm_struct *mm,
-					unsigned long addr,
-					pte_t *ptep, unsigned long clr,
-					unsigned long set,
-					int huge)
+					      unsigned long addr,
+					      pte_t *ptep, unsigned long clr,
+					      unsigned long set,
+					      unsigned long page_size)
 {
 	unsigned long old_pte;
 
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
 
+		int psize;
 		unsigned long new_pte;
 
 		old_pte = __radix_pte_update(ptep, ~0, 0);
@@ -146,18 +147,14 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 		 * new value of pte
 		 */
 		new_pte = (old_pte | set) & ~clr;
-
-		/*
-		 * For now let's do heavy pid flush
-		 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
-		 */
-		radix__flush_tlb_mm(mm);
+		psize = radix_get_mmu_psize(page_size);
+		radix__flush_tlb_page_psize(mm, addr, psize);
 
 		__radix_pte_update(ptep, 0, new_pte);
 	} else
 		old_pte = __radix_pte_update(ptep, clr, set);
 	asm volatile("ptesync" : : : "memory");
-	if (!huge)
+	if (page_size == PAGE_SIZE)
 		assert_pte_locked(mm, addr);
 
 	return old_pte;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 416918005395..2fc7336619b3 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -486,7 +486,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 	assert_spin_locked(&mm->page_table_lock);
 #endif
 
-	old = radix__pte_update(mm, addr, (pte_t *)pmdp, clr, set, 1);
+	old = radix__pte_update(mm, addr, (pte_t *)pmdp, clr, set, HPAGE_PMD_SIZE);
 	trace_hugepage_update(addr, old, clr, set);
 
 	return old;
-- 
2.10.2
