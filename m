Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/tm: Fix userspace stack corruption on signal
 delivery for active transactions
Date: Mon, 27 May 2013 14:09:41 +1000
Message-Id: <1369627781-31088-6-git-send-email-mikey@neuling.org>
In-Reply-To: <1369627781-31088-1-git-send-email-mikey@neuling.org>
References: <1369627781-31088-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When in an active transaction that takes a signal, we need to be careful with
the stack.  It's possible that the stack has moved back up after the tbegin.
The obvious case here is when the tbegin is called inside a function that
returns before a tend.  In this case, the stack is part of the checkpointed
transactional memory state.  If we write over this non transactionally or in
suspend, we are in trouble because if we get a tm abort, the program counter
and stack pointer will be back at the tbegin but our in memory stack won't be
valid anymore.

To avoid this, when taking a signal in an active transaction, we need to use
the stack pointer from the checkpointed state, rather than the speculated
state.  This ensures that the signal context (written tm suspended) will be
written below the stack required for the rollback.  The transaction is aborted
becuase of the treclaim, so any memory written between the tbegin and the
signal will be rolled back anyway.

For signals taken in non-TM or suspended mode, we use the
normal/non-checkpointed stack pointer.

Tested with 64 and 32 bit signals

Signed-off-by: Michael Neuling <mikey@neuling.org>
Cc: <stable@vger.kernel.org> # v3.9
---
 Documentation/powerpc/transactional_memory.txt |   19 +++++++++++
 arch/powerpc/include/asm/processor.h           |   13 +++-----
 arch/powerpc/include/asm/signal.h              |    3 ++
 arch/powerpc/kernel/signal.c                   |   40 ++++++++++++++++++++++--
 arch/powerpc/kernel/signal.h                   |    2 +-
 arch/powerpc/kernel/signal_32.c                |   10 ++----
 arch/powerpc/kernel/signal_64.c                |   23 +++++---------
 7 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/Documentation/powerpc/transactional_memory.txt b/Documentation/powerpc/transactional_memory.txt
index c54bf31..dc23e58 100644
--- a/Documentation/powerpc/transactional_memory.txt
+++ b/Documentation/powerpc/transactional_memory.txt
@@ -147,6 +147,25 @@ Example signal handler:
       fix_the_problem(ucp->dar);
     }
 
+When in an active transaction that takes a signal, we need to be careful with
+the stack.  It's possible that the stack has moved back up after the tbegin.
+The obvious case here is when the tbegin is called inside a function that
+returns before a tend.  In this case, the stack is part of the checkpointed
+transactional memory state.  If we write over this non transactionally or in
+suspend, we are in trouble because if we get a tm abort, the program counter and
+stack pointer will be back at the tbegin but our in memory stack won't be valid
+anymore.
+
+To avoid this, when taking a signal in an active transaction, we need to use
+the stack pointer from the checkpointed state, rather than the speculated
+state.  This ensures that the signal context (written tm suspended) will be
+written below the stack required for the rollback.  The transaction is aborted
+becuase of the treclaim, so any memory written between the tbegin and the
+signal will be rolled back anyway.
+
+For signals taken in non-TM or suspended mode, we use the
+normal/non-checkpointed stack pointer.
+
 
 Failure cause codes used by kernel
 ==================================
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 594db6b..14a6583 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -409,21 +409,16 @@ static inline void prefetchw(const void *x)
 #endif
 
 #ifdef CONFIG_PPC64
-static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
+static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
 {
-	unsigned long sp;
-
 	if (is_32)
-		sp = regs->gpr[1] & 0x0ffffffffUL;
-	else
-		sp = regs->gpr[1];
-
+		return sp & 0x0ffffffffUL;
 	return sp;
 }
 #else
-static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
+static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
 {
-	return regs->gpr[1];
+	return sp;
 }
 #endif
 
diff --git a/arch/powerpc/include/asm/signal.h b/arch/powerpc/include/asm/signal.h
index fbe66c4..9322c28 100644
--- a/arch/powerpc/include/asm/signal.h
+++ b/arch/powerpc/include/asm/signal.h
@@ -3,5 +3,8 @@
 
 #define __ARCH_HAS_SA_RESTORER
 #include <uapi/asm/signal.h>
+#include <uapi/asm/ptrace.h>
+
+extern unsigned long get_tm_stackpointer(struct pt_regs *regs);
 
 #endif /* _ASM_POWERPC_SIGNAL_H */
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 577a8aa..457e97a 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -18,6 +18,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/debug.h>
+#include <asm/tm.h>
 
 #include "signal.h"
 
@@ -30,13 +31,13 @@ int show_unhandled_signals = 1;
 /*
  * Allocate space for the signal frame
  */
-void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+void __user * get_sigframe(struct k_sigaction *ka, unsigned long sp,
 			   size_t frame_size, int is_32)
 {
         unsigned long oldsp, newsp;
 
         /* Default to using normal stack */
-        oldsp = get_clean_sp(regs, is_32);
+        oldsp = get_clean_sp(sp, is_32);
 
 	/* Check for alt stack */
 	if ((ka->sa.sa_flags & SA_ONSTACK) &&
@@ -175,3 +176,38 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 
 	user_enter();
 }
+
+unsigned long get_tm_stackpointer(struct pt_regs *regs)
+{
+	/* When in an active transaction that takes a signal, we need to be
+	 * careful with the stack.  It's possible that the stack has moved back
+	 * up after the tbegin.  The obvious case here is when the tbegin is
+	 * called inside a function that returns before a tend.  In this case,
+	 * the stack is part of the checkpointed transactional memory state.
+	 * If we write over this non transactionally or in suspend, we are in
+	 * trouble because if we get a tm abort, the program counter and stack
+	 * pointer will be back at the tbegin but our in memory stack won't be
+	 * valid anymore.
+	 *
+	 * To avoid this, when taking a signal in an active transaction, we
+	 * need to use the stack pointer from the checkpointed state, rather
+	 * than the speculated state.  This ensures that the signal context
+	 * (written tm suspended) will be written below the stack required for
+	 * the rollback.  The transaction is aborted becuase of the treclaim,
+	 * so any memory written between the tbegin and the signal will be
+	 * rolled back anyway.
+	 *
+	 * For signals taken in non-TM or suspended mode, we use the
+	 * normal/non-checkpointed stack pointer.
+	 */
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(regs->msr)) {
+		tm_enable();
+		tm_reclaim(&current->thread, regs->msr, TM_CAUSE_SIGNAL);
+		if (MSR_TM_TRANSACTIONAL(regs->msr))
+			return current->thread.ckpt_regs.gpr[1];
+	}
+#endif
+	return regs->gpr[1];
+}
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index ec84c90..c69b9ae 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -12,7 +12,7 @@
 
 extern void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags);
 
-extern void __user * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
+extern void __user * get_sigframe(struct k_sigaction *ka, unsigned long sp,
 				  size_t frame_size, int is_32);
 
 extern int handle_signal32(unsigned long sig, struct k_sigaction *ka,
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 95068bf..201385c 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -503,12 +503,6 @@ static int save_tm_user_regs(struct pt_regs *regs,
 {
 	unsigned long msr = regs->msr;
 
-	/* tm_reclaim rolls back all reg states, updating thread.ckpt_regs,
-	 * thread.transact_fpr[], thread.transact_vr[], etc.
-	 */
-	tm_enable();
-	tm_reclaim(&current->thread, msr, TM_CAUSE_SIGNAL);
-
 	/* Make sure floating point registers are stored in regs */
 	flush_fp_to_thread(current);
 
@@ -965,7 +959,7 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	rt_sf = get_sigframe(ka, regs, sizeof(*rt_sf), 1);
+	rt_sf = get_sigframe(ka, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
 	addr = rt_sf;
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
@@ -1403,7 +1397,7 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 	unsigned long tramp;
 
 	/* Set up Signal Frame */
-	frame = get_sigframe(ka, regs, sizeof(*frame), 1);
+	frame = get_sigframe(ka, get_tm_stackpointer(regs), sizeof(*frame), 1);
 	if (unlikely(frame == NULL))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c179428..3459473 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -154,11 +154,12 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
  * As above, but Transactional Memory is in use, so deliver sigcontexts
  * containing checkpointed and transactional register states.
  *
- * To do this, we treclaim to gather both sets of registers and set up the
- * 'normal' sigcontext registers with rolled-back register values such that a
- * simple signal handler sees a correct checkpointed register state.
- * If interested, a TM-aware sighandler can examine the transactional registers
- * in the 2nd sigcontext to determine the real origin of the signal.
+ * To do this, we treclaim (done before entering here) to gather both sets of
+ * registers and set up the 'normal' sigcontext registers with rolled-back
+ * register values such that a simple signal handler sees a correct
+ * checkpointed register state.  If interested, a TM-aware sighandler can
+ * examine the transactional registers in the 2nd sigcontext to determine the
+ * real origin of the signal.
  */
 static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 				 struct sigcontext __user *tm_sc,
@@ -184,16 +185,6 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 
 	BUG_ON(!MSR_TM_ACTIVE(regs->msr));
 
-	/* tm_reclaim rolls back all reg states, saving checkpointed (older)
-	 * GPRs to thread.ckpt_regs and (if used) FPRs to (newer)
-	 * thread.transact_fp and/or VRs to (newer) thread.transact_vr.
-	 * THEN we save out FP/VRs, if necessary, to the checkpointed (older)
-	 * thread.fr[]/vr[]s.  The transactional (newer) GPRs are on the
-	 * stack, in *regs.
-	 */
-	tm_enable();
-	tm_reclaim(&current->thread, msr, TM_CAUSE_SIGNAL);
-
 	flush_fp_to_thread(current);
 
 #ifdef CONFIG_ALTIVEC
@@ -711,7 +702,7 @@ int handle_rt_signal64(int signr, struct k_sigaction *ka, siginfo_t *info,
 	unsigned long newsp = 0;
 	long err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame), 0);
+	frame = get_sigframe(ka, get_tm_stackpointer(regs), sizeof(*frame), 0);
 	if (unlikely(frame == NULL))
 		goto badframe;
 
-- 
1.7.10.4
