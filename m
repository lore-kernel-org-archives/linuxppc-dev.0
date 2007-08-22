Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CAEE5DDE9D
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 13:54:25 +1000 (EST)
Date: Wed, 22 Aug 2007 13:44:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Move iSeries startup code out of head_64.S
Message-Id: <20070822134458.ed7a89f9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/head_64.S              |   86 +--------------------
 arch/powerpc/platforms/iseries/Makefile    |    1 +
 arch/powerpc/platforms/iseries/exception.S |  114 ++++++++++++++++++++++++++++
 include/asm-powerpc/ppc_asm.h              |   14 ++++
 4 files changed, 131 insertions(+), 84 deletions(-)
 create mode 100644 arch/powerpc/platforms/iseries/exception.S

This version creates platforms/iseries/exception.S instead of head.S.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1e6d9cc..97f089b 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -802,56 +802,6 @@ system_call_iSeries:
 	STD_EXCEPTION_ISERIES( 0xe00, trap_0e, PACA_EXGEN)
 	STD_EXCEPTION_ISERIES( 0xf00, performance_monitor, PACA_EXGEN)
 
-	.globl system_reset_iSeries
-system_reset_iSeries:
-	mfspr	r13,SPRN_SPRG3		/* Get paca address */
-	mfmsr	r24
-	ori	r24,r24,MSR_RI
-	mtmsrd	r24			/* RI on */
-	lhz	r24,PACAPACAINDEX(r13)	/* Get processor # */
-	cmpwi	0,r24,0			/* Are we processor 0? */
-	bne	1f
-	b	.__start_initialization_iSeries	/* Start up the first processor */
-1:	mfspr	r4,SPRN_CTRLF
-	li	r5,CTRL_RUNLATCH	/* Turn off the run light */
-	andc	r4,r4,r5
-	mtspr	SPRN_CTRLT,r4
-
-1:
-	HMT_LOW
-#ifdef CONFIG_SMP
-	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
-					 * should start */
-	sync
-	LOAD_REG_IMMEDIATE(r3,current_set)
-	sldi	r28,r24,3		/* get current_set[cpu#] */
-	ldx	r3,r3,r28
-	addi	r1,r3,THREAD_SIZE
-	subi	r1,r1,STACK_FRAME_OVERHEAD
-
-	cmpwi	0,r23,0
-	beq	iSeries_secondary_smp_loop	/* Loop until told to go */
-	bne	__secondary_start		/* Loop until told to go */
-iSeries_secondary_smp_loop:
-	/* Let the Hypervisor know we are alive */
-	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
-	lis	r3,0x8002
-	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
-#else /* CONFIG_SMP */
-	/* Yield the processor.  This is required for non-SMP kernels
-		which are running on multi-threaded machines. */
-	lis	r3,0x8000
-	rldicr	r3,r3,32,15		/* r3 = (r3 << 32) & 0xffff000000000000 */
-	addi	r3,r3,18		/* r3 = 0x8000000000000012 which is "yield" */
-	li	r4,0			/* "yield timed" */
-	li	r5,-1			/* "yield forever" */
-#endif /* CONFIG_SMP */
-	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
-	sc				/* Invoke the hypervisor via a system call */
-	mfspr	r13,SPRN_SPRG3		/* Put r13 back ???? */
-	b	1b			/* If SMP not configured, secondaries
-					 * loop forever */
-
 decrementer_iSeries_masked:
 	/* We may not have a valid TOC pointer in here. */
 	li	r11,1
@@ -1622,39 +1572,6 @@ _GLOBAL(generic_secondary_smp_init)
 	b	__secondary_start
 #endif
 
-#ifdef CONFIG_PPC_ISERIES
-_INIT_STATIC(__start_initialization_iSeries)
-	/* Clear out the BSS */
-	LOAD_REG_IMMEDIATE(r11,__bss_stop)
-	LOAD_REG_IMMEDIATE(r8,__bss_start)
-	sub	r11,r11,r8		/* bss size			*/
-	addi	r11,r11,7		/* round up to an even double word */
-	rldicl. r11,r11,61,3		/* shift right by 3		*/
-	beq	4f
-	addi	r8,r8,-8
-	li	r0,0
-	mtctr	r11			/* zero this many doublewords	*/
-3:	stdu	r0,8(r8)
-	bdnz	3b
-4:
-	LOAD_REG_IMMEDIATE(r1,init_thread_union)
-	addi	r1,r1,THREAD_SIZE
-	li	r0,0
-	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
-
-	LOAD_REG_IMMEDIATE(r2,__toc_start)
-	addi	r2,r2,0x4000
-	addi	r2,r2,0x4000
-
-	bl	.iSeries_early_setup
-	bl	.early_setup
-
-	/* relocation is on at this point */
-
-	b	.start_here_common
-#endif /* CONFIG_PPC_ISERIES */
-
-
 _STATIC(__mmu_off)
 	mfmsr	r3
 	andi.	r0,r3,MSR_IR|MSR_DR
@@ -1902,6 +1819,7 @@ _GLOBAL(pmac_secondary_start)
  *   r13   = paca virtual address
  *   SPRG3 = paca virtual address
  */
+	.globl	__secondary_start
 __secondary_start:
 	/* Set thread priority to MEDIUM */
 	HMT_MEDIUM
@@ -2032,7 +1950,7 @@ _INIT_STATIC(start_here_multiplatform)
 	b	.	/* prevent speculative execution */
 	
 	/* This is where all platforms converge execution */
-_INIT_STATIC(start_here_common)
+_INIT_GLOBAL(start_here_common)
 	/* relocation is on at this point */
 
 	/* The following code sets up the SP and TOC now that we are */
diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index 13ac301..60db509 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -2,6 +2,7 @@ EXTRA_CFLAGS	+= -mno-minimal-toc
 
 extra-y += dt.o
 
+obj-y += exception.o
 obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt_mod.o mf.o lpevents.o \
 	hvcall.o proc.o htab.o iommu.o misc.o irq.o
 obj-$(CONFIG_PCI) += pci.o vpdinfo.o
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
new file mode 100644
index 0000000..b6e2f8c
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -0,0 +1,114 @@
+/*
+ *  Low level routines for legacy iSeries support.
+ *
+ *  Extracted from head_64.S
+ *
+ *  PowerPC version
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ *  Rewritten by Cort Dougan (cort@cs.nmt.edu) for PReP
+ *    Copyright (C) 1996 Cort Dougan <cort@cs.nmt.edu>
+ *  Adapted for Power Macintosh by Paul Mackerras.
+ *  Low-level exception handlers and MMU support
+ *  rewritten by Paul Mackerras.
+ *    Copyright (C) 1996 Paul Mackerras.
+ *
+ *  Adapted for 64bit PowerPC by Dave Engebretsen, Peter Bergner, and
+ *    Mike Corrigan {engebret|bergner|mikejc}@us.ibm.com
+ *
+ *  This file contains the low-level support and setup for the
+ *  PowerPC-64 platform, including trap and interrupt dispatch.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/reg.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+#include <asm/ptrace.h>
+
+	.text
+
+	.globl system_reset_iSeries
+system_reset_iSeries:
+	mfspr	r13,SPRN_SPRG3		/* Get paca address */
+	mfmsr	r24
+	ori	r24,r24,MSR_RI
+	mtmsrd	r24			/* RI on */
+	lhz	r24,PACAPACAINDEX(r13)	/* Get processor # */
+	cmpwi	0,r24,0			/* Are we processor 0? */
+	bne	1f
+	b	.__start_initialization_iSeries	/* Start up the first processor */
+1:	mfspr	r4,SPRN_CTRLF
+	li	r5,CTRL_RUNLATCH	/* Turn off the run light */
+	andc	r4,r4,r5
+	mtspr	SPRN_CTRLT,r4
+
+1:
+	HMT_LOW
+#ifdef CONFIG_SMP
+	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
+					 * should start */
+	sync
+	LOAD_REG_IMMEDIATE(r3,current_set)
+	sldi	r28,r24,3		/* get current_set[cpu#] */
+	ldx	r3,r3,r28
+	addi	r1,r3,THREAD_SIZE
+	subi	r1,r1,STACK_FRAME_OVERHEAD
+
+	cmpwi	0,r23,0
+	beq	iSeries_secondary_smp_loop	/* Loop until told to go */
+	b	__secondary_start		/* Loop until told to go */
+iSeries_secondary_smp_loop:
+	/* Let the Hypervisor know we are alive */
+	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
+	lis	r3,0x8002
+	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
+#else /* CONFIG_SMP */
+	/* Yield the processor.  This is required for non-SMP kernels
+		which are running on multi-threaded machines. */
+	lis	r3,0x8000
+	rldicr	r3,r3,32,15		/* r3 = (r3 << 32) & 0xffff000000000000 */
+	addi	r3,r3,18		/* r3 = 0x8000000000000012 which is "yield" */
+	li	r4,0			/* "yield timed" */
+	li	r5,-1			/* "yield forever" */
+#endif /* CONFIG_SMP */
+	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
+	sc				/* Invoke the hypervisor via a system call */
+	mfspr	r13,SPRN_SPRG3		/* Put r13 back ???? */
+	b	1b			/* If SMP not configured, secondaries
+					 * loop forever */
+
+_INIT_STATIC(__start_initialization_iSeries)
+	/* Clear out the BSS */
+	LOAD_REG_IMMEDIATE(r11,__bss_stop)
+	LOAD_REG_IMMEDIATE(r8,__bss_start)
+	sub	r11,r11,r8		/* bss size			*/
+	addi	r11,r11,7		/* round up to an even double word */
+	rldicl. r11,r11,61,3		/* shift right by 3		*/
+	beq	4f
+	addi	r8,r8,-8
+	li	r0,0
+	mtctr	r11			/* zero this many doublewords	*/
+3:	stdu	r0,8(r8)
+	bdnz	3b
+4:
+	LOAD_REG_IMMEDIATE(r1,init_thread_union)
+	addi	r1,r1,THREAD_SIZE
+	li	r0,0
+	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
+
+	LOAD_REG_IMMEDIATE(r2,__toc_start)
+	addi	r2,r2,0x4000
+	addi	r2,r2,0x4000
+
+	bl	.iSeries_early_setup
+	bl	.early_setup
+
+	/* relocation is on at this point */
+
+	b	.start_here_common
diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index 6532572..211fdae 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -155,6 +155,20 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
+#define _INIT_GLOBAL(name) \
+	.section ".text.init.refok"; \
+	.align 2 ; \
+	.globl name; \
+	.globl GLUE(.,name); \
+	.section ".opd","aw"; \
+name: \
+	.quad GLUE(.,name); \
+	.quad .TOC.@tocbase; \
+	.quad 0; \
+	.previous; \
+	.type GLUE(.,name),@function; \
+GLUE(.,name):
+
 #define _KPROBE(name) \
 	.section ".kprobes.text","a"; \
 	.align 2 ; \
-- 
1.5.2.4
