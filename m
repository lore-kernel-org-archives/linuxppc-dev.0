Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GMzK4ZVrzF3Mm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 02:45:17 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KGeOD7101705
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:45:15 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mmd1rewmj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 12:45:15 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 20 Sep 2018 10:45:14 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 2/3] powerpc/ptrace: Add support for PTRACE_SYSEMU
Date: Thu, 20 Sep 2018 13:45:06 -0300
In-Reply-To: <1537461907-32003-1-git-send-email-leitao@debian.org>
References: <1537461907-32003-1-git-send-email-leitao@debian.org>
Message-Id: <1537461907-32003-2-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a patch that adds support for PTRACE_SYSEMU ptrace request in
PowerPC architecture.

When ptrace(PTRACE_SYSEMU, ...) request is called, it will be handled by
the arch independent function ptrace_resume(), which will tag the task with
the TIF_SYSCALL_EMU flag. This flag needs to be handled from a platform
dependent point of view, which is what this patch does.

This patch adds this task's flag as part of the _TIF_SYSCALL_DOTRACE, which
is the MACRO that is used to trace syscalls at entrance/exit.

Since TIF_SYSCALL_EMU is now part of _TIF_SYSCALL_DOTRACE, if the task has
_TIF_SYSCALL_DOTRACE set, it will hit do_syscall_trace_enter() at syscall
entrance and do_syscall_trace_leave() at syscall leave.
do_syscall_trace_enter() needs to handle the TIF_SYSCALL_EMU flag properly,
which will interrupt the syscall executing if TIF_SYSCALL_EMU is set. The
output values should not be changed, i.e. the return value (r3) should
contain the original syscall argument on exit.

With this flag set, the syscall is not executed fundamentally, because
do_syscall_trace_enter() is returning -1 which is bigger than NR_syscall,
thus, skipping the syscall execution and exiting userspace.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/thread_info.h |  4 +++-
 arch/powerpc/include/uapi/asm/ptrace.h |  4 ++++
 arch/powerpc/kernel/ptrace.c           | 11 +++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1a52e14ec3ee..3185f8ac1182 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -81,6 +81,7 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_FSCHECK		3	/* Check FS is USER_DS on return */
+#define TIF_SYSCALL_EMU		4	/* syscall emulation active */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
@@ -120,9 +121,10 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)
 #define _TIF_FSCHECK		(1<<TIF_FSCHECK)
+#define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
-				 _TIF_NOHZ)
+				 _TIF_NOHZ | _TIF_SYSCALL_EMU)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 5e3edc2a7634..55c7a131d2ab 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -160,6 +160,10 @@ struct pt_regs {
 #define PTRACE_GETVSRREGS	0x1b
 #define PTRACE_SETVSRREGS	0x1c
 
+/* Syscall emulation defines */
+#define PTRACE_SYSEMU			0x1d
+#define PTRACE_SYSEMU_SINGLESTEP	0x1e
+
 /*
  * Get or set a debug register. The first 16 are DABR registers and the
  * second 16 are IABR registers.
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9667666eb18e..4e372f54088f 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -2508,6 +2508,7 @@ void ptrace_disable(struct task_struct *child)
 {
 	/* make sure the single step bit is not set. */
 	user_disable_single_step(child);
+	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 }
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
@@ -3264,6 +3265,16 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	user_exit();
 
+	if (test_thread_flag(TIF_SYSCALL_EMU)) {
+		ptrace_report_syscall(regs);
+		/*
+		 * Returning -1 will skip the syscall execution. We want to
+		 * avoid clobbering any register also, thus, not 'gotoing'
+		 * skip label.
+		 */
+		return -1;
+	}
+
 	/*
 	 * The tracer may decide to abort the syscall, if so tracehook
 	 * will return !0. Note that the tracer may also just change
-- 
2.19.0
