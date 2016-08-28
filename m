Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMk7t57BCzDrgS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 04:38:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SIckuJ140794
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 14:38:48 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 253ref3hdd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 14:38:47 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 00:08:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 66559125805C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 00:08:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SIcfMw18022492
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 00:08:41 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SIcGTT026612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 00:08:18 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v4 09/12] powerpc: Add "bitmask" paramater to MASKABLE_*
 macros
Date: Mon, 29 Aug 2016 00:07:25 +0530
In-Reply-To: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472409448-18172-10-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make it explicit the interrupt masking supported
by a gievn interrupt handler. Patch correspondingly
extends the MASKABLE_* macros with an addition's parameter.
"bitmask" parameter is passed to SOFTEN_TEST macro to decide
on masking the interrupt.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 62 ++++++++++++++++----------------
 arch/powerpc/kernel/exceptions-64s.S     | 36 ++++++++++++-------
 2 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 1eea4ab75607..41be0c2d7658 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -179,9 +179,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
  * checking of the interrupt maskable level in the SOFTEN_TEST.
  * Intended to be used in MASKABLE_EXCPETION_* macros.
  */
-#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
+#define __EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
 	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec);							\
+	extra(vec, bitmask);						\
 	__EXCEPTION_PROLOG_1_POST(area);
 
 /*
@@ -428,79 +428,79 @@ label##_relon_hv:						\
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
 #define SOFTEN_VALUE_0xea2	PACA_IRQ_EE
 
-#define __SOFTEN_TEST(h, vec)						\
+#define __SOFTEN_TEST(h, vec, bitmask)					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;				\
+	andi.	r10,r10,bitmask;					\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	bne	masked_##h##interrupt
-#define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
+#define _SOFTEN_TEST(h, vec, bitmask)	__SOFTEN_TEST(h, vec, bitmask)
 
-#define SOFTEN_TEST_PR(vec)						\
+#define SOFTEN_TEST_PR(vec, bitmask)					\
 	KVMTEST(vec);							\
-	_SOFTEN_TEST(EXC_STD, vec)
+	_SOFTEN_TEST(EXC_STD, vec, bitmask)
 
-#define SOFTEN_TEST_HV(vec)						\
+#define SOFTEN_TEST_HV(vec, bitmask)					\
 	KVMTEST(vec);							\
-	_SOFTEN_TEST(EXC_HV, vec)
+	_SOFTEN_TEST(EXC_HV, vec, bitmask)
 
-#define SOFTEN_NOTEST_PR(vec)		_SOFTEN_TEST(EXC_STD, vec)
-#define SOFTEN_NOTEST_HV(vec)		_SOFTEN_TEST(EXC_HV, vec)
+#define SOFTEN_NOTEST_PR(vec, bitmask)		_SOFTEN_TEST(EXC_STD, vec, bitmask)
+#define SOFTEN_NOTEST_HV(vec, bitmask)		_SOFTEN_TEST(EXC_HV, vec, bitmask)
 
-#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
+#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);			\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);		\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
 
-#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)
+#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
+	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)
 
-#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label)			\
+#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label, bitmask)		\
 	. = loc;							\
 	.globl label##_pSeries;						\
 label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
-				    EXC_STD, SOFTEN_TEST_PR)
+				    EXC_STD, SOFTEN_TEST_PR, bitmask)
 
-#define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
+#define MASKABLE_EXCEPTION_HV(loc, vec, label, bitmask)			\
 	. = loc;							\
 	.globl label##_hv;						\
 label##_hv:								\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
-				    EXC_HV, SOFTEN_TEST_HV)
+				    EXC_HV, SOFTEN_TEST_HV, bitmask)
 
-#define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
+#define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
 	.globl label##_hv;						\
 label##_hv:								\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);	\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
 
-#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
+#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, h);
-#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
-	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)
+#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)\
+	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)
 
-#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label)		\
+#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label, bitmask)	\
 	. = loc;							\
 	.globl label##_relon_pSeries;					\
 label##_relon_pSeries:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_STD, SOFTEN_NOTEST_PR)
+					  EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
-#define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label)			\
+#define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
 	. = loc;							\
 	.globl label##_relon_hv;					\
 label##_relon_hv:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_HV, SOFTEN_NOTEST_HV)
+					  EXC_HV, SOFTEN_NOTEST_HV, bitmask)
 
-#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
+#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
 	.globl label##_relon_hv;					\
 label##_relon_hv:							\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec, bitmask);\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index df6d45eb4115..6c56554cfcc3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -221,11 +221,13 @@ hardware_interrupt_pSeries:
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
-					    EXC_HV, SOFTEN_TEST_HV)
+					    EXC_HV, SOFTEN_TEST_HV,
+						IRQ_DISABLE_MASK_LINUX)
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
-					    EXC_STD, SOFTEN_TEST_PR)
+					    EXC_STD, SOFTEN_TEST_PR,
+						IRQ_DISABLE_MASK_LINUX)
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
@@ -241,11 +243,13 @@ hardware_interrupt_hv:
 	. = 0x900
 	.globl decrementer_pSeries
 decrementer_pSeries:
-	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD, SOFTEN_TEST_PR)
+	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD, SOFTEN_TEST_PR,
+							IRQ_DISABLE_MASK_LINUX)
 
 	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
-	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
+	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super,
+							IRQ_DISABLE_MASK_LINUX)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xa00)
 
 	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
@@ -566,13 +570,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe22)
 	STD_EXCEPTION_HV_OOL(0xe42, emulation_assist)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe42)
-	MASKABLE_EXCEPTION_HV_OOL(0xe62, hmi_exception)
+	MASKABLE_EXCEPTION_HV_OOL(0xe62, hmi_exception,IRQ_DISABLE_MASK_LINUX)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe62)
 
-	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell)
+	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell,IRQ_DISABLE_MASK_LINUX)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
 
-	MASKABLE_EXCEPTION_HV_OOL(0xea2, h_virt_irq)
+	MASKABLE_EXCEPTION_HV_OOL(0xea2, h_virt_irq,IRQ_DISABLE_MASK_LINUX)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xea2)
 
 	/* moved from 0xf00 */
@@ -808,16 +812,20 @@ instruction_access_slb_relon_pSeries:
 hardware_interrupt_relon_pSeries:
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV, SOFTEN_TEST_HV)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt,
+			EXC_HV, SOFTEN_TEST_HV, IRQ_DISABLE_MASK_LINUX)
 	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD, SOFTEN_TEST_PR)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt,
+			EXC_STD, SOFTEN_TEST_PR, IRQ_DISABLE_MASK_LINUX)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_RELON_EXCEPTION_PSERIES(0x4600, 0x600, alignment)
 	STD_RELON_EXCEPTION_PSERIES(0x4700, 0x700, program_check)
 	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer,
+							IRQ_DISABLE_MASK_LINUX)
 	STD_RELON_EXCEPTION_HV(0x4980, 0x982, hdecrementer)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super,
+							IRQ_DISABLE_MASK_LINUX)
 	STD_RELON_EXCEPTION_PSERIES(0x4b00, 0xb00, trap_0b)
 
 	. = 0x4c00
@@ -1113,8 +1121,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xea0, h_virt_irq)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell,
+							IRQ_DISABLE_MASK_LINUX)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xea0, h_virt_irq,
+							IRQ_DISABLE_MASK_LINUX)
 
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-- 
2.7.4
