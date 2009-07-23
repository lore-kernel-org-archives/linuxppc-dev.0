Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A8796B7BA4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 15:59:59 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Jul 2009 15:59:48 +1000
Subject: [PATCH 14/20] powerpc: Add memory management headers for new 64-bit
	BookE
Message-Id: <20090723055959.97EBEDDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds the PTE and pgtable format definitions, along with changes
to the kernel memory map and other definitions related to implementing
support for 64-bit Book3E. This also shields some asm-offset bits that
are currently only relevant on 32-bit

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/mmu-book3e.h    |   50 ++++++++++++++++++++++
 arch/powerpc/include/asm/mmu.h           |    1 
 arch/powerpc/include/asm/page.h          |    4 +
 arch/powerpc/include/asm/page_64.h       |   10 ++++
 arch/powerpc/include/asm/pgtable-ppc64.h |   61 +++++++++++++++++++--------
 arch/powerpc/include/asm/pte-book3e.h    |   70 +++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/pte-common.h    |    3 +
 arch/powerpc/kernel/asm-offsets.c        |    5 +-
 8 files changed, 186 insertions(+), 18 deletions(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/include/asm/pte-book3e.h	2009-07-22 16:40:20.000000000 +1000
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
--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc64.h	2009-07-22 16:37:24.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc64.h	2009-07-22 16:40:20.000000000 +1000
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
--- linux-work.orig/arch/powerpc/include/asm/pte-common.h	2009-07-22 16:37:24.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pte-common.h	2009-07-22 16:40:20.000000000 +1000
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
--- linux-work.orig/arch/powerpc/include/asm/mmu-book3e.h	2009-07-22 16:37:24.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu-book3e.h	2009-07-22 16:40:20.000000000 +1000
@@ -161,6 +161,29 @@
 #define TLBILX_T_CLASS2			6
 #define TLBILX_T_CLASS3			7
 
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
@@ -170,6 +193,33 @@ typedef struct {
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
--- linux-work.orig/arch/powerpc/include/asm/page_64.h	2009-07-22 16:37:24.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/page_64.h	2009-07-22 16:40:20.000000000 +1000
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
Index: linux-work/arch/powerpc/include/asm/mmu.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/mmu.h	2009-07-22 16:46:59.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/mmu.h	2009-07-22 16:56:22.000000000 +1000
@@ -17,6 +17,7 @@
 #define MMU_FTR_TYPE_40x		ASM_CONST(0x00000004)
 #define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
 #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
+#define MMU_FTR_TYPE_3E			ASM_CONST(0x00000020)
 
 /*
  * This is individual features
Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2009-07-22 16:57:40.000000000 +1000
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2009-07-22 16:59:51.000000000 +1000
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
@@ -260,6 +276,7 @@ int main(void)
 	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
 #endif /* CONFIG_PPC64 */
 
+#if defined(CONFIG_PPC32)
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	DEFINE(EXC_LVL_SIZE, STACK_EXC_LVL_FRAME_SIZE);
 	DEFINE(MAS0, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, mas0));
@@ -278,7 +295,7 @@ int main(void)
 	DEFINE(_DSRR1, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, dsrr1));
 	DEFINE(SAVED_KSP_LIMIT, STACK_INT_FRAME_SIZE+offsetof(struct exception_regs, saved_ksp_limit));
 #endif
-
+#endif
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 
Index: linux-work/arch/powerpc/include/asm/page.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/page.h	2009-07-22 16:57:39.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/page.h	2009-07-22 16:59:51.000000000 +1000
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
 
