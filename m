Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: ratelimit users spamming kernel log buffer
Date: Fri, 14 Mar 2014 17:03:58 +1100
Message-ID: <17889.1394777038@ale.ozlabs.ibm.com>
Cc: michael@ellerman.id.au, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The facility unavailable exception can be triggered from userspace by
accessing PMU registers when EBB is not enabled.  This causes the
included pr_err() to run, hence spamming the kernel log buffer.

This avoids this by rate limiting these messages.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
We can bike shed the hell out of this one.  We could just remove it, or
we could put it under the control of show_unhandled_signals.

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e435bc0..7836de3f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1340,8 +1340,9 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
-	pr_err("%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
-	       hv ? "Hypervisor " : "", facility, regs->nip, regs->msr);
+	pr_err_ratelimited(
+		"%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
+		hv ? "Hypervisor " : "", facility, regs->nip, regs->msr);
 
 	if (user_mode(regs)) {
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
