Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfY3357HLzDqts
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:40:47 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rfY331nzTz9t0X
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:47 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T6d6bf059932
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:40:45 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09p02rm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 02:40:45 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 29 Jun 2016 16:40:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3B89B3578057
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5T6eetP1573242
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5T6edJZ022493
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 16:40:40 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: anton@samba.org, mikey@neuling.org
Subject: [RFC 3/3] powerpc: tm: Enable transactional memory (TM) lazily for
 userspace
Date: Wed, 29 Jun 2016 16:34:36 +1000
In-Reply-To: <20160629063436.10003-1-cyrilbur@gmail.com>
References: <20160629063436.10003-1-cyrilbur@gmail.com>
Message-Id: <20160629063436.10003-4-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the MSR TM bit is always set if the hardware is TM capable.
This adds extra overhead as it means the TM SPRS (TFHAR, TEXASR and
TFAIR) must be swapped for each process regardless of if they use TM.

For processes that don't use TM the TM MSR bit can be turned off
allowing the kernel to avoid the expensive swap of the TM registers.

A TM unavailable exception will occur if a thread does use TM and the
kernel will enable MSR_TM and leave it so for some time afterwards.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/processor.h |  1 +
 arch/powerpc/kernel/process.c        | 30 ++++++++++++++++++++++--------
 arch/powerpc/kernel/traps.c          |  8 ++++++++
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 5ff1e4c..9d4363c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -257,6 +257,7 @@ struct thread_struct {
 	int		used_spe;	/* set if process has used spe */
 #endif /* CONFIG_SPE */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	u8	load_tm;
 	u64		tm_tfhar;	/* Transaction fail handler addr */
 	u64		tm_texasr;	/* Transaction exception & summary */
 	u64		tm_tfiar;	/* Transaction fail instr address reg */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2e903c6..8abecda 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -870,6 +870,9 @@ void tm_recheckpoint(struct thread_struct *thread,
 {
 	unsigned long flags;
 
+	if (!(thread->regs->msr & MSR_TM))
+		return;
+
 	/* We really can't be interrupted here as the TEXASR registers can't
 	 * change and later in the trecheckpoint code, we have a userspace R1.
 	 * So let's hard disable over this region.
@@ -905,6 +908,9 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 	if (!new->thread.regs)
 		return;
 
+	if (!(new->thread.regs->msr & MSR_TM))
+		return;
+
 	if (!MSR_TM_ACTIVE(new->thread.regs->msr)){
 		tm_restore_sprs(&new->thread);
 		return;
@@ -925,11 +931,18 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 		 new->pid, mfmsr());
 }
 
-static inline void __switch_to_tm(struct task_struct *prev)
+static inline void __switch_to_tm(struct task_struct *prev, struct task_struct *new)
 {
 	if (cpu_has_feature(CPU_FTR_TM)) {
-		tm_enable();
-		tm_reclaim_task(prev);
+		if (prev->thread.regs && (prev->thread.regs->msr & MSR_TM)) {
+			prev->thread.load_tm++;
+			tm_enable();
+			tm_reclaim_task(prev);
+			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
+				prev->thread.regs->msr |= ~MSR_TM;
+		} else if (new && new->thread.regs && (new->thread.regs->msr & MSR_TM)) {
+			tm_enable();
+		}
 	}
 }
 
@@ -965,7 +978,7 @@ void restore_tm_state(struct pt_regs *regs)
 
 #else
 #define tm_recheckpoint_new_task(new)
-#define __switch_to_tm(prev)
+#define __switch_to_tm(prev, new)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 static inline void save_sprs(struct thread_struct *t)
@@ -1095,7 +1108,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	/* Save FPU, Altivec, VSX and SPE state */
 	giveup_all(prev);
 
-	__switch_to_tm(prev);
+	__switch_to_tm(prev, new);
 
 	/*
 	 * We can't take a PMU exception inside _switch() since there is a
@@ -1340,8 +1353,11 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	 * transitions the CPU out of TM mode.  Hence we need to call
 	 * tm_recheckpoint_new_task() (on the same task) to restore the
 	 * checkpointed state back and the TM mode.
+	 *
+	 * Can't pass dst because it isn't ready. Doesn't matter, passing
+	 * dst is only important for __switch_to()
 	 */
-	__switch_to_tm(src);
+	__switch_to_tm(src, NULL);
 	tm_recheckpoint_new_task(src);
 
 	*dst = *src;
@@ -1574,8 +1590,6 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.used_spe = 0;
 #endif /* CONFIG_SPE */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	if (cpu_has_feature(CPU_FTR_TM))
-		regs->msr |= MSR_TM;
 	current->thread.tm_tfhar = 0;
 	current->thread.tm_texasr = 0;
 	current->thread.tm_tfiar = 0;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 29260ee..141b953 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1366,6 +1366,14 @@ void vsx_unavailable_exception(struct pt_regs *regs)
 
 static void tm_unavailable(struct pt_regs *regs)
 {
+	if (user_mode(regs)) {
+		current->thread.load_tm++;
+		regs->msr |= MSR_TM;
+		tm_enable();
+		tm_restore_sprs(&current->thread);
+		return;
+	}
+
 	pr_emerg("Unrecoverable TM Unavailable Exception "
 			"%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable TM Unavailable Exception", regs, SIGABRT);
-- 
2.9.0
