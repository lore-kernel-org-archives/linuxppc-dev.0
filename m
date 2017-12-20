Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gtb5zvLzF08C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:23 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3siJ6053566
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:21 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eyc76hjfk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:21 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:18 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 02/17] powerpc/64: Add #defines for paca->soft_enabled
 flags
Date: Wed, 20 Dec 2017 09:25:42 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two #defines, IRQ_ENABLED and IRQ_DISABLED, are added to be used when
updating paca->soft_enabled. Replace the hardcoded values used when
updating paca->soft_enabled with IRQ_[EN/DIS]ABLED. No logic change.

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
index b27205297e1d..7c2486248dfa 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -499,7 +499,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,0;							\
+	cmpwi	r10,IRQ_DISABLED;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	beq	masked_##h##interrupt
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 3818fa0164f0..463b595ca971 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -28,6 +28,12 @@
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
@@ -60,9 +66,10 @@ static inline unsigned long arch_local_irq_disable(void)
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
@@ -72,7 +79,7 @@ extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(1);
+	arch_local_irq_restore(IRQ_ENABLED);
 }
 
 static inline unsigned long arch_local_irq_save(void)
@@ -82,7 +89,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == 0;
+	return flags == IRQ_DISABLED;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -102,9 +109,9 @@ static inline bool arch_irqs_disabled(void)
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
 
@@ -127,7 +134,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return !regs->softe;
+	return (regs->softe == IRQ_DISABLED);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 1aeb5f13b8c4..55d9a0c0f1a6 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -49,8 +49,8 @@
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
@@ -64,7 +64,7 @@
 
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	li	__rB,0;				\
+	li	__rB,IRQ_DISABLED;	\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACASOFTIRQEN(r13);	\
 	stb	__rA,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 941c2a3f231b..70a38ba46dc0 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -873,7 +873,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = IRQ_ENABLED;
 #endif
 }
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b3055ebf20d1..02536e989df5 100644
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
@@ -915,7 +915,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
 	/* The interrupt should not have soft enabled. */
 	lbz	r7,PACASOFTIRQEN(r13)
-	tdnei	r7,0
+	tdnei	r7,IRQ_DISABLED
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	b	.Ldo_restore
@@ -1036,7 +1036,7 @@ _GLOBAL(enter_rtas)
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
index aa71a90f5222..a9a577dc465c 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -765,7 +765,7 @@ _GLOBAL(pmac_secondary_start)
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,0
+	li	r0,IRQ_DISABLED
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -822,6 +822,7 @@ __secondary_start:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
+	li	r7,IRQ_DISABLED
 	stb	r7,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -988,7 +989,7 @@ start_here_common:
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
index b7a84522e652..1ba8f6632cd2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -67,6 +67,7 @@
 #include <asm/smp.h>
 #include <asm/livepatch.h>
 #include <asm/asm-prototypes.h>
+#include <asm/hw_irq.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -231,7 +232,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	set_soft_enabled(en);
-	if (!en)
+	if (en == IRQ_DISABLED)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
@@ -276,7 +277,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	set_soft_enabled(0);
+	set_soft_enabled(IRQ_DISABLED);
 	trace_hardirqs_off();
 
 	/*
@@ -288,7 +289,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* We can soft-enable now */
 	trace_hardirqs_on();
-	set_soft_enabled(1);
+	set_soft_enabled(IRQ_ENABLED);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -363,7 +364,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = IRQ_ENABLED;
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 5acb5a176dbe..c59a4d2a7905 100644
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
@@ -1674,7 +1675,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 			childregs->gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = 1;
+		childregs->softe = IRQ_ENABLED;
 #endif
 		childregs->gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8956a9856604..909903f042ff 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/livepatch.h>
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
+#include <asm/hw_irq.h>
 
 #include "setup.h"
 
@@ -189,6 +190,8 @@ static void __init fixup_boot_paca(void)
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
index a9b9083c5e49..b8640ef11041 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -752,7 +752,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = 1
+ * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_ENABLED
  */
 pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 			bool *is_thp, unsigned *hpage_shift)
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 153812966365..7ffc02ed0b0f 100644
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
