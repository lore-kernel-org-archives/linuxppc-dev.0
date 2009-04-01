Return-Path: <roland@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 0ABA8DDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 08:59:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: [PATCH] powerpc ptrace block-step
Message-Id: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
Date: Wed,  1 Apr 2009 14:59:03 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, utrace-devel@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maynard asked about user_enable_block_step() support on powerpc.
This is the old patch I've posted before.  I haven't even tried
to compile it lately, but it rebased cleanly.

AFAIK the only reason this didn't go in several months ago was waiting
for someone to decide what the right arch_has_block_step() condition was,
i.e. if it needs to check some cpu_feature or chip identifier bits.

I had hoped that I had passed the buck then to ppc folks to figure that out
and make it so.  But it does not appear to have happened.

Note you can drop the #define PTRACE_SINGLEBLOCK if you want to be
conservative and not touch the user (ptrace) ABI yet.  Then Maynard
could beat on it with internal uses (utrace) before you worry about
whether userland expects the new ptrace request macro to exist.


Thanks,
Roland
---
>From 2482ed1a0ced9caf964275889ea2315916e84ada Mon Sep 17 00:00:00 2001
From: Roland McGrath <roland@redhat.com>
Date: Thu, 1 May 2008 23:40:58 -0700
Subject: [PATCH] powerpc ptrace block-step

This adds block-step support on powerpc,
including a PTRACE_SINGLEBLOCK request for ptrace.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/include/asm/ptrace.h |    4 ++++
 arch/powerpc/kernel/ptrace.c      |   19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index c9c678f..d7692b8 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -135,7 +135,9 @@ do {									      \
  * These are defined as per linux/ptrace.h, which see.
  */
 #define arch_has_single_step()	(1)
+#define arch_has_block_step()	(1)
 extern void user_enable_single_step(struct task_struct *);
+extern void user_enable_block_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
 #endif /* __ASSEMBLY__ */
@@ -288,4 +290,6 @@ extern void user_disable_single_step(struct task_struct *);
 #define PPC_PTRACE_PEEKUSR_3264  0x91
 #define PPC_PTRACE_POKEUSR_3264  0x90
 
+#define PTRACE_SINGLEBLOCK	0x100	/* resume execution until next branch */
+
 #endif /* _ASM_POWERPC_PTRACE_H */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 3635be6..656fea2 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -707,12 +707,29 @@ void user_enable_single_step(struct task_struct *task)
 		task->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
 		regs->msr |= MSR_DE;
 #else
+		regs->msr &= ~MSR_BE;
 		regs->msr |= MSR_SE;
 #endif
 	}
 	set_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+void user_enable_block_step(struct task_struct *task)
+{
+	struct pt_regs *regs = task->thread.regs;
+
+	if (regs != NULL) {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
+		regs->msr |= MSR_DE;
+#else
+		regs->msr &= ~MSR_SE;
+		regs->msr |= MSR_BE;
+#endif
+	}
+	set_tsk_thread_flag(task, TIF_SINGLESTEP);
+}
+
 void user_disable_single_step(struct task_struct *task)
 {
 	struct pt_regs *regs = task->thread.regs;
@@ -729,7 +746,7 @@ void user_disable_single_step(struct task_struct *task)
 		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_IDM);
 		regs->msr &= ~MSR_DE;
 #else
-		regs->msr &= ~MSR_SE;
+		regs->msr &= ~(MSR_SE | MSR_BE);
 #endif
 	}
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
-- 
1.6.0.6
