Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryklN12NtzDrKp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:19 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PEn3DG009698
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c1h4dyph-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:17 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 00:53:14 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1E6392BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:11 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PErBmW21102750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:11 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PErAKO012628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:10 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH 7/9] powerpc: Add support to mask perf interrupts
Date: Mon, 25 Jul 2016 20:22:20 +0530
In-Reply-To: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469458342-26233-8-git-send-email-maddy@linux.vnet.ibm.com>
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
MASKABLE_RELON_EXCEPTION_PSERIES_OOL. These are needed to include the
SOFTEN_TEST and implement the support at both host and guest kernel.

Couple of new irq #defs "PACA_IRQ_PMI" and "SOFTEN_VALUE_0xf0*" added to
use in the exception code to check for PMI interrupts.

__SOFTEN_TEST macro is modified to support the PMI interrupt.
Present __SOFTEN_TEST code loads the soft_enabled from paca and check to call
masked_interrupt handler code. To support both current behaviour and PMI
masking, these changes are added,

1) Current LR register content are saved in R11
2) "bge" branch operation is changed to "bgel".
3) restore R11 to LR

Reason:

To retain PMI as NMI behaviour for flag state of 1, we save the LR regsiter
value in R11 and branch to "masked_interrupt" handler with LR update. And in
"masked_interrupt" handler, we check for the "SOFTEN_VALUE_*" value in R10
for PMI and branch back with "blr" if PMI.

To mask PMI for a flag >1 value, masked_interrupt vaoid's the above check
and continue to execute the masked_interrupt code and disabled MSR[EE] and
updated the irq_happend with PMI info.

Finally, saving of R11 is moved before calling SOFTEN_TEST in the
__EXCEPTION_PROLOG_1 macro to support saving of LR values in SOFTEN_TEST.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 22 ++++++++++++++++++++--
 arch/powerpc/include/asm/hw_irq.h        |  1 +
 arch/powerpc/kernel/exceptions-64s.S     | 27 ++++++++++++++++++++++++---
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 44d3f539d8a5..c951b7ab5108 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -166,8 +166,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
 	SAVE_CTR(r10, area);						\
 	mfcr	r9;							\
-	extra(vec);							\
 	std	r11,area+EX_R11(r13);					\
+	extra(vec);							\
 	std	r12,area+EX_R12(r13);					\
 	GET_SCRATCH0(r10);						\
 	std	r10,area+EX_R13(r13)
@@ -403,12 +403,17 @@ label##_relon_hv:						\
 #define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
+#define SOFTEN_VALUE_0xf01	PACA_IRQ_PMI
+#define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	r10,LAZY_INTERRUPT_DISABLED;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	bge	masked_##h##interrupt
+	mflr	r11;							\
+	bgel	masked_##h##interrupt;					\
+	mtlr	r11;
+
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
 #define SOFTEN_TEST_PR(vec)						\
@@ -438,6 +443,12 @@ label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_STD, SOFTEN_TEST_PR)
 
+#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
+	.globl label##_pSeries;						\
+label##_pSeries:							\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD);
+
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
 	. = loc;							\
 	.globl label##_hv;						\
@@ -466,6 +477,13 @@ label##_relon_pSeries:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_STD, SOFTEN_NOTEST_PR)
 
+#define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label)		\
+	.globl label##_relon_pSeries;					\
+label##_relon_pSeries:							\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec);		\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD);
+
+
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label)			\
 	. = loc;							\
 	.globl label##_relon_hv;					\
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index b7c7f1c6706f..cc69dde6eb84 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -26,6 +26,7 @@
 #define PACA_IRQ_DEC		0x08 /* Or FIT */
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
+#define PACA_IRQ_PMI		0x40
 
 /*
  * flags for paca->soft_enabled
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8bcc1b457115..479271168bb8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -360,7 +360,11 @@ hv_doorbell_trampoline:
 performance_monitor_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
+BEGIN_FTR_SECTION
+	b	performance_monitor_hv
+FTR_SECTION_ELSE
 	b	performance_monitor_pSeries
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 
 	. = 0xf20
 altivec_unavailable_pseries_trampoline:
@@ -602,8 +606,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+BEGIN_FTR_SECTION
+	MASKABLE_EXCEPTION_HV_OOL(0xf01, performance_monitor)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf01)
+FTR_SECTION_ELSE
+	MASKABLE_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf20)
 	STD_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
@@ -625,7 +634,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
  */
 #define MASKED_INTERRUPT(_H)				\
 masked_##_H##interrupt:					\
-	std	r11,PACA_EXGEN+EX_R11(r13);		\
+	bgt	3f;					\
+	cmpwi	r10,PACA_IRQ_PMI;			\
+	bne	3f;					\
+	blr;						\
+3:	mtlr	r11;					\
 	lbz	r11,PACAIRQHAPPENED(r13);		\
 	or	r11,r11,r10;				\
 	stb	r11,PACAIRQHAPPENED(r13);		\
@@ -881,7 +894,11 @@ h_doorbell_relon_trampoline:
 performance_monitor_relon_pseries_trampoline:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
+BEGIN_FTR_SECTION
+	b	performance_monitor_relon_hv
+FTR_SECTION_ELSE
 	b	performance_monitor_relon_pSeries
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 
 	. = 0x4f20
 altivec_unavailable_relon_pseries_trampoline:
@@ -1138,7 +1155,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
 	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
 
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+BEGIN_FTR_SECTION
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xf01, performance_monitor)
+FTR_SECTION_ELSE
+	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-- 
2.7.4
