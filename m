Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZ7J3856zDrcg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 16:30:52 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7P6SMci061641
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:50 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 251b8rcf11-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:49 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 12:00:46 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 01574125805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:04:02 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7P6UhIC53280914
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7P6Udtn031730
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:42 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 11/12] powerpc: Support to replay PMIs
Date: Thu, 25 Aug 2016 12:00:02 +0530
In-Reply-To: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472106603-23336-12-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Code to replay the Performance Monitoring Interrupts(PMI).
In the masked_interrupt handler, for PMIs we reset the MSR[EE]
and return. In the __check_irq_replay(), replay the PMI interrupt
by calling performance_monitor_common handler.

Patch also adds a new soft_irq_set_mask() to update paca->soft_enabled.
New Kconfig is added "CONFIG_IRQ_DEBUG_SUPPORT" to add a warn_on
to alert the usage of soft_irq_set_mask() for disabling lower
bitmask interrupts.

Have also moved the code under the CONFIG_TRACE_IRQFLAGS in
arch_local_irq_restore() to new Kconfig as suggested.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                 |  4 ++++
 arch/powerpc/include/asm/hw_irq.h    | 17 +++++++++++++++++
 arch/powerpc/kernel/entry_64.S       |  5 +++++
 arch/powerpc/kernel/exceptions-64s.S |  2 ++
 arch/powerpc/kernel/irq.c            | 12 ++++++++++--
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab2ce08..878f05925340 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -51,6 +51,10 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
+config IRQ_DEBUG_SUPPORT
+	bool
+	default n
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 415734c07cfa..9f71559ce868 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -81,6 +81,23 @@ static inline unsigned long arch_local_irq_disable(void)
 	return flags;
 }
 
+static inline unsigned long soft_irq_set_mask(int value)
+{
+	unsigned long flags, zero;
+
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
+	WARN_ON(value <= IRQ_DISABLE_MASK_LINUX);
+#endif
+	asm volatile(
+		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
+		: "=r" (flags), "=&r" (zero)
+		: "i" (offsetof(struct paca_struct, soft_enabled)),\
+		 "i" (value)
+		: "memory");
+
+	return flags;
+}
+
 extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 99bab5c65734..b79baff3dae4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -933,6 +933,11 @@ restore_check_irq_replay:
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
index bc2a838e1926..44c871324228 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -655,6 +655,8 @@ _GLOBAL(__replay_interrupt)
 	beq	decrementer_common
 	cmpwi	r3,0x500
 	beq	hardware_interrupt_common
+	cmpwi	r3,0xf00
+	beq	performance_monitor_common
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xe80
 	beq	h_doorbell_common
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 40af16a102bb..57343a55111e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -159,6 +159,14 @@ notrace unsigned int __check_irq_replay(void)
 	if ((happened & PACA_IRQ_DEC) || decrementer_check_overflow())
 		return 0x900;
 
+	/*
+	 * In masked_handler() for PMI, we disable MSR[EE] and return.
+	 * When replaying it here
+	 */
+	local_paca->irq_happened &= ~PACA_IRQ_PMI;
+	if (happened & PACA_IRQ_PMI)
+		return 0xf00;
+
 	/* Finally check if an external interrupt happened */
 	local_paca->irq_happened &= ~PACA_IRQ_EE;
 	if (happened & PACA_IRQ_EE)
@@ -235,7 +243,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 	 */
 	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
 		__hard_irq_disable();
-#ifdef CONFIG_TRACE_IRQFLAGS
+#ifdef CONFIG_IRQ_DEBUG_SUPPORT
 	else {
 		/*
 		 * We should already be hard disabled here. We had bugs
@@ -246,7 +254,7 @@ notrace void arch_local_irq_restore(unsigned long en)
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
 	}
-#endif /* CONFIG_TRACE_IRQFLAGS */
+#endif /* CONFIG_IRQ_DEBUG_SUPPORT */
 
 	set_soft_enabled(IRQ_DISABLE_MASK_LINUX);
 
-- 
2.7.4
