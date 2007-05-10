Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 3/7] Abolish iopa(), mm_ptov(),
	io_block_mapping() from arch/powerpc
In-Reply-To: <20070510060449.GA3118@localhost.localdomain>
Message-Id: <20070510060556.9274DDDEB9@ozlabs.org>
Date: Thu, 10 May 2007 16:05:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These old-fashioned IO mapping functions no longer have any callers in
code which remains relevant on arch/powerpc.  Therefore, this patch
removes them from arch/powerpc.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/mm/pgtable_32.c        |  118 ------------------------------------
 include/asm-powerpc/io.h            |    7 --
 include/asm-powerpc/pgtable-ppc32.h |    2 
 3 files changed, 127 deletions(-)

Index: working-2.6/arch/powerpc/mm/pgtable_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable_32.c	2007-05-10 13:48:49.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable_32.c	2007-05-10 13:52:29.000000000 +1000
@@ -303,48 +303,6 @@ void __init mapin_ram(void)
 /* is x a power of 4? */
 #define is_power_of_4(x)	is_power_of_2(x) && (ffs(x) & 1)
 
-/*
- * Set up a mapping for a block of I/O.
- * virt, phys, size must all be page-aligned.
- * This should only be called before ioremap is called.
- */
-void __init io_block_mapping(unsigned long virt, phys_addr_t phys,
-			     unsigned int size, int flags)
-{
-	int i;
-
-	if (virt > KERNELBASE && virt < ioremap_bot)
-		ioremap_bot = ioremap_base = virt;
-
-#ifdef HAVE_BATS
-	/*
-	 * Use a BAT for this if possible...
-	 */
-	if (io_bat_index < 2 && is_power_of_2(size)
-	    && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
-		setbat(io_bat_index, virt, phys, size, flags);
-		++io_bat_index;
-		return;
-	}
-#endif /* HAVE_BATS */
-
-#ifdef HAVE_TLBCAM
-	/*
-	 * Use a CAM for this if possible...
-	 */
-	if (tlbcam_index < num_tlbcam_entries && is_power_of_4(size)
-	    && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
-		settlbcam(tlbcam_index, virt, phys, size, flags, 0);
-		++tlbcam_index;
-		return;
-	}
-#endif /* HAVE_TLBCAM */
-
-	/* No BATs available, put it in the page tables. */
-	for (i = 0; i < size; i += PAGE_SIZE)
-		map_page(virt + i, phys + i, flags);
-}
-
 /* Scan the real Linux page tables and return a PTE pointer for
  * a virtual address in a context.
  * Returns true (1) if PTE was found, zero otherwise.  The pointer to
@@ -379,82 +337,6 @@ get_pteptr(struct mm_struct *mm, unsigne
         return(retval);
 }
 
-/* Find physical address for this virtual address.  Normally used by
- * I/O functions, but anyone can call it.
- */
-unsigned long iopa(unsigned long addr)
-{
-	unsigned long pa;
-
-	/* I don't know why this won't work on PMacs or CHRP.  It
-	 * appears there is some bug, or there is some implicit
-	 * mapping done not properly represented by BATs or in page
-	 * tables.......I am actively working on resolving this, but
-	 * can't hold up other stuff.  -- Dan
-	 */
-	pte_t *pte;
-	struct mm_struct *mm;
-
-	/* Check the BATs */
-	pa = v_mapped_by_bats(addr);
-	if (pa)
-		return pa;
-
-	/* Allow mapping of user addresses (within the thread)
-	 * for DMA if necessary.
-	 */
-	if (addr < TASK_SIZE)
-		mm = current->mm;
-	else
-		mm = &init_mm;
-
-	pa = 0;
-	if (get_pteptr(mm, addr, &pte, NULL)) {
-		pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);
-		pte_unmap(pte);
-	}
-
-	return(pa);
-}
-
-/* This is will find the virtual address for a physical one....
- * Swiped from APUS, could be dangerous :-).
- * This is only a placeholder until I really find a way to make this
- * work.  -- Dan
- */
-unsigned long
-mm_ptov (unsigned long paddr)
-{
-	unsigned long ret;
-#if 0
-	if (paddr < 16*1024*1024)
-		ret = ZTWO_VADDR(paddr);
-	else {
-		int i;
-
-		for (i = 0; i < kmap_chunk_count;){
-			unsigned long phys = kmap_chunks[i++];
-			unsigned long size = kmap_chunks[i++];
-			unsigned long virt = kmap_chunks[i++];
-			if (paddr >= phys
-			    && paddr < (phys + size)){
-				ret = virt + paddr - phys;
-				goto exit;
-			}
-		}
-	
-		ret = (unsigned long) __va(paddr);
-	}
-exit:
-#ifdef DEBUGPV
-	printk ("PTOV(%lx)=%lx\n", paddr, ret);
-#endif
-#else
-	ret = (unsigned long)paddr + KERNELBASE;
-#endif
-	return ret;
-}
-
 #ifdef CONFIG_DEBUG_PAGEALLOC
 
 static int __change_page_attr(struct page *page, pgprot_t prot)
Index: working-2.6/include/asm-powerpc/io.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/io.h	2007-05-10 13:49:20.000000000 +1000
+++ working-2.6/include/asm-powerpc/io.h	2007-05-10 13:52:41.000000000 +1000
@@ -636,13 +636,6 @@ extern int __iounmap_explicit(volatile v
 
 extern void __iomem * reserve_phb_iospace(unsigned long size);
 
-/* Those are more 32 bits only functions */
-extern unsigned long iopa(unsigned long addr);
-extern unsigned long mm_ptov(unsigned long addr) __attribute_const__;
-extern void io_block_mapping(unsigned long virt, phys_addr_t phys,
-			     unsigned int size, int flags);
-
-
 /*
  * When CONFIG_PPC_INDIRECT_IO is set, we use the generic iomap implementation
  * which needs some additional definitions here. They basically allow PIO
Index: working-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc32.h	2007-05-10 13:49:35.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc32.h	2007-05-10 13:52:49.000000000 +1000
@@ -756,8 +756,6 @@ extern void paging_init(void);
 extern void cache_clear(__u32 addr, int length);
 extern void cache_push(__u32 addr, int length);
 extern int mm_end_of_chunk (unsigned long addr, int len);
-extern unsigned long iopa(unsigned long addr);
-extern unsigned long mm_ptov(unsigned long addr) __attribute_const__;
 
 /* Values for nocacheflag and cmode */
 /* These are not used by the APUS kernel_map, but prevents
