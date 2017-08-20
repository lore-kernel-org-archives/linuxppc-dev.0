Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb4Mm69QFzDr54
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:32 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KHx1td145943
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:30 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cefnrben1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:30 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 03:59:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7KHxPgg33554562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7KHxGO6009803
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:16 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 07/14] powerpc: Change from enable flag to disable bitmask
Date: Sun, 20 Aug 2017 23:28:24 +0530
In-Reply-To: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1503251911-30637-8-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"paca->soft_enabled" is used as a flag to mask some of interrupts.
Currently supported flags values and their details:

soft_enabled    MSR[EE]

0               0       Disabled (PMI and HMI not masked)
1               1       Enabled

"paca->soft_enabled" is initialized to 1 to make the interripts as
enabled. arch_local_irq_disable() will toggle the value when interrupts
needs to disbled. At this point, the interrupts are not actually disabled,
instead, interrupt vector has code to check for the flag and mask it when it occurs.
By "mask it", it update interrupt paca->irq_happened and return.
arch_local_irq_restore() is called to re-enable interrupts, which checks and
replays interrupts if any occured.

Now, as mentioned, current logic doesnot mask "performance monitoring interrupts"
and PMIs are implemented as NMI. But this patchset depends on local_irq_*
for a successful local_* update. Meaning, mask all possible interrupts during
local_* update and replay them after the update.

So the idea here is to reserve the "paca->soft_enabled" logic. New values and
details:

soft_enabled    MSR[EE]

1               0       Disabled  (PMI and HMI not masked)
0               1       Enabled

Reason for the this change is to create foundation for a third mask value "0x2"
for "soft_enabled" to add support to mask PMIs. When ->soft_enabled is
set to a value "3", PMI interrupts are mask and when set to a value
of "1", PMI are not mask. With this patch also extends soft_enabled as
interrupt disable mask.

Current flags are renamed from IRQ_[EN?DIS}ABLED to IRQ_DISABLE_MASK_NONE and
IRQ_DISABLE_MASK_LINUX.

Patch also fixes the ptrace call to force the user to see the softe value
to be alway 1. Reason being, even though userspace has no business knowing about
softe, it is part of pt_regs. Like-wise in signal context.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  4 ++--
 arch/powerpc/include/asm/hw_irq.h        | 14 +++++++-------
 arch/powerpc/include/asm/irqflags.h      |  8 ++++----
 arch/powerpc/include/asm/kvm_ppc.h       |  2 +-
 arch/powerpc/kernel/entry_64.S           | 27 +++++++++++++--------------
 arch/powerpc/kernel/exceptions-64e.S     | 10 +++++-----
 arch/powerpc/kernel/head_64.S            |  6 +++---
 arch/powerpc/kernel/idle_book3e.S        |  2 +-
 arch/powerpc/kernel/idle_power4.S        |  2 +-
 arch/powerpc/kernel/irq.c                | 12 ++++++++----
 arch/powerpc/kernel/process.c            |  2 +-
 arch/powerpc/kernel/ptrace.c             | 10 ++++++++++
 arch/powerpc/kernel/setup_64.c           |  4 ++--
 arch/powerpc/kernel/signal_32.c          |  8 ++++++++
 arch/powerpc/kernel/signal_64.c          |  3 +++
 arch/powerpc/kernel/time.c               |  2 +-
 arch/powerpc/mm/hugetlbpage.c            |  2 +-
 arch/powerpc/perf/core-book3s.c          |  2 +-
 18 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 05523e825147..ad7340ce5c15 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -494,9 +494,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,IRQ_DISABLED;				\
+	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	beq	masked_##h##interrupt
+	bne	masked_##h##interrupt
 
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 85f67a4938a5..cfea88260e85 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -30,8 +30,8 @@
 /*
  * flags for paca->soft_enabled
  */
-#define IRQ_ENABLED	1
-#define IRQ_DISABLED	0
+#define IRQ_DISABLE_MASK_NONE	0
+#define IRQ_DISABLE_MASK_LINUX	1
 
 #endif /* CONFIG_PPC64 */
 
@@ -94,12 +94,12 @@ extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(IRQ_ENABLED);
+	arch_local_irq_restore(IRQ_DISABLE_MASK_NONE);
 }
 
 static inline unsigned long arch_local_irq_save(void)
 {
-	return soft_enabled_set_return(IRQ_DISABLED);
+	return soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
 }
 
 static inline void arch_local_irq_disable(void)
@@ -109,7 +109,7 @@ static inline void arch_local_irq_disable(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == IRQ_DISABLED;
+	return flags & IRQ_DISABLE_MASK_LINUX;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -128,7 +128,7 @@ static inline bool arch_irqs_disabled(void)
 #define hard_irq_disable()	do {			\
 	unsigned long flags;				\
 	__hard_irq_disable();				\
-	flags = soft_enabled_set_return(IRQ_DISABLED);	\
+	flags = soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
 	if (!arch_irqs_disabled_flags(flags))		\
 		trace_hardirqs_off();			\
@@ -153,7 +153,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return (regs->softe == IRQ_DISABLED);
+	return (regs->softe & IRQ_DISABLE_MASK_LINUX);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 16eafcec58a4..9ff09747a226 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -48,11 +48,11 @@
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	cmpwi	cr0,__rA,IRQ_DISABLED;\
-	li	__rA,IRQ_DISABLED;	\
+	andi.	__rA,__rA,IRQ_DISABLE_MASK_LINUX;\
+	li	__rA,IRQ_DISABLE_MASK_LINUX;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
-	beq	44f;				\
+	bne	44f;				\
 	stb	__rA,PACASOFTIRQEN(r13);	\
 	TRACE_DISABLE_INTS;			\
 44:
@@ -63,7 +63,7 @@
 
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	li	__rB,IRQ_DISABLED;	\
+	li	__rB,IRQ_DISABLE_MASK_LINUX;	\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACASOFTIRQEN(r13);	\
 	stb	__rA,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 76f82014cd80..0e90dbe46b5b 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -869,7 +869,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	soft_enabled_set(IRQ_ENABLED);
+	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
 #endif
 }
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6b343d2ba405..31d800778c74 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -130,8 +130,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 */
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
 	lbz	r10,PACASOFTIRQEN(r13)
-	xori	r10,r10,IRQ_ENABLED
-1:	tdnei	r10,0
+1:	tdnei	r10,IRQ_DISABLE_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
@@ -147,7 +146,7 @@ system_call:			/* label this so stack traces look sane */
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
 	 */
-	li	r10,IRQ_ENABLED
+	li	r10,IRQ_DISABLE_MASK_NONE
 	std	r10,SOFTE(r1)
 
 	CURRENT_THREAD_INFO(r11, r1)
@@ -741,10 +740,10 @@ resume_kernel:
 	beq+	restore
 	/* Check that preempt_count() == 0 and interrupts are enabled */
 	lwz	r8,TI_PREEMPT(r9)
-	cmpwi	cr1,r8,0
+	cmpwi	cr0,r8,0
+	bne	restore
 	ld	r0,SOFTE(r1)
-	cmpdi	r0,IRQ_DISABLED
-	crandc	eq,cr1*4+eq,eq
+	andi.	r0,r0,IRQ_DISABLE_MASK_LINUX
 	bne	restore
 
 	/*
@@ -783,11 +782,11 @@ restore:
 	 */
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
-	cmpwi	cr0,r5,IRQ_DISABLED
-	beq	.Lrestore_irq_off
+	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
+	bne	.Lrestore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
-	cmpwi	cr0,r6,IRQ_ENABLED
+	andi.	r6,r6,IRQ_DISABLE_MASK_LINUX
 	beq	cr0,.Ldo_restore
 
 	/*
@@ -806,7 +805,7 @@ restore:
 	 */
 .Lrestore_no_replay:
 	TRACE_ENABLE_INTS
-	li	r0,IRQ_ENABLED
+	li	r0,IRQ_DISABLE_MASK_NONE
 	stb	r0,PACASOFTIRQEN(r13);
 
 	/*
@@ -911,7 +910,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	beq	1f
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
-1:	li	r0,IRQ_DISABLED
+1:	li	r0,IRQ_DISABLE_MASK_LINUX
 	stb	r0,PACASOFTIRQEN(r13);
 	TRACE_DISABLE_INTS
 	b	.Ldo_restore
@@ -1032,15 +1031,15 @@ _GLOBAL(enter_rtas)
 	li	r0,0
 	mtcr	r0
 
-#ifdef CONFIG_BUG	
+#ifdef CONFIG_BUG
 	/* There is no way it is acceptable to get here with interrupts enabled,
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,IRQ_DISABLED
+1:	tdeqi	r0,IRQ_DISABLE_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
-	
+
 	/* Hard-disable interrupts */
 	mfmsr	r6
 	rldicl	r7,r6,48,1
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 1ca9ed89ed0b..6b5f4038e961 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -210,10 +210,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	ld	r5,SOFTE(r1)
 
 	/* Interrupts had better not already be enabled... */
-	twnei	r6,IRQ_DISABLED
+	twnei	r6,IRQ_DISABLE_MASK_NONE
 
-	cmpwi	cr0,r5,IRQ_DISABLED
-	beq	1f
+	andi.	r6,r5,IRQ_DISABLE_MASK_LINUX
+	bne	1f
 
 	TRACE_ENABLE_INTS
 	stb	r5,PACASOFTIRQEN(r13)
@@ -352,8 +352,8 @@ ret_from_mc_except:
 
 #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
 	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	cmpwi	cr0,r10,IRQ_DISABLED;	/* yes -> go out of line */ \
-	beq	masked_interrupt_book3e_##n
+	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;	/* yes -> go out of line */ \
+	bne	masked_interrupt_book3e_##n
 
 #define PROLOG_ADDITION_2REGS_GEN(n)					    \
 	std	r14,PACA_EXGEN+EX_R14(r13);				    \
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index a7c69e0a243e..7926e2dc4503 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -759,7 +759,7 @@ _GLOBAL(pmac_secondary_start)
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,IRQ_DISABLED
+	li	r0,IRQ_DISABLE_MASK_LINUX
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -816,7 +816,7 @@ __secondary_start:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r7,IRQ_DISABLED
+	li	r7,IRQ_DISABLE_MASK_LINUX
 	stb	r7,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -983,7 +983,7 @@ start_here_common:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,IRQ_DISABLED
+	li	r0,IRQ_DISABLE_MASK_LINUX
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index b25a1aee6e08..a459c306b04e 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -47,7 +47,7 @@ _GLOBAL(\name)
 	bl	trace_hardirqs_on
 	addi    r1,r1,128
 #endif
-	li	r0,IRQ_ENABLED
+	li	r0,IRQ_DISABLE_MASK_NONE
 	stb	r0,PACASOFTIRQEN(r13)
 	
 	/* Interrupts will make use return to LR, so get something we want
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 26b0d6f3f748..785e10619d8d 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -54,7 +54,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	mfmsr	r7
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	li	r0,IRQ_ENABLED
+	li	r0,IRQ_DISABLE_MASK_NONE
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
 BEGIN_FTR_SECTION
 	DSSALL
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 86210c220cf7..8e8dfd022f15 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -218,9 +218,13 @@ notrace void arch_local_irq_restore(unsigned long en)
 	unsigned char irq_happened;
 	unsigned int replay;
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	WARN_ON(en & soft_enabled_return() & ~IRQ_DISABLE_MASK_LINUX);
+#endif
+
 	/* Write the new soft-enabled value */
 	soft_enabled_set(en);
-	if (en == IRQ_DISABLED)
+	if (en == IRQ_DISABLE_MASK_LINUX)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
@@ -265,7 +269,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	soft_enabled_set(IRQ_DISABLED);
+	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -275,7 +279,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	soft_enabled_set(IRQ_ENABLED);
+	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -350,7 +354,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	soft_enabled_set(IRQ_ENABLED);
+	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 760ba9e3b13e..e41798dba740 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1528,7 +1528,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 			childregs->gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = IRQ_ENABLED;
+		childregs->softe = IRQ_DISABLE_MASK_NONE;
 #endif
 		childregs->gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 660ed39e9c9a..39c139d46c09 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -283,6 +283,16 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 	if (regno == PT_DSCR)
 		return get_user_dscr(task, data);
 
+	/*
+	 * softe copies paca->soft_enabled variable state. Since soft_enabled is
+	 * no more used as a flag, lets force usr to alway see the softe value as 1
+	 * which means interrupts are not soft disabled.
+	 */
+	if (regno == PT_SOFTE) {
+		*data = 1;
+		return  0;
+	}
+
 	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long))) {
 		*data = ((unsigned long *)task->thread.regs)[regno];
 		return 0;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4e77972edfac..23a10bb0d5b6 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -189,7 +189,7 @@ static void __init fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLED);
+	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 }
 
 static void __init configure_exceptions(void)
@@ -345,7 +345,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLED);
+	soft_enabled_set(IRQ_DISABLE_MASK_LINUX);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 97bb1385e771..bc1216f9be3c 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -138,12 +138,20 @@ static inline int save_general_regs(struct pt_regs *regs,
 {
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
+	/* Force usr to alway see softe as 1 (interrupts enabled) */
+	elf_greg_t64 softe = 0x1;
 
 	WARN_ON(!FULL_REGS(regs));
 
 	for (i = 0; i <= PT_RESULT; i ++) {
 		if (i == 14 && !FULL_REGS(regs))
 			i = 32;
+		if ( i == PT_SOFTE) {
+			if(__put_user((unsigned int)softe, &frame->mc_gregs[i]))
+				return -EFAULT;
+			else
+				continue;
+		}
 		if (__put_user((unsigned int)gregs[i], &frame->mc_gregs[i]))
 			return -EFAULT;
 	}
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c83c115858c1..797029edbcb4 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -110,6 +110,8 @@ static long setup_sigcontext(struct sigcontext __user *sc,
 	struct pt_regs *regs = tsk->thread.regs;
 	unsigned long msr = regs->msr;
 	long err = 0;
+	/* Force usr to alway see softe as 1 (interrupts enabled) */
+	unsigned long softe = 0x1;
 
 	BUG_ON(tsk != current);
 
@@ -169,6 +171,7 @@ static long setup_sigcontext(struct sigcontext __user *sc,
 	WARN_ON(!FULL_REGS(regs));
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __put_user(msr, &sc->gp_regs[PT_MSR]);
+	err |= __put_user(softe, &sc->gp_regs[PT_SOFTE]);
 	err |= __put_user(signr, &sc->signal);
 	err |= __put_user(handler, &sc->handler);
 	if (set != NULL)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f495956a3664..96402dcb38d1 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -253,7 +253,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	save_soft_enabled = soft_enabled_set_return(IRQ_DISABLED);
+	save_soft_enabled = soft_enabled_set_return(IRQ_DISABLE_MASK_LINUX);
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 07e644766524..4df4925a14d1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -884,7 +884,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_ENABLED
+ * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_DISABLE_MASK_NONE
  */
 
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2f9b6e62fcaa..4cca2bf74a22 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -322,7 +322,7 @@ static inline void perf_read_regs(struct pt_regs *regs)
  */
 static inline int perf_intr_is_nmi(struct pt_regs *regs)
 {
-	return (regs->softe == IRQ_DISABLED);
+	return (regs->softe & IRQ_DISABLE_MASK_LINUX);
 }
 
 /*
-- 
2.7.4
