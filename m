Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 128772C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 08:11:20 +1000 (EST)
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [RFC][PATCH 1/2] powerpc/booke: extend PTRACE_SINGLEBLOCK for BookE
 Branch Taken Debug
Date: Fri, 5 Jul 2013 17:11:04 -0500
Message-ID: <1373062265-4267-2-git-send-email-James.Yang@freescale.com>
In-Reply-To: <1373062265-4267-1-git-send-email-James.Yang@freescale.com>
References: <1373062265-4267-1-git-send-email-James.Yang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: James Yang <James.Yang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A BookE branch taken debug exception followed by a single step does not
accurately simulate Server's branch execute debug exception.  BookE's
branch taken debug exception stops before the branch is to be executed
and only happens if the branch will actually be taken.  Server's branch
execute trace exception stops on the instruction after the branch
executes, regardless of whether or not the branch redirected the program
counter.

The existing PTRACE_SINGLEBLOCK support for BookE hardcodes a single
step after the branch taken exception is taken in order to simulate
Server's behavior, but this misses fall-through branch instructions
(i.e., branches that are NOT taken).  Also, the si_code became masked as
TRAP_TRACE instead of TRAP_BRANCH.

This patch makes available the unmodified BookE branch taken debug
exception through PTRACE_SINGLEBLOCK if the ptrace() addr parameter is
set to 2.  (The existing behavior of PTRACE_SINGLEBLOCK is retained for
any other addr parameter value, e.g., 0.)  SIGTRAP will be signaled with
the NIP pointing to the branch instruction before it has executed.  The
ptrace-calling program can then examine the program state.  It should
then request a PTRACE_SINGLESTEP in order to advance the program to the
next instruction or a PTRACE_CONT to resume normal program execution.
The si_code now also reports TRAP_BRANCH.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/include/asm/thread_info.h |    3 ++
 arch/powerpc/kernel/traps.c            |   51 ++++++++++++++++++++++++-------
 kernel/ptrace.c                        |   13 ++++++--
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index ba7b197..ab7c257 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -107,6 +107,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
 						for stack store? */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
+#define TIF_BOOKE_SINGLEBLOCK	18	/* Do not advance PC after Branch Taken
+					   debug exception for BookE */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -125,6 +127,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
+#define _TIF_BOOKE_SINGLEBLOCK	(1<<TIF_BOOKE_SINGLEBLOCK)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c3ceaa2..ee899b3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1518,11 +1518,14 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
 	current->thread.dbsr = debug_status;
 
-	/* Hack alert: On BookE, Branch Taken stops on the branch itself, while
-	 * on server, it stops on the target of the branch. In order to simulate
-	 * the server behaviour, we thus restart right away with a single step
-	 * instead of stopping here when hitting a BT
+	/* Hack alert: On BookE, Branch Taken stops on the branch itself iff the
+	 * branch will be taken, while on server, it stops on the target of the
+	 * branch, regardless of whether or not the branch was taken. In order
+	 * to simulate the server behaviour (at least for taken branches), we
+	 * thus restart right away with a single step instead of stopping here
+	 * when hitting a BT.
 	 */
+
 	if (debug_status & DBSR_BT) {
 		regs->msr &= ~MSR_DE;
 
@@ -1531,20 +1534,44 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 		/* Clear the BT event */
 		mtspr(SPRN_DBSR, DBSR_BT);
 
-		/* Do the single step trick only when coming from userspace */
-		if (user_mode(regs)) {
-			current->thread.dbcr0 &= ~DBCR0_BT;
-			current->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
-			regs->msr |= MSR_DE;
-			return;
-		}
-
 		if (notify_die(DIE_SSTEP, "block_step", regs, 5,
 			       5, SIGTRAP) == NOTIFY_STOP) {
 			return;
 		}
+
 		if (debugger_sstep(regs))
 			return;
+
+		if (user_mode(regs)) {
+
+			/* Do the single step trick only when coming from
+			 * userspace and if BOOKE SINGLEBLOCK mode is NOT
+			 * specified.
+			 */
+
+			if (test_thread_flag(TIF_BOOKE_SINGLEBLOCK)) {
+				current->thread.dbcr0 &= ~DBCR0_BT;
+				if (DBCR_ACTIVE_EVENTS(current->thread.dbcr0,
+							current->thread.dbcr1))
+					regs->msr |= MSR_DE;
+				else
+					/* Make sure the IDM bit is off */
+					current->thread.dbcr0 &= ~DBCR0_IDM;
+
+				_exception(SIGTRAP, regs, TRAP_BRANCH,
+					   regs->nip);
+			} else {
+				current->thread.dbcr0 &= ~DBCR0_BT;
+				current->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
+				regs->msr |= MSR_DE;
+
+				/* XXX: Is this the correct fix? */
+				mtmsr(mfmsr() & ~MSR_DE);
+				mtspr(SPRN_DBCR0, current->thread.dbcr0);
+			}
+			return;
+		}
+
 	} else if (debug_status & DBSR_IC) { 	/* Instruction complete */
 		regs->msr &= ~MSR_DE;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index aed981a..78db9f8 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -715,7 +715,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 #endif
 
 static int ptrace_resume(struct task_struct *child, long request,
-			 unsigned long data)
+			 unsigned long addr, unsigned long data)
 {
 	if (!valid_signal(data))
 		return -EIO;
@@ -736,6 +736,13 @@ static int ptrace_resume(struct task_struct *child, long request,
 		if (unlikely(!arch_has_block_step()))
 			return -EIO;
 		user_enable_block_step(child);
+#ifdef TIF_BOOKE_SINGLEBLOCK
+		if (addr == 2) {	/* 2 is arbitrary */
+			set_tsk_thread_flag(child, TIF_BOOKE_SINGLEBLOCK);
+		} else {
+			clear_tsk_thread_flag(child, TIF_BOOKE_SINGLEBLOCK);
+		}
+#endif
 	} else if (is_singlestep(request) || is_sysemu_singlestep(request)) {
 		if (unlikely(!arch_has_single_step()))
 			return -EIO;
@@ -937,12 +944,12 @@ int ptrace_request(struct task_struct *child, long request,
 #endif
 	case PTRACE_SYSCALL:
 	case PTRACE_CONT:
-		return ptrace_resume(child, request, data);
+		return ptrace_resume(child, request, addr, data);
 
 	case PTRACE_KILL:
 		if (child->exit_state)	/* already dead */
 			return 0;
-		return ptrace_resume(child, request, SIGKILL);
+		return ptrace_resume(child, request, addr, SIGKILL);
 
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	case PTRACE_GETREGSET:
-- 
1.7.0.4
