Date: Wed, 31 Oct 2001 02:44:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: small cleanup
Message-ID: <Pine.LNX.4.33.0110310209390.30087-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Below is a patch from the APUS tree (more to follow :) ). It does some
small cleanups and one important change to get APUS working:
- introducing PPC_MEMSTART/PPC_MEMOFFSET, for non-APUS machines these are
constants otherwise variables. I added with this support for memory
starting != 0.
- ram_phys_base became ppc_memstart
- removed end_of_DRAM, it's equivalent to high_memory
- pcibios_make_OF_bus_map depends on CONFIG_ALL_PPC
- removed duplicate definition of isa_io_base/isa_mem_base/pci_dram_offset
(note: these variables are protected with CONFIG_PCI in ppc_ksyms.c, but
not in the include files, so there are unconditional now)
- removed nested __KERNEL__ ifdefs in io.h, one even outside of the
recursive protection (bad style).

The last two changes don't apply cleanly to 2_4_devel, but it needs a
similiar change.

bye, Roman


--- arch/ppc/kernel/apus_setup.c	2001/10/25 19:30:42	1.1.1.14
+++ arch/ppc/kernel/apus_setup.c	2001/10/29 23:09:38	1.26
@@ -991,6 +960,8 @@
 		memory[0].size = ((size+0x001fffff) & 0xffe00000);
 	}

+	ppc_memstart = memory[0].addr;
+	ppc_memoffset = PAGE_OFFSET - PPC_MEMSTART;
 	total = memory[0].size;

 	/* Remove the memory chunks that are controlled by special
@@ -1011,7 +982,6 @@
 	   the PowerUP board. Other system memory is horrible slow in
 	   comparison. The user can use other memory for swapping
 	   using the z2ram device. */
-	ram_phys_base = memory[0].addr;
 	return total;
 }

--- arch/ppc/kernel/pci.c	2001/08/21 00:40:02	1.1.1.19
+++ arch/ppc/kernel/pci.c	2001/08/21 17:43:48	1.14
@@ -715,12 +715,14 @@
 	}
 	pci_bus_count = next_busno;

+#ifdef CONFIG_ALL_PPC
 	/* OpenFirmware based machines need a map of OF bus
 	 * numbers vs. kernel bus numbers since we may have to
 	 * remap them.
 	 */
 	if (pci_assign_all_busses && have_of)
 		pcibios_make_OF_bus_map();
+#endif /* CONFIG_ALL_PPC */

 	/* Call machine dependant fixup */
 	if (ppc_md.pcibios_fixup)
--- arch/ppc/mm/init.c	2001/10/16 15:54:16	1.1.1.19
+++ arch/ppc/mm/init.c	2001/10/29 23:09:38	1.23
@@ -53,10 +53,12 @@

 mmu_gather_t mmu_gathers[NR_CPUS];

-void *end_of_DRAM;
 unsigned long total_memory;
 unsigned long total_lowmem;

+unsigned long ppc_memstart;
+unsigned long ppc_memoffset = PAGE_OFFSET;
+
 int mem_init_done;
 int init_bootmem_done;
 int boot_mapsize;
@@ -319,7 +321,6 @@
 		total_memory = total_lowmem;
 #endif /* CONFIG_HIGHMEM */
 	}
-	end_of_DRAM = __va(total_lowmem);
 	set_phys_avail(total_lowmem);

 	/* Initialize the MMU hardware */
@@ -401,8 +402,12 @@
 	}
 	start = PAGE_ALIGN(start);

-	boot_mapsize = init_bootmem(start >> PAGE_SHIFT,
-				    total_lowmem >> PAGE_SHIFT);
+	high_memory = __va(PPC_MEMSTART + total_lowmem);
+	min_low_pfn = start >> PAGE_SHIFT;
+	max_low_pfn = (PPC_MEMSTART + total_lowmem) >> PAGE_SHIFT;
+	boot_mapsize = init_bootmem_node(&contig_page_data, min_low_pfn,
+					 PPC_MEMSTART >> PAGE_SHIFT,
+					 max_low_pfn);

 	/* remove the bootmem bitmap from the available memory */
 	mem_pieces_remove(&phys_avail, start, boot_mapsize, 1);
@@ -457,10 +462,9 @@
 	highmem_start_page = mem_map + highmem_mapnr;
 	max_mapnr = total_memory >> PAGE_SHIFT;
 #else
-	max_mapnr = max_low_pfn;
+	max_mapnr = total_lowmem >> PAGE_SHIFT;
 #endif /* CONFIG_HIGHMEM */

-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	num_physpages = max_mapnr;	/* RAM is assumed contiguous */

 	totalram_pages += free_all_bootmem();
@@ -488,7 +492,7 @@
 		     addr += PAGE_SIZE)
 			SetPageReserved(virt_to_page(addr));

-	for (addr = PAGE_OFFSET; addr < (unsigned long)end_of_DRAM;
+	for (addr = PAGE_OFFSET; addr < (unsigned long)high_memory;
 	     addr += PAGE_SIZE) {
 		if (!PageReserved(virt_to_page(addr)))
 			continue;
@@ -543,7 +547,7 @@
 	 * physical memory.
 	 */

-	phys_avail.regions[0].address = 0;
+	phys_avail.regions[0].address = PPC_MEMSTART;
 	phys_avail.regions[0].size = total_memory;
 	phys_avail.n_regions = 1;

--- arch/ppc/mm/mmu_decl.h	2001/10/25 19:31:14	1.1.1.2
+++ arch/ppc/mm/mmu_decl.h	2001/10/29 23:09:38	1.2
@@ -31,14 +31,12 @@
 extern void reserve_phys_mem(unsigned long start, unsigned long size);

 extern int __map_without_bats;
-extern void *end_of_DRAM;
 extern unsigned long ioremap_base;
 extern unsigned long ioremap_bot;
 extern unsigned int rtas_data, rtas_size;

 extern unsigned long total_memory;
 extern unsigned long total_lowmem;
-extern unsigned long ram_phys_base;
 extern int mem_init_done;

 extern PTE *Hash, *Hash_end;
--- arch/ppc/mm/pgtable.c	2001/10/16 15:54:18	1.1.1.2
+++ arch/ppc/mm/pgtable.c	2001/10/29 23:09:38	1.4
@@ -35,8 +35,6 @@

 #include "mmu_decl.h"

-unsigned long ram_phys_base;
-
 unsigned long ioremap_base;
 unsigned long ioremap_bot;
 int io_bat_index;
@@ -199,7 +215,7 @@
 #endif /* HAVE_BATS */

 	v = KERNELBASE;
-	p = ram_phys_base;
+	p = PPC_MEMSTART;
 	for (s = 0; s < total_lowmem; s += PAGE_SIZE) {
 		/* On the MPC8xx, we want the page shared so we
 		 * don't get ASID compares on kernel space.
--- arch/ppc/mm/ppc_mmu.c	2001/08/21 00:39:44	1.1.1.1
+++ arch/ppc/mm/ppc_mmu.c	2001/10/29 23:09:38	1.2
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
--- include/asm-ppc/io.h	2001/10/25 19:46:42	1.1.1.13
+++ include/asm-ppc/io.h	2001/10/25 22:02:40	1.12
@@ -1,12 +1,12 @@
 /*
  * BK Id: SCCS/s.io.h 1.14 10/16/01 15:58:42 trini
  */
-#ifdef __KERNEL__
 #ifndef _PPC_IO_H
 #define _PPC_IO_H

+#ifdef __KERNEL__
+
 #include <linux/config.h>
-#include <linux/types.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>

@@ -31,18 +31,19 @@
 #elif defined(CONFIG_8260)
 #include <asm/mpc8260.h>
 #elif defined(CONFIG_APUS)
-#define _IO_BASE 0
-#define _ISA_MEM_BASE 0
+#define _IO_BASE	0
+#define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET 0
 #else /* Everyone else */
-extern unsigned long isa_io_base;
-extern unsigned long isa_mem_base;
-extern unsigned long pci_dram_offset;
 #define _IO_BASE	isa_io_base
 #define _ISA_MEM_BASE	isa_mem_base
 #define PCI_DRAM_OFFSET	pci_dram_offset
 #endif /* Platform-dependant I/O */

+extern unsigned long isa_io_base;
+extern unsigned long isa_mem_base;
+extern unsigned long pci_dram_offset;
+
 #define readb(addr) in_8((volatile u8 *)(addr))
 #define writeb(b,addr) out_8((volatile u8 *)(addr), (b))
 #if defined(CONFIG_APUS)
@@ -181,7 +182,6 @@
 #define memcpy_fromio(a,b,c)   memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))

-#ifdef __KERNEL__
 /*
  * Map in an area of physical address space, for accessing
  * I/O devices etc.
@@ -250,11 +257,9 @@
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	(((page - mem_map) << PAGE_SHIFT) + PPC_MEMSTART)
 #define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)

-#endif /* __KERNEL__ */
-
 /*
  * Enforce In-order Execution of I/O:
  * Acts as a barrier to ensure all previous I/O accesses have
@@ -373,5 +378,5 @@
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)

-#endif
 #endif /* __KERNEL__ */
+#endif
--- include/asm-ppc/mpc8xx.h	2001/10/25 19:46:38	1.1.1.9
+++ include/asm-ppc/mpc8xx.h	2001/10/25 22:02:40	1.5
@@ -74,10 +74,6 @@
 #endif

 #ifndef __ASSEMBLY__
-extern unsigned long isa_io_base;
-extern unsigned long isa_mem_base;
-extern unsigned long pci_dram_offset;
-
 /* The "residual" data board information structure the boot loader
  * hands to us.
  */
--- include/asm-ppc/ppc4xx.h	2001/06/09 18:19:23	1.1.1.3
+++ include/asm-ppc/ppc4xx.h	2001/06/10 00:17:28	1.3
@@ -37,8 +37,6 @@
 #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET	0

-extern unsigned long isa_io_base;
-
 /*
  * The "residual" board information structure the boot loader passes
  * into the kernel.
--- include/asm-ppc/page.h	2001/10/16 18:59:52	1.1.1.9
+++ include/asm-ppc/page.h	2001/10/29 23:09:38	1.6
@@ -86,6 +86,17 @@
 #define clear_user_page(page, vaddr)	clear_page(page)
 #define copy_user_page(to, from, vaddr)	copy_page(to, from)

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
@@ -113,6 +124,11 @@

 	return (void*) v;
 }
+#else
+#define ___pa(vaddr) ((vaddr)-PPC_MEMOFFSET)
+#define ___va(paddr) ((paddr)+PPC_MEMOFFSET)
+#endif
+
 #define __pa(x) ___pa ((unsigned long)(x))
 #define __va(x) ___va ((unsigned long)(x))

--- include/asm-ppc/pgtable.h	2001/10/16 18:59:48	1.1.1.11
+++ include/asm-ppc/pgtable.h	2001/10/29 23:09:38	1.12
@@ -345,7 +345,7 @@
  * Permanent address of a page.
  */
 #define page_address(page)	((page)->virtual)
-#define pte_page(x)		(mem_map+(unsigned long)((pte_val(x) >> PAGE_SHIFT)))
+#define pte_page(x)		(mem_map+(unsigned long)((pte_val(x)-PPC_MEMSTART) >> PAGE_SHIFT))

 #ifndef __ASSEMBLY__
 /*
@@ -411,7 +411,7 @@
 #define mk_pte(page,pgprot) \
 ({									\
 	pte_t pte;							\
-	pte_val(pte) = ((page - mem_map) << PAGE_SHIFT) | pgprot_val(pgprot); \
+	pte_val(pte) = (((page - mem_map) << PAGE_SHIFT) + PPC_MEMSTART) | pgprot_val(pgprot); \
 	pte;							\
 })


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
