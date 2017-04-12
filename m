Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2xGq6vHJzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:27 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C7rnku037215
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:18 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29rxx3mf6f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:02:17 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 18:02:15 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3C8249R41877724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:02:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3C81aOo003094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:01:36 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v7 07/11] powerpc: Add support to take additional parameter in
 MASKABLE_* macro
Date: Wed, 12 Apr 2017 13:30:36 +0530
In-Reply-To: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491984040-28801-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491984040-28801-8-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To support addition of "bitmask" to MASKABLE_* macros,
factor out the EXCPETION_PROLOG_1 macro.

Make it explicit the interrupt masking supported
by a gievn interrupt handler. Patch correspondingly
extends the MASKABLE_* macros with an addition's parameter.
"bitmask" parameter is passed to SOFTEN_TEST macro to decide
on masking the interrupt.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 92 ++++++++++++++++++++------------
 arch/powerpc/include/asm/head-64.h       | 40 +++++++-------
 arch/powerpc/include/asm/irqflags.h      |  4 +-
 arch/powerpc/kernel/entry_64.S           |  4 +-
 arch/powerpc/kernel/exceptions-64e.S     |  6 +--
 arch/powerpc/kernel/exceptions-64s.S     | 32 ++++++-----
 6 files changed, 103 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 25f8134d1b62..72c96162c492 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -178,18 +178,40 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	GET_PACA(r13);							\
 	EXCEPTION_PROLOG_0_PACA(area)
 
-#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
+#define __EXCEPTION_PROLOG_1_PRE(area)					\
 	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
 	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
 	SAVE_CTR(r10, area);						\
-	mfcr	r9;							\
-	extra(vec);							\
+	mfcr	r9;
+
+#define __EXCEPTION_PROLOG_1_POST(area)					\
 	std	r11,area+EX_R11(r13);					\
 	std	r12,area+EX_R12(r13);					\
 	GET_SCRATCH0(r10);						\
 	std	r10,area+EX_R13(r13)
+
+/*
+ * This version of the EXCEPTION_PROLOG_1 will carry
+ * addition parameter called "bitmask" to support
+ * checking of the interrupt maskable level in the SOFTEN_TEST.
+ * Intended to be used in MASKABLE_EXCPETION_* macros.
+ */
+#define MASKABLE_EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
+	__EXCEPTION_PROLOG_1_PRE(area);					\
+	extra(vec, bitmask);						\
+	__EXCEPTION_PROLOG_1_POST(area);
+
+/*
+ * This version of the EXCEPTION_PROLOG_1 is intended
+ * to be used in STD_EXCEPTION* macros
+ */
+#define _EXCEPTION_PROLOG_1(area, extra, vec)				\
+	__EXCEPTION_PROLOG_1_PRE(area);					\
+	extra(vec);							\
+	__EXCEPTION_PROLOG_1_POST(area);
+
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
-	__EXCEPTION_PROLOG_1(area, extra, vec)
+	_EXCEPTION_PROLOG_1(area, extra, vec)
 
 #define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
@@ -453,21 +475,21 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
 
-#define __SOFTEN_TEST(h, vec)						\
+#define __SOFTEN_TEST(h, vec, bitmask)					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;				\
+	andi.	r10,r10,bitmask;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	bne	masked_##h##interrupt
 
-#define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
+#define _SOFTEN_TEST(h, vec, bitmask)	__SOFTEN_TEST(h, vec, bitmask)
 
-#define SOFTEN_TEST_PR(vec)						\
+#define SOFTEN_TEST_PR(vec, bitmask)						\
 	KVMTEST(EXC_STD, vec);						\
-	_SOFTEN_TEST(EXC_STD, vec)
+	_SOFTEN_TEST(EXC_STD, vec, bitmask)
 
-#define SOFTEN_TEST_HV(vec)						\
+#define SOFTEN_TEST_HV(vec, bitmask)						\
 	KVMTEST(EXC_HV, vec);						\
-	_SOFTEN_TEST(EXC_HV, vec)
+	_SOFTEN_TEST(EXC_HV, vec, bitmask)
 
 #define KVMTEST_PR(vec)							\
 	KVMTEST(EXC_STD, vec)
@@ -475,53 +497,53 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define KVMTEST_HV(vec)							\
 	KVMTEST(EXC_HV, vec)
 
-#define SOFTEN_NOTEST_PR(vec)		_SOFTEN_TEST(EXC_STD, vec)
-#define SOFTEN_NOTEST_HV(vec)		_SOFTEN_TEST(EXC_HV, vec)
+#define SOFTEN_NOTEST_PR(vec, bitmask)		_SOFTEN_TEST(EXC_STD, vec, bitmask)
+#define SOFTEN_NOTEST_HV(vec, bitmask)		_SOFTEN_TEST(EXC_HV, vec, bitmask)
 
-#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
+#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);			\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
-#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)
+#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
+	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)
 
-#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label)			\
+#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label, bitmask)		\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
-				    EXC_STD, SOFTEN_TEST_PR)
+				    EXC_STD, SOFTEN_TEST_PR, bitmask)
 
-#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label, bitmask)		\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);	\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
 
-#define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
+#define MASKABLE_EXCEPTION_HV(loc, vec, label, bitmask)			\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
-				    EXC_HV, SOFTEN_TEST_HV)
+				    EXC_HV, SOFTEN_TEST_HV, bitmask)
 
-#define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+#define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
-#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
+#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);			\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
 
-#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)
+#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)\
+	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)
 
-#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label)		\
+#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label, bitmask)	\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_STD, SOFTEN_NOTEST_PR)
+					  EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
-#define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label)			\
+#define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_HV, SOFTEN_TEST_HV)
+					  EXC_HV, SOFTEN_TEST_HV, bitmask)
 
-#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec, bitmask);\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 5067048daad4..9aa248c05cf1 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -248,14 +248,14 @@ end_##sname:
 	STD_RELON_EXCEPTION_PSERIES(start, realvec, name##_common);	\
 	EXC_VIRT_END(name, start, size);
 
-#define EXC_REAL_MASKABLE(name, start, size)				\
+#define EXC_REAL_MASKABLE(name, start, size, bitmask)			\
 	EXC_REAL_BEGIN(name, start, size);				\
-	MASKABLE_EXCEPTION_PSERIES(start, start, name##_common);	\
+	MASKABLE_EXCEPTION_PSERIES(start, start, name##_common, bitmask);\
 	EXC_REAL_END(name, start, size);
 
-#define EXC_VIRT_MASKABLE(name, start, size, realvec)			\
+#define EXC_VIRT_MASKABLE(name, start, size, realvec, bitmask)		\
 	EXC_VIRT_BEGIN(name, start, size);				\
-	MASKABLE_RELON_EXCEPTION_PSERIES(start, realvec, name##_common); \
+	MASKABLE_RELON_EXCEPTION_PSERIES(start, realvec, name##_common, bitmask);\
 	EXC_VIRT_END(name, start, size);
 
 #define EXC_REAL_HV(name, start, size)					\
@@ -284,13 +284,13 @@ end_##sname:
 #define __EXC_REAL_OOL_MASKABLE(name, start, size)			\
 	__EXC_REAL_OOL(name, start, size);
 
-#define __TRAMP_REAL_OOL_MASKABLE(name, vec)				\
+#define __TRAMP_REAL_OOL_MASKABLE(name, vec, bitmask)			\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common);		\
+	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common, bitmask);	\
 
-#define EXC_REAL_OOL_MASKABLE(name, start, size)			\
+#define EXC_REAL_OOL_MASKABLE(name, start, size, bitmask)		\
 	__EXC_REAL_OOL_MASKABLE(name, start, size);			\
-	__TRAMP_REAL_OOL_MASKABLE(name, start);
+	__TRAMP_REAL_OOL_MASKABLE(name, start, bitmask);
 
 #define __EXC_REAL_OOL_HV_DIRECT(name, start, size, handler)		\
 	EXC_REAL_BEGIN(name, start, size);				\
@@ -311,13 +311,13 @@ end_##sname:
 #define __EXC_REAL_OOL_MASKABLE_HV(name, start, size)			\
 	__EXC_REAL_OOL(name, start, size);
 
-#define __TRAMP_REAL_OOL_MASKABLE_HV(name, vec)				\
+#define __TRAMP_REAL_OOL_MASKABLE_HV(name, vec, bitmask)		\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common);			\
+	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common, bitmask);		\
 
-#define EXC_REAL_OOL_MASKABLE_HV(name, start, size)			\
+#define EXC_REAL_OOL_MASKABLE_HV(name, start, size, bitmask)		\
 	__EXC_REAL_OOL_MASKABLE_HV(name, start, size);			\
-	__TRAMP_REAL_OOL_MASKABLE_HV(name, start);
+	__TRAMP_REAL_OOL_MASKABLE_HV(name, start, bitmask);
 
 #define __EXC_VIRT_OOL(name, start, size)				\
 	EXC_VIRT_BEGIN(name, start, size);				\
@@ -335,13 +335,13 @@ end_##sname:
 #define __EXC_VIRT_OOL_MASKABLE(name, start, size)			\
 	__EXC_VIRT_OOL(name, start, size);
 
-#define __TRAMP_VIRT_OOL_MASKABLE(name, realvec)			\
+#define __TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)		\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
+	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common, bitmask);\
 
-#define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec)		\
+#define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec, bitmask)	\
 	__EXC_VIRT_OOL_MASKABLE(name, start, size);			\
-	__TRAMP_VIRT_OOL_MASKABLE(name, realvec);
+	__TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask);
 
 #define __EXC_VIRT_OOL_HV(name, start, size)				\
 	__EXC_VIRT_OOL(name, start, size);
@@ -357,13 +357,13 @@ end_##sname:
 #define __EXC_VIRT_OOL_MASKABLE_HV(name, start, size)			\
 	__EXC_VIRT_OOL(name, start, size);
 
-#define __TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec)			\
+#define __TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask)		\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common);	\
+	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common, bitmask);\
 
-#define EXC_VIRT_OOL_MASKABLE_HV(name, start, size, realvec)		\
+#define EXC_VIRT_OOL_MASKABLE_HV(name, start, size, realvec, bitmask)	\
 	__EXC_VIRT_OOL_MASKABLE_HV(name, start, size);			\
-	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec);
+	__TRAMP_VIRT_OOL_MASKABLE_HV(name, realvec, bitmask);
 
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index d0ed2a7d7d10..9ff09747a226 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -48,11 +48,11 @@
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACASOFTIRQEN(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	cmpwi	cr0,__rA,IRQ_DISABLE_MASK_LINUX;\
+	andi.	__rA,__rA,IRQ_DISABLE_MASK_LINUX;\
 	li	__rA,IRQ_DISABLE_MASK_LINUX;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
-	beq	44f;				\
+	bne	44f;				\
 	stb	__rA,PACASOFTIRQEN(r13);	\
 	TRACE_DISABLE_INTS;			\
 44:
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7ef3064ddde1..f3afa0b9332d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -763,8 +763,8 @@ restore:
 	 */
 	ld	r5,SOFTE(r1)
 	lbz	r6,PACASOFTIRQEN(r13)
-	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
-	beq	restore_irq_off
+	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
+	bne	restore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
 	cmpwi	cr0,r6,IRQ_DISABLE_MASK_NONE
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 84de31f6f3ed..6ee1ed7e2a86 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -212,8 +212,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	/* Interrupts had better not already be enabled... */
 	twnei	r6,IRQ_DISABLE_MASK_LINUX
 
-	cmpwi	cr0,r5,IRQ_DISABLE_MASK_LINUX
-	beq	1f
+	andi.	r5,r5,IRQ_DISABLE_MASK_LINUX
+	bne	1f
 
 	TRACE_ENABLE_INTS
 	stb	r5,PACASOFTIRQEN(r13)
@@ -352,7 +352,7 @@ ret_from_mc_except:
 
 #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
 	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	cmpwi	cr0,r10,IRQ_DISABLE_MASK_LINUX;	/* yes -> go out of line */ \
+	andi.	r10,r10,IRQ_DISABLE_MASK_LINUX;	/* yes -> go out of line */ \
 	beq	masked_interrupt_book3e_##n
 
 #define PROLOG_ADDITION_2REGS_GEN(n)					    \
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 857bf7c5b946..5c93a1700d83 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -716,10 +716,12 @@ EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
-					    EXC_HV, SOFTEN_TEST_HV)
+					    EXC_HV, SOFTEN_TEST_HV,
+					    IRQ_DISABLE_MASK_LINUX)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
-					    EXC_STD, SOFTEN_TEST_PR)
+					    EXC_STD, SOFTEN_TEST_PR,
+					    IRQ_DISABLE_MASK_LINUX)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
 
@@ -727,9 +729,13 @@ EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
 	.globl hardware_interrupt_relon_hv;
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+						  EXC_HV, SOFTEN_TEST_HV,
+						  IRQ_DISABLE_MASK_LINUX)
 	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+						  EXC_STD, SOFTEN_TEST_PR,
+						  IRQ_DISABLE_MASK_LINUX)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
 
@@ -803,8 +809,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
 
-EXC_REAL_MASKABLE(decrementer, 0x900, 0x80)
-EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x80, 0x900)
+EXC_REAL_MASKABLE(decrementer, 0x900, 0x80, IRQ_DISABLE_MASK_LINUX)
+EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x80, 0x900, IRQ_DISABLE_MASK_LINUX)
 TRAMP_KVM(PACA_EXGEN, 0x900)
 EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
 
@@ -815,8 +821,8 @@ TRAMP_KVM_HV(PACA_EXGEN, 0x980)
 EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
 
-EXC_REAL_MASKABLE(doorbell_super, 0xa00, 0x100)
-EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x100, 0xa00)
+EXC_REAL_MASKABLE(doorbell_super, 0xa00, 0x100, IRQ_DISABLE_MASK_LINUX)
+EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x100, 0xa00, IRQ_DISABLE_MASK_LINUX)
 TRAMP_KVM(PACA_EXGEN, 0xa00)
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
@@ -963,7 +969,7 @@ EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
  * mode.
  */
 __EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0x20, hmi_exception_early)
-__TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
+__TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60, IRQ_DISABLE_MASK_LINUX)
 EXC_VIRT_NONE(0x4e60, 0x20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
@@ -1018,8 +1024,8 @@ hmi_exception_after_realmode:
 EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
 
 
-EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0x20)
-EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x20, 0xe80)
+EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0x20, IRQ_DISABLE_MASK_LINUX)
+EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x20, 0xe80, IRQ_DISABLE_MASK_LINUX)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
@@ -1028,8 +1034,8 @@ EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
 
 
-EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0x20)
-EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x20, 0xea0)
+EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0x20, IRQ_DISABLE_MASK_LINUX)
+EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x20, 0xea0, IRQ_DISABLE_MASK_LINUX)
 TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
 EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 
-- 
2.7.4
