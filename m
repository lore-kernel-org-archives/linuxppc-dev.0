Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C5C801007DD
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2012 20:36:17 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 2 Mar 2012 10:27:00 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q229UXpe3383496
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:30:34 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q229a5QU012111
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:36:05 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/12] powerpc: Remove legacy iSeries bits from assembly files
Date: Fri,  2 Mar 2012 20:35:11 +1100
Message-Id: <1330680922-6894-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This removes the various bits of assembly in the kernel entry,
exception handling and SLB management code that were specific
to running under the legacy iSeries hypervisor which is no
longer supported.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h |   15 -----
 arch/powerpc/kernel/entry_64.S           |   42 +-------------
 arch/powerpc/kernel/exceptions-64s.S     |   95 ++---------------------------
 arch/powerpc/kernel/head_64.S            |   44 ++------------
 arch/powerpc/kernel/misc.S               |    1 -
 arch/powerpc/kernel/vmlinux.lds.S        |    5 --
 arch/powerpc/mm/slb_low.S                |   16 -----
 7 files changed, 15 insertions(+), 203 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 8057f4f..cc2bcf4 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -272,26 +272,11 @@ label##_hv:								\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_HV, SOFTEN_TEST_HV)
 
-#ifdef CONFIG_PPC_ISERIES
-#define DISABLE_INTS				\
-	li	r11,0;				\
-	stb	r11,PACASOFTIRQEN(r13);		\
-BEGIN_FW_FTR_SECTION;				\
-	stb	r11,PACAHARDIRQEN(r13);		\
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES);	\
-	TRACE_DISABLE_INTS;			\
-BEGIN_FW_FTR_SECTION;				\
-	mfmsr	r10;				\
-	ori	r10,r10,MSR_EE;			\
-	mtmsrd	r10,1;				\
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#else
 #define DISABLE_INTS				\
 	li	r11,0;				\
 	stb	r11,PACASOFTIRQEN(r13);		\
 	stb	r11,PACAHARDIRQEN(r13);		\
 	TRACE_DISABLE_INTS
-#endif /* CONFIG_PPC_ISERIES */
 
 #define ENABLE_INTS				\
 	ld	r12,_MSR(r1);			\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 866462c..0c3764b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -127,17 +127,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	stb	r10,PACASOFTIRQEN(r13)
 	stb	r10,PACAHARDIRQEN(r13)
 	std	r10,SOFTE(r1)
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	/* Hack for handling interrupts when soft-enabling on iSeries */
-	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
-	andi.	r10,r12,MSR_PR		/* from kernel */
-	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
-	bne	2f
-	b	hardware_interrupt_entry
-2:
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif /* CONFIG_PPC_ISERIES */
 
 	/* Hard enable interrupts */
 #ifdef CONFIG_PPC_BOOK3E
@@ -591,15 +580,10 @@ _GLOBAL(ret_from_except_lite)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_USER_WORK_MASK
 	bne	do_work
-#endif
+#endif /* !CONFIG_PREEMPT */
 
 restore:
-BEGIN_FW_FTR_SECTION
 	ld	r5,SOFTE(r1)
-FW_FTR_SECTION_ELSE
-	b	.Liseries_check_pending_irqs
-ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_ISERIES)
-2:
 	TRACE_AND_RESTORE_IRQ(r5);
 
 	/* extract EE bit and use it to restore paca->hard_enabled */
@@ -669,30 +653,6 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 #endif /* CONFIG_PPC_BOOK3E */
 
-.Liseries_check_pending_irqs:
-#ifdef CONFIG_PPC_ISERIES
-	ld	r5,SOFTE(r1)
-	cmpdi	0,r5,0
-	beq	2b
-	/* Check for pending interrupts (iSeries) */
-	ld	r3,PACALPPACAPTR(r13)
-	ld	r3,LPPACAANYINT(r3)
-	cmpdi	r3,0
-	beq+	2b			/* skip do_IRQ if no interrupts */
-
-	li	r3,0
-	stb	r3,PACASOFTIRQEN(r13)	/* ensure we are soft-disabled */
-#ifdef CONFIG_TRACE_IRQFLAGS
-	bl	.trace_hardirqs_off
-	mfmsr	r10
-#endif
-	ori	r10,r10,MSR_EE
-	mtmsrd	r10			/* hard-enable again */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.do_IRQ
-	b	.ret_from_except_lite		/* loop back and handle more */
-#endif
-
 do_work:
 #ifdef CONFIG_PREEMPT
 	andi.	r0,r3,MSR_PR	/* Returning to user mode? */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 15c5a4f..fea8a69 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,7 +19,7 @@
  * We layout physical memory as follows:
  * 0x0000 - 0x00ff : Secondary processor spin code
  * 0x0100 - 0x2fff : pSeries Interrupt prologs
- * 0x3000 - 0x5fff : interrupt support, iSeries and common interrupt prologs
+ * 0x3000 - 0x5fff : interrupt support common interrupt prologs
  * 0x6000 - 0x6fff : Initial (CPU0) segment table
  * 0x7000 - 0x7fff : FWNMI data area
  * 0x8000 -        : Early init and support code
@@ -458,6 +458,7 @@ machine_check_common:
 	bl	.machine_check_exception
 	b	.ret_from_except
 
+	STD_EXCEPTION_COMMON_LITE(0x500, hardware_interrupt, do_IRQ)
 	STD_EXCEPTION_COMMON_LITE(0x900, decrementer, .timer_interrupt)
 	STD_EXCEPTION_COMMON(0xa00, trap_0a, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
@@ -672,12 +673,6 @@ _GLOBAL(slb_miss_realmode)
 	ld	r10,PACA_EXSLB+EX_LR(r13)
 	ld	r3,PACA_EXSLB+EX_R3(r13)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	ld	r11,PACALPPACAPTR(r13)
-	ld	r11,LPPACASRR0(r11)		/* get SRR0 value */
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif /* CONFIG_PPC_ISERIES */
 
 	mtlr	r10
 
@@ -690,12 +685,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	mtspr	SPRN_SRR0,r11
-	mtspr	SPRN_SRR1,r12
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif /* CONFIG_PPC_ISERIES */
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
@@ -704,13 +693,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 	rfid
 	b	.	/* prevent speculative execution */
 
-2:
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	b	unrecov_slb
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif /* CONFIG_PPC_ISERIES */
-	mfspr	r11,SPRN_SRR0
+2:	mfspr	r11,SPRN_SRR0
 	ld	r10,PACAKBASE(r13)
 	LOAD_HANDLER(r10,unrecov_slb)
 	mtspr	SPRN_SRR0,r10
@@ -727,20 +710,6 @@ unrecov_slb:
 	bl	.unrecoverable_exception
 	b	1b
 
-	.align	7
-	.globl hardware_interrupt_common
-	.globl hardware_interrupt_entry
-hardware_interrupt_common:
-	EXCEPTION_PROLOG_COMMON(0x500, PACA_EXGEN)
-	FINISH_NAP
-hardware_interrupt_entry:
-	DISABLE_INTS
-BEGIN_FTR_SECTION
-	bl	.ppc64_runlatch_on
-END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.do_IRQ
-	b	.ret_from_except_lite
 
 #ifdef CONFIG_PPC_970_NAP
 power4_fixup_nap:
@@ -913,11 +882,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
 
-	/*
-	 * On iSeries, we soft-disable interrupts here, then
-	 * hard-enable interrupts so that the hash_page code can spin on
-	 * the hash_table_lock without problems on a shared processor.
-	 */
+	/* We run with interrupts both soft and hard disabled */
 	DISABLE_INTS
 
 	/*
@@ -956,25 +921,11 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	bl	.hash_page		/* build HPTE if possible */
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
-BEGIN_FW_FTR_SECTION
-	/*
-	 * If we had interrupts soft-enabled at the point where the
-	 * DSI/ISI occurred, and an interrupt came in during hash_page,
-	 * handle it now.
-	 * We jump to ret_from_except_lite rather than fast_exception_return
-	 * because ret_from_except_lite will check for and handle pending
-	 * interrupts if necessary.
-	 */
-	beq	13f
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-
-BEGIN_FW_FTR_SECTION
 	/*
 	 * Here we have interrupts hard-disabled, so it is sufficient
 	 * to restore paca->{soft,hard}_enable and get out.
 	 */
 	beq	fast_exc_return_irq	/* Return from exception on success */
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 
 	/* For a hash failure, we don't bother re-enabling interrupts */
 	ble-	12f
@@ -1141,51 +1092,19 @@ _GLOBAL(do_stab_bolted)
 	.= 0x7000
 	.globl fwnmi_data_area
 fwnmi_data_area:
-#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
-
-	/* iSeries does not use the FWNMI stuff, so it is safe to put
-	 * this here, even if we later allow kernels that will boot on
-	 * both pSeries and iSeries */
-#ifdef CONFIG_PPC_ISERIES
-        . = LPARMAP_PHYS
-	.globl xLparMap
-xLparMap:
-	.quad	HvEsidsToMap		/* xNumberEsids */
-	.quad	HvRangesToMap		/* xNumberRanges */
-	.quad	STAB0_PAGE		/* xSegmentTableOffs */
-	.zero	40			/* xRsvd */
-	/* xEsids (HvEsidsToMap entries of 2 quads) */
-	.quad	PAGE_OFFSET_ESID	/* xKernelEsid */
-	.quad	PAGE_OFFSET_VSID	/* xKernelVsid */
-	.quad	VMALLOC_START_ESID	/* xKernelEsid */
-	.quad	VMALLOC_START_VSID	/* xKernelVsid */
-	/* xRanges (HvRangesToMap entries of 3 quads) */
-	.quad	HvPagesToMap		/* xPages */
-	.quad	0			/* xOffset */
-	.quad	PAGE_OFFSET_VSID << (SID_SHIFT - HW_PAGE_SHIFT)	/* xVPN */
-
-#endif /* CONFIG_PPC_ISERIES */
 
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 	/* pseries and powernv need to keep the whole page from
 	 * 0x7000 to 0x8000 free for use by the firmware
 	 */
         . = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
-/*
- * Space for CPU0's segment table.
- *
- * On iSeries, the hypervisor must fill in at least one entry before
- * we get control (with relocate on).  The address is given to the hv
- * as a page number (see xLparMap above), so this must be at a
- * fixed address (the linker can't compute (u64)&initial_stab >>
- * PAGE_SHIFT).
- */
-	. = STAB0_OFFSET	/* 0x8000 */
+/* Space for CPU0's segment table */
+	.balign 4096
 	.globl initial_stab
 initial_stab:
 	.space	4096
+
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
 	HMT_MEDIUM
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 06c7251..40759fb 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -32,7 +32,6 @@
 #include <asm/cputable.h>
 #include <asm/setup.h>
 #include <asm/hvcall.h>
-#include <asm/iseries/lpar_map.h>
 #include <asm/thread_info.h>
 #include <asm/firmware.h>
 #include <asm/page_64.h>
@@ -57,10 +56,6 @@
  *	entry in r9 for debugging purposes
  *   2. Secondary processors enter at 0x60 with PIR in gpr3
  *
- *  For iSeries:
- *   1. The MMU is on (as it always is for iSeries)
- *   2. The kernel is entered at system_reset_iSeries
- *
  *  For Book3E processors:
  *   1. The MMU is on running in AS0 in a state defined in ePAPR
  *   2. The kernel is entered at __start
@@ -93,15 +88,6 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.llong	0x0
 
-#ifdef CONFIG_PPC_ISERIES
-	/*
-	 * At offset 0x20, there is a pointer to iSeries LPAR data.
-	 * This is required by the hypervisor
-	 */
-	. = 0x20
-	.llong hvReleaseData-KERNELBASE
-#endif /* CONFIG_PPC_ISERIES */
-
 #ifdef CONFIG_RELOCATABLE
 	/* This flag is set to 1 by a loader if the kernel should run
 	 * at the loaded address instead of the linked address.  This
@@ -582,7 +568,7 @@ _GLOBAL(pmac_secondary_start)
  *   1. Processor number
  *   2. Segment table pointer (virtual address)
  * On entry the following are set:
- *   r1	       = stack pointer.  vaddr for iSeries, raddr (temp stack) for pSeries
+ *   r1	       = stack pointer (real addr of temp stack)
  *   r24       = cpu# (in Linux terms)
  *   r13       = paca virtual address
  *   SPRG_PACA = paca virtual address
@@ -595,7 +581,7 @@ __secondary_start:
 	/* Set thread priority to MEDIUM */
 	HMT_MEDIUM
 
-	/* Initialize the kernel stack.  Just a repeat for iSeries.	 */
+	/* Initialize the kernel stack */
 	LOAD_REG_ADDR(r3, current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
 	ldx	r14,r3,r28
@@ -615,20 +601,13 @@ __secondary_start:
 	li	r7,0
 	mtlr	r7
 
+	/* Mark interrupts both hard and soft disabled */
+	stb	r7,PACAHARDIRQEN(r13)
+	stb	r7,PACASOFTIRQEN(r13)
+
 	/* enable MMU and jump to start_secondary */
 	LOAD_REG_ADDR(r3, .start_secondary_prolog)
 	LOAD_REG_IMMEDIATE(r4, MSR_KERNEL)
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	ori	r4,r4,MSR_EE
-	li	r8,1
-	stb	r8,PACAHARDIRQEN(r13)
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
-BEGIN_FW_FTR_SECTION
-	stb	r7,PACAHARDIRQEN(r13)
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
-	stb	r7,PACASOFTIRQEN(r13)
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
@@ -774,17 +753,8 @@ _INIT_GLOBAL(start_here_common)
 	bl	.setup_system
 
 	/* Load up the kernel context */
-5:
-	li	r5,0
+5:	li	r5,0
 	stb	r5,PACASOFTIRQEN(r13)	/* Soft Disabled */
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	mfmsr	r5
-	ori	r5,r5,MSR_EE		/* Hard Enabled on iSeries*/
-	mtmsrd	r5
-	li	r5,1
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
 	stb	r5,PACAHARDIRQEN(r13)	/* Hard Disabled on others */
 
 	bl	.start_kernel
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index b69463e..ba16874 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -5,7 +5,6 @@
  * Largely rewritten by Cort Dougan (cort@cs.nmt.edu)
  * and Paul Mackerras.
  *
- * Adapted for iSeries by Mike Corrigan (mikejc@us.ibm.com)
  * PPC64 updates by Dave Engebretsen (engebret@us.ibm.com)
  *
  * setjmp/longjmp code by Paul Mackerras.
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 710a540..65d1c08 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -109,11 +109,6 @@ SECTIONS
 		__ptov_table_begin = .;
 		*(.ptov_fixup);
 		__ptov_table_end = .;
-#ifdef CONFIG_PPC_ISERIES
-		__dt_strings_start = .;
-		*(.dt_strings);
-		__dt_strings_end = .;
-#endif
 	}
 
 	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index ef653dc..b9ee79ce 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -217,21 +217,6 @@ slb_finish_load:
 	 * free slot first but that took too long. Unfortunately we
  	 * dont have any LRU information to help us choose a slot.
  	 */
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
-	/*
-	 * On iSeries, the "bolted" stack segment can be cast out on
-	 * shared processor switch so we need to check for a miss on
-	 * it and restore it to the right slot.
-	 */
-	ld	r9,PACAKSAVE(r13)
-	clrrdi	r9,r9,28
-	clrrdi	r3,r3,28
-	li	r10,SLB_NUM_BOLTED-1	/* Stack goes in last bolted slot */
-	cmpld	r9,r3
-	beq	3f
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif /* CONFIG_PPC_ISERIES */
 
 7:	ld	r10,PACASTABRR(r13)
 	addi	r10,r10,1
@@ -282,7 +267,6 @@ _GLOBAL(slb_compare_rr_to_size)
 
 /*
  * Finish loading of a 1T SLB entry (for the kernel linear mapping) and return.
- * We assume legacy iSeries will never have 1T segments.
  *
  * r3 = EA, r10 = proto-VSID, r11 = flags, clobbers r9
  */
-- 
1.7.9
