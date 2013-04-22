Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1B102C0226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:05 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 19:54:51 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0CFE22BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:03 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3M9mLnq9503214
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 19:48:21 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MA216t010631
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, David Gibson <dwg@au1.ibm.com>
Subject: [PATCH -V6 05/27] powerpc: New hugepage directory format
Date: Mon, 22 Apr 2013 15:30:39 +0530
Message-Id: <1366624861-24948-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Change the hugepage directory format so that we can have leaf ptes directly
at page directory avoiding the allocation of hugepage directory.

With the new table format we have 3 cases for pgds and pmds:
(1) invalid (all zeroes)
(2) pointer to next table, as normal; bottom 6 bits == 0
(4) hugepd pointer, bottom two bits == 00, next 4 bits indicate size of table

Instead of storing shift value in hugepd pointer we use mmu_psize_def index
so that we can fit all the supported hugepage size in 4 bits

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hugetlb.h    |   13 +++++++++++--
 arch/powerpc/include/asm/mmu-hash64.h |   20 +++++++++++++++++++-
 arch/powerpc/include/asm/page.h       |   18 +++++-------------
 arch/powerpc/include/asm/pgalloc-64.h |    5 ++++-
 arch/powerpc/mm/hugetlbpage.c         |   23 ++++-------------------
 arch/powerpc/mm/init_64.c             |    3 +--
 6 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 62e11a3..81f7677 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -9,12 +9,21 @@ extern struct kmem_cache *hugepte_cache;
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
 	BUG_ON(!hugepd_ok(hpd));
-	return (pte_t *)((hpd.pd & ~HUGEPD_SHIFT_MASK) | PD_HUGE);
+	/*
+	 * We have only four bits to encode, MMU page size
+	 */
+	BUILD_BUG_ON((MMU_PAGE_COUNT - 1) > 0xf);
+	return (pte_t *)(hpd.pd & ~HUGEPD_SHIFT_MASK);
+}
+
+static inline unsigned int hugepd_mmu_psize(hugepd_t hpd)
+{
+	return (hpd.pd & HUGEPD_SHIFT_MASK) >> 2;
 }
 
 static inline unsigned int hugepd_shift(hugepd_t hpd)
 {
-	return hpd.pd & HUGEPD_SHIFT_MASK;
+	return mmu_psize_to_shift(hugepd_mmu_psize(hpd));
 }
 
 static inline pte_t *hugepte_offset(hugepd_t *hpdp, unsigned long addr,
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index b59e06f..05895cf 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -21,6 +21,7 @@
  * complete pgtable.h but only a portion of it.
  */
 #include <asm/pgtable-ppc64.h>
+#include <asm/bug.h>
 
 /*
  * Segment table
@@ -159,6 +160,24 @@ struct mmu_psize_def
 	unsigned long	avpnm;	/* bits to mask out in AVPN in the HPTE */
 	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
 };
+extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+
+static inline int shift_to_mmu_psize(unsigned int shift)
+{
+	int psize;
+
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
+		if (mmu_psize_defs[psize].shift == shift)
+			return psize;
+	return -1;
+}
+
+static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
+{
+	if (mmu_psize_defs[mmu_psize].shift)
+		return mmu_psize_defs[mmu_psize].shift;
+	BUG();
+}
 
 #endif /* __ASSEMBLY__ */
 
@@ -193,7 +212,6 @@ static inline int segment_shift(int ssize)
 /*
  * The current system page and segment sizes
  */
-extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 extern int mmu_linear_psize;
 extern int mmu_virtual_psize;
 extern int mmu_vmalloc_psize;
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f072e97..b309cf4 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -250,18 +250,6 @@ extern long long virt_phys_offset;
 #endif
 
 /*
- * Use the top bit of the higher-level page table entries to indicate whether
- * the entries we point to contain hugepages.  This works because we know that
- * the page tables live in kernel space.  If we ever decide to support having
- * page tables at arbitrary addresses, this breaks and will have to change.
- */
-#ifdef CONFIG_PPC64
-#define PD_HUGE 0x8000000000000000
-#else
-#define PD_HUGE 0x80000000
-#endif
-
-/*
  * Some number of bits at the level of the page table that points to
  * a hugepte are used to encode the size.  This masks those bits.
  */
@@ -356,7 +344,11 @@ typedef struct { signed long pd; } hugepd_t;
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int hugepd_ok(hugepd_t hpd)
 {
-	return (hpd.pd > 0);
+	/*
+	 * hugepd pointer, bottom two bits == 00 and next 4 bits
+	 * indicate size of table
+	 */
+	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
 }
 
 #define is_hugepd(pdep)               (hugepd_ok(*((hugepd_t *)(pdep))))
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 292725c..69e352a 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -35,7 +35,10 @@ struct vmemmap_backing {
 #define MAX_PGTABLE_INDEX_SIZE	0xf
 
 extern struct kmem_cache *pgtable_cache[];
-#define PGT_CACHE(shift) (pgtable_cache[(shift)-1])
+#define PGT_CACHE(shift) ({				\
+			BUG_ON(!(shift));		\
+			pgtable_cache[(shift) - 1];	\
+		})
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 1a6de0a..9108ce7 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -48,23 +48,6 @@ static u64 gpage_freearray[MAX_NUMBER_GPAGES];
 static unsigned nr_gpages;
 #endif
 
-static inline int shift_to_mmu_psize(unsigned int shift)
-{
-	int psize;
-
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize)
-		if (mmu_psize_defs[psize].shift == shift)
-			return psize;
-	return -1;
-}
-
-static inline unsigned int mmu_psize_to_shift(unsigned int mmu_psize)
-{
-	if (mmu_psize_defs[mmu_psize].shift)
-		return mmu_psize_defs[mmu_psize].shift;
-	BUG();
-}
-
 #define hugepd_none(hpd)	((hpd).pd == 0)
 
 pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea, unsigned *shift)
@@ -145,7 +128,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		if (unlikely(!hugepd_none(*hpdp)))
 			break;
 		else
-			hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
+			hpdp->pd = (unsigned long)new |
+				    (shift_to_mmu_psize(pshift) << 2);
 	}
 	/* If we bailed from the for loop early, an error occurred, clean up */
 	if (i < num_hugepd) {
@@ -157,7 +141,8 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 	if (!hugepd_none(*hpdp))
 		kmem_cache_free(cachep, new);
 	else
-		hpdp->pd = ((unsigned long)new & ~PD_HUGE) | pshift;
+		hpdp->pd = (unsigned long)new |
+			    (shift_to_mmu_psize(pshift) << 2);
 #endif
 	spin_unlock(&mm->page_table_lock);
 	return 0;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 7e2246f..a56de85 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -129,8 +129,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
 	new = kmem_cache_create(name, table_size, align, 0, ctor);
-	PGT_CACHE(shift) = new;
-
+	pgtable_cache[shift - 1] = new;
 	pr_debug("Allocated pgtable cache for order %d\n", shift);
 }
 
-- 
1.7.10
