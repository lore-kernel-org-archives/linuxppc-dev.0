Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMk7W59JpzDrgj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 04:38:31 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SIXebF063024
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 14:38:29 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25356eqs2u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 14:38:29 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 00:08:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E5323125805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 00:08:25 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SIcO5S16777414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 00:08:24 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SIcMDQ026758
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 00:08:24 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 10/12] powerpc: Add support to mask perf interrupts and
 replay
Date: Mon, 29 Aug 2016 00:07:26 +0530
In-Reply-To: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472409448-18172-11-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support masking of the PMI interrupts, couple of new interrupt handler
macros are added MASKABLE_EXCEPTION_PSERIES_OOL and
MASKABLE_RELON_EXCEPTION_PSERIES_OOL.

Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*" added to
use in the exception code to check for PMI interrupts.

In the masked_interrupt handler, for PMIs we reset the MSR[EE]
and return. In the __check_irq_replay(), replay the PMI interrupt
by calling performance_monitor_common handler.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 13 +++++++++++++
 arch/powerpc/include/asm/hw_irq.h        |  1 +
 arch/powerpc/kernel/entry_64.S           |  5 +++++
 arch/powerpc/kernel/exceptions-64s.S     |  6 ++++--
 arch/powerpc/kernel/irq.c                |  8 ++++++++
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 41be0c2d7658..ca40b5c59869 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -427,6 +427,7 @@ label##_relon_hv:						\
 #define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
 #define SOFTEN_VALUE_0xea2	PACA_IRQ_EE
+#define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
 
 #define __SOFTEN_TEST(h, vec, bitmask)					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
@@ -462,6 +463,12 @@ label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_STD, SOFTEN_TEST_PR, bitmask)
 
+#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label, bitmask)		\
+	.globl label##_pSeries;						\
+label##_pSeries:							\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);	\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD);
+
 #define MASKABLE_EXCEPTION_HV(loc, vec, label, bitmask)			\
 	. = loc;							\
 	.globl label##_hv;						\
@@ -490,6 +497,12 @@ label##_relon_pSeries:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
+#define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, bitmask)	\
+	.globl label##_relon_pSeries;					\
+label##_relon_pSeries:							\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD);
+
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
 	. = loc;							\
 	.globl label##_relon_hv;					\
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e457438c6fdf..415734c07cfa 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -26,6 +26,7 @@
 #define PACA_IRQ_DEC		0x08 /* Or FIT */
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
+#define PACA_IRQ_PMI		0x40
 
 /*
  * flags for paca->soft_enabled
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
index 6c56554cfcc3..44c871324228 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -580,7 +580,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xea2)
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+	MASKABLE_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor, IRQ_DISABLE_MASK_PMU)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
 	STD_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf20)
@@ -655,6 +655,8 @@ _GLOBAL(__replay_interrupt)
 	beq	decrementer_common
 	cmpwi	r3,0x500
 	beq	hardware_interrupt_common
+	cmpwi	r3,0xf00
+	beq	performance_monitor_common
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xe80
 	beq	h_doorbell_common
@@ -1126,7 +1128,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	MASKABLE_RELON_EXCEPTION_HV_OOL(0xea0, h_virt_irq,
 							IRQ_DISABLE_MASK_LINUX)
 
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor, IRQ_DISABLE_MASK_PMU)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 40af16a102bb..db453a5c0514 100644
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
-- 
2.7.4
