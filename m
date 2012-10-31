Return-Path: <haren@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 831CA2C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 17:57:54 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 00:57:52 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 716621FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:57:48 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9V6vnR5228786
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:57:49 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9V6vnCs029167
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:57:49 -0600
Subject: [PATCH 6/6] powerpc: Implement PPR save/restore
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Oct 2012 23:57:47 -0700
Message-ID: <1351666667.32304.20.camel@hbabu-laptop>
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

[PATCH 6/6] powerpc: Implement PPR save/restore

When the task enters in to kernel space, the user defined priority (PPR)
will be saved in to PACA at the beginning of first level exception
vector and then copy from PACA to thread_info in second level vector.
PPR will be restored from thread_info before exits the kernel space.

P7 temporarily raises the thread priority to higher level during
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
 arch/powerpc/include/asm/exception-64s.h |   12 +++++++-----
 arch/powerpc/kernel/entry_64.S           |    3 +++
 arch/powerpc/kernel/exceptions-64s.S     |   15 ++++++++-------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 880ef7d..cf7eae6 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -93,8 +93,9 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943)
 
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
@@ -208,6 +209,7 @@ do_kvm_##n:								\
 	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
+	SAVE_PPR(area, r9, r10);					   \
 4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
 	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
@@ -249,7 +251,7 @@ do_kvm_##n:								\
 	. = loc;					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_NO_PPR;				\
 	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_STD, KVMTEST_PR, vec)
@@ -258,7 +260,7 @@ label##_pSeries:					\
 	. = loc;					\
 	.globl label##_hv;				\
 label##_hv:						\
-	HMT_MEDIUM;					\
+	HMT_MEDIUM_NO_PPR;				\
 	SET_SCRATCH0(r13);	/* save r13 */			\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
@@ -289,7 +291,7 @@ label##_hv:						\
 	_SOFTEN_TEST(EXC_STD, vec)
 
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
-	HMT_MEDIUM;							\
+	HMT_MEDIUM_NO_PPR;						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 72c40dd..1d0f409 100644
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
 
@@ -762,6 +764,7 @@ fast_exception_return:
 	andi.	r0,r3,MSR_PR
 	beq	1f
 	ACCOUNT_CPU_USER_EXIT(r2, r4)
+	RESTORE_PPR(r2, r4)
 	REST_GPR(13, r1)
 1:
 	mtspr	SPRN_SRR1,r3
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 10b658a..0fa2c88 100644
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
@@ -321,7 +321,7 @@ denorm_exception_hv:
 machine_check_pSeries:
 	.globl machine_check_fwnmi
 machine_check_fwnmi:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common,
 				 EXC_STD, KVMTEST, 0x200)
@@ -540,7 +540,7 @@ _GLOBAL(__replay_interrupt)
 	.globl system_reset_fwnmi
       .align 7
 system_reset_fwnmi:
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
@@ -843,6 +843,7 @@ _GLOBAL(slb_miss_realmode)
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
@@ -1175,7 +1176,7 @@ initial_stab:
 
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
-	HMT_MEDIUM
+	HMT_MEDIUM_NO_PPR
 	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	clrldi	r3,r3,2
-- 
1.7.1
