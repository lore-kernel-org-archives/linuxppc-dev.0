Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txx5j4rnvzDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:36:57 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v09DYFN2136068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jan 2017 08:36:55 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27v7183b8r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Jan 2017 08:36:55 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 9 Jan 2017 23:36:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C19B63578057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:36:50 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v09DaojR60293246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:36:50 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v09DanO0027160
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 00:36:50 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v6 08/12] powerpc: Add support to mask perf interrupts and
 replay them
Date: Mon,  9 Jan 2017 19:06:14 +0530
In-Reply-To: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483968978-16035-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1483968978-16035-9-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/kernel/irq.c                | 25 ++++++++++++++++++++++++-
 5 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index d04f519c7b75..b97a52718365 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -431,6 +431,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
+#define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
 
 #define __SOFTEN_TEST(h, vec, bitmask)					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
@@ -495,6 +496,10 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
+#define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, bitmask)	\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
+	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD);
+
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_HV, SOFTEN_NOTEST_HV, bitmask)
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index f7c761902dc9..5bcadd139fca 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -26,12 +26,15 @@
 #define PACA_IRQ_DEC		0x08 /* Or FIT */
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
+#define PACA_IRQ_PMI		0x40
 
 /*
  * flags for paca->soft_enabled
  */
 #define IRQ_DISABLE_MASK_NONE	0
 #define IRQ_DISABLE_MASK_LINUX	1
+#define IRQ_DISABLE_MASK_PMU	2
+#define IRQ_DISABLE_MASK_ALL	3
 
 #endif /* CONFIG_PPC64 */
 
@@ -132,7 +135,7 @@ static inline bool arch_irqs_disabled(void)
 	u8 _was_enabled;				\
 	__hard_irq_disable();				\
 	_was_enabled = local_paca->soft_enabled;	\
-	local_paca->soft_enabled = IRQ_DISABLE_MASK_LINUX;\
+	local_paca->soft_enabled = IRQ_DISABLE_MASK_ALL;\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
 	if (!(_was_enabled & IRQ_DISABLE_MASK_LINUX))	\
 		trace_hardirqs_off();			\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index f3afa0b9332d..d021f7de79bd 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -931,6 +931,11 @@ restore_check_irq_replay:
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
index 66f5334870bf..e914b9f6cd2f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1041,8 +1041,8 @@ EXC_REAL_NONE(0xec0, 0xf00)
 EXC_VIRT_NONE(0x4ec0, 0x4f00)
 
 
-EXC_REAL_OOL(performance_monitor, 0xf00, 0xf20)
-EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20, 0xf00)
+EXC_REAL_OOL_MASKABLE(performance_monitor, 0xf00, 0xf20, IRQ_DISABLE_MASK_PMU)
+EXC_VIRT_OOL_MASKABLE(performance_monitor, 0x4f00, 0x4f20, 0xf00, IRQ_DISABLE_MASK_PMU)
 TRAMP_KVM(PACA_EXGEN, 0xf00)
 EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 
@@ -1580,6 +1580,8 @@ _GLOBAL(__replay_interrupt)
 	beq	decrementer_common
 	cmpwi	r3,0x500
 	beq	hardware_interrupt_common
+	cmpwi	r3,0xf00
+	beq	performance_monitor_common
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xe80
 	beq	h_doorbell_common
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6055b04d2592..da538ec0fd47 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -169,6 +169,27 @@ notrace unsigned int __check_irq_replay(void)
 	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
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
@@ -208,7 +229,9 @@ notrace void arch_local_irq_restore(unsigned long en)
 
 	/* Write the new soft-enabled value */
 	soft_enabled_set(en);
-	if (en == IRQ_DISABLE_MASK_LINUX)
+
+	/* any bits still disabled */
+	if (en)
 		return;
 	/*
 	 * From this point onward, we can take interrupts, preempt,
-- 
2.7.4
