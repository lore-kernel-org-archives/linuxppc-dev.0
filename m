Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/17] powerpc: Assembler routines for FP/VSX/VMX unavailable
 during a transaction
Date: Fri, 18 Jan 2013 16:48:31 +1100
Message-Id: <1358488117-17363-12-git-send-email-mikey@neuling.org>
In-Reply-To: <1358488117-17363-1-git-send-email-mikey@neuling.org>
References: <1358488117-17363-1-git-send-email-mikey@neuling.org>
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

We do lazy FP but not lazy TM (ie. userspace starts with MSR TM=1 FP=0).  Hence
if userspace does an FP instruction during a transaction, we'll take an
fp unavailable exception.

This adds functions needed to handle this case.  We have to inject the current
FP state into the checkpoint so that the hardware can decide what to do with
the transaction.  We can't inject only the FP so we have to do a full treclaim
and recheckpoint to inject just the FP state.  This will cause the transaction
to be marked as aborted by the hardware.

This just add the routines needed to do this for FP, VMX and VSX.  It doesn't
hook them into the rest of the code yet.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/traps.c |   95 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index dda0517..311770d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -58,6 +58,7 @@
 #include <asm/rio.h>
 #include <asm/fadump.h>
 #include <asm/switch_to.h>
+#include <asm/tm.h>
 #include <asm/debug.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
@@ -1192,6 +1193,100 @@ void tm_unavailable_exception(struct pt_regs *regs)
 	die("Unexpected TM unavailable exception", regs, SIGABRT);
 }
 
+#ifdef CONFIG_TRANSACTIONAL_MEM
+
+extern void do_load_up_fpu(struct pt_regs *regs);
+
+void fp_unavailable_tm(struct pt_regs *regs)
+{
+	/* Note:  This does not handle any kind of FP laziness. */
+
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
+	TM_DEBUG("FP Unavailable trap whilst transactional at 0x%lx, MSR=%lx\n",
+		 regs->nip, regs->msr);
+	tm_enable();
+
+        /* We can only have got here if the task started using FP after
+         * beginning the transaction.  So, the transactional regs are just a
+         * copy of the checkpointed ones.  But, we still need to recheckpoint
+         * as we're enabling FP for the process; it will return, abort the
+         * transaction, and probably retry but now with FP enabled.  So the
+         * checkpointed FP registers need to be loaded.
+	 */
+	tm_reclaim(&current->thread, current->thread.regs->msr,
+		   TM_CAUSE_FAC_UNAV);
+	/* Reclaim didn't save out any FPRs to transact_fprs. */
+
+	/* Enable FP for the task: */
+	regs->msr |= (MSR_FP | current->thread.fpexc_mode);
+
+	/* This loads and recheckpoints the FP registers from
+	 * thread.fpr[].  They will remain in registers after the
+	 * checkpoint so we don't need to reload them after.
+	 */
+	tm_recheckpoint(&current->thread, regs->msr);
+}
+
+#ifdef CONFIG_ALTIVEC
+extern void do_load_up_altivec(struct pt_regs *regs);
+
+void altivec_unavailable_tm(struct pt_regs *regs)
+{
+	/* See the comments in fp_unavailable_tm().  This function operates
+	 * the same way.
+	 */
+
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
+	TM_DEBUG("Vector Unavailable trap whilst transactional at 0x%lx,"
+		 "MSR=%lx\n",
+		 regs->nip, regs->msr);
+	tm_enable();
+	tm_reclaim(&current->thread, current->thread.regs->msr,
+		   TM_CAUSE_FAC_UNAV);
+	regs->msr |= MSR_VEC;
+	tm_recheckpoint(&current->thread, regs->msr);
+	current->thread.used_vr = 1;
+}
+#endif
+
+#ifdef CONFIG_VSX
+void vsx_unavailable_tm(struct pt_regs *regs)
+{
+	/* See the comments in fp_unavailable_tm().  This works similarly,
+	 * though we're loading both FP and VEC registers in here.
+	 *
+	 * If FP isn't in use, load FP regs.  If VEC isn't in use, load VEC
+	 * regs.  Either way, set MSR_VSX.
+	 */
+
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
+	TM_DEBUG("VSX Unavailable trap whilst transactional at 0x%lx,"
+		 "MSR=%lx\n",
+		 regs->nip, regs->msr);
+
+	tm_enable();
+	/* This reclaims FP and/or VR regs if they're already enabled */
+	tm_reclaim(&current->thread, current->thread.regs->msr,
+		   TM_CAUSE_FAC_UNAV);
+
+	regs->msr |= MSR_VEC | MSR_FP | current->thread.fpexc_mode |
+		MSR_VSX;
+	/* This loads & recheckpoints FP and VRs. */
+	tm_recheckpoint(&current->thread, regs->msr);
+	current->thread.used_vsr = 1;
+}
+#endif
+#endif /* CONFIG_TRANSACTIONAL_MEM */
+
 void performance_monitor_exception(struct pt_regs *regs)
 {
 	__get_cpu_var(irq_stat).pmu_irqs++;
-- 
1.7.10.4
