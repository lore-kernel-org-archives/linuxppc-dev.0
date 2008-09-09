Return-Path: <dgibson@ozlabs.org>
Date: Tue, 9 Sep 2008 15:04:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Get USE_STRICT_MM_TYPECHECKS working again
Message-ID: <20080909050447.GC30127@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The typesafe version of the powerpc pagetable handling (with
USE_STRICT_MM_TYPECHECKS defined) has bitrotted again.  This patch
makes a bunch of small fixes to get it building again.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2008-09-09 14:17:27.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/pgtable-ppc64.h	2008-09-09 14:17:31.000000000 +1000
@@ -117,10 +117,10 @@
 #define PAGE_AGP	__pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_NO_CACHE)
 #define HAVE_PAGE_AGP
 
-#define PAGE_PROT_BITS	__pgprot(_PAGE_GUARDED | _PAGE_COHERENT | \
-				 _PAGE_NO_CACHE | _PAGE_WRITETHRU | \
-				 _PAGE_4K_PFN | _PAGE_RW | _PAGE_USER | \
- 				 _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_EXEC)
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | \
+			 _PAGE_NO_CACHE | _PAGE_WRITETHRU |		\
+			 _PAGE_4K_PFN | _PAGE_RW | _PAGE_USER |		\
+			 _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_EXEC)
 /* PTEIDX nibble */
 #define _PTEIDX_SECONDARY	0x8
 #define _PTEIDX_GROUP_IX	0x7
@@ -264,9 +264,9 @@ static inline pte_t pte_mkhuge(pte_t pte
 	return pte; }
 static inline pte_t pte_mkspecial(pte_t pte) {
 	pte_val(pte) |= _PAGE_SPECIAL; return pte; }
-static inline unsigned long pte_pgprot(pte_t pte)
+static inline pgprot_t pte_pgprot(pte_t pte)
 {
-	return __pgprot(pte_val(pte)) & PAGE_PROT_BITS;
+	return __pgprot(pte_val(pte) & PAGE_PROT_BITS);
 }
 
 /* Atomic PTE updates */
Index: working-2.6/arch/powerpc/include/asm/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/pgtable-ppc32.h	2008-09-02 11:50:12.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/pgtable-ppc32.h	2008-09-09 14:17:31.000000000 +1000
@@ -415,11 +415,11 @@ extern int icache_44x_need_flush;
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 
-#define PAGE_PROT_BITS	__pgprot(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
-				 _PAGE_WRITETHRU | _PAGE_ENDIAN | \
-				 _PAGE_USER | _PAGE_ACCESSED | \
-				 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
-				 _PAGE_EXEC | _PAGE_HWEXEC)
+#define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
+			 _PAGE_WRITETHRU | _PAGE_ENDIAN | \
+			 _PAGE_USER | _PAGE_ACCESSED | \
+			 _PAGE_RW | _PAGE_HWWRITE | _PAGE_DIRTY | \
+			 _PAGE_EXEC | _PAGE_HWEXEC)
 /*
  * Note: the _PAGE_COHERENT bit automatically gets set in the hardware
  * PTE if CONFIG_SMP is defined (hash_page does this); there is no need
@@ -553,9 +553,9 @@ static inline pte_t pte_mkyoung(pte_t pt
 	pte_val(pte) |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkspecial(pte_t pte) {
 	return pte; }
-static inline unsigned long pte_pgprot(pte_t pte)
+static inline pgprot_t pte_pgprot(pte_t pte)
 {
-	return __pgprot(pte_val(pte)) & PAGE_PROT_BITS;
+	return __pgprot(pte_val(pte) & PAGE_PROT_BITS);
 }
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
Index: working-2.6/arch/powerpc/include/asm/mman.h
===================================================================
--- working-2.6.orig/arch/powerpc/include/asm/mman.h	2008-09-02 11:50:12.000000000 +1000
+++ working-2.6/arch/powerpc/include/asm/mman.h	2008-09-09 14:17:31.000000000 +1000
@@ -44,7 +44,7 @@ static inline unsigned long arch_calc_vm
 
 static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 {
-	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : 0;
+	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
 }
 #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
Index: working-2.6/arch/powerpc/mm/gup.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/gup.c	2008-09-08 14:27:32.000000000 +1000
+++ working-2.6/arch/powerpc/mm/gup.c	2008-09-09 14:22:18.000000000 +1000
@@ -41,7 +41,7 @@ static noinline int gup_pte_range(pmd_t 
 		page = pte_page(pte);
 		if (!page_cache_get_speculative(page))
 			return 0;
-		if (unlikely(pte != *ptep)) {
+		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
 			put_page(page);
 			return 0;
 		}
@@ -92,7 +92,7 @@ static noinline int gup_huge_pte(pte_t *
 		*nr -= refs;
 		return 0;
 	}
-	if (unlikely(pte != *ptep)) {
+	if (unlikely(pte_val(pte) != pte_val(*ptep))) {
 		/* Could be optimized better */
 		while (*nr) {
 			put_page(page);
@@ -237,7 +237,8 @@ int get_user_pages_fast(unsigned long st
 			pgd_t pgd = *pgdp;
 
 			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, addr)].shift);
-			pr_debug("  %016lx: normal pgd %p\n", addr, (void *)pgd);
+			pr_debug("  %016lx: normal pgd %p\n", addr,
+				 (void *)pgd_val(pgd));
 			next = pgd_addr_end(addr, end);
 			if (pgd_none(pgd))
 				goto slow;
Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2008-09-09 14:17:27.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2008-09-09 14:17:31.000000000 +1000
@@ -539,7 +539,7 @@ static unsigned long __init htab_get_tab
 void create_section_mapping(unsigned long start, unsigned long end)
 {
 	BUG_ON(htab_bolt_mapping(start, end, __pa(start),
-				 PAGE_KERNEL, mmu_linear_psize,
+				 pgprot_val(PAGE_KERNEL), mmu_linear_psize,
 				 mmu_kernel_ssize));
 }
 
@@ -647,7 +647,7 @@ void __init htab_initialize(void)
 		mtspr(SPRN_SDR1, _SDR1);
 	}
 
-	prot = PAGE_KERNEL;
+	prot = pgprot_val(PAGE_KERNEL);
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	linear_map_hash_count = lmb_end_of_DRAM() >> PAGE_SHIFT;
Index: working-2.6/arch/powerpc/mm/init_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/init_64.c	2008-09-08 14:27:32.000000000 +1000
+++ working-2.6/arch/powerpc/mm/init_64.c	2008-09-09 14:17:31.000000000 +1000
@@ -228,8 +228,8 @@ int __meminit vmemmap_populate(struct pa
 			start, p, __pa(p));
 
 		mapped = htab_bolt_mapping(start, start + page_size, __pa(p),
-					   PAGE_KERNEL, mmu_vmemmap_psize,
-					   mmu_kernel_ssize);
+					   pgprot_val(PAGE_KERNEL),
+					   mmu_vmemmap_psize, mmu_kernel_ssize);
 		BUG_ON(mapped < 0);
 	}
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
