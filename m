Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2X5Y4qHDzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:07:13 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6VJ3g00047708
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:07:11 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gr45x4r9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:07:11 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 05:07:08 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CC4882CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:07:04 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6VJ74E228115152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:07:04 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6VJ74Oc009845
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:07:04 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 09/11] powerpc: Add support to mask perf interrupts
Date: Mon,  1 Aug 2016 00:36:27 +0530
In-Reply-To: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469991989-28409-10-git-send-email-maddy@linux.vnet.ibm.com>
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

New flag value, "IRQ_DISABLE_LEVEL_PMU == 2", added to soft_enabled.
With new flag value for "soft_enabled", states looks like:

soft_enabled		MSR[EE]

2			0	Disbaled PMIs also
1			0	Disabled  (PMI and HMI not masked)
0			1	Enabled

PMI will have the maskable level as 2 and will be a NMI in lower level.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 14 +++++++++++
 arch/powerpc/include/asm/hw_irq.h        |  4 +++
 arch/powerpc/kernel/exceptions-64s.S     | 43 ++++++++++++++++++++++----------
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 01ab37eff3f8..90b150478398 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -425,6 +425,8 @@ label##_relon_hv:						\
 #define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
+#define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
+#define SOFTEN_VALUE_0xf01	PACA_IRQ_PMI
 
 #define __SOFTEN_TEST(h, vec, mask_lvl)					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
@@ -462,6 +464,12 @@ label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_STD, SOFTEN_TEST_PR, mask_lvl)
 
+#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label, mask_lvl)		\
+	.globl label##_pSeries;						\
+label##_pSeries:							\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, mask_lvl);\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD);
+
 #define MASKABLE_EXCEPTION_HV(loc, vec, label, mask_lvl)		\
 	. = loc;							\
 	.globl label##_hv;						\
@@ -490,6 +498,12 @@ label##_relon_pSeries:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_STD, SOFTEN_NOTEST_PR, mask_lvl)
 
+#define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, mask_lvl)	\
+	.globl label##_relon_pSeries;					\
+label##_relon_pSeries:							\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, mask_lvl);\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD);
+
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, mask_lvl)		\
 	. = loc;							\
 	.globl label##_relon_hv;					\
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 0206a6c493c7..a7b86edc94bf 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -26,12 +26,16 @@
 #define PACA_IRQ_DEC		0x08 /* Or FIT */
 #define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
 #define PACA_IRQ_HMI		0x20
+#define PACA_IRQ_PMI		0x40
 
 /*
  * flags for paca->soft_enabled
  */
 #define IRQ_DISABLE_LEVEL_NONE		0
 #define IRQ_DISABLE_LEVEL_LINUX		1
+#define IRQ_DISABLE_LEVEL_PMU		2
+
+#define MASK_IRQ_LEVEL		IRQ_DISABLE_LEVEL_LINUX | IRQ_DISABLE_LEVEL_PMU
 
 
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2c87e82ecbe4..56dc71b82824 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -256,11 +256,11 @@ hardware_interrupt_pSeries:
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
-					    EXC_HV, SOFTEN_TEST_HV, IRQ_DISABLE_LEVEL_LINUX)
+					    EXC_HV, SOFTEN_TEST_HV, MASK_IRQ_LEVEL)
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
-					    EXC_STD, SOFTEN_TEST_PR, IRQ_DISABLE_LEVEL_LINUX)
+					    EXC_STD, SOFTEN_TEST_PR, MASK_IRQ_LEVEL)
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
@@ -277,11 +277,11 @@ hardware_interrupt_hv:
 	.globl decrementer_pSeries
 decrementer_pSeries:
 	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD,
-					SOFTEN_TEST_PR, IRQ_DISABLE_LEVEL_LINUX)
+					SOFTEN_TEST_PR, MASK_IRQ_LEVEL)
 
 	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
-	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super, IRQ_DISABLE_LEVEL_LINUX)
+	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super, MASK_IRQ_LEVEL)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xa00)
 
 	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
@@ -361,7 +361,11 @@ hv_doorbell_trampoline:
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
@@ -596,15 +600,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe22)
 	STD_EXCEPTION_HV_OOL(0xe42, emulation_assist)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe42)
-	MASKABLE_EXCEPTION_HV_OOL(0xe62, hmi_exception, IRQ_DISABLE_LEVEL_LINUX)
+	MASKABLE_EXCEPTION_HV_OOL(0xe62, hmi_exception, MASK_IRQ_LEVEL)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe62)
 
-	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell, IRQ_DISABLE_LEVEL_LINUX)
+	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell, MASK_IRQ_LEVEL)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+BEGIN_FTR_SECTION
+	MASKABLE_EXCEPTION_HV_OOL(0xf01, performance_monitor, IRQ_DISABLE_LEVEL_PMU)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf01)
+FTR_SECTION_ELSE
+	MASKABLE_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor, IRQ_DISABLE_LEVEL_PMU)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf20)
 	STD_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
@@ -836,17 +845,17 @@ hardware_interrupt_relon_pSeries:
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt,
-					EXC_HV, SOFTEN_TEST_HV, IRQ_DISABLE_LEVEL_LINUX)
+					EXC_HV, SOFTEN_TEST_HV, MASK_IRQ_LEVEL)
 	FTR_SECTION_ELSE
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt,
-					EXC_STD, SOFTEN_TEST_PR, IRQ_DISABLE_LEVEL_LINUX)
+					EXC_STD, SOFTEN_TEST_PR, MASK_IRQ_LEVEL)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_RELON_EXCEPTION_PSERIES(0x4600, 0x600, alignment)
 	STD_RELON_EXCEPTION_PSERIES(0x4700, 0x700, program_check)
 	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer, IRQ_DISABLE_LEVEL_LINUX)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer, MASK_IRQ_LEVEL)
 	STD_RELON_EXCEPTION_HV(0x4980, 0x982, hdecrementer)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super, IRQ_DISABLE_LEVEL_LINUX)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super, MASK_IRQ_LEVEL)
 	STD_RELON_EXCEPTION_PSERIES(0x4b00, 0xb00, trap_0b)
 
 	. = 0x4c00
@@ -884,7 +893,11 @@ h_doorbell_relon_trampoline:
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
@@ -1139,9 +1152,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell, IRQ_DISABLE_LEVEL_LINUX)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell, MASK_IRQ_LEVEL)
 
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+BEGIN_FTR_SECTION
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xf01, performance_monitor, IRQ_DISABLE_LEVEL_PMU)
+FTR_SECTION_ELSE
+	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor, IRQ_DISABLE_LEVEL_PMU)
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-- 
2.7.4
