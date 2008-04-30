Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 754D7DDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 15:41:58 +1000 (EST)
Subject: [RFC] [PATCH] vmemmap fixes to use smaller pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 15:41:48 +1000
Message-Id: <1209534108.18023.221.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes vmemmap to use a different region (region 0xf) of the
address space whose page size can be dynamically configured at boot.

The problem with the current approach of always using 16M pages is that
it's not well suited to machines that have small amounts of memory such
as small partitions on pseries, or PS3's.

In fact, on the PS3, failure to allocate the 16M page backing vmmemmap
tends to prevent hotplugging the HV's "additional" memory, thus limiting
the available memory even more, from my experience down to something
like 80M total, which makes it really not very useable.

The logic used by my match to choose the vmemmap page size is:

 - If 16M pages are available and there's 1G or more RAM at boot, use that size.
 - Else if 64K pages are available, use that
 - Else use 4K pages

I've tested on a POWER6 (16M pages) and on an iSeries POWER3 (4K pages)
and it seems to work fine.

However, when attempting to test on a PS3, it didn't boot.

In fact, it doesn't boot without my patch with current upstream. I tried
booting 2.6.25 with a ps3_defconfig and that doesn't work neither
(though at least when doing the later, I do get a black screen & no
sync, like of ps3fb failed monitor detection, while with current
upstream, I just get the last kexec messages and nothing happens).

Since the PS3 boot failures are impossible to debug unless your email is
@sony* and you have the special magic tools, I'll let Geoff try the
patch out.

Note that I intend to change the way we organize the kernel regions &
SLBs so the actual region will change from 0xf back to something else at
one point, as I simplify the SLB miss handler, but that will be for a
later patch.

Index: linux-work/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/hash_utils_64.c	2008-04-30 15:00:54.000000000 +1000
+++ linux-work/arch/powerpc/mm/hash_utils_64.c	2008-04-30 15:01:00.000000000 +1000
@@ -94,6 +94,9 @@ unsigned long htab_hash_mask;
 int mmu_linear_psize = MMU_PAGE_4K;
 int mmu_virtual_psize = MMU_PAGE_4K;
 int mmu_vmalloc_psize = MMU_PAGE_4K;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+int mmu_vmemmap_psize = MMU_PAGE_4K;
+#endif
 int mmu_io_psize = MMU_PAGE_4K;
 int mmu_kernel_ssize = MMU_SEGSIZE_256M;
 int mmu_highuser_ssize = MMU_SEGSIZE_256M;
@@ -387,11 +390,32 @@ static void __init htab_init_page_sizes(
 	}
 #endif /* CONFIG_PPC_64K_PAGES */
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	/* We try to use 16M pages for vmemmap if that is supported
+	 * and we have at least 1G of RAM at boot
+	 */
+	if (mmu_psize_defs[MMU_PAGE_16M].shift &&
+	    lmb_phys_mem_size() >= 0x40000000)
+		mmu_vmemmap_psize = MMU_PAGE_16M;
+	else if (mmu_psize_defs[MMU_PAGE_64K].shift)
+		mmu_vmemmap_psize = MMU_PAGE_64K;
+	else
+		mmu_vmemmap_psize = MMU_PAGE_4K;
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
 	printk(KERN_DEBUG "Page orders: linear mapping = %d, "
-	       "virtual = %d, io = %d\n",
+	       "virtual = %d, io = %d"
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	       ", vmemmap = %d"
+#endif
+	       "\n",
 	       mmu_psize_defs[mmu_linear_psize].shift,
 	       mmu_psize_defs[mmu_virtual_psize].shift,
-	       mmu_psize_defs[mmu_io_psize].shift);
+	       mmu_psize_defs[mmu_io_psize].shift
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	       ,mmu_psize_defs[mmu_vmemmap_psize].shift
+#endif
+	       );
 
 #ifdef CONFIG_HUGETLB_PAGE
 	/* Init large page size. Currently, we pick 16M or 1M depending
Index: linux-work/arch/powerpc/mm/init_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_64.c	2008-04-30 15:00:54.000000000 +1000
+++ linux-work/arch/powerpc/mm/init_64.c	2008-04-30 15:05:02.000000000 +1000
@@ -19,6 +19,8 @@
  *
  */
 
+#undef DEBUG
+
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -208,12 +210,12 @@ int __meminit vmemmap_populated(unsigned
 }
 
 int __meminit vmemmap_populate(struct page *start_page,
-					unsigned long nr_pages, int node)
+			       unsigned long nr_pages, int node)
 {
 	unsigned long mode_rw;
 	unsigned long start = (unsigned long)start_page;
 	unsigned long end = (unsigned long)(start_page + nr_pages);
-	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
+	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 
 	mode_rw = _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX;
 
@@ -235,11 +237,11 @@ int __meminit vmemmap_populate(struct pa
 			start, p, __pa(p));
 
 		mapped = htab_bolt_mapping(start, start + page_size,
-					__pa(p), mode_rw, mmu_linear_psize,
+					__pa(p), mode_rw, mmu_vmemmap_psize,
 					mmu_kernel_ssize);
 		BUG_ON(mapped < 0);
 	}
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
Index: linux-work/arch/powerpc/mm/slb.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/slb.c	2008-04-30 15:00:54.000000000 +1000
+++ linux-work/arch/powerpc/mm/slb.c	2008-04-30 15:01:14.000000000 +1000
@@ -28,7 +28,7 @@
 #include <asm/udbg.h>
 
 #ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
+#define DBG(fmt...) printk(fmt)
 #else
 #define DBG(fmt...)
 #endif
@@ -263,13 +263,19 @@ void slb_initialize(void)
 	extern unsigned int *slb_miss_kernel_load_linear;
 	extern unsigned int *slb_miss_kernel_load_io;
 	extern unsigned int *slb_compare_rr_to_size;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	extern unsigned int *slb_miss_kernel_load_vmemmap;
+	unsigned long vmemmap_llp;
+#endif
 
 	/* Prepare our SLB miss handler based on our page size */
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
 	io_llp = mmu_psize_defs[mmu_io_psize].sllp;
 	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
 	get_paca()->vmalloc_sllp = SLB_VSID_KERNEL | vmalloc_llp;
-
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	vmemmap_llp = mmu_psize_defs[mmu_vmemmap_psize].sllp;
+#endif
 	if (!slb_encoding_inited) {
 		slb_encoding_inited = 1;
 		patch_slb_encoding(slb_miss_kernel_load_linear,
@@ -279,8 +285,14 @@ void slb_initialize(void)
 		patch_slb_encoding(slb_compare_rr_to_size,
 				   mmu_slb_size);
 
-		DBG("SLB: linear  LLP = %04x\n", linear_llp);
-		DBG("SLB: io      LLP = %04x\n", io_llp);
+		DBG("SLB: linear  LLP = %04lx\n", linear_llp);
+		DBG("SLB: io      LLP = %04lx\n", io_llp);
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+		patch_slb_encoding(slb_miss_kernel_load_vmemmap,
+				   SLB_VSID_KERNEL | vmemmap_llp);
+		DBG("SLB: vmemmap LLP = %04lx\n", vmemmap_llp);
+#endif
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED;
Index: linux-work/arch/powerpc/mm/slb_low.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/slb_low.S	2008-04-30 15:00:54.000000000 +1000
+++ linux-work/arch/powerpc/mm/slb_low.S	2008-04-30 15:01:00.000000000 +1000
@@ -47,8 +47,7 @@ _GLOBAL(slb_allocate_realmode)
 	 * it to VSID 0, which is reserved as a bad VSID - one which
 	 * will never have any pages in it.  */
 
-	/* Check if hitting the linear mapping of the vmalloc/ioremap
-	 * kernel space
+	/* Check if hitting the linear mapping or some other kernel space
 	*/
 	bne	cr7,1f
 
@@ -62,7 +61,18 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
 	b	slb_finish_load_1T
 
-1:	/* vmalloc/ioremap mapping encoding bits, the "li" instructions below
+1:
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	/* Check virtual memmap region. To be patches at kernel boot */
+	cmpldi	cr0,r9,0xf
+	bne	1f
+_GLOBAL(slb_miss_kernel_load_vmemmap)
+	li	r11,0
+	b	6f
+1:
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
+	/* vmalloc/ioremap mapping encoding bits, the "li" instructions below
 	 * will be patched by the kernel at boot
 	 */
 BEGIN_FTR_SECTION
Index: linux-work/include/asm-powerpc/mmu-hash64.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mmu-hash64.h	2008-04-30 15:00:54.000000000 +1000
+++ linux-work/include/asm-powerpc/mmu-hash64.h	2008-04-30 15:01:00.000000000 +1000
@@ -177,6 +177,7 @@ extern struct mmu_psize_def mmu_psize_de
 extern int mmu_linear_psize;
 extern int mmu_virtual_psize;
 extern int mmu_vmalloc_psize;
+extern int mmu_vmemmap_psize;
 extern int mmu_io_psize;
 extern int mmu_kernel_ssize;
 extern int mmu_highuser_ssize;
Index: linux-work/include/asm-powerpc/pgtable-ppc64.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pgtable-ppc64.h	2008-04-30 15:00:54.000000000 +1000
+++ linux-work/include/asm-powerpc/pgtable-ppc64.h	2008-04-30 15:01:00.000000000 +1000
@@ -65,15 +65,15 @@
 
 #define VMALLOC_REGION_ID	(REGION_ID(VMALLOC_START))
 #define KERNEL_REGION_ID	(REGION_ID(PAGE_OFFSET))
+#define VMEMMAP_REGION_ID	(0xfUL)
 #define USER_REGION_ID		(0UL)
 
 /*
- * Defines the address of the vmemap area, in the top 16th of the
- * kernel region.
+ * Defines the address of the vmemap area, in its own region
  */
-#define VMEMMAP_BASE (ASM_CONST(CONFIG_KERNEL_START) + \
-					(0xfUL << (REGION_SHIFT - 4)))
-#define vmemmap ((struct page *)VMEMMAP_BASE)
+#define VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
+#define vmemmap			((struct page *)VMEMMAP_BASE)
+
 
 /*
  * Common bits in a linux-style PTE.  These match the bits in the
