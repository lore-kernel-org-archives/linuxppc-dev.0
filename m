Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41sDV26jpYzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 16:55:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: muriloo@linux.ibm.com
Subject: [PATCH] powerpc/traps: Avoid rate limit messages from show unhandled
 signals
Date: Fri, 17 Aug 2018 16:55:00 +1000
Message-Id: <20180817065500.16899-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the recent commit to add an explicit ratelimit state when showing
unhandled signals, commit 35a52a10c3ac ("powerpc/traps: Use an
explicit ratelimit state for show_signal_msg()"), I put the check of
show_unhandled_signals and the ratelimit state before the call to
unhandled_signal() so as to avoid unnecessarily calling the latter
when show_unhandled_signals is false.

However that causes us to check the ratelimit state on every call, so
if we take a lot of *handled* signals that has the effect of making
the ratelimit code print warnings that callbacks have been suppressed
when they haven't.

So rearrange the code so that we check show_unhandled_signals first,
then call unhandled_signal() and finally check the ratelimit state.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/traps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 070e96f1773a..c85adb858271 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -315,22 +315,21 @@ void user_single_step_siginfo(struct task_struct *tsk,
 	info->si_addr = (void __user *)regs->nip;
 }
 
-static bool show_unhandled_signals_ratelimited(void)
+static void show_signal_msg(int signr, struct pt_regs *regs, int code,
+			    unsigned long addr)
 {
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
-	return show_unhandled_signals && __ratelimit(&rs);
-}
 
-static void show_signal_msg(int signr, struct pt_regs *regs, int code,
-			    unsigned long addr)
-{
-	if (!show_unhandled_signals_ratelimited())
+	if (!show_unhandled_signals)
 		return;
 
 	if (!unhandled_signal(current, signr))
 		return;
 
+	if (!__ratelimit(&rs))
+		return;
+
 	pr_info("%s[%d]: %s (%d) at %lx nip %lx lr %lx code %x",
 		current->comm, current->pid, signame(signr), signr,
 		addr, regs->nip, regs->link, code);
-- 
2.17.1
