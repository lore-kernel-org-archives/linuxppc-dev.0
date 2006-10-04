Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17699.22805.658581.839928@cargo.ozlabs.ibm.com>
Date: Wed, 4 Oct 2006 16:47:49 +1000
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

This version renames paca->proc_enabled to paca->soft_enabled, and
changes a couple of soft-disables in the kexec code to hard-disables,
which should fix the crash that Michael Ellerman saw.  This doesn't
yet use a reserved CR field for the soft_enabled and hard_enabled
flags.  This applies on top of Stephen Rothwell's patches to make it
possible to build a combined iSeries/other kernel.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d06f378..e965215 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -118,7 +118,8 @@ #ifdef CONFIG_PPC64
 	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_rr));
 	DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
 	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
-	DEFINE(PACAPROCENABLED, offsetof(struct paca_struct, proc_enabled));
+	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
+	DEFINE(PACAHARDIRQEN, offsetof(struct paca_struct, hard_enabled));
 	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
 	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 1af41f7..89b03c8 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -111,7 +111,7 @@ void crash_ipi_callback(struct pt_regs *
 	if (!cpu_online(cpu))
 		return;
 
-	local_irq_disable();
+	hard_irq_disable();
 	if (!cpu_isset(cpu, cpus_in_crash))
 		crash_save_this_cpu(regs, cpu);
 	cpu_set(cpu, cpus_in_crash);
@@ -289,7 +289,7 @@ void default_machine_crash_shutdown(stru
 	 * an SMP system.
 	 * The kernel is broken so disable interrupts.
 	 */
-	local_irq_disable();
+	hard_irq_disable();
 
 	for_each_irq(irq) {
 		struct irq_desc *desc = irq_desc + irq;
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 748e74f..efda487 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -87,6 +87,10 @@ system_call_common:
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+	li	r10,1
+	stb	r10,PACASOFTIRQEN(r13)
+	stb	r10,PACAHARDIRQEN(r13)
+	std	r10,SOFTE(r1)
 #ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
 	/* Hack for handling interrupts when soft-enabling on iSeries */
@@ -94,8 +98,6 @@ BEGIN_FW_FTR_SECTION
 	andi.	r10,r12,MSR_PR		/* from kernel */
 	crand	4*cr0+eq,4*cr1+eq,4*cr0+eq
 	beq	hardware_interrupt_entry
-	lbz	r10,PACAPROCENABLED(r13)
-	std	r10,SOFTE(r1)
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 	mfmsr	r11
@@ -460,9 +462,9 @@ #else /* !CONFIG_PREEMPT */
 #endif
 
 restore:
+	ld	r5,SOFTE(r1)
 #ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
-	ld	r5,SOFTE(r1)
 	cmpdi	0,r5,0
 	beq	4f
 	/* Check for pending interrupts (iSeries) */
@@ -472,16 +474,16 @@ BEGIN_FW_FTR_SECTION
 	beq+	4f			/* skip do_IRQ if no interrupts */
 
 	li	r3,0
-	stb	r3,PACAPROCENABLED(r13)	/* ensure we are soft-disabled */
+	stb	r3,PACASOFTIRQEN(r13)	/* ensure we are soft-disabled */
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10			/* hard-enable again */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
 	b	.ret_from_except_lite		/* loop back and handle more */
-
-4:	stb	r5,PACAPROCENABLED(r13)
+4:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
+	stb	r5,PACASOFTIRQEN(r13)
 
 	ld	r3,_MSR(r1)
 	andi.	r0,r3,MSR_RI
@@ -538,25 +540,15 @@ #ifdef CONFIG_PREEMPT
 	/* Check that preempt_count() == 0 and interrupts are enabled */
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
 	ld	r0,SOFTE(r1)
 	cmpdi	r0,0
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
-BEGIN_FW_FTR_SECTION
-	andi.	r0,r3,MSR_EE
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 	/* here we are preempting the current task */
 1:
-#ifdef CONFIG_PPC_ISERIES
-BEGIN_FW_FTR_SECTION
 	li	r0,1
-	stb	r0,PACAPROCENABLED(r13)
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
-#endif
+	stb	r0,PACASOFTIRQEN(r13)
+	stb	r0,PACAHARDIRQEN(r13)
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1		/* reenable interrupts */
 	bl	.preempt_schedule
@@ -639,8 +631,7 @@ _GLOBAL(enter_rtas)
 	/* There is no way it is acceptable to get here with interrupts enabled,
 	 * check it with the asm equivalent of WARN_ON
 	 */
-	mfmsr	r6
-	andi.	r0,r6,MSR_EE
+	lbz	r0,PACASOFTIRQEN(r13)
 1:	tdnei	r0,0
 .section __bug_table,"a"
 	.llong	1b,__LINE__ + 0x1000000, 1f, 2f
@@ -649,7 +640,13 @@ _GLOBAL(enter_rtas)
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
index 645c7f1..c93d9f3 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -35,9 +35,7 @@ #include <asm/iseries/lpar_map.h>
 #include <asm/thread_info.h>
 #include <asm/firmware.h>
 
-#ifdef CONFIG_PPC_ISERIES
 #define DO_SOFT_DISABLE
-#endif
 
 /*
  * We layout physical memory as follows:
@@ -308,7 +306,9 @@ #define EXCEPTION_PROLOG_COMMON(n, area)
 	std	r9,_LINK(r1);						   \
 	mfctr	r10;			/* save CTR in stackframe	*/ \
 	std	r10,_CTR(r1);						   \
+	lbz	r10,PACASOFTIRQEN(r13);				   \
 	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
+	std	r10,SOFTE(r1);						   \
 	std	r11,_XER(r1);						   \
 	li	r9,(n)+1;						   \
 	std	r9,_TRAP(r1);		/* set trap number		*/ \
@@ -343,6 +343,34 @@ label##_pSeries:					\
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
+	lbz	r10,PACASOFTIRQEN(r13);					\
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
@@ -358,40 +386,32 @@ label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRN_SPRG1,r13;		/* save r13 */			\
 	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN);				\
-	lbz	r10,PACAPROCENABLED(r13);				\
+	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	0,r10,0;						\
 	beq-	label##_iSeries_masked;					\
 	EXCEPTION_PROLOG_ISERIES_2;					\
 	b	label##_common;						\
 
-#ifdef DO_SOFT_DISABLE
+#ifdef CONFIG_PPC_ISERIES
 #define DISABLE_INTS				\
-BEGIN_FW_FTR_SECTION;				\
-	lbz	r10,PACAPROCENABLED(r13);	\
 	li	r11,0;				\
-	std	r10,SOFTE(r1);			\
+	stb	r11,PACASOFTIRQEN(r13);		\
+BEGIN_FW_FTR_SECTION;				\
+	stb	r11,PACAHARDIRQEN(r13);		\
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES);	\
+BEGIN_FW_FTR_SECTION;				\
 	mfmsr	r10;				\
-	stb	r11,PACAPROCENABLED(r13);	\
 	ori	r10,r10,MSR_EE;			\
 	mtmsrd	r10,1;				\
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 
-#define ENABLE_INTS				\
-BEGIN_FW_FTR_SECTION;				\
-	lbz	r10,PACAPROCENABLED(r13);	\
-	mfmsr	r11;				\
-	std	r10,SOFTE(r1);			\
-	ori	r11,r11,MSR_EE;			\
-END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES);	\
-BEGIN_FW_FTR_SECTION;				\
-	ld	r12,_MSR(r1);			\
-	mfmsr	r11;				\
-	rlwimi	r11,r12,0,MSR_EE;		\
-END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES);	\
-	mtmsrd	r11,1
+#else
+#define DISABLE_INTS				\
+	li	r11,0;				\
+	stb	r11,PACASOFTIRQEN(r13);		\
+	stb	r11,PACAHARDIRQEN(r13)
 
-#else	/* hard enable/disable interrupts */
-#define DISABLE_INTS
+#endif /* CONFIG_PPC_ISERIES */
 
 #define ENABLE_INTS				\
 	ld	r12,_MSR(r1);			\
@@ -399,8 +419,6 @@ #define ENABLE_INTS				\
 	rlwimi	r11,r12,0,MSR_EE;		\
 	mtmsrd	r11,1
 
-#endif
-
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)		\
 	.align	7;					\
 	.globl label##_common;				\
@@ -541,11 +559,11 @@ #endif /* __DISABLED__ */
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
 
@@ -597,7 +615,24 @@ #endif /* CONFIG_CBE_RAS */
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
@@ -952,7 +987,8 @@ #endif
 	REST_8GPRS(2, r1)
 
 	mfmsr	r10
-	clrrdi	r10,r10,2		/* clear RI (LE is 0 already) */
+	rldicl	r10,r10,48,1		/* clear EE */
+	rldicr	r10,r10,16,61		/* clear RI (LE is 0 already) */
 	mtmsrd	r10,1
 
 	mtspr	SPRN_SRR1,r12
@@ -1877,11 +1913,16 @@ _GLOBAL(__secondary_start)
 	/* enable MMU and jump to start_secondary */
 	LOAD_REG_ADDR(r3, .start_secondary_prolog)
 	LOAD_REG_IMMEDIATE(r4, MSR_KERNEL)
-#ifdef DO_SOFT_DISABLE
+#ifdef CONFIG_PPC_ISERIES
 BEGIN_FW_FTR_SECTION
 	ori	r4,r4,MSR_EE
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
+BEGIN_FW_FTR_SECTION
+	stb	r7,PACASOFTIRQEN(r13)
+	stb	r7,PACAHARDIRQEN(r13)
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
+
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
 	rfid
@@ -2019,15 +2060,18 @@ _STATIC(start_here_common)
 
 	/* Load up the kernel context */
 5:
-#ifdef DO_SOFT_DISABLE
-BEGIN_FW_FTR_SECTION
 	li	r5,0
-	stb	r5,PACAPROCENABLED(r13)	/* Soft Disabled */
+	stb	r5,PACASOFTIRQEN(r13)	/* Soft Disabled */
+#ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	mfmsr	r5
 	ori	r5,r5,MSR_EE		/* Hard Enabled */
 	mtmsrd	r5
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
+BEGIN_FW_FTR_SECTION
+	stb	r5,PACAHARDIRQEN(r13)
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 
 	bl .start_kernel
 
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 30de81d..ba31954 100644
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
+	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
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
index c3f58f2..d4aa490 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -64,8 +64,9 @@ #include <asm/prom.h>
 #include <asm/ptrace.h>
 #include <asm/machdep.h>
 #include <asm/udbg.h>
-#ifdef CONFIG_PPC_ISERIES
+#ifdef CONFIG_PPC64
 #include <asm/paca.h>
+#include <asm/firmware.h>
 #endif
 
 int __irq_offset_value;
@@ -95,6 +96,27 @@ #ifdef CONFIG_PPC64
 EXPORT_SYMBOL(irq_desc);
 
 int distribute_irqs = 1;
+
+void local_irq_restore(unsigned long en)
+{
+	get_paca()->soft_enabled = en;
+	if (!en)
+		return;
+
+	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+		if (get_paca()->lppaca_ptr->int_dword.any_int)
+			iseries_handle_interrupts();
+		return;
+	}
+
+	if (get_paca()->hard_enabled)
+		return;
+	/* need to hard-enable interrupts here */
+	get_paca()->hard_enabled = en;
+	if ((int)mfspr(SPRN_DEC) < 0)
+		mtspr(SPRN_DEC, 1);
+	hard_irq_enable();
+}
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
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4b2e32e..b1b0cda 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -223,8 +223,8 @@ void early_setup_secondary(void)
 {
 	struct paca_struct *lpaca = get_paca();
 
-	/* Mark enabled in PACA */
-	lpaca->proc_enabled = 0;
+	/* Mark interrupts enabled in PACA */
+	lpaca->soft_enabled = 0;
 
 	/* Initialize hash table for that CPU */
 	htab_initialize_secondary();
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
index 7641fc7..2c6ff0f 100644
--- a/arch/powerpc/platforms/iseries/misc.S
+++ b/arch/powerpc/platforms/iseries/misc.S
@@ -19,39 +19,8 @@ #include <asm/ppc_asm.h>
 
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
-/* void local_irq_restore(unsigned long flags) */
-_GLOBAL(local_irq_restore)
-	lbz	r5,PACAPROCENABLED(r13)
-	 /* Check if things are setup the way we want _already_. */
-	cmpw	0,r3,r5
-	beqlr
-	/* are we enabling interrupts? */
-	cmpdi	0,r3,0
-	stb	r3,PACAPROCENABLED(r13)
-	beqlr
-	/* Check pending interrupts */
-	/*   A decrementer, IPI or PMC interrupt may have occurred
-	 *   while we were in the hypervisor (which enables) */
-	ld	r4,PACALPPACAPTR(r13)
-	ld	r4,LPPACAANYINT(r4)
-	cmpdi	r4,0
-	beqlr
-
-	/*
-	 * Handle pending interrupts in interrupt context
-	 */
+/* Handle pending interrupts in interrupt context */
+_GLOBAL(iseries_handle_interrupts)
 	li	r0,0x5555
 	sc
 	blr
diff --git a/include/asm-powerpc/hw_irq.h b/include/asm-powerpc/hw_irq.h
index d403592..c4a1ab6 100644
--- a/include/asm-powerpc/hw_irq.h
+++ b/include/asm-powerpc/hw_irq.h
@@ -7,16 +7,30 @@ #define _ASM_POWERPC_HW_IRQ_H
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
+	return get_paca()->soft_enabled;
+}
+
+static inline unsigned long local_irq_disable(void)
+{
+	unsigned long flag = get_paca()->soft_enabled;
+	get_paca()->soft_enabled = 0;
+	barrier();
+	return flag;
+}
 
-extern unsigned long local_get_flags(void);
-extern unsigned long local_irq_disable(void);
 extern void local_irq_restore(unsigned long);
+extern void iseries_handle_interrupts(void);
 
 #define local_irq_enable()	local_irq_restore(1)
 #define local_save_flags(flags)	((flags) = local_get_flags())
@@ -24,17 +38,14 @@ #define local_irq_save(flags)	((flags) =
 
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
@@ -81,7 +92,7 @@ #define local_save_flags(flags)	((flags)
 #define local_irq_save(flags)	local_irq_save_ptr(&flags)
 #define irqs_disabled()		((mfmsr() & MSR_EE) == 0)
 
-#endif /* CONFIG_PPC_ISERIES */
+#endif /* CONFIG_PPC64 */
 
 #define mask_irq(irq)						\
 	({							\
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index 0a4e5c9..0d3adc0 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -93,7 +93,8 @@ #endif /* CONFIG_PPC_ISERIES */
 	u64 stab_rr;			/* stab/slb round-robin counter */
 	u64 saved_r1;			/* r1 save for RTAS calls */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
-	u8 proc_enabled;		/* irq soft-enable flag */
+	u8 soft_enabled;		/* irq soft-enable flag */
+	u8 hard_enabled;		/* set if irqs are enabled in MSR */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 
 	/* Stuff for accurate time accounting */
