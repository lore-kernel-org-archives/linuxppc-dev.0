Return-Path: <matt@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4090dC30qzzDrFR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:55:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4090dB0lq8z9s37
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:55:25 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [PATCH] powerpc: Clear branch trap (MSR.BE) before delivering SIGTRAP
Message-Id: <74EBF461-0D94-4C2D-ABA7-0B9BE010F173@ozlabs.org>
Date: Mon, 26 Mar 2018 17:55:21 +0100
To: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using SIG_DBG_BRANCH_TRACING, MSR.BE is left enabled in the
user context when single_step_exception() prepares the SIGTRAP
delivery.  The resulting branch-trap-within-the-SIGTRAP-handler
isn't healthy.

Commit 2538c2d08f46141550a1e68819efa8fe31c6e3dc broke this, by
replacing an MSR mask operation of ~(MSR_SE | MSR_BE) with a call
to clear_single_step() which only clears MSR_SE.

This patch adds a new helper, clear_br_trace(), which clears the
debug trap before invoking the signal handler.  This helper is a
NOP for BookE as SIG_DBG_BRANCH_TRACING isn't supported on BookE.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/kernel/traps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1e48d157196a..5eaab234e747 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -460,7 +460,7 @@ static inline int check_io_access(struct pt_regs *regs)
 /* single-step stuff */
 #define single_stepping(regs)	(current->thread.debug.dbcr0 & DBCR0_IC)
 #define clear_single_step(regs)	(current->thread.debug.dbcr0 &= ~DBCR0_IC)
-
+#define clear_br_trace(regs)	do {} while(0)
 #else
 /* On non-4xx, the reason for the machine check or program
    exception is in the MSR. */
@@ -473,6 +473,7 @@ static inline int check_io_access(struct pt_regs *regs)
 
 #define single_stepping(regs)	((regs)->msr & MSR_SE)
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
+#define clear_br_trace(regs)	((regs)->msr &= ~MSR_BE)
 #endif
 
 #if defined(CONFIG_E500)
@@ -988,6 +989,7 @@ void single_step_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 
 	clear_single_step(regs);
+	clear_br_trace(regs);
 
 	if (kprobe_post_handler(regs))
 		return;
-- 
2.14.1
