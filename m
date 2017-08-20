Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb4MD2YfmzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:04 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KHx0k3121955
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:02 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cfdt4b649-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:01 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 03:58:59 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7KHwvt022347886
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:58:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7KHwlb6009370
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:58:48 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 01/14] powerpc: Add #defs for paca->soft_enabled flags
Date: Sun, 20 Aug 2017 23:28:18 +0530
In-Reply-To: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1503251911-30637-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two #defs IRQ_ENABLED and IRQ_DISABLED
are added to be used when updating paca->soft_enabled.
Replace the hardcoded values used when updating
paca->soft_enabled with IRQ_[EN/DIS]ABLED #def.
No logic change.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  2 +-
 arch/powerpc/include/asm/hw_irq.h        | 21 ++++++++++++++-------
 arch/powerpc/include/asm/irqflags.h      |  6 +++---
 arch/powerpc/include/asm/kvm_ppc.h       |  2 +-
 arch/powerpc/kernel/entry_64.S           | 16 ++++++++--------
 arch/powerpc/kernel/exceptions-64e.S     |  6 +++---
 arch/powerpc/kernel/head_64.S            |  5 +++--
 arch/powerpc/kernel/idle_book3e.S        |  3 ++-
 arch/powerpc/kernel/idle_power4.S        |  3 ++-
 arch/powerpc/kernel/irq.c                |  9 +++++----
 arch/powerpc/kernel/process.c            |  3 ++-
 arch/powerpc/kernel/setup_64.c           |  3 +++
 arch/powerpc/kernel/time.c               |  2 +-
 arch/powerpc/mm/hugetlbpage.c            |  2 +-
 arch/powerpc/perf/core-book3s.c          |  2 +-
 15 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9a318973af05..05523e825147 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -494,7 +494,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,0;							\
+	cmpwi	r10,IRQ_DISABLED;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	beq	masked_##h##interrupt
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c1dd1929342d..d037a57700b9 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -27,6 +27,12 @@
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
 
+/*
+ * flags for paca->soft_enabled
+ */
+#define IRQ_ENABLED	1
+#define IRQ_DISABLED	0
+
 #endif /* CONFIG_PPC64 */
 
 #ifndef __ASSEMBLY__
@@ -58,9 +64,10 @@ static inline unsigned long arch_local_irq_disable(void)
 	unsigned long flags, zero;
 
 	asm volatile(
-		"li %1,0; lbz %0,%2(13); stb %1,%2(13)"
+		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
 		: "=r" (flags), "=&r" (zero)
-		: "i" (offsetof(struct paca_struct, soft_enabled))
+		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		  "i" (IRQ_DISABLED)
 		: "memory");
 
 	return flags;
@@ -70,7 +77,7 @@ extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(1);
+	arch_local_irq_restore(IRQ_ENABLED);
 }
 
 static inline unsigned long arch_local_irq_save(void)
@@ -80,7 +87,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == 0;
+	return flags == IRQ_DISABLED;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -100,9 +107,9 @@ static inline bool arch_irqs_disabled(void)
 	u8 _was_enabled;				\
 	__hard_irq_disable();				\
 	_was_enabled = local_paca->soft_enabled;	\
-	local_paca->soft_enabled = 0;			\
+	local_paca->soft_enabled = IRQ_DISABLED;\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
-	if (_was_enabled)				\
+	if (_was_enabled == IRQ_ENABLED)	\
 		trace_hardirqs_off();			\
 } while(0)
 
@@ -125,7 +132,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return !regs->softe;
+	return (regs->softe == IRQ_DISABLED);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index f2149066fe5d..16eafcec58a4 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -48,8 +48,8 @@
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	cmpwi	cr0,__rA,0;			\
-	li	__rA,0;				\
+	cmpwi	cr0,__rA,IRQ_DISABLED;\
+	li	__rA,IRQ_DISABLED;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
 	beq	44f;				\
@@ -63,7 +63,7 @@
 
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	li	__rB,0;				\
+	li	__rB,IRQ_DISABLED;	\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACASOFTIRQEN(r13);	\
 	stb	__rA,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index ba5fadd6f3c9..d3608fe43245 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -869,7 +869,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = IRQ_ENABLED;
 #endif
 }
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e925c1c99c71..6b343d2ba405 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -130,7 +130,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 */
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
 	lbz	r10,PACASOFTIRQEN(r13)
-	xori	r10,r10,1
+	xori	r10,r10,IRQ_ENABLED
 1:	tdnei	r10,0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
@@ -147,7 +147,7 @@ system_call:			/* label this so stack traces look sane */
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
 	 */
-	li	r10,1
+	li	r10,IRQ_ENABLED
 	std	r10,SOFTE(r1)
 
 	CURRENT_THREAD_INFO(r11, r1)
@@ -743,7 +743,7 @@ resume_kernel:
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
 	ld	r0,SOFTE(r1)
-	cmpdi	r0,0
+	cmpdi	r0,IRQ_DISABLED
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 
@@ -783,11 +783,11 @@ restore:
 	 */
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
-	cmpwi	cr0,r5,0
+	cmpwi	cr0,r5,IRQ_DISABLED
 	beq	.Lrestore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
-	cmpwi	cr0,r6,1
+	cmpwi	cr0,r6,IRQ_ENABLED
 	beq	cr0,.Ldo_restore
 
 	/*
@@ -806,7 +806,7 @@ restore:
 	 */
 .Lrestore_no_replay:
 	TRACE_ENABLE_INTS
-	li	r0,1
+	li	r0,IRQ_ENABLED
 	stb	r0,PACASOFTIRQEN(r13);
 
 	/*
@@ -911,7 +911,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	beq	1f
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
-1:	li	r0,0
+1:	li	r0,IRQ_DISABLED
 	stb	r0,PACASOFTIRQEN(r13);
 	TRACE_DISABLE_INTS
 	b	.Ldo_restore
@@ -1037,7 +1037,7 @@ _GLOBAL(enter_rtas)
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,0
+1:	tdnei	r0,IRQ_DISABLED
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index acd8ca76233e..1ca9ed89ed0b 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -210,9 +210,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	ld	r5,SOFTE(r1)
 
 	/* Interrupts had better not already be enabled... */
-	twnei	r6,0
+	twnei	r6,IRQ_DISABLED
 
-	cmpwi	cr0,r5,0
+	cmpwi	cr0,r5,IRQ_DISABLED
 	beq	1f
 
 	TRACE_ENABLE_INTS
@@ -352,7 +352,7 @@ ret_from_mc_except:
 
 #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
 	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	cmpwi	cr0,r10,0;		/* yes -> go out of line */	    \
+	cmpwi	cr0,r10,IRQ_DISABLED;	/* yes -> go out of line */ \
 	beq	masked_interrupt_book3e_##n
 
 #define PROLOG_ADDITION_2REGS_GEN(n)					    \
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 0ddc602b33a4..a7c69e0a243e 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -759,7 +759,7 @@ _GLOBAL(pmac_secondary_start)
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,0
+	li	r0,IRQ_DISABLED
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -816,6 +816,7 @@ __secondary_start:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
+	li	r7,IRQ_DISABLED
 	stb	r7,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -982,7 +983,7 @@ start_here_common:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,0
+	li	r0,IRQ_DISABLED
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 48c21acef915..b25a1aee6e08 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -17,6 +17,7 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/hw_irq.h>
 
 /* 64-bit version only for now */
 #ifdef CONFIG_PPC64
@@ -46,7 +47,7 @@ _GLOBAL(\name)
 	bl	trace_hardirqs_on
 	addi    r1,r1,128
 #endif
-	li	r0,1
+	li	r0,IRQ_ENABLED
 	stb	r0,PACASOFTIRQEN(r13)
 	
 	/* Interrupts will make use return to LR, so get something we want
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index f57a19348bdd..26b0d6f3f748 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -15,6 +15,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/irqflags.h>
+#include <asm/hw_irq.h>
 
 #undef DEBUG
 
@@ -53,7 +54,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	mfmsr	r7
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	li	r0,1
+	li	r0,IRQ_ENABLED
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
 BEGIN_FTR_SECTION
 	DSSALL
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f291f7826abc..1c92f0c6ef69 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -67,6 +67,7 @@
 #include <asm/smp.h>
 #include <asm/livepatch.h>
 #include <asm/asm-prototypes.h>
+#include <asm/hw_irq.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -225,7 +226,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	set_soft_enabled(en);
-	if (!en)
+	if (en == IRQ_DISABLED)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
@@ -270,7 +271,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	set_soft_enabled(0);
+	set_soft_enabled(IRQ_DISABLED);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -280,7 +281,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	set_soft_enabled(1);
+	set_soft_enabled(IRQ_ENABLED);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -355,7 +356,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = IRQ_ENABLED;
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ec480966f9bf..760ba9e3b13e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -57,6 +57,7 @@
 #include <asm/debug.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
+#include <asm/hw_irq.h>
 #endif
 #include <asm/code-patching.h>
 #include <asm/exec.h>
@@ -1527,7 +1528,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 			childregs->gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = 1;
+		childregs->softe = IRQ_ENABLED;
 #endif
 		childregs->gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index af23d4b576ec..946e6131ff25 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/livepatch.h>
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
+#include <asm/hw_irq.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -187,6 +188,8 @@ static void __init fixup_boot_paca(void)
 	get_paca()->cpu_start = 1;
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
+	/* Mark interrupts disabled in PACA */
+	get_paca()->soft_enabled = IRQ_DISABLED;
 }
 
 static void __init configure_exceptions(void)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fe6f3a285455..d0d730c61758 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -253,7 +253,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	local_paca->soft_enabled = 0;
+	local_paca->soft_enabled = IRQ_DISABLED;
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e1bf5ca397fe..07e644766524 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -884,7 +884,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = 1
+ * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_ENABLED
  */
 
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 6c2d4168daec..2f9b6e62fcaa 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -322,7 +322,7 @@ static inline void perf_read_regs(struct pt_regs *regs)
  */
 static inline int perf_intr_is_nmi(struct pt_regs *regs)
 {
-	return !regs->softe;
+	return (regs->softe == IRQ_DISABLED);
 }
 
 /*
-- 
2.7.4
