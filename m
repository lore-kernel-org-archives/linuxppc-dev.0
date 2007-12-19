Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34B69DDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 09:36:35 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBJMaL4w020742
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 17:36:21 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBJMaFtR040468
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 15:36:15 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBJMaEkp008616
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 15:36:15 -0700
Message-ID: <47699CC3.1050909@linux.vnet.ibm.com>
Date: Wed, 19 Dec 2007 16:35:47 -0600
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] powerpc: add hugepagesz boot-time parameter
Content-Type: text/plain; charset=ISO-8859-1
Cc: arnd@arndb.de, mel@csn.ul.ie, David Gibson <dwg@au1.ibm.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, csnook@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul, please include this in 2.6.25 if there are no objections.

This patch adds the hugepagesz boot-time parameter for ppc64.  It lets
one pick the size for huge pages. The choices available are 64K and 16M
when the base page size is 4k. It defaults to 16M (previously the only
only choice) if nothing or an invalid choice is specified.

Tested 64K huge pages successfully with the libhugetlbfs 1.2.

Changes from v1:
    disallow 64K huge pages when base page size is 64K since we can't
distinguish between
        base and huge pages when doing a hash_page()
    collapsed pmd_offset and pmd_alloc to inline calls to simplify the
main code
    removed printing of the huge page size in mm/hugetlb.c since this
information is already
       available in /proc/meminfo and leaves the remaining changes all
powerpc specific

Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
---

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 33121d6..2fc1fb8 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -685,6 +685,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			See Documentation/isdn/README.HiSax.
 
 	hugepages=	[HW,X86-32,IA-64] Maximal number of HugeTLB pages.
+	hugepagesz=	[HW,IA-64,PPC] The size of the HugeTLB pages.
 
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index cbbd8b0..9326a69 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -369,18 +369,11 @@ static void __init htab_init_page_sizes(void)
 	 * on what is available
 	 */
 	if (mmu_psize_defs[MMU_PAGE_16M].shift)
-		mmu_huge_psize = MMU_PAGE_16M;
+		set_huge_psize(MMU_PAGE_16M);
 	/* With 4k/4level pagetables, we can't (for now) cope with a
 	 * huge page size < PMD_SIZE */
 	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
-		mmu_huge_psize = MMU_PAGE_1M;
-
-	/* Calculate HPAGE_SHIFT and sanity check it */
-	if (mmu_psize_defs[mmu_huge_psize].shift > MIN_HUGEPTE_SHIFT &&
-	    mmu_psize_defs[mmu_huge_psize].shift < SID_SHIFT)
-		HPAGE_SHIFT = mmu_psize_defs[mmu_huge_psize].shift;
-	else
-		HPAGE_SHIFT = 0; /* No huge pages dude ! */
+		set_huge_psize(MMU_PAGE_1M);
 #endif /* CONFIG_HUGETLB_PAGE */
 }
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 71efb38..3099e48 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -24,18 +24,17 @@
 #include <asm/cputable.h>
 #include <asm/spu.h>
 
+#define HPAGE_SHIFT_64K	16
+#define HPAGE_SHIFT_16M	24
+
 #define NUM_LOW_AREAS	(0x100000000UL >> SID_SHIFT)
 #define NUM_HIGH_AREAS	(PGTABLE_RANGE >> HTLB_AREA_SHIFT)
 
-#ifdef CONFIG_PPC_64K_PAGES
-#define HUGEPTE_INDEX_SIZE	(PMD_SHIFT-HPAGE_SHIFT)
-#else
-#define HUGEPTE_INDEX_SIZE	(PUD_SHIFT-HPAGE_SHIFT)
-#endif
-#define PTRS_PER_HUGEPTE	(1 << HUGEPTE_INDEX_SIZE)
-#define HUGEPTE_TABLE_SIZE	(sizeof(pte_t) << HUGEPTE_INDEX_SIZE)
+unsigned int hugepte_shift;
+#define PTRS_PER_HUGEPTE	(1 << hugepte_shift)
+#define HUGEPTE_TABLE_SIZE	(sizeof(pte_t) << hugepte_shift)
 
-#define HUGEPD_SHIFT		(HPAGE_SHIFT + HUGEPTE_INDEX_SIZE)
+#define HUGEPD_SHIFT		(HPAGE_SHIFT + hugepte_shift)
 #define HUGEPD_SIZE		(1UL << HUGEPD_SHIFT)
 #define HUGEPD_MASK		(~(HUGEPD_SIZE-1))
 
@@ -82,11 +81,31 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	return 0;
 }
 
+#ifndef CONFIG_PPC_64K_PAGES
+static inline
+pmd_t *hpmd_offset(pud_t *pud, unsigned long addr)
+{
+	if (HPAGE_SHIFT == HPAGE_SHIFT_64K)
+		return pmd_offset(pud, addr);
+	else
+		return (pmd_t *) pud;
+}
+static inline
+pmd_t *hpmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr)
+{
+	if (HPAGE_SHIFT == HPAGE_SHIFT_64K)
+		return pmd_alloc(mm, pud, addr);
+	else
+		return (pmd_t *) pud;
+}
+#endif
+
 /* Modelled after find_linux_pte() */
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pg;
 	pud_t *pu;
+	pmd_t *pm;
 
 	BUG_ON(get_slice_psize(mm, addr) != mmu_huge_psize);
 
@@ -96,14 +115,9 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 	if (!pgd_none(*pg)) {
 		pu = pud_offset(pg, addr);
 		if (!pud_none(*pu)) {
-#ifdef CONFIG_PPC_64K_PAGES
-			pmd_t *pm;
-			pm = pmd_offset(pu, addr);
+			pm = hpmd_offset(pu, addr);
 			if (!pmd_none(*pm))
 				return hugepte_offset((hugepd_t *)pm, addr);
-#else
-			return hugepte_offset((hugepd_t *)pu, addr);
-#endif
 		}
 	}
 
@@ -114,6 +128,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pg;
 	pud_t *pu;
+	pmd_t *pm;
 	hugepd_t *hpdp = NULL;
 
 	BUG_ON(get_slice_psize(mm, addr) != mmu_huge_psize);
@@ -124,14 +139,9 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 	pu = pud_alloc(mm, pg, addr);
 
 	if (pu) {
-#ifdef CONFIG_PPC_64K_PAGES
-		pmd_t *pm;
-		pm = pmd_alloc(mm, pu, addr);
+		pm = hpmd_alloc(mm, pu, addr);
 		if (pm)
 			hpdp = (hugepd_t *)pm;
-#else
-		hpdp = (hugepd_t *)pu;
-#endif
 	}
 
 	if (! hpdp)
@@ -158,7 +168,6 @@ static void free_hugepte_range(struct mmu_gather *tlb, hugepd_t *hpdp)
 						 PGF_CACHENUM_MASK));
 }
 
-#ifdef CONFIG_PPC_64K_PAGES
 static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				   unsigned long addr, unsigned long end,
 				   unsigned long floor, unsigned long ceiling)
@@ -191,7 +200,6 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	pud_clear(pud);
 	pmd_free_tlb(tlb, pmd);
 }
-#endif
 
 static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 				   unsigned long addr, unsigned long end,
@@ -210,9 +218,15 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 			continue;
 		hugetlb_free_pmd_range(tlb, pud, addr, next, floor, ceiling);
 #else
-		if (pud_none(*pud))
-			continue;
-		free_hugepte_range(tlb, (hugepd_t *)pud);
+		if (HPAGE_SHIFT == HPAGE_SHIFT_64K) {
+			if (pud_none_or_clear_bad(pud))
+				continue;
+			hugetlb_free_pmd_range(tlb, pud, addr, next, floor, ceiling);
+		} else {
+			if (pud_none(*pud))
+				continue;
+			free_hugepte_range(tlb, (hugepd_t *)pud);
+		}
 #endif
 	} while (pud++, addr = next, addr != end);
 
@@ -526,6 +540,57 @@ repeat:
 	return err;
 }
 
+void set_huge_psize(int psize)
+{
+	/* Check that it is a page size supported by the hardware and
+	 * that it fits within pagetable limits. */
+	if (mmu_psize_defs[psize].shift && mmu_psize_defs[psize].shift < SID_SHIFT &&
+		(mmu_psize_defs[psize].shift > MIN_HUGEPTE_SHIFT ||
+			mmu_psize_defs[psize].shift == HPAGE_SHIFT_64K)) {
+		HPAGE_SHIFT = mmu_psize_defs[psize].shift;
+		mmu_huge_psize = psize;
+#ifdef CONFIG_PPC_64K_PAGES
+		hugepte_shift = (PMD_SHIFT-HPAGE_SHIFT);
+#else
+		if (HPAGE_SHIFT == HPAGE_SHIFT_64K)
+			hugepte_shift = (PMD_SHIFT-HPAGE_SHIFT);
+		else
+			hugepte_shift = (PUD_SHIFT-HPAGE_SHIFT);
+#endif
+
+	} else
+		HPAGE_SHIFT = 0;
+}
+
+static int __init hugepage_setup_sz(char *str)
+{
+	unsigned long long size;
+	int mmu_psize = -1;
+	int shift;
+
+	size = memparse(str, &str);
+
+	shift = __ffs(size);
+	switch (shift) {
+#ifndef CONFIG_PPC_64K_PAGES
+	case HPAGE_SHIFT_64K:
+		mmu_psize = MMU_PAGE_64K;
+		break;
+#endif
+	case HPAGE_SHIFT_16M:
+		mmu_psize = MMU_PAGE_16M;
+		break;
+	}
+
+	if (mmu_psize >=0 && mmu_psize_defs[mmu_psize].shift)
+		set_huge_psize(mmu_psize);
+	else
+		printk(KERN_WARNING "Invalid huge page size specified(%llu)\n", size);
+
+	return 1;
+}
+__setup("hugepagesz=", hugepage_setup_sz);
+
 static void zero_ctor(struct kmem_cache *cache, void *addr)
 {
 	memset(addr, 0, kmem_cache_size(cache));
diff --git a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
index 12e5e77..2fda33c 100644
--- a/include/asm-powerpc/mmu-hash64.h
+++ b/include/asm-powerpc/mmu-hash64.h
@@ -278,6 +278,7 @@ extern int hash_huge_page(struct mm_struct *mm, unsigned long access,
 extern int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			     unsigned long pstart, unsigned long mode,
 			     int psize, int ssize);
+extern void set_huge_psize(int psize);
 
 extern void htab_initialize(void);
 extern void htab_initialize_secondary(void);
diff --git a/include/asm-powerpc/pgtable.h b/include/asm-powerpc/pgtable.h
index d18ffe7..66ff7e5 100644
--- a/include/asm-powerpc/pgtable.h
+++ b/include/asm-powerpc/pgtable.h
@@ -37,6 +37,12 @@ extern void paging_init(void);
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot)		\
 		remap_pfn_range(vma, vaddr, pfn, size, prot)
 
+/* Base page size affects how we walk hugetlb page tables */
+#ifdef CONFIG_PPC_64K_PAGES
+#define hpmd_offset(pud, addr)		pmd_offset(pud, addr)
+#define hpmd_alloc(mm, pud, addr)	pmd_alloc(mm, pud, addr)
+#endif
+
 #include <asm-generic/pgtable.h>
 #endif /* __ASSEMBLY__ */
 
