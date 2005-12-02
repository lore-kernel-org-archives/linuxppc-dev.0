Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (unknown [198.161.247.241])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C42E668802
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 19:42:33 +1100 (EST)
Received: from jgg by quartz.orcorp.ca with local (Exim 4.50)
	id 1Ei5wl-0008WS-G1
	for linuxppc-embedded@ozlabs.org; Fri, 02 Dec 2005 01:07:11 -0700
Date: Fri, 2 Dec 2005 01:07:11 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051202080711.GA32759@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.15-rc4] ppc32: Fixes for non-zero PPC_MEMSTART on PPC440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a custom embedded system with a 440GP derived CPU that places the
memory starting at 0xc0000000 which requires a non-zero PPC_MEMSTART. There
are a couple of places that assume PPC_MEMSTART is 0. This results in
various tricky crashing during booting. Most of the problems are
not accounting for PPC_MEMSTART during va/pa translations. My fixes
convert these places to use pre-existing macros instead of duplicating
the calculation.

The two items in head_4xx.S are critical, but I can't see a good way
to link them in without an #ifdef, or maybe a CONFIG_* symbol. The
alternate version of the tlb index picker will work for any platform,
but is based on 'random' selection of the tlb index using the timebase
rather than linear increment. I don't know if this is better, but it
is an easy way to skip the problematic memory reference.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

---

 arch/ppc/kernel/head_4xx.S |    7 +++++++
 arch/ppc/mm/4xx_mmu.c      |    5 +++--
 arch/ppc/mm/pgtable.c      |    4 +++-
 include/asm-ppc/io.h       |    4 ++--
 include/asm-ppc/pgtable.h  |    4 ++--
 5 files changed, 17 insertions(+), 7 deletions(-)

applies-to: cec49fea2095ec77123684854ed519f01cf890da
1ffdbeb034cf2ad10105c28b4c9b7588084d8d9d
diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
index 10c261c..4d5ccaf 100644
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
@@ -771,10 +771,15 @@ tlb_4xx_index:
 finish_tlb_load:
 	/* load the next available TLB index.
 	*/
+#ifdef NON_ZERO_PPC_MEMSTART
+	mftb    r9
+	andi.	r9, r9, (PPC4XX_TLB_SIZE-1)
+#else
 	lwz	r9, tlb_4xx_index@l(0)
 	addi	r9, r9, 1
 	andi.	r9, r9, (PPC4XX_TLB_SIZE-1)
 	stw	r9, tlb_4xx_index@l(0)
+#endif
 
 6:
 	/*
@@ -872,6 +877,7 @@ start_here:
 	tlbia
 	isync			/* Flush shadow TLBs */
 
+#ifndef NON_ZERO_PPC_MEMSTART
 	/* set up the PTE pointers for the Abatron bdiGDB.
 	*/
 	lis	r6, swapper_pg_dir@h
@@ -881,6 +887,7 @@ start_here:
 	stw	r5, 0xf0(r0)	/* Must match your Abatron config file */
 	tophys(r5,r5)
 	stw	r6, 0(r5)
+#endif
 
 /* Now turn on the MMU for real! */
 	lis	r4,MSR_KERNEL@h
diff --git a/arch/ppc/mm/4xx_mmu.c b/arch/ppc/mm/4xx_mmu.c
index 4d006aa..253cf64 100644
--- a/arch/ppc/mm/4xx_mmu.c
+++ b/arch/ppc/mm/4xx_mmu.c
@@ -84,10 +84,11 @@ void __init MMU_init_hw(void)
         /*
 	 * Cache instruction and data space where the exception
 	 * vectors and the kernel live in real-mode.
+	 * 512MB starting at the base physical address of the kernel.
 	 */
 
-        mtspr(SPRN_DCCR, 0xF0000000);	/* 512 MB of data space at 0x0. */
-        mtspr(SPRN_ICCR, 0xF0000000);	/* 512 MB of instr. space at 0x0. */
+        mtspr(SPRN_DCCR, 0xF0000000 >> (PPC_MEMSTART/0x8000000));
+        mtspr(SPRN_ICCR, 0xF0000000 >> (PPC_MEMSTART/0x8000000));
 }
 
 #define LARGE_PAGE_SIZE_16M	(1<<24)
diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
index 6ea9185..29909ac 100644
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -190,7 +190,9 @@ __ioremap(phys_addr_t addr, unsigned lon
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 * mem_init() sets high_memory so only do the check after that.
 	 */
-	if ( mem_init_done && (p < virt_to_phys(high_memory)) )
+	if ( mem_init_done &&
+	     p < virt_to_phys(high_memory) &&
+	     p >= PPC_MEMSTART )
 	{
 		printk("__ioremap(): phys addr "PHYS_FMT" is RAM lr %p\n", p,
 		       __builtin_return_address(0));
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 84ac6e2..c43f2f9 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -422,7 +422,7 @@ extern inline void * bus_to_virt(unsigne
 extern inline unsigned long virt_to_phys(volatile void * address)
 {
 #ifndef CONFIG_APUS
-	return (unsigned long) address - KERNELBASE;
+	return __pa(address);
 #else
 	return iopa ((unsigned long) address);
 #endif
@@ -431,7 +431,7 @@ extern inline unsigned long virt_to_phys
 extern inline void * phys_to_virt(unsigned long address)
 {
 #ifndef CONFIG_APUS
-	return (void *) (address + KERNELBASE);
+	return __va(address);
 #else
 	return (void*) mm_ptov (address);
 #endif
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index 6d1c39e..488c6e9 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -724,12 +724,12 @@ extern pgprot_t phys_mem_access_prot(str
 #define pmd_page_kernel(pmd)	\
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (pmd_val(pmd) >> PAGE_SHIFT))
+        pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_kernel(pmd)	\
 	((unsigned long) (pmd_val(pmd) & PAGE_MASK))
 #define pmd_page(pmd)		\
-	(mem_map + (__pa(pmd_val(pmd)) >> PAGE_SHIFT))
+        (virt_to_page(pmd_val(pmd)))
 #endif
 
 /* to find an entry in a kernel page-table-directory */
---
0.99.9k
