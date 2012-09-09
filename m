Return-Path: <haren@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1703A2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 21:44:34 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sun, 9 Sep 2012 07:44:31 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7634A38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Sep 2012 07:44:29 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q89BiTJo161418
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 07:44:29 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q89BiSk1029121
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Sep 2012 08:44:29 -0300
Subject: [PATCH 6/6] powerpc: Implement PPR save/restore
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Sep 2012 04:44:27 -0700
Message-ID: <1347191067.3418.21.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When the task enters in to kernel space, the user defined priority (PPR)
will be saved in to PACA at the beginning of first level exception
vector and then copy from PACA to thread_info in second level vector.
PPR will be restored from thread_info before exits the kernel space.

P7 temporarily raises the thread priority to higher level during
exception until the program executes HMT_* calls. But it will not modify
PPR register. So we save PPR value whenever some register is available
to use and then calls HMT_MEDIUM to increase the priority. This feature
supports on P7 or later processors.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |   12 +++++++-----
 arch/powerpc/kernel/entry_64.S           |    4 ++++
 arch/powerpc/kernel/exceptions-64s.S     |   18 ++++++++++--------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 618fd18..fd99094 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -99,8 +99,9 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) /* P7 */
 
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	GET_PACA(r13);							\
-	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
-	std	r10,area+EX_R10(r13);					\
+	std	r9,area+EX_R9(r13);	/* save r9 */			\
+	HMT_MEDIUM_HAS_PPR(area, r9);					\
+	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
 	BEGIN_FTR_SECTION_NESTED(66);					\
 	mfspr	r10,SPRN_CFAR;						\
 	std	r10,area+EX_CFAR(r13);					\
@@ -214,6 +215,7 @@ do_kvm_##n:								\
 	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
+	SAVE_PPR(area, r9, r10);					   \
 4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
 	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
@@ -255,7 +257,7 @@ do_kvm_##n:								\
 	. = loc;					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_NO_PPR;				\
 	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_STD, KVMTEST_PR, vec)
@@ -264,7 +266,7 @@ label##_pSeries:					\
 	. = loc;					\
 	.globl label##_hv;				\
 label##_hv:						\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_NO_PPR;				\
 	SET_SCRATCH0(r13);	/* save r13 */			\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
@@ -295,7 +297,7 @@ label##_hv:						\
 	_SOFTEN_TEST(EXC_STD, vec)
 
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	HMT_MEDIUM;							\
+	HMT_MEDIUM_NO_PPR;						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 8d21cc4..034dbb7 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -33,6 +33,7 @@
 #include <asm/irqflags.h>
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
+#include <asm/exception-64s.h>
 
 /*
  * System calls.
@@ -64,6 +65,7 @@ system_call_common:
 	std	r10,GPR1(r1)
 	beq	2f			/* if from kernel mode */
 	ACCOUNT_CPU_USER_ENTRY(r10, r11)
+	SAVE_PPR(PACA_EXGEN, r10, r11)
 2:	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
 	mfcr	r2
@@ -227,6 +229,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
+	RESTORE_PPR(r11, r12)
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
@@ -711,6 +714,7 @@ fast_exception_return:
 	andi.	r0,r3,MSR_PR
 	beq	1f
 	ACCOUNT_CPU_USER_EXIT(r2, r4)
+	RESTORE_PPR(r2, r4)
 	REST_GPR(13, r1)
 1:
 	mtspr	SPRN_SRR1,r3
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 39aa97d..69af469 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -40,7 +40,7 @@ __start_interrupts:
 
 	.globl system_reset_pSeries;
 system_reset_pSeries:
-	HMT_MEDIUM;
+	HMT_MEDIUM_NO_PPR;
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
 BEGIN_FTR_SECTION
@@ -94,7 +94,7 @@ machine_check_pSeries_1:
 	. = 0x300
 	.globl data_access_pSeries
 data_access_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)
 BEGIN_FTR_SECTION
 	b	data_access_check_stab
@@ -106,7 +106,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	. = 0x380
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -137,7 +137,7 @@ data_access_slb_pSeries:
 	. = 0x480
 	.globl instruction_access_slb_pSeries
 instruction_access_slb_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -197,7 +197,7 @@ hardware_interrupt_hv:
 	. = 0xc00
 	.globl	system_call_pSeries
 system_call_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
@@ -213,6 +213,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	mr	r9,r13
 	GET_PACA(r13)
+	HMT_MEDIUM_HAS_PPR(PACA_EXGEN,r10)
 	mfspr	r11,SPRN_SRR0
 	mfspr	r12,SPRN_SRR1
 	ld	r10,PACAKBASE(r13)
@@ -296,7 +297,7 @@ vsx_unavailable_pSeries_1:
 machine_check_pSeries:
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common,
 				 EXC_STD, KVMTEST, 0x200)
@@ -418,7 +419,7 @@ _GLOBAL(__replay_interrupt)
 	.globl system_reset_fwnmi
       .align 7
 system_reset_fwnmi:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
@@ -720,6 +721,7 @@ _GLOBAL(slb_miss_realmode)
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
@@ -1050,7 +1052,7 @@ initial_stab:
 
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	clrldi	r3,r3,2
-- 
1.7.10.4
