Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24FC61A032F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 14:25:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] powerpc/kernel: Drop HMT_MEDIUM_PPR_DISCARD
Date: Wed, 25 Nov 2015 14:25:16 +1100
Message-Id: <1448421919-30426-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HMT_MEDIUM_PPR_DISCARD is a macro which is present at the start of most
of our first level exception handlers. It conditionally executes a
HMT_MEDIUM instruction, which sets the processor priority to medium.

On on modern systems, ie. Power7 and later, it is nop'ed out at boot.
All it does is make the exception vectors more cramped, and consume 4
bytes of icache.

On old systems it has the effect of boosting the processor priority at
the start of exception processing. If we were previously in the idle
loop for example, we may be at low or very low priority. This is
desirable as we want to process the exception as fast as possible.

However looking closely at the generated code, we see that in all cases
we execute another HMT_MEDIUM just four instructions later. With code
patching applied, the final code on an old (Power6) system will look
like, eg:

  c000000000000300 <data_access_pSeries>:
  c000000000000300:	7c 42 13 78	mr	r2,r2		<-
  c000000000000304:	7d b2 43 a6	mtsprg	2,r13
  c000000000000308:	7d b1 42 a6	mfsprg	r13,1
  c00000000000030c:	f9 2d 00 80	std	r9,128(r13)
  c000000000000310:	60 00 00 00	nop
  c000000000000314:	7c 42 13 78	mr	r2,r2		<-

So I suggest that the added code complexity of HMT_MEDIUM_PPR_DISCARD is
not justified by the benefit of boosting the processor priority for the
duration of four instructions, and therefore we drop it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 15 ---------------
 arch/powerpc/kernel/exceptions-64s.S     |  9 ---------
 2 files changed, 24 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 77f52b26dad6..9b91879b7876 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -130,15 +130,6 @@ BEGIN_FTR_SECTION_NESTED(941)						\
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,941)
 
 /*
- * Increase the priority on systems where PPR save/restore is not
- * implemented/ supported.
- */
-#define HMT_MEDIUM_PPR_DISCARD						\
-BEGIN_FTR_SECTION_NESTED(942)						\
-	HMT_MEDIUM;							\
-END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,942)  /*non P7*/		
-
-/*
  * Get an SPR into a register if the CPU has the given feature
  */
 #define OPT_GET_SPR(ra, spr, ftr)					\
@@ -357,7 +348,6 @@ do_kvm_##n:								\
 	. = loc;					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
-	HMT_MEDIUM_PPR_DISCARD;				\
 	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_STD, KVMTEST_PR, vec)
@@ -373,7 +363,6 @@ label##_pSeries:						\
 	. = loc;					\
 	.globl label##_hv;				\
 label##_hv:						\
-	HMT_MEDIUM_PPR_DISCARD;				\
 	SET_SCRATCH0(r13);	/* save r13 */			\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
@@ -389,7 +378,6 @@ label##_hv:						\
 	. = loc;					\
 	.globl label##_relon_pSeries;			\
 label##_relon_pSeries:					\
-	HMT_MEDIUM_PPR_DISCARD;				\
 	/* No guest interrupts come through here */	\
 	SET_SCRATCH0(r13);		/* save r13 */	\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
@@ -405,7 +393,6 @@ label##_relon_pSeries:						\
 	. = loc;					\
 	.globl label##_relon_hv;			\
 label##_relon_hv:					\
-	HMT_MEDIUM_PPR_DISCARD;				\
 	/* No guest interrupts come through here */	\
 	SET_SCRATCH0(r13);	/* save r13 */		\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
@@ -463,7 +450,6 @@ label##_relon_hv:						\
 	. = loc;							\
 	.globl label##_pSeries;						\
 label##_pSeries:							\
-	HMT_MEDIUM_PPR_DISCARD;						\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_STD, SOFTEN_TEST_PR)
 
@@ -481,7 +467,6 @@ label##_hv:								\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
-	HMT_MEDIUM_PPR_DISCARD;						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0a0399c2af11..9035bda220f5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -96,7 +96,6 @@ __start_interrupts:
 
 	.globl system_reset_pSeries;
 system_reset_pSeries:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
 BEGIN_FTR_SECTION
@@ -164,7 +163,6 @@ machine_check_pSeries_1:
 	 * some code path might still want to branch into the original
 	 * vector
 	 */
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
 #ifdef CONFIG_PPC_P7_NAP
 BEGIN_FTR_SECTION
@@ -199,7 +197,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	. = 0x300
 	.globl data_access_pSeries
 data_access_pSeries:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD,
 				 KVMTEST, 0x300)
@@ -207,7 +204,6 @@ data_access_pSeries:
 	. = 0x380
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
@@ -239,7 +235,6 @@ data_access_slb_pSeries:
 	. = 0x480
 	.globl instruction_access_slb_pSeries
 instruction_access_slb_pSeries:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
@@ -269,7 +264,6 @@ instruction_access_slb_pSeries:
 	.globl hardware_interrupt_hv;
 hardware_interrupt_pSeries:
 hardware_interrupt_hv:
-	HMT_MEDIUM_PPR_DISCARD
 	BEGIN_FTR_SECTION
 		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
 					    EXC_HV, SOFTEN_TEST_HV)
@@ -413,7 +407,6 @@ hv_facility_unavailable_trampoline:
 	. = 0x1500
 	.global denorm_exception_hv
 denorm_exception_hv:
-	HMT_MEDIUM_PPR_DISCARD
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
@@ -527,7 +520,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 machine_check_pSeries:
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 machine_check_pSeries_0:
@@ -711,7 +703,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 	.globl system_reset_fwnmi
       .align 7
 system_reset_fwnmi:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
-- 
2.5.0
