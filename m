Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA8111A0075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 02:50:03 +1100 (AEDT)
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 30 Nov 2015 15:49:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2943C2190046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 15:49:50 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAUFnudt9765156
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 15:49:56 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAUFnuDs009154
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 08:49:56 -0700
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Cc: xemul@parallels.com
Subject: [PATCH v3] powerpc/mm: Add page soft dirty tracking
Date: Mon, 30 Nov 2015 16:49:54 +0100
Message-Id: <1448898594-28136-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

User space checkpoint and restart tool (CRIU) needs the page's change
to be soft tracked. This allows to do a pre checkpoint and then dump
only touched pages.

This is done by using a newly assigned PTE bit (_PAGE_SOFT_DIRTY) when
the page is backed in memory, and a new _PAGE_SWP_SOFT_DIRTY bit when
the page is swapped out.

To introduce a new PTE _PAGE_SOFT_DIRTY bit value common to hash 4k
and hash 64k pte, the bits already defined in hash-*4k.h should be
shifted left by one.

The _PAGE_SWP_SOFT_DIRTY bit is dynamically put after the swap type in
the swap pte. A check is added to ensure that the bit is not
overwritten by _PAGE_HPTEFLAGS.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

This patch should to be applied on top of the Aneesh's series titled
"[PATCH V5 00/31] powerpc/mm: Update page table format for book3s 64"

V3:
- updated to match Aneesh's changes in the pte handling
- updated to match commit a7b761749317 ("mm: add architecture
  primitives for software dirty bit clearing")
V2:
- Fix allnoconfig build

 arch/powerpc/Kconfig                          |  2 ++
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash.h     | 30 ++++++++++++++++++++++-----
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 26 +++++++++++++++++++++++
 5 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db49e0d796b1..6e03f85b11cd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -559,6 +559,7 @@ choice
 
 config PPC_4K_PAGES
 	bool "4k page size"
+	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
 
 config PPC_16K_PAGES
 	bool "16k page size"
@@ -567,6 +568,7 @@ config PPC_16K_PAGES
 config PPC_64K_PAGES
 	bool "64k page size"
 	depends on !PPC_FSL_BOOK3E && (44x || PPC_STD_MMU_64 || PPC_BOOK3E_64)
+	select HAVE_ARCH_SOFT_DIRTY if CHECKPOINT_RESTORE && PPC_BOOK3S
 
 config PPC_256K_PAGES
 	bool "256k page size"
diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index e59832c94609..ea0414d6659e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -52,7 +52,7 @@
 			 _PAGE_F_SECOND | _PAGE_F_GIX)
 
 /* shift to put page number into pte */
-#define PTE_RPN_SHIFT	(17)
+#define PTE_RPN_SHIFT	(18)
 
 #define _PAGE_4K_PFN		0
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 957d66d13a97..39e5a8fd86bd 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -31,8 +31,8 @@
 /* Bits to mask out from a PGD/PUD to get to the PMD page */
 #define PUD_MASKED_BITS		0x1ff
 
-#define _PAGE_COMBO	0x00020000 /* this is a combo 4k page */
-#define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
+#define _PAGE_COMBO	0x00040000 /* this is a combo 4k page */
+#define _PAGE_4K_PFN	0x00080000 /* PFN is for a single 4k page */
 
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_F_SECOND | \
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d86c95775e02..54db1a6d1f49 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -33,6 +33,7 @@
 #define _PAGE_F_GIX_SHIFT	12
 #define _PAGE_F_SECOND		0x08000 /* Whether to use secondary hash or not */
 #define _PAGE_SPECIAL		0x10000 /* software: special page */
+#define _PAGE_SOFT_DIRTY	0x20000 /* software: software dirty tracking */
 
 /*
  * THP pages can't be special. So use the _PAGE_SPECIAL
@@ -50,7 +51,7 @@
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
 			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
-			 _PAGE_THP_HUGE | _PAGE_PTE)
+			 _PAGE_THP_HUGE | _PAGE_PTE | _PAGE_SOFT_DIRTY)
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
@@ -138,14 +139,16 @@
  * pgprot changes
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE)
+			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE | \
+			 _PAGE_SOFT_DIRTY)
 /*
  * Mask of bits returned by pte_pgprot()
  */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_4K_PFN | \
 			 _PAGE_USER | _PAGE_ACCESSED |  \
-			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC)
+			 _PAGE_RW |  _PAGE_DIRTY | _PAGE_EXEC | \
+			 _PAGE_SOFT_DIRTY)
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
  * cacheable kernel and user pages) and one for non cacheable
@@ -341,7 +344,8 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC |
+		 _PAGE_SOFT_DIRTY);
 
 	unsigned long old, tmp;
 
@@ -368,6 +372,22 @@ static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIA
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline int pte_soft_dirty(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_SOFT_DIRTY);
+}
+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
+}
+
+static inline pte_t pte_clear_soft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_SOFT_DIRTY);
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * These work without NUMA balancing but the kernel does not care. See the
@@ -426,7 +446,7 @@ static inline pte_t pte_mkwrite(pte_t pte)
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
+	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0b43ca60dcb9..18ea9739d398 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -146,6 +146,7 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
 	 * We filter HPTEFLAGS on set_pte.			\
 	 */							\
 	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
+	BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY);	\
 	} while (0)
 /*
  * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
@@ -161,6 +162,24 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
 #define __swp_entry_to_pte(x)		__pte((x).val)
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+#define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
+}
+static inline int pte_swp_soft_dirty(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
+}
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
+}
+#else
+#define _PAGE_SWP_SOFT_DIRTY	0
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
@@ -201,6 +220,13 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
+
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+#define pmd_soft_dirty(pmd)    pte_soft_dirty(pmd_pte(pmd))
+#define pmd_mksoft_dirty(pmd)  pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
+#define pmd_clear_soft_dirty(pmd) pte_pmd(pte_clear_soft_dirty(pmd_pte(pmd)))
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 #ifdef CONFIG_NUMA_BALANCING
 static inline int pmd_protnone(pmd_t pmd)
 {
-- 
1.9.1
