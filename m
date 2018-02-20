Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCs2RHKzDrHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:05 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0IoxX063056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:02 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g85g3pmqa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:02 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:00 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 05/12] [WIP] powerpc/tm: Reclaim/recheckpoint on entry/exit
Date: Tue, 20 Feb 2018 11:22:34 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-6-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/include/asm/exception-64s.h | 25 +++++++++++++++++++++
 arch/powerpc/kernel/entry_64.S           |  5 +++++
 arch/powerpc/kernel/process.c            | 37 ++++++++++++++++++++++++++++----
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 471b2274fbeb..f904f19a9ec2 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -35,6 +35,7 @@
  * implementations as possible.
  */
 #include <asm/head-64.h>
+#include <asm/tm.h>
 
 /* PACA save area offsets (exgen, exmc, etc) */
 #define EX_R9		0
@@ -127,6 +128,26 @@
 	hrfid;								\
 	b	hrfi_flush_fallback
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+#define TM_KERNEL_ENTRY		                                        \
+	ld	r3,_MSR(r1);			                        \
+	/* Probably don't need to check if coming from user/kernel */	\
+	/* If TM is suspended or active then we must have come from*/	\
+	/* userspace */							\
+	andi.	r0,r3,MSR_PR;						\
+	beq	1f;							\
+	rldicl. r3,r3,(64-MSR_TS_LG),(64-2); /* SUSPENDED or ACTIVE*/   \
+	beql+	1f;                   	/* Not SUSPENDED or ACTIVE */   \
+	bl	save_nvgprs;						\
+	RECONCILE_IRQ_STATE(r10,r11);					\
+	li	r3,TM_CAUSE_MISC;					\
+	bl	tm_reclaim_current;	/* uint8 cause		   */	\
+1:
+
+#else /* CONFIG_PPC_TRANSACTIONAL_MEM */
+#define TM_KERNEL_ENTRY
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+
 #ifdef CONFIG_RELOCATABLE
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
@@ -675,6 +696,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	EXCEPTION_PROLOG_COMMON(trap, area);			\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
+	/* This is going to need to go somewhere else as well */\
+	/* See comment in tm_recheckpoint()		      */\
+	TM_KERNEL_ENTRY;					\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr;						\
 	b	ret
@@ -689,6 +713,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	EXCEPTION_PROLOG_COMMON_3(trap);			\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
+	TM_KERNEL_ENTRY;					\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cb5109a7ea3..107c15c6f48b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -126,6 +126,11 @@ BEGIN_FW_FTR_SECTION
 33:
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE && CONFIG_PPC_SPLPAR */
+	TM_KERNEL_ENTRY
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
 
 	/*
 	 * A syscall should always be called with interrupts enabled
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 77dc6d8288eb..ea75da0fd506 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -951,6 +951,23 @@ void tm_recheckpoint(struct thread_struct *thread)
 	if (!(thread->regs->msr & MSR_TM))
 		return;
 
+	/*
+	 * This is 'that' comment.
+	 *
+	 * If we get where with tm suspended or active then something
+	 * has gone wrong. I've added this now as a proof of concept.
+	 *
+	 * The problem I'm seeing without it is an attempt to
+	 * recheckpoint a CPU without a previous reclaim.
+	 *
+	 * I'm probably missed an exception entry with the
+	 * TM_KERNEL_ENTRY macro. Should be easy enough to find.
+	 */
+	if (MSR_TM_ACTIVE(mfmsr()))
+		return;
+
+	tm_enable();
+
 	/* We really can't be interrupted here as the TEXASR registers can't
 	 * change and later in the trecheckpoint code, we have a userspace R1.
 	 * So let's hard disable over this region.
@@ -1009,6 +1026,13 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 static inline void __switch_to_tm(struct task_struct *prev,
 		struct task_struct *new)
 {
+	/*
+	 * So, with the rework none of this code should not be needed.
+	 * I've left in the reclaim for now. This *should* save us
+	 * from any mistake in the new code. Also the
+	 * enabling/disabling logic of MSR_TM really should be
+	 * refactored into a common way with MSR_{FP,VEC,VSX}
+	 */
 	if (cpu_has_feature(CPU_FTR_TM)) {
 		if (tm_enabled(prev) || tm_enabled(new))
 			tm_enable();
@@ -1016,11 +1040,14 @@ static inline void __switch_to_tm(struct task_struct *prev,
 		if (tm_enabled(prev)) {
 			prev->thread.load_tm++;
 			tm_reclaim_task(prev);
-			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
-				prev->thread.regs->msr &= ~MSR_TM;
+			/*
+			 * The disabling logic may be confused don't
+			 * disable for now
+			 *
+			 * if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
+			 *	prev->thread.regs->msr &= ~MSR_TM;
+			 */
 		}
-
-		tm_recheckpoint_new_task(new);
 	}
 }
 
@@ -1055,6 +1082,8 @@ void restore_tm_state(struct pt_regs *regs)
 	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
 	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
 
+	tm_recheckpoint(&current->thread);
+
 	/* Ensure that restore_math() will restore */
 	if (msr_diff & MSR_FP)
 		current->thread.load_fp = 1;
-- 
2.16.2
