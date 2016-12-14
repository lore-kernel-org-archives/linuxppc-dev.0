Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdkN237wYzDvk5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 15:38:10 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBE4XjIU026242
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 23:38:07 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27avy49kpy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 23:38:07 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Dec 2016 21:38:06 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Fix little-endian 4K hugetlb
Date: Wed, 14 Dec 2016 10:07:53 +0530
Message-Id: <20161214043753.25934-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we switched to big endian page table, we never updated
the hugepd format such that it can work for both big endian and
little endian config. This patch series update hugepd format
such that it is looked at as __be64 value in big endian page
table config.

This patch also switch hugepd_t.pd from signed long to unsigned long.
I did update the FSL hugepd_ok check to check for the top bit instead
of checking > 0.

Fixes: 5dc1ef858c12f8 ("powerpc/mm: Use big endian Linux page tables for book3s 64")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h |  5 +++--
 arch/powerpc/include/asm/hugetlb.h           | 14 ++++++++------
 arch/powerpc/include/asm/nohash/pgtable.h    |  5 +++--
 arch/powerpc/include/asm/page.h              |  3 ---
 arch/powerpc/include/asm/pgtable-be-types.h  |  8 ++++++++
 arch/powerpc/include/asm/pgtable-types.h     |  7 +++++++
 arch/powerpc/mm/hugetlbpage-hash64.c         |  5 ++++-
 arch/powerpc/mm/hugetlbpage.c                | 22 +++++++++++-----------
 8 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 1c64bc6330bc..0c4e470571ca 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -36,12 +36,13 @@
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int hash__hugepd_ok(hugepd_t hpd)
 {
+	unsigned long hpdval = hpd_val(hpd);
 	/*
 	 * if it is not a pte and have hugepd shift mask
 	 * set, then it is a hugepd directory pointer
 	 */
-	if (!(hpd.pd & _PAGE_PTE) &&
-	    ((hpd.pd & HUGEPD_SHIFT_MASK) != 0))
+	if (!(hpdval & _PAGE_PTE) &&
+	    ((hpdval & HUGEPD_SHIFT_MASK) != 0))
 		return true;
 	return false;
 }
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index ede215167d1a..7f4025a6c69e 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -21,12 +21,12 @@ static inline pte_t *hugepd_page(hugepd_t hpd)
 	 * We have only four bits to encode, MMU page size
 	 */
 	BUILD_BUG_ON((MMU_PAGE_COUNT - 1) > 0xf);
-	return __va(hpd.pd & HUGEPD_ADDR_MASK);
+	return __va(hpd_val(hpd) & HUGEPD_ADDR_MASK);
 }
 
 static inline unsigned int hugepd_mmu_psize(hugepd_t hpd)
 {
-	return (hpd.pd & HUGEPD_SHIFT_MASK) >> 2;
+	return (hpd_val(hpd) & HUGEPD_SHIFT_MASK) >> 2;
 }
 
 static inline unsigned int hugepd_shift(hugepd_t hpd)
@@ -52,18 +52,20 @@ static inline pte_t *hugepd_page(hugepd_t hpd)
 {
 	BUG_ON(!hugepd_ok(hpd));
 #ifdef CONFIG_PPC_8xx
-	return (pte_t *)__va(hpd.pd & ~(_PMD_PAGE_MASK | _PMD_PRESENT_MASK));
+	return (pte_t *)__va(hpd_val(hpd) &
+			     ~(_PMD_PAGE_MASK | _PMD_PRESENT_MASK));
 #else
-	return (pte_t *)((hpd.pd & ~HUGEPD_SHIFT_MASK) | PD_HUGE);
+	return (pte_t *)((hpd_val(hpd) &
+			  ~HUGEPD_SHIFT_MASK) | PD_HUGE);
 #endif
 }
 
 static inline unsigned int hugepd_shift(hugepd_t hpd)
 {
 #ifdef CONFIG_PPC_8xx
-	return ((hpd.pd & _PMD_PAGE_MASK) >> 1) + 17;
+	return ((hpd_val(hpd) & _PMD_PAGE_MASK) >> 1) + 17;
 #else
-	return hpd.pd & HUGEPD_SHIFT_MASK;
+	return hpd_val(hpd) & HUGEPD_SHIFT_MASK;
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 172849727054..0cd8a3852763 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -227,9 +227,10 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 static inline int hugepd_ok(hugepd_t hpd)
 {
 #ifdef CONFIG_PPC_8xx
-	return ((hpd.pd & 0x4) != 0);
+	return ((hpd_val(hpd) & 0x4) != 0);
 #else
-	return (hpd.pd > 0);
+	/* We clear the top bit to indicate hugepd */
+	return ((hpd_val(hpd) & PD_HUGE) ==  0);
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 56398e7e6100..47120bf2670c 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -294,15 +294,12 @@ extern long long virt_phys_offset;
 #include <asm/pgtable-types.h>
 #endif
 
-typedef struct { signed long pd; } hugepd_t;
 
 #ifndef CONFIG_HUGETLB_PAGE
 #define is_hugepd(pdep)		(0)
 #define pgd_huge(pgd)		(0)
 #endif /* CONFIG_HUGETLB_PAGE */
 
-#define __hugepd(x) ((hugepd_t) { (x) })
-
 struct page;
 extern void clear_user_page(void *page, unsigned long vaddr, struct page *pg);
 extern void copy_user_page(void *to, void *from, unsigned long vaddr,
diff --git a/arch/powerpc/include/asm/pgtable-be-types.h b/arch/powerpc/include/asm/pgtable-be-types.h
index 49c0a5a80efa..9c0f5db5cf46 100644
--- a/arch/powerpc/include/asm/pgtable-be-types.h
+++ b/arch/powerpc/include/asm/pgtable-be-types.h
@@ -104,4 +104,12 @@ static inline bool pmd_xchg(pmd_t *pmdp, pmd_t old, pmd_t new)
 	return pmd_raw(old) == prev;
 }
 
+typedef struct { __be64 pdbe; } hugepd_t;
+#define __hugepd(x) ((hugepd_t) { cpu_to_be64(x) })
+
+static inline unsigned long hpd_val(hugepd_t x)
+{
+	return be64_to_cpu(x.pdbe);
+}
+
 #endif /* _ASM_POWERPC_PGTABLE_BE_TYPES_H */
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index e7f4f3e0fcde..8bd3b13fe2fb 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -66,4 +66,11 @@ static inline bool pte_xchg(pte_t *ptep, pte_t old, pte_t new)
 }
 #endif
 
+typedef struct { unsigned long pd; } hugepd_t;
+#define __hugepd(x) ((hugepd_t) { (x) })
+static inline unsigned long hpd_val(hugepd_t x)
+{
+	return x.pd;
+}
+
 #endif /* _ASM_POWERPC_PGTABLE_TYPES_H */
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index d5026f3800b6..37b5f91e381b 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -125,11 +125,14 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 int hugepd_ok(hugepd_t hpd)
 {
 	bool is_hugepd;
+	unsigned long hpdval;
+
+	hpdval = hpd_val(hpd);
 
 	/*
 	 * We should not find this format in page directory, warn otherwise.
 	 */
-	is_hugepd = (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
+	is_hugepd = (((hpdval & 0x3) == 0x0) && ((hpdval & HUGEPD_SHIFT_MASK) != 0));
 	WARN(is_hugepd, "Found wrong page directory format\n");
 	return 0;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e46bbd716832..72379b8245c1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -53,7 +53,7 @@ static u64 gpage_freearray[MAX_NUMBER_GPAGES];
 static unsigned nr_gpages;
 #endif
 
-#define hugepd_none(hpd)	((hpd).pd == 0)
+#define hugepd_none(hpd)	(hpd_val(hpd) == 0)
 
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
@@ -103,24 +103,24 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	for (i = 0; i < num_hugepd; i++, hpdp++) {
 		if (unlikely(!hugepd_none(*hpdp)))
 			break;
-		else
+		else {
 #ifdef CONFIG_PPC_BOOK3S_64
-			hpdp->pd = __pa(new) |
-				   (shift_to_mmu_psize(pshift) << 2);
+			*hpdp = __hugepd(__pa(new) |
+					 (shift_to_mmu_psize(pshift) << 2));
 #elif defined(CONFIG_PPC_8xx)
-			hpdp->pd = __pa(new) |
-				   (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M :
-							      _PMD_PAGE_512K) |
-				   _PMD_PRESENT;
+			*hpdp = __hugepd(__pa(new) |
+					 (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M :
+					  _PMD_PAGE_512K) | _PMD_PRESENT);
 #else
 			/* We use the old format for PPC_FSL_BOOK3E */
-			hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
+			*hpdp = __hugepd(((unsigned long)new & ~PD_HUGE) | pshift);
 #endif
+		}
 	}
 	/* If we bailed from the for loop early, an error occurred, clean up */
 	if (i < num_hugepd) {
 		for (i = i - 1 ; i >= 0; i--, hpdp--)
-			hpdp->pd = 0;
+			*hpdp = __hugepd(0);
 		kmem_cache_free(cachep, new);
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -454,7 +454,7 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 		return;
 
 	for (i = 0; i < num_hugepd; i++, hpdp++)
-		hpdp->pd = 0;
+		*hpdp = __hugepd(0);
 
 	if (shift >= pdshift)
 		hugepd_free(tlb, hugepte);
-- 
2.10.2
