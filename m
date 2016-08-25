Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKZ7J2VPnzDrfV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 16:30:52 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7P6SNO8032681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:50 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 251kn3hdsj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 02:30:50 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 12:00:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AFE3E3940071
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:42 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7P6UgYi7405886
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:42 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7P6Udxc031717
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 12:00:41 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 10/12] powerpc: Add support to mask perf interrupts
Date: Thu, 25 Aug 2016 12:00:01 +0530
In-Reply-To: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472106603-23336-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472106603-23336-11-git-send-email-maddy@linux.vnet.ibm.com>
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

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 13 +++++++++++++
 arch/powerpc/include/asm/hw_irq.h        |  1 +
 arch/powerpc/kernel/exceptions-64s.S     |  4 ++--
 3 files changed, 16 insertions(+), 2 deletions(-)

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
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6c56554cfcc3..bc2a838e1926 100644
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
@@ -1126,7 +1126,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	MASKABLE_RELON_EXCEPTION_HV_OOL(0xea0, h_virt_irq,
 							IRQ_DISABLE_MASK_LINUX)
 
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor, IRQ_DISABLE_MASK_PMU)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-- 
2.7.4
