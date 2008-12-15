Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Dec 2008 16:44:51 +1100
Subject: [PATCH 10/16] powerpc/mm: Remove flush_HPTE()
In-Reply-To: <1229319836.100184.344640589620.qpush@grosgo>
Message-Id: <20081215054549.686BEDDFB1@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The function flush_HPTE() is used in only one place, the implementation
of DEBUG_PAGEALLOC on ppc32.

It's actually a dup of flush_tlb_page() though it's -slightly- more
efficient on hash based processors. We remove it and replace it by
a direct call to the hash flush code on those processors and to
flush_tlb_page() for everybody else.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/mmu_decl.h   |   17 -----------------
 arch/powerpc/mm/pgtable_32.c |    6 +++++-
 2 files changed, 5 insertions(+), 18 deletions(-)

--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2008-12-10 17:01:18.000000000 +1100
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2008-12-10 17:01:35.000000000 +1100
@@ -58,17 +58,14 @@ extern phys_addr_t lowmem_end_addr;
  * architectures.  -- Dan
  */
 #if defined(CONFIG_8xx)
-#define flush_HPTE(X, va, pg)	_tlbie(va, 0 /* 8xx doesn't care about PID */)
 #define MMU_init_hw()		do { } while(0)
 #define mmu_mapin_ram()		(0UL)
 
 #elif defined(CONFIG_4xx)
-#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
 
 #elif defined(CONFIG_FSL_BOOKE)
-#define flush_HPTE(pid, va, pg)	_tlbie(va, pid)
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
 extern void adjust_total_lowmem(void);
@@ -77,18 +74,4 @@ extern void adjust_total_lowmem(void);
 /* anything 32-bit except 4xx or 8xx */
 extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(void);
-
-/* Be careful....this needs to be updated if we ever encounter 603 SMPs,
- * which includes all new 82xx processors.  We need tlbie/tlbsync here
- * in that case (I think). -- Dan.
- */
-static inline void flush_HPTE(unsigned context, unsigned long va,
-			      unsigned long pdval)
-{
-	if ((Hash != 0) &&
-	    mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		flush_hash_pages(0, va, pdval, 1);
-	else
-		_tlbie(va);
-}
 #endif
Index: linux-work/arch/powerpc/mm/pgtable_32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable_32.c	2008-12-10 17:01:49.000000000 +1100
+++ linux-work/arch/powerpc/mm/pgtable_32.c	2008-12-10 17:04:36.000000000 +1100
@@ -342,7 +342,11 @@ static int __change_page_attr(struct pag
 		return -EINVAL;
 	set_pte_at(&init_mm, address, kpte, mk_pte(page, prot));
 	wmb();
-	flush_HPTE(0, address, pmd_val(*kpmd));
+#ifdef CONFIG_PPC_STD_MMU
+	flush_hash_pages(0, address, pmd_val(*kpmd), 1);
+#else
+	flush_tlb_page(NULL, address);
+#endif
 	pte_unmap(kpte);
 
 	return 0;
