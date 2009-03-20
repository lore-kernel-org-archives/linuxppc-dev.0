Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 20 Mar 2009 16:34:09 +1100
Subject: [PATCH 2/6] powerpc/mm: Merge various PTE bits and accessors
	definitions (v3)
In-Reply-To: <1237527248.890279.946079812092.qpush@grosgo>
Message-Id: <20090320053428.E643EDDF03@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that they are almost identical, we can merge some of the definitions
related to the PTE format into common files.

This creates a new pte-common.h which is included by both 32 and 64-bit
right after the CPU specific pte-*.h file, and which defines some
bits to "default" values if they haven't been defined already, and
then provides a generic definition of most of the bit combinations
based on these and exposed to the rest of the kernel.

I also moved to the common pgtable.h most of the "small" accessors to the
PTE bits and modification helpers (pte_mk*). The actual accessors remain
in their separate files.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: Fix mixup with previous patch
v3: Rebase due to change in previous patch and fix pfn_pte() for 32-bit
    platforms with >32 bit physical address space

 arch/powerpc/include/asm/pgtable-ppc32.h |  204 -------------------------------
 arch/powerpc/include/asm/pgtable-ppc64.h |  132 --------------------
 arch/powerpc/include/asm/pgtable.h       |   54 +++++++-
 arch/powerpc/include/asm/pte-common.h    |  180 +++++++++++++++++++++++++++
 4 files changed, 233 insertions(+), 337 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc32.h	2009-03-20 15:47:40.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc32.h	2009-03-20 15:50:39.000000000 +1100
@@ -97,174 +97,11 @@ extern int icache_44x_need_flush;
 #include <asm/pte-hash32.h>
 #endif
 
-/* If _PAGE_SPECIAL is defined, then we advertise our support for it */
-#ifdef _PAGE_SPECIAL
-#define __HAVE_ARCH_PTE_SPECIAL
-#endif
-
-/*
- * Some bits are only used on some cpu families... Make sure that all
- * the undefined gets defined as 0
- */
-#ifndef _PAGE_HASHPTE
-#define _PAGE_HASHPTE	0
-#endif
-#ifndef _PTE_NONE_MASK
-#define _PTE_NONE_MASK 0
-#endif
-#ifndef _PAGE_SHARED
-#define _PAGE_SHARED	0
-#endif
-#ifndef _PAGE_HWWRITE
-#define _PAGE_HWWRITE	0
-#endif
-#ifndef _PAGE_HWEXEC
-#define _PAGE_HWEXEC	0
-#endif
-#ifndef _PAGE_EXEC
-#define _PAGE_EXEC	0
-#endif
-#ifndef _PAGE_ENDIAN
-#define _PAGE_ENDIAN	0
-#endif
-#ifndef _PAGE_COHERENT
-#define _PAGE_COHERENT	0
-#endif
-#ifndef _PAGE_WRITETHRU
-#define _PAGE_WRITETHRU	0
-#endif
-#ifndef _PAGE_SPECIAL
-#define _PAGE_SPECIAL	0
-#endif
-#ifndef _PMD_PRESENT_MASK
-#define _PMD_PRESENT_MASK	_PMD_PRESENT
-#endif
-#ifndef _PMD_SIZE
-#define _PMD_SIZE	0
-#define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
-#endif
-
-#ifndef _PAGE_KERNEL_RO
-#define _PAGE_KERNEL_RO	0
-#endif
-#ifndef _PAGE_KERNEL_RW
-#define _PAGE_KERNEL_RW	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
-#endif
-
-#define _PAGE_HPTEFLAGS _PAGE_HASHPTE
-
-/* Location of the PFN in the PTE. Most platforms use the same as _PAGE_SHIFT
- * here (ie, naturally aligned). Platform who don't just pre-define the
- * value so we don't override it here
- */
-#ifndef PTE_RPN_SHIFT
-#define PTE_RPN_SHIFT	(PAGE_SHIFT)
-#endif
-
-#ifdef CONFIG_PTE_64BIT
-#define PTE_RPN_MAX	(1ULL << (64 - PTE_RPN_SHIFT))
-#define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
-#else
-#define PTE_RPN_MAX	(1UL << (32 - PTE_RPN_SHIFT))
-#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
-#endif
-
-/* _PAGE_CHG_MASK masks of bits that are to be preserved accross
- * pgprot changes
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-                         _PAGE_ACCESSED | _PAGE_SPECIAL)
-
-/* Mask of bits returned by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-			 _PAGE_WRITETHRU | _PAGE_ENDIAN | \
-			 _PAGE_USER | _PAGE_ACCESSED | \
-			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
-			 _PAGE_EXEC | _PAGE_HWEXEC)
-
-/*
- * We define 2 sets of base prot bits, one for basic pages (ie,
- * cacheable kernel and user pages) and one for non cacheable
- * pages. We always set _PAGE_COHERENT when SMP is enabled or
- * the processor might need it for DMA coherency.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU)
-#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
-#else
-#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
-#endif
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
-
-/* Permission masks used for kernel mappings */
-#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
-#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE)
-#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE | _PAGE_GUARDED)
-#define PAGE_KERNEL_X __pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC)
-#define PAGE_KERNEL_RO __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
-#define PAGE_KERNEL_ROX __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO | _PAGE_EXEC)
-
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
-	defined(CONFIG_KPROBES)
-/* We want the debuggers to be able to set breakpoints anywhere, so
- * don't write protect the kernel text */
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
-#else
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-#endif
-
-#define PAGE_NONE	__pgprot(_PAGE_BASE)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
-
-/*
- * The PowerPC can only do execute protection on a segment (256MB) basis,
- * not on a page basis.  So we consider execute permission the same as read.
- * Also, write permissions imply read permissions.
- * This is the closest we can get..
- */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY_X
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY_X
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY_X
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED_X
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED_X
+/* And here we include common definitions */
+#include <asm/pte-common.h>
 
 #ifndef __ASSEMBLY__
-/* Make sure we get a link error if PMD_PAGE_SIZE is ever called on a
- * kernel without large page PMD support */
-extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 
-/*
- * Conversions between PTE values and page frame numbers.
- */
-
-#define pte_pfn(x)		(pte_val(x) >> PTE_RPN_SHIFT)
-#define pte_page(x)		pfn_to_page(pte_pfn(x))
-
-#define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |\
-					pgprot_val(prot))
-#define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
-#endif /* __ASSEMBLY__ */
-
-#define pte_none(pte)		((pte_val(pte) & ~_PTE_NONE_MASK) == 0)
-#define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(ptep, ~_PAGE_HASHPTE, 0); } while (0)
 
@@ -273,43 +110,6 @@ extern unsigned long bad_call_to_PMD_PAG
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
 #define	pmd_clear(pmdp)		do { pmd_val(*(pmdp)) = 0; } while (0)
 
-#ifndef __ASSEMBLY__
-/*
- * The following only work if pte_present() is true.
- * Undefined behaviour if not..
- */
-static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
-static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
-static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
-static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
-
-static inline pte_t pte_wrprotect(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE); return pte; }
-static inline pte_t pte_mkclean(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_HWWRITE); return pte; }
-static inline pte_t pte_mkold(pte_t pte) {
-	pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-
-static inline pte_t pte_mkwrite(pte_t pte) {
-	pte_val(pte) |= _PAGE_RW; return pte; }
-static inline pte_t pte_mkdirty(pte_t pte) {
-	pte_val(pte) |= _PAGE_DIRTY; return pte; }
-static inline pte_t pte_mkyoung(pte_t pte) {
-	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkspecial(pte_t pte) {
-	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
-static inline pgprot_t pte_pgprot(pte_t pte)
-{
-	return __pgprot(pte_val(pte) & PAGE_PROT_BITS);
-}
-
-static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
-{
-	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
-	return pte;
-}
-
 /*
  * When flushing the tlb entry for a page, we also need to flush the hash
  * table entry.  flush_hash_pages is assembler (for speed) in hashtable.S.
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-20 15:49:51.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-03-20 15:52:59.000000000 +1100
@@ -80,82 +80,8 @@
  * Include the PTE bits definitions
  */
 #include <asm/pte-hash64.h>
+#include <asm/pte-common.h
 
-/* Some other useful definitions */
-#define PTE_RPN_MAX	(1UL << (64 - PTE_RPN_SHIFT))
-#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
-
-/* _PAGE_CHG_MASK masks of bits that are to be preserved accross
- * pgprot changes
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-                         _PAGE_ACCESSED | _PAGE_SPECIAL)
-
-#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
-#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
-
-
-/* Permission masks used to generate the __P and __S table,
- *
- * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
- */
-#define PAGE_NONE	__pgprot(_PAGE_BASE)
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
-
-/* Permission masks used for kernel mappings */
-#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
-#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE)
-#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
-				 _PAGE_NO_CACHE | _PAGE_GUARDED)
-#define PAGE_KERNEL_X __pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC)
-#define PAGE_KERNEL_RO __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
-#define PAGE_KERNEL_ROX __pgprot(_PAGE_BASE | _PAGE_KERNEL_RO | _PAGE_EXEC)
-
-/* Protection bits for use by pte_pgprot() */
-#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | \
-			 _PAGE_NO_CACHE | _PAGE_WRITETHRU |		\
-			 _PAGE_4K_PFN | _PAGE_USER | _PAGE_RW |		\
-			 _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_EXEC)
-
-
-/* We always have _PAGE_SPECIAL on 64 bit */
-#define __HAVE_ARCH_PTE_SPECIAL
-
-/* Make modules code happy. We don't set RO yet */
-#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
-
-/*
- * POWER4 and newer have per page execute protection, older chips can only
- * do this on a segment (256MB) basis.
- *
- * Also, write permissions imply read permissions.
- * This is the closest we can get..
- *
- * Note due to the way vm flags are laid out, the bits are XWR
- */
-#define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY_X
-#define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY_X
-#define __P111	PAGE_COPY_X
-
-#define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY_X
-#define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED_X
-#define __S111	PAGE_SHARED_X
 
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
@@ -196,34 +122,8 @@
 #endif /* __real_pte */
 
 
-/*
- * Conversion functions: convert a page and protection to a page entry,
- * and a page entry and page directory to the page they refer to.
- *
- * mk_pte takes a (struct page *) as input
- */
-#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-
-static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
-{
-	pte_t pte;
-
-
-	pte_val(pte) = (pfn << PTE_RPN_SHIFT) | pgprot_val(pgprot);
-	return pte;
-}
-
-#define pte_modify(_pte, newprot) \
-  (__pte((pte_val(_pte) & _PAGE_CHG_MASK) | pgprot_val(newprot)))
-
-#define pte_none(pte)		((pte_val(pte) & ~_PAGE_HPTEFLAGS) == 0)
-#define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
-
 /* pte_clear moved to later in this file */
 
-#define pte_pfn(x)		((unsigned long)((pte_val(x)>>PTE_RPN_SHIFT)))
-#define pte_page(x)		pfn_to_page(pte_pfn(x))
-
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
@@ -271,36 +171,6 @@ static inline pte_t pfn_pte(unsigned lon
 /* This now only contains the vmalloc pages */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
-/*
- * The following only work if pte_present() is true.
- * Undefined behaviour if not..
- */
-static inline int pte_write(pte_t pte) { return pte_val(pte) & _PAGE_RW;}
-static inline int pte_dirty(pte_t pte) { return pte_val(pte) & _PAGE_DIRTY;}
-static inline int pte_young(pte_t pte) { return pte_val(pte) & _PAGE_ACCESSED;}
-static inline int pte_file(pte_t pte) { return pte_val(pte) & _PAGE_FILE;}
-static inline int pte_special(pte_t pte) { return pte_val(pte) & _PAGE_SPECIAL; }
-
-static inline pte_t pte_wrprotect(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_RW); return pte; }
-static inline pte_t pte_mkclean(pte_t pte) {
-	pte_val(pte) &= ~(_PAGE_DIRTY); return pte; }
-static inline pte_t pte_mkold(pte_t pte) {
-	pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkwrite(pte_t pte) {
-	pte_val(pte) |= _PAGE_RW; return pte; }
-static inline pte_t pte_mkdirty(pte_t pte) {
-	pte_val(pte) |= _PAGE_DIRTY; return pte; }
-static inline pte_t pte_mkyoung(pte_t pte) {
-	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
-static inline pte_t pte_mkhuge(pte_t pte) {
-	return pte; }
-static inline pte_t pte_mkspecial(pte_t pte) {
-	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
-static inline pgprot_t pte_pgprot(pte_t pte)
-{
-	return __pgprot(pte_val(pte) & PAGE_PROT_BITS);
-}
 
 /* Atomic PTE updates */
 static inline unsigned long pte_update(struct mm_struct *mm,
Index: linux-work/arch/powerpc/include/asm/pgtable.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable.h	2009-03-20 15:47:40.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable.h	2009-03-20 15:55:06.000000000 +1100
@@ -25,12 +25,58 @@ static inline void assert_pte_locked(str
 #  include <asm/pgtable-ppc32.h>
 #endif
 
-/* Special mapping for AGP */
-#define PAGE_AGP	(PAGE_KERNEL_NC)
-#define HAVE_PAGE_AGP
-
 #ifndef __ASSEMBLY__
 
+/* Generic accessors to PTE bits */
+static inline int pte_write(pte_t pte)		{ return pte_val(pte) & _PAGE_RW; }
+static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
+static inline int pte_young(pte_t pte)		{ return pte_val(pte) & _PAGE_ACCESSED; }
+static inline int pte_file(pte_t pte)		{ return pte_val(pte) & _PAGE_FILE; }
+static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
+static inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_PRESENT; }
+static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
+
+/* Conversion functions: convert a page and protection to a page entry,
+ * and a page entry and page directory to the page they refer to.
+ *
+ * Even if PTEs can be unsigned long long, a PFN is always an unsigned
+ * long for now.
+ */
+static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot) {
+	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
+		     pgprot_val(pgprot)); }
+static inline unsigned long pte_pfn(pte_t pte)	{
+	return pte_val(pte) >> PTE_RPN_SHIFT; }
+
+/* Keep these as a macros to avoid include dependency mess */
+#define pte_page(x)		pfn_to_page(pte_pfn(x))
+#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
+
+/* Generic modifiers for PTE bits */
+static inline pte_t pte_wrprotect(pte_t pte) {
+	pte_val(pte) &= ~(_PAGE_RW | _PAGE_HWWRITE); return pte; }
+static inline pte_t pte_mkclean(pte_t pte) {
+	pte_val(pte) &= ~(_PAGE_DIRTY | _PAGE_HWWRITE); return pte; }
+static inline pte_t pte_mkold(pte_t pte) {
+	pte_val(pte) &= ~_PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkwrite(pte_t pte) {
+	pte_val(pte) |= _PAGE_RW; return pte; }
+static inline pte_t pte_mkdirty(pte_t pte) {
+	pte_val(pte) |= _PAGE_DIRTY; return pte; }
+static inline pte_t pte_mkyoung(pte_t pte) {
+	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
+static inline pte_t pte_mkspecial(pte_t pte) {
+	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
+static inline pte_t pte_mkhuge(pte_t pte) {
+	return pte; }
+static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
+{
+	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
+	return pte;
+}
+
+
 /* Insert a PTE, top-level function is out of line. It uses an inline
  * low level function in the respective pgtable-* files
  */
Index: linux-work/arch/powerpc/include/asm/pte-common.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pte-common.h	2009-03-20 15:51:48.000000000 +1100
@@ -0,0 +1,180 @@
+/* Included from asm/pgtable-*.h only ! */
+
+/*
+ * Some bits are only used on some cpu families... Make sure that all
+ * the undefined gets a sensible default
+ */
+#ifndef _PAGE_HASHPTE
+#define _PAGE_HASHPTE	0
+#endif
+#ifndef _PAGE_SHARED
+#define _PAGE_SHARED	0
+#endif
+#ifndef _PAGE_HWWRITE
+#define _PAGE_HWWRITE	0
+#endif
+#ifndef _PAGE_HWEXEC
+#define _PAGE_HWEXEC	0
+#endif
+#ifndef _PAGE_EXEC
+#define _PAGE_EXEC	0
+#endif
+#ifndef _PAGE_ENDIAN
+#define _PAGE_ENDIAN	0
+#endif
+#ifndef _PAGE_COHERENT
+#define _PAGE_COHERENT	0
+#endif
+#ifndef _PAGE_WRITETHRU
+#define _PAGE_WRITETHRU	0
+#endif
+#ifndef _PAGE_SPECIAL
+#define _PAGE_SPECIAL	0
+#endif
+#ifndef _PAGE_4K_PFN
+#define _PAGE_4K_PFN		0
+#endif
+#ifndef _PAGE_PSIZE
+#define _PAGE_PSIZE		0
+#endif
+#ifndef _PMD_PRESENT_MASK
+#define _PMD_PRESENT_MASK	_PMD_PRESENT
+#endif
+#ifndef _PMD_SIZE
+#define _PMD_SIZE	0
+#define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
+#endif
+#ifndef _PAGE_KERNEL_RO
+#define _PAGE_KERNEL_RO	0
+#endif
+#ifndef _PAGE_KERNEL_RW
+#define _PAGE_KERNEL_RW	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
+#endif
+#ifndef _PAGE_HPTEFLAGS
+#define _PAGE_HPTEFLAGS _PAGE_HASHPTE
+#endif
+#ifndef _PTE_NONE_MASK
+#define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
+#endif
+
+/* Make sure we get a link error if PMD_PAGE_SIZE is ever called on a
+ * kernel without large page PMD support
+ */
+#ifndef __ASSEMBLY__
+extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
+#endif /* __ASSEMBLY__ */
+
+/* Location of the PFN in the PTE. Most 32-bit platforms use the same
+ * as _PAGE_SHIFT here (ie, naturally aligned).
+ * Platform who don't just pre-define the value so we don't override it here
+ */
+#ifndef PTE_RPN_SHIFT
+#define PTE_RPN_SHIFT	(PAGE_SHIFT)
+#endif
+
+/* The mask convered by the RPN must be a ULL on 32-bit platforms with
+ * 64-bit PTEs
+ */
+#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+#define PTE_RPN_MAX	(1ULL << (64 - PTE_RPN_SHIFT))
+#define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
+#else
+#define PTE_RPN_MAX	(1UL << (32 - PTE_RPN_SHIFT))
+#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
+#endif
+
+/* _PAGE_CHG_MASK masks of bits that are to be preserved accross
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+                         _PAGE_ACCESSED | _PAGE_SPECIAL)
+
+/* Mask of bits returned by pte_pgprot() */
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_ENDIAN | _PAGE_4K_PFN | \
+			 _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
+			 _PAGE_EXEC | _PAGE_HWEXEC)
+
+/*
+ * We define 2 sets of base prot bits, one for basic pages (ie,
+ * cacheable kernel and user pages) and one for non cacheable
+ * pages. We always set _PAGE_COHERENT when SMP is enabled or
+ * the processor might need it for DMA coherency.
+ */
+#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_STD_MMU)
+#define _PAGE_BASE	(_PAGE_BASE_NC | _PAGE_COHERENT)
+#else
+#define _PAGE_BASE	(_PAGE_BASE_NC)
+#endif
+
+/* Permission masks used to generate the __P and __S table,
+ *
+ * Note:__pgprot is defined in arch/powerpc/include/asm/page.h
+ *
+ * Write permissions imply read permissions for now (we could make write-only
+ * pages on BookE but we don't bother for now). Execute permission control is
+ * possible on platforms that define _PAGE_EXEC
+ *
+ * Note due to the way vm flags are laid out, the bits are XWR
+ */
+#define PAGE_NONE	__pgprot(_PAGE_BASE)
+#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+
+#define __P000	PAGE_NONE
+#define __P001	PAGE_READONLY
+#define __P010	PAGE_COPY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_READONLY_X
+#define __P101	PAGE_READONLY_X
+#define __P110	PAGE_COPY_X
+#define __P111	PAGE_COPY_X
+
+#define __S000	PAGE_NONE
+#define __S001	PAGE_READONLY
+#define __S010	PAGE_SHARED
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY_X
+#define __S101	PAGE_READONLY_X
+#define __S110	PAGE_SHARED_X
+#define __S111	PAGE_SHARED_X
+
+/* Permission masks used for kernel mappings */
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
+#define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE)
+#define PAGE_KERNEL_NCG	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | \
+				 _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define PAGE_KERNEL_X	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC)
+#define PAGE_KERNEL_RO	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO)
+#define PAGE_KERNEL_ROX	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RO | _PAGE_EXEC)
+
+/* Protection used for kernel text. We want the debuggers to be able to
+ * set breakpoints anywhere, so don't write protect the kernel text
+ * on platforms where such control is possible.
+ */
+#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) ||\
+	defined(CONFIG_KPROBES)
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
+#else
+#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
+#endif
+
+/* Make modules code happy. We don't set RO yet */
+#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
+
+/* Advertise special mapping type for AGP */
+#define PAGE_AGP		(PAGE_KERNEL_NC)
+#define HAVE_PAGE_AGP
+
+/* Advertise support for _PAGE_SPECIAL */
+#ifdef _PAGE_SPECIAL
+#define __HAVE_ARCH_PTE_SPECIAL
+#endif
+
