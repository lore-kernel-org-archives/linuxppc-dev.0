Date: Thu, 1 Nov 2001 23:22:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	<linuxppc-commit@source.mvista.com>
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
In-Reply-To: <20011101115619.A25864@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0111012309400.8554-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 1 Nov 2001, Tom Rini wrote:

> Arg, not my day.  Can you split up the rest of the changes into seperate
> patches (01, 02, 0n) and make it vs the _devel tree?  It'll help stop me
> from doing things like that. :)

Hmm, there isn't much left to split.
BTW the second patch depends on the first and only the last patch doesn't
apply to the stable tree.

---------- introduce PPC_MEMSTART/PPC_MEMOFFSET, rename ram_phys_base to ppc_memstart

--- include/asm-ppc/page.h	Thu Nov  1 21:54:39 2001
+++ include/asm-ppc/page.h	Thu Nov  1 22:09:58 2001
@@ -89,6 +89,17 @@
 extern void clear_user_page(struct page *page, unsigned long vaddr);
 extern void copy_user_page(struct page *to, struct page *from, unsigned long vaddr);

+extern unsigned long ppc_memstart;
+extern unsigned long ppc_memoffset;
+#ifndef CONFIG_APUS
+#define PPC_MEMSTART	0
+#define PPC_MEMOFFSET	PAGE_OFFSET
+#else
+#define PPC_MEMSTART	ppc_memstart
+#define PPC_MEMOFFSET	ppc_memoffset
+#endif
+
+#if defined(CONFIG_APUS) && !defined(MODULE)
 /* map phys->virtual and virtual->phys for RAM pages */
 static inline unsigned long ___pa(unsigned long v)
 {
@@ -116,6 +127,11 @@

 	return (void*) v;
 }
+#else
+#define ___pa(vaddr) ((vaddr)-PPC_MEMOFFSET)
+#define ___va(paddr) ((paddr)+PPC_MEMOFFSET)
+#endif
+
 #define __pa(x) ___pa ((unsigned long)(x))
 #define __va(x) ___va ((unsigned long)(x))

--- include/asm-ppc/io.h	Thu Nov  1 22:32:53 2001
+++ include/asm-ppc/io.h	Thu Nov  1 22:36:43 2001
@@ -295,7 +295,7 @@
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	(((page - mem_map) << PAGE_SHIFT) + PPC_MEMSTART)
 #define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)

 /*
--- include/asm-ppc/pgtable.h	Thu Nov  1 21:53:59 2001
+++ include/asm-ppc/pgtable.h	Thu Nov  1 22:09:58 2001
@@ -393,7 +393,7 @@
  * Permanent address of a page.
  */
 #define page_address(page)	((page)->virtual)
-#define pte_page(x)		(mem_map+(unsigned long)((pte_val(x) >> PAGE_SHIFT)))
+#define pte_page(x)		(mem_map+(unsigned long)((pte_val(x)-PPC_MEMSTART) >> PAGE_SHIFT))

 #ifndef __ASSEMBLY__
 /*
@@ -459,7 +459,7 @@
 #define mk_pte(page,pgprot) \
 ({									\
 	pte_t pte;							\
-	pte_val(pte) = ((page - mem_map) << PAGE_SHIFT) | pgprot_val(pgprot); \
+	pte_val(pte) = (((page - mem_map) << PAGE_SHIFT) + PPC_MEMSTART) | pgprot_val(pgprot); \
 	pte;							\
 })

--- arch/ppc/kernel/apus_setup.c	Thu Nov  1 21:54:36 2001
+++ arch/ppc/kernel/apus_setup.c	Thu Nov  1 22:09:42 2001
@@ -991,6 +991,8 @@
 		memory[0].size = ((size+0x001fffff) & 0xffe00000);
 	}

+	ppc_memstart = memory[0].addr;
+	ppc_memoffset = PAGE_OFFSET - PPC_MEMSTART;
 	total = memory[0].size;

 	/* Remove the memory chunks that are controlled by special
@@ -1011,7 +1013,6 @@
 	   the PowerUP board. Other system memory is horrible slow in
 	   comparison. The user can use other memory for swapping
 	   using the z2ram device. */
-	ram_phys_base = memory[0].addr;
 	return total;
 }

--- arch/ppc/mm/init.c	Thu Nov  1 21:54:06 2001
+++ arch/ppc/mm/init.c	Thu Nov  1 22:59:45 2001
@@ -62,6 +62,9 @@
 unsigned long total_memory;
 unsigned long total_lowmem;

+unsigned long ppc_memstart;
+unsigned long ppc_memoffset = PAGE_OFFSET;
+
 int mem_init_done;
 int init_bootmem_done;
 int boot_mapsize;
@@ -406,8 +409,11 @@
 	}
 	start = PAGE_ALIGN(start);

-	boot_mapsize = init_bootmem(start >> PAGE_SHIFT,
-				    total_lowmem >> PAGE_SHIFT);
+	min_low_pfn = start >> PAGE_SHIFT;
+	max_low_pfn = (PPC_MEMSTART + total_lowmem) >> PAGE_SHIFT;
+	boot_mapsize = init_bootmem_node(&contig_page_data, min_low_pfn,
+					 PPC_MEMSTART >> PAGE_SHIFT,
+					 max_low_pfn);

 	/* remove the bootmem bitmap from the available memory */
 	mem_pieces_remove(&phys_avail, start, boot_mapsize, 1);
@@ -460,12 +466,10 @@

 	highmem_mapnr = total_lowmem >> PAGE_SHIFT;
 	highmem_start_page = mem_map + highmem_mapnr;
-	max_mapnr = total_memory >> PAGE_SHIFT;
-#else
-	max_mapnr = max_low_pfn;
 #endif /* CONFIG_HIGHMEM */
+	max_mapnr = total_memory >> PAGE_SHIFT;

-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
+	high_memory = __va(PPC_MEMSTART + total_lowmem);
 	num_physpages = max_mapnr;	/* RAM is assumed contiguous */

 	totalram_pages += free_all_bootmem();
@@ -553,7 +557,7 @@
 	 * physical memory.
 	 */

-	phys_avail.regions[0].address = 0;
+	phys_avail.regions[0].address = PPC_MEMSTART;
 	phys_avail.regions[0].size = total_memory;
 	phys_avail.n_regions = 1;

--- arch/ppc/mm/mmu_decl.h	Thu Nov  1 21:53:48 2001
+++ arch/ppc/mm/mmu_decl.h	Thu Nov  1 22:47:46 2001
@@ -38,7 +38,6 @@

 extern unsigned long total_memory;
 extern unsigned long total_lowmem;
-extern unsigned long ram_phys_base;
 extern int mem_init_done;

 extern PTE *Hash, *Hash_end;
--- arch/ppc/mm/pgtable.c	Thu Nov  1 21:57:11 2001
+++ arch/ppc/mm/pgtable.c	Thu Nov  1 22:09:42 2001
@@ -35,8 +35,6 @@

 #include "mmu_decl.h"

-unsigned long ram_phys_base;
-
 unsigned long ioremap_base;
 unsigned long ioremap_bot;
 int io_bat_index;
@@ -199,7 +197,7 @@
 #endif /* HAVE_BATS */

 	v = KERNELBASE;
-	p = ram_phys_base;
+	p = PPC_MEMSTART;
 	for (s = 0; s < total_lowmem; s += PAGE_SIZE) {
 		/* On the MPC8xx, we want the page shared so we
 		 * don't get ASID compares on kernel space.
--- arch/ppc/mm/ppc_mmu.c	Thu Nov  1 21:55:56 2001
+++ arch/ppc/mm/ppc_mmu.c	Thu Nov  1 22:09:42 2001
@@ -96,8 +96,8 @@

 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */
-	/* alignment of ram_phys_base */
-	align = ~(ram_phys_base-1) & ram_phys_base;
+	/* alignment of PPC_MEMSTART */
+	align = ~(PPC_MEMSTART-1) & PPC_MEMSTART;
 	/* set BAT block size to MIN(max_size, align) */
 	if (align && align < max_size)
 		max_size = align;
@@ -108,7 +108,7 @@
 			break;
 	}

-	setbat(2, KERNELBASE, ram_phys_base, bl, _PAGE_KERNEL);
+	setbat(2, KERNELBASE, PPC_MEMSTART, bl, _PAGE_KERNEL);
 	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
 	if ((done < tot) && !bat_addrs[3].limit) {
 		/* use BAT3 to cover a bit more */
@@ -116,7 +116,7 @@
 		for (bl = 128<<10; bl < max_size; bl <<= 1)
 			if (bl * 2 > tot)
 				break;
-		setbat(3, KERNELBASE+done, ram_phys_base+done, bl,
+		setbat(3, KERNELBASE+done, PPC_MEMSTART+done, bl,
 		       _PAGE_KERNEL);
 	}
 }


---------- replace end_of_DRAM with high_memory

--- arch/ppc/mm/init.c	Thu Nov  1 22:59:45 2001
+++ arch/ppc/mm/init.c	Thu Nov  1 22:59:02 2001
@@ -58,7 +58,6 @@

 mmu_gather_t mmu_gathers[NR_CPUS];

-void *end_of_DRAM;
 unsigned long total_memory;
 unsigned long total_lowmem;

@@ -327,7 +326,6 @@
 		total_memory = total_lowmem;
 #endif /* CONFIG_HIGHMEM */
 	}
-	end_of_DRAM = __va(total_lowmem);
 	set_phys_avail(total_lowmem);

 	/* Initialize the MMU hardware */
@@ -497,7 +495,7 @@
 		     addr += PAGE_SIZE)
 			SetPageReserved(virt_to_page(addr));

-	for (addr = PAGE_OFFSET; addr < (unsigned long)end_of_DRAM;
+	for (addr = PAGE_OFFSET; addr < (unsigned long)high_memory;
 	     addr += PAGE_SIZE) {
 		if (!PageReserved(virt_to_page(addr)))
 			continue;
--- arch/ppc/mm/mmu_decl.h	Thu Nov  1 22:47:46 2001
+++ arch/ppc/mm/mmu_decl.h	Thu Nov  1 22:09:42 2001
@@ -31,7 +31,6 @@
 extern void reserve_phys_mem(unsigned long start, unsigned long size);

 extern int __map_without_bats;
-extern void *end_of_DRAM;
 extern unsigned long ioremap_base;
 extern unsigned long ioremap_bot;
 extern unsigned int rtas_data, rtas_size;


---------- move ifdef __KERNEL__ inside include protection

--- include/asm-ppc/io.h	Thu Nov  1 22:36:43 2001
+++ include/asm-ppc/io.h	Thu Nov  1 22:13:42 2001
@@ -2,10 +2,11 @@
  * BK Id: SCCS/s.io.h 1.21 10/16/01 16:44:09 %#%
  */

-#ifdef __KERNEL__
 #ifndef _PPC_IO_H
 #define _PPC_IO_H

+#ifdef __KERNEL__
+
 #include <linux/config.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>
@@ -448,5 +449,5 @@
 #define consistent_sync_page(pg, off, sz, rw)	do { } while (0)

 #endif /* CONFIG_NOT_COHERENT_CACHE */
-#endif /* _PPC_IO_H */
 #endif /* __KERNEL__ */
+#endif /* _PPC_IO_H */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
