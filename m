Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 6/10] Port 44x MMU definitions to ARCH=powerpc
In-Reply-To: <20070418063517.GB29312@localhost.localdomain>
Message-Id: <20070418063626.80A69DDEBA@ozlabs.org>
Date: Wed, 18 Apr 2007 16:36:26 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the mmu.h definitions which are still relevant for
ARCH=powerpc from include/asm-ppc/mmu.h to their own file,
include/asm-powerpc/mmu_44x.h.  The new file is included from
asm-powerpc/mmu.h, and a couple of other tweaks to correct mmu
definitions for 44x are made.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/kernel/head_44x.S    |    4 -
 arch/powerpc/mm/44x_mmu.c         |   81 +++++++-------------------------------
 arch/powerpc/mm/mmu_decl.h        |    2 
 include/asm-powerpc/mmu-44x/mmu.h |   75 +++++++++++++++++++++++++++++++++++
 include/asm-powerpc/mmu.h         |   11 ++++-
 5 files changed, 105 insertions(+), 68 deletions(-)

Index: working-2.6/include/asm-powerpc/mmu.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu.h	2007-02-09 09:57:55.000000000 +1100
+++ working-2.6/include/asm-powerpc/mmu.h	2007-04-16 10:32:48.000000000 +1000
@@ -2,8 +2,15 @@
 #define _ASM_POWERPC_MMU_H_
 #ifdef __KERNEL__
 
-#ifndef CONFIG_PPC64
-#include <asm-ppc/mmu.h>
+#if defined(CONFIG_44x)
+/* 44x-style software loaded TLB */
+#  include <asm/mmu-44x/mmu.h>
+#elif !defined(CONFIG_PPC64)
+/* Other 32-bit.
+ *
+ * FIXME: split up the other 32-bit MMU types, and revise for
+ * arch/powerpc */
+#  include <asm-ppc/mmu.h>
 #else
 
 /*
Index: working-2.6/arch/powerpc/mm/44x_mmu.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/44x_mmu.c	2006-12-08 10:42:48.000000000 +1100
+++ working-2.6/arch/powerpc/mm/44x_mmu.c	2007-04-16 10:32:48.000000000 +1000
@@ -24,73 +24,35 @@
  *
  */
 
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/mman.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/stddef.h>
-#include <linux/vmalloc.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/highmem.h>
-
-#include <asm/pgalloc.h>
-#include <asm/prom.h>
-#include <asm/io.h>
-#include <asm/mmu_context.h>
-#include <asm/pgtable.h>
 #include <asm/mmu.h>
-#include <asm/uaccess.h>
-#include <asm/smp.h>
-#include <asm/bootx.h>
-#include <asm/machdep.h>
-#include <asm/setup.h>
 
 #include "mmu_decl.h"
 
-extern char etext[], _stext[];
-
 /* Used by the 44x TLB replacement exception handler.
  * Just needed it declared someplace.
  */
-unsigned int tlb_44x_index = 0;
-unsigned int tlb_44x_hwater = 62;
+unsigned int tlb_44x_index; /* = 0 */
+unsigned int tlb_44x_hwater = PPC44x_TLB_SIZE - 1 - PPC44x_EARLY_TLBS;
 
 /*
  * "Pins" a 256MB TLB entry in AS0 for kernel lowmem
  */
-static void __init
-ppc44x_pin_tlb(int slot, unsigned int virt, unsigned int phys)
+static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 {
-	unsigned long attrib = 0;
-
-	__asm__ __volatile__("\
-	clrrwi	%2,%2,10\n\
-	ori	%2,%2,%4\n\
-	clrrwi	%1,%1,10\n\
-	li	%0,0\n\
-	ori	%0,%0,%5\n\
-	tlbwe	%2,%3,%6\n\
-	tlbwe	%1,%3,%7\n\
-	tlbwe	%0,%3,%8"
+	__asm__ __volatile__(
+		"tlbwe	%2,%3,%4\n"
+		"tlbwe	%1,%3,%5\n"
+		"tlbwe	%0,%3,%6\n"
 	:
-	: "r" (attrib), "r" (phys), "r" (virt), "r" (slot),
-	  "i" (PPC44x_TLB_VALID | PPC44x_TLB_256M),
-	  "i" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
+	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
+	  "r" (phys),
+	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
+	  "r" (tlb_44x_hwater--), /* slot for this TLB entry */
 	  "i" (PPC44x_TLB_PAGEID),
 	  "i" (PPC44x_TLB_XLAT),
 	  "i" (PPC44x_TLB_ATTRIB));
 }
 
-/*
- * MMU_init_hw does the chip-specific initialization of the MMU hardware.
- */
 void __init MMU_init_hw(void)
 {
 	flush_instruction_cache();
@@ -98,22 +60,13 @@ void __init MMU_init_hw(void)
 
 unsigned long __init mmu_mapin_ram(void)
 {
-	unsigned int pinned_tlbs = 1;
-	int i;
+	unsigned long addr;
 
-	/* Determine number of entries necessary to cover lowmem */
-	pinned_tlbs = (unsigned int)
-		(_ALIGN(total_lowmem, PPC_PIN_SIZE) >> PPC44x_PIN_SHIFT);
-
-	/* Write upper watermark to save location */
-	tlb_44x_hwater = PPC44x_LOW_SLOT - pinned_tlbs;
-
-	/* If necessary, set additional pinned TLBs */
-	if (pinned_tlbs > 1)
-		for (i = (PPC44x_LOW_SLOT-(pinned_tlbs-1)); i < PPC44x_LOW_SLOT; i++) {
-			unsigned int phys_addr = (PPC44x_LOW_SLOT-i) * PPC_PIN_SIZE;
-			ppc44x_pin_tlb(i, phys_addr+PAGE_OFFSET, phys_addr);
-		}
+	/* Pin in enough TLBs to cover any lowmem not covered by the
+	 * initial 256M mapping established in head_44x.S */
+	for (addr = PPC_PIN_SIZE; addr < total_lowmem;
+	     addr += PPC_PIN_SIZE)
+		ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
 
 	return total_lowmem;
 }
Index: working-2.6/arch/powerpc/mm/mmu_decl.h
===================================================================
--- working-2.6.orig/arch/powerpc/mm/mmu_decl.h	2007-04-16 10:04:20.000000000 +1000
+++ working-2.6/arch/powerpc/mm/mmu_decl.h	2007-04-16 10:32:48.000000000 +1000
@@ -39,8 +39,10 @@ extern int __map_without_bats;
 extern unsigned long ioremap_base;
 extern unsigned int rtas_data, rtas_size;
 
+#ifdef CONFIG_CLASSIC32
 extern PTE *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
+#endif /* CONFIG_CLASSIC32 */
 
 extern unsigned int num_tlbcam_entries;
 #endif
Index: working-2.6/arch/powerpc/kernel/head_44x.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-02-14 10:58:22.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-04-16 10:32:48.000000000 +1000
@@ -120,8 +120,8 @@ skpinv:	addi	r4,r4,1				/* Increment */
  * Configure and load pinned entry into TLB slot 63.
  */
 
-	lis	r3,KERNELBASE@h		/* Load the kernel virtual address */
-	ori	r3,r3,KERNELBASE@l
+	lis	r3,PAGE_OFFSET@h
+	ori	r3,r3,PAGE_OFFSET@l
 
 	/* Kernel is at the base of RAM */
 	li r4, 0			/* Load the kernel physical address */
Index: working-2.6/include/asm-powerpc/mmu-44x/mmu.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/include/asm-powerpc/mmu-44x/mmu.h	2007-04-16 10:32:48.000000000 +1000
@@ -0,0 +1,75 @@
+#ifndef _ASM_POWERPC_MMU_44X_MMU_H_
+#define _ASM_POWERPC_MMU_44X_MMU_H_
+
+/*
+ * PPC440 support
+ */
+#define PPC44x_MMUCR_TID	0x000000ff
+#define PPC44x_MMUCR_STS	0x00010000
+
+#define	PPC44x_TLB_PAGEID	0
+#define	PPC44x_TLB_XLAT		1
+#define	PPC44x_TLB_ATTRIB	2
+
+/* Page identification fields */
+#define PPC44x_TLB_EPN_MASK	0xfffffc00      /* Effective Page Number */
+#define	PPC44x_TLB_VALID	0x00000200      /* Valid flag */
+#define PPC44x_TLB_TS		0x00000100	/* Translation address space */
+#define PPC44x_TLB_1K		0x00000000	/* Page sizes */
+#define PPC44x_TLB_4K		0x00000010
+#define PPC44x_TLB_16K		0x00000020
+#define PPC44x_TLB_64K		0x00000030
+#define PPC44x_TLB_256K		0x00000040
+#define PPC44x_TLB_1M		0x00000050
+#define PPC44x_TLB_16M		0x00000070
+#define	PPC44x_TLB_256M		0x00000090
+
+/* Translation fields */
+#define PPC44x_TLB_RPN_MASK	0xfffffc00      /* Real Page Number */
+#define	PPC44x_TLB_ERPN_MASK	0x0000000f
+
+/* Storage attribute and access control fields */
+#define PPC44x_TLB_ATTR_MASK	0x0000ff80
+#define PPC44x_TLB_U0		0x00008000      /* User 0 */
+#define PPC44x_TLB_U1		0x00004000      /* User 1 */
+#define PPC44x_TLB_U2		0x00002000      /* User 2 */
+#define PPC44x_TLB_U3		0x00001000      /* User 3 */
+#define PPC44x_TLB_W		0x00000800      /* Caching is write-through */
+#define PPC44x_TLB_I		0x00000400      /* Caching is inhibited */
+#define PPC44x_TLB_M		0x00000200      /* Memory is coherent */
+#define PPC44x_TLB_G		0x00000100      /* Memory is guarded */
+#define PPC44x_TLB_E		0x00000080      /* Memory is guarded */
+
+#define PPC44x_TLB_PERM_MASK	0x0000003f
+#define PPC44x_TLB_UX		0x00000020      /* User execution */
+#define PPC44x_TLB_UW		0x00000010      /* User write */
+#define PPC44x_TLB_UR		0x00000008      /* User read */
+#define PPC44x_TLB_SX		0x00000004      /* Super execution */
+#define PPC44x_TLB_SW		0x00000002      /* Super write */
+#define PPC44x_TLB_SR		0x00000001      /* Super read */
+
+/* Number of TLB entries */
+#define PPC44x_TLB_SIZE		64
+
+#ifndef __ASSEMBLY__
+
+typedef unsigned long long phys_addr_t;
+
+extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
+#define PHYS_FMT	"%16Lx"
+
+typedef struct {
+	unsigned long id;
+	unsigned long vdso_base;
+} mm_context_t;
+
+#endif /* !__ASSEMBLY__ */
+
+/* TLB entry offset/size used for pinning kernel lowmem */
+#define PPC44x_PIN_SHIFT	28
+#define PPC_PIN_SIZE		(1 << PPC44x_PIN_SHIFT)
+
+#define PPC44x_EARLY_TLBS	1
+
+#endif /* _ASM_POWERPC_MMU_44X_MMU_H_ */
+
