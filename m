Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gvD4zz1zF08p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:56 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sa5L103640
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:54 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ey9mtqtqb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:54 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:52 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 13/17] powerpc/64s: Add support to mask perf interrupts
 and replay them
Date: Wed, 20 Dec 2017 09:25:53 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-14-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two new bit mask field "IRQ_DISABLE_MASK_PMU" is introduced to support
the masking of PMI and "IRQ_DISABLE_MASK_ALL" to aid interrupt masking
checking.

Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*" added
to use in the exception code to check for PMI interrupts.

In the masked_interrupt handler, for PMIs we reset the MSR[EE] and
return. In the __check_irq_replay(), replay the PMI interrupt by
calling performance_monitor_common handler.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  5 +++++
 arch/powerpc/include/asm/hw_irq.h        | 19 +++++++++++--------
 arch/powerpc/kernel/entry_64.S           |  5 +++++
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++++--
 arch/powerpc/kernel/irq.c                |  7 ++++++-
 5 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index d005a1c19b68..54afd1f140a4 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -518,6 +518,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
+#define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
 
 #define __SOFTEN_TEST(h, vec, bitmask)					\
 	lbz	r10,PACAIRQSOFTMASK(r13);				\
@@ -582,6 +583,10 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
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
index 6022aa6d1dd4..6249ebc17608 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -27,12 +27,15 @@
 #define PACA_IRQ_DEC		0x08 /* Or FIT */
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
+#define PACA_IRQ_PMI		0x40
 
 /*
  * flags for paca->irq_soft_mask
  */
 #define IRQ_SOFT_MASK_NONE	0x00
-#define IRQ_SOFT_MASK_STD	0x01
+#define IRQ_SOFT_MASK_STD	0x01 /* local_irq_disable() interrupts */
+#define IRQ_SOFT_MASK_PMU	0x02
+#define IRQ_SOFT_MASK_ALL	0x03
 
 #endif /* CONFIG_PPC64 */
 
@@ -152,13 +155,13 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
 #endif
 
-#define hard_irq_disable()	do {				\
-	unsigned long flags;					\
-	__hard_irq_disable();					\
-	flags = irq_soft_mask_set_return(IRQ_SOFT_MASK_STD);	\
-	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;		\
-	if (!arch_irqs_disabled_flags(flags))			\
-		trace_hardirqs_off();				\
+#define hard_irq_disable()	do {					\
+	unsigned long flags;						\
+	__hard_irq_disable();						\
+	flags = irq_soft_mask_set_return(IRQ_SOFT_MASK_ALL);		\
+	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;			\
+	if (!arch_irqs_disabled_flags(flags))				\
+		trace_hardirqs_off();					\
 } while(0)
 
 static inline bool lazy_irq_pending(void)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 25951224b383..511a97b62075 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -954,6 +954,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
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
index 52027e800bb6..60d9c68ef414 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1111,8 +1111,8 @@ EXC_REAL_NONE(0xee0, 0x20)
 EXC_VIRT_NONE(0x4ee0, 0x20)
 
 
-EXC_REAL_OOL(performance_monitor, 0xf00, 0x20)
-EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x20, 0xf00)
+EXC_REAL_OOL_MASKABLE(performance_monitor, 0xf00, 0x20, IRQ_SOFT_MASK_PMU)
+EXC_VIRT_OOL_MASKABLE(performance_monitor, 0x4f00, 0x20, 0xf00, IRQ_SOFT_MASK_PMU)
 TRAMP_KVM(PACA_EXGEN, 0xf00)
 EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
 
@@ -1723,6 +1723,8 @@ BEGIN_FTR_SECTION
 FTR_SECTION_ELSE
 	beq	hardware_interrupt_common
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_300)
+	cmpwi	r3,0xf00
+	beq	performance_monitor_common
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xa00
 	beq	h_doorbell_common_msgclr
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4b21b502c148..1cbf6a0caed7 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -186,6 +186,11 @@ notrace unsigned int __check_irq_replay(void)
 		return 0x900;
 	}
 
+	if (happened & PACA_IRQ_PMI) {
+		local_paca->irq_happened &= ~PACA_IRQ_PMI;
+		return 0xf00;
+	}
+
 	if (happened & PACA_IRQ_EE) {
 		local_paca->irq_happened &= ~PACA_IRQ_EE;
 		return 0x500;
@@ -272,7 +277,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
+	irq_soft_mask_set(IRQ_SOFT_MASK_ALL);
 	trace_hardirqs_off();
 
 	/*
-- 
2.7.4
