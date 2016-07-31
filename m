Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2X5S2jKnzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:07:08 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6VJ3kEN124124
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:07:06 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gratk0kk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:07:06 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 05:07:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F03D23578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:07:01 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6VJ71nq28115124
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:07:01 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6VJ711a009822
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:07:01 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 08/11] powerpc: Add "mask_lvl" paramater to MASKABLE_*
 macros
Date: Mon,  1 Aug 2016 00:36:26 +0530
In-Reply-To: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469991989-28409-9-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make it explicit the interrupt masking level supported
by a gievn interrupt handler. Patch correspondingly
extends the MASKABLE_* macros with an addition's parameter.
"mask_lvl" parameter is passed to SOFTEN_TEST macro to decide
on masking the interrupt.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 66 ++++++++++++++++----------------
 arch/powerpc/kernel/exceptions-64s.S     | 25 ++++++------
 2 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 1e6f04adba51..01ab37eff3f8 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -179,9 +179,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
  * checking of the interrupt maskable level in the SOFTEN_TEST.
  * Intended to be used in MASKABLE_EXCPETION_* macros.
  */
-#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
+#define __EXCEPTION_PROLOG_1(area, extra, vec, mask_lvl)		\
 	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec);							\
+	extra(vec, mask_lvl);							\
 	__EXCEPTION_PROLOG_1_POST(area);
 
 /*
@@ -426,79 +426,81 @@ label##_relon_hv:						\
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
 
-#define __SOFTEN_TEST(h, vec)						\
+#define __SOFTEN_TEST(h, vec, mask_lvl)					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	cmpwi	r10,IRQ_DISABLE_LEVEL_LINUX;				\
+	andi.	r10,r10,mask_lvl;					\
 	li	r10,SOFTEN_VALUE_##vec;					\
-	bge	masked_##h##interrupt
-#define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
+	bne	masked_##h##interrupt
+#define _SOFTEN_TEST(h, vec, mask_lvl)	__SOFTEN_TEST(h, vec, mask_lvl)
 
-#define SOFTEN_TEST_PR(vec)						\
+#define SOFTEN_TEST_PR(vec, mask_lvl)					\
 	KVMTEST(vec);							\
-	_SOFTEN_TEST(EXC_STD, vec)
+	_SOFTEN_TEST(EXC_STD, vec, mask_lvl)
 
-#define SOFTEN_TEST_HV(vec)						\
+#define SOFTEN_TEST_HV(vec, mask_lvl)					\
 	KVMTEST(vec);							\
-	_SOFTEN_TEST(EXC_HV, vec)
+	_SOFTEN_TEST(EXC_HV, vec, mask_lvl)
 
-#define SOFTEN_NOTEST_PR(vec)		_SOFTEN_TEST(EXC_STD, vec)
-#define SOFTEN_NOTEST_HV(vec)		_SOFTEN_TEST(EXC_HV, vec)
+#define SOFTEN_NOTEST_PR(vec, mask_lvl)	\
+		_SOFTEN_TEST(EXC_STD, vec, mask_lvl)
+#define SOFTEN_NOTEST_HV(vec, mask_lvl)	\
+		_SOFTEN_TEST(EXC_HV, vec, mask_lvl)
 
-#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
+#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, mask_lvl)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);			\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, mask_lvl);		\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
 
-#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)
+#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, mask_lvl)	\
+	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, mask_lvl)
 
-#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label)			\
+#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label, mask_lvl)		\
 	. = loc;							\
 	.globl label##_pSeries;						\
 label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
-				    EXC_STD, SOFTEN_TEST_PR)
+				    EXC_STD, SOFTEN_TEST_PR, mask_lvl)
 
-#define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
+#define MASKABLE_EXCEPTION_HV(loc, vec, label, mask_lvl)		\
 	. = loc;							\
 	.globl label##_hv;						\
 label##_hv:								\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
-				    EXC_HV, SOFTEN_TEST_HV)
+				    EXC_HV, SOFTEN_TEST_HV, mask_lvl)
 
-#define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
+#define MASKABLE_EXCEPTION_HV_OOL(vec, label, mask_lvl)			\
 	.globl label##_hv;						\
 label##_hv:								\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, mask_lvl);\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
 
-#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
+#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, mask_lvl)\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, mask_lvl);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, h);
-#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
-	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)
+#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, mask_lvl)\
+	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, mask_lvl)
 
-#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label)		\
+#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label, mask_lvl)	\
 	. = loc;							\
 	.globl label##_relon_pSeries;					\
 label##_relon_pSeries:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_STD, SOFTEN_NOTEST_PR)
+					  EXC_STD, SOFTEN_NOTEST_PR, mask_lvl)
 
-#define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label)			\
+#define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, mask_lvl)		\
 	. = loc;							\
 	.globl label##_relon_hv;					\
 label##_relon_hv:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_HV, SOFTEN_NOTEST_HV)
+					  EXC_HV, SOFTEN_NOTEST_HV, mask_lvl)
 
-#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
+#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, mask_lvl)		\
 	.globl label##_relon_hv;					\
 label##_relon_hv:							\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);		\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec, mask_lvl);\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 8bcc1b457115..2c87e82ecbe4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -256,11 +256,11 @@ hardware_interrupt_pSeries:
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
-					    EXC_HV, SOFTEN_TEST_HV)
+					    EXC_HV, SOFTEN_TEST_HV, IRQ_DISABLE_LEVEL_LINUX)
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
-					    EXC_STD, SOFTEN_TEST_PR)
+					    EXC_STD, SOFTEN_TEST_PR, IRQ_DISABLE_LEVEL_LINUX)
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
@@ -276,11 +276,12 @@ hardware_interrupt_hv:
 	. = 0x900
 	.globl decrementer_pSeries
 decrementer_pSeries:
-	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD, SOFTEN_TEST_PR)
+	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD,
+					SOFTEN_TEST_PR, IRQ_DISABLE_LEVEL_LINUX)
 
 	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
-	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
+	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super, IRQ_DISABLE_LEVEL_LINUX)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xa00)
 
 	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
@@ -595,10 +596,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe22)
 	STD_EXCEPTION_HV_OOL(0xe42, emulation_assist)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe42)
-	MASKABLE_EXCEPTION_HV_OOL(0xe62, hmi_exception)
+	MASKABLE_EXCEPTION_HV_OOL(0xe62, hmi_exception, IRQ_DISABLE_LEVEL_LINUX)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe62)
 
-	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell)
+	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell, IRQ_DISABLE_LEVEL_LINUX)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
 
 	/* moved from 0xf00 */
@@ -834,16 +835,18 @@ instruction_access_slb_relon_pSeries:
 hardware_interrupt_relon_pSeries:
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV, SOFTEN_TEST_HV)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt,
+					EXC_HV, SOFTEN_TEST_HV, IRQ_DISABLE_LEVEL_LINUX)
 	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD, SOFTEN_TEST_PR)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt,
+					EXC_STD, SOFTEN_TEST_PR, IRQ_DISABLE_LEVEL_LINUX)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_RELON_EXCEPTION_PSERIES(0x4600, 0x600, alignment)
 	STD_RELON_EXCEPTION_PSERIES(0x4700, 0x700, program_check)
 	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer, IRQ_DISABLE_LEVEL_LINUX)
 	STD_RELON_EXCEPTION_HV(0x4980, 0x982, hdecrementer)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super, IRQ_DISABLE_LEVEL_LINUX)
 	STD_RELON_EXCEPTION_PSERIES(0x4b00, 0xb00, trap_0b)
 
 	. = 0x4c00
@@ -1136,7 +1139,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell, IRQ_DISABLE_LEVEL_LINUX)
 
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-- 
2.7.4
