Return-Path: <ra8135@perf2farm5.am.freescale.net>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10C5E2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jul 2013 08:11:20 +1000 (EST)
From: James Yang <James.Yang@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [RFC][PATCH 2/2] powerpc/booke: revert PTRACE_SINGLEBLOCK to BookE
 behavior
Date: Fri, 5 Jul 2013 17:11:05 -0500
Message-ID: <1373062265-4267-3-git-send-email-James.Yang@freescale.com>
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

This patch provides native support for the BookE branch taken debug
exception's behavior:  PTRACE_SINGLEBLOCK stops with a SIGTRAP before a
branch-that-would-be-taken would execute.  Userspace software will be
able to examine the process state upon catching the SIGTRAP, and it
will need to issue a PTRACE_SINGLESTEP or PTRACE_CONT to resume program
execution past the branch.

Signed-off-by: James Yang <James.Yang@freescale.com>
---
 arch/powerpc/kernel/traps.c |   40 +++++++++++++++++++++++++++-------------
 1 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index c3ceaa2..5837d7f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1518,12 +1518,21 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
 	current->thread.dbsr = debug_status;
 
-	/* Hack alert: On BookE, Branch Taken stops on the branch itself, while
-	 * on server, it stops on the target of the branch. In order to simulate
-	 * the server behaviour, we thus restart right away with a single step
-	 * instead of stopping here when hitting a BT
+	/* BookE's Branch Taken Debug Exception stops on the branch iff the
+	 * branch is resolved to be taken.  No exception occurs if the branch
+	 * is not taken (no exception if the branch does not redirect the PC).
+	 * This is unlike Classic/Server's behavior where the exception occurs
+	 * after the branch executes, regardless of whether or not the branch
+	 * redirected the PC.
+	 *
+	 * The past behavior of this function was to simulate Classic/Server's
+	 * behavior by performing a single-step upon a branch taken exception.
+	 * However, the simulation is not accurate because fall-through non-
+	 * taken branches would not result in a SIGTRAP.  Also, that SIGTRAP's
+	 * si_code would be reported as a TRAP_TRACE instead of a TRAP_BRANCH.
 	 */
-	if (debug_status & DBSR_BT) {
+
+	if (debug_status & DBSR_BT) {	/* Branch Taken */
 		regs->msr &= ~MSR_DE;
 
 		/* Disable BT */
@@ -1531,20 +1540,25 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
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
+			current->thread.dbcr0 &= ~DBCR0_BT;
+			if (DBCR_ACTIVE_EVENTS(current->thread.dbcr0,
+					       current->thread.dbcr1))
+				regs->msr |= MSR_DE;
+			else
+				/* Make sure the IDM bit is off */
+				current->thread.dbcr0 &= ~DBCR0_IDM;
+		}
+
+		_exception(SIGTRAP, regs, TRAP_BRANCH, regs->nip);
 	} else if (debug_status & DBSR_IC) { 	/* Instruction complete */
 		regs->msr &= ~MSR_DE;
 
-- 
1.7.0.4
