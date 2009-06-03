Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 03 Jun 2009 17:20:22 +1000
Subject: [RFC/PATCH] powerpc: Experimental 64-bit BookE support (v2)
Message-Id: <20090603072038.BAA8DDE251@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is still experiemental... among other things, don't
try to enable SPARSEMEM_VMEMMAP or HUGETLBFS...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

NOTE: Kumar, I haven't addressed most of your comments yet ! I will
      though... this is mostly a refresh and make-it-work-again on top
      of upstream + the previously posted patches (including the RFC
      patch I sent separately for adding an argument to __pte_free_tlb)

v2. - SMP works :-) Threads not yet
    - Various other misc fixes and copy/paste errors, the handling of
      the HW tablewalk should be correct now among others
    - Removed spurrious 32-bit Book3E stuff for now

 arch/powerpc/include/asm/exception-64e.h |  223 ++++++++
 arch/powerpc/include/asm/hw_irq.h        |    5 
 arch/powerpc/include/asm/mmu-book3e.h    |  152 +++++
 arch/powerpc/include/asm/mmu.h           |    1 
 arch/powerpc/include/asm/mmu_context.h   |    9 
 arch/powerpc/include/asm/paca.h          |   23 
 arch/powerpc/include/asm/page.h          |    4 
 arch/powerpc/include/asm/page_64.h       |   10 
 arch/powerpc/include/asm/pgalloc.h       |   21 
 arch/powerpc/include/asm/pgtable-ppc64.h |   61 +-
 arch/powerpc/include/asm/ppc-opcode.h    |    6 
 arch/powerpc/include/asm/ppc_asm.h       |    8 
 arch/powerpc/include/asm/pte-book3e.h    |   70 ++
 arch/powerpc/include/asm/pte-common.h    |    3 
 arch/powerpc/include/asm/reg.h           |   10 
 arch/powerpc/include/asm/reg_booke.h     |   35 +
 arch/powerpc/include/asm/tlbflush.h      |   11 
 arch/powerpc/kernel/Makefile             |   10 
 arch/powerpc/kernel/asm-offsets.c        |   19 
 arch/powerpc/kernel/cputable.c           |   27 -
 arch/powerpc/kernel/entry_64.S           |  102 ++-
 arch/powerpc/kernel/exceptions-64e.S     |  794 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_64.S            |   45 +
 arch/powerpc/kernel/paca.c               |    3 
 arch/powerpc/kernel/process.c            |    2 
 arch/powerpc/kernel/setup_64.c           |   27 +
 arch/powerpc/mm/Makefile                 |    1 
 arch/powerpc/mm/init_64.c                |    2 
 arch/powerpc/mm/mmu_context_hash64.c     |    5 
 arch/powerpc/mm/mmu_decl.h               |   26 -
 arch/powerpc/mm/pgtable_64.c             |   60 ++
 arch/powerpc/mm/tlb_book3e.c             |  165 ++++++
 arch/powerpc/mm/tlb_hash64.c             |    5 
 arch/powerpc/mm/tlb_low_64e.S            |  733 ++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb_nohash.c             |   69 ++
 arch/powerpc/mm/tlb_nohash_low.S         |   79 +++
 arch/powerpc/platforms/Kconfig.cputype   |   45 +
 arch/powerpc/xmon/xmon.c                 |    2 
 38 files changed, 2748 insertions(+), 125 deletions(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pte-book3e.h	2009-06-03 15:13:29.000000000 +1000
@@ -0,0 +1,70 @@
+#ifndef _ASM_POWERPC_PTE_BOOK3E_H
+#define _ASM_POWERPC_PTE_BOOK3E_H
+#ifdef __KERNEL__
+
+/* PTE bit definitions for processors compliant to the Book3E
+ * architecture 2.06 or later. The position of the PTE bits
+ * matches the HW definition of the optional Embedded Page Table
+ * category.
+ */
+
+/* Architected bits */
+#define _PAGE_PRESENT	0x000001 /* software: pte contains a translation */
+#define _PAGE_FILE	0x000002 /* (!present only) software: pte holds file offset */
+#define _PAGE_SW1	0x000002
+#define _PAGE_BAP_SR	0x000004
+#define _PAGE_BAP_UR	0x000008
+#define _PAGE_BAP_SW	0x000010
+#define _PAGE_BAP_UW	0x000020
+#define _PAGE_BAP_SX	0x000040
+#define _PAGE_BAP_UX	0x000080
+#define _PAGE_PSIZE_MSK	0x000f00
+#define _PAGE_PSIZE_4K	0x000200
+#define _PAGE_PSIZE_64K	0x000600
+#define _PAGE_PSIZE_1M	0x000a00
+#define _PAGE_PSIZE_16M	0x000e00
+#define _PAGE_DIRTY	0x001000 /* C: page changed */
+#define _PAGE_SW0	0x002000
+#define _PAGE_U3	0x004000
+#define _PAGE_U2	0x008000
+#define _PAGE_U1	0x010000
+#define _PAGE_U0	0x020000
+#define _PAGE_ACCESSED	0x040000
+#define _PAGE_LENDIAN	0x080000
+#define _PAGE_GUARDED	0x100000
+#define _PAGE_COHERENT	0x200000 /* M: enforce memory coherence */
+#define _PAGE_NO_CACHE	0x400000 /* I: cache inhibit */
+#define _PAGE_WRITETHRU	0x800000 /* W: cache write-through */
+
+/* "Higher level" linux bit combinations */
+#define _PAGE_EXEC	_PAGE_BAP_SX /* Can be executed from potentially */
+#define _PAGE_HWEXEC	_PAGE_BAP_UX /* .. and was cache cleaned */
+#define _PAGE_RW	(_PAGE_BAP_SW | _PAGE_BAP_UW) /* User write permission */
+#define _PAGE_KERNEL_RW	(_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY)
+#define _PAGE_KERNEL_RO	(_PAGE_BAP_SR)
+#define _PAGE_USER	(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
+
+#define _PAGE_HASHPTE	0
+#define _PAGE_BUSY	0
+
+#define _PAGE_SPECIAL	_PAGE_SW0
+
+/* Flags to be preserved on PTE modifications */
+#define _PAGE_HPTEFLAGS	_PAGE_BUSY
+
+/* Base page size */
+#ifdef CONFIG_PPC_64K_PAGES
+#define _PAGE_PSIZE	_PAGE_PSIZE_64K
+#define PTE_RPN_SHIFT	(28)
+#else
+#define _PAGE_PSIZE	_PAGE_PSIZE_4K
+#define	PTE_RPN_SHIFT	(24)
+#endif
+
+/* On 32-bit, we never clear the top part of the PTE */
+#ifdef CONFIG_PPC32
+#define _PTE_NONE_MASK	0xffffffff00000000ULL
+#endif
+
+#endif /* __KERNEL__ */
+#endif /*  _ASM_POWERPC_PTE_FSL_BOOKE_H */
Index: linux-work/arch/powerpc/include/asm/pgtable-ppc64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-06-03 15:13:29.000000000 +1000
@@ -5,11 +5,6 @@
  * the ppc64 hashed page table.
  */
 
-#ifndef __ASSEMBLY__
-#include <linux/stddef.h>
-#include <asm/tlbflush.h>
-#endif /* __ASSEMBLY__ */
-
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/pgtable-ppc64-64k.h>
 #else
@@ -38,26 +33,46 @@
 #endif
 
 /*
- * Define the address range of the vmalloc VM area.
+ * Define the address range of the kernel non-linear virtual area
+ */
+
+#ifdef CONFIG_PPC_BOOK3E
+#define KERN_VIRT_START ASM_CONST(0x8000000000000000)
+#else
+#define KERN_VIRT_START ASM_CONST(0xD000000000000000)
+#endif
+#define KERN_VIRT_SIZE	PGTABLE_RANGE
+
+/*
+ * The vmalloc space starts at the beginning of that region, and
+ * occupies half of it on hash CPUs and a quarter of it on Book3E
  */
-#define VMALLOC_START ASM_CONST(0xD000000000000000)
-#define VMALLOC_SIZE  (PGTABLE_RANGE >> 1)
-#define VMALLOC_END   (VMALLOC_START + VMALLOC_SIZE)
+#define VMALLOC_START	KERN_VIRT_START
+#ifdef CONFIG_PPC_BOOK3E
+#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 2)
+#else
+#define VMALLOC_SIZE	(KERN_VIRT_SIZE >> 1)
+#endif
+#define VMALLOC_END	(VMALLOC_START + VMALLOC_SIZE)
 
 /*
- * Define the address ranges for MMIO and IO space :
+ * The second half of the kernel virtual space is used for IO mappings,
+ * it's itself carved into the PIO region (ISA and PHB IO space) and
+ * the ioremap space
  *
- *  ISA_IO_BASE = VMALLOC_END, 64K reserved area
+ *  ISA_IO_BASE = KERN_IO_START, 64K reserved area
  *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
  * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
  */
+#define KERN_IO_START	(KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))
 #define FULL_IO_SIZE	0x80000000ul
-#define  ISA_IO_BASE	(VMALLOC_END)
-#define  ISA_IO_END	(VMALLOC_END + 0x10000ul)
+#define  ISA_IO_BASE	(KERN_IO_START)
+#define  ISA_IO_END	(KERN_IO_START + 0x10000ul)
 #define  PHB_IO_BASE	(ISA_IO_END)
-#define  PHB_IO_END	(VMALLOC_END + FULL_IO_SIZE)
+#define  PHB_IO_END	(KERN_IO_START + FULL_IO_SIZE)
 #define IOREMAP_BASE	(PHB_IO_END)
-#define IOREMAP_END	(VMALLOC_START + PGTABLE_RANGE)
+#define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
+
 
 /*
  * Region IDs
@@ -72,19 +87,28 @@
 #define USER_REGION_ID		(0UL)
 
 /*
- * Defines the address of the vmemap area, in its own region
+ * Defines the address of the vmemap area, in its own region on
+ * hash table CPUs and after the vmalloc space on Book3E
  */
+#ifdef CONFIG_PPC_BOOK3E
+#define VMEMMAP_BASE		VMALLOC_END
+#define VMEMMAP_END		KERN_IO_START
+#else
 #define VMEMMAP_BASE		(VMEMMAP_REGION_ID << REGION_SHIFT)
+#endif
 #define vmemmap			((struct page *)VMEMMAP_BASE)
 
 
 /*
  * Include the PTE bits definitions
  */
+#ifdef CONFIG_PPC_BOOK3S
 #include <asm/pte-hash64.h>
+#else
+#include <asm/pte-book3e.h>
+#endif
 #include <asm/pte-common.h>
 
-
 #ifdef CONFIG_PPC_MM_SLICES
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
@@ -92,6 +116,9 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/stddef.h>
+#include <asm/tlbflush.h>
+
 /*
  * This is the default implementation of various PTE accessors, it's
  * used in all cases except Book3S with 64K pages where we have a
Index: linux-work/arch/powerpc/include/asm/pte-common.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pte-common.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pte-common.h	2009-06-03 15:13:29.000000000 +1000
@@ -34,6 +34,9 @@
 #ifndef _PAGE_4K_PFN
 #define _PAGE_4K_PFN		0
 #endif
+#ifndef _PAGE_SAO
+#define _PAGE_SAO	0
+#endif
 #ifndef _PAGE_PSIZE
 #define _PAGE_PSIZE		0
 #endif
Index: linux-work/arch/powerpc/include/asm/mmu-book3e.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu-book3e.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-book3e.h	2009-06-03 15:13:29.000000000 +1000
@@ -38,6 +38,10 @@
 #define BOOK3E_PAGESZ_1TB	30
 #define BOOK3E_PAGESZ_2TB	31
 
+/*
+ * Old MAS bit definitions
+ */
+
 #define MAS0_TLBSEL(x)	((x << 28) & 0x30000000)
 #define MAS0_ESEL(x)	((x << 16) & 0x0FFF0000)
 #define MAS0_NV(x)	((x) & 0x00000FFF)
@@ -91,6 +95,127 @@
 
 #define MAS7_RPN	0xFFFFFFFF
 
+/*
+ * New MAS bit definitions
+ */
+
+#define SPRN_MAS0_HES		0x00004000
+#define SPRN_MAS0_WQ_ALLWAYS	0x00000000
+#define SPRN_MAS0_WQ_COND	0x00001000
+#define SPRN_MAS0_WQ_CLR_RSRV	0x00002000
+
+#define SPRN_MAS1_V		0x80000000
+#define SPRN_MAS1_IPROT		0x40000000
+#define SPRN_MAS1_TSIZE_MASK	0x00000f80
+#define SPRN_MAS1_TSIZE_SHIFT	7
+#define SPRN_MAS1_TS		0x00001000
+#define SPRN_MAS1_IND		0x00002000
+
+#define SPRN_MAS2_E		0x00000001
+#define SPRN_MAS2_G		0x00000002
+#define SPRN_MAS2_M		0x00000004
+#define SPRN_MAS2_I		0x00000008
+#define SPRN_MAS2_W		0x00000010
+
+#define SPRN_MAS3_SR		0x00000001
+#define SPRN_MAS3_UR		0x00000002
+#define SPRN_MAS3_SW		0x00000004
+#define SPRN_MAS3_UW		0x00000008
+#define SPRN_MAS3_SX		0x00000010
+#define SPRN_MAS3_UX		0x00000020
+#define SPRN_MAS3_SPSIZE	0x0000003e
+#define SPRN_MAS3_SPSIZE_SHIFT	1
+#define SPRN_MAS3_U3		0x00000040
+#define SPRN_MAS3_U2		0x00000080
+#define SPRN_MAS3_U1		0x00000100
+#define SPRN_MAS3_U0		0x00000200
+
+#define SPRN_MAS4_WIMGED_MASK	0x0000001f	/* Default WIMGE */
+#define SPRN_MAS4_WIMGED_SHIFT	0
+#define SPRN_MAS4_VLED		0x00000020	/* Default VLE */
+#define SPRN_MAS4_ACMD		0x000000c0	/* Default ACM */
+#define SPRN_MAS4_ACMD_SHIFT	6
+#define SPRN_MAS4_TSIZED_MASK	0x00000f80	/* Default TSIZE */
+#define SPRN_MAS4_TSIZED_SHIFT	7
+#define SPRN_MAS4_INDD		0x00008000	/* Default IND */
+
+#define SPRN_MAS6_SIND 		0x00000002	/* Indirect page */
+#define SPRN_MAS6_SIND_SHIFT	1
+#define SPRN_MAS6_SPID_MASK	0x3fff0000
+#define SPRN_MAS6_SPID_SHIFT	16
+#define SPRN_MAS6_ISIZE_MASK	0x00000f80
+#define SPRN_MAS6_ISIZE_SHIFT	7
+
+/* TLBnCFG encoding */
+#define SPRN_TLBnCFG_N_ENTRY	0x00000fff	/* number of entries */
+#define SPRN_TLBnCFG_HES	0x00002000	/* HW select supported */
+#define SPRN_TLBnCFG_IPROT	0x00008000	/* IPROT supported */
+#define SPRN_TLBnCFG_GTWE	0x00010000	/* Guest can write */
+#define SPRN_TLBnCFG_IND	0x00020000	/* IND entries supported */
+#define SPRN_TLBnCFG_PT		0x00040000	/* Can load from page table */
+#define SPRN_TLBnCFG_ASSOC	0xff000000	/* Associativity */
+
+/* TLBnPS encoding */
+#define SPRN_TLBnPS_4K		0x00000004
+#define SPRN_TLBnPS_8K		0x00000008
+#define SPRN_TLBnPS_16K		0x00000010
+#define SPRN_TLBnPS_32K		0x00000020
+#define SPRN_TLBnPS_64K		0x00000040
+#define SPRN_TLBnPS_128K	0x00000080
+#define SPRN_TLBnPS_256K	0x00000100
+#define SPRN_TLBnPS_512K	0x00000200
+#define SPRN_TLBnPS_1M 		0x00000400
+#define SPRN_TLBnPS_2M 		0x00000800
+#define SPRN_TLBnPS_4M 		0x00001000
+#define SPRN_TLBnPS_8M 		0x00002000
+#define SPRN_TLBnPS_16M		0x00004000
+#define SPRN_TLBnPS_32M		0x00008000
+#define SPRN_TLBnPS_64M		0x00010000
+#define SPRN_TLBnPS_128M	0x00020000
+#define SPRN_TLBnPS_256M	0x00040000
+#define SPRN_TLBnPS_512M	0x00080000
+#define SPRN_TLBnPS_1G		0x00100000
+#define SPRN_TLBnPS_2G		0x00200000
+#define SPRN_TLBnPS_4G		0x00400000
+#define SPRN_TLBnPS_8G		0x00800000
+#define SPRN_TLBnPS_16G		0x01000000
+#define SPRN_TLBnPS_32G		0x02000000
+#define SPRN_TLBnPS_64G		0x04000000
+#define SPRN_TLBnPS_128G	0x08000000
+#define SPRN_TLBnPS_256G	0x10000000
+
+/* tlbilx action encoding */
+#define TLBILX_T_ALL			0
+#define TLBILX_T_TID			1
+#define TLBILX_T_FULLMATCH		3
+#define TLBILX_T_CLASS0			4
+#define TLBILX_T_CLASS1			5
+#define TLBILX_T_CLASS2			6
+#define TLBILX_T_CLASS3			7
+
+/*
+ * The kernel use the constants below to index in the page sizes array.
+ * The use of fixed constants for this purpose is better for performances
+ * of the low level hash refill handlers.
+ *
+ * A non supported page size has a "shift" field set to 0
+ *
+ * Any new page size being implemented can get a new entry in here. Whether
+ * the kernel will use it or not is a different matter though. The actual page
+ * size used by hugetlbfs is not defined here and may be made variable
+ *
+ * Note: This is identical to the definition in mmu-hash64.h and possibly
+ * to be moved to a common file. This is also only used on 64-bit for now
+ */
+
+#define MMU_PAGE_4K		0
+#define MMU_PAGE_64K		1
+#define MMU_PAGE_1M		2
+#define MMU_PAGE_16M		3
+#define MMU_PAGE_256M		4
+#define MMU_PAGE_1G		5
+#define MMU_PAGE_COUNT		6
+
 #ifndef __ASSEMBLY__
 
 extern unsigned int tlbcam_index;
@@ -100,6 +225,33 @@ typedef struct {
 	unsigned int	active;
 	unsigned long	vdso_base;
 } mm_context_t;
+
+/* Page size definitions, common between 32 and 64-bit
+ *
+ *    shift : is the "PAGE_SHIFT" value for that page size
+ *    penc  : is the pte encoding mask
+ *
+ */
+struct mmu_psize_def
+{
+	unsigned int	shift;	/* number of bits */
+	unsigned int	enc;	/* PTE encoding */
+};
+extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+
+/* The page sizes use the same names as 64-bit hash but are
+ * constants
+ */
+#if defined(CONFIG_PPC_4K_PAGES)
+#define mmu_virtual_psize	MMU_PAGE_4K
+#elif defined(CONFIG_PPC_64K_PAGES)
+#define mmu_virtual_psize	MMU_PAGE_64K
+#else
+#error Unsupported page size
+#endif
+
+extern int mmu_linear_psize;
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_MMU_BOOK3E_H_ */
Index: linux-work/arch/powerpc/include/asm/page_64.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/page_64.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/page_64.h	2009-06-03 15:13:29.000000000 +1000
@@ -135,12 +135,22 @@ extern void slice_set_range_psize(struct
 #endif /* __ASSEMBLY__ */
 #else
 #define slice_init()
+#ifdef CONFIG_PPC_STD_MMU_64
 #define get_slice_psize(mm, addr)	((mm)->context.user_psize)
 #define slice_set_user_psize(mm, psize)		\
 do {						\
 	(mm)->context.user_psize = (psize);	\
 	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
 } while (0)
+#else /* CONFIG_PPC_STD_MMU_64 */
+#ifdef CONFIG_PPC_64K_PAGES
+#define get_slice_psize(mm, addr)	MMU_PAGE_64K
+#else /* CONFIG_PPC_64K_PAGES */
+#define get_slice_psize(mm, addr)	MMU_PAGE_4K
+#endif /* !CONFIG_PPC_64K_PAGES */
+#define slice_set_user_psize(mm, psize)	do { BUG(); } while(0)
+#endif /* !CONFIG_PPC_STD_MMU_64 */
+
 #define slice_set_range_psize(mm, start, len, psize)	\
 	slice_set_user_psize((mm), (psize))
 #define slice_mm_new_context(mm)	1
Index: linux-work/arch/powerpc/mm/pgtable_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable_64.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/pgtable_64.c	2009-06-03 16:55:50.000000000 +1000
@@ -33,6 +33,8 @@
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/bootmem.h>
+#include <linux/lmb.h>
 
 #include <asm/pgalloc.h>
 #include <asm/page.h>
@@ -55,19 +57,39 @@
 
 unsigned long ioremap_bot = IOREMAP_BASE;
 
+
+#ifdef CONFIG_PPC_MMU_NOHASH
+static void *early_alloc_pgtable(unsigned long size)
+{
+	void *pt;
+
+	if (init_bootmem_done)
+		pt = __alloc_bootmem(size, size, __pa(MAX_DMA_ADDRESS));
+	else
+		pt = __va(lmb_alloc_base(size, size,
+					 __pa(MAX_DMA_ADDRESS)));
+	memset(pt, 0, size);
+
+	printk("early_alloc_pgtable(0x%lx) -> 0x%p (using %s)\n",
+	       size, pt, init_bootmem_done ? "bootmem" : "lmb");
+
+	return pt;
+}
+#endif /* CONFIG_PPC_MMU_NOHASH */
+
 /*
- * map_io_page currently only called by __ioremap
- * map_io_page adds an entry to the ioremap page table
+ * map_kernel_page currently only called by __ioremap
+ * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-static int map_io_page(unsigned long ea, unsigned long pa, int flags)
+static int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
 {
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	if (mem_init_done) {
+	if (slab_is_available()) {
 		pgdp = pgd_offset_k(ea);
 		pudp = pud_alloc(&init_mm, pgdp, ea);
 		if (!pudp)
@@ -81,6 +103,33 @@ static int map_io_page(unsigned long ea,
 		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
 							  __pgprot(flags)));
 	} else {
+#ifdef CONFIG_PPC_MMU_NOHASH
+		/* Warning ! This will blow up if bootmem is not initialized
+		 * which our ppc64 code is keen to do that, we'll need to
+		 * fix it and/or be more careful
+		 */
+		pgdp = pgd_offset_k(ea);
+		if (pgd_none(*pgdp)) {
+			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
+			BUG_ON(pudp == NULL);
+			pgd_populate(&init_mm, pgdp, pudp);
+		}
+		pudp = pud_offset(pgdp, ea);
+		if (pud_none(*pudp)) {
+			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
+			BUG_ON(pmdp == NULL);
+			pud_populate(&init_mm, pudp, pmdp);
+		}
+		pmdp = pmd_offset(pudp, ea);
+		if (!pmd_present(*pmdp)) {
+			ptep = early_alloc_pgtable(PAGE_SIZE);
+			BUG_ON(ptep == NULL);
+			pmd_populate_kernel(&init_mm, pmdp, ptep);
+		}
+		ptep = pte_offset_kernel(pmdp, ea);
+		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
+							  __pgprot(flags)));
+#else /* CONFIG_PPC_MMU_NOHASH */
 		/*
 		 * If the mm subsystem is not fully up, we cannot create a
 		 * linux page table entry for this mapping.  Simply bolt an
@@ -93,6 +142,7 @@ static int map_io_page(unsigned long ea,
 			       "memory at %016lx !\n", pa);
 			return -ENOMEM;
 		}
+#endif /* !CONFIG_PPC_MMU_NOHASH */
 	}
 	return 0;
 }
@@ -124,7 +174,7 @@ void __iomem * __ioremap_at(phys_addr_t 
 	WARN_ON(size & ~PAGE_MASK);
 
 	for (i = 0; i < size; i += PAGE_SIZE)
-		if (map_io_page((unsigned long)ea+i, pa+i, flags))
+		if (map_kernel_page((unsigned long)ea+i, pa+i, flags))
 			return NULL;
 
 	return (void __iomem *)ea;
Index: linux-work/arch/powerpc/include/asm/exception-64e.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/exception-64e.h	2009-06-03 15:13:29.000000000 +1000
@@ -0,0 +1,223 @@
+/*
+ *  Definitions for use by exception code on Book3-E
+ *
+ *  Copyright (C) 2008 Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+#ifndef __EXCEPTION_64E_H__
+#define __EXCEPTION_64E_H__
+
+/*
+ * SPRGs usage an other considerations...
+ *
+ * Since TLB miss and other standard exceptions can be interrupted by
+ * critical exceptions which can themselves be interrupted by machine
+ * checks, and since the two later can themselves cause a TLB miss when
+ * hitting the linear mapping for the kernel stacks, we need to be a bit
+ * creative on how we use SPRGs.
+ *
+ * The base idea is that we have one SRPG reserved for critical and one
+ * for machine check interrupts. Those are used to save a GPR that can
+ * then be used to get the PACA, and store as much context as we need
+ * to save in there. That includes saving the SPRGs used by the TLB miss
+ * handler for linear mapping misses and the associated SRR0/1 due to
+ * the above re-entrancy issue.
+ *
+ * So here's the current usage pattern. It's done regardless of which
+ * SPRGs are user-readable though, thus we might have to change some of
+ * this later. In order to do that more easily, we use special constants
+ * for naming them
+ *
+ * WARNING: Some of these SPRGs are user readable. We need to do something
+ * about it as some point by making sure they can't be used to leak kernel
+ * critical data
+ */
+
+/* Machine check reserved SPRG */
+#define SPRN_SPRG_MCHECK	SPRN_SPRG8
+
+/* Critical interrupt reserved SPRG */
+#define SPRN_SPRG_CRIT		SPRN_SPRG7
+
+/* Debug interrupt reserved SPRG */
+#define SPRN_SPRG_DBG		SPRN_SPRG6
+
+/* PACA (can't be changed without updating kernel code all over though) */
+#define SPRN_SPRG_PACA		SPRN_SPRG3
+
+/* Current TLB miss exception frame in PACA (can't be changed without updating
+ * the code in setup_paca() */
+#define SPRN_SPRG_TLB_EXFRAME	SPRN_SPRG2
+#define SPRN_SPRG_TLB_R12	SPRN_SPRG1
+
+/* Normal exceptions only use one SPRG to save r13 and it's not clobbered
+ * by TLB misses, though it could be if the exception code was causing a
+ * protection fault. Howeverm such a fault would be fatal anyway.
+ */
+#define SPRN_SPRG_GEN		SPRN_SPRG0
+
+
+/* We are out of SPRGs so we save some things in the PACA. The normal
+ * exception frame is smaller than the CRIT or MC one though
+ */
+#define EX_R1		(0 * 8)
+#define EX_CR		(1 * 8)
+#define EX_R10		(2 * 8)
+#define EX_R11		(3 * 8)
+#define EX_R14		(4 * 8)
+#define EX_R15		(5 * 8)
+
+/* The TLB miss exception uses different slots */
+
+#define EX_TLB_R10	( 0 * 8)
+#define EX_TLB_R11	( 1 * 8)
+#define EX_TLB_R12	( 2 * 8)
+#define EX_TLB_R13	( 3 * 8)
+#define EX_TLB_R14	( 4 * 8)
+#define EX_TLB_R15	( 5 * 8)
+#define EX_TLB_R16	( 6 * 8)
+#define EX_TLB_CR	( 7 * 8)
+#define EX_TLB_DEAR	( 8 * 8) /* Level 0 and 2 only */
+#define EX_TLB_ESR	( 9 * 8) /* Level 0 and 2 only */
+#define EX_TLB_SRR0	(10 * 8)
+#define EX_TLB_SRR1	(11 * 8)
+#define EX_TLB_MMUCR0	(12 * 8) /* Level 0 */
+#define EX_TLB_MAS1	(12 * 8) /* Level 0 */
+#define EX_TLB_MAS2	(13 * 8) /* Level 0 */
+#ifdef CONFIG_BOOK3E_MMU_TLB_STATS
+#define EX_TLB_R8	(14 * 8)
+#define EX_TLB_R9	(15 * 8)
+#define EX_TLB_LR	(16 * 8)
+#define EX_TLB_SIZE	(17 * 8)
+#else
+#define EX_TLB_SIZE	(14 * 8)
+#endif
+
+#define	START_EXCEPTION(label)						\
+	.globl exc_##label##_book3e;					\
+exc_##label##_book3e:
+
+/* TLB miss exception prolog
+ *
+ * This prolog handles re-entrancy (up to 3 levels supported in the PACA
+ * though we currently don't test for overflow). It provides you with a
+ * re-entrancy safe working space of r10...r16 and CR with r12 being used
+ * as the exception area pointer in the PACA for that level of re-entrancy
+ * and r13 containing the PACA pointer.
+ *
+ * SRR0 and SRR1 are saved, but DEAR and ESR are not, since they don't apply
+ * as-is for instruction exceptions. It's up to the actual exception code
+ * to save them as well if required.
+ */
+#define TLB_MISS_PROLOG							    \
+	mtspr	SPRN_SPRG_TLB_R12,r12;					    \
+	mfspr	r12,SPRN_SPRG_TLB_EXFRAME;				    \
+	std	r10,EX_TLB_R10(r12);					    \
+	mfcr	r10;							    \
+	std	r11,EX_TLB_R11(r12);					    \
+	mfspr	r11,SPRN_SPRG_TLB_R12;					    \
+	std	r13,EX_TLB_R13(r12);					    \
+	mfspr	r13,SPRN_SPRG_PACA;					    \
+	std	r14,EX_TLB_R14(r12);					    \
+	addi	r14,r12,EX_TLB_SIZE;					    \
+	std	r15,EX_TLB_R15(r12);					    \
+	mfspr	r15,SPRN_SRR1;						    \
+	std	r16,EX_TLB_R16(r12);					    \
+	mfspr	r16,SPRN_SRR0;						    \
+	std	r10,EX_TLB_CR(r12);					    \
+	std	r11,EX_TLB_R12(r12);					    \
+	mtspr	SPRN_SPRG_TLB_EXFRAME,r14;				    \
+	std	r15,EX_TLB_SRR1(r12);					    \
+	std	r16,EX_TLB_SRR0(r12);					    \
+	TLB_MISS_PROLOG_STATS
+
+/* And these are the matching epilogs that restores things
+ *
+ * There are 3 epilogs:
+ *
+ * - SUCCESS       : Unwinds one level
+ * - ERROR         : restore from level 0 and reset
+ * - ERROR_SPECIAL : restore from current level and reset
+ *
+ * Normal errors use ERROR, that is, they restore the initial fault context
+ * and trigger a fault. However, there is a special case for linear mapping
+ * errors. Those should basically never happen, but if they do happen, we
+ * want the error to point out the context that did that linear mapping
+ * fault, not the initial level 0 (basically, we got a bogus PGF or something
+ * like that). For userland errors on the linear mapping, there is no
+ * difference since those are always level 0 anyway
+ */
+
+#define TLB_MISS_RESTORE(freg)						    \
+	ld	r14,EX_TLB_CR(r12);					    \
+	ld	r10,EX_TLB_R10(r12);					    \
+	ld	r15,EX_TLB_SRR0(r12);					    \
+	ld	r16,EX_TLB_SRR1(r12);					    \
+	mtspr	SPRN_SPRG_TLB_EXFRAME,freg;				    \
+	ld	r11,EX_TLB_R11(r12);					    \
+	mtcr	r14;							    \
+	ld	r13,EX_TLB_R13(r12);					    \
+	ld	r14,EX_TLB_R14(r12);					    \
+	mtspr	SPRN_SRR0,r15;						    \
+	ld	r15,EX_TLB_R15(r12);					    \
+	mtspr	SPRN_SRR1,r16;						    \
+	TLB_MISS_RESTORE_STATS						    \
+	ld	r16,EX_TLB_R16(r12);					    \
+	ld	r12,EX_TLB_R12(r12);					    \
+
+#define TLB_MISS_EPILOG_SUCCESS						    \
+	TLB_MISS_RESTORE(r12)
+
+#define TLB_MISS_EPILOG_ERROR						    \
+	addi	r12,r13,PACA_EXTLB;					    \
+	TLB_MISS_RESTORE(r12)
+
+#define TLB_MISS_EPILOG_ERROR_SPECIAL					    \
+	addi	r11,r13,PACA_EXTLB;					    \
+	TLB_MISS_RESTORE(r11)
+
+#ifdef CONFIG_BOOK3E_MMU_TLB_STATS
+#define TLB_MISS_PROLOG_STATS						    \
+	mflr	r10;							    \
+	std	r8,EX_TLB_R8(r12);					    \
+	std	r9,EX_TLB_R9(r12);					    \
+	std	r10,EX_TLB_LR(r12);
+#define TLB_MISS_RESTORE_STATS					            \
+	ld	r16,EX_TLB_LR(r12);					    \
+	ld	r9,EX_TLB_R9(r12);					    \
+	ld	r8,EX_TLB_R8(r12);					    \
+	mtlr	r16;
+#define TLB_MISS_STATS_D(name)						    \
+	addi	r9,r13,MMSTAT_DSTATS+name;				    \
+	bl	.tlb_stat_inc;
+#define TLB_MISS_STATS_I(name)						    \
+	addi	r9,r13,MMSTAT_ISTATS+name;				    \
+	bl	.tlb_stat_inc;
+#define TLB_MISS_STATS_X(name)						    \
+	ld	r8,PACA_EXTLB+EX_TLB_ESR(r13);				    \
+	cmpdi	cr2,r8,-1;						    \
+	beq	cr2,61f;						    \
+	addi	r9,r13,MMSTAT_DSTATS+name;				    \
+	b	62f;							    \
+61:	addi	r9,r13,MMSTAT_ISTATS+name;				    \
+62:	bl	.tlb_stat_inc;
+#define TLB_MISS_STATS_SAVE_INFO					    \
+	std	r14,EX_TLB_ESR(r12);	/* save ESR */			    \
+
+
+#else
+#define TLB_MISS_PROLOG_STATS
+#define TLB_MISS_RESTORE_STATS
+#define TLB_MISS_STATS_D(name)
+#define TLB_MISS_STATS_I(name)
+#define TLB_MISS_STATS_X(name)
+#define TLB_MISS_STATS_Y(name)
+#define TLB_MISS_STATS_SAVE_INFO
+#endif
+
+
+#endif /* __EXCEPTIONS_64E_H__ */
Index: linux-work/arch/powerpc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/kernel/Makefile	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/Makefile	2009-06-03 15:13:29.000000000 +1000
@@ -31,10 +31,10 @@ obj-y				:= cputable.o ptrace.o syscalls
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
-				   paca.o cpu_setup_ppc970.o \
-				   cpu_setup_pa6t.o \
-				   firmware.o nvram_64.o
+				   paca.o nvram_64.o firmware.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
+obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
@@ -61,8 +61,8 @@ obj-$(CONFIG_MODULES)		+= module.o modul
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
 obj-$(CONFIG_FSL_BOOKE)		+= cpu_setup_fsl_booke.o dbell.o
 
-extra-$(CONFIG_PPC_STD_MMU)	:= head_32.o
-extra-$(CONFIG_PPC64)		:= head_64.o
+extra-y				:= head_$(CONFIG_WORD_SIZE).o
+extra-$(CONFIG_PPC_BOOK3E_32)	:= head_new_booke.o
 extra-$(CONFIG_40x)		:= head_40x.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
Index: linux-work/arch/powerpc/include/asm/reg.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/reg.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg.h	2009-06-03 15:13:29.000000000 +1000
@@ -98,19 +98,15 @@
 #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC_BOOK3S_64)
+/* Server variant */
 #define MSR_		MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV
 #define MSR_KERNEL      MSR_ | MSR_SF
-
 #define MSR_USER32	MSR_ | MSR_PR | MSR_EE
 #define MSR_USER64	MSR_USER32 | MSR_SF
-
-#else /* 32-bit */
+#elif defined(CONFIG_PPC_BOOK3S_32)
 /* Default MSR for kernel mode. */
-#ifndef MSR_KERNEL	/* reg_booke.h also defines this */
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR)
-#endif
-
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
Index: linux-work/arch/powerpc/include/asm/reg_booke.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/reg_booke.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg_booke.h	2009-06-03 15:13:29.000000000 +1000
@@ -18,18 +18,26 @@
 #define MSR_IS		MSR_IR	/* Instruction Space */
 #define MSR_DS		MSR_DR	/* Data Space */
 #define MSR_PMM		(1<<2)	/* Performance monitor mark bit */
+#define MSR_CM		(1<<31) /* Computation Mode (0=32-bit, 1=64-bit) */
 
-/* Default MSR for kernel mode. */
-#if defined (CONFIG_40x)
+#if defined(CONFIG_PPC_BOOK3E_64)
+#define MSR_		MSR_ME | MSR_CE
+#define MSR_KERNEL      MSR_ | MSR_CM
+#define MSR_USER32	MSR_ | MSR_PR | MSR_EE
+#define MSR_USER64	MSR_USER32 | MSR_CM
+#elif defined (CONFIG_40x)
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
-#elif defined(CONFIG_BOOKE)
+#define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
+#else
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
+#define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
 /* Special Purpose Registers (SPRNs)*/
 #define SPRN_DECAR	0x036	/* Decrementer Auto Reload Register */
 #define SPRN_IVPR	0x03F	/* Interrupt Vector Prefix Register */
 #define SPRN_USPRG0	0x100	/* User Special Purpose Register General 0 */
+#define SPRN_SPRG3R	0x103	/* Special Purpose Register General 4 Read */
 #define SPRN_SPRG4R	0x104	/* Special Purpose Register General 4 Read */
 #define SPRN_SPRG5R	0x105	/* Special Purpose Register General 5 Read */
 #define SPRN_SPRG6R	0x106	/* Special Purpose Register General 6 Read */
@@ -38,11 +46,18 @@
 #define SPRN_SPRG5W	0x115	/* Special Purpose Register General 5 Write */
 #define SPRN_SPRG6W	0x116	/* Special Purpose Register General 6 Write */
 #define SPRN_SPRG7W	0x117	/* Special Purpose Register General 7 Write */
+#define SPRN_EPCR	0x133	/* Embedded Processor Control Register */
 #define SPRN_DBCR2	0x136	/* Debug Control Register 2 */
 #define SPRN_IAC3	0x13A	/* Instruction Address Compare 3 */
 #define SPRN_IAC4	0x13B	/* Instruction Address Compare 4 */
 #define SPRN_DVC1	0x13E	/* Data Value Compare Register 1 */
 #define SPRN_DVC2	0x13F	/* Data Value Compare Register 2 */
+#define SPRN_MAS8	0x155	/* MMU Assist Register 8 */
+#define SPRN_TLB0PS	0x158	/* TLB 0 Page Size Register */
+#define SPRN_MAS5_MAS6	0x15c	/* MMU Assist Register 5 || 6 */
+#define SPRN_MAS8_MAS1	0x15d	/* MMU Assist Register 8 || 1 */
+#define SPRN_MAS7_MAS3	0x174	/* MMU Assist Register 7 || 3 */
+#define SPRN_MAS0_MAS1	0x175	/* MMU Assist Register 0 || 1 */
 #define SPRN_IVOR0	0x190	/* Interrupt Vector Offset Register 0 */
 #define SPRN_IVOR1	0x191	/* Interrupt Vector Offset Register 1 */
 #define SPRN_IVOR2	0x192	/* Interrupt Vector Offset Register 2 */
@@ -423,6 +438,19 @@
 #define SGR_NORMAL	0		/* Speculative fetching allowed. */
 #define SGR_GUARDED	1		/* Speculative fetching disallowed. */
 
+/* Bit definitions for EPCR */
+#define SPRN_EPCR_EXTGS		0x80000000
+#define SPRN_EPCR_DTLBGS	0x40000000
+#define SPRN_EPCR_ITLBGS	0x20000000
+#define SPRN_EPCR_DSIGS		0x10000000
+#define SPRN_EPCR_ISIGS		0x08000000
+#define SPRN_EPCR_DUVD		0x04000000
+#define SPRN_EPCR_ICM		0x02000000
+#define SPRN_EPCR_GICM		0x01000000
+#define SPRN_EPCR_DGTMI		0x00800000
+#define SPRN_EPCR_DMIUH		0x00400000
+
+
 /*
  * The IBM-403 is an even more odd special case, as it is much
  * older than the IBM-405 series.  We put these down here incase someone
@@ -478,3 +506,4 @@
 #endif /* 403GCX */
 #endif /* __ASM_POWERPC_REG_BOOKE_H__ */
 #endif /* __KERNEL__ */
+
Index: linux-work/arch/powerpc/mm/tlb_low_64e.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/tlb_low_64e.S	2009-06-03 15:13:29.000000000 +1000
@@ -0,0 +1,733 @@
+/*
+ *  Low leve TLB miss handlers for Book3E
+ *
+ *  Copyright (C) 2008-2009
+ *      Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/mmu.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cputable.h>
+#include <asm/pgtable.h>
+#include <asm/reg.h>
+#include <asm/exception-64e.h>
+#include <asm/ppc-opcode.h>
+
+#ifdef CONFIG_PPC_64K_PAGES
+#define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE+1)
+#else
+#define VPTE_PMD_SHIFT	(PTE_INDEX_SIZE)
+#endif
+#define VPTE_PUD_SHIFT	(VPTE_PMD_SHIFT + PMD_INDEX_SIZE)
+#define VPTE_PGD_SHIFT	(VPTE_PUD_SHIFT + PUD_INDEX_SIZE)
+#define VPTE_INDEX_SIZE (VPTE_PGD_SHIFT + PGD_INDEX_SIZE)
+
+
+/**********************************************************************
+ *                                                                    *
+ * TLB miss handling for Book3E with TLB reservation and HES support  *
+ *                                                                    *
+ **********************************************************************/
+
+
+/* Data TLB miss */
+	START_EXCEPTION(data_tlb_miss)
+	TLB_MISS_PROLOG
+
+	/* Now we handle the fault proper. We only save DEAR in normal
+	 * fault case since that's the only interesting values here.
+	 * We could probably also optimize by not saving SRR0/1 in the
+	 * linear mapping case but I'll leave that for later
+	 */
+	mfspr	r14,SPRN_ESR
+	mfspr	r16,SPRN_DEAR		/* get faulting address */
+	srdi	r15,r16,60		/* get region */
+	cmpldi	cr0,r15,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* The page tables are mapped virtually linear. At this point, though,
+	 * we don't know whether we are trying to fault in a first level
+	 * virtual address or a virtual page table address. We can get that
+	 * from bit 0x1 of the region ID which we have set for a page table
+	 */
+	andi.	r10,r15,0x1
+	bne-	virt_page_table_tlb_miss
+
+	std	r14,EX_TLB_ESR(r12);	/* save ESR */
+	std	r16,EX_TLB_DEAR(r12);	/* save DEAR */
+
+	 /* We need _PAGE_PRESENT and  _PAGE_ACCESSED set */
+	li	r11,_PAGE_PRESENT
+	oris	r11,r11,_PAGE_ACCESSED@h
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	cmpldi	cr0,r15,0		/* Check for user region */
+
+	/* We pre-test some combination of permissions to avoid double
+	 * faults:
+	 *
+	 * We move the ESR:ST bit into the position of _PAGE_BAP_SW in the PTE
+	 * ESR_ST   is 0x00800000
+	 * _PAGE_BAP_SW is 0x00000010
+	 * So the shift is >> 19. This tests for supervisor writeability.
+	 * If the page happens to be supervisor writeable and not user
+	 * writeable, we will take a new fault later, but that should be
+	 * a rare enough case.
+	 *
+	 * We also move ESR_ST in _PAGE_DIRTY position
+	 * _PAGE_DIRTY is 0x00001000 so the shift is >> 11
+	 *
+	 * MAS1 is preset for all we need except for TID that needs to
+	 * be cleared for kernel translations
+	 */
+	rlwimi	r11,r14,32-19,27,27
+	rlwimi	r11,r14,32-16,19,19
+	beq	normal_tlb_miss
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r15,8		/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1		/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	beq+	normal_tlb_miss
+
+	/* We got a crappy address, just fault with whatever DEAR and ESR
+	 * are here
+	 */
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+
+/* Instruction TLB miss */
+	START_EXCEPTION(instruction_tlb_miss)
+	TLB_MISS_PROLOG
+
+	/* If we take a recursive fault, the second level handler may need
+	 * to know whether we are handling a data or instruction fault in
+	 * order to get to the right store fault handler. We provide that
+	 * info by writing a crazy value in ESR in our exception frame
+	 */
+	li	r14,-1	/* store to exception frame is done later */
+
+	/* Now we handle the fault proper. We only save DEAR in the non
+	 * linear mapping case since we know the linear mapping case will
+	 * not re-enter. We could indeed optimize and also not save SRR0/1
+	 * in the linear mapping case but I'll leave that for later
+	 *
+	 * Faulting address is SRR0 which is already in r16
+	 */
+	srdi	r15,r16,60		/* get region */
+	cmpldi	cr0,r15,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	li	r11,_PAGE_PRESENT|_PAGE_HWEXEC	/* Base perm */
+	oris	r11,r11,_PAGE_ACCESSED@h
+
+	cmpldi	cr0,r15,0			/* Check for user region */
+	std	r14,EX_TLB_ESR(r12)		/* write crazy -1 to frame */
+	beq	normal_tlb_miss
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r15,8			/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1			/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	beq+	normal_tlb_miss
+
+	/* We got a crappy address, just fault */
+	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+/*
+ * This is the guts of the first-level TLB miss handler for direct
+ * misses. We are entered with:
+ *
+ * r16 = faulting address
+ * r15 = region ID
+ * r14 = crap (free to use)
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = PTE permission mask
+ * r10 = crap (free to use)
+ */
+normal_tlb_miss:
+	/* So we first construct the page table address. We do that by
+	 * shifting the bottom of the address (not the region ID) by
+	 * PAGE_SHIFT-3, clearing the bottom 3 bits (get a PTE ptr) and
+	 * or'ing the fourth high bit.
+	 *
+	 * NOTE: For 64K pages, we do things slightly differently in
+	 * order to handle the weird page table format used by linux
+	 */
+	ori	r10,r15,0x1
+#ifdef CONFIG_PPC_64K_PAGES
+	/* For the top bits, 16 bytes per PTE */
+	rldicl	r14,r16,64-(PAGE_SHIFT-4),PAGE_SHIFT-4+4
+	/* Now create the bottom bits as 0 in position 0x8000 and
+	 * the rest calculated for 8 bytes per PTE
+	 */
+	rldicl	r15,r16,64-(PAGE_SHIFT-3),64-15
+	/* Insert the bottom bits in */
+	rlwimi	r14,r15,0,16,31
+#else
+	rldicl	r14,r16,64-(PAGE_SHIFT-3),PAGE_SHIFT-3+4
+#endif
+	sldi	r15,r10,60
+	clrrdi	r14,r14,3
+	or	r10,r15,r14
+
+	/* Set the TLB reservation and seach for existing entry. Then load
+	 * the entry.
+	 */
+	PPC_TLBSRX_DOT(0,r16)
+	ld	r14,0(r10)
+	beq	normal_tlb_miss_done
+
+finish_normal_tlb_miss:
+	/* Check if required permissions are met */
+	andc.	r15,r11,r14
+	bne-	normal_tlb_miss_access_fault
+
+	/* Now we build the MAS:
+	 *
+	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
+	 * MAS 1   :	Almost fully setup
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE need change if !base page size, not
+	 *                 yet implemented for now
+	 * MAS 2   :	Defaults not useful, need to be redone
+	 * MAS 3+7 :	Needs to be done
+	 *
+	 * TODO: mix up code below for better scheduling
+	 */
+	clrrdi	r11,r16,12		/* Clear low crap in EA */
+	rlwimi	r11,r14,32-19,27,31	/* Insert WIMGE */
+	mtspr	SPRN_MAS2,r11
+
+	/* Check page size, if not standard, update MAS1 */
+	rldicl	r11,r14,64-8,64-8
+#ifdef CONFIG_PPC_64K_PAGES
+	cmpldi	cr0,r11,BOOK3E_PAGESZ_64K
+#else
+	cmpldi	cr0,r11,BOOK3E_PAGESZ_4K
+#endif
+	beq-	1f
+	mfspr	r11,SPRN_MAS1
+	rlwimi	r11,r14,31,21,24
+	rlwinm	r11,r11,0,21,19
+	mtspr	SPRN_MAS1,r11
+1:
+	/* Move RPN in position */
+	rldicr	r11,r14,64-(PTE_RPN_SHIFT-PAGE_SHIFT),63-PAGE_SHIFT
+	clrldi	r15,r11,12		/* Clear crap at the top */
+	rlwimi	r15,r14,32-8,22,25	/* Move in U bits */
+	rlwimi	r15,r14,32-2,26,31	/* Move in BAP bits */
+
+	/* Mask out SW and UW if !DIRTY (XXX optimize this !) */
+	andi.	r11,r14,_PAGE_DIRTY
+	bne	1f
+	li	r11,SPRN_MAS3_SW|SPRN_MAS3_UW
+	andc	r15,r15,r11
+1:	mtspr	SPRN_MAS7_MAS3,r15
+
+	tlbwe
+
+normal_tlb_miss_done:
+	/* We don't bother with restoring DEAR or ESR since we know we are
+	 * level 0 and just going back to userland. They are only needed
+	 * if you are going to take an access fault
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_NORM_OK)
+	TLB_MISS_EPILOG_SUCCESS
+	rfi
+
+normal_tlb_miss_access_fault:
+	/* We need to check if it was an instruction miss */
+	andi.	r10,r11,_PAGE_HWEXEC
+	bne	1f
+	ld	r14,EX_TLB_DEAR(r12)
+	ld	r15,EX_TLB_ESR(r12)
+	mtspr	SPRN_DEAR,r14
+	mtspr	SPRN_ESR,r15
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+1:	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+
+/*
+ * This is the guts of the second-level TLB miss handler for direct
+ * misses. We are entered with:
+ *
+ * r16 = virtual page table faulting address
+ * r15 = region (top 4 bits of address)
+ * r14 = crap (free to use)
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = crap (free to use)
+ * r10 = crap (free to use)
+ *
+ * Note that this should only ever be called as a second level handler
+ * with the current scheme when using SW load.
+ * That means we can always get the original fault DEAR at
+ * EX_TLB_DEAR-EX_TLB_SIZE(r12)
+ *
+ * It can be re-entered by the linear mapping miss handler. However, to
+ * avoid too much complication, it will restart the whole fault at level
+ * 0 so we don't care too much about clobbers
+ *
+ * XXX That code was written back when we couldn't clobber r14. We can now,
+ * so we could probably optimize things a bit
+ */
+virt_page_table_tlb_miss:
+	/* Are we hitting a kernel page table ? */
+	andi.	r10,r15,0x8
+
+	/* The cool thing now is that r10 contains 0 for user and 8 for kernel,
+	 * and we happen to have the swapper_pg_dir at offset 8 from the user
+	 * pgdir in the PACA :-).
+	 */
+	add	r11,r10,r13
+
+	/* If kernel, we need to clear MAS1 TID */
+	beq	1f
+	/* XXX replace the RMW cycles with immediate loads + writes */
+	mfspr	r10,SPRN_MAS1
+	rlwinm	r10,r10,0,16,1			/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+1:
+	/* Search if we already have a TLB entry for that virtual address, and
+	 * if we do, bail out.
+	 */
+	PPC_TLBSRX_DOT(0,r16)
+	beq	virt_page_table_tlb_miss_done
+
+	/* Now, we need to walk the page tables. First check if we are in
+	 * range.
+	 */
+	rldicl.	r10,r16,64-(VPTE_INDEX_SIZE+3),VPTE_INDEX_SIZE+3+4
+	bne-	virt_page_table_tlb_miss_fault
+
+	/* Get the PGD pointer */
+	ld	r15,PACAPGD(r11)
+	cmpldi	cr0,r15,0
+	beq-	virt_page_table_tlb_miss_fault
+
+	/* Get to PGD entry */
+	rldicl	r11,r16,64-VPTE_PGD_SHIFT,64-PGD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	virt_page_table_tlb_miss_fault
+
+#ifndef CONFIG_PPC_64K_PAGES
+	/* Get to PUD entry */
+	rldicl	r11,r16,64-VPTE_PUD_SHIFT,64-PUD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	virt_page_table_tlb_miss_fault
+#endif /* CONFIG_PPC_64K_PAGES */
+
+	/* Get to PMD entry */
+	rldicl	r11,r16,64-VPTE_PMD_SHIFT,64-PMD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	virt_page_table_tlb_miss_fault
+
+	/* Ok, we're all right, we can now create a kernel translation for
+	 * a 4K or 64K page from r16 -> r15.
+	 */
+	/* Now we build the MAS:
+	 *
+	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
+	 * MAS 1   :	Almost fully setup
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE for now is base page size always
+	 * MAS 2   :	Use defaults
+	 * MAS 3+7 :	Needs to be done
+	 *
+	 * So we only do MAS 2 and 3 for now...
+	 */
+	clrldi	r11,r15,4		/* remove region ID from RPN */
+	ori	r10,r11,1		/* Or-in SR */
+	mtspr	SPRN_MAS7_MAS3,r10
+
+	tlbwe
+
+virt_page_table_tlb_miss_done:
+
+	/* We have overriden MAS2:EPN but currently our primary TLB miss
+	 * handler will always restore it so that should not be an issue,
+	 * if we ever optimize the primary handler to not write MAS2 on
+	 * some cases, we'll have to restore MAS2:EPN here based on the
+	 * original fault's DEAR. If we do that we have to modify the
+	 * ITLB miss handler to also store SRR0 in the exception frame
+	 * as DEAR.
+	 *
+	 * However, one nasty thing we did is we cleared the reservation
+	 * (well, potentially we did). We do a trick here thus if we
+	 * are not a level 0 exception (we interrupted the TLB miss) we
+	 * offset the return address by -4 in order to replay the tlbsrx
+	 * instruction there
+	 */
+	subf	r10,r13,r12
+	cmpldi	cr0,r10,PACA_EXTLB+EX_TLB_SIZE
+	bne-	1f
+	ld	r11,PACA_EXTLB+EX_TLB_SIZE+EX_TLB_SRR0(r13)
+	addi	r10,r11,-4
+	std	r10,PACA_EXTLB+EX_TLB_SIZE+EX_TLB_SRR0(r13)
+1:
+	/* Return to caller, normal case */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_PT_OK);
+	TLB_MISS_EPILOG_SUCCESS
+	rfi
+
+virt_page_table_tlb_miss_fault:
+	/* If we fault here, things are a little bit tricky. We need to call
+	 * either data or instruction store fault, and we need to retreive
+	 * the original fault address and ESR (for data).
+	 *
+	 * The thing is, we know that in normal circumstances, this is
+	 * always called as a second level tlb miss for SW load or as a first
+	 * level TLB miss for HW load, so we should be able to peek at the
+	 * relevant informations in the first exception frame in the PACA.
+	 *
+	 * However, we do need to double check that, because we may just hit
+	 * a stray kernel pointer or a userland attack trying to hit those
+	 * areas. If that is the case, we do a data fault. (We can't get here
+	 * from an instruction tlb miss anyway).
+	 *
+	 * Note also that when going to a fault, we must unwind the previous
+	 * level as well. Since we are doing that, we don't need to clear or
+	 * restore the TLB reservation neither.
+	 */
+	subf	r10,r13,r12
+	cmpldi	cr0,r10,PACA_EXTLB+EX_TLB_SIZE
+	bne-	virt_page_table_tlb_miss_whacko_fault
+
+	/* We dig the original DEAR and ESR from slot 0 */
+	ld	r15,EX_TLB_DEAR+PACA_EXTLB(r13)
+	ld	r16,EX_TLB_ESR+PACA_EXTLB(r13)
+
+	/* We check for the "special" ESR value for instruction faults */
+	cmpdi	cr0,r16,-1
+	beq	1f
+	mtspr	SPRN_DEAR,r15
+	mtspr	SPRN_ESR,r16
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_PT_FAULT);
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+1:	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_PT_FAULT);
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+virt_page_table_tlb_miss_whacko_fault:
+	/* The linear fault will restart everything so ESR and DEAR will
+	 * not have been clobbered, let's just fault with what we have
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_PT_FAULT);
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+
+
+/**************************************************************
+ *                                                            *
+ * TLB miss handling for Book3E with hw page table support    *
+ *                                                            *
+ **************************************************************/
+
+
+/* Data TLB miss */
+	START_EXCEPTION(data_tlb_miss_htw)
+	TLB_MISS_PROLOG
+
+	/* Now we handle the fault proper. We only save DEAR in normal
+	 * fault case since that's the only interesting values here.
+	 * We could probably also optimize by not saving SRR0/1 in the
+	 * linear mapping case but I'll leave that for later
+	 */
+	mfspr	r14,SPRN_ESR
+	mfspr	r16,SPRN_DEAR		/* get faulting address */
+	srdi	r11,r16,60		/* get region */
+	cmpldi	cr0,r11,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	cmpldi	cr0,r11,0		/* Check for user region */
+	ld	r15,PACAPGD(r13)	/* Load user pgdir */
+	beq	htw_tlb_miss
+
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r11,8		/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1		/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	ld	r15,PACA_KERNELPGD(r13)	/* Load kernel pgdir */
+	beq+	htw_tlb_miss
+
+	/* We got a crappy address, just fault with whatever DEAR and ESR
+	 * are here
+	 */
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+
+/* Instruction TLB miss */
+	START_EXCEPTION(instruction_tlb_miss_htw)
+	TLB_MISS_PROLOG
+
+	/* If we take a recursive fault, the second level handler may need
+	 * to know whether we are handling a data or instruction fault in
+	 * order to get to the right store fault handler. We provide that
+	 * info by keeping a crazy value for ESR in r14
+	 */
+	li	r14,-1	/* store to exception frame is done later */
+
+	/* Now we handle the fault proper. We only save DEAR in the non
+	 * linear mapping case since we know the linear mapping case will
+	 * not re-enter. We could indeed optimize and also not save SRR0/1
+	 * in the linear mapping case but I'll leave that for later
+	 *
+	 * Faulting address is SRR0 which is already in r16
+	 */
+	srdi	r11,r16,60		/* get region */
+	cmpldi	cr0,r11,0xc		/* linear mapping ? */
+	TLB_MISS_STATS_SAVE_INFO
+	beq	tlb_load_linear		/* yes -> go to linear map load */
+
+	/* We do the user/kernel test for the PID here along with the RW test
+	 */
+	cmpldi	cr0,r11,0			/* Check for user region */
+	ld	r15,PACAPGD(r13)		/* Load user pgdir */
+	beq	htw_tlb_miss
+
+	/* XXX replace the RMW cycles with immediate loads + writes */
+1:	mfspr	r10,SPRN_MAS1
+	cmpldi	cr0,r11,8			/* Check for vmalloc region */
+	rlwinm	r10,r10,0,16,1			/* Clear TID */
+	mtspr	SPRN_MAS1,r10
+	ld	r15,PACA_KERNELPGD(r13)		/* Load kernel pgdir */
+	beq+	htw_tlb_miss
+
+	/* We got a crappy address, just fault */
+	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+
+/*
+ * This is the guts of the second-level TLB miss handler for direct
+ * misses. We are entered with:
+ *
+ * r16 = virtual page table faulting address
+ * r15 = PGD pointer
+ * r14 = ESR
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = crap (free to use)
+ * r10 = crap (free to use)
+ *
+ * It can be re-entered by the linear mapping miss handler. However, to
+ * avoid too much complication, it will save/restore things for us
+ */
+htw_tlb_miss:
+	/* Search if we already have a TLB entry for that virtual address, and
+	 * if we do, bail out.
+	 *
+	 * MAS1:IND should be already set based on MAS4
+	 */
+	PPC_TLBSRX_DOT(0,r16)
+	beq	htw_tlb_miss_done
+
+	/* Now, we need to walk the page tables. First check if we are in
+	 * range.
+	 */
+	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
+	bne-	htw_tlb_miss_fault
+
+	/* Get the PGD pointer */
+	cmpldi	cr0,r15,0
+	beq-	htw_tlb_miss_fault
+
+	/* Get to PGD entry */
+	rldicl	r11,r16,64-(PGDIR_SHIFT-3),64-PGD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	htw_tlb_miss_fault
+
+#ifndef CONFIG_PPC_64K_PAGES
+	/* Get to PUD entry */
+	rldicl	r11,r16,64-(PUD_SHIFT-3),64-PUD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	htw_tlb_miss_fault
+#endif /* CONFIG_PPC_64K_PAGES */
+
+	/* Get to PMD entry */
+	rldicl	r11,r16,64-(PMD_SHIFT-3),64-PMD_INDEX_SIZE-3
+	clrrdi	r10,r11,3
+	ldx	r15,r10,r15
+	cmpldi	cr0,r15,0
+	beq	htw_tlb_miss_fault
+
+	/* Ok, we're all right, we can now create an indirect entry for
+	 * a 1M or 256M page.
+	 *
+	 * The last trick is now that because we use "half" pages for
+	 * the HTW (1M IND is 2K and 256M IND is 32K) we need to account
+	 * for an added LSB bit to the RPN. For 64K pages, there is no
+	 * problem as we already use 32K arrays (half PTE pages), but for
+	 * 4K page we need to extract a bit from the virtual address and
+	 * insert it into the "PA52" bit of the RPN.
+	 */
+#ifndef CONFIG_PPC_64K_PAGES
+	rlwimi	r15,r16,32-9,20,20
+#endif
+	/* Now we build the MAS:
+	 *
+	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
+	 * MAS 1   :	Almost fully setup
+	 *               - PID already updated by caller if necessary
+	 *               - TSIZE for now is base ind page size always
+	 * MAS 2   :	Use defaults
+	 * MAS 3+7 :	Needs to be done
+	 */
+#ifdef CONFIG_PPC_64K_PAGES
+	ori	r10,r15,(BOOK3E_PAGESZ_64K << SPRN_MAS3_SPSIZE_SHIFT)
+#else
+	ori	r10,r15,(BOOK3E_PAGESZ_4K << SPRN_MAS3_SPSIZE_SHIFT)
+#endif
+	mtspr	SPRN_MAS7_MAS3,r10
+
+	tlbwe
+
+htw_tlb_miss_done:
+	/* We don't bother with restoring DEAR or ESR since we know we are
+	 * level 0 and just going back to userland. They are only needed
+	 * if you are going to take an access fault
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_PT_OK)
+	TLB_MISS_EPILOG_SUCCESS
+	rfi
+
+htw_tlb_miss_fault:
+	/* We need to check if it was an instruction miss. We know this
+	 * though because r14 would contain -1
+	 */
+	cmpdi	cr0,r14,-1
+	beq	1f
+	mtspr	SPRN_DEAR,r16
+	mtspr	SPRN_ESR,r14
+	TLB_MISS_STATS_D(MMSTAT_TLB_MISS_PT_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_data_storage_book3e
+1:	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_PT_FAULT)
+	TLB_MISS_EPILOG_ERROR
+	b	exc_instruction_storage_book3e
+
+/*
+ * This is the guts of "any" level TLB miss handler for kernel linear
+ * mapping misses. We are entered with:
+ *
+ *
+ * r16 = faulting address
+ * r15 = crap (free to use)
+ * r14 = ESR (data) or -1 (instruction)
+ * r13 = PACA
+ * r12 = TLB exception frame in PACA
+ * r11 = crap (free to use)
+ * r10 = crap (free to use)
+ *
+ * In addition we know that we will not re-enter, so in theory, we could
+ * use a simpler epilog not restoring SRR0/1 etc.. but we'll do that later.
+ *
+ * We also need to be careful about MAS registers here & TLB reservation,
+ * as we know we'll have clobbered them if we interrupt the main TLB miss
+ * handlers in which case we probably want to do a full restart at level
+ * 0 rather than saving / restoring the MAS.
+ *
+ * Note: If we care about performance of that core, we can easily shuffle
+ *       a few things around
+ */
+tlb_load_linear:
+	/* For now, we assume the linear mapping is contiguous and stops at
+	 * linear_map_top. We also assume the size is a multiple of 1G, thus
+	 * we only use 1G pages for now. That might have to be changed in a
+	 * final implementation, especially when dealing with hypervisors
+	 */
+	ld	r11,PACATOC(r13)
+	ld	r11,linear_map_top@got(r11)
+	ld	r10,0(r11)
+	cmpld	cr0,r10,r16
+	bge	tlb_load_linear_fault
+
+	/* MAS1 need whole new setup. */
+	li	r15,(BOOK3E_PAGESZ_1GB<<SPRN_MAS1_TSIZE_SHIFT)
+	oris	r15,r15,SPRN_MAS1_V@h	/* MAS1 needs V and TSIZE */
+	mtspr	SPRN_MAS1,r15
+
+	/* Already somebody there ? */
+	PPC_TLBSRX_DOT(0,r16)
+	beq	tlb_load_linear_done
+
+	/* Now we build the remaining MAS. MAS0 and 2 should be fine
+	 * with their defaults, which leaves us with MAS 3 and 7. The
+	 * mapping is linear, so we just take the address, clear the
+	 * region bits, and or in the permission bits which are currently
+	 * hard wired
+	 */
+	clrrdi	r10,r16,30		/* 1G page index */
+	clrldi	r10,r10,4		/* clear region bits */
+	ori	r10,r10,SPRN_MAS3_SR|SPRN_MAS3_SW|SPRN_MAS3_SX
+	mtspr	SPRN_MAS7_MAS3,r10
+
+	tlbwe
+
+tlb_load_linear_done:
+	/* We use the "error" epilog for success as we do want to
+	 * restore to the initial faulting context, whatever it was.
+	 * We do that because we can't resume a fault within a TLB
+	 * miss handler, due to MAS and TLB reservation being clobbered.
+	 */
+	TLB_MISS_STATS_X(MMSTAT_TLB_MISS_LINEAR)
+	TLB_MISS_EPILOG_ERROR
+	rfi
+
+tlb_load_linear_fault:
+	/* We keep the DEAR and ESR around, this shouldn't have happened */
+	cmpdi	cr0,r14,-1
+	beq	1f
+	TLB_MISS_EPILOG_ERROR_SPECIAL
+	b	exc_data_storage_book3e
+1:	TLB_MISS_EPILOG_ERROR_SPECIAL
+	b	exc_instruction_storage_book3e
+
+
+#ifdef CONFIG_BOOK3E_MMU_TLB_STATS
+.tlb_stat_inc:
+1:	ldarx	r8,0,r9
+	addi	r8,r8,1
+	stdcx.	r8,0,r9
+	bne-	1b
+	blr
+#endif
Index: linux-work/arch/powerpc/kernel/exceptions-64e.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/kernel/exceptions-64e.S	2009-06-03 16:18:23.000000000 +1000
@@ -0,0 +1,794 @@
+/*
+ *  Boot code and exception vectors for Book3E processors
+ *
+ *  Copyright (C) 2007 Ben. Herrenschmidt (benh@kernel.crashing.org), IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/threads.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cputable.h>
+#include <asm/setup.h>
+#include <asm/thread_info.h>
+#include <asm/reg.h>
+#include <asm/exception-64e.h>
+#include <asm/bug.h>
+#include <asm/irqflags.h>
+#include <asm/ptrace.h>
+#include <asm/ppc-opcode.h>
+#include <asm/mmu.h>
+
+/* XXX This will ultimately add space for a special exception save
+ *     structure used to save things like SRR0/SRR1, SPRGs, MAS, etc...
+ *     when taking special interrupts. For now we don't support that,
+ *     special interrupts from within a non-standard level will probably
+ *     blow you up
+ */
+#define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
+
+/* Exception prolog code for all exceptions */
+#define EXCEPTION_PROLOG(n, type, addition)				    \
+	mtspr	SPRN_SPRG_##type,r13;	/* get spare registers */	    \
+	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
+	std	r10,PACA_EX##type+EX_R10(r13);				    \
+	std	r11,PACA_EX##type+EX_R11(r13);				    \
+	mfcr	r10;			/* save CR */			    \
+	addition;			/* additional code for that exc. */ \
+	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
+	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
+	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
+	type##_SET_KSTACK;		/* get special stack if necessary */\
+	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
+	beq	1f;			/* branch around if supervisor */   \
+	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
+1:	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
+	bge-	cr1,exc_##n##_bad_stack;/* bad stack (TODO: out of line) */ \
+	mfspr	r10,SPRN_##type##_SRR0;	/* read SRR0 before touching stack */
+
+/* Exception type-specific macros */
+#define	GEN_SET_KSTACK							    \
+	subi	r1,r1,INT_FRAME_SIZE;	/* alloc frame on kernel stack */
+#define SPRN_GEN_SRR0	SPRN_SRR0
+#define SPRN_GEN_SRR1	SPRN_SRR1
+
+#define CRIT_SET_KSTACK						            \
+	ld	r1,PACA_CRIT_STACK(r13);				    \
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+#define SPRN_CRIT_SRR0	SPRN_CSRR0
+#define SPRN_CRIT_SRR1	SPRN_CSRR1
+
+#define DBG_SET_KSTACK						            \
+	ld	r1,PACA_DBG_STACK(r13);					    \
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+#define SPRN_DBG_SRR0	SPRN_DSRR0
+#define SPRN_DBG_SRR1	SPRN_DSRR1
+
+#define MC_SET_KSTACK						            \
+	ld	r1,PACA_MC_STACK(r13);					    \
+	subi	r1,r1,SPECIAL_EXC_FRAME_SIZE;
+#define SPRN_MC_SRR0	SPRN_MCSRR0
+#define SPRN_MC_SRR1	SPRN_MCSRR1
+
+#define NORMAL_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, GEN, addition##_GEN)
+
+#define CRIT_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, CRIT, addition##_CRIT)
+
+#define DBG_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, DBG, addition##_DBG)
+
+#define MC_EXCEPTION_PROLOG(n, addition)				    \
+	EXCEPTION_PROLOG(n, MC, addition##_MC)
+
+
+/* Variants of the "addition" argument for the prolog
+ */
+#define PROLOG_ADDITION_NONE_GEN
+#define PROLOG_ADDITION_NONE_CRIT
+#define PROLOG_ADDITION_NONE_DBG
+#define PROLOG_ADDITION_NONE_MC
+
+#define PROLOG_ADDITION_MASKABLE_GEN					    \
+	lbz	r11,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
+	cmpwi	cr0,r11,0;		/* yes -> go out of line */	    \
+	beq	masked_interrupt_book3e;
+
+#define PROLOG_ADDITION_2REGS_GEN					    \
+	std	r14,PACA_EXGEN+EX_R14(r13);				    \
+	std	r15,PACA_EXGEN+EX_R15(r13)
+
+#define PROLOG_ADDITION_1REG_GEN					    \
+	std	r14,PACA_EXGEN+EX_R14(r13);
+
+#define PROLOG_ADDITION_2REGS_CRIT					    \
+	std	r14,PACA_EXCRIT+EX_R14(r13);				    \
+	std	r15,PACA_EXCRIT+EX_R15(r13)
+
+#define PROLOG_ADDITION_2REGS_DBG					    \
+	std	r14,PACA_EXDBG+EX_R14(r13);				    \
+	std	r15,PACA_EXDBG+EX_R15(r13)
+
+#define PROLOG_ADDITION_2REGS_MC					    \
+	std	r14,PACA_EXMC+EX_R14(r13);				    \
+	std	r15,PACA_EXMC+EX_R15(r13)
+
+/* Core exception code for all exceptions except TLB misses.
+ * XXX: Needs to make SPRN_SPRG_GEN depend on exception type
+ */
+#define EXCEPTION_COMMON(n, excf, ints)					    \
+	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
+	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe */    \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe */	    \
+	std	r9,GPR9(r1);		/* save r9 in stackframe */	    \
+	std	r10,_NIP(r1);		/* save SRR0 to stackframe */	    \
+	std	r11,_MSR(r1);		/* save SRR1 to stackframe */	    \
+	ACCOUNT_CPU_USER_ENTRY(r10,r11);/* accounting (uses cr0+eq) */	    \
+	ld	r3,excf+EX_R10(r13);	/* get back r10 */		    \
+	ld	r4,excf+EX_R11(r13);	/* get back r11 */		    \
+	mfspr	r5,SPRN_SPRG_GEN;	/* get back r13 */		    \
+	std	r12,GPR12(r1);		/* save r12 in stackframe */	    \
+	ld	r2,PACATOC(r13);	/* get kernel TOC into r2 */	    \
+	mflr	r6;			/* save LR in stackframe */	    \
+	mfctr	r7;			/* save CTR in stackframe */	    \
+	mfspr	r8,SPRN_XER;		/* save XER in stackframe */	    \
+	ld	r9,excf+EX_R1(r13);	/* load orig r1 back from PACA */   \
+	lwz	r10,excf+EX_CR(r13);	/* load orig CR back from PACA	*/  \
+	lbz	r11,PACASOFTIRQEN(r13);	/* get current IRQ softe */	    \
+	ld	r12,exception_marker@toc(r2);				    \
+	li	r0,0;							    \
+	std	r3,GPR10(r1);		/* save r10 to stackframe */	    \
+	std	r4,GPR11(r1);		/* save r11 to stackframe */	    \
+	std	r5,GPR13(r1);		/* save it to stackframe */	    \
+	std	r6,_LINK(r1);						    \
+	std	r7,_CTR(r1);						    \
+	std	r8,_XER(r1);						    \
+	li	r3,(n)+1;		/* indicate partial regs in trap */ \
+	std	r9,0(r1);		/* store stack frame back link */   \
+	std	r10,_CCR(r1);		/* store orig CR in stackframe */   \
+	std	r9,GPR1(r1);		/* store stack frame back link */   \
+	std	r11,SOFTE(r1);		/* and save it to stackframe */     \
+	std	r12,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame */	    \
+	std	r3,_TRAP(r1);		/* set trap number		*/  \
+	std	r0,RESULT(r1);		/* clear regs->result */	    \
+	ints;
+
+/* Variants for the "ints" argument */
+#define INTS_KEEP
+#define INTS_DISABLE_SOFT						    \
+	stb	r0,PACASOFTIRQEN(r13);	/* mark interrupts soft-disabled */ \
+	TRACE_DISABLE_INTS;
+#define INTS_DISABLE_HARD						    \
+	stb	r0,PACAHARDIRQEN(r13); /* and hard disabled */
+#define INTS_DISABLE_ALL						    \
+	INTS_DISABLE_SOFT						    \
+	INTS_DISABLE_HARD
+
+/* This is called by exceptions that used INTS_KEEP (that is did not clear
+ * neither soft nor hard IRQ indicators in the PACA. This will restore MSR:EE
+ * to it's previous value
+ *
+ * XXX In the long run, we may want to open-code it in order to separate the
+ *     load from the wrtee, thus limiting the latency caused by the dependency
+ *     but at this point, I'll favor code clarity until we have a near to final
+ *     implementation
+ */
+#define INTS_RESTORE_HARD						    \
+	ld	r11,_MSR(r1);						    \
+	wrtee	r11;
+
+/* XXX FIXME: Restore r14/r15 when necessary */
+#define BAD_STACK_TRAMPOLINE(n)						    \
+exc_##n##_bad_stack:							    \
+	li	r1,(n);			/* get exception number */	    \
+	sth	r1,PACA_TRAP_SAVE(r13);	/* store trap */		    \
+	b	bad_stack_book3e;	/* bad stack error */
+
+#define	EXCEPTION_STUB(loc, label)					\
+	. = interrupt_base_book3e + loc;				\
+	nop;	/* To make debug interrupts happy */			\
+	b	exc_##label##_book3e;
+
+#define ACK_NONE(r)
+#define ACK_DEC(r)							\
+	lis	r,TSR_DIS@h;						\
+	mtspr	SPRN_TSR,r
+#define ACK_FIT(r)							\
+	lis	r,TSR_FIS@h;						\
+	mtspr	SPRN_TSR,r
+
+#define MASKABLE_EXCEPTION(trapnum, label, hdlr, ack)			\
+	START_EXCEPTION(label);						\
+	NORMAL_EXCEPTION_PROLOG(trapnum, PROLOG_ADDITION_MASKABLE)	\
+	EXCEPTION_COMMON(trapnum, PACA_EXGEN, INTS_DISABLE_ALL)		\
+	ack(r8);							\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;				\
+	bl	hdlr;							\
+	b	.ret_from_except_lite;
+
+/* This value is used to mark exception frames on the stack. */
+	.section	".toc","aw"
+exception_marker:
+	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
+
+
+/*
+ * And here we have the exception vectors !
+ */
+
+	.text
+	.balign	0x1000
+	.globl interrupt_base_book3e
+interrupt_base_book3e:					/* fake trap */
+	/* Note: If real debug exceptions are supported by the HW, the vector
+	 * below will have to be patched up to point to an appropriate handler
+	 */
+	EXCEPTION_STUB(0x000, machine_check)		/* 0x0200 */
+	EXCEPTION_STUB(0x020, critical_input)		/* 0x0580 */
+	EXCEPTION_STUB(0x040, debug_crit)		/* 0x0d00 */
+	EXCEPTION_STUB(0x060, data_storage)		/* 0x0300 */
+	EXCEPTION_STUB(0x080, instruction_storage)	/* 0x0400 */
+	EXCEPTION_STUB(0x0a0, external_input)		/* 0x0500 */
+	EXCEPTION_STUB(0x0c0, alignment)		/* 0x0600 */
+	EXCEPTION_STUB(0x0e0, program)			/* 0x0700 */
+	EXCEPTION_STUB(0x100, fp_unavailable)		/* 0x0800 */
+	EXCEPTION_STUB(0x120, system_call)		/* 0x0c00 */
+	EXCEPTION_STUB(0x140, ap_unavailable)		/* 0x0f20 */
+	EXCEPTION_STUB(0x160, decrementer)		/* 0x0900 */
+	EXCEPTION_STUB(0x180, fixed_interval)		/* 0x0980 */
+	EXCEPTION_STUB(0x1a0, watchdog)			/* 0x09f0 */
+	EXCEPTION_STUB(0x1c0, data_tlb_miss)
+	EXCEPTION_STUB(0x1e0, instruction_tlb_miss)
+
+#if 0
+	EXCEPTION_STUB(0x280, processor_doorbell)
+	EXCEPTION_STUB(0x220, processor_doorbell_crit)
+#endif
+	.globl interrupt_end_book3e
+interrupt_end_book3e:
+
+/* Critical Input Interrupt */
+	START_EXCEPTION(critical_input);
+	CRIT_EXCEPTION_PROLOG(0x100, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x100, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	bl	special_reg_save_crit
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.critical_exception
+//	b	ret_from_crit_except
+	b	.
+
+/* Machine Check Interrupt */
+	START_EXCEPTION(machine_check);
+	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE_ALL)
+//	bl	special_reg_save_mc
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.machine_check_exception
+//	b	ret_from_mc_except
+	b	.
+
+/* Data Storage Interrupt */
+	START_EXCEPTION(data_storage)
+	NORMAL_EXCEPTION_PROLOG(0x300, PROLOG_ADDITION_2REGS)
+	mfspr	r14,SPRN_DEAR
+	mfspr	r15,SPRN_ESR
+	EXCEPTION_COMMON(0x300, PACA_EXGEN, INTS_KEEP)
+	b	storage_fault_common
+
+/* Instruction Storage Interrupt */
+	START_EXCEPTION(instruction_storage);
+	NORMAL_EXCEPTION_PROLOG(0x400, PROLOG_ADDITION_2REGS)
+	li	r15,0
+	mr	r14,r10
+	EXCEPTION_COMMON(0x400, PACA_EXGEN, INTS_KEEP)
+	b	storage_fault_common
+
+/* External Input Interrupt */
+	MASKABLE_EXCEPTION(0x500, external_input, .do_IRQ, ACK_NONE)
+
+/* Alignment */
+	START_EXCEPTION(alignment);
+	NORMAL_EXCEPTION_PROLOG(0x600, PROLOG_ADDITION_2REGS)
+	mfspr	r14,SPRN_DEAR
+	mfspr	r15,SPRN_ESR
+	EXCEPTION_COMMON(0x600, PACA_EXGEN, INTS_KEEP)
+	b	alignment_more	/* no room, go out of line */
+
+/* Program Interrupt */
+	START_EXCEPTION(program);
+	NORMAL_EXCEPTION_PROLOG(0x700, PROLOG_ADDITION_1REG)
+	mfspr	r14,SPRN_ESR
+	EXCEPTION_COMMON(0x700, PACA_EXGEN, INTS_DISABLE_SOFT)
+	std	r14,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	ld	r14,PACA_EXGEN+EX_R14(r13)
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.program_check_exception
+	b	.ret_from_except
+
+/* Floating Point Unavailable Interrupt */
+	START_EXCEPTION(fp_unavailable);
+	NORMAL_EXCEPTION_PROLOG(0x800, PROLOG_ADDITION_NONE)
+	/* we can probably do a shorter exception entry for that one... */
+	EXCEPTION_COMMON(0x800, PACA_EXGEN, INTS_KEEP)
+	bne	1f			/* if from user, just load it up */
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	INTS_RESTORE_HARD
+	bl	.kernel_fp_unavailable_exception
+	BUG_OPCODE
+1:	ld	r12,_MSR(r1)
+	bl	.load_up_fpu
+	b	fast_exception_return
+
+/* Decrementer Interrupt */
+	MASKABLE_EXCEPTION(0x900, decrementer, .timer_interrupt, ACK_DEC)
+
+/* Fixed Interval Timer Interrupt */
+	MASKABLE_EXCEPTION(0x980, fixed_interval, .unknown_exception, ACK_FIT)
+
+/* Watchdog Timer Interrupt */
+	START_EXCEPTION(watchdog);
+	CRIT_EXCEPTION_PROLOG(0x9f0, PROLOG_ADDITION_NONE)
+//	EXCEPTION_COMMON(0x9f0, PACA_EXCRIT, INTS_DISABLE_ALL)
+//	bl	special_reg_save_crit
+//	addi	r3,r1,STACK_FRAME_OVERHEAD
+//	bl	.unknown_exception
+//	b	ret_from_crit_except
+	b	.
+
+/* System Call Interrupt */
+	START_EXCEPTION(system_call)
+	mr	r9,r13			/* keep a copy of userland r13 */
+	mfspr	r11,SPRN_SRR0		/* get return address */
+	mfspr	r12,SPRN_SRR1		/* get previous MSR */
+	mfspr	r13,SPRN_SPRG_PACA	/* get our PACA */
+	b	system_call_common
+
+/* Auxillary Processor Unavailable Interrupt */
+	START_EXCEPTION(ap_unavailable);
+	NORMAL_EXCEPTION_PROLOG(0xf20, PROLOG_ADDITION_NONE)
+	EXCEPTION_COMMON(0xf20, PACA_EXGEN, INTS_KEEP)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.unknown_exception
+	b	.ret_from_except
+
+/* Debug exception as a critical interrupt*/
+	START_EXCEPTION(debug_crit);
+	CRIT_EXCEPTION_PROLOG(0xd00, PROLOG_ADDITION_2REGS)
+
+	/*
+	 * If there is a single step or branch-taken exception in an
+	 * exception entry sequence, it was probably meant to apply to
+	 * the code where the exception occurred (since exception entry
+	 * doesn't turn off DE automatically).  We simulate the effect
+	 * of turning off DE on entry to an exception handler by turning
+	 * off DE in the CSRR1 value and clearing the debug status.
+	 */
+
+	mfspr	r14,SPRN_DBSR		/* check single-step/branch taken */
+	andis.	r15,r14,DBSR_IC@h
+	beq+	1f
+
+	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
+	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
+	cmpld	cr0,r10,r14
+	cmpld	cr1,r10,r15
+	blt+	cr0,1f
+	bge+	cr1,1f
+
+	/* here it looks like we got an inappropriate debug exception. */
+	lis	r14,DBSR_IC@h		/* clear the IC event */
+	rlwinm	r11,r11,0,~MSR_DE	/* clear DE in the CSRR1 value */
+	mtspr	SPRN_DBSR,r14
+	mtspr	SPRN_CSRR1,r11
+	lwz	r10,PACA_EXCRIT+EX_CR(r13)	/* restore registers */
+	ld	r1,PACA_EXCRIT+EX_R1(r13)
+	ld	r14,PACA_EXCRIT+EX_R14(r13)
+	ld	r15,PACA_EXCRIT+EX_R15(r13)
+	mtcr	r10
+	ld	r10,PACA_EXCRIT+EX_R10(r13)	/* restore registers */
+	ld	r11,PACA_EXCRIT+EX_R11(r13)
+	mfspr	r13,SPRN_SPRG_CRIT
+	rfci
+
+	/* Normal debug exception */
+	/* XXX We only handle coming from userspace for now since we can't
+	 *     quite save properly an interrupted kernel state yet
+	 */
+1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
+	beq	kernel_dbg_exc;		/* if from kernel mode */
+
+	/* Now we mash up things to make it look like we are coming on a
+	 * normal exception
+	 */
+	mfspr	r15,SPRN_SPRG_CRIT
+	mtspr	SPRN_SPRG_GEN,r15
+	mfspr	r14,SPRN_DBSR
+	EXCEPTION_COMMON(0xd00, PACA_EXCRIT, INTS_DISABLE_ALL)
+	std	r14,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mr	r4,r14
+	ld	r14,PACA_EXCRIT+EX_R14(r13)
+	ld	r15,PACA_EXCRIT+EX_R15(r13)
+	bl	.save_nvgprs
+	bl	.DebugException
+	b	.ret_from_except
+
+kernel_dbg_exc:
+	b	.	/* NYI */
+
+
+/*
+ * An interrupt came in while soft-disabled; clear EE in SRR1,
+ * clear paca->hard_enabled and return.
+ */
+masked_interrupt_book3e:
+	mtcr	r10
+	stb	r11,PACAHARDIRQEN(r13)
+	mfspr	r10,SPRN_SRR1
+	rldicl	r11,r10,48,1		/* clear MSR_EE */
+	rotldi	r10,r11,16
+	mtspr	SPRN_SRR1,r10
+	ld	r10,PACA_EXGEN+EX_R10(r13);	/* restore registers */
+	ld	r11,PACA_EXGEN+EX_R11(r13);
+	mfspr	r13,SPRN_SPRG_GEN;
+	rfi
+	b	.
+
+/*
+ * This is called from 0x300 and 0x400 handlers after the prologs with
+ * r14 and r15 containing the fault address and error code, with the
+ * original values stashed away in the PACA
+ */
+storage_fault_common:
+	std	r14,_DAR(r1)
+	std	r15,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mr	r4,r14
+	mr	r5,r15
+	ld	r14,PACA_EXGEN+EX_R14(r13)
+	ld	r15,PACA_EXGEN+EX_R15(r13)
+	INTS_RESTORE_HARD
+	bl	.do_page_fault
+	cmpdi	r3,0
+	bne-	1f
+	b	.ret_from_except_lite
+1:	bl	.save_nvgprs
+	mr	r5,r3
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	ld	r4,_DAR(r1)
+	bl	.bad_page_fault
+	b	.ret_from_except
+
+/*
+ * Alignment exception doesn't fit entirely in the 0x100 bytes so it
+ * continues here.
+ */
+alignment_more:
+	std	r14,_DAR(r1)
+	std	r15,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	ld	r14,PACA_EXGEN+EX_R14(r13)
+	ld	r15,PACA_EXGEN+EX_R15(r13)
+	bl	.save_nvgprs
+	INTS_RESTORE_HARD
+	bl	.alignment_exception
+	b	.ret_from_except
+
+/*
+ * We branch here from entry_64.S for the last stage of the exception
+ * return code path. MSR:EE is expected to be off at that point
+ */
+_GLOBAL(exception_return_book3e)
+	b	1f
+
+/* This is the return from load_up_fpu fast path which could do with
+ * less GPR restores in fact, but for now we have a single return path
+ */
+	.globl fast_exception_return
+fast_exception_return:
+	wrteei	0
+1:	mr	r0,r13
+	ld	r10,_MSR(r1)
+	REST_4GPRS(2, r1)
+	andi.	r6,r10,MSR_PR
+	REST_2GPRS(6, r1)
+	beq	1f
+	ACCOUNT_CPU_USER_EXIT(r10, r11)
+	ld	r0,GPR13(r1)
+
+1:	stdcx.	r0,0,r1		/* to clear the reservation */
+
+	ld	r8,_CCR(r1)
+	ld	r9,_LINK(r1)
+	ld	r10,_CTR(r1)
+	ld	r11,_XER(r1)
+	mtcr	r8
+	mtlr	r9
+	mtctr	r10
+	mtxer	r11
+	REST_2GPRS(8, r1)
+	ld	r10,GPR10(r1)
+	ld	r11,GPR11(r1)
+	ld	r12,GPR12(r1)
+	mtspr	SPRN_SPRG_GEN,r0
+
+	std	r10,PACA_EXGEN+EX_R10(r13);
+	std	r11,PACA_EXGEN+EX_R11(r13);
+	ld	r10,_NIP(r1)
+	ld	r11,_MSR(r1)
+	ld	r0,GPR0(r1)
+	ld	r1,GPR1(r1)
+	mtspr	SPRN_SRR0,r10
+	mtspr	SPRN_SRR1,r11
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	mfspr	r13,SPRN_SPRG_GEN
+	rfi
+
+/*
+ * Trampolines used when spotting a bad kernel stack pointer in
+ * the exception entry code.
+ *
+ * TODO: move some bits like SRR0 read to trampoline, pass PACA
+ * index around, etc... to handle crit & mcheck
+ */
+BAD_STACK_TRAMPOLINE(0x000)
+BAD_STACK_TRAMPOLINE(0x100)
+BAD_STACK_TRAMPOLINE(0x200)
+BAD_STACK_TRAMPOLINE(0x300)
+BAD_STACK_TRAMPOLINE(0x400)
+BAD_STACK_TRAMPOLINE(0x500)
+BAD_STACK_TRAMPOLINE(0x600)
+BAD_STACK_TRAMPOLINE(0x700)
+BAD_STACK_TRAMPOLINE(0x800)
+BAD_STACK_TRAMPOLINE(0x900)
+BAD_STACK_TRAMPOLINE(0x980)
+BAD_STACK_TRAMPOLINE(0x9f0)
+BAD_STACK_TRAMPOLINE(0xa00)
+BAD_STACK_TRAMPOLINE(0xb00)
+BAD_STACK_TRAMPOLINE(0xc00)
+BAD_STACK_TRAMPOLINE(0xd00)
+BAD_STACK_TRAMPOLINE(0xe00)
+BAD_STACK_TRAMPOLINE(0xf00)
+BAD_STACK_TRAMPOLINE(0xf20)
+
+	.globl	bad_stack_book3e
+bad_stack_book3e:
+	mfspr	r10,SPRN_SRR0;		  /* read SRR0 before touching stack */
+	ld	r1,PACAEMERGSP(r13)
+	subi	r1,r1,64+INT_FRAME_SIZE
+	std	r10,_NIP(r1)
+	std	r11,_MSR(r1)
+	ld	r10,PACA_EXGEN+EX_R1(r13) /* FIXME for crit & mcheck */
+	lwz	r11,PACA_EXGEN+EX_CR(r13) /* FIXME for crit & mcheck */
+	std	r10,GPR1(r1)
+	std	r11,_CCR(r1)
+	mfspr	r10,SPRN_DEAR
+	mfspr	r11,SPRN_ESR
+	std	r10,_DAR(r1)
+	std	r11,_DSISR(r1)
+	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
+	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe */    \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe */	    \
+	std	r9,GPR9(r1);		/* save r9 in stackframe */	    \
+	ld	r3,PACA_EXGEN+EX_R10(r13);/* get back r10 */		    \
+	ld	r4,PACA_EXGEN+EX_R11(r13);/* get back r11 */		    \
+	mfspr	r5,SPRN_SPRG_GEN;	/* get back r13 XXX can be wrong */ \
+	std	r3,GPR10(r1);		/* save r10 to stackframe */	    \
+	std	r4,GPR11(r1);		/* save r11 to stackframe */	    \
+	std	r12,GPR12(r1);		/* save r12 in stackframe */	    \
+	std	r5,GPR13(r1);		/* save it to stackframe */	    \
+	mflr	r10
+	mfctr	r11
+	mfxer	r12
+	std	r10,_LINK(r1)
+	std	r11,_CTR(r1)
+	std	r12,_XER(r1)
+	SAVE_10GPRS(14,r1)
+	SAVE_8GPRS(24,r1)
+	lhz	r12,PACA_TRAP_SAVE(r13)
+	std	r12,_TRAP(r1)
+	addi	r11,r1,INT_FRAME_SIZE
+	std	r11,0(r1)
+	li	r12,0
+	std	r12,0(r11)
+	ld	r2,PACATOC(r13)
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.kernel_bad_stack
+	b	1b
+
+/*
+ * Setup the initial TLB for a core. This current implementation
+ * assume that whatever we are running off will not conflict with
+ * the new mapping at PAGE_OFFSET.
+ * We also make various assumptions about the processor we run on,
+ * this might have to be made more flexible based on the content
+ * of MMUCFG and friends.
+ */
+_GLOBAL(initial_tlb_book3e)
+
+	/* Setup MAS 0,1,2,3 and 7 for tlbwe of a 1G entry that maps the
+	 * kernel linear mapping. We also set MAS8 once for all here though
+	 * that will have to be made dependent on whether we are running under
+	 * a hypervisor I suppose.
+	 */
+	li	r3,SPRN_MAS0_HES | SPRN_MAS0_WQ_ALLWAYS
+	mtspr	SPRN_MAS0,r3
+	lis	r3,(SPRN_MAS1_V | SPRN_MAS1_IPROT)@h
+	ori	r3,r3,BOOK3E_PAGESZ_1GB << SPRN_MAS1_TSIZE_SHIFT
+	mtspr	SPRN_MAS1,r3
+	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET | SPRN_MAS2_M)
+	mtspr	SPRN_MAS2,r3
+	li	r3,SPRN_MAS3_SR | SPRN_MAS3_SW | SPRN_MAS3_SX
+	mtspr	SPRN_MAS7_MAS3,r3
+	li	r3,0
+	mtspr	SPRN_MAS8,r3
+
+	/* Write the TLB entry */
+	tlbwe
+
+	/* Now we branch the new virtual address mapped by this entry */
+	LOAD_REG_IMMEDIATE(r3,1f)
+	mtctr	r3
+	bctr
+
+1:	/* We are now running at PAGE_OFFSET, clean the TLB of everything
+	 * else (XXX we should scan for bolted crap from the firmware too)
+	 */
+	PPC_TLBILX(0,0,0)
+	sync
+	isync
+
+	/* We translate LR and return */
+	mflr	r3
+	tovirt(r3,r3)
+	mtlr	r3
+	blr
+
+/*
+ * Main entry (boot CPU, thread 0)
+ *
+ * We enter here from head_64.S, possibly after the prom_init trampoline
+ * with r3 and r4 already saved to r31 and 30 respectively and in 64 bits
+ * mode. Anything else is as it was left by the bootloader
+ *
+ * Initial requirements of this port:
+ *
+ * - Kernel loaded at 0 physical
+ * - A good lump of memory mapped 0:0 by UTLB entry 0
+ * - MSR:IS & MSR:DS set to 0
+ *
+ * Note that some of the above requirements will be relaxed in the future
+ * as the kernel becomes smarter at dealing with different initial conditions
+ * but for now you have to be careful
+ */
+_GLOBAL(start_initialization_book3e)
+	mflr	r28
+
+	/* First, we need to setup some initial TLBs to map the kernel
+	 * text, data and bss at PAGE_OFFSET. We don't have a real mode
+	 * and always use AS 0, so we just set it up to match our link
+	 * address and never use 0 based addresses.
+	 */
+	bl	.initial_tlb_book3e
+
+	/* Init global core bits */
+	bl	.init_core_book3e
+
+	/* Init per-thread bits */
+	bl	.init_thread_book3e
+
+	/* Return to common init code */
+	tovirt(r28,r28)
+	mtlr	r28
+	blr
+
+
+/*
+ * Secondary core/processor entry
+ *
+ * This is entered for thread 0 of a secondary core, all other threads
+ * are expected to be stopped. It's similar to start_initialization_book3e
+ * except that it's generally entered from the holding loop in head_64.S
+ * after CPUs have been gathered by Open Firmware.
+ *
+ * We assume we are in 32 bits mode running with whatever TLB entry was
+ * set for us by the firmware or POR engine.
+ */
+_GLOBAL(book3e_secondary_core_init_64bit)
+	li	r4,1
+	b	.generic_secondary_smp_init
+
+_GLOBAL(book3e_secondary_core_init)
+	mflr	r28
+	mr	r24,r3
+	cmplwi	r4,0
+	bne	2f
+
+	/* Setup TLB for this core */
+	bl	.initial_tlb_book3e
+
+		/* get the TOC pointer (virtual address) */
+	bl	.relative_toc
+
+	/* Init global core bits */
+2:	bl	.init_core_book3e
+
+	/* Init per-thread bits */
+	bl	.init_thread_book3e
+
+	/* Return to common init code */
+	tovirt(r28,r28)
+	mtlr	r28
+	blr
+
+/*
+ * Secondary thread entry
+ *
+ * This is entered in 32 bits mode, we are mapped by a temporary
+ * ERAT entry covering that thread only that we need to get rid of.
+ * r3 contains our linux CPU number. We are getting in here via RTAS
+ * with the current implementation.
+ */
+_GLOBAL(book3e_secondary_thread_init_64bit)
+	mr	r24,r3
+	b	2f
+
+_GLOBAL(book3e_secondary_thread_init)
+	mr	r24,r3
+
+	/* Turn on 64-bit mode */
+	bl	.enable_64b_mode
+
+	/* We need to get away from our 32 bits address and jump to
+	 * the proper full 64 bits address
+	 */
+	LOAD_REG_IMMEDIATE(r3,1f)
+	mtctr	r3
+	bctr
+1:	isync
+
+	/* Init per-thread bits */
+2:	bl	.init_thread_book3e
+
+	/* Jump to common init code */
+	mr	r3,r24
+	b	.generic_secondary_smp_init
+
+
+_STATIC(init_core_book3e)
+	/* Establish the interrupt vector base */
+	LOAD_REG_IMMEDIATE(r3, interrupt_base_book3e)
+	mtspr	SPRN_IVPR,r3
+	sync
+	blr
+
+_STATIC(init_thread_book3e)
+	lis	r3,(SPRN_EPCR_ICM | SPRN_EPCR_GICM)@h
+	mtspr	SPRN_EPCR,r3
+
+	/* Make sure interrupts are off */
+	wrteei	0
+
+	/* disable watchdog and FIT and enable DEC interrupts */
+	lis	r3,TCR_DIE@h
+	mtspr	SPRN_TCR,r3
+
+	blr
+
+
+
Index: linux-work/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/ppc_asm.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/ppc_asm.h	2009-06-03 15:13:29.000000000 +1000
@@ -376,7 +376,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #endif
 
 
-#if defined(CONFIG_BOOKE)
+/* XXX Implement __toreal and __tovirt that can be used by Book3E 64-bit
+ * where it wants it to avoid having the ifdef CONFIG_PPC64 below
+ */
+#if defined(CONFIG_BOOKE) && !defined(CONFIG_PPC64)
 #define toreal(rd)
 #define fromreal(rd)
 
@@ -426,10 +429,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	.previous
 #endif
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 #define RFI		rfid
 #define MTMSRD(r)	mtmsrd	r
-
 #else
 #define FIX_SRR1(ra, rb)
 #ifndef CONFIG_40x
Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/head_64.S	2009-06-03 16:30:43.000000000 +1000
@@ -122,10 +122,11 @@ __run_at_load:
  */
 	.globl	__secondary_hold
 __secondary_hold:
+#ifndef CONFIG_PPC_BOOK3E
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
 	mtmsrd	r24			/* RI on */
-
+#endif
 	/* Grab our physical cpu number */
 	mr	r24,r3
 
@@ -144,6 +145,7 @@ __secondary_hold:
 	ld	r4,0(r4)		/* deref function descriptor */
 	mtctr	r4
 	mr	r3,r24
+	li	r4,0
 	bctr
 #else
 	BUG_OPCODE
@@ -172,13 +174,20 @@ exception_marker:
  */
 _GLOBAL(generic_secondary_smp_init)
 	mr	r24,r3
-	
+	mr	r25,r4
+
 	/* turn on 64-bit mode */
 	bl	.enable_64b_mode
 
 	/* get the TOC pointer (real address) */
 	bl	.relative_toc
 
+#ifdef CONFIG_PPC_BOOK3E
+	/* Book3E initialization */
+	mr	r3,r24
+	mr	r4,r25
+	bl	.book3e_secondary_core_init
+#endif
 	/* Set up a paca value for this processor. Since we have the
 	 * physical cpu id in r24, we need to search the pacas to find
 	 * which logical id maps to our physical one.
@@ -197,6 +206,11 @@ _GLOBAL(generic_secondary_smp_init)
 	b	.kexec_wait		/* next kernel might do better	 */
 
 2:	mtspr	SPRN_SPRG3,r13		/* Save vaddr of paca in SPRG3	 */
+#ifdef CONFIG_PPC_BOOK3E
+	addi	r12,r13,PACA_EXTLB	/* and TLB exc frame in SPRG2    */
+	mtspr	SPRN_SPRG2,r12
+#endif
+
 	/* From now on, r24 is expected to be logical cpuid */
 	mr	r24,r5
 3:	HMT_LOW
@@ -232,6 +246,7 @@ _GLOBAL(generic_secondary_smp_init)
  * Turn the MMU off.
  * Assumes we're mapped EA == RA if the MMU is on.
  */
+#ifdef CONFIG_PPC_BOOK3S
 _STATIC(__mmu_off)
 	mfmsr	r3
 	andi.	r0,r3,MSR_IR|MSR_DR
@@ -243,6 +258,7 @@ _STATIC(__mmu_off)
 	sync
 	rfid
 	b	.	/* prevent speculative execution */
+#endif
 
 
 /*
@@ -280,6 +296,10 @@ _GLOBAL(__start_initialization_multiplat
 	mr	r31,r3
 	mr	r30,r4
 
+#ifdef CONFIG_PPC_BOOK3E
+	bl	.start_initialization_book3e
+	b	.__after_prom_start
+#else
 	/* Setup some critical 970 SPRs before switching MMU off */
 	mfspr	r0,SPRN_PVR
 	srwi	r0,r0,16
@@ -297,6 +317,7 @@ _GLOBAL(__start_initialization_multiplat
 	/* Switch off MMU if not already off */
 	bl	.__mmu_off
 	b	.__after_prom_start
+#endif /* CONFIG_PPC_BOOK3E */
 
 _INIT_STATIC(__boot_from_prom)
 #ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
@@ -359,10 +380,16 @@ _STATIC(__after_prom_start)
  * Note: This process overwrites the OF exception vectors.
  */
 	li	r3,0			/* target addr */
+#ifdef CONFIG_PPC_BOOK3E
+	tovirt(r3,r3)			/* on booke, we already run at PAGE_OFFSET */
+#endif
 	mr.	r4,r26			/* In some cases the loader may  */
 	beq	9f			/* have already put us at zero */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
+#ifdef CONFIG_PPC_BOOK3E
+	tovirt(r6,r6)			/* on booke, we already run at PAGE_OFFSET */
+#endif
 
 #ifdef CONFIG_CRASH_DUMP
 /*
@@ -508,6 +535,9 @@ _GLOBAL(pmac_secondary_start)
  *   r13   = paca virtual address
  *   SPRG3 = paca virtual address
  */
+	.section ".text";
+	.align 2 ;
+
 	.globl	__secondary_start
 __secondary_start:
 	/* Set thread priority to MEDIUM */
@@ -544,7 +574,7 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISER
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	rfid
+	RFI
 	b	.	/* prevent speculative execution */
 
 /* 
@@ -565,11 +595,16 @@ _GLOBAL(start_secondary_prolog)
  */
 _GLOBAL(enable_64b_mode)
 	mfmsr	r11			/* grab the current MSR */
+#ifdef CONFIG_PPC_BOOK3E
+	oris	r11,r11,0x8000		/* CM bit set, we'll set ICM later */
+	mtmsr	r11
+#else /* CONFIG_PPC_BOOK3E */
 	li	r12,(MSR_SF | MSR_ISF)@highest
 	sldi	r12,r12,48
 	or	r11,r11,r12
 	mtmsrd	r11
 	isync
+#endif
 	blr
 
 /*
@@ -613,9 +648,11 @@ _INIT_STATIC(start_here_multiplatform)
 	bdnz	3b
 4:
 
+#ifndef CONFIG_PPC_BOOK3E
 	mfmsr	r6
 	ori	r6,r6,MSR_RI
 	mtmsrd	r6			/* RI on */
+#endif
 
 #ifdef CONFIG_RELOCATABLE
 	/* Save the physical address we're running at in kernstart_addr */
@@ -648,7 +685,7 @@ _INIT_STATIC(start_here_multiplatform)
 	ld	r4,PACAKMSR(r13)
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	rfid
+	RFI
 	b	.	/* prevent speculative execution */
 	
 	/* This is where all platforms converge execution */
Index: linux-work/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/entry_64.S	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/entry_64.S	2009-06-03 17:15:23.000000000 +1000
@@ -124,6 +124,15 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISER
 	ori	r11,r11,MSR_EE
 	mtmsrd	r11,1
 
+	/* Hard enable interrupts */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+#else
+	mfmsr	r11
+	ori	r11,r11,MSR_EE
+	mtmsrd	r11,1
+#endif /* CONFIG_PPC_BOOK3E */
+
 #ifdef SHOW_SYSCALLS
 	bl	.do_show_syscall
 	REST_GPR(0,r1)
@@ -168,15 +177,25 @@ syscall_exit:
 #endif
 	clrrdi	r12,r1,THREAD_SHIFT
 
-	/* disable interrupts so current_thread_info()->flags can't change,
-	   and so that we don't get interrupted after loading SRR0/1. */
 	ld	r8,_MSR(r1)
+#ifdef CONFIG_PPC_BOOK3S
+	/* No MSR:RI on BookE */
 	andi.	r10,r8,MSR_RI
 	beq-	unrecov_restore
+#endif
+
+	/* Disable interrupts so current_thread_info()->flags can't change,
+	 * and so that we don't get interrupted after loading SRR0/1.
+	 */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	0
+#else
 	mfmsr	r10
 	rldicl	r10,r10,48,1
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
+
 	ld	r9,TI_FLAGS(r12)
 	li	r11,-_LAST_ERRNO
 	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
@@ -194,9 +213,13 @@ syscall_error_cont:
 	 * userspace and we take an exception after restoring r13,
 	 * we end up corrupting the userspace r13 value.
 	 */
+#ifdef CONFIG_PPC_BOOK3S
+	/* No MSR:RI on BookE */
 	li	r12,MSR_RI
 	andc	r11,r10,r12
 	mtmsrd	r11,1			/* clear MSR.RI */
+#endif /* CONFIG_PPC_BOOK3S */
+
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
@@ -206,7 +229,7 @@ syscall_error_cont:
 	mtcr	r5
 	mtspr	SPRN_SRR0,r7
 	mtspr	SPRN_SRR1,r8
-	rfid
+	RFI
 	b	.	/* prevent speculative execution */
 
 syscall_error:	
@@ -276,9 +299,13 @@ syscall_exit_work:
 	beq	.ret_from_except_lite
 
 	/* Re-enable interrupts */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+#else
 	mfmsr	r10
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
 
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -380,7 +407,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	and.	r0,r0,r22
 	beq+	1f
 	andc	r22,r22,r0
-	mtmsrd	r22
+	MTMSRD(r22)
 	isync
 1:	std	r20,_NIP(r1)
 	mfcr	r23
@@ -399,6 +426,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
 
 	ld	r8,KSP(r4)	/* new stack pointer */
+#ifdef CONFIG_PPC_BOOK3S
 BEGIN_FTR_SECTION
   BEGIN_FTR_SECTION_NESTED(95)
 	clrrdi	r6,r8,28	/* get its ESID */
@@ -445,8 +473,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT
 	slbie	r6		/* Workaround POWER5 < DD2.1 issue */
 	slbmte	r7,r0
 	isync
-
 2:
+#endif /* !CONFIG_PPC_BOOK3S */
+
 	clrrdi	r7,r8,THREAD_SHIFT	/* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
 	   because we don't need to leave the 288-byte ABI gap at the
@@ -490,10 +519,14 @@ _GLOBAL(ret_from_except_lite)
 	 * can't change between when we test it and when we return
 	 * from the interrupt.
 	 */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	0
+#else
 	mfmsr	r10		/* Get current interrupt state */
 	rldicl	r9,r10,48,1	/* clear MSR_EE */
 	rotldi	r9,r9,16
 	mtmsrd	r9,1		/* Update machine state */
+#endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PREEMPT
 	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
@@ -531,6 +564,9 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_
 	rldicl	r4,r3,49,63		/* r0 = (r3 >> 15) & 1 */
 	stb	r4,PACAHARDIRQEN(r13)
 
+#ifdef CONFIG_PPC_BOOK3E
+	b	.exception_return_book3e
+#else
 	ld	r4,_CTR(r1)
 	ld	r0,_LINK(r1)
 	mtctr	r4
@@ -579,6 +615,8 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_
 	rfid
 	b	.	/* prevent speculative execution */
 
+#endif /* CONFIG_PPC_BOOK3E */
+
 iseries_check_pending_irqs:
 #ifdef CONFIG_PPC_ISERIES
 	ld	r5,SOFTE(r1)
@@ -629,6 +667,11 @@ do_work:
 	li	r0,1
 	stb	r0,PACASOFTIRQEN(r13)
 	stb	r0,PACAHARDIRQEN(r13)
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+	bl	.preempt_schedule
+	wrteei	0
+#else
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1		/* reenable interrupts */
 	bl	.preempt_schedule
@@ -637,6 +680,7 @@ do_work:
 	rldicl	r10,r10,48,1	/* disable interrupts again */
 	rotldi	r10,r10,16
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
@@ -645,8 +689,12 @@ do_work:
 user_work:
 #endif
 	/* Enable interrupts */
+#ifdef CONFIG_PPC_BOOK3E
+	wrteei	1
+#else
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
+#endif /* CONFIG_PPC_BOOK3E */
 
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	beq	1f
@@ -814,33 +862,25 @@ _GLOBAL(enter_prom)
 	 * of all registers that it saves.  We therefore save those registers
 	 * PROM might touch to the stack.  (r0, r3-r13 are caller saved)
    	 */
-	SAVE_8GPRS(2, r1)
+	SAVE_GPR(2, r1)
 	SAVE_GPR(13, r1)
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
-	mfcr	r4
-	std	r4,_CCR(r1)
-	mfctr	r5
-	std	r5,_CTR(r1)
-	mfspr	r6,SPRN_XER
-	std	r6,_XER(r1)
-	mfdar	r7
-	std	r7,_DAR(r1)
-	mfdsisr	r8
-	std	r8,_DSISR(r1)
-	mfsrr0	r9
-	std	r9,_SRR0(r1)
-	mfsrr1	r10
-	std	r10,_SRR1(r1)
+	mfcr	r10
 	mfmsr	r11
+	std	r10,_CCR(r1)
 	std	r11,_MSR(r1)
 
 	/* Get the PROM entrypoint */
-	ld	r0,GPR4(r1)
-	mtlr	r0
+	mtlr	r4
 
 	/* Switch MSR to 32 bits mode
 	 */
+#ifdef CONFIG_PPC_BOOK3E
+	oris	r11,r11,0x8000	/* XXX use rlwim */
+	xoris	r11,r11,0x8000
+	mtmsr	r11
+#else /* CONFIG_PPC_BOOK3E */
         mfmsr   r11
         li      r12,1
         rldicr  r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
@@ -849,10 +889,10 @@ _GLOBAL(enter_prom)
         rldicr  r12,r12,MSR_ISF_LG,(63-MSR_ISF_LG)
         andc    r11,r11,r12
         mtmsrd  r11
+#endif /* CONFIG_PPC_BOOK3E */
         isync
 
-	/* Restore arguments & enter PROM here... */
-	ld	r3,GPR3(r1)
+	/* Enter PROM here... */
 	blrl
 
 	/* Just make sure that r1 top 32 bits didn't get
@@ -862,7 +902,7 @@ _GLOBAL(enter_prom)
 
 	/* Restore the MSR (back to 64 bits) */
 	ld	r0,_MSR(r1)
-	mtmsrd	r0
+	MTMSRD(r0)
         isync
 
 	/* Restore other registers */
@@ -872,18 +912,6 @@ _GLOBAL(enter_prom)
 	REST_10GPRS(22, r1)
 	ld	r4,_CCR(r1)
 	mtcr	r4
-	ld	r5,_CTR(r1)
-	mtctr	r5
-	ld	r6,_XER(r1)
-	mtspr	SPRN_XER,r6
-	ld	r7,_DAR(r1)
-	mtdar	r7
-	ld	r8,_DSISR(r1)
-	mtdsisr	r8
-	ld	r9,_SRR0(r1)
-	mtsrr0	r9
-	ld	r10,_SRR1(r1)
-	mtsrr1	r10
 	
         addi	r1,r1,PROM_FRAME_SIZE
 	ld	r0,16(r1)
Index: linux-work/arch/powerpc/include/asm/mmu.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu.h	2009-06-03 15:57:15.000000000 +1000
@@ -17,6 +17,7 @@
 #define MMU_FTR_TYPE_40x		ASM_CONST(0x00000004)
 #define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
 #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
+#define MMU_FTR_TYPE_3E			ASM_CONST(0x00000020)
 
 /*
  * This is individual features
Index: linux-work/arch/powerpc/include/asm/paca.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/paca.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/paca.h	2009-06-03 15:13:29.000000000 +1000
@@ -14,9 +14,11 @@
 #define _ASM_POWERPC_PACA_H
 #ifdef __KERNEL__
 
-#include	<asm/types.h>
-#include	<asm/lppaca.h>
-#include	<asm/mmu.h>
+#include <asm/types.h>
+#include <asm/lppaca.h>
+#include <asm/mmu.h>
+#include <asm/page.h>
+#include <asm/exception-64e.h>
 
 register struct paca_struct *local_paca asm("r13");
 
@@ -91,6 +93,21 @@ struct paca_struct {
 	u16 slb_cache[SLB_CACHE_ENTRIES];
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
+#ifdef CONFIG_PPC_BOOK3E
+	pgd_t *pgd;			/* Current PGD */
+	pgd_t *kernel_pgd;		/* Kernel PGD */
+	u64 exgen[8] __attribute__((aligned(0x80)));
+	u64 extlb[EX_TLB_SIZE*3] __attribute__((aligned(0x80)));
+	u64 exmc[8];		/* used for machine checks */
+	u64 excrit[8];		/* used for crit interrupts */
+	u64 exdbg[8];		/* used for debug interrupts */
+
+	/* Kernel stack pointers for use by special exceptions */
+	void *mc_kstack;
+	void *crit_kstack;
+	void *dbg_kstack;
+#endif /* CONFIG_PPC_BOOK3E */
+
 	mm_context_t context;
 
 	/*
Index: linux-work/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/ppc-opcode.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/ppc-opcode.h	2009-06-03 16:00:05.000000000 +1000
@@ -48,6 +48,8 @@
 #define PPC_INST_TLBIE			0x7c000264
 #define PPC_INST_TLBILX			0x7c000024
 #define PPC_INST_WAIT			0x7c00007c
+#define PPC_INST_TLBIVAX		0x7c000624
+#define PPC_INST_TLBSRX_DOT		0x7c0006a5
 
 /* macros to insert fields into opcodes */
 #define __PPC_RA(a)	(((a) & 0x1f) << 16)
@@ -76,6 +78,10 @@
 					__PPC_WC(w))
 #define PPC_TLBIE(lp,a) 	stringify_in_c(.long PPC_INST_TLBIE | \
 					       __PPC_RB(a) | __PPC_RS(lp))
+#define PPC_TLBSRX_DOT(a,b)	stringify_in_c(.long PPC_INST_TLBSRX_DOT | \
+					__PPC_RA(a) | __PPC_RB(b))
+#define PPC_TLBIVAX(a,b)	stringify_in_c(.long PPC_INST_TLBIVAX | \
+					__PPC_RA(a) | __PPC_RB(b))
 
 /*
  * Define what the VSX XX1 form instructions will look like, then add
Index: linux-work/arch/powerpc/include/asm/tlbflush.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/tlbflush.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/tlbflush.h	2009-06-03 15:13:29.000000000 +1000
@@ -6,7 +6,7 @@
  *
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
- *  - local_flush_tlb_mm(mm) flushes the specified mm context on
+ *  - local_flush_tlb_mm(mm, full) flushes the specified mm context on
  *                           the local processor
  *  - local_flush_tlb_page(vma, vmaddr) flushes one page on the local processor
  *  - flush_tlb_page_nohash(vma, vmaddr) flushes one page if SW loaded TLB
@@ -29,7 +29,8 @@
  * specific tlbie's
  */
 
-#include <linux/mm.h>
+struct vm_area_struct;
+struct mm_struct;
 
 #define MMU_NO_CONTEXT      	((unsigned int)-1)
 
@@ -40,12 +41,18 @@ extern void flush_tlb_kernel_range(unsig
 extern void local_flush_tlb_mm(struct mm_struct *mm);
 extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
 
+extern void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+				   int psize, int ind);
+
 #ifdef CONFIG_SMP
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+			     int psize, int ind);
 #else
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
 #define flush_tlb_page(vma,addr)	local_flush_tlb_page(vma,addr)
+#define __flush_tlb_page(mm,addr,p,i)	__local_flush_tlb_page(mm,addr,p,i)
 #endif
 #define flush_tlb_page_nohash(vma,addr)	flush_tlb_page(vma,addr)
 
Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2009-06-03 15:13:29.000000000 +1000
@@ -52,9 +52,11 @@
 #include <linux/kvm_host.h>
 #endif
 
+#ifdef CONFIG_PPC32
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 #include "head_booke.h"
 #endif
+#endif
 
 #if defined(CONFIG_FSL_BOOKE)
 #include "../mm/mmu_decl.h"
@@ -137,6 +139,20 @@ int main(void)
 					    context.high_slices_psize));
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
 #endif /* CONFIG_PPC_MM_SLICES */
+
+#ifdef CONFIG_PPC_BOOK3E
+	DEFINE(PACAPGD, offsetof(struct paca_struct, pgd));
+	DEFINE(PACA_KERNELPGD, offsetof(struct paca_struct, kernel_pgd));
+	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
+	DEFINE(PACA_EXTLB, offsetof(struct paca_struct, extlb));
+	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
+	DEFINE(PACA_EXCRIT, offsetof(struct paca_struct, excrit));
+	DEFINE(PACA_EXDBG, offsetof(struct paca_struct, exdbg));
+	DEFINE(PACA_MC_STACK, offsetof(struct paca_struct, mc_kstack));
+	DEFINE(PACA_CRIT_STACK, offsetof(struct paca_struct, crit_kstack));
+	DEFINE(PACA_DBG_STACK, offsetof(struct paca_struct, dbg_kstack));
+#endif /* CONFIG_PPC_BOOK3E */
+
 #ifdef CONFIG_PPC_STD_MMU_64
 	DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
 	DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
@@ -259,6 +275,7 @@ int main(void)
 	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
 #endif /* CONFIG_PPC64 */
 
+#if defined(CONFIG_PPC32)
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	DEFINE(EXC_LVL_SIZE, STACK_EXC_LVL_FRAME_SIZE);
 	DEFINE(MAS0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
@@ -277,7 +294,7 @@ int main(void)
 	DEFINE(_DSRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, dsrr1));
 	DEFINE(SAVED_KSP_LIMIT, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, saved_ksp_limit));
 #endif
-
+#endif
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 
Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/cputable.c	2009-06-03 15:57:33.000000000 +1000
@@ -93,7 +93,7 @@ extern void __restore_cpu_power7(void);
 				 PPC_FEATURE_BOOKE)
 
 static struct cpu_spec __initdata cpu_specs[] = {
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 	{	/* Power3 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00400000,
@@ -508,7 +508,30 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_generic,
 		.platform		= "power4",
 	}
-#endif	/* CONFIG_PPC64 */
+#endif	/* CONFIG_PPC_BOOK3S_64 */
+#ifdef CONFIG_PPC_BOOK3E_64
+	{	/* This is a default entry to get going, to be replaced by
+		 * a real one at some stage
+		 */
+#define CPU_FTRS_BASE_BOOK3E	(CPU_FTR_USE_TB | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_SMT | \
+	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "Book3E",
+		.cpu_features		= CPU_FTRS_BASE_BOOK3E,
+		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_TYPE_3E | MMU_FTR_USE_TLBILX |
+					  MMU_FTR_USE_TLBIVAX_BCAST |
+					  MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 0,
+		.machine_check		= machine_check_generic,
+		.platform		= "power6",
+	},
+#endif
+
 #ifdef CONFIG_PPC32
 #if CLASSIC_PPC
 	{	/* 601 */
Index: linux-work/arch/powerpc/mm/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/mm/Makefile	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/Makefile	2009-06-03 15:13:29.000000000 +1000
@@ -11,6 +11,7 @@ obj-y				:= fault.o mem.o pgtable.o gup.
 				   pgtable_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
 				   tlb_nohash_low.o
+obj-$(CONFIG_PPC_BOOK3E)	+= tlb_book3e.o tlb_low_$(CONFIG_WORD_SIZE)e.o
 obj-$(CONFIG_PPC64)		+= mmap_64.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_STD_MMU_64)	+= hash_utils_64.o \
Index: linux-work/arch/powerpc/mm/init_64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/init_64.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/init_64.c	2009-06-03 15:13:29.000000000 +1000
@@ -76,6 +76,8 @@
 #endif
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+
 phys_addr_t memstart_addr = ~0;
 phys_addr_t kernstart_addr;
 
Index: linux-work/arch/powerpc/mm/mmu_decl.h
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_decl.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_decl.h	2009-06-03 15:13:29.000000000 +1000
@@ -36,32 +36,42 @@ static inline void _tlbil_pid(unsigned i
 {
 	asm volatile ("sync; tlbia; isync" : : : "memory");
 }
+#define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
+
 #else /* CONFIG_40x || CONFIG_8xx */
 extern void _tlbil_all(void);
 extern void _tlbil_pid(unsigned int pid);
+#ifdef CONFIG_PPC_BOOK3E
+extern void _tlbil_pid_noind(unsigned int pid);
+#else
+#define _tlbil_pid_noind(pid)	_tlbil_pid(pid)
+#endif
 #endif /* !(CONFIG_40x || CONFIG_8xx) */
 
 /*
  * On 8xx, we directly inline tlbie, on others, it's extern
  */
 #ifdef CONFIG_8xx
-static inline void _tlbil_va(unsigned long address, unsigned int pid)
+static inline void _tlbil_va(unsigned long address, unsigned int pid,
+			     unsigned int psize, unsigned int ind)
 {
 	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
 }
 #else /* CONFIG_8xx */
-extern void _tlbil_va(unsigned long address, unsigned int pid);
+extern void _tlbil_va(unsigned long address, unsigned int pid,
+		      unsigned int psize, unsigned int ind);
 #endif /* CONIFG_8xx */
 
-/*
- * As of today, we don't support tlbivax broadcast on any
- * implementation. When that becomes the case, this will be
- * an extern.
- */
-static inline void _tlbivax_bcast(unsigned long address, unsigned int pid)
+#ifdef CONFIG_PPC_BOOK3E
+extern void _tlbivax_bcast(unsigned long address, unsigned int pid,
+			   unsigned int psize, unsigned int ind);
+#else
+static inline void _tlbivax_bcast(unsigned long address, unsigned int pid,
+				  unsigned int psize, unsigned int ind)
 {
 	BUG();
 }
+#endif
 
 #else /* CONFIG_PPC_MMU_NOHASH */
 
Index: linux-work/arch/powerpc/mm/tlb_hash64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_hash64.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_hash64.c	2009-06-03 15:13:29.000000000 +1000
@@ -33,11 +33,6 @@
 
 DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 
-/* This is declared as we are using the more or less generic
- * arch/powerpc/include/asm/tlb.h file -- tgall
- */
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-
 /*
  * A linux PTE was changed and the corresponding hash table entry
  * neesd to be flushed. This function will either perform the flush
Index: linux-work/arch/powerpc/mm/tlb_book3e.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/mm/tlb_book3e.c	2009-06-03 15:13:29.000000000 +1000
@@ -0,0 +1,165 @@
+/*
+ * This file contains support code for Book3E TLB handling
+ *
+ * Copyright 2009 Ben Herrenschmidt <benh@kernel.crashing.org>
+ *                IBM Corp.
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/preempt.h>
+#include <linux/spinlock.h>
+#include <linux/lmb.h>
+
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+#include <asm/code-patching.h>
+
+#include "mmu_decl.h"
+
+/* Page size used for the linear mapping */
+int mmu_linear_psize;
+
+/* Page size used for PTE pages */
+int mmu_pte_psize;
+
+/* Is HW tablewalk enabled ? */
+int book3e_htw_enabled;
+
+/* Top of linear mapping */
+unsigned long linear_map_top;
+
+/*
+ * Handling of virtual linear page tables or indirect TLB entries
+ * flushing when PTE pages are freed
+ */
+void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
+{
+	if (book3e_htw_enabled) {
+		unsigned long start = address & PMD_MASK;
+		unsigned long end = address + PMD_SIZE;
+		unsigned long size = 1UL << mmu_psize_defs[mmu_pte_psize].shift;
+		int enc = mmu_psize_defs[mmu_pte_psize].enc;
+
+		/* This isn't the most optimal, ideally we would factor out the
+		 * while preempt & CPU mask mucking around, or even the IPI but
+		 * it will do for now
+		 */
+		while (start < end) {
+			__flush_tlb_page(tlb->mm, start, enc, 1);
+			start += size;
+		}
+	} else {
+		unsigned long rmask = 0xf000000000000000ul;
+		unsigned long rid = (address & rmask) | 0x1000000000000000ul;
+		unsigned long vpte = address & ~rmask;
+
+#ifdef CONFIG_PPC_64K_PAGES
+		vpte = (vpte >> (PAGE_SHIFT - 4)) & ~0xfffful;
+#else
+		vpte = (vpte >> (PAGE_SHIFT - 3)) & ~0xffful;
+#endif
+		vpte |= rid;
+		__flush_tlb_page(tlb->mm, vpte, mmu_pte_psize, 0);
+	}
+}
+
+/*
+ * Early initialization of the MMU TLB code
+ */
+static void __early_init_mmu(int boot_cpu)
+{
+	extern unsigned int interrupt_base_book3e;
+	extern unsigned int exc_data_tlb_miss_htw_book3e;
+	extern unsigned int exc_instruction_tlb_miss_htw_book3e;
+
+	unsigned int *ibase = &interrupt_base_book3e;
+	unsigned int mas4;
+
+	/* XXX This will have to be decided at runtime, but right
+	 * now our boot and TLB miss code hard wires it
+	 */
+	mmu_linear_psize = MMU_PAGE_1G;
+
+
+	/* Check if HW tablewalk is present, and if yes, enable it by:
+	 *
+	 * - patching the TLB miss handlers to branch to the
+	 *   one dedicates to it
+	 *
+	 * - setting the global book3e_htw_enabled
+	 *
+	 * - Set MAS4:INDD and default page size
+	 */
+
+	/* XXX This code only checks for TLB 0 capabilities and doesn't
+	 *     check what page size combos are supported by the HW. It
+	 *     also doesn't handle the case where a separate array holds
+	 *     the IND entries from the array loaded by the PT.
+	 */
+	if (boot_cpu) {
+		unsigned int tlb0cfg = mfspr(SPRN_TLB0CFG);
+
+		/* Check if HW loader is supported */
+		if ((tlb0cfg & SPRN_TLBnCFG_IND) &&
+		    (tlb0cfg & SPRN_TLBnCFG_PT)) {
+			patch_branch(ibase + (0x1c0 / 4),
+			     (unsigned long)&exc_data_tlb_miss_htw_book3e, 0);
+			patch_branch(ibase + (0x1e0 / 4),
+			     (unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
+			book3e_htw_enabled = 1;
+		}
+		printk(KERN_INFO "MMU: Book3E Page Tables %s\n",
+		       book3e_htw_enabled ? "Enabled" : "Disabled");
+	}
+
+	/* Set MAS4 based on page table setting */
+
+	mas4 = 0x4 << SPRN_MAS4_WIMGED_SHIFT;
+	if (book3e_htw_enabled) {
+		mas4 |= mas4 | SPRN_MAS4_INDD;
+#ifdef CONFIG_PPC_64K_PAGES
+		mas4 |=	BOOK3E_PAGESZ_256M << SPRN_MAS4_TSIZED_SHIFT;
+		mmu_pte_psize = MMU_PAGE_256M;
+#else
+		mas4 |=	BOOK3E_PAGESZ_1M << SPRN_MAS4_TSIZED_SHIFT;
+		mmu_pte_psize = MMU_PAGE_1M;
+#endif
+	} else {
+#ifdef CONFIG_PPC_64K_PAGES
+		mas4 |=	BOOK3E_PAGESZ_64K << SPRN_MAS4_TSIZED_SHIFT;
+#else
+		mas4 |=	BOOK3E_PAGESZ_4K << SPRN_MAS4_TSIZED_SHIFT;
+#endif
+		mmu_pte_psize = mmu_virtual_psize;
+	}
+	mtspr(SPRN_MAS4, mas4);
+
+	/* Set the global containing the top of the linear mapping
+	 * for use by the TLB miss code
+	 */
+	linear_map_top = lmb_end_of_DRAM();
+
+	/* A sync won't hurt us after mucking around with
+	 * the MMU configuration
+	 */
+	mb();
+}
+
+void __init early_init_mmu(void)
+{
+	__early_init_mmu(1);
+}
+
+void __cpuinit early_init_mmu_secondary(void)
+{
+	__early_init_mmu(0);
+}
Index: linux-work/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash.c	2009-06-03 15:19:30.000000000 +1000
@@ -40,6 +40,33 @@
 
 #include "mmu_decl.h"
 
+struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
+	[MMU_PAGE_4K] = {
+		.shift	= 12,
+		.enc	= BOOK3E_PAGESZ_4K,
+	},
+	[MMU_PAGE_64K] = {
+		.shift	= 16,
+		.enc	= BOOK3E_PAGESZ_64K,
+	},
+	[MMU_PAGE_1M] = {
+		.shift	= 20,
+		.enc	= BOOK3E_PAGESZ_1M,
+	},
+	[MMU_PAGE_16M] = {
+		.shift	= 24,
+		.enc	= BOOK3E_PAGESZ_16M,
+	},
+	[MMU_PAGE_256M] = {
+		.shift	= 28,
+		.enc	= BOOK3E_PAGESZ_256M,
+	},
+	[MMU_PAGE_1G] = {
+		.shift	= 30,
+		.enc	= BOOK3E_PAGESZ_1GB,
+	},
+};
+
 /*
  * Base TLB flushing operations:
  *
@@ -67,16 +94,23 @@ void local_flush_tlb_mm(struct mm_struct
 }
 EXPORT_SYMBOL(local_flush_tlb_mm);
 
-void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+			    int psize, int ind)
 {
 	unsigned int pid;
 
 	preempt_disable();
-	pid = vma ? vma->vm_mm->context.id : 0;
+	pid = mm ? mm->context.id : 0;
 	if (pid != MMU_NO_CONTEXT)
-		_tlbil_va(vmaddr, pid);
+		_tlbil_va(vmaddr, pid, psize, ind);
 	preempt_enable();
 }
+
+void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	__local_flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			       mmu_psize_defs[mmu_virtual_psize].enc, 0);
+}
 EXPORT_SYMBOL(local_flush_tlb_page);
 
 
@@ -90,6 +124,8 @@ static DEFINE_SPINLOCK(tlbivax_lock);
 struct tlb_flush_param {
 	unsigned long addr;
 	unsigned int pid;
+	unsigned int psize;
+	unsigned int ind;
 };
 
 static void do_flush_tlb_mm_ipi(void *param)
@@ -103,7 +139,7 @@ static void do_flush_tlb_page_ipi(void *
 {
 	struct tlb_flush_param *p = param;
 
-	_tlbil_va(p->addr, p->pid);
+	_tlbil_va(p->addr, p->pid, p->psize, p->ind);
 }
 
 
@@ -143,41 +179,53 @@ void flush_tlb_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(flush_tlb_mm);
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr, int psize, int ind)
 {
 	struct cpumask *cpu_mask;
 	unsigned int pid;
 
 	preempt_disable();
-	pid = vma ? vma->vm_mm->context.id : 0;
+	pid = mm ? mm->context.id : 0;
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		goto bail;
-	cpu_mask = mm_cpumask(vma->vm_mm);
+	cpu_mask = mm_cpumask(mm);
 	if (!cpumask_equal(cpu_mask, cpumask_of(smp_processor_id()))) {
 		/* If broadcast tlbivax is supported, use it */
 		if (mmu_has_feature(MMU_FTR_USE_TLBIVAX_BCAST)) {
 			int lock = mmu_has_feature(MMU_FTR_LOCK_BCAST_INVAL);
 			if (lock)
 				spin_lock(&tlbivax_lock);
-			_tlbivax_bcast(vmaddr, pid);
+			_tlbivax_bcast(vmaddr, pid, psize, ind);
 			if (lock)
 				spin_unlock(&tlbivax_lock);
 			goto bail;
 		} else {
-			struct tlb_flush_param p = { .pid = pid, .addr = vmaddr };
+			struct tlb_flush_param p = {
+				.pid = pid,
+				.addr = vmaddr,
+				.psize = psize,
+				.ind = ind,
+			};
 			/* Ignores smp_processor_id() even if set in cpu_mask */
 			smp_call_function_many(cpu_mask,
 					       do_flush_tlb_page_ipi, &p, 1);
 		}
 	}
-	_tlbil_va(vmaddr, pid);
+	_tlbil_va(vmaddr, pid, psize, ind);
  bail:
 	preempt_enable();
 }
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	__flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			 mmu_psize_defs[mmu_virtual_psize].enc, 0);
+}
 EXPORT_SYMBOL(flush_tlb_page);
 
 #endif /* CONFIG_SMP */
 
+
 /*
  * Flush kernel TLB entries in the given range
  */
@@ -207,3 +255,4 @@ void flush_tlb_range(struct vm_area_stru
 	flush_tlb_mm(vma->vm_mm);
 }
 EXPORT_SYMBOL(flush_tlb_range);
+
Index: linux-work/arch/powerpc/include/asm/pgalloc.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pgalloc.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgalloc.h	2009-06-03 15:13:29.000000000 +1000
@@ -4,6 +4,12 @@
 
 #include <linux/mm.h>
 
+#ifdef CONFIG_PPC_BOOK3E
+extern void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address);
+#else
+#define tlb_flush_pgtable(tlb, address)	do { } while(0)
+#endif
+
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
@@ -38,14 +44,19 @@ static inline pgtable_free_t pgtable_fre
 extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
 
 #ifdef CONFIG_SMP
-#define __pte_free_tlb(tlb,ptepage,address)		\
-do { \
-	pgtable_page_dtor(ptepage); \
+#define __pte_free_tlb(tlb,ptepage,address)				\
+do { 									\
+	pgtable_page_dtor(ptepage); 					\
+	tlb_flush_pgtable(tlb, address);				\
 	pgtable_free_tlb(tlb, pgtable_free_cache(page_address(ptepage), \
-		PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1)); \
+		PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1)); 			\
 } while (0)
 #else
-#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, (pte))
+#define __pte_free_tlb(tlb,pte,address)			\
+do { 							\
+	tlb_flush_pgtable(tlb, address);		\
+	pte_free((tlb)->mm, (pte));  			\
+} while (0)
 #endif
 
 
Index: linux-work/arch/powerpc/include/asm/mmu_context.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu_context.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu_context.h	2009-06-03 15:13:29.000000000 +1000
@@ -36,8 +36,13 @@ static inline void switch_mm(struct mm_s
 	/* 32-bit keeps track of the current PGDIR in the thread struct */
 #ifdef CONFIG_PPC32
 	tsk->thread.pgdir = next->pgd;
+
 #endif /* CONFIG_PPC32 */
 
+	/* 64-bit Book3E keeps track of current PGD in the PACA */
+#ifdef CONFIG_PPC_BOOK3E_64
+	get_paca()->pgd = next->pgd;
+#endif
 	/* Nothing else to do if we aren't actually switching */
 	if (prev == next)
 		return;
@@ -84,6 +89,10 @@ static inline void activate_mm(struct mm
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
+ 	/* 64-bit Book3E keeps track of current PGD in the PACA */
+#ifdef CONFIG_PPC_BOOK3E_64
+      	get_paca()->pgd = NULL;
+#endif
 }
 
 #endif /* __KERNEL__ */
Index: linux-work/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/setup_64.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/setup_64.c	2009-06-03 17:15:23.000000000 +1000
@@ -61,6 +61,7 @@
 #include <asm/xmon.h>
 #include <asm/udbg.h>
 #include <asm/kexec.h>
+#include <asm/mmu_context.h>
 
 #include "setup.h"
 
@@ -146,6 +147,9 @@ void __init setup_paca(int cpu)
 {
 	local_paca = &paca[cpu];
 	mtspr(SPRN_SPRG3, local_paca);
+#ifdef CONFIG_PPC_BOOK3E
+	mtspr(SPRN_SPRG2, local_paca->extlb);
+#endif
 }
 
 /*
@@ -452,6 +456,24 @@ static void __init irqstack_early_init(v
 #define irqstack_early_init()
 #endif
 
+#ifdef CONFIG_PPC_BOOK3E
+static void __init exc_lvl_early_init(void)
+{
+	unsigned int i;
+
+	for_each_possible_cpu(i) {
+		critirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+		dbgirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+		mcheckirq_ctx[i] = (struct thread_info *)
+			__va(lmb_alloc(THREAD_SIZE, THREAD_SIZE));
+	}
+}
+#else
+#define exc_lvl_early_init()
+#endif
+
 /*
  * Stack space used when we detect a bad kernel stack pointer, and
  * early in SMP boots before relocation is enabled.
@@ -511,6 +533,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = klimit;
 	
 	irqstack_early_init();
+	exc_lvl_early_init();
 	emergency_stack_init();
 
 #ifdef CONFIG_PPC_STD_MMU_64
@@ -528,6 +551,10 @@ void __init setup_arch(char **cmdline_p)
 		ppc_md.setup_arch();
 
 	paging_init();
+
+	/* Initialize the MMU context management stuff */
+	mmu_context_init();
+
 	ppc64_boot_msg(0x15, "Setup Done");
 }
 
Index: linux-work/arch/powerpc/kernel/paca.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/paca.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/paca.c	2009-06-03 15:13:29.000000000 +1000
@@ -13,6 +13,7 @@
 #include <asm/lppaca.h>
 #include <asm/paca.h>
 #include <asm/sections.h>
+#include <asm/pgtable.h>
 
 /* This symbol is provided by the linker - let it fill in the paca
  * field correctly */
@@ -87,6 +88,8 @@ void __init initialise_pacas(void)
 
 #ifdef CONFIG_PPC_BOOK3S
 		new_paca->lppaca_ptr = &lppaca[cpu];
+#else
+		new_paca->kernel_pgd = swapper_pg_dir;
 #endif
 		new_paca->lock_token = 0x8000;
 		new_paca->paca_index = cpu;
Index: linux-work/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/hw_irq.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/hw_irq.h	2009-06-03 15:13:29.000000000 +1000
@@ -49,8 +49,13 @@ extern void iseries_handle_interrupts(vo
 #define raw_irqs_disabled()		(local_get_flags() == 0)
 #define raw_irqs_disabled_flags(flags)	((flags) == 0)
 
+#ifdef CONFIG_PPC_BOOK3E
+#define __hard_irq_enable()	__asm__ __volatile__("wrteei 1": : :"memory");
+#define __hard_irq_disable()	__asm__ __volatile__("wrteei 0": : :"memory");
+#else
 #define __hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
 #define __hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
+#endif
 
 #define  hard_irq_disable()			\
 	do {					\
Index: linux-work/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/powerpc/xmon/xmon.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/xmon/xmon.c	2009-06-03 15:13:29.000000000 +1000
@@ -2570,7 +2570,7 @@ static void xmon_print_symbol(unsigned l
 	printf("%s", after);
 }
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_BOOK3S_64
 static void dump_slb(void)
 {
 	int i;
Index: linux-work/arch/powerpc/kernel/process.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/process.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/kernel/process.c	2009-06-03 15:13:29.000000000 +1000
@@ -664,6 +664,7 @@ int copy_thread(unsigned long clone_flag
 		sp_vsid |= SLB_VSID_KERNEL | llp;
 		p->thread.ksp_vsid = sp_vsid;
 	}
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	/*
 	 * The PPC64 ABI makes use of a TOC to contain function 
@@ -671,6 +672,7 @@ int copy_thread(unsigned long clone_flag
 	 * to the TOC entry.  The first entry is a pointer to the actual
 	 * function.
  	 */
+#ifdef CONFIG_PPC64
 	kregs->nip = *((unsigned long *)ret_from_fork);
 #else
 	kregs->nip = (unsigned long)ret_from_fork;
Index: linux-work/arch/powerpc/mm/mmu_context_hash64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/mmu_context_hash64.c	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/mmu_context_hash64.c	2009-06-03 15:13:29.000000000 +1000
@@ -76,3 +76,8 @@ void destroy_context(struct mm_struct *m
 
 	mm->context.id = NO_CONTEXT;
 }
+
+void __init mmu_context_init(void)
+{
+}
+
Index: linux-work/arch/powerpc/include/asm/page.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/page.h	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/page.h	2009-06-03 15:13:29.000000000 +1000
@@ -139,7 +139,11 @@ extern phys_addr_t kernstart_addr;
  * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
  * "kernelness", use is_kernel_addr() - it should do what you want.
  */
+#ifdef CONFIG_PPC_BOOK3E_64
+#define is_kernel_addr(x)	((x) >= 0x8000000000000000ul)
+#else
 #define is_kernel_addr(x)	((x) >= PAGE_OFFSET)
+#endif
 
 #ifndef __ASSEMBLY__
 
Index: linux-work/arch/powerpc/mm/tlb_nohash_low.S
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash_low.S	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash_low.S	2009-06-03 15:58:21.000000000 +1000
@@ -191,6 +191,85 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_US
 	isync
 1:	wrtee	r10
 	blr
+#elif defined(CONFIG_PPC_BOOK3E)
+/*
+ * New Book3E (>= 2.06) implementation
+ *
+ * Note: We may be able to get away without the interrupt masking stuff
+ * if we save/restore MAS6 on exceptions that might modify it
+ */
+_GLOBAL(_tlbil_pid)
+	slwi	r4,r3,SPRN_MAS6_SPID_SHIFT
+	mfmsr	r10
+	wrteei	0
+	mtspr	SPRN_MAS6,r4
+	PPC_TLBILX_PID(0,0)
+	wrtee	r10
+	msync
+	isync
+	blr
+
+_GLOBAL(_tlbil_pid_noind)
+	slwi	r4,r3,SPRN_MAS6_SPID_SHIFT
+	mfmsr	r10
+	ori	r4,r4,SPRN_MAS6_SIND
+	wrteei	0
+	mtspr	SPRN_MAS6,r4
+	PPC_TLBILX_PID(0,0)
+	wrtee	r10
+	msync
+	isync
+	blr
+
+_GLOBAL(_tlbil_all)
+	PPC_TLBILX_ALL(0,0)
+	msync
+	isync
+	blr
+
+_GLOBAL(_tlbil_va)
+	mfmsr	r10
+	wrteei	0
+	cmpwi	cr0,r6,0
+	slwi	r4,r4,SPRN_MAS6_SPID_SHIFT
+	rlwimi	r4,r5,SPRN_MAS6_ISIZE_SHIFT,SPRN_MAS6_ISIZE_MASK
+	beq	1f
+	rlwimi	r4,r6,SPRN_MAS6_SIND_SHIFT,SPRN_MAS6_SIND
+1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
+	PPC_TLBILX_VA(0,r3)
+	msync
+	isync
+	wrtee	r10
+	blr
+
+_GLOBAL(_tlbivax_bcast)
+	mfmsr	r10
+	wrteei	0
+	cmpwi	cr0,r6,0
+	slwi	r4,r4,SPRN_MAS6_SPID_SHIFT
+	rlwimi	r4,r5,SPRN_MAS6_ISIZE_SHIFT,SPRN_MAS6_ISIZE_MASK
+	beq	1f
+	rlwimi	r4,r6,SPRN_MAS6_SIND_SHIFT,SPRN_MAS6_SIND
+1:	mtspr	SPRN_MAS6,r4		/* assume AS=0 for now */
+	PPC_TLBIVAX(0,r3)
+	eieio
+	tlbsync
+	sync
+	wrtee	r10
+	blr
+
+_GLOBAL(set_context)
+#ifdef CONFIG_BDI_SWITCH
+	/* Context switch the PTE pointer for the Abatron BDI2000.
+	 * The PGDIR is the second parameter.
+	 */
+	lis	r5, abatron_pteptrs@h
+	ori	r5, r5, abatron_pteptrs@l
+	stw	r4, 0x4(r5)
+#endif
+	mtspr	SPRN_PID,r3
+	isync			/* Force context change */
+	blr
 #else
 #error Unsupported processor type !
 #endif
Index: linux-work/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-work.orig/arch/powerpc/platforms/Kconfig.cputype	2009-06-03 15:11:20.000000000 +1000
+++ linux-work/arch/powerpc/platforms/Kconfig.cputype	2009-06-03 15:16:05.000000000 +1000
@@ -20,7 +20,7 @@ choice
 
 	  If unsure, select 52xx/6xx/7xx/74xx/82xx/83xx/86xx.
 
-config PPC_BOOK3S
+config PPC_BOOK3S_32
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
 	select PPC_FPU
 
@@ -56,11 +56,34 @@ config E200
 
 endchoice
 
-config PPC_BOOK3S
-	default y
-       	depends on PPC64
+choice
+	prompt "Processor Type"
+	depends on PPC64
+	help
+	  There are two families of 64 bit PowerPC chips supported.
+	  The most common ones are the desktop and server CPUs
+	  (POWER3, RS64, POWER4, POWER5, POWER5+, POWER6, ...)
+
+	  The other are the "embedded" processors compliant with the
+	  "Book 3E" variant of the architecture
+
+config PPC_BOOK3S_64
+	bool "Server processors"
 	select PPC_FPU
 
+config PPC_BOOK3E_64
+	bool "Embedded processors"
+	select PPC_FPU # Make it a choice ?
+
+endchoice
+
+config PPC_BOOK3E
+	def_bool y
+	depends on PPC_BOOK3E_32 || PPC_BOOK3E_64
+
+config PPC_BOOK3S
+	def_bool y
+	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
 
 config POWER4_ONLY
 	bool "Optimize for POWER4"
@@ -120,7 +143,7 @@ config 4xx
 
 config BOOKE
 	bool
-	depends on E200 || E500 || 44x
+	depends on E200 || E500 || 44x || PPC_BOOK3E
 	default y
 
 config FSL_BOOKE
@@ -218,9 +241,17 @@ config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_STD_MMU
 
+config PPC_MMU_NOHASH_32
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC32
+
+config PPC_MMU_NOHASH_64
+	def_bool y
+	depends on PPC_MMU_NOHASH && PPC64
+
 config PPC_BOOK3E_MMU
 	def_bool y
-	depends on FSL_BOOKE
+	depends on FSL_BOOKE || PPC_BOOK3E
 
 config PPC_MM_SLICES
 	bool
@@ -243,7 +274,7 @@ config VIRT_CPU_ACCOUNTING
 	  If in doubt, say Y here.
 
 config SMP
-	depends on PPC_STD_MMU || FSL_BOOKE
+	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
