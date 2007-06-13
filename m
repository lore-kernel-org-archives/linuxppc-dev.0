Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/13] Remove the dregs of APUS support from arch/powerpc
In-Reply-To: <20070613045031.GD16148@localhost.localdomain>
Message-Id: <20070613045255.E2E4FDDE31@ozlabs.org>
Date: Wed, 13 Jun 2007 14:52:54 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

APUS (the Amiga Power-Up System) is not supported under arch/powerpc
and it's unlikely it ever will be.  Therefore, this patch removes the
fragments of APUS support code from arch/powerpc which have been
copied from arch/ppc.

A few APUS references are left in asm-powerpc in .h files which are
still used from arch/ppc.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/Kconfig                |    4 -
 arch/powerpc/kernel/head_32.S       |  122 ---------------------------------
 arch/powerpc/kernel/irq.c           |    1 
 arch/powerpc/mm/44x_mmu.c           |    1 
 arch/powerpc/mm/4xx_mmu.c           |    1 
 arch/powerpc/mm/fsl_booke_mmu.c     |    1 
 arch/powerpc/mm/init_32.c           |    1 
 arch/powerpc/mm/init_64.c           |    1 
 arch/powerpc/mm/mem.c               |    1 
 arch/powerpc/mm/mmu_context_32.c    |    1 
 arch/powerpc/mm/mmu_decl.h          |    1 
 arch/powerpc/mm/pgtable_32.c        |    1 
 arch/powerpc/mm/pgtable_64.c        |    1 
 arch/powerpc/mm/ppc_mmu_32.c        |    1 
 arch/powerpc/mm/tlb_32.c            |    1 
 arch/powerpc/mm/tlb_64.c            |    1 
 arch/powerpc/platforms/Kconfig      |    7 -
 arch/powerpc/platforms/apus/Kconfig |  130 ------------------------------------
 include/asm-powerpc/pgtable-ppc32.h |   26 -------
 19 files changed, 5 insertions(+), 298 deletions(-)

Index: working-2.6/include/asm-powerpc/pgtable-ppc32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable-ppc32.h	2007-06-04 13:39:21.000000000 +1000
+++ working-2.6/include/asm-powerpc/pgtable-ppc32.h	2007-06-04 13:39:22.000000000 +1000
@@ -751,32 +751,6 @@
 #define pte_to_pgoff(pte)	(pte_val(pte) >> 3)
 #define pgoff_to_pte(off)	((pte_t) { ((off) << 3) | _PAGE_FILE })
 
-/* CONFIG_APUS */
-/* For virtual address to physical address conversion */
-extern void cache_clear(__u32 addr, int length);
-extern void cache_push(__u32 addr, int length);
-extern int mm_end_of_chunk (unsigned long addr, int len);
-
-/* Values for nocacheflag and cmode */
-/* These are not used by the APUS kernel_map, but prevents
-   compilation errors. */
-#define	KERNELMAP_FULL_CACHING		0
-#define	KERNELMAP_NOCACHE_SER		1
-#define	KERNELMAP_NOCACHE_NONSER	2
-#define	KERNELMAP_NO_COPYBACK		3
-
-/*
- * Map some physical address range into the kernel address space.
- */
-extern unsigned long kernel_map(unsigned long paddr, unsigned long size,
-				int nocacheflag, unsigned long *memavailp );
-
-/*
- * Set cache mode of (kernel space) address range.
- */
-extern void kernel_set_cachemode (unsigned long address, unsigned long size,
-                                 unsigned int cmode);
-
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define kern_addr_valid(addr)	(1)
 
Index: working-2.6/arch/powerpc/Kconfig
===================================================================
--- working-2.6.orig/arch/powerpc/Kconfig	2007-06-04 13:32:53.000000000 +1000
+++ working-2.6/arch/powerpc/Kconfig	2007-06-04 13:39:22.000000000 +1000
@@ -686,9 +686,9 @@
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
 		|| MPC7448HPC2 || PPC_PS3 || PPC_HOLLY
-	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
+	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
-	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
+	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	select ARCH_SUPPORTS_MSI
 	help
Index: working-2.6/arch/powerpc/kernel/head_32.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/head_32.S	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/head_32.S	2007-06-04 13:39:22.000000000 +1000
@@ -9,7 +9,6 @@
  *  rewritten by Paul Mackerras.
  *    Copyright (C) 1996 Paul Mackerras.
  *  MPC8xx modifications Copyright (C) 1997 Dan Malek (dmalek@jlc.net).
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  This file contains the low-level support and setup for the
  *  PowerPC platform, including trap and interrupt dispatch.
@@ -32,10 +31,6 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 
-#ifdef CONFIG_APUS
-#include <asm/amigappc.h>
-#endif
-
 /* 601 only have IBAT; cr0.eq is set on 601 when using this macro */
 #define LOAD_BAT(n, reg, RA, RB)	\
 	/* see the comment for clear_bats() -- Cort */ \
@@ -92,11 +87,6 @@
  *  r4: virtual address of boot_infos_t
  *  r5: 0
  *
- * APUS
- *   r3: 'APUS'
- *   r4: physical address of memory base
- *   Linux/m68k style BootInfo structure at &_end.
- *
  * PREP
  * This is jumped to on prep systems right after the kernel is relocated
  * to its proper place in memory by the boot loader.  The expected layout
@@ -150,14 +140,6 @@
  */
 	bl	early_init
 
-#ifdef CONFIG_APUS
-/* On APUS the __va/__pa constants need to be set to the correct
- * values before continuing.
- */
-	mr	r4,r30
-	bl	fix_mem_constants
-#endif /* CONFIG_APUS */
-
 /* Switch MMU off, clear BATs and flush TLB. At this point, r3 contains
  * the physical address we are running at, returned by early_init()
  */
@@ -167,7 +149,7 @@
 	bl	flush_tlbs
 
 	bl	initial_bats
-#if !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT)
+#if defined(CONFIG_BOOTX_TEXT)
 	bl	setup_disp_bat
 #endif
 
@@ -183,7 +165,6 @@
 #endif /* CONFIG_6xx */
 
 
-#ifndef CONFIG_APUS
 /*
  * We need to run with _start at physical address 0.
  * On CHRP, we are loaded at 0x10000 since OF on CHRP uses
@@ -196,7 +177,6 @@
 	addis	r4,r3,KERNELBASE@h	/* current address of _start */
 	cmpwi	0,r4,0			/* are we already running at 0? */
 	bne	relocate_kernel
-#endif /* CONFIG_APUS */
 /*
  * we now have the 1st 16M of ram mapped with the bats.
  * prep needs the mmu to be turned on here, but pmac already has it on.
@@ -881,85 +861,6 @@
 	addi	r6,r6,4
 	blr
 
-#ifdef CONFIG_APUS
-/*
- * On APUS the physical base address of the kernel is not known at compile
- * time, which means the __pa/__va constants used are incorrect. In the
- * __init section is recorded the virtual addresses of instructions using
- * these constants, so all that has to be done is fix these before
- * continuing the kernel boot.
- *
- * r4 = The physical address of the kernel base.
- */
-fix_mem_constants:
-	mr	r10,r4
-	addis	r10,r10,-KERNELBASE@h    /* virt_to_phys constant */
-	neg	r11,r10	                 /* phys_to_virt constant */
-
-	lis	r12,__vtop_table_begin@h
-	ori	r12,r12,__vtop_table_begin@l
-	add	r12,r12,r10	         /* table begin phys address */
-	lis	r13,__vtop_table_end@h
-	ori	r13,r13,__vtop_table_end@l
-	add	r13,r13,r10	         /* table end phys address */
-	subi	r12,r12,4
-	subi	r13,r13,4
-1:	lwzu	r14,4(r12)               /* virt address of instruction */
-	add     r14,r14,r10              /* phys address of instruction */
-	lwz     r15,0(r14)               /* instruction, now insert top */
-	rlwimi  r15,r10,16,16,31         /* half of vp const in low half */
-	stw	r15,0(r14)               /* of instruction and restore. */
-	dcbst	r0,r14			 /* write it to memory */
-	sync
-	icbi	r0,r14			 /* flush the icache line */
-	cmpw	r12,r13
-	bne     1b
-	sync				/* additional sync needed on g4 */
-	isync
-
-/*
- * Map the memory where the exception handlers will
- * be copied to when hash constants have been patched.
- */
-#ifdef CONFIG_APUS_FAST_EXCEPT
-	lis	r8,0xfff0
-#else
-	lis	r8,0
-#endif
-	ori	r8,r8,0x2		/* 128KB, supervisor */
-	mtspr	SPRN_DBAT3U,r8
-	mtspr	SPRN_DBAT3L,r8
-
-	lis	r12,__ptov_table_begin@h
-	ori	r12,r12,__ptov_table_begin@l
-	add	r12,r12,r10	         /* table begin phys address */
-	lis	r13,__ptov_table_end@h
-	ori	r13,r13,__ptov_table_end@l
-	add	r13,r13,r10	         /* table end phys address */
-	subi	r12,r12,4
-	subi	r13,r13,4
-1:	lwzu	r14,4(r12)               /* virt address of instruction */
-	add     r14,r14,r10              /* phys address of instruction */
-	lwz     r15,0(r14)               /* instruction, now insert top */
-	rlwimi  r15,r11,16,16,31         /* half of pv const in low half*/
-	stw	r15,0(r14)               /* of instruction and restore. */
-	dcbst	r0,r14			 /* write it to memory */
-	sync
-	icbi	r0,r14			 /* flush the icache line */
-	cmpw	r12,r13
-	bne     1b
-
-	sync				/* additional sync needed on g4 */
-	isync				/* No speculative loading until now */
-	blr
-
-/***********************************************************************
- *  Please note that on APUS the exception handlers are located at the
- *  physical address 0xfff0000. For this reason, the exception handlers
- *  cannot use relative branches to access the code below.
- ***********************************************************************/
-#endif /* CONFIG_APUS */
-
 #ifdef CONFIG_SMP
 #ifdef CONFIG_GEMINI
 	.globl	__secondary_start_gemini
@@ -1135,19 +1036,6 @@
 	bl	__save_cpu_setup
 	bl	MMU_init
 
-#ifdef CONFIG_APUS
-	/* Copy exception code to exception vector base on APUS. */
-	lis	r4,KERNELBASE@h
-#ifdef CONFIG_APUS_FAST_EXCEPT
-	lis	r3,0xfff0		/* Copy to 0xfff00000 */
-#else
-	lis	r3,0			/* Copy to 0x00000000 */
-#endif
-	li	r5,0x4000		/* # bytes of memory to copy */
-	li	r6,0
-	bl	copy_and_flush		/* copy the first 0x4000 bytes */
-#endif  /* CONFIG_APUS */
-
 /*
  * Go back to running unmapped so we can load up new values
  * for SDR1 (hash table pointer) and the segment registers
@@ -1324,11 +1212,7 @@
 #else
 	ori	r8,r8,2			/* R/W access */
 #endif /* CONFIG_SMP */
-#ifdef CONFIG_APUS
-	ori	r11,r11,BL_8M<<2|0x2	/* set up 8MB BAT registers for 604 */
-#else
 	ori	r11,r11,BL_256M<<2|0x2	/* set up BAT registers for 604 */
-#endif /* CONFIG_APUS */
 
 	mtspr	SPRN_DBAT0L,r8		/* N.B. 6xx (not 601) have valid */
 	mtspr	SPRN_DBAT0U,r11		/* bit in upper BAT register */
@@ -1338,7 +1222,7 @@
 	blr
 
 
-#if !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT)
+#ifdef CONFIG_BOOTX_TEXT
 setup_disp_bat:
 	/*
 	 * setup the display bat prepared for us in prom.c
@@ -1362,7 +1246,7 @@
 1:	mtspr	SPRN_IBAT3L,r8
 	mtspr	SPRN_IBAT3U,r11
 	blr
-#endif /* !defined(CONFIG_APUS) && defined(CONFIG_BOOTX_TEXT) */
+#endif /* CONFIG_BOOTX_TEXT */
 
 #ifdef CONFIG_8260
 /* Jump into the system reset for the rom.
Index: working-2.6/arch/powerpc/kernel/irq.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/irq.c	2007-06-04 13:32:53.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/irq.c	2007-06-04 13:39:22.000000000 +1000
@@ -7,7 +7,6 @@
  *    Copyright (C) 1996-2001 Cort Dougan
  *  Adapted for Power Macintosh by Paul Mackerras
  *    Copyright (C) 1996 Paul Mackerras (paulus@cs.anu.edu.au)
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
Index: working-2.6/arch/powerpc/mm/44x_mmu.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/44x_mmu.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/44x_mmu.c	2007-06-04 13:39:22.000000000 +1000
@@ -12,7 +12,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/4xx_mmu.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/4xx_mmu.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/4xx_mmu.c	2007-06-04 13:39:22.000000000 +1000
@@ -9,7 +9,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/fsl_booke_mmu.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/fsl_booke_mmu.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/fsl_booke_mmu.c	2007-06-04 13:39:22.000000000 +1000
@@ -14,7 +14,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/init_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/init_32.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/init_32.c	2007-06-04 13:39:22.000000000 +1000
@@ -5,7 +5,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *  PPC44x/36-bit changes by Matt Porter (mporter@mvista.com)
  *
  *  Derived from "arch/i386/mm/init.c"
Index: working-2.6/arch/powerpc/mm/init_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/init_64.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/init_64.c	2007-06-04 13:39:22.000000000 +1000
@@ -5,7 +5,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/mem.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/mem.c	2007-05-24 21:31:17.000000000 +1000
+++ working-2.6/arch/powerpc/mm/mem.c	2007-06-04 13:39:22.000000000 +1000
@@ -5,7 +5,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *  PPC44x/36-bit changes by Matt Porter (mporter@mvista.com)
  *
  *  Derived from "arch/i386/mm/init.c"
Index: working-2.6/arch/powerpc/mm/mmu_context_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/mmu_context_32.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/mmu_context_32.c	2007-06-04 13:39:22.000000000 +1000
@@ -11,7 +11,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/mmu_decl.h
===================================================================
--- working-2.6.orig/arch/powerpc/mm/mmu_decl.h	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/mmu_decl.h	2007-06-04 13:39:22.000000000 +1000
@@ -8,7 +8,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/pgtable_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable_64.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable_64.c	2007-06-04 13:39:22.000000000 +1000
@@ -7,7 +7,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@samba.org)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/ppc_mmu_32.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/ppc_mmu_32.c	2007-06-04 13:39:22.000000000 +1000
@@ -11,7 +11,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/tlb_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/tlb_32.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/tlb_32.c	2007-06-04 13:39:22.000000000 +1000
@@ -11,7 +11,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/mm/tlb_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/tlb_64.c	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/mm/tlb_64.c	2007-06-04 13:39:22.000000000 +1000
@@ -8,7 +8,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
Index: working-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/Kconfig	2007-05-19 09:22:28.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/Kconfig	2007-06-04 13:39:22.000000000 +1000
@@ -16,13 +16,6 @@
 	bool "Embedded 6xx/7xx/7xxx-based board"
 	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
 
-config APUS
-	bool "Amiga-APUS"
-	depends on PPC32 && BROKEN
-	help
-	  Select APUS if configuring for a PowerUP Amiga.
-	  More information is available at:
-	  <http://linux-apus.sourceforge.net/>.
 endchoice
 
 source "arch/powerpc/platforms/pseries/Kconfig"
Index: working-2.6/arch/powerpc/platforms/apus/Kconfig
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/apus/Kconfig	2007-05-19 09:22:28.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,130 +0,0 @@
-
-config AMIGA
-	bool
-	depends on APUS
-	default y
-	help
-	  This option enables support for the Amiga series of computers.
-
-config ZORRO
-	bool
-	depends on APUS
-	default y
-	help
-	  This enables support for the Zorro bus in the Amiga. If you have
-	  expansion cards in your Amiga that conform to the Amiga
-	  AutoConfig(tm) specification, say Y, otherwise N. Note that even
-	  expansion cards that do not fit in the Zorro slots but fit in e.g.
-	  the CPU slot may fall in this category, so you have to say Y to let
-	  Linux use these.
-
-config ABSTRACT_CONSOLE
-	bool
-	depends on APUS
-	default y
-
-config APUS_FAST_EXCEPT
-	bool
-	depends on APUS
-	default y
-
-config AMIGA_PCMCIA
-	bool "Amiga 1200/600 PCMCIA support"
-	depends on APUS && EXPERIMENTAL
-	help
-	  Include support in the kernel for pcmcia on Amiga 1200 and Amiga
-	  600. If you intend to use pcmcia cards say Y; otherwise say N.
-
-config AMIGA_BUILTIN_SERIAL
-	tristate "Amiga builtin serial support"
-	depends on APUS
-	help
-	  If you want to use your Amiga's built-in serial port in Linux,
-	  answer Y.
-
-	  To compile this driver as a module, choose M here.
-
-config GVPIOEXT
-	tristate "GVP IO-Extender support"
-	depends on APUS
-	help
-	  If you want to use a GVP IO-Extender serial card in Linux, say Y.
-	  Otherwise, say N.
-
-config GVPIOEXT_LP
-	tristate "GVP IO-Extender parallel printer support"
-	depends on GVPIOEXT
-	help
-	  Say Y to enable driving a printer from the parallel port on your
-	  GVP IO-Extender card, N otherwise.
-
-config GVPIOEXT_PLIP
-	tristate "GVP IO-Extender PLIP support"
-	depends on GVPIOEXT
-	help
-	  Say Y to enable doing IP over the parallel port on your GVP
-	  IO-Extender card, N otherwise.
-
-config MULTIFACE_III_TTY
-	tristate "Multiface Card III serial support"
-	depends on APUS
-	help
-	  If you want to use a Multiface III card's serial port in Linux,
-	  answer Y.
-
-	  To compile this driver as a module, choose M here.
-
-config A2232
-	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && APUS
-	---help---
-	  This option supports the 2232 7-port serial card shipped with the
-	  Amiga 2000 and other Zorro-bus machines, dating from 1989.  At
-	  a max of 19,200 bps, the ports are served by a 6551 ACIA UART chip
-	  each, plus a 8520 CIA, and a master 6502 CPU and buffer as well. The
-	  ports were connected with 8 pin DIN connectors on the card bracket,
-	  for which 8 pin to DB25 adapters were supplied. The card also had
-	  jumpers internally to toggle various pinning configurations.
-
-	  This driver can be built as a module; but then "generic_serial"
-	  will also be built as a module. This has to be loaded before
-	  "ser_a2232". If you want to do this, answer M here.
-
-config WHIPPET_SERIAL
-	tristate "Hisoft Whippet PCMCIA serial support"
-	depends on AMIGA_PCMCIA
-	help
-	  HiSoft has a web page at <http://www.hisoft.co.uk/>, but there
-	  is no listing for the Whippet in their Amiga section.
-
-config APNE
-	tristate "PCMCIA NE2000 support"
-	depends on AMIGA_PCMCIA
-	help
-	  If you have a PCMCIA NE2000 compatible adapter, say Y.  Otherwise,
-	  say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called apne.
-
-config SERIAL_CONSOLE
-	bool "Support for serial port console"
-	depends on APUS && (AMIGA_BUILTIN_SERIAL=y || GVPIOEXT=y || MULTIFACE_III_TTY=y)
-
-config HEARTBEAT
-	bool "Use power LED as a heartbeat"
-	depends on APUS
-	help
-	  Use the power-on LED on your machine as a load meter.  The exact
-	  behavior is platform-dependent, but normally the flash frequency is
-	  a hyperbolic function of the 5-minute load average.
-
-config PROC_HARDWARE
-	bool "/proc/hardware support"
-	depends on APUS
-
-source "drivers/zorro/Kconfig"
-
-config PCI_PERMEDIA
-	bool "PCI for Permedia2"
-	depends on !4xx && !8xx && APUS
Index: working-2.6/arch/powerpc/mm/pgtable_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/pgtable_32.c	2007-06-04 13:39:21.000000000 +1000
+++ working-2.6/arch/powerpc/mm/pgtable_32.c	2007-06-04 13:39:25.000000000 +1000
@@ -8,7 +8,6 @@
  *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
  *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
  *    Copyright (C) 1996 Paul Mackerras
- *  Amiga/APUS changes by Jesper Skov (jskov@cygnus.co.uk).
  *
  *  Derived from "arch/i386/mm/init.c"
  *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
