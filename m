Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
Date: Tue, 26 Sep 2006 14:55:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Lazy interrupt disabling for 64-bit machines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This implements a lazy strategy for disabling interrupts.  This means
that local_irq_disable() et al. just clear the 'interrupts are
enabled' flag in the paca.  If an interrupt comes along, the interrupt
entry code notices that interrupts are supposed to be disabled, and
clears the EE bit in SRR1, clears the 'interrupts are hard-enabled'
flag in the paca, and returns.  This means that interrupts only
actually get disabled in the processor when an interrupt comes along.

When interrupts are enabled by local_irq_enable() et al., the code
sets the interrupts-enabled flag in the paca, and then checks whether
interrupts got hard-disabled.  If so, it also sets the EE bit in the
MSR to hard-enable the interrupts.

This has the potential to improve performance, and also makes it
easier to make a kernel that can boot on iSeries and on other 64-bit
machines, since this lazy-disable strategy is very similar to the
soft-disable strategy that iSeries already uses.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d06f378..157ab40 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -119,6 +119,7 @@ #ifdef CONFIG_PPC64
 	DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
 	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
 	DEFINE(PACAPROCENABLED, offsetof(struct paca_struct, proc_enabled));
+	DEFINE(PACAHARDIRQEN, offsetof(struct paca_struct, hard_enabled));
 	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
 	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cd872b..0639f1c 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -28,10 +28,6 @@ #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 
-#ifdef CONFIG_PPC_ISERIES
-#define DO_SOFT_DISABLE
-#endif
-
 /*
  * System calls.
  */
@@ -90,14 +86,16 @@ system_call_common:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+	li	r10,1
+	stb	r10,PACAPROCENABLED(r13)
+	stb	r10,PACAHARDIRQEN(r13)
+	std	r10,SOFTE(r1)
 #ifdef CONFIG_PPC_ISERIES
 	/* Hack for handling interrupts when soft-enabling on iSeries */
 	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
 	andi.	r10,r12,MSR_PR		/* from kernel */
 	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
 	beq	hardware_interrupt_entry
-	lbz	r10,PACAPROCENABLED(r13)
-	std	r10,SOFTE(r1)
 #endif
 	mfmsr	r11
 	ori	r11,r11,MSR_EE
@@ -461,8 +459,8 @@ #else /* !CONFIG_PREEMPT */
 #endif
 
 restore:
-#ifdef CONFIG_PPC_ISERIES
 	ld	r5,SOFTE(r1)
+#ifdef CONFIG_PPC_ISERIES
 	cmpdi	0,r5,0
 	beq	4f
 	/* Check for pending interrupts (iSeries) */
@@ -479,8 +477,9 @@ #ifdef CONFIG_PPC_ISERIES
 	bl	.do_IRQ
 	b	.ret_from_except_lite		/* loop back and handle more */
 
-4:	stb	r5,PACAPROCENABLED(r13)
+4:
 #endif
+	stb	r5,PACAPROCENABLED(r13)
 
 	ld	r3,_MSR(r1)
 	andi.	r0,r3,MSR_RI
@@ -537,20 +536,15 @@ #ifdef CONFIG_PREEMPT
 	/* Check that preempt_count() == 0 and interrupts are enabled */
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
-#ifdef CONFIG_PPC_ISERIES
 	ld	r0,SOFTE(r1)
 	cmpdi	r0,0
-#else
-	andi.	r0,r3,MSR_EE
-#endif
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 	/* here we are preempting the current task */
 1:
-#ifdef CONFIG_PPC_ISERIES
 	li	r0,1
 	stb	r0,PACAPROCENABLED(r13)
-#endif
+	stb	r0,PACAHARDIRQEN(r13)
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1		/* reenable interrupts */
 	bl	.preempt_schedule
@@ -633,8 +627,7 @@ _GLOBAL(enter_rtas)
 	/* There is no way it is acceptable to get here with interrupts enabled,
 	 * check it with the asm equivalent of WARN_ON
 	 */
-	mfmsr	r6
-	andi.	r0,r6,MSR_EE
+	lbz	r0,PACAPROCENABLED(r13)
 1:	tdnei	r0,0
 .section __bug_table,"a"
 	.llong	1b,__LINE__ + 0x1000000, 1f, 2f
@@ -643,7 +636,13 @@ _GLOBAL(enter_rtas)
 1:	.asciz	__FILE__
 2:	.asciz "enter_rtas"
 .previous
-	
+
+	/* Hard-disable interrupts */
+	mfmsr	r6
+	rldicl	r7,r6,48,1
+	rotldi	r7,r7,16
+	mtmsrd	r7,1
+
 	/* Unfortunately, the stack pointer and the MSR are also clobbered,
 	 * so they are saved in the PACA which allows us to restore
 	 * our original state after RTAS returns.
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 3065b47..8981b32 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -34,9 +34,7 @@ #include <asm/hvcall.h>
 #include <asm/iseries/lpar_map.h>
 #include <asm/thread_info.h>
 
-#ifdef CONFIG_PPC_ISERIES
 #define DO_SOFT_DISABLE
-#endif
 
 /*
  * We layout physical memory as follows:
@@ -307,7 +305,9 @@ #define EXCEPTION_PROLOG_COMMON(n, area)
 	std	r9,_LINK(r1);						   \
 	mfctr	r10;			/* save CTR in stackframe	*/ \
 	std	r10,_CTR(r1);						   \
+	lbz	r10,PACAPROCENABLED(r13);				   \
 	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
+	std	r10,SOFTE(r1);						   \
 	std	r11,_XER(r1);						   \
 	li	r9,(n)+1;						   \
 	std	r9,_TRAP(r1);		/* set trap number		*/ \
@@ -342,6 +342,34 @@ label##_pSeries:					\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
 
+#define MASKABLE_EXCEPTION_PSERIES(n, label)				\
+	. = n;								\
+	.globl label##_pSeries;						\
+label##_pSeries:							\
+	HMT_MEDIUM;							\
+	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
+	mfspr	r13,SPRN_SPRG3;		/* get paca address into r13 */	\
+	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
+	std	r10,PACA_EXGEN+EX_R10(r13);				\
+	lbz	r10,PACAPROCENABLED(r13);				\
+	mfcr	r9;							\
+	cmpwi	r10,0;							\
+	beq	masked_interrupt;					\
+	mfspr	r10,SPRN_SPRG1;						\
+	std	r10,PACA_EXGEN+EX_R13(r13);				\
+	std	r11,PACA_EXGEN+EX_R11(r13);				\
+	std	r12,PACA_EXGEN+EX_R12(r13);				\
+	clrrdi	r12,r13,32;		/* get high part of &label */	\
+	mfmsr	r10;							\
+	mfspr	r11,SPRN_SRR0;		/* save SRR0 */			\
+	LOAD_HANDLER(r12,label##_common)				\
+	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI;				\
+	mtspr	SPRN_SRR0,r12;						\
+	mfspr	r12,SPRN_SRR1;		/* and SRR1 */			\
+	mtspr	SPRN_SRR1,r10;						\
+	rfid;								\
+	b	.	/* prevent speculative execution */
+
 #define STD_EXCEPTION_ISERIES(n, label, area)		\
 	.globl label##_iSeries;				\
 label##_iSeries:					\
@@ -363,25 +391,19 @@ label##_iSeries:							\
 	EXCEPTION_PROLOG_ISERIES_2;					\
 	b	label##_common;						\
 
-#ifdef DO_SOFT_DISABLE
+#ifndef CONFIG_PPC_ISERIES
+#define DISABLE_INTS				\
+	li	r11,0;				\
+	stb	r11,PACAPROCENABLED(r13);	\
+	stb	r11,PACAHARDIRQEN(r13)
+#else
 #define DISABLE_INTS				\
-	lbz	r10,PACAPROCENABLED(r13);	\
 	li	r11,0;				\
-	std	r10,SOFTE(r1);			\
 	mfmsr	r10;				\
 	stb	r11,PACAPROCENABLED(r13);	\
 	ori	r10,r10,MSR_EE;			\
 	mtmsrd	r10,1
-
-#define ENABLE_INTS				\
-	lbz	r10,PACAPROCENABLED(r13);	\
-	mfmsr	r11;				\
-	std	r10,SOFTE(r1);			\
-	ori	r11,r11,MSR_EE;			\
-	mtmsrd	r11,1
-
-#else	/* hard enable/disable interrupts */
-#define DISABLE_INTS
+#endif
 
 #define ENABLE_INTS				\
 	ld	r12,_MSR(r1);			\
@@ -389,8 +411,6 @@ #define ENABLE_INTS				\
 	rlwimi	r11,r12,0,MSR_EE;		\
 	mtmsrd	r11,1
 
-#endif
-
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)		\
 	.align	7;					\
 	.globl label##_common;				\
@@ -531,11 +551,11 @@ #endif /* __DISABLED__ */
 	mfspr	r12,SPRN_SRR1		/* and SRR1 */
 	b	.slb_miss_realmode	/* Rel. branch works in real mode */
 
-	STD_EXCEPTION_PSERIES(0x500, hardware_interrupt)
+	MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt)
 	STD_EXCEPTION_PSERIES(0x600, alignment)
 	STD_EXCEPTION_PSERIES(0x700, program_check)
 	STD_EXCEPTION_PSERIES(0x800, fp_unavailable)
-	STD_EXCEPTION_PSERIES(0x900, decrementer)
+	MASKABLE_EXCEPTION_PSERIES(0x900, decrementer)
 	STD_EXCEPTION_PSERIES(0xa00, trap_0a)
 	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
 
@@ -587,7 +607,24 @@ #endif /* CONFIG_CBE_RAS */
 /*** pSeries interrupt support ***/
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES(., performance_monitor)
+	MASKABLE_EXCEPTION_PSERIES(., performance_monitor)
+
+/*
+ * An interrupt came in while soft-disabled; clear EE in SRR1,
+ * clear paca->hard_enabled and return.
+ */
+masked_interrupt:
+	stb	r10,PACAHARDIRQEN(r13)
+	mtcrf	0x80,r9
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	mfspr	r10,SPRN_SRR1
+	rldicl	r10,r10,48,1		/* clear MSR_EE */
+	rotldi	r10,r10,16
+	mtspr	SPRN_SRR1,r10
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	mfspr	r13,SPRN_SPRG1
+	rfid
+	b	.
 
 	.align	7
 _GLOBAL(do_stab_bolted_pSeries)
@@ -942,7 +979,8 @@ #endif
 	REST_8GPRS(2, r1)
 
 	mfmsr	r10
-	clrrdi	r10,r10,2		/* clear RI (LE is 0 already) */
+	rldicl	r10,r10,48,1		/* clear EE */
+	rldicr	r10,r10,16,61		/* clear RI (LE is 0 already) */
 	mtmsrd	r10,1
 
 	mtspr	SPRN_SRR1,r12
@@ -1860,8 +1898,11 @@ _GLOBAL(__secondary_start)
 	/* enable MMU and jump to start_secondary */
 	LOAD_REG_ADDR(r3, .start_secondary_prolog)
 	LOAD_REG_IMMEDIATE(r4, MSR_KERNEL)
-#ifdef DO_SOFT_DISABLE
+#ifdef CONFIG_PPC_ISERIES
 	ori	r4,r4,MSR_EE
+#else
+	stb	r7,PACAPROCENABLED(r13)
+	stb	r7,PACAHARDIRQEN(r13)
 #endif
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
@@ -1999,9 +2040,11 @@ _STATIC(start_here_common)
 
 	/* Load up the kernel context */
 5:
-#ifdef DO_SOFT_DISABLE
 	li	r5,0
 	stb	r5,PACAPROCENABLED(r13)	/* Soft Disabled */
+#ifndef CONFIG_PPC_ISERIES
+	stb	r5,PACAHARDIRQEN(r13)	/* hard-disabled too */
+#else
 	mfmsr	r5
 	ori	r5,r5,MSR_EE		/* Hard Enabled */
 	mtmsrd	r5
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 30de81d..2eac58d 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -30,6 +30,13 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	beqlr
 
 	/* Go to NAP now */
+	mfmsr	r7
+	rldicl	r0,r7,48,1
+	rotldi	r0,r0,16
+	mtmsrd	r0,1			/* hard-disable interrupts */
+	li	r0,1
+	stb	r0,PACAPROCENABLED(r13)	/* we'll hard-enable shortly */
+	stb	r0,PACAHARDIRQEN(r13)
 BEGIN_FTR_SECTION
 	DSSALL
 	sync
@@ -38,7 +45,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
-	mfmsr	r7
 	ori	r7,r7,MSR_EE
 	oris	r7,r7,MSR_POW@h
 1:	sync
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index b443233..efbd77a 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -95,6 +95,20 @@ #ifdef CONFIG_PPC64
 EXPORT_SYMBOL(irq_desc);
 
 int distribute_irqs = 1;
+
+#ifndef CONFIG_PPC_ISERIES
+void local_irq_restore(unsigned long en)
+{
+	get_paca()->proc_enabled = en;
+	if (!en || get_paca()->hard_enabled)
+		return;
+	/* need to hard-enable interrupts here */
+	get_paca()->hard_enabled = en;
+	if ((int)mfspr(SPRN_DEC) < 0)
+		mtspr(SPRN_DEC, 1);
+	hard_irq_enable();
+}
+#endif /* CONFIG_PPC_ISERIES */
 #endif /* CONFIG_PPC64 */
 
 int show_interrupts(struct seq_file *p, void *v)
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 807193a..9179f07 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -49,6 +49,10 @@ #ifdef  CONFIG_8xx
 #include <asm/commproc.h>
 #endif
 
+#ifdef CONFIG_PPC64
+EXPORT_SYMBOL(local_irq_restore);
+#endif
+
 #ifdef CONFIG_PPC32
 extern void transfer_to_handler(void);
 extern void do_IRQ(struct pt_regs *regs);
diff --git a/arch/powerpc/platforms/iseries/ksyms.c b/arch/powerpc/platforms/iseries/ksyms.c
index a220084..2430848 100644
--- a/arch/powerpc/platforms/iseries/ksyms.c
+++ b/arch/powerpc/platforms/iseries/ksyms.c
@@ -19,9 +19,3 @@ EXPORT_SYMBOL(HvCall4);
 EXPORT_SYMBOL(HvCall5);
 EXPORT_SYMBOL(HvCall6);
 EXPORT_SYMBOL(HvCall7);
-
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(local_get_flags);
-EXPORT_SYMBOL(local_irq_disable);
-EXPORT_SYMBOL(local_irq_restore);
-#endif
diff --git a/arch/powerpc/platforms/iseries/misc.S b/arch/powerpc/platforms/iseries/misc.S
index 7641fc7..385a627 100644
--- a/arch/powerpc/platforms/iseries/misc.S
+++ b/arch/powerpc/platforms/iseries/misc.S
@@ -19,18 +19,6 @@ #include <asm/ppc_asm.h>
 
 	.text
 
-/* unsigned long local_save_flags(void) */
-_GLOBAL(local_get_flags)
-	lbz	r3,PACAPROCENABLED(r13)
-	blr
-
-/* unsigned long local_irq_disable(void) */
-_GLOBAL(local_irq_disable)
-	lbz	r3,PACAPROCENABLED(r13)
-	li	r4,0
-	stb	r4,PACAPROCENABLED(r13)
-	blr			/* Done */
-
 /* void local_irq_restore(unsigned long flags) */
 _GLOBAL(local_irq_restore)
 	lbz	r5,PACAPROCENABLED(r13)
diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
index d403592..66cc2ac 100644
--- a/include/asm-powerpc/hw_irq.h
+++ b/include/asm-powerpc/hw_irq.h
@@ -7,15 +7,28 @@ #define _ASM_POWERPC_HW_IRQ_H
 #ifdef __KERNEL__
 
 #include <linux/errno.h>
+#include <linux/compiler.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
 extern void timer_interrupt(struct pt_regs *);
 
-#ifdef CONFIG_PPC_ISERIES
+#ifdef CONFIG_PPC64
+#include <asm/paca.h>
+
+static inline unsigned long local_get_flags(void)
+{
+	return get_paca()->proc_enabled;
+}
+
+static inline unsigned long local_irq_disable(void)
+{
+	unsigned long flag = get_paca()->proc_enabled;
+	get_paca()->proc_enabled = 0;
+	barrier();
+	return flag;
+}
 
-extern unsigned long local_get_flags(void);
-extern unsigned long local_irq_disable(void);
 extern void local_irq_restore(unsigned long);
 
 #define local_irq_enable()	local_irq_restore(1)
@@ -24,17 +37,14 @@ #define local_irq_save(flags)	((flags) =
 
 #define irqs_disabled()		(local_get_flags() == 0)
 
+#define hard_irq_enable()	__mtmsrd(mfmsr() | MSR_EE, 1)
+#define hard_irq_disable()	__mtmsrd(mfmsr() & ~MSR_EE, 1)
+
 #else
 
 #if defined(CONFIG_BOOKE)
 #define SET_MSR_EE(x)	mtmsr(x)
 #define local_irq_restore(flags)	__asm__ __volatile__("wrtee %0" : : "r" (flags) : "memory")
-#elif defined(__powerpc64__)
-#define SET_MSR_EE(x)	__mtmsrd(x, 1)
-#define local_irq_restore(flags) do { \
-	__asm__ __volatile__("": : :"memory"); \
-	__mtmsrd((flags), 1); \
-} while(0)
 #else
 #define SET_MSR_EE(x)	mtmsr(x)
 #define local_irq_restore(flags)	mtmsr(flags)
@@ -81,7 +91,7 @@ #define local_save_flags(flags)	((flags)
 #define local_irq_save(flags)	local_irq_save_ptr(&flags)
 #define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
 
-#endif /* CONFIG_PPC_ISERIES */
+#endif /* CONFIG_PPC64 */
 
 #define mask_irq(irq)						\
 	({							\
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 0a4e5c9..9ef277e 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -94,6 +94,7 @@ #endif /* CONFIG_PPC_ISERIES */
 	u64 saved_r1;			/* r1 save for RTAS calls */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u8 proc_enabled;		/* irq soft-enable flag */
+	u8 hard_enabled;		/* set if irqs are enabled in MSR */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 
 	/* Stuff for accurate time accounting */
