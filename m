Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHdjp5ywczDt3D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 05:05:50 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEI5Zec140673
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:05:49 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qfda9w0h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:05:46 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 23:35:05 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 658233940060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAEI53ZH9568464
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:03 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAEI51eU010679
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:35:02 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3 01/11] powerpc: Add #defs for paca->soft_enabled flags
Date: Mon, 14 Nov 2016 23:34:42 +0530
In-Reply-To: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1479146692-15726-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two #defs IRQ_DISABLE_LEVEL_NONE and IRQ_DISABLE_LEVEL_LINUX
are added to be used when updating paca->soft_enabled.
Replace the hardcoded values used when updating
paca->soft_enabled with IRQ_DISABLE_MASK_* #def.
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
index 84d49b197c32..53ba672fe9dc 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -403,7 +403,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,0;							\
+	cmpwi	r10,IRQ_DISABLE_MASK_LINUX;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	beq	masked_##h##interrupt
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index eba60416536e..05b81bca15e9 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -27,6 +27,12 @@
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
 
+/*
+ * flags for paca->soft_enabled
+ */
+#define IRQ_DISABLE_MASK_NONE	1
+#define IRQ_DISABLE_MASK_LINUX	0
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
+		  "i" (IRQ_DISABLE_MASK_LINUX)
 		: "memory");
 
 	return flags;
@@ -70,7 +77,7 @@ extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(1);
+	arch_local_irq_restore(IRQ_DISABLE_MASK_NONE);
 }
 
 static inline unsigned long arch_local_irq_save(void)
@@ -80,7 +87,7 @@ static inline unsigned long arch_local_irq_save(void)
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags == 0;
+	return flags == IRQ_DISABLE_MASK_LINUX;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -100,9 +107,9 @@ static inline bool arch_irqs_disabled(void)
 	u8 _was_enabled;				\
 	__hard_irq_disable();				\
 	_was_enabled = local_paca->soft_enabled;	\
-	local_paca->soft_enabled = 0;			\
+	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
-	if (_was_enabled)				\
+	if (_was_enabled == IRQ_DISABLE_MASK_NONE)	\
 		trace_hardirqs_off();			\
 } while(0)
 
@@ -125,7 +132,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return !regs->softe;
+	return (regs->softe == IRQ_DISABLE_MASK_LINUX);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index f2149066fe5d..d0ed2a7d7d10 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -48,8 +48,8 @@
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	cmpwi	cr0,__rA,0;			\
-	li	__rA,0;				\
+	cmpwi	cr0,__rA,IRQ_DISABLE_MASK_LINUX;\
+	li	__rA,IRQ_DISABLE_MASK_LINUX;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
 	beq	44f;				\
@@ -63,7 +63,7 @@
 
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	li	__rB,0;				\
+	li	__rB,IRQ_DISABLE_MASK_LINUX;	\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACASOFTIRQEN(r13);	\
 	stb	__rA,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index f6e49640dbe1..7d8d2b40c6a8 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -735,7 +735,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = IRQ_DISABLE_MASK_NONE;
 #endif
 }
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6432d4bf08c8..8e347ffca14e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -132,7 +132,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 */
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
 	lbz	r10,PACASOFTIRQEN(r13)
-	xori	r10,r10,1
+	xori	r10,r10,IRQ_DISABLE_MASK_NONE
 1:	tdnei	r10,0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
@@ -148,7 +148,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
 	 */
-	li	r10,1
+	li	r10,IRQ_DISABLE_MASK_NONE
 	std	r10,SOFTE(r1)
 
 	CURRENT_THREAD_INFO(r11, r1)
@@ -724,7 +724,7 @@ resume_kernel:
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
 	ld	r0,SOFTE(r1)
-	cmpdi	r0,0
+	cmpdi	r0,IRQ_DISABLE_MASK_LINUX
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 
@@ -764,11 +764,11 @@ restore:
 	 */
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
-	cmpwi	cr0,r5,0
+	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
 	beq	restore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
-	cmpwi	cr0,r6,1
+	cmpwi	cr0,r6,IRQ_DISABLE_MASK_NONE
 	beq	cr0,do_restore
 
 	/*
@@ -787,7 +787,7 @@ restore:
 	 */
 restore_no_replay:
 	TRACE_ENABLE_INTS
-	li	r0,1
+	li	r0,IRQ_DISABLE_MASK_NONE
 	stb	r0,PACASOFTIRQEN(r13);
 
 	/*
@@ -892,7 +892,7 @@ restore_irq_off:
 	beq	1f
 	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
 	stb	r7,PACAIRQHAPPENED(r13)
-1:	li	r0,0
+1:	li	r0,IRQ_DISABLE_MASK_LINUX
 	stb	r0,PACASOFTIRQEN(r13);
 	TRACE_DISABLE_INTS
 	b	do_restore
@@ -1010,7 +1010,7 @@ _GLOBAL(enter_rtas)
 	 * check it with the asm equivalent of WARN_ON
 	 */
 	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdnei	r0,0
+1:	tdnei	r0,IRQ_DISABLE_MASK_LINUX
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 38a1f96430e1..a39226c502c5 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -210,9 +210,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	ld	r5,SOFTE(r1)
 
 	/* Interrupts had better not already be enabled... */
-	twnei	r6,0
+	twnei	r6,IRQ_DISABLE_MASK_LINUX
 
-	cmpwi	cr0,r5,0
+	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
 	beq	1f
 
 	TRACE_ENABLE_INTS
@@ -352,7 +352,7 @@ ret_from_mc_except:
 
 #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
 	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	cmpwi	cr0,r10,0;		/* yes -> go out of line */	    \
+	cmpwi	cr0,r10,IRQ_DISABLE_MASK_LINUX;	/* yes -> go out of line */ \
 	beq	masked_interrupt_book3e_##n
 
 #define PROLOG_ADDITION_2REGS_GEN(n)					    \
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 04c546e20cc0..9bc378e680b5 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -752,7 +752,7 @@ _GLOBAL(pmac_secondary_start)
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,0
+	li	r0,IRQ_DISABLE_MASK_LINUX
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -809,6 +809,7 @@ __secondary_start:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
+	li	r7,IRQ_DISABLE_MASK_LINUX
 	stb	r7,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
@@ -974,7 +975,7 @@ start_here_common:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,0
+	li	r0,IRQ_DISABLE_MASK_LINUX
 	stb	r0,PACASOFTIRQEN(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 48c21acef915..a459c306b04e 100644
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
+	li	r0,IRQ_DISABLE_MASK_NONE
 	stb	r0,PACASOFTIRQEN(r13)
 	
 	/* Interrupts will make use return to LR, so get something we want
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index f57a19348bdd..785e10619d8d 100644
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
+	li	r0,IRQ_DISABLE_MASK_NONE
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
 BEGIN_FTR_SECTION
 	DSSALL
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 3c05c311e35e..c6f1e13ff441 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -68,6 +68,7 @@
 #include <asm/debug.h>
 #include <asm/livepatch.h>
 #include <asm/asm-prototypes.h>
+#include <asm/hw_irq.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
@@ -213,7 +214,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	set_soft_enabled(en);
-	if (!en)
+	if (en == IRQ_DISABLE_MASK_LINUX)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
@@ -258,7 +259,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	set_soft_enabled(0);
+	set_soft_enabled(IRQ_DISABLE_MASK_LINUX);
 
 	/*
 	 * Check if anything needs to be re-emitted. We haven't
@@ -268,7 +269,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	replay = __check_irq_replay();
 
 	/* We can soft-enable now */
-	set_soft_enabled(1);
+	set_soft_enabled(IRQ_DISABLE_MASK_NONE);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -342,7 +343,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	local_paca->soft_enabled = 1;
+	local_paca->soft_enabled = IRQ_DISABLE_MASK_NONE;
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ce6dc61b15b2..28b85d884688 100644
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
@@ -1474,7 +1475,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 			childregs->gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = 1;
+		childregs->softe = IRQ_DISABLE_MASK_NONE;
 #endif
 		childregs->gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7ac8e6eaab5b..f31930b9bfc1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -67,6 +67,7 @@
 #include <asm/livepatch.h>
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
+#include <asm/hw_irq.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -195,6 +196,8 @@ static void __init fixup_boot_paca(void)
 	get_paca()->cpu_start = 1;
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
+	/* Mark interrupts disabled in PACA */
+	get_paca()->soft_enabled = IRQ_DISABLE_MASK_LINUX;
 }
 
 static void __init configure_exceptions(void)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index bc3f7d0d7b79..334144e300ca 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -269,7 +269,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	local_paca->soft_enabled = 0;
+	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a5d3ecdabc44..441fdfbb9990 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -914,7 +914,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = 1
+ * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_DISABLE_MASK_NONE
  */
 
 pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 72c27b8d2cf3..a0861a8311c7 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -313,7 +313,7 @@ static inline void perf_read_regs(struct pt_regs *regs)
  */
 static inline int perf_intr_is_nmi(struct pt_regs *regs)
 {
-	return !regs->softe;
+	return (regs->softe == IRQ_DISABLE_MASK_LINUX);
 }
 
 /*
-- 
2.7.4
