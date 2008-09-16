Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26A61DE113
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 01:15:51 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8GFFmYi024488
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 10:15:48 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 4/4] powerpc/mm: Implement _PAGE_SPECIAL & pte_special()
	for 32-bit
Date: Tue, 16 Sep 2008 10:15:45 -0500
Message-Id: <1221578145-29102-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1221578145-29102-3-git-send-email-galak@kernel.crashing.org>
References: <1221578145-29102-1-git-send-email-galak@kernel.crashing.org>
	<1221578145-29102-2-git-send-email-galak@kernel.crashing.org>
	<1221578145-29102-3-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement _PAGE_SPECIAL and pte_special() for 32-bit powerpc. This bit will
be used by the fast get_user_pages() to differenciate PTEs that correspond
to a valid struct page from special mappings that don't such as IO mappings
obtained via io_remap_pfn_ranges().

We currently only implement this on sub-arch that support SMP or will so
in the future (6xx, 44x, FSL-BookE) and not (8xx, 40x).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/pgtable-ppc32.h |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 1b11955..c2e58b4 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -261,6 +261,7 @@ extern int icache_44x_need_flush;
 #define _PAGE_HWEXEC	0x00000004		/* H: Execute permission */
 #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
 #define _PAGE_DIRTY	0x00000010		/* S: Page dirty */
+#define _PAGE_SPECIAL	0x00000020		/* S: Special page */
 #define _PAGE_USER	0x00000040		/* S: User page */
 #define _PAGE_ENDIAN	0x00000080		/* H: E bit */
 #define _PAGE_GUARDED	0x00000100		/* H: G bit */
@@ -276,6 +277,7 @@ extern int icache_44x_need_flush;
 /* ERPN in a PTE never gets cleared, ignore it */
 #define _PTE_NONE_MASK	0xffffffff00000000ULL
 
+#define __HAVE_ARCH_PTE_SPECIAL
 
 #elif defined(CONFIG_FSL_BOOKE)
 /*
@@ -305,6 +307,7 @@ extern int icache_44x_need_flush;
 #define _PAGE_COHERENT	0x00100	/* H: M bit */
 #define _PAGE_NO_CACHE	0x00200	/* H: I bit */
 #define _PAGE_WRITETHRU	0x00400	/* H: W bit */
+#define _PAGE_SPECIAL	0x00800 /* S: Special page */
 
 #ifdef CONFIG_PTE_64BIT
 /* ERPN in a PTE never gets cleared, ignore it */
@@ -315,6 +318,8 @@ extern int icache_44x_need_flush;
 #define _PMD_PRESENT_MASK (PAGE_MASK)
 #define _PMD_BAD	(~PAGE_MASK)
 
+#define __HAVE_ARCH_PTE_SPECIAL
+
 #elif defined(CONFIG_8xx)
 /* Definitions for 8xx embedded chips. */
 #define _PAGE_PRESENT	0x0001	/* Page is valid */
@@ -362,6 +367,7 @@ extern int icache_44x_need_flush;
 #define _PAGE_ACCESSED	0x100	/* R: page referenced */
 #define _PAGE_EXEC	0x200	/* software: i-cache coherency required */
 #define _PAGE_RW	0x400	/* software: user write access allowed */
+#define _PAGE_SPECIAL	0x800	/* software: Special page */
 
 #define _PTE_NONE_MASK	_PAGE_HASHPTE
 
@@ -372,6 +378,8 @@ extern int icache_44x_need_flush;
 /* Hash table based platforms need atomic updates of the linux PTE */
 #define PTE_ATOMIC_UPDATES	1
 
+#define __HAVE_ARCH_PTE_SPECIAL
+
 #endif
 
 /*
@@ -404,6 +412,9 @@ extern int icache_44x_need_flush;
 #ifndef _PAGE_WRITETHRU
 #define _PAGE_WRITETHRU	0
 #endif
+#ifndef _PAGE_SPECIAL
+#define _PAGE_SPECIAL	0
+#endif
 #ifndef _PMD_PRESENT_MASK
 #define _PMD_PRESENT_MASK	_PMD_PRESENT
 #endif
@@ -534,7 +545,7 @@ static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
 static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
-static inline int pte_special(pte_t pte)	{ return 0; }
+static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 
 static inline void pte_uncache(pte_t pte)       { pte_val(pte) |= _PAGE_NO_CACHE; }
 static inline void pte_cache(pte_t pte)         { pte_val(pte) &= ~_PAGE_NO_CACHE; }
@@ -553,7 +564,7 @@ static inline pte_t pte_mkdirty(pte_t pte) {
 static inline pte_t pte_mkyoung(pte_t pte) {
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkspecial(pte_t pte) {
-	return pte; }
+	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
 static inline unsigned long pte_pgprot(pte_t pte)
 {
 	return __pgprot(pte_val(pte)) & PAGE_PROT_BITS;
-- 
1.5.5.1
