Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38FAB1A0905
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 15:57:48 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, linuxppc-dev@ozlabs.org,
 paulus@samba.org
Subject: [PATCH 5/5] powerpc/tm: Clarify get_tm_stackpointer() by renaming it
Date: Fri, 13 Nov 2015 15:57:32 +1100
Message-Id: <1447390652-28355-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1447390652-28355-1-git-send-email-mikey@neuling.org>
References: <1447390652-28355-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_tm_stackpointer() gets the userspace stack pointer which the
signal frame will be written from pt_regs.  To do this it performs a
tm_reclaim to access the checkpointed stack pointer.

Doing a tm_reclaim is an important operation which changes the machine
state.  Doing this in the wrong state or an attempt to do it twice it can
result in a TM Bad Thing exception.  Hence we should make it clearer
that this function is making this change.

This patch renames this function to make it clearer what's happening
when calling this function.  No functional change.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/signal.h | 2 +-
 arch/powerpc/kernel/process.c     | 2 +-
 arch/powerpc/kernel/signal.c      | 2 +-
 arch/powerpc/kernel/signal_32.c   | 6 ++++--
 arch/powerpc/kernel/signal_64.c   | 3 ++-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/signal.h b/arch/powerpc/include/asm/signal.h
index 9322c28..0139dc2 100644
--- a/arch/powerpc/include/asm/signal.h
+++ b/arch/powerpc/include/asm/signal.h
@@ -5,6 +5,6 @@
 #include <uapi/asm/signal.h>
 #include <uapi/asm/ptrace.h>
 
-extern unsigned long get_tm_stackpointer(struct pt_regs *regs);
+extern unsigned long get_tm_stackpointer_and_reclaim(struct pt_regs *regs);
 
 #endif /* _ASM_POWERPC_SIGNAL_H */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a1b41d1..264a39c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -555,7 +555,7 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	 * Use the current MSR TM suspended bit to track if we have
 	 * checkpointed state outstanding.
 	 * On signal delivery, we'd normally reclaim the checkpointed
-	 * state to obtain stack pointer (see:get_tm_stackpointer()).
+	 * state to obtain stack pointer (see:get_tm_stackpointer_and_reclaim()).
 	 * This will then directly return to userspace without going
 	 * through __switch_to(). However, if the stack frame is bad,
 	 * we need to exit this thread which calls __switch_to() which
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index cf8c7e4..b3de865 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -162,7 +162,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	user_enter();
 }
 
-unsigned long get_tm_stackpointer(struct pt_regs *regs)
+unsigned long get_tm_stackpointer_and_reclaim(struct pt_regs *regs)
 {
 	/* When in an active transaction that takes a signal, we need to be
 	 * careful with the stack.  It's possible that the stack has moved back
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 5b519c7..b2c3f8c 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1001,7 +1001,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
-	rt_sf = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
+	rt_sf = get_sigframe(ksig, get_tm_stackpointer_and_reclaim(regs),
+			     sizeof(*rt_sf), 1);
 	addr = rt_sf;
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
@@ -1424,7 +1425,8 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 	unsigned long tramp;
 
 	/* Set up Signal Frame */
-	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 1);
+	frame = get_sigframe(ksig, get_tm_stackpointer_and_reclaim(regs),
+			     sizeof(*frame), 1);
 	if (unlikely(frame == NULL))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index b320689..96264be 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -731,7 +731,8 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 	unsigned long newsp = 0;
 	long err = 0;
 
-	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 0);
+	frame = get_sigframe(ksig, get_tm_stackpointer_and_reclaim(regs),
+			     sizeof(*frame), 0);
 	if (unlikely(frame == NULL))
 		goto badframe;
 
-- 
2.5.0
