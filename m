Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc274zZBzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 01/42] powerpc/64s: Add new exception vector macros
Date: Wed,  5 Oct 2016 11:22:23 +1100
Message-Id: <1475626984-18770-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create arch/powerpc/include/asm/head-64.h with macros that specify
an exception vector (name, type, location), which will be used to
label and lay out exceptions into the object file.

Naming is moved out of exception-64s.h, which is used to specify the
implementation of exception handlers.

objdump of generated code in exception vectors is unchanged except for
names. Alignment directives scattered around are annoying, but done
this way so that disassembly can verify identical instruction
generation before and after patch. These get cleaned up in future
patch.

We change the way KVMTEST works, explicitly passing EXC_HV or EXC_STD
rather than overloading the trap number. This removes the need to have
SOFTEN values for the overloaded trap numbers, eg. 0x502.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 135 +++----
 arch/powerpc/include/asm/head-64.h       | 163 +++++++++
 arch/powerpc/kernel/exceptions-64s.S     | 597 +++++++++++++++----------------
 3 files changed, 504 insertions(+), 391 deletions(-)
 create mode 100644 arch/powerpc/include/asm/head-64.h

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 5032a80e8f6a..72f2b1e3f343 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -34,6 +34,7 @@
  * exception handlers (including pSeries LPAR) and iSeries LPAR
  * implementations as possible.
  */
+#include <asm/head-64.h>
 
 #define EX_R9		0
 #define EX_R10		8
@@ -191,10 +192,10 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
-#define __KVMTEST(n)							\
-	lbz	r10,HSTATE_IN_GUEST(r13);			\
+#define __KVMTEST(h, n)							\
+	lbz	r10,HSTATE_IN_GUEST(r13);				\
 	cmpwi	r10,0;							\
-	bne	do_kvm_##n
+	bne	do_kvm_##h##n
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
@@ -207,8 +208,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define kvmppc_interrupt kvmppc_interrupt_pr
 #endif
 
-#define __KVM_HANDLER(area, h, n)					\
-do_kvm_##n:								\
+#define __KVM_HANDLER_PROLOG(area, n)					\
 	BEGIN_FTR_SECTION_NESTED(947)					\
 	ld	r10,area+EX_CFAR(r13);					\
 	std	r10,HSTATE_CFAR(r13);					\
@@ -221,21 +221,23 @@ do_kvm_##n:								\
 	stw	r9,HSTATE_SCRATCH1(r13);				\
 	ld	r9,area+EX_R9(r13);					\
 	std	r12,HSTATE_SCRATCH0(r13);				\
+
+#define __KVM_HANDLER(area, h, n)					\
+	__KVM_HANDLER_PROLOG(area, n)					\
 	li	r12,n;							\
 	b	kvmppc_interrupt
 
 #define __KVM_HANDLER_SKIP(area, h, n)					\
-do_kvm_##n:								\
 	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
 	ld	r10,area+EX_R10(r13);					\
 	beq	89f;							\
-	stw	r9,HSTATE_SCRATCH1(r13);			\
+	stw	r9,HSTATE_SCRATCH1(r13);				\
 	BEGIN_FTR_SECTION_NESTED(948)					\
 	ld	r9,area+EX_PPR(r13);					\
 	std	r9,HSTATE_PPR(r13);					\
 	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
 	ld	r9,area+EX_R9(r13);					\
-	std	r12,HSTATE_SCRATCH0(r13);			\
+	std	r12,HSTATE_SCRATCH0(r13);				\
 	li	r12,n;							\
 	b	kvmppc_interrupt;					\
 89:	mtocrf	0x80,r9;						\
@@ -243,12 +245,12 @@ do_kvm_##n:								\
 	b	kvmppc_skip_##h##interrupt
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-#define KVMTEST(n)			__KVMTEST(n)
+#define KVMTEST(h, n)			__KVMTEST(h, n)
 #define KVM_HANDLER(area, h, n)		__KVM_HANDLER(area, h, n)
 #define KVM_HANDLER_SKIP(area, h, n)	__KVM_HANDLER_SKIP(area, h, n)
 
 #else
-#define KVMTEST(n)
+#define KVMTEST(h, n)
 #define KVM_HANDLER(area, h, n)
 #define KVM_HANDLER_SKIP(area, h, n)
 #endif
@@ -332,94 +334,79 @@ do_kvm_##n:								\
 /*
  * Exception vectors.
  */
-#define STD_EXCEPTION_PSERIES(vec, label)		\
-	. = vec;					\
-	.globl label##_pSeries;				\
-label##_pSeries:					\
+#define STD_EXCEPTION_PSERIES(vec, label)			\
 	SET_SCRATCH0(r13);		/* save r13 */		\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
-				 EXC_STD, KVMTEST, vec)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label,		\
+				 EXC_STD, KVMTEST_PR, vec);	\
 
 /* Version of above for when we have to branch out-of-line */
+#define __OOL_EXCEPTION(vec, label, hdlr)			\
+	SET_SCRATCH0(r13)					\
+	EXCEPTION_PROLOG_0(PACA_EXGEN)				\
+	b hdlr;
+
 #define STD_EXCEPTION_PSERIES_OOL(vec, label)			\
-	.globl label##_pSeries;					\
-label##_pSeries:						\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, vec);	\
-	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD)
-
-#define STD_EXCEPTION_HV(loc, vec, label)		\
-	. = loc;					\
-	.globl label##_hv;				\
-label##_hv:						\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
+	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
+
+#define STD_EXCEPTION_HV(loc, vec, label)			\
 	SET_SCRATCH0(r13);	/* save r13 */			\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
-				 EXC_HV, KVMTEST, vec)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label,		\
+				 EXC_HV, KVMTEST_HV, vec);
 
-/* Version of above for when we have to branch out-of-line */
-#define STD_EXCEPTION_HV_OOL(vec, label)		\
-	.globl label##_hv;				\
-label##_hv:						\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, vec);	\
-	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV)
+#define STD_EXCEPTION_HV_OOL(vec, label)			\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
+	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define STD_RELON_EXCEPTION_PSERIES(loc, vec, label)	\
-	. = loc;					\
-	.globl label##_relon_pSeries;			\
-label##_relon_pSeries:					\
 	/* No guest interrupts come through here */	\
 	SET_SCRATCH0(r13);		/* save r13 */	\
-	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
-				       EXC_STD, NOTEST, vec)
+	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label, EXC_STD, NOTEST, vec);
 
 #define STD_RELON_EXCEPTION_PSERIES_OOL(vec, label)		\
-	.globl label##_relon_pSeries;				\
-label##_relon_pSeries:						\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, EXC_STD)
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
-	. = loc;					\
-	.globl label##_relon_hv;			\
-label##_relon_hv:					\
 	/* No guest interrupts come through here */	\
 	SET_SCRATCH0(r13);	/* save r13 */		\
-	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
-				       EXC_HV, NOTEST, vec)
+	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label, EXC_HV, NOTEST, vec);
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	.globl label##_relon_hv;				\
-label##_relon_hv:						\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, EXC_HV)
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
 
 /* This associate vector numbers with bits in paca->irq_happened */
 #define SOFTEN_VALUE_0x500	PACA_IRQ_EE
-#define SOFTEN_VALUE_0x502	PACA_IRQ_EE
 #define SOFTEN_VALUE_0x900	PACA_IRQ_DEC
-#define SOFTEN_VALUE_0x982	PACA_IRQ_DEC
+#define SOFTEN_VALUE_0x980	PACA_IRQ_DEC
 #define SOFTEN_VALUE_0xa00	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
-#define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
-#define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
-#define SOFTEN_VALUE_0xea2	PACA_IRQ_EE
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	r10,0;							\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	beq	masked_##h##interrupt
+
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
 #define SOFTEN_TEST_PR(vec)						\
-	KVMTEST(vec);							\
+	KVMTEST(EXC_STD, vec);						\
 	_SOFTEN_TEST(EXC_STD, vec)
 
 #define SOFTEN_TEST_HV(vec)						\
-	KVMTEST(vec);							\
+	KVMTEST(EXC_HV, vec);						\
 	_SOFTEN_TEST(EXC_HV, vec)
 
+#define KVMTEST_PR(vec)							\
+	KVMTEST(EXC_STD, vec)
+
+#define KVMTEST_HV(vec)							\
+	KVMTEST(EXC_HV, vec)
+
 #define SOFTEN_NOTEST_PR(vec)		_SOFTEN_TEST(EXC_STD, vec)
 #define SOFTEN_NOTEST_HV(vec)		_SOFTEN_TEST(EXC_HV, vec)
 
@@ -427,58 +414,47 @@ label##_relon_hv:						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);			\
-	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
+	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
 #define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
 	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)
 
 #define MASKABLE_EXCEPTION_PSERIES(loc, vec, label)			\
-	. = loc;							\
-	.globl label##_pSeries;						\
-label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_STD, SOFTEN_TEST_PR)
 
+#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
+
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
-	. = loc;							\
-	.globl label##_hv;						\
-label##_hv:								\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
-	.globl label##_hv;						\
-label##_hv:								\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
-	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
+	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, h);
-#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);			\
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
+
+#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)		\
 	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)
 
 #define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label)		\
-	. = loc;							\
-	.globl label##_relon_pSeries;					\
-label##_relon_pSeries:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_STD, SOFTEN_NOTEST_PR)
 
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label)			\
-	. = loc;							\
-	.globl label##_relon_hv;					\
-label##_relon_hv:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_HV, SOFTEN_NOTEST_HV)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	.globl label##_relon_hv;					\
-label##_relon_hv:							\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);		\
-	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
+	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
  * Our exception common code can be passed various "additions"
@@ -504,9 +480,6 @@ BEGIN_FTR_SECTION				\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
 #define EXCEPTION_COMMON(trap, label, hdlr, ret, additions)	\
-	.align	7;						\
-	.globl label##_common;					\
-label##_common:							\
 	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);		\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
new file mode 100644
index 000000000000..358c25c80c62
--- /dev/null
+++ b/arch/powerpc/include/asm/head-64.h
@@ -0,0 +1,163 @@
+#ifndef _ASM_POWERPC_HEAD_64_H
+#define _ASM_POWERPC_HEAD_64_H
+
+#include <asm/cache.h>
+
+#define EXC_REAL_BEGIN(name, start, end)			\
+	. = start ;							\
+	.global exc_real_##start##_##name ;				\
+exc_real_##start##_##name:
+
+#define EXC_REAL_END(name, start, end)
+
+#define EXC_VIRT_BEGIN(name, start, end)			\
+	. = start ;							\
+	.global exc_virt_##start##_##name ;				\
+exc_virt_##start##_##name:
+
+#define EXC_VIRT_END(name, start, end)
+
+#define EXC_COMMON_BEGIN(name)					\
+	.global name;							\
+name:
+
+#define TRAMP_REAL_BEGIN(name)					\
+	.global name ;							\
+name:
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#define TRAMP_KVM_BEGIN(name)						\
+	TRAMP_REAL_BEGIN(name)
+#else
+#define TRAMP_KVM_BEGIN(name)
+#endif
+
+#define EXC_REAL_NONE(start, end)
+
+#define EXC_VIRT_NONE(start, end)
+
+
+#define EXC_REAL(name, start, end)				\
+	EXC_REAL_BEGIN(name, start, end);			\
+	STD_EXCEPTION_PSERIES(start, name##_common);			\
+	EXC_REAL_END(name, start, end);
+
+#define EXC_VIRT(name, start, end, realvec)			\
+	EXC_VIRT_BEGIN(name, start, end);			\
+	STD_RELON_EXCEPTION_PSERIES(start, realvec, name##_common);	\
+	EXC_VIRT_END(name, start, end);
+
+#define EXC_REAL_MASKABLE(name, start, end)			\
+	EXC_REAL_BEGIN(name, start, end);			\
+	MASKABLE_EXCEPTION_PSERIES(start, start, name##_common);	\
+	EXC_REAL_END(name, start, end);
+
+#define EXC_VIRT_MASKABLE(name, start, end, realvec)		\
+	EXC_VIRT_BEGIN(name, start, end);			\
+	MASKABLE_RELON_EXCEPTION_PSERIES(start, realvec, name##_common); \
+	EXC_VIRT_END(name, start, end);
+
+#define EXC_REAL_HV(name, start, end)			\
+	EXC_REAL_BEGIN(name, start, end);			\
+	STD_EXCEPTION_HV(start, start, name##_common);			\
+	EXC_REAL_END(name, start, end);
+
+#define EXC_VIRT_HV(name, start, end, realvec)		\
+	EXC_VIRT_BEGIN(name, start, end);			\
+	STD_RELON_EXCEPTION_HV(start, realvec, name##_common);		\
+	EXC_VIRT_END(name, start, end);
+
+#define __EXC_REAL_OOL(name, start, end)			\
+	EXC_REAL_BEGIN(name, start, end);			\
+	__OOL_EXCEPTION(start, label, tramp_real_##name);		\
+	EXC_REAL_END(name, start, end);
+
+#define __TRAMP_REAL_REAL_OOL(name, vec)				\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	STD_EXCEPTION_PSERIES_OOL(vec, name##_common);			\
+
+#define __EXC_REAL_OOL_MASKABLE(name, start, end)		\
+	__EXC_REAL_OOL(name, start, end);
+
+#define __TRAMP_REAL_REAL_OOL_MASKABLE(name, vec)			\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common);		\
+
+#define __EXC_REAL_OOL_HV_DIRECT(name, start, end, handler)	\
+	EXC_REAL_BEGIN(name, start, end);			\
+	__OOL_EXCEPTION(start, label, handler);				\
+	EXC_REAL_END(name, start, end);
+
+#define __EXC_REAL_OOL_HV(name, start, end)			\
+	__EXC_REAL_OOL(name, start, end);
+
+#define __TRAMP_REAL_REAL_OOL_HV(name, vec)				\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	STD_EXCEPTION_HV_OOL(vec, name##_common);			\
+
+#define __EXC_REAL_OOL_MASKABLE_HV(name, start, end)		\
+	__EXC_REAL_OOL(name, start, end);
+
+#define __TRAMP_REAL_REAL_OOL_MASKABLE_HV(name, vec)			\
+	TRAMP_REAL_BEGIN(tramp_real_##name);				\
+	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common);			\
+
+#define __EXC_VIRT_OOL(name, start, end)			\
+	EXC_VIRT_BEGIN(name, start, end);			\
+	__OOL_EXCEPTION(start, label, tramp_virt_##name);		\
+	EXC_VIRT_END(name, start, end);
+
+#define __TRAMP_REAL_VIRT_OOL(name, realvec)				\
+	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	STD_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
+
+#define __EXC_VIRT_OOL_MASKABLE(name, start, end)		\
+	__EXC_VIRT_OOL(name, start, end);
+
+#define __TRAMP_REAL_VIRT_OOL_MASKABLE(name, realvec)		\
+	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
+
+#define __EXC_VIRT_OOL_HV(name, start, end)			\
+	__EXC_VIRT_OOL(name, start, end);
+
+#define __TRAMP_REAL_VIRT_OOL_HV(name, realvec)			\
+	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common);		\
+
+#define __EXC_VIRT_OOL_MASKABLE_HV(name, start, end)		\
+	__EXC_VIRT_OOL(name, start, end);
+
+#define __TRAMP_REAL_VIRT_OOL_MASKABLE_HV(name, realvec)		\
+	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common);	\
+
+#define TRAMP_KVM(area, n)						\
+	TRAMP_KVM_BEGIN(do_kvm_##n);					\
+	KVM_HANDLER(area, EXC_STD, n);					\
+
+#define TRAMP_KVM_SKIP(area, n)						\
+	TRAMP_KVM_BEGIN(do_kvm_##n);					\
+	KVM_HANDLER_SKIP(area, EXC_STD, n);				\
+
+#define TRAMP_KVM_HV(area, n)						\
+	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
+	KVM_HANDLER(area, EXC_HV, n + 0x2);				\
+
+#define TRAMP_KVM_HV_SKIP(area, n)					\
+	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
+	KVM_HANDLER_SKIP(area, EXC_HV, n + 0x2);			\
+
+#define EXC_COMMON(name, realvec, hdlr)				\
+	EXC_COMMON_BEGIN(name);					\
+	STD_EXCEPTION_COMMON(realvec, name, hdlr);			\
+
+#define EXC_COMMON_ASYNC(name, realvec, hdlr)			\
+	EXC_COMMON_BEGIN(name);					\
+	STD_EXCEPTION_COMMON_ASYNC(realvec, name, hdlr);		\
+
+#define EXC_COMMON_HV(name, realvec, hdlr)				\
+	EXC_COMMON_BEGIN(name);					\
+	STD_EXCEPTION_COMMON(realvec + 0x2, name, hdlr);		\
+
+#endif	/* _ASM_POWERPC_HEAD_64_H */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 23018162d749..52d22891f6a4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -16,6 +16,7 @@
 #include <asm/exception-64s.h>
 #include <asm/ptrace.h>
 #include <asm/cpuidle.h>
+#include <asm/head-64.h>
 
 /*
  * We layout physical memory as follows:
@@ -89,8 +90,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	.globl __start_interrupts
 __start_interrupts:
 
-	.globl system_reset_pSeries;
-system_reset_pSeries:
+EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
 BEGIN_FTR_SECTION
@@ -131,9 +131,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #endif /* CONFIG_PPC_P7_NAP */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
+EXC_REAL_END(system_reset, 0x100, 0x200)
 
-	. = 0x200
-machine_check_pSeries_1:
+EXC_REAL_BEGIN(machine_check, 0x200, 0x300)
 	/* This is moved out of line as it can be patched by FW, but
 	 * some code path might still want to branch into the original
 	 * vector
@@ -153,20 +153,14 @@ BEGIN_FTR_SECTION
 FTR_SECTION_ELSE
 	b	machine_check_pSeries_0
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+EXC_REAL_END(machine_check, 0x200, 0x300)
 
-	. = 0x300
-	.globl data_access_pSeries
-data_access_pSeries:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD,
-				 KVMTEST, 0x300)
+EXC_REAL(data_access, 0x300, 0x380)
 
-	. = 0x380
-	.globl data_access_slb_pSeries
-data_access_slb_pSeries:
+EXC_REAL_BEGIN(data_access_slb, 0x380, 0x400)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 	mfspr	r12,SPRN_SRR1
@@ -184,15 +178,14 @@ data_access_slb_pSeries:
 	mtctr	r10
 	bctr
 #endif
+EXC_REAL_END(data_access_slb, 0x380, 0x400)
 
-	STD_EXCEPTION_PSERIES(0x400, instruction_access)
+EXC_REAL(instruction_access, 0x400, 0x480)
 
-	. = 0x480
-	.globl instruction_access_slb_pSeries
-instruction_access_slb_pSeries:
+EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x480)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r12,SPRN_SRR1
@@ -205,50 +198,52 @@ instruction_access_slb_pSeries:
 	mtctr	r10
 	bctr
 #endif
+EXC_REAL_END(instruction_access_slb, 0x480, 0x500)
 
 	/* We open code these as we can't have a ". = x" (even with
 	 * x = "." within a feature section
 	 */
-	. = 0x500;
-	.globl hardware_interrupt_pSeries;
+EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
 	.globl hardware_interrupt_hv;
-hardware_interrupt_pSeries:
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
+		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 					    EXC_HV, SOFTEN_TEST_HV)
+do_kvm_H0x500:
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
-		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
+		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 					    EXC_STD, SOFTEN_TEST_PR)
+do_kvm_0x500:
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+EXC_REAL_END(hardware_interrupt, 0x500, 0x600)
+
+EXC_REAL(alignment, 0x600, 0x700)
+
+TRAMP_KVM(PACA_EXGEN, 0x600)
+
+EXC_REAL(program_check, 0x700, 0x800)
 
-	STD_EXCEPTION_PSERIES(0x600, alignment)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x600)
+TRAMP_KVM(PACA_EXGEN, 0x700)
 
-	STD_EXCEPTION_PSERIES(0x700, program_check)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x700)
+EXC_REAL(fp_unavailable, 0x800, 0x900)
 
-	STD_EXCEPTION_PSERIES(0x800, fp_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x800)
+TRAMP_KVM(PACA_EXGEN, 0x800)
 
-	. = 0x900
-	.globl decrementer_pSeries
-decrementer_pSeries:
-	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD, SOFTEN_TEST_PR)
+EXC_REAL_MASKABLE(decrementer, 0x900, 0x980)
 
-	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
+EXC_REAL_HV(hdecrementer, 0x980, 0xa00)
 
-	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xa00)
+EXC_REAL_MASKABLE(doorbell_super, 0xa00, 0xb00)
 
-	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xb00)
+TRAMP_KVM(PACA_EXGEN, 0xa00)
 
-	. = 0xc00
-	.globl	system_call_pSeries
-system_call_pSeries:
+EXC_REAL(trap_0b, 0xb00, 0xc00)
+
+TRAMP_KVM(PACA_EXGEN, 0xb00)
+
+EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	 /*
 	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
 	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
@@ -265,7 +260,7 @@ system_call_pSeries:
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);
 	mfcr	r9
-	KVMTEST(0xc00)
+	KVMTEST_PR(0xc00)
 	GET_SCRATCH0(r13)
 #else
 	HMT_MEDIUM;
@@ -273,96 +268,59 @@ system_call_pSeries:
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_RFID
 	SYSCALL_PSERIES_3
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
+EXC_REAL_END(system_call, 0xc00, 0xd00)
+
+TRAMP_KVM(PACA_EXGEN, 0xc00)
+
+EXC_REAL(single_step, 0xd00, 0xe00)
+
+TRAMP_KVM(PACA_EXGEN, 0xd00)
 
-	STD_EXCEPTION_PSERIES(0xd00, single_step)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xd00)
 
 	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
 	 * out of line to handle them
 	 */
-	. = 0xe00
-hv_data_storage_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_data_storage_hv
+__EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
 
-	. = 0xe20
-hv_instr_storage_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_instr_storage_hv
+__EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
 
-	. = 0xe40
-emulation_assist_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	emulation_assist_hv
+__EXC_REAL_OOL_HV(emulation_assist, 0xe40, 0xe60)
 
-	. = 0xe60
-hv_exception_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	hmi_exception_early
+__EXC_REAL_OOL_HV_DIRECT(hmi_exception, 0xe60, 0xe80, hmi_exception_early)
 
-	. = 0xe80
-hv_doorbell_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_doorbell_hv
+__EXC_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80, 0xea0)
 
-	. = 0xea0
-hv_virt_irq_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_virt_irq_hv
+__EXC_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0, 0xec0)
 
-	/* We need to deal with the Altivec unavailable exception
-	 * here which is at 0xf20, thus in the middle of the
-	 * prolog code of the PerformanceMonitor one. A little
-	 * trickery is thus necessary
-	 */
-	. = 0xf00
-performance_monitor_pseries_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	performance_monitor_pSeries
+EXC_REAL_NONE(0xec0, 0xf00)
 
-	. = 0xf20
-altivec_unavailable_pseries_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	altivec_unavailable_pSeries
+__EXC_REAL_OOL(performance_monitor, 0xf00, 0xf20)
 
-	. = 0xf40
-vsx_unavailable_pseries_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	vsx_unavailable_pSeries
+__EXC_REAL_OOL(altivec_unavailable, 0xf20, 0xf40)
 
-	. = 0xf60
-facility_unavailable_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	facility_unavailable_pSeries
+__EXC_REAL_OOL(vsx_unavailable, 0xf40, 0xf60)
+
+__EXC_REAL_OOL(facility_unavailable, 0xf60, 0xf80)
+
+__EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
+
+EXC_REAL_NONE(0xfa0, 0x1200)
 
-	. = 0xf80
-hv_facility_unavailable_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	hv_facility_unavailable_hv
 
 #ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
-#endif /* CONFIG_CBE_RAS */
+EXC_REAL_HV(cbe_system_error, 0x1200, 0x1300)
+
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
+
+#else /* CONFIG_CBE_RAS */
+EXC_REAL_NONE(0x1200, 0x1300)
+#endif
 
-	STD_EXCEPTION_PSERIES(0x1300, instruction_breakpoint)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
+EXC_REAL(instruction_breakpoint, 0x1300, 0x1400)
 
-	. = 0x1500
-	.global denorm_exception_hv
-denorm_exception_hv:
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
+
+EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
@@ -375,31 +333,41 @@ denorm_exception_hv:
 	bne+	denorm_assist
 #endif
 
-	KVMTEST(0x1500)
+	KVMTEST_PR(0x1500)
 	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x1500)
+EXC_REAL_END(denorm_exception_hv, 0x1500, 0x1600)
+
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x1500)
 
 #ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_HV(0x1600, 0x1602, cbe_maintenance)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1602)
-#endif /* CONFIG_CBE_RAS */
+EXC_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
 
-	STD_EXCEPTION_PSERIES(0x1700, altivec_assist)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x1700)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
+
+#else /* CONFIG_CBE_RAS */
+EXC_REAL_NONE(0x1600, 0x1700)
+#endif
+
+EXC_REAL(altivec_assist, 0x1700, 0x1800)
+
+TRAMP_KVM(PACA_EXGEN, 0x1700)
 
 #ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_HV(0x1800, 0x1802, cbe_thermal)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1802)
-#else
+EXC_REAL_HV(cbe_thermal, 0x1800, 0x1900)
+
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
+
+#else /* CONFIG_CBE_RAS */
+EXC_REAL_NONE(0x1800, 0x1900)
 	. = 0x1800
-#endif /* CONFIG_CBE_RAS */
+#endif
 
 
 /*** Out of line interrupts support ***/
 
-	.align	7
 	/* moved from 0x200 */
-machine_check_powernv_early:
+	.align 7;
+TRAMP_REAL_BEGIN(machine_check_powernv_early)
 BEGIN_FTR_SECTION
 	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
 	/*
@@ -471,13 +439,13 @@ BEGIN_FTR_SECTION
 	b	.	/* prevent speculative execution */
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 
-machine_check_pSeries:
+TRAMP_REAL_BEGIN(machine_check_pSeries)
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST, 0x200)
+	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
 	/*
 	 * The following is essentially EXCEPTION_PROLOG_PSERIES_1 with the
 	 * difference that MSR_RI is not enabled, because PACA_EXMC is being
@@ -494,16 +462,17 @@ machine_check_pSeries_0:
 	rfid
 	b	.	/* prevent speculative execution */
 
-	KVM_HANDLER_SKIP(PACA_EXMC, EXC_STD, 0x200)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
-	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x400)
-	KVM_HANDLER(PACA_EXSLB, EXC_STD, 0x480)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x900)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x982)
+
+TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
+TRAMP_KVM_SKIP(PACA_EXGEN, 0x300)
+TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
+TRAMP_KVM(PACA_EXGEN, 0x400)
+TRAMP_KVM(PACA_EXSLB, 0x480)
+TRAMP_KVM(PACA_EXGEN, 0x900)
+TRAMP_KVM_HV(PACA_EXGEN, 0x980)
 
 #ifdef CONFIG_PPC_DENORMALISATION
-denorm_assist:
+TRAMP_REAL_BEGIN(denorm_assist)
 BEGIN_FTR_SECTION
 /*
  * To denormalise we need to move a copy of the register to itself.
@@ -568,32 +537,39 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 
 	.align	7
 	/* moved from 0xe00 */
-	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)
-	STD_EXCEPTION_HV_OOL(0xe22, h_instr_storage)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe22)
-	STD_EXCEPTION_HV_OOL(0xe42, emulation_assist)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe42)
-	MASKABLE_EXCEPTION_HV_OOL(0xe62, hmi_exception)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe62)
+__TRAMP_REAL_REAL_OOL_HV(h_data_storage, 0xe00)
+TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
+
+__TRAMP_REAL_REAL_OOL_HV(h_instr_storage, 0xe20)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
+
+__TRAMP_REAL_REAL_OOL_HV(emulation_assist, 0xe40)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe40)
 
-	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
+__TRAMP_REAL_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 
-	MASKABLE_EXCEPTION_HV_OOL(0xea2, h_virt_irq)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xea2)
+__TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xe80)
+
+__TRAMP_REAL_REAL_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
+TRAMP_KVM_HV(PACA_EXGEN, 0xea0)
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
-	STD_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf20)
-	STD_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf40)
-	STD_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf60)
-	STD_EXCEPTION_HV_OOL(0xf82, hv_facility_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf82)
+__TRAMP_REAL_REAL_OOL(performance_monitor, 0xf00)
+TRAMP_KVM(PACA_EXGEN, 0xf00)
+
+__TRAMP_REAL_REAL_OOL(altivec_unavailable, 0xf20)
+TRAMP_KVM(PACA_EXGEN, 0xf20)
+
+__TRAMP_REAL_REAL_OOL(vsx_unavailable, 0xf40)
+TRAMP_KVM(PACA_EXGEN, 0xf40)
+
+__TRAMP_REAL_REAL_OOL(facility_unavailable, 0xf60)
+TRAMP_KVM(PACA_EXGEN, 0xf60)
+
+__TRAMP_REAL_REAL_OOL_HV(h_facility_unavailable, 0xf80)
+TRAMP_KVM_HV(PACA_EXGEN, 0xf80)
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
@@ -676,9 +652,8 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 /*
  * Vectors for the FWNMI option.  Share common code.
  */
-	.globl system_reset_fwnmi
       .align 7
-system_reset_fwnmi:
+TRAMP_REAL_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
@@ -686,7 +661,7 @@ system_reset_fwnmi:
 #endif /* CONFIG_PPC_PSERIES */
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-kvmppc_skip_interrupt:
+TRAMP_REAL_BEGIN(kvmppc_skip_interrupt)
 	/*
 	 * Here all GPRs are unchanged from when the interrupt happened
 	 * except for r13, which is saved in SPRG_SCRATCH0.
@@ -698,7 +673,7 @@ kvmppc_skip_interrupt:
 	rfid
 	b	.
 
-kvmppc_skip_Hinterrupt:
+TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 	/*
 	 * Here all GPRs are unchanged from when the interrupt happened
 	 * except for r13, which is saved in SPRG_SCRATCH0.
@@ -720,34 +695,50 @@ kvmppc_skip_Hinterrupt:
 
 /*** Common interrupt handlers ***/
 
-	STD_EXCEPTION_COMMON(0x100, system_reset, system_reset_exception)
+	.align 7;
+EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
+	.align 7;
+EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
+	.align 7;
+EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
+	.align 7;
+EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
-	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
-	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, timer_interrupt)
-	STD_EXCEPTION_COMMON(0x980, hdecrementer, hdec_interrupt)
+	.align 7;
 #ifdef CONFIG_PPC_DOORBELL
-	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, doorbell_exception)
+EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
 #else
-	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, unknown_exception)
+EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 #endif
-	STD_EXCEPTION_COMMON(0xb00, trap_0b, unknown_exception)
-	STD_EXCEPTION_COMMON(0xd00, single_step, single_step_exception)
-	STD_EXCEPTION_COMMON(0xe00, trap_0e, unknown_exception)
-	STD_EXCEPTION_COMMON(0xe40, emulation_assist, emulation_assist_interrupt)
-	STD_EXCEPTION_COMMON_ASYNC(0xe60, hmi_exception, handle_hmi_exception)
+	.align 7;
+EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
+	.align 7;
+EXC_COMMON(single_step_common, 0xd00, single_step_exception)
+	.align 7;
+EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
+	.align 7;
+EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
+	.align 7;
+EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
+	.align 7;
 #ifdef CONFIG_PPC_DOORBELL
-	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, doorbell_exception)
+EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
 #else
-	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, unknown_exception)
+EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
-	STD_EXCEPTION_COMMON_ASYNC(0xea0, h_virt_irq, do_IRQ)
-	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, performance_monitor_exception)
-	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, instruction_breakpoint_exception)
-	STD_EXCEPTION_COMMON(0x1502, denorm, unknown_exception)
+	.align 7;
+EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
+	.align 7;
+EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
+	.align 7;
+EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
+	.align 7;
+EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
+	.align 7;
 #ifdef CONFIG_ALTIVEC
-	STD_EXCEPTION_COMMON(0x1700, altivec_assist, altivec_assist_exception)
+EXC_COMMON(altivec_assist_common, 0x1700, altivec_assist_exception)
 #else
-	STD_EXCEPTION_COMMON(0x1700, altivec_assist, unknown_exception)
+EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 #endif
 
 	/*
@@ -765,10 +756,12 @@ kvmppc_skip_Hinterrupt:
 	 * only has extra guff for STAB-based processors -- which never
 	 * come here.
 	 */
-	STD_RELON_EXCEPTION_PSERIES(0x4300, 0x300, data_access)
-	. = 0x4380
-	.globl data_access_slb_relon_pSeries
-data_access_slb_relon_pSeries:
+EXC_VIRT_NONE(0x4100, 0x4200)
+EXC_VIRT_NONE(0x4200, 0x4300)
+
+EXC_VIRT(data_access, 0x4300, 0x4380, 0x300)
+
+EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x4400)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
@@ -789,11 +782,11 @@ data_access_slb_relon_pSeries:
 	mtctr	r10
 	bctr
 #endif
+EXC_VIRT_END(data_access_slb, 0x4380, 0x4400)
 
-	STD_RELON_EXCEPTION_PSERIES(0x4400, 0x400, instruction_access)
-	. = 0x4480
-	.globl instruction_access_slb_relon_pSeries
-instruction_access_slb_relon_pSeries:
+EXC_VIRT(instruction_access, 0x4400, 0x4480, 0x400)
+
+EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x4500)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
@@ -809,100 +802,86 @@ instruction_access_slb_relon_pSeries:
 	mtctr	r10
 	bctr
 #endif
+EXC_VIRT_END(instruction_access_slb, 0x4480, 0x4500)
 
-	. = 0x4500
-	.globl hardware_interrupt_relon_pSeries;
+EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
 	.globl hardware_interrupt_relon_hv;
-hardware_interrupt_relon_pSeries:
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV, SOFTEN_TEST_HV)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
 	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD, SOFTEN_TEST_PR)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-	STD_RELON_EXCEPTION_PSERIES(0x4600, 0x600, alignment)
-	STD_RELON_EXCEPTION_PSERIES(0x4700, 0x700, program_check)
-	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer)
-	STD_RELON_EXCEPTION_HV(0x4980, 0x982, hdecrementer)
-	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super)
-	STD_RELON_EXCEPTION_PSERIES(0x4b00, 0xb00, trap_0b)
-
-	. = 0x4c00
-	.globl system_call_relon_pSeries
-system_call_relon_pSeries:
+EXC_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
+
+EXC_VIRT(alignment, 0x4600, 0x4700, 0x600)
+EXC_VIRT(program_check, 0x4700, 0x4800, 0x700)
+EXC_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
+EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
+EXC_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
+EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
+EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
+
+EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
 	HMT_MEDIUM
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_DIRECT
 	SYSCALL_PSERIES_3
+EXC_VIRT_END(system_call, 0x4c00, 0x4d00)
 
-	STD_RELON_EXCEPTION_PSERIES(0x4d00, 0xd00, single_step)
+EXC_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 
-	. = 0x4e00
-	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_END(unused, 0x4e00, 0x4e20)
 
-	. = 0x4e20
-	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_BEGIN(unused, 0x4e20, 0x4e40)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_END(unused, 0x4e20, 0x4e40)
 
-	. = 0x4e40
-emulation_assist_relon_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	emulation_assist_relon_hv
+__EXC_VIRT_OOL_HV(emulation_assist, 0x4e40, 0x4e60)
 
-	. = 0x4e60
-	b	.	/* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_BEGIN(unused, 0x4e60, 0x4e80)
+	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
+EXC_VIRT_END(unused, 0x4e60, 0x4e80)
 
-	. = 0x4e80
-h_doorbell_relon_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_doorbell_relon_hv
+__EXC_VIRT_OOL_MASKABLE_HV(h_doorbell, 0x4e80, 0x4ea0)
 
-	. = 0x4ea0
-h_virt_irq_relon_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	h_virt_irq_relon_hv
+__EXC_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0x4ea0, 0x4ec0)
 
-	. = 0x4f00
-performance_monitor_relon_pseries_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	performance_monitor_relon_pSeries
+EXC_VIRT_NONE(0x4ec0, 0x4f00)
 
-	. = 0x4f20
-altivec_unavailable_relon_pseries_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	altivec_unavailable_relon_pSeries
+__EXC_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
 
-	. = 0x4f40
-vsx_unavailable_relon_pseries_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	vsx_unavailable_relon_pSeries
+__EXC_VIRT_OOL(altivec_unavailable, 0x4f20, 0x4f40)
 
-	. = 0x4f60
-facility_unavailable_relon_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	facility_unavailable_relon_pSeries
+__EXC_VIRT_OOL(vsx_unavailable, 0x4f40, 0x4f60)
 
-	. = 0x4f80
-hv_facility_unavailable_relon_trampoline:
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	hv_facility_unavailable_relon_hv
+__EXC_VIRT_OOL(facility_unavailable, 0x4f60, 0x4f80)
+
+__EXC_VIRT_OOL_HV(h_facility_unavailable, 0x4f80, 0x4fa0)
+
+EXC_VIRT_NONE(0x4fa0, 0x5200)
+
+EXC_VIRT_NONE(0x5200, 0x5300)
+
+EXC_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
 
-	STD_RELON_EXCEPTION_PSERIES(0x5300, 0x1300, instruction_breakpoint)
 #ifdef CONFIG_PPC_DENORMALISATION
-	. = 0x5500
-	b	denorm_exception_hv
+EXC_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
+	b	exc_real_0x1500_denorm_exception_hv
+EXC_VIRT_END(denorm_exception, 0x5500, 0x5600)
+#else
+EXC_VIRT_NONE(0x5500, 0x5600)
 #endif
-	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
 
-ppc64_runlatch_on_trampoline:
+EXC_VIRT_NONE(0x5600, 0x5700)
+
+EXC_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
+
+EXC_VIRT_NONE(0x5800, 0x5900)
+
+TRAMP_REAL_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
 /*
@@ -911,8 +890,7 @@ ppc64_runlatch_on_trampoline:
  * r9 - r13 are saved in paca->exgen.
  */
 	.align	7
-	.globl data_access_common
-data_access_common:
+EXC_COMMON_BEGIN(data_access_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
 	mfspr	r10,SPRN_DSISR
@@ -932,8 +910,7 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	.align  7
-	.globl  h_data_storage_common
-h_data_storage_common:
+EXC_COMMON_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
 	std     r10,PACA_EXGEN+EX_DAR(r13)
 	mfspr   r10,SPRN_HDSISR
@@ -946,8 +923,7 @@ h_data_storage_common:
 	b       ret_from_except
 
 	.align	7
-	.globl instruction_access_common
-instruction_access_common:
+EXC_COMMON_BEGIN(instruction_access_common)
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
@@ -962,16 +938,15 @@ MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
-	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, unknown_exception)
+	.align 7
+EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
 	/*
 	 * Machine check is different because we use a different
 	 * save area: PACA_EXMC instead of PACA_EXGEN.
 	 */
 	.align	7
-	.globl machine_check_common
-machine_check_common:
-
+EXC_COMMON_BEGIN(machine_check_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXMC+EX_DAR(r13)
 	mfspr	r10,SPRN_DSISR
@@ -992,8 +967,7 @@ machine_check_common:
 	b	ret_from_except
 
 	.align	7
-	.globl alignment_common
-alignment_common:
+EXC_COMMON_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
 	mfspr	r10,SPRN_DSISR
@@ -1010,8 +984,7 @@ alignment_common:
 	b	ret_from_except
 
 	.align	7
-	.globl program_check_common
-program_check_common:
+EXC_COMMON_BEGIN(program_check_common)
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
@@ -1020,8 +993,7 @@ program_check_common:
 	b	ret_from_except
 
 	.align	7
-	.globl fp_unavailable_common
-fp_unavailable_common:
+EXC_COMMON_BEGIN(fp_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
 	bl	save_nvgprs
@@ -1049,9 +1021,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	bl	fp_unavailable_tm
 	b	ret_from_except
 #endif
+
 	.align	7
-	.globl altivec_unavailable_common
-altivec_unavailable_common:
+EXC_COMMON_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
@@ -1085,8 +1057,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	b	ret_from_except
 
 	.align	7
-	.globl vsx_unavailable_common
-vsx_unavailable_common:
+EXC_COMMON_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
@@ -1119,15 +1090,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xea0, h_virt_irq)
-
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
+__TRAMP_REAL_VIRT_OOL_HV(emulation_assist, 0xe40)
+__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_doorbell, 0xe80)
+__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(h_virt_irq, 0xea0)
+__TRAMP_REAL_VIRT_OOL(performance_monitor, 0xf00)
+__TRAMP_REAL_VIRT_OOL(altivec_unavailable, 0xf20)
+__TRAMP_REAL_VIRT_OOL(vsx_unavailable, 0xf40)
+__TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
+__TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
@@ -1155,18 +1125,24 @@ fwnmi_data_area:
 	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
-	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
-	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
+	.align 7;
+EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
+	.align 7;
+EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
 #ifdef CONFIG_CBE_RAS
-	STD_EXCEPTION_COMMON(0x1200, cbe_system_error, cbe_system_error_exception)
-	STD_EXCEPTION_COMMON(0x1600, cbe_maintenance, cbe_maintenance_exception)
-	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, cbe_thermal_exception)
+	.align 7;
+EXC_COMMON(cbe_system_error_common, 0x1200, cbe_system_error_exception)
+	.align 7;
+EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
+	.align 7;
+EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
-	.globl hmi_exception_early
-hmi_exception_early:
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, 0xe62)
+
+	.align 7;
+EXC_COMMON_BEGIN(hmi_exception_early)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
 	mr	r10,r1			/* Save r1			*/
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
@@ -1212,7 +1188,7 @@ hmi_exception_early:
 hmi_exception_after_realmode:
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	b	hmi_exception_hv
+	b	tramp_real_hmi_exception
 
 
 #define MACHINE_CHECK_HANDLER_WINDUP			\
@@ -1251,8 +1227,7 @@ hmi_exception_after_realmode:
 	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
 	 */
 	.align	7
-	.globl machine_check_handle_early
-machine_check_handle_early:
+EXC_COMMON_BEGIN(machine_check_handle_early)
 	std	r0,GPR0(r1)	/* Save r0 */
 	EXCEPTION_PROLOG_COMMON_3(0x200)
 	bl	save_nvgprs
@@ -1378,7 +1353,7 @@ machine_check_handle_early:
 	MACHINE_CHECK_HANDLER_WINDUP
 	b	machine_check_pSeries
 
-unrecover_mce:
+EXC_COMMON_BEGIN(unrecover_mce)
 	/* Invoke machine_check_exception to print MCE event and panic. */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	machine_check_exception
@@ -1389,6 +1364,7 @@ unrecover_mce:
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	unrecoverable_exception
 	b	1b
+
 /*
  * r13 points to the PACA, r9 contains the saved CR,
  * r12 contain the saved SRR1, SRR0 is still ready for return
@@ -1398,7 +1374,7 @@ unrecover_mce:
  * cr6.eq is set for a D-SLB miss, clear for a I-SLB miss
  * We assume we aren't going to take any exceptions during this procedure.
  */
-slb_miss_realmode:
+EXC_COMMON_BEGIN(slb_miss_realmode)
 	mflr	r10
 #ifdef CONFIG_RELOCATABLE
 	mtctr	r11
@@ -1451,14 +1427,6 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	rfid
 	b	.
 
-unrecov_slb:
-	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
-	RECONCILE_IRQ_STATE(r10, r11)
-	bl	save_nvgprs
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	unrecoverable_exception
-	b	1b
-
 8:	mfspr	r11,SPRN_SRR0
 	LOAD_HANDLER(r10,bad_addr_slb)
 	mtspr	SPRN_SRR0,r10
@@ -1467,7 +1435,16 @@ unrecov_slb:
 	rfid
 	b	.
 
-bad_addr_slb:
+EXC_COMMON_BEGIN(unrecov_slb)
+	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
+	RECONCILE_IRQ_STATE(r10, r11)
+	bl	save_nvgprs
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	unrecoverable_exception
+	b	1b
+
+
+EXC_COMMON_BEGIN(bad_addr_slb)
 	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r3, PACA_EXSLB+EX_DAR(r13)
@@ -1481,7 +1458,7 @@ bad_addr_slb:
 	b	ret_from_except
 
 #ifdef CONFIG_PPC_970_NAP
-power4_fixup_nap:
+TRAMP_REAL_BEGIN(power4_fixup_nap)
 	andc	r9,r9,r10
 	std	r9,TI_LOCAL_FLAGS(r11)
 	ld	r10,_LINK(r1)		/* make idle task do the */
-- 
2.7.4
