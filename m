Return-Path: <roland@redhat.com>
Received: from QMTA06.westchester.pa.mail.comcast.net
	(qmta06.westchester.pa.mail.comcast.net [76.96.62.56])
	by ozlabs.org (Postfix) with ESMTP id D0964DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 16:52:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc ptrace block-step
Message-Id: <20080502065145.B4FCA26FA07@magilla.localdomain>
Date: Thu,  1 May 2008 23:51:45 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I didn't test the booke variant of this (I don't have that hardware).
I only tested it on a Mac G5 (ppc64, 970FX).

There is a test program at:

http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/tests/ptrace-tests/tests/block-step.c?cvsroot=systemtap

To build that program for powerpc, remove the && 0 from this line:

# elif defined __powerpc__  && 0	/* XXX not upstream yet */

and compile with -D_GNU_SOURCE.


Thanks,
Roland

---
[PATCH] powerpc ptrace block-step

This adds block-step support on powerpc,
including a PTRACE_SINGLEBLOCK request for ptrace.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |   19 ++++++++++++++++++-
 include/asm-powerpc/ptrace.h |    4 ++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2a9fe97..91ee077 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -619,12 +619,29 @@ void user_enable_single_step(struct task_struct *task) 		task->thread.dbcr0 = DBCR0_IDM | DBCR0_IC;
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
@@ -634,7 +651,7 @@ void user_disable_single_step(struct task_struct *task)
 		task->thread.dbcr0 = 0;
 		regs->msr &= ~MSR_DE;
 #else
-		regs->msr &= ~MSR_SE;
+		regs->msr &= ~(MSR_SE | MSR_BE);
 #endif
 	}
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
diff --git a/include/asm-powerpc/ptrace.h b/include/asm-powerpc/ptrace.h
index 39023dd..6a3892d 100644
--- a/include/asm-powerpc/ptrace.h
+++ b/include/asm-powerpc/ptrace.h
@@ -135,7 +135,9 @@ do {									      \
  * These are defined as per linux/ptrace.h, which see.
  */
 #define arch_has_single_step()	(1)
+#define arch_has_block_step()	(1)
 extern void user_enable_single_step(struct task_struct *);
+extern void user_enable_block_step(struct task_struct *);
 extern void user_disable_single_step(struct task_struct *);
 
 #endif /* __ASSEMBLY__ */
@@ -276,4 +278,6 @@ extern void user_disable_single_step(struct task_struct *);
 #define PPC_PTRACE_PEEKUSR_3264  0x91
 #define PPC_PTRACE_POKEUSR_3264  0x90
 
+#define PTRACE_SINGLEBLOCK	0x100	/* resume execution until next branch */
+
 #endif /* _ASM_POWERPC_PTRACE_H */
