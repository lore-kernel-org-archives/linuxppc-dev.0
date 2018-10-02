Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F793C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:47:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78322082A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O55psR5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78322082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Phnd4kp7zF1QT
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:47:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O55psR5J";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="O55psR5J"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMZ0Rk3zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:10 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id p5-v6so1710392plk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ObEtYDLgz3Lgb20fPm0fCcwQauapL+90pwSaM8mBqDg=;
 b=O55psR5JWK5nCYnBWI3XmSQ1+1GctLFfKzqqrB1ovqEfIg1hgzEt2e3PqJDSG8vhWx
 Qe7G2WHEVsL11w2WSAbK8fAtwn2OeGLegVVHbYa5BOedW/iebWJb9CQWORt4bnHX1D9G
 Jq8NkvWGw/KCxf5mUk+WzoOpc57nTpPVMyhbUeZMCwx2JE6Yo9RlzdSC0rB5MZA4yFaH
 T2D9Tcp+gMud/NZYhj0FdkpAvukHG1M/fSDqXo2NeoKMFfYCK6LHW8/Eh/hSZlvDlSQm
 2Y6vYbGJ7IV1zjutZMaYo/6OQjVWFqWucKPYvu3+RJSHNCUFmdAJantj2yDoBetKSTbp
 pKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ObEtYDLgz3Lgb20fPm0fCcwQauapL+90pwSaM8mBqDg=;
 b=HhwTzs8O8C85eZho3QSIwpUKUzLEn7TC6wZogWZ4N+h2KHdYmwb6UsNsp/kwNI9Gbb
 7fH2t1h6YJ18+CSv365o9kflEpB5iZ0HOTzLkJL4fbMGRtCcik4KJrlCtYPfixr1i3OK
 FFQh0cTDl6OFZ7zE517ht3Qpqms+fzAmwSdmZxLJmbu1Dz6g6dYutJV7GD3qZMgv/+bn
 xn04mvEbnSwbs7zDpjXU3UWc5q1fB4teM0lekUEFsabqy+OYehJVkbYr4aXHlsN1eLNQ
 g5/hoL9BzaItTuggvjHkSIXK5AdCSnL31EgBN21CoLhX/55Ihk6tfssGoJch6hym9u5U
 mEDg==
X-Gm-Message-State: ABuFfojawmsoXX19GrcFdRU6C1Lv//n5GXlMkl46itMrfpYDGBizlhIM
 4Wh99bpIp03fuUchRFJirRRxQFH8
X-Google-Smtp-Source: ACcGV62og4abSu294UlTfRgnyH/PtoHELw/RdYiB3ZhIc9JH0/zuZbppN1md/8JTpcj2ULs+mhic1Q==
X-Received: by 2002:a17:902:8543:: with SMTP id
 d3-v6mr17286561plo.81.1538490488175; 
 Tue, 02 Oct 2018 07:28:08 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/9] powerpc/64: add struct int_regs to save additional
 registers on stack
Date: Wed,  3 Oct 2018 00:27:52 +1000
Message-Id: <20181002142759.6244-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181002142759.6244-1-npiggin@gmail.com>
References: <20181002142759.6244-1-npiggin@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

struct pt_regs is part of the user ABI and also the fundametal
structure for saving registers at interrupt.

The generic kernel code makes it difficult to completely decouple
these, but it's easy enough to add additional space required to save
more registers. Create a struct int_stack with struct pt_regs at
offset 0.

This is required for a following fix to save the PPR SPR on stack.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h | 17 +++++++---
 arch/powerpc/kernel/asm-offsets.c | 21 ++++++++-----
 arch/powerpc/kernel/process.c     | 52 ++++++++++++++++---------------
 arch/powerpc/kernel/stacktrace.c  |  2 +-
 4 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 447cbd1bee99..1a98cd8c49f6 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -26,7 +26,6 @@
 #include <uapi/asm/ptrace.h>
 #include <asm/asm-const.h>
 
-
 #ifdef __powerpc64__
 
 /*
@@ -44,7 +43,7 @@
 #define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
 #define STACK_FRAME_LR_SAVE	2	/* Location of LR in stack frame */
 #define STACK_FRAME_REGS_MARKER	ASM_CONST(0x7265677368657265)
-#define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + \
+#define STACK_INT_FRAME_SIZE	(sizeof(struct int_regs) + \
 				 STACK_FRAME_OVERHEAD + KERNEL_REDZONE_SIZE)
 #define STACK_FRAME_MARKER	12
 
@@ -76,6 +75,11 @@
 
 #ifndef __ASSEMBLY__
 
+struct int_regs {
+	/* pt_regs must be offset 0 so r1 + STACK_FRAME_OVERHEAD points to it */
+	struct pt_regs pt_regs;
+};
+
 #define GET_IP(regs)		((regs)->nip)
 #define GET_USP(regs)		((regs)->gpr[1])
 #define GET_FP(regs)		(0)
@@ -119,8 +123,11 @@ extern int ptrace_get_reg(struct task_struct *task, int regno,
 extern int ptrace_put_reg(struct task_struct *task, int regno,
 			  unsigned long data);
 
-#define current_pt_regs() \
-	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
+#define current_int_regs() \
+ ((struct int_regs *)((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
+
+#define current_pt_regs() (&current_int_regs()->pt_regs)
+
 /*
  * We use the least-significant bit of the trap field to indicate
  * whether we have saved the full set of registers, or only a
@@ -137,7 +144,7 @@ extern int ptrace_put_reg(struct task_struct *task, int regno,
 #define TRAP(regs)		((regs)->trap & ~0xF)
 #ifdef __powerpc64__
 #define NV_REG_POISON		0xdeadbeefdeadbeefUL
-#define CHECK_FULL_REGS(regs)	BUG_ON(regs->trap & 1)
+#define CHECK_FULL_REGS(regs)	BUG_ON((regs)->trap & 1)
 #else
 #define NV_REG_POISON		0xdeadbeef
 #define CHECK_FULL_REGS(regs)						      \
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 27c78b6c9909..509a113f97dc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -72,8 +72,13 @@
 #include <asm/fixmap.h>
 #endif
 
-#define STACK_PT_REGS_OFFSET(sym, val)	\
-	DEFINE(sym, STACK_FRAME_OVERHEAD + offsetof(struct pt_regs, val))
+#define STACK_INT_REGS_OFFSET(sym, val)				\
+	DEFINE(sym, STACK_FRAME_OVERHEAD + offsetof(struct int_regs, val))
+
+#define STACK_PT_REGS_OFFSET(sym, val)				\
+	DEFINE(sym, STACK_FRAME_OVERHEAD +			\
+			offsetof(struct int_regs, pt_regs) +	\
+			offsetof(struct pt_regs, val))
 
 int main(void)
 {
@@ -150,7 +155,7 @@ int main(void)
 	OFFSET(THREAD_CKFPSTATE, thread_struct, ckfp_state.fpr);
 	/* Local pt_regs on stack for Transactional Memory funcs. */
 	DEFINE(TM_FRAME_SIZE, STACK_FRAME_OVERHEAD +
-	       sizeof(struct pt_regs) + 16);
+	       sizeof(struct int_regs) + 16);
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 	OFFSET(TI_FLAGS, thread_info, flags);
@@ -273,11 +278,11 @@ int main(void)
 
 	/* Interrupt register frame */
 	DEFINE(INT_FRAME_SIZE, STACK_INT_FRAME_SIZE);
-	DEFINE(SWITCH_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
+	DEFINE(SWITCH_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct int_regs));
 #ifdef CONFIG_PPC64
 	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
-	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
-	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
+	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct int_regs) + 16);
+	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct int_regs) + 16);
 #endif /* CONFIG_PPC64 */
 	STACK_PT_REGS_OFFSET(GPR0, gpr[0]);
 	STACK_PT_REGS_OFFSET(GPR1, gpr[1]);
@@ -324,8 +329,8 @@ int main(void)
 	STACK_PT_REGS_OFFSET(SOFTE, softe);
 
 	/* These _only_ to be used with {PROM,RTAS}_FRAME_SIZE!!! */
-	DEFINE(_SRR0, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs));
-	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
+	DEFINE(_SRR0, STACK_FRAME_OVERHEAD+sizeof(struct int_regs));
+	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct int_regs)+8);
 #endif /* CONFIG_PPC64 */
 
 #if defined(CONFIG_PPC32)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 03c2e1f134bc..532e9a83e526 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1627,7 +1627,7 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long kthread_arg, struct task_struct *p)
 {
-	struct pt_regs *childregs, *kregs;
+	struct int_regs *childregs, *kregs;
 	extern void ret_from_fork(void);
 	extern void ret_from_kernel_thread(void);
 	void (*f)(void);
@@ -1637,44 +1637,44 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	klp_init_thread_info(ti);
 
 	/* Copy registers */
-	sp -= sizeof(struct pt_regs);
-	childregs = (struct pt_regs *) sp;
+	sp -= sizeof(struct int_regs);
+	childregs = (struct int_regs *) sp;
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		/* kernel thread */
-		memset(childregs, 0, sizeof(struct pt_regs));
-		childregs->gpr[1] = sp + sizeof(struct pt_regs);
+		memset(childregs, 0, sizeof(struct int_regs));
+		childregs->pt_regs.gpr[1] = sp + sizeof(struct int_regs);
 		/* function */
 		if (usp)
-			childregs->gpr[14] = ppc_function_entry((void *)usp);
+			childregs->pt_regs.gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = IRQS_ENABLED;
+		childregs->pt_regs.softe = IRQS_ENABLED;
 #endif
-		childregs->gpr[15] = kthread_arg;
+		childregs->pt_regs.gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
 		ti->flags |= _TIF_RESTOREALL;
 		f = ret_from_kernel_thread;
 	} else {
 		/* user thread */
-		struct pt_regs *regs = current_pt_regs();
-		CHECK_FULL_REGS(regs);
+		struct int_regs *regs = current_int_regs();
+		CHECK_FULL_REGS(&regs->pt_regs);
 		*childregs = *regs;
 		if (usp)
-			childregs->gpr[1] = usp;
-		p->thread.regs = childregs;
-		childregs->gpr[3] = 0;  /* Result from fork() */
+			childregs->pt_regs.gpr[1] = usp;
+		p->thread.regs = &childregs->pt_regs;
+		childregs->pt_regs.gpr[3] = 0;  /* Result from fork() */
 		if (clone_flags & CLONE_SETTLS) {
 #ifdef CONFIG_PPC64
 			if (!is_32bit_task())
-				childregs->gpr[13] = childregs->gpr[6];
+				childregs->pt_regs.gpr[13] = childregs->pt_regs.gpr[6];
 			else
 #endif
-				childregs->gpr[2] = childregs->gpr[6];
+				childregs->pt_regs.gpr[2] = childregs->pt_regs.gpr[6];
 		}
 
 		f = ret_from_fork;
 	}
-	childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);
+	childregs->pt_regs.msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);
 	sp -= STACK_FRAME_OVERHEAD;
 
 	/*
@@ -1686,8 +1686,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	 * system call, using the stack frame created above.
 	 */
 	((unsigned long *)sp)[0] = 0;
-	sp -= sizeof(struct pt_regs);
-	kregs = (struct pt_regs *) sp;
+	sp -= sizeof(struct int_regs);
+	kregs = (struct int_regs *) sp;
 	sp -= STACK_FRAME_OVERHEAD;
 	p->thread.ksp = sp;
 #ifdef CONFIG_PPC32
@@ -1715,7 +1715,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 
 	p->thread.tidr = 0;
 #endif
-	kregs->nip = ppc_function_entry(f);
+	kregs->pt_regs.nip = ppc_function_entry(f);
 	return 0;
 }
 
@@ -1739,8 +1739,8 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	 * set.  Do it now.
 	 */
 	if (!current->thread.regs) {
-		struct pt_regs *regs = task_stack_page(current) + THREAD_SIZE;
-		current->thread.regs = regs - 1;
+		struct int_regs *iregs = task_stack_page(current) + THREAD_SIZE;
+		current->thread.regs = &(iregs - 1)->pt_regs;
 	}
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -2106,11 +2106,13 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		 */
 		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE)
 		    && stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
-			struct pt_regs *regs = (struct pt_regs *)
-				(sp + STACK_FRAME_OVERHEAD);
-			lr = regs->link;
+			struct int_regs *regs;
+			regs = (struct int_regs *)(sp + STACK_FRAME_OVERHEAD);
+			lr = regs->pt_regs.link;
 			printk("--- interrupt: %lx at %pS\n    LR = %pS\n",
-			       regs->trap, (void *)regs->nip, (void *)lr);
+			       regs->pt_regs.trap,
+			       (void *)regs->pt_regs.nip,
+			       (void *)lr);
 			firstframe = 1;
 		}
 
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e2c50b55138f..463dedc4d664 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -120,7 +120,7 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 		 * an unreliable stack trace until it's been
 		 * _switch()'ed to for the first time.
 		 */
-		stack_end -= STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
+		stack_end -= STACK_FRAME_OVERHEAD + sizeof(struct int_regs);
 	} else {
 		/*
 		 * idle tasks have a custom stack layout,
-- 
2.18.0

