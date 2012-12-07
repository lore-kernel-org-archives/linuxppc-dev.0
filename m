Return-Path: <haren@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67A982C04E4
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 18:51:11 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Fri, 7 Dec 2012 00:51:09 -0700
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 956871FF001C
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2012 00:51:00 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qB77p6j9299318
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 00:51:06 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qB77p5No013146
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2012 00:51:05 -0700
Subject: [PATCH 6/6] powerpc: Implement PPR save/restore
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 Dec 2012 23:51:04 -0800
Message-ID: <1354866664.1281.19.camel@hbabu-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 6/6] powerpc: Implement PPR save/restore

When the task enters in to kernel space, the user defined priority (PPR)
will be saved in to PACA at the beginning of first level exception
vector and then copy from PACA to thread_info in second level vector.
PPR will be restored from thread_info before exits the kernel space.

P7/P8 temporarily raises the thread priority to higher level during
exception until the program executes HMT_* calls. But it will not modify
PPR register. So we save PPR value whenever some register is available
to use and then calls HMT_MEDIUM to increase the priority. This feature
supports on P7 or later processors.

We save/ restore PPR for all exception vectors except system call entry.
GLIBC will be saving / restore for system calls. So the default PPR
value (3) will be set for the system call exit when the task returned
to the user space.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |   18 ++++++++++--------
 arch/powerpc/kernel/entry_64.S           |    3 +++
 arch/powerpc/kernel/exceptions-64s.S     |   23 +++++++++++++----------
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 090fcd1..c235867 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -147,8 +147,9 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943)
 
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	GET_PACA(r13);							\
-	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
-	std	r10,area+EX_R10(r13);					\
+	std	r9,area+EX_R9(r13);	/* save r9 */			\
+	HMT_MEDIUM_PPR_SAVE(area, r9);					\
+	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
 	BEGIN_FTR_SECTION_NESTED(66);					\
 	mfspr	r10,SPRN_CFAR;						\
 	std	r10,area+EX_CFAR(r13);					\
@@ -264,6 +265,7 @@ do_kvm_##n:								\
 	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
+	SAVE_PPR(area, r9, r10);					   \
 4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
 	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
@@ -305,7 +307,7 @@ do_kvm_##n:								\
 	. = loc;					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_PPR_DISCARD;				\
 	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_STD, KVMTEST_PR, vec)
@@ -314,7 +316,7 @@ label##_pSeries:					\
 	. = loc;					\
 	.globl label##_hv;				\
 label##_hv:						\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_PPR_DISCARD;				\
 	SET_SCRATCH0(r13);	/* save r13 */			\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
@@ -323,7 +325,7 @@ label##_hv:						\
 	. = loc;					\
 	.globl label##_relon_pSeries;			\
 label##_relon_pSeries:					\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_PPR_DISCARD;				\
 	/* No guest interrupts come through here */	\
 	SET_SCRATCH0(r13);		/* save r13 */	\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
@@ -333,7 +335,7 @@ label##_relon_pSeries:					\
 	. = loc;					\
 	.globl label##_relon_hv;			\
 label##_relon_hv:					\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_PPR_DISCARD;				\
 	/* No guest interrupts come through here */	\
 	SET_SCRATCH0(r13);	/* save r13 */		\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
@@ -368,7 +370,7 @@ label##_relon_hv:					\
 #define SOFTEN_NOTEST_HV(vec)		_SOFTEN_TEST(EXC_HV, vec)
 
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	HMT_MEDIUM;							\
+	HMT_MEDIUM_PPR_DISCARD;						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
@@ -390,7 +392,7 @@ label##_hv:								\
 				    EXC_HV, SOFTEN_TEST_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
-	HMT_MEDIUM;							\
+	HMT_MEDIUM_PPR_DISCARD;						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, h);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 4e78247..886fc64 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -227,6 +227,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r11, r12)
+	HMT_MEDIUM_LOW_HAS_PPR
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
@@ -303,6 +304,7 @@ syscall_exit_work:
 	subi	r12,r12,TI_FLAGS
 
 4:	/* Anything else left to do? */
+	SET_DEFAULT_THREAD_PPR(r3, r9)		/* Set thread.ppr = 3 */
 	andi.	r0,r9,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	beq	.ret_from_except_lite
 
@@ -764,6 +766,7 @@ fast_exception_return:
 	andi.	r0,r3,MSR_PR
 	beq	1f
 	ACCOUNT_CPU_USER_EXIT(r2, r4)
+	RESTORE_PPR(r2, r4)
 	REST_GPR(13, r1)
 1:
 	mtspr	SPRN_SRR1,r3
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4665e82..6f9d83d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -104,7 +104,7 @@ __start_interrupts:
 
 	.globl system_reset_pSeries;
 system_reset_pSeries:
-	HMT_MEDIUM;
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
 BEGIN_FTR_SECTION
@@ -158,7 +158,7 @@ machine_check_pSeries_1:
 	. = 0x300
 	.globl data_access_pSeries
 data_access_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 BEGIN_FTR_SECTION
 	b	data_access_check_stab
@@ -170,7 +170,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 	. = 0x380
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -201,7 +201,7 @@ data_access_slb_pSeries:
 	. = 0x480
 	.globl instruction_access_slb_pSeries
 instruction_access_slb_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -322,10 +322,11 @@ vsx_unavailable_pSeries_1:
 	. = 0x1500
 	.global denorm_exception_hv
 denorm_exception_hv:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	mfspr	r13,SPRN_SPRG_HPACA
 	std	r9,PACA_EXGEN+EX_R9(r13)
+	HMT_MEDIUM_PPR_SAVE(PACA_EXGEN, r9)
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	std	r11,PACA_EXGEN+EX_R11(r13)
 	std	r12,PACA_EXGEN+EX_R12(r13)
@@ -367,7 +368,7 @@ denorm_exception_hv:
 machine_check_pSeries:
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common,
 				 EXC_STD, KVMTEST, 0x200)
@@ -496,6 +497,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 	mtspr	SPRN_HSRR0,r11
 	mtcrf	0x80,r9
 	ld	r9,PACA_EXGEN+EX_R9(r13)
+	RESTORE_PPR_PACA(PACA_EXGEN, r10)
 	ld	r10,PACA_EXGEN+EX_R10(r13)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r12,PACA_EXGEN+EX_R12(r13)
@@ -586,7 +588,7 @@ _GLOBAL(__replay_interrupt)
 	.globl system_reset_fwnmi
       .align 7
 system_reset_fwnmi:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
@@ -690,7 +692,7 @@ machine_check_common:
 	. = 0x4380
 	.globl data_access_slb_relon_pSeries
 data_access_slb_relon_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -715,7 +717,7 @@ data_access_slb_relon_pSeries:
 	. = 0x4480
 	.globl instruction_access_slb_relon_pSeries
 instruction_access_slb_relon_pSeries:
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
@@ -1036,6 +1038,7 @@ _GLOBAL(slb_miss_realmode)
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
@@ -1383,7 +1386,7 @@ initial_stab:
 
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
-	HMT_MEDIUM
+	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	clrldi	r3,r3,2
-- 
1.7.1
