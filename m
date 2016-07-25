Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rykkq2KDtzDrJs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:51 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PEn4nN039985
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:52:49 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c1fjknbp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:52:49 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 00:52:46 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D4C9E2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PEqhrB25624614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PEqhWr012276
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:52:43 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/9] Cleanup to use LAZY_INTERRUPT_* macros for
 paca->soft_enabled update
Date: Mon, 25 Jul 2016 20:22:15 +0530
In-Reply-To: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469458342-26233-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the hardcoded values used when updating
paca->soft_enabled with LAZY_INTERRUPT_* #def.
No logic change.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  2 +-
 arch/powerpc/include/asm/hw_irq.h        | 15 ++++++++-------
 arch/powerpc/include/asm/irqflags.h      |  6 +++---
 arch/powerpc/include/asm/kvm_ppc.h       |  2 +-
 arch/powerpc/kernel/entry_64.S           | 14 +++++++-------
 arch/powerpc/kernel/head_64.S            |  3 ++-
 arch/powerpc/kernel/idle_power4.S        |  3 ++-
 arch/powerpc/kernel/irq.c                |  9 +++++----
 arch/powerpc/kernel/process.c            |  3 ++-
 arch/powerpc/kernel/setup_64.c           |  3 +++
 arch/powerpc/kernel/time.c               |  2 +-
 arch/powerpc/mm/hugetlbpage.c            |  2 +-
 arch/powerpc/perf/core-book3s.c          |  2 +-
 13 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 93ae809fe5ea..e24e63d216c4 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -406,7 +406,7 @@ label##_relon_hv:						\
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,0;							\
+	cmpwi	r10,LAZY_INTERRUPT_DISABLED;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	beq	masked_##h##interrupt
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e58c9d95050a..433fe60cf428 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -65,9 +65,10 @@ static inline unsigned long arch_local_irq_disable(void)
 	unsigned long flags, zero;
 
 	asm volatile(
-		"li %1,0; lbz %0,%2(13); stb %1,%2(13)"
+		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
 		: "=r" (flags), "=&r" (zero)
-		: "i" (offsetof(struct paca_struct, soft_enabled))
+		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		  "i" (LAZY_INTERRUPT_DISABLED)
 		: "memory");
 
 	return flags;
@@ -77,7 +78,7 @@ extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(1);
+	arch_local_irq_restore(LAZY_INTERRUPT_ENABLED);
 }
 
 static inline unsigned long arch_local_irq_save(void)
@@ -87,7 +88,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == 0;
+	return flags == LAZY_INTERRUPT_DISABLED;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -107,9 +108,9 @@ static inline bool arch_irqs_disabled(void)
 	u8 _was_enabled;				\
 	__hard_irq_disable();				\
 	_was_enabled = local_paca->soft_enabled;	\
-	local_paca->soft_enabled = 0;			\
+	local_paca->soft_enabled = LAZY_INTERRUPT_DISABLED;\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
-	if (_was_enabled)				\
+	if (_was_enabled == LAZY_INTERRUPT_ENABLED)	\
 		trace_hardirqs_off();			\
 } while(0)
 
@@ -132,7 +133,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return !regs->softe;
+	return (regs->softe == LAZY_INTERRUPT_DISABLED);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index f2149066fe5d..6091e46f2455 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -48,8 +48,8 @@
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	cmpwi	cr0,__rA,0;			\
-	li	__rA,0;				\
+	cmpwi	cr0,__rA,LAZY_INTERRUPT_DISABLED;\
+	li	__rA,LAZY_INTERRUPT_DISABLED;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
 	beq	44f;				\
@@ -63,7 +63,7 @@
 
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	li	__rB,0;				\
+	li	__rB,LAZY_INTERRUPT_DISABLED;	\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACASOFTIRQEN(r13);	\
 	stb	__rA,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2544edabe7f3..e790b8a6bf0b 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -707,7 +707,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = LAZY_INTERRUPT_ENABLED;
 #endif
 }
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 73e461a3dfbb..cade169a7517 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -147,7 +147,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
 	 */
-	li	r10,1
+	li	r10,LAZY_INTERRUPT_ENABLED
 	std	r10,SOFTE(r1)
 
 	CURRENT_THREAD_INFO(r11, r1)
@@ -725,7 +725,7 @@ resume_kernel:
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
 	ld	r0,SOFTE(r1)
-	cmpdi	r0,0
+	cmpdi	r0,LAZY_INTERRUPT_DISABLED
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 
@@ -765,11 +765,11 @@ restore:
 	 */
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
-	cmpwi	cr0,r5,0
+	cmpwi	cr0,r5,LAZY_INTERRUPT_DISABLED
 	beq	restore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
-	cmpwi	cr0,r6,1
+	cmpwi	cr0,r6,LAZY_INTERRUPT_ENABLED
 	beq	cr0,do_restore
 
 	/*
@@ -788,7 +788,7 @@ restore:
 	 */
 restore_no_replay:
 	TRACE_ENABLE_INTS
-	li	r0,1
+	li	r0,LAZY_INTERRUPT_ENABLED
 	stb	r0,PACASOFTIRQEN(r13);
 
 	/*
@@ -894,7 +894,7 @@ restore_irq_off:
 	beq	1f
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
-1:	li	r0,0
+1:	li	r0,LAZY_INTERRUPT_DISABLED
 	stb	r0,PACASOFTIRQEN(r13);
 	TRACE_DISABLE_INTS
 	b	do_restore
@@ -1012,7 +1012,7 @@ _GLOBAL(enter_rtas)
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,0
+1:	tdnei	r0,LAZY_INTERRUPT_DISABLED
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2d14774af6b4..bfcb8625671b 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -789,6 +789,7 @@ __secondary_start:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
+	li	r7,LAZY_INTERRUPT_DISABLED
 	stb	r7,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -957,7 +958,7 @@ start_here_common:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,0
+	li	r0,LAZY_INTERRUPT_DISABLED
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index f57a19348bdd..3e7fa14a736f 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -14,6 +14,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/hw_irq.h>
 #include <asm/irqflags.h>
 
 #undef DEBUG
@@ -53,7 +54,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	mfmsr	r7
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	li	r0,1
+	li	r0,LAZY_INTERRUPT_ENABLED
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
 BEGIN_FTR_SECTION
 	DSSALL
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 3cb46a3b1de7..06dff620fcdc 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -67,6 +67,7 @@
 #include <asm/smp.h>
 #include <asm/debug.h>
 #include <asm/livepatch.h>
+#include <asm/hw_irq.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -207,7 +208,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	set_soft_enabled(en);
-	if (!en)
+	if (en == LAZY_INTERRUPT_DIABLED)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
@@ -252,7 +253,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAG */
 
-	set_soft_enabled(0);
+	set_soft_enabled(LAZY_INTERRUPT_DISABLED);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -262,7 +263,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	set_soft_enabled(1);
+	set_soft_enabled(LAZY_INTERRUPT_ENABLED);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -336,7 +337,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = LAZY_INTERRUPT_ENABLED;
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 0b93893424f5..eb2d1bc8607c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -54,6 +54,7 @@
 #include <asm/debug.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
+#include <asm/hw_irq.h>
 #endif
 #include <asm/code-patching.h>
 #include <asm/exec.h>
@@ -1418,7 +1419,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 			childregs->gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = 1;
+		childregs->softe = LAZY_INTERRUPT_ENABLED;
 #endif
 		childregs->gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 96d4a2b23d0f..0ca504839550 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -70,6 +70,7 @@
 #include <asm/hugetlb.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/livepatch.h>
+#include <asm/hw_irq.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -204,6 +205,8 @@ static void fixup_boot_paca(void)
 	get_paca()->cpu_start = 1;
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
+	/* Mark interrupts disabled in PACA */
+	get_paca()->soft_enabled = LAZY_INTERRUPT_DISABLED;
 }
 
 static void cpu_ready_for_interrupts(void)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3ed9a5a21d77..e46f7ab6cbde 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -258,7 +258,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	local_paca->soft_enabled = 0;
+	local_paca->soft_enabled = LAZY_INTERRUPT_DISABLED;
 
 	sst = scan_dispatch_log(local_paca->starttime_user);
 	ust = scan_dispatch_log(local_paca->starttime);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 119d18611500..56ea41da2ea7 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -907,7 +907,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = 1
+ * when we have MSR[EE] = 0 but the paca->soft_enabled = LAZY_INTERRUPT_ENABLED
  */
 
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 141c289ae492..a5a6b06f3c33 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -313,7 +313,7 @@ static inline void perf_read_regs(struct pt_regs *regs)
  */
 static inline int perf_intr_is_nmi(struct pt_regs *regs)
 {
-	return !regs->softe;
+	return (regs->softe == LAZY_INTERRUPT_DISABLED);
 }
 
 /*
-- 
2.7.4
