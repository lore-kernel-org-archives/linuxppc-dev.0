Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DDF61A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 03:42:29 +1100 (AEDT)
Received: from localhost
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 16:42:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C1A5F2190056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 16:42:20 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RGgNbI7668176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 16:42:23 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RGgNdv032507
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 10:42:23 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v2] powerpc/mm: Add page soft dirty tracking
Date: Tue, 27 Oct 2015 17:42:22 +0100
Message-Id: <1445964142-32050-1-git-send-email-ldufour@linux.vnet.ibm.com>
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

The _PAGE_SWP_SOFT_DIRTY bit is dynamically put after the swap type
in the swap pte. A check is added to ensure that the bit is not
overwritten by _PAGE_HPTEFLAGS.

V2:
- Fix allnoconfig build

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                     |  2 ++
 arch/powerpc/include/asm/pgtable-ppc64.h | 13 +++++++++--
 arch/powerpc/include/asm/pgtable.h       | 40 +++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/pte-book3e.h    |  1 +
 arch/powerpc/include/asm/pte-common.h    |  8 +++++--
 arch/powerpc/include/asm/pte-hash64.h    |  1 +
 6 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9a7057ec2154..73a4a36a6b38 100644
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
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 3245f2d96d4f..9ae686003b12 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -315,7 +315,8 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 {
 	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC |
+		 _PAGE_SOFT_DIRTY);
 
 #ifdef PTE_ATOMIC_UPDATES
 	unsigned long old, tmp;
@@ -354,6 +355,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 	 * We filter HPTEFLAGS on set_pte.			\
 	 */							\
 	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
+	BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY);	\
 	} while (0)
 /*
  * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
@@ -371,6 +373,8 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
+
+#define _PAGE_SWP_SOFT_DIRTY	(1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -389,7 +393,7 @@ void pgtable_cache_init(void);
  */
 #define _HPAGE_CHG_MASK (PTE_RPN_MASK | _PAGE_HPTEFLAGS |		\
 			 _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPLITTING | \
-			 _PAGE_THP_HUGE)
+			 _PAGE_THP_HUGE | _PAGE_SOFT_DIRTY)
 
 #ifndef __ASSEMBLY__
 /*
@@ -521,6 +525,11 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+#define pmd_soft_dirty(pmd)	pte_soft_dirty(pmd_pte(pmd))
+#define pmd_mksoft_dirty(pmd)	pte_pmd(pte_mksoft_dirty(pmd_pte(pmd)))
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index b64b4212b71f..9f1bc8a58ba4 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -38,6 +38,44 @@ static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL;
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline int pte_soft_dirty(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SOFT_DIRTY;
+}
+static inline pte_t pte_mksoft_dirty(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_SOFT_DIRTY;
+	return pte;
+}
+
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_SWP_SOFT_DIRTY;
+	return pte;
+}
+static inline int pte_swp_soft_dirty(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_SOFT_DIRTY;
+}
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	pte_val(pte) &= ~_PAGE_SWP_SOFT_DIRTY;
+	return pte;
+}
+
+static inline pte_t pte_clear_flags(pte_t pte, pte_basic_t clear)
+{
+	pte_val(pte) &= ~clear;
+	return pte;
+}
+static inline pmd_t pmd_clear_flags(pmd_t pmd, unsigned long clear)
+{
+	pmd_val(pmd) &= ~clear;
+	return pmd;
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * These work without NUMA balancing but the kernel does not care. See the
@@ -89,7 +127,7 @@ static inline pte_t pte_mkwrite(pte_t pte) {
 	pte_val(pte) &= ~_PAGE_RO;
 	pte_val(pte) |= _PAGE_RW; return pte; }
 static inline pte_t pte_mkdirty(pte_t pte) {
-	pte_val(pte) |= _PAGE_DIRTY; return pte; }
+	pte_val(pte) |= _PAGE_DIRTY | _PAGE_SOFT_DIRTY; return pte; }
 static inline pte_t pte_mkyoung(pte_t pte) {
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkspecial(pte_t pte) {
diff --git a/arch/powerpc/include/asm/pte-book3e.h b/arch/powerpc/include/asm/pte-book3e.h
index 8d8473278d91..df5581f817f6 100644
--- a/arch/powerpc/include/asm/pte-book3e.h
+++ b/arch/powerpc/include/asm/pte-book3e.h
@@ -57,6 +57,7 @@
 
 #define _PAGE_HASHPTE	0
 #define _PAGE_BUSY	0
+#define _PAGE_SOFT_DIRTY	0
 
 #define _PAGE_SPECIAL	_PAGE_SW0
 
diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 71537a319fc8..4ac8c2cff8e5 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -16,6 +16,9 @@
 #ifndef _PAGE_EXEC
 #define _PAGE_EXEC	0
 #endif
+#ifndef _PAGE_SOFT_DIRTY
+#define _PAGE_SOFT_DIRTY	0
+#endif
 #ifndef _PAGE_ENDIAN
 #define _PAGE_ENDIAN	0
 #endif
@@ -94,13 +97,14 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
  * pgprot changes
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-                         _PAGE_ACCESSED | _PAGE_SPECIAL)
+			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_SOFT_DIRTY)
 
 /* Mask of bits returned by pte_pgprot() */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_ENDIAN | _PAGE_4K_PFN | \
 			 _PAGE_USER | _PAGE_ACCESSED | _PAGE_RO | \
-			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | _PAGE_EXEC)
+			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
+			 _PAGE_EXEC | _PAGE_SOFT_DIRTY)
 
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
diff --git a/arch/powerpc/include/asm/pte-hash64.h b/arch/powerpc/include/asm/pte-hash64.h
index ef612c160da7..19ffd150957f 100644
--- a/arch/powerpc/include/asm/pte-hash64.h
+++ b/arch/powerpc/include/asm/pte-hash64.h
@@ -19,6 +19,7 @@
 #define _PAGE_BIT_SWAP_TYPE	2
 #define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert) */
 #define _PAGE_GUARDED		0x0008
+#define _PAGE_SOFT_DIRTY	0x0010 /* software dirty tracking */
 /* We can derive Memory coherence from _PAGE_NO_CACHE */
 #define _PAGE_NO_CACHE		0x0020 /* I: cache inhibit */
 #define _PAGE_WRITETHRU		0x0040 /* W: cache write-through */
-- 
1.9.1
