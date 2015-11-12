Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6E841A03F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 16:44:43 +1100 (AEDT)
Date: Thu, 12 Nov 2015 16:44:42 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Neuling <mikey@neuling.org>, kvm-ppc@vger.kernel.org
Subject: [PATCH] powerpc/64: Include KVM guest test in all interrupt vectors
Message-ID: <20151112054442.GD22330@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, if HV KVM is configured but PR KVM isn't, we don't include
a test to see whether we were interrupted in KVM guest context for the
set of interrupts which get delivered directly to the guest by hardware
if they occur in the guest.  This includes things like program
interrupts.

However, the recent bug where userspace could set the MSR for a VCPU
to have an illegal value in the TS field, and thus cause a TM Bad Thing
type of program interrupt on the hrfid that enters the guest, showed that
we can never be completely sure that these interrupts can never occur
in the guest entry/exit code.  If one of these interrupts does happen
and we have HV KVM configured but not PR KVM, then we end up trying to
run the handler in the host with the MMU set to the guest MMU context,
which generally ends badly.

Thus, for robustness it is better to have the test in every interrupt
vector, so that if some way is found to trigger some interrupt in the
guest entry/exit path, we can handle it without immediately crashing
the host.

This means that the distinction between KVMTEST and KVMTEST_PR goes
away.  Thus we delete KVMTEST_PR and associated macros and use KVMTEST
everywhere that we previously used either KVMTEST_PR or KVMTEST.  It
also means that SOFTEN_TEST_HV_201 becomes the same as SOFTEN_TEST_PR,
so we deleted SOFTEN_TEST_HV_201 and use SOFTEN_TEST_PR instead.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h | 21 +++-----------------
 arch/powerpc/kernel/exceptions-64s.S     | 34 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 77f52b2..9ee1078 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -263,17 +263,6 @@ do_kvm_##n:								\
 #define KVM_HANDLER_SKIP(area, h, n)
 #endif
 
-#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-#define KVMTEST_PR(n)			__KVMTEST(n)
-#define KVM_HANDLER_PR(area, h, n)	__KVM_HANDLER(area, h, n)
-#define KVM_HANDLER_PR_SKIP(area, h, n)	__KVM_HANDLER_SKIP(area, h, n)
-
-#else
-#define KVMTEST_PR(n)
-#define KVM_HANDLER_PR(area, h, n)
-#define KVM_HANDLER_PR_SKIP(area, h, n)
-#endif
-
 #define NOTEST(n)
 
 /*
@@ -360,13 +349,13 @@ label##_pSeries:					\
 	HMT_MEDIUM_PPR_DISCARD;				\
 	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
-				 EXC_STD, KVMTEST_PR, vec)
+				 EXC_STD, KVMTEST, vec)
 
 /* Version of above for when we have to branch out-of-line */
 #define STD_EXCEPTION_PSERIES_OOL(vec, label)			\
 	.globl label##_pSeries;					\
 label##_pSeries:						\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, vec);	\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD)
 
 #define STD_EXCEPTION_HV(loc, vec, label)		\
@@ -436,17 +425,13 @@ label##_relon_hv:						\
 #define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
 
 #define SOFTEN_TEST_PR(vec)						\
-	KVMTEST_PR(vec);						\
+	KVMTEST(vec);							\
 	_SOFTEN_TEST(EXC_STD, vec)
 
 #define SOFTEN_TEST_HV(vec)						\
 	KVMTEST(vec);							\
 	_SOFTEN_TEST(EXC_HV, vec)
 
-#define SOFTEN_TEST_HV_201(vec)						\
-	KVMTEST(vec);							\
-	_SOFTEN_TEST(EXC_STD, vec)
-
 #define SOFTEN_NOTEST_PR(vec)		_SOFTEN_TEST(EXC_STD, vec)
 #define SOFTEN_NOTEST_HV(vec)		_SOFTEN_TEST(EXC_HV, vec)
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0a0399c2..1a03142 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -242,7 +242,7 @@ instruction_access_slb_pSeries:
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 #ifdef __DISABLED__
@@ -276,18 +276,18 @@ hardware_interrupt_hv:
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
-					    EXC_STD, SOFTEN_TEST_HV_201)
+					    EXC_STD, SOFTEN_TEST_PR)
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
 	STD_EXCEPTION_PSERIES(0x600, 0x600, alignment)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x600)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x600)
 
 	STD_EXCEPTION_PSERIES(0x700, 0x700, program_check)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x700)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x700)
 
 	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x800)
 
 	. = 0x900
 	.globl decrementer_pSeries
@@ -297,10 +297,10 @@ decrementer_pSeries:
 	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
 	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xa00)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xa00)
 
 	STD_EXCEPTION_PSERIES(0xb00, 0xb00, trap_0b)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xb00)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xb00)
 
 	. = 0xc00
 	.globl	system_call_pSeries
@@ -332,7 +332,7 @@ system_call_pSeries:
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
 
 	STD_EXCEPTION_PSERIES(0xd00, 0xd00, single_step)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xd00)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xd00)
 
 	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
 	 * out of line to handle them
@@ -408,7 +408,7 @@ hv_facility_unavailable_trampoline:
 #endif /* CONFIG_CBE_RAS */
 
 	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
-	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
 
 	. = 0x1500
 	.global denorm_exception_hv
@@ -436,7 +436,7 @@ denorm_exception_hv:
 #endif /* CONFIG_CBE_RAS */
 
 	STD_EXCEPTION_PSERIES(0x1700, 0x1700, altivec_assist)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x1700)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x1700)
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1800, 0x1802, cbe_thermal)
@@ -536,9 +536,9 @@ machine_check_pSeries_0:
 	KVM_HANDLER_SKIP(PACA_EXMC, EXC_STD, 0x200)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
 	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x400)
-	KVM_HANDLER_PR(PACA_EXSLB, EXC_STD, 0x480)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x900)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x400)
+	KVM_HANDLER(PACA_EXSLB, EXC_STD, 0x480)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x900)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x982)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -621,13 +621,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf00)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
 	STD_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf20)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf20)
 	STD_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf40)
 	STD_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf60)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf60)
 	STD_EXCEPTION_HV_OOL(0xf82, facility_unavailable)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf82)
 
-- 
2.1.4
