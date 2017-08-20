Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb4N74ssBzDqb6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:51 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KHxLWD107037
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:50 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cehdyg154-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 13:59:49 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 21 Aug 2017 03:59:47 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7KHxiOc37290206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7KHxZej010096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 03:59:35 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 11/14] powerpc: Add support to mask perf interrupts and
 replay them
Date: Sun, 20 Aug 2017 23:28:28 +0530
In-Reply-To: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1503251911-30637-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1503251911-30637-12-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two new bit mask field "IRQ_DISABLE_MASK_PMU" is introduced to support
the masking of PMI and "IRQ_DISABLE_MASK_ALL" to aid interrupt masking checking.

Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*" added to
use in the exception code to check for PMI interrupts.

In the masked_interrupt handler, for PMIs we reset the MSR[EE]
and return. In the __check_irq_replay(), replay the PMI interrupt
by calling performance_monitor_common handler.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  5 +++++
 arch/powerpc/include/asm/hw_irq.h        |  5 ++++-
 arch/powerpc/kernel/entry_64.S           |  5 +++++
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++++--
 arch/powerpc/kernel/irq.c                | 24 +++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index e44b0fdb56f7..6f7685ccec28 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -513,6 +513,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
+#define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
 
 #define __SOFTEN_TEST(h, vec, bitmask)					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
@@ -577,6 +578,10 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
+#define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, bitmask)	\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
+	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD);
+
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_HV, SOFTEN_TEST_HV, bitmask)
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index efbf5ebc03de..f93de4b3b700 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -26,12 +26,15 @@
 #define PACA_IRQ_DEC		0x08 /* Or FIT */
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
+#define PACA_IRQ_PMI		0x40
 
 /*
  * flags for paca->soft_disable_mask
  */
 #define IRQ_DISABLE_MASK_NONE	0
 #define IRQ_DISABLE_MASK_LINUX	1
+#define IRQ_DISABLE_MASK_PMU	2
+#define IRQ_DISABLE_MASK_ALL	3
 
 #endif /* CONFIG_PPC64 */
 
@@ -128,7 +131,7 @@ static inline bool arch_irqs_disabled(void)
 #define hard_irq_disable()	do {			\
 	unsigned long flags;				\
 	__hard_irq_disable();				\
-	flags = soft_disable_mask_set_return(IRQ_DISABLE_MASK_LINUX);\
+	flags = soft_disable_mask_set_return(IRQ_DISABLE_MASK_ALL);\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
 	if (!arch_irqs_disabled_flags(flags))		\
 		trace_hardirqs_off();			\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 31d800778c74..837f12d39bf0 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -950,6 +950,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
  	bl	do_IRQ
 	b	ret_from_except
+1:	cmpwi	cr0,r3,0xf00
+	bne	1f
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+	bl	performance_monitor_exception
+	b	ret_from_except
 1:	cmpwi	cr0,r3,0xe60
 	bne	1f
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a85ba164e7e1..a03bfecbc280 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1073,8 +1073,8 @@ EXC_REAL_NONE(0xee0, 0x20)
 EXC_VIRT_NONE(0x4ee0, 0x20)
 
 
-EXC_REAL_OOL(performance_monitor, 0xf00, 0x20)
-EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x20, 0xf00)
+EXC_REAL_OOL_MASKABLE(performance_monitor, 0xf00, 0x20, IRQ_DISABLE_MASK_PMU)
+EXC_VIRT_OOL_MASKABLE(performance_monitor, 0x4f00, 0x20, 0xf00, IRQ_DISABLE_MASK_PMU)
 TRAMP_KVM(PACA_EXGEN, 0xf00)
 EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 
@@ -1682,6 +1682,8 @@ _GLOBAL(__replay_interrupt)
 	beq	decrementer_common
 	cmpwi	r3,0x500
 	beq	hardware_interrupt_common
+	cmpwi	r3,0xf00
+	beq	performance_monitor_common
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xe80
 	beq	h_doorbell_common_msgclr
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6348b5d10ddd..fda01a4a3672 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -181,6 +181,27 @@ notrace unsigned int __check_irq_replay(void)
 	if (happened & PACA_IRQ_DEC)
 		return 0x900;
 
+	/*
+	 * In masked_handler() for PMI, we disable MSR[EE] and return.
+	 * Replay it here.
+	 *
+	 * After this point, PMIs could still be disabled in certain
+	 * scenarios like this one.
+	 *
+	 * local_irq_disable();
+	 * powerpc_irq_pmu_save();
+	 * powerpc_irq_pmu_restore();
+	 * local_irq_restore();
+	 *
+	 * Even though powerpc_irq_pmu_restore() would have replayed the PMIs
+	 * if any, we have still not enabled EE and this will happen only at
+	 * complition of last *_restore in this nested cases. And PMIs will
+	 * once again start firing only when we have MSR[EE] enabled.
+	 */
+	local_paca->irq_happened &= ~PACA_IRQ_PMI;
+	if (happened & PACA_IRQ_PMI)
+		return 0xf00;
+
 	/* Finally check if an external interrupt happened */
 	local_paca->irq_happened &= ~PACA_IRQ_EE;
 	if (happened & PACA_IRQ_EE)
@@ -224,7 +245,8 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	soft_disable_mask_set(en);
-	if (en == IRQ_DISABLE_MASK_LINUX)
+	/* any bits still disabled */
+	if (en)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
-- 
2.7.4
