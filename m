Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:46:11 +1100
Subject: [PATCH 11/11] powerpc: Remove calculation of io hole
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094640.961E467B93@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In mm_init_ppc64() we calculate the location of the "IO hole", but then
no one ever looks at the value. So don't bother.

That's actually all mm_init_ppc64() does, so get rid of it too.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/setup_64.c |    2 -
 arch/powerpc/mm/init_64.c      |   48 -----------------------------------------
 include/asm-powerpc/lmb.h      |    2 -
 include/asm-powerpc/mmu.h      |    1 
 4 files changed, 53 deletions(-)

Index: to-merge/arch/powerpc/kernel/setup_64.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/setup_64.c
+++ to-merge/arch/powerpc/kernel/setup_64.c
@@ -497,8 +497,6 @@ void __init setup_system(void)
 #endif
 	printk("-----------------------------------------------------\n");
 
-	mm_init_ppc64();
-
 	DBG(" <- setup_system()\n");
 }
 
Index: to-merge/arch/powerpc/mm/init_64.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/init_64.c
+++ to-merge/arch/powerpc/mm/init_64.c
@@ -84,54 +84,6 @@
 /* max amount of RAM to use */
 unsigned long __max_memory;
 
-/* info on what we think the IO hole is */
-unsigned long 	io_hole_start;
-unsigned long	io_hole_size;
-
-/*
- * Do very early mm setup.
- */
-void __init mm_init_ppc64(void)
-{
-#ifndef CONFIG_PPC_ISERIES
-	unsigned long i;
-#endif
-
-	ppc64_boot_msg(0x100, "MM Init");
-
-	/* This is the story of the IO hole... please, keep seated,
-	 * unfortunately, we are out of oxygen masks at the moment.
-	 * So we need some rough way to tell where your big IO hole
-	 * is. On pmac, it's between 2G and 4G, on POWER3, it's around
-	 * that area as well, on POWER4 we don't have one, etc...
-	 * We need that as a "hint" when sizing the TCE table on POWER3
-	 * So far, the simplest way that seem work well enough for us it
-	 * to just assume that the first discontinuity in our physical
-	 * RAM layout is the IO hole. That may not be correct in the future
-	 * (and isn't on iSeries but then we don't care ;)
-	 */
-
-#ifndef CONFIG_PPC_ISERIES
-	for (i = 1; i < lmb.memory.cnt; i++) {
-		unsigned long base, prevbase, prevsize;
-
-		prevbase = lmb.memory.region[i-1].base;
-		prevsize = lmb.memory.region[i-1].size;
-		base = lmb.memory.region[i].base;
-		if (base > (prevbase + prevsize)) {
-			io_hole_start = prevbase + prevsize;
-			io_hole_size = base  - (prevbase + prevsize);
-			break;
-		}
-	}
-#endif /* CONFIG_PPC_ISERIES */
-	if (io_hole_start)
-		printk("IO Hole assumed to be %lx -> %lx\n",
-		       io_hole_start, io_hole_start + io_hole_size - 1);
-
-	ppc64_boot_msg(0x100, "MM Init Done");
-}
-
 void free_initmem(void)
 {
 	unsigned long addr;
Index: to-merge/include/asm-powerpc/lmb.h
===================================================================
--- to-merge.orig/include/asm-powerpc/lmb.h
+++ to-merge/include/asm-powerpc/lmb.h
@@ -54,8 +54,6 @@ extern void __init lmb_enforce_memory_li
 
 extern void lmb_dump_all(void);
 
-extern unsigned long io_hole_start;
-
 static inline unsigned long
 lmb_size_bytes(struct lmb_region *type, unsigned long region_nr)
 {
Index: to-merge/include/asm-powerpc/mmu.h
===================================================================
--- to-merge.orig/include/asm-powerpc/mmu.h
+++ to-merge/include/asm-powerpc/mmu.h
@@ -236,7 +236,6 @@ extern void htab_initialize_secondary(vo
 extern void hpte_init_native(void);
 extern void hpte_init_lpar(void);
 extern void hpte_init_iSeries(void);
-extern void mm_init_ppc64(void);
 
 extern long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 				     unsigned long va, unsigned long prpn,
