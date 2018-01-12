Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ2Xc0L0czF0jx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 23:45:35 +1100 (AEDT)
Message-Id: <7161e90cacc94ef5d124f11636cf3ea2a4b9b950.1515759812.git.christophe.leroy@c-s.fr>
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
References: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/8] powerpc/8xx: Remove _PAGE_USER and handle user access at
 PMD level
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Jan 2018 13:45:31 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Linux kernel separates KERNEL and USER address spaces, there is
therefore no need to flag USER access at page level.

Today, the 8xx TLB handlers already handle user access in the L1 entry
through Access Protection Groups, it is then natural to move the user
access handling at PMD level once _PAGE_NA allows to handle PAGE_NONE
protection without _PAGE_USER

In the mean time, as we free up one bit in the PTE, we can use it to
include SPS (page size flag) in the PTE and avoid handling it at every
TLB miss hence removing special handling based on compiled page size.

For _PAGE_EXEC, we rework it to use PP PTE bits, avoiding the copy
of _PAGE_EXEC bit into the L1 entry. Unfortunatly we are not
able to put it at the correct location as it conflicts with
NA/RO/RW bits for data entries.

Upper bits of APG in L1 entry overlap with PMD base address. In
order to avoid having to filter that out, we set up all groups so that
upper bits can have any value.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hugetlb.h           |  3 +-
 arch/powerpc/include/asm/mmu-8xx.h           | 34 ++++++++++----------
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  3 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 14 ++++++---
 arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
 arch/powerpc/include/asm/pte-common.h        |  6 ++++
 arch/powerpc/kernel/head_8xx.S               | 46 ++++++----------------------
 arch/powerpc/mm/hugetlbpage.c                |  2 +-
 8 files changed, 48 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 14c9d44f355b..1a4847f67ea8 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -47,8 +47,7 @@ static inline pte_t *hugepd_page(hugepd_t hpd)
 {
 	BUG_ON(!hugepd_ok(hpd));
 #ifdef CONFIG_PPC_8xx
-	return (pte_t *)__va(hpd_val(hpd) &
-			     ~(_PMD_PAGE_MASK | _PMD_PRESENT_MASK));
+	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
 #else
 	return (pte_t *)((hpd_val(hpd) &
 			  ~HUGEPD_SHIFT_MASK) | PD_HUGE);
diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index 40aa7b0cd0dc..ae68f6c848d3 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -29,17 +29,17 @@
 #define MI_Kp		0x40000000	/* Should always be set */
 
 /*
- * All pages' PP exec bits are set to 000, which means Execute for Supervisor
- * and no Execute for User.
- * Then we use the APG to say whether accesses are according to Page rules,
- * "all Supervisor" rules (Exec for all) and "all User" rules (Exec for noone)
- * Therefore, we define 4 APG groups. msb is _PAGE_EXEC, lsb is _PAGE_USER
- * 0 (00) => Not User, no exec => 11 (all accesses performed as user)
- * 1 (01) => User but no exec => 11 (all accesses performed as user)
- * 2 (10) => Not User, exec => 01 (rights according to page definition)
- * 3 (11) => User, exec => 00 (all accesses performed as supervisor)
- */
-#define MI_APG_INIT	0xf4ffffff
+ * All pages' PP data bits are set to either 001 or 011 by copying _PAGE_EXEC
+ * into bit 21 in the ITLBmiss handler (bit 21 is the middle bit), which means
+ * respectively NA for All or X for Supervisor and no access for User.
+ * Then we use the APG to say whether accesses are according to Page rules or
+ * "all Supervisor" rules (Access to all)
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
+ * 0 => No user => 01 (all accesses performed according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * We define all 16 groups so that all other bits of APG can take any value
+ */
+#define MI_APG_INIT	0x44444444
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MI_RPN is written, bits in
@@ -102,17 +102,17 @@
 #define MD_Kp		0x40000000	/* Should always be set */
 
 /*
- * All pages' PP data bits are set to either 000 or 011, which means
+ * All pages' PP data bits are set to either 000 or 011 or 001, which means
  * respectively RW for Supervisor and no access for User, or RO for
- * Supervisor and no access for user.
+ * Supervisor and no access for user and NA for ALL.
  * Then we use the APG to say whether accesses are according to Page rules or
  * "all Supervisor" rules (Access to all)
- * Therefore, we define 2 APG groups. lsb is _PAGE_USER
+ * Therefore, we define 2 APG groups. lsb is _PMD_USER
  * 0 => No user => 01 (all accesses performed according to page definition)
- * 1 => User => 00 (all accesses performed as supervisor
- *                                 according to page definition)
+ * 1 => User => 00 (all accesses performed as supervisor iaw page definition)
+ * We define all 16 groups so that all other bits of APG can take any value
  */
-#define MD_APG_INIT	0x4fffffff
+#define MD_APG_INIT	0x44444444
 
 /* The effective page number register.  When read, contains the information
  * about the last instruction TLB miss.  When MD_RPN is written, bits in
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index d072139ff2e5..29d37bd1f3b3 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -61,7 +61,8 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pte_page)
 {
-	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_PRESENT);
+	*pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_USER |
+		      _PMD_PRESENT);
 }
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 7c7040f015e2..f04cb46ae8a1 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -32,27 +32,33 @@
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
 #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
 #define _PAGE_PRIVILEGED	0x0004	/* No ASID (context) compare */
-#define _PAGE_SPECIAL	0x0008	/* SW entry, forced to 0 by the TLB miss */
+#define _PAGE_HUGE	0x0008	/* SPS: Small Page Size (1 if 16k, 512k or 8M)*/
 #define _PAGE_DIRTY	0x0100	/* C: page changed */
 
 /* These 4 software bits must be masked out when the L2 entry is loaded
  * into the TLB.
  */
 #define _PAGE_GUARDED	0x0010	/* Copied to L1 G entry in DTLB */
-#define _PAGE_USER	0x0020	/* Copied to L1 APG lsb */
-#define _PAGE_EXEC	0x0040	/* Copied to L1 APG */
+#define _PAGE_SPECIAL	0x0020	/* SW entry */
+#define _PAGE_EXEC	0x0040	/* Copied to PP (bit 21) in ITLB */
 #define _PAGE_ACCESSED	0x0080	/* software: page referenced */
 
+#define _PAGE_NA	0x0200	/* Supervisor NA, User no access */
 #define _PAGE_RO	0x0600	/* Supervisor RO, User no access */
 
 #define _PMD_PRESENT	0x0001
-#define _PMD_BAD	0x0ff0
+#define _PMD_BAD	0x0fd0
 #define _PMD_PAGE_MASK	0x000c
 #define _PMD_PAGE_8M	0x000c
 #define _PMD_PAGE_512K	0x0004
+#define _PMD_USER	0x0020	/* APG 1 */
 
 /* Until my rework is finished, 8xx still needs atomic PTE updates */
 #define PTE_ATOMIC_UPDATES	1
 
+#ifdef CONFIG_PPC_16K_PAGES
+#define _PAGE_PSIZE	_PAGE_HUGE
+#endif
+
 #endif /* __KERNEL__ */
 #endif /*  _ASM_POWERPC_NOHASH_32_PTE_8xx_H */
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 84120d65d0e9..2fda3b291d9e 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -103,7 +103,7 @@ static inline pte_t pte_mkspecial(pte_t pte)
 
 static inline pte_t pte_mkhuge(pte_t pte)
 {
-	return pte;
+	return __pte(pte_val(pte) | _PAGE_HUGE);
 }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 426a902816c5..c4a72c7a8c83 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -53,6 +53,9 @@
 #ifndef _PAGE_NA
 #define _PAGE_NA 0
 #endif
+#ifndef _PAGE_HUGE
+#define _PAGE_HUGE 0
+#endif
 
 #ifndef _PMD_PRESENT_MASK
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
@@ -61,6 +64,9 @@
 #define _PMD_SIZE	0
 #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
 #endif
+#ifndef _PMD_USER
+#define _PMD_USER	0
+#endif
 #ifndef _PAGE_KERNEL_RO
 #define _PAGE_KERNEL_RO		(_PAGE_PRIVILEGED | _PAGE_RO)
 #endif
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 642680389b7e..c3b831bb8bad 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -52,11 +52,7 @@
  * Value for the bits that have fixed value in RPN entries.
  * Also used for tagging DAR for DTLBerror.
  */
-#ifdef CONFIG_PPC_16K_PAGES
-#define RPN_PATTERN	(0x00f0 | MD_SPS16K)
-#else
 #define RPN_PATTERN	0x00f0
-#endif
 
 #define PAGE_SHIFT_512K		19
 #define PAGE_SHIFT_8M		23
@@ -358,31 +354,23 @@ _ENTRY(ITLBMiss_cmp)
 #if defined(ITLB_MISS_KERNEL) || defined(CONFIG_HUGETLB_PAGE)
 	mtcr	r12
 #endif
-	/* Insert the APG into the TWC from the Linux PTE. */
-	rlwimi	r11, r10, 0, 25, 26
 	/* Load the MI_TWC with the attributes for this "segment." */
 	mtspr	SPRN_MI_TWC, r11	/* Set segment attributes */
 
-#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
-	rlwimi	r10, r11, 1, MI_SPS16K
-#endif
 #ifdef CONFIG_SWAP
 	rlwinm	r11, r10, 32-5, _PAGE_PRESENT
 	and	r11, r11, r10
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
 #endif
-	li	r11, RPN_PATTERN
+	li	r11, RPN_PATTERN | 0x200
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 20-23 and 28 must be clear.
-	 * Software indicator bits 24, 25, 26, and 27 must be
+	 * Software indicator bits 20 and 23 must be clear.
+	 * Software indicator bits 22, 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
-	rlwimi	r10, r11, 0, 0x0ff0	/* Set 24-27, clear 20-23 */
-#else
-	rlwimi	r10, r11, 0, 0x0ff8	/* Set 24-27, clear 20-23,28 */
-#endif
+	rlwimi	r11, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
+	rlwimi	r10, r11, 0, 0x0ff0	/* Set 22, 24-27, clear 20,23 */
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
@@ -419,7 +407,6 @@ _ENTRY(itlb_miss_perf)
 	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
 #endif
 	lwz	r10, 0(r10)	/* Get the pte */
-	rlwinm	r11, r11, 0, 0xf
 	b	4b
 
 20:	/* 512k pages */
@@ -428,7 +415,6 @@ _ENTRY(itlb_miss_perf)
 	/* Add level 2 base */
 	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
 	lwz	r10, 0(r10)	/* Get the pte */
-	rlwinm	r11, r11, 0, 0xf
 	b	4b
 #endif
 
@@ -479,20 +465,15 @@ _ENTRY(DTLBMiss_jmp)
 4:
 	mtcr	r12
 
-	/* Insert the Guarded flag and APG into the TWC from the Linux PTE.
-	 * It is bit 26-27 of both the Linux PTE and the TWC (at least
+	/* Insert the Guarded flag into the TWC from the Linux PTE.
+	 * It is bit 27 of both the Linux PTE and the TWC (at least
 	 * I got that right :-).  It will be better when we can put
 	 * this into the Linux pgd/pmd and load it in the operation
 	 * above.
 	 */
-	rlwimi	r11, r10, 0, 26, 27
+	rlwimi	r11, r10, 0, _PAGE_GUARDED
 	mtspr	SPRN_MD_TWC, r11
 
-	/* In 4k pages mode, SPS (bit 28) in RPN must match PS[1] (bit 29)
-	 * In 16k pages mode, SPS is always 1 */
-#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
-	rlwimi	r10, r11, 1, MD_SPS16K
-#endif
 	/* Both _PAGE_ACCESSED and _PAGE_PRESENT has to be set.
 	 * We also need to know if the insn is a load/store, so:
 	 * Clear _PAGE_PRESENT and load that which will
@@ -508,17 +489,12 @@ _ENTRY(DTLBMiss_jmp)
 	rlwimi	r10, r11, 0, _PAGE_PRESENT
 #endif
 	/* The Linux PTE won't go exactly into the MMU TLB.
-	 * Software indicator bits 22 and 28 must be clear.
 	 * Software indicator bits 24, 25, 26, and 27 must be
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
 	li	r11, RPN_PATTERN
-#if defined (CONFIG_HUGETLB_PAGE) && defined (CONFIG_PPC_4K_PAGES)
 	rlwimi	r10, r11, 0, 24, 27	/* Set 24-27 */
-#else
-	rlwimi	r10, r11, 0, 24, 28	/* Set 24-27, clear 28 */
-#endif
 	mtspr	SPRN_MD_RPN, r10	/* Update TLB entry */
 
 	/* Restore registers */
@@ -552,7 +528,6 @@ _ENTRY(dtlb_miss_perf)
 	rlwinm	r10, r11, 0, ~HUGEPD_SHIFT_MASK
 #endif
 	lwz	r10, 0(r10)	/* Get the pte */
-	rlwinm	r11, r11, 0, 0xf
 	b	4b
 
 20:	/* 512k pages */
@@ -561,7 +536,6 @@ _ENTRY(dtlb_miss_perf)
 	/* Add level 2 base */
 	rlwimi	r10, r11, 0, 0, 32 + PAGE_SHIFT_512K - (PAGE_SHIFT << 1) - 1
 	lwz	r10, 0(r10)	/* Get the pte */
-	rlwinm	r11, r11, 0, 0xf
 	b	4b
 #endif
 
@@ -712,7 +686,7 @@ _ENTRY(dtlb_miss_exit_3)
 ITLBMissLinear:
 	mtcr	r12
 	/* Set 8M byte page and mark it valid */
-	li	r11, MI_PS8MEG | MI_SVALID | _PAGE_EXEC
+	li	r11, MI_PS8MEG | MI_SVALID
 	mtspr	SPRN_MI_TWC, r11
 	rlwinm	r10, r10, 0, 0x0f800000	/* 8xx supports max 256Mb RAM */
 	ori	r10, r10, 0xf0 | MI_SPS16K | _PAGE_PRIVILEGED | _PAGE_DIRTY | \
@@ -994,7 +968,7 @@ initial_mmu:
 	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
 	ori	r8, r8, MI_EVALID	/* Mark it valid */
 	mtspr	SPRN_MI_EPN, r8
-	li	r8, MI_PS8MEG | (2 << 5)	/* Set 8M byte page, APG 2 */
+	li	r8, MI_PS8MEG /* Set 8M byte page */
 	ori	r8, r8, MI_SVALID	/* Make it valid */
 	mtspr	SPRN_MI_TWC, r8
 	li	r8, MI_BOOTINIT		/* Create RPN for address 0 */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 0eadf9f199de..186ee8a08f6c 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -97,7 +97,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			*hpdp = __hugepd(__pa(new) |
 					 (shift_to_mmu_psize(pshift) << 2));
 #elif defined(CONFIG_PPC_8xx)
-			*hpdp = __hugepd(__pa(new) |
+			*hpdp = __hugepd(__pa(new) | _PMD_USER |
 					 (pshift == PAGE_SHIFT_8M ? _PMD_PAGE_8M :
 					  _PMD_PAGE_512K) | _PMD_PRESENT);
 #else
-- 
2.13.3
