Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 11 Mar 2009 14:24:37 +1100
Subject: [PATCH] powerpc/mm: Properly wire up get_user_pages_fast() on 32-bit
Message-Id: <20090311032440.16A50DE0C4@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While we did add support for _PAGE_SPECIAL on some 32-bit platforms,
we never actually built get_user_pages_fast() on them. This fixes
it which requires a little bit of ifdef'ing around.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/mm/Makefile |    4 ++--
 arch/powerpc/mm/gup.c    |   16 +++++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

--- linux-work.orig/arch/powerpc/mm/Makefile	2009-03-10 16:08:18.000000000 +1100
+++ linux-work/arch/powerpc/mm/Makefile	2009-03-10 16:51:04.000000000 +1100
@@ -6,7 +6,7 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
 
-obj-y				:= fault.o mem.o pgtable.o \
+obj-y				:= fault.o mem.o pgtable.o gup.o \
 				   init_$(CONFIG_WORD_SIZE).o \
 				   pgtable_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
@@ -14,7 +14,7 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_cont
 hash-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC64)		+= hash_utils_64.o \
 				   slb_low.o slb.o stab.o \
-				   gup.o mmap.o $(hash-y)
+				   mmap.o $(hash-y)
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
 				   tlb_hash$(CONFIG_WORD_SIZE).o \
Index: linux-work/arch/powerpc/mm/gup.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/gup.c	2009-03-10 16:08:18.000000000 +1100
+++ linux-work/arch/powerpc/mm/gup.c	2009-03-10 16:52:14.000000000 +1100
@@ -14,6 +14,8 @@
 #include <linux/rwsem.h>
 #include <asm/pgtable.h>
 
+#ifdef __HAVE_ARCH_PTE_SPECIAL
+
 /*
  * The performance critical leaf functions are made noinline otherwise gcc
  * inlines everything into a single function which results in too much
@@ -151,8 +153,11 @@ int get_user_pages_fast(unsigned long st
 	unsigned long addr, len, end;
 	unsigned long next;
 	pgd_t *pgdp;
-	int psize, nr = 0;
+	int nr = 0;
+#ifdef CONFIG_PPC64
 	unsigned int shift;
+	int psize;
+#endif
 
 	pr_debug("%s(%lx,%x,%s)\n", __func__, start, nr_pages, write ? "write" : "read");
 
@@ -205,8 +210,13 @@ int get_user_pages_fast(unsigned long st
 	 */
 	local_irq_disable();
 
+#ifdef CONFIG_PPC64
+	/* Those bits are related to hugetlbfs implementation and only exist
+	 * on 64-bit for now
+	 */
 	psize = get_slice_psize(mm, addr);
 	shift = mmu_psize_defs[psize].shift;
+#endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_HUGETLB_PAGE
 	if (unlikely(mmu_huge_psizes[psize])) {
@@ -236,7 +246,9 @@ int get_user_pages_fast(unsigned long st
 		do {
 			pgd_t pgd = *pgdp;
 
+#ifdef CONFIG_PPC64
 			VM_BUG_ON(shift != mmu_psize_defs[get_slice_psize(mm, addr)].shift);
+#endif
 			pr_debug("  %016lx: normal pgd %p\n", addr,
 				 (void *)pgd_val(pgd));
 			next = pgd_addr_end(addr, end);
@@ -279,3 +291,5 @@ slow_irqon:
 		return ret;
 	}
 }
+
+#endif /* __HAVE_ARCH_PTE_SPECIAL */
