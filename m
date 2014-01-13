Return-Path: <paulus@samba.org>
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc: Fix transactional FP/VMX/VSX unavailable handlers
Date: Mon, 13 Jan 2014 15:56:30 +1100
Message-Id: <1389588990-25953-4-git-send-email-paulus@samba.org>
In-Reply-To: <1389588990-25953-1-git-send-email-paulus@samba.org>
References: <1389588990-25953-1-git-send-email-paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, if a process starts a transaction and then takes an
exception because the FPU, VMX or VSX unit is unavailable to it,
we end up corrupting any FP/VMX/VSX state that was valid before
the interrupt.  For example, if the process starts a transaction
with the FPU available to it but VMX unavailable, and then does
a VMX instruction inside the transaction, the FP state gets
corrupted.

Loading up the desired state generally involves doing a reclaim
and a recheckpoint.  To avoid corrupting already-valid state, we have
to be careful not to reload that state from the thread_struct
between the reclaim and the recheckpoint (since the thread_struct
values are stale by now), and we have to reload that state from
the transact_fp/vr arrays after the recheckpoint to get back the
current transactional values saved there by the reclaim.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/traps.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b543587..50a7ec3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1401,11 +1401,19 @@ void fp_unavailable_tm(struct pt_regs *regs)
 	/* This loads and recheckpoints the FP registers from
 	 * thread.fpr[].  They will remain in registers after the
 	 * checkpoint so we don't need to reload them after.
+	 * If VMX is in use, the VRs now hold checkpointed values,
+	 * so we don't want to load the VRs from the thread_struct.
 	 */
-	tm_recheckpoint(&current->thread, regs->msr);
+	tm_recheckpoint(&current->thread, MSR_FP);
+
+	/* If VMX is in use, get the transactional values back */
+	if (regs->msr & MSR_VEC) {
+		do_load_up_transact_altivec(&current->thread);
+		/* At this point all the VSX state is loaded, so enable it */
+		regs->msr |= MSR_VSX;
+	}
 }
 
-#ifdef CONFIG_ALTIVEC
 void altivec_unavailable_tm(struct pt_regs *regs)
 {
 	/* See the comments in fp_unavailable_tm().  This function operates
@@ -1417,14 +1425,19 @@ void altivec_unavailable_tm(struct pt_regs *regs)
 		 regs->nip, regs->msr);
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
 	regs->msr |= MSR_VEC;
-	tm_recheckpoint(&current->thread, regs->msr);
+	tm_recheckpoint(&current->thread, MSR_VEC);
 	current->thread.used_vr = 1;
+
+	if (regs->msr & MSR_FP) {
+		do_load_up_transact_fpu(&current->thread);
+		regs->msr |= MSR_VSX;
+	}
 }
-#endif
 
-#ifdef CONFIG_VSX
 void vsx_unavailable_tm(struct pt_regs *regs)
 {
+	unsigned long orig_msr = regs->msr;
+
 	/* See the comments in fp_unavailable_tm().  This works similarly,
 	 * though we're loading both FP and VEC registers in here.
 	 *
@@ -1436,16 +1449,30 @@ void vsx_unavailable_tm(struct pt_regs *regs)
 		 "MSR=%lx\n",
 		 regs->nip, regs->msr);
 
+	current->thread.used_vsr = 1;
+
+	/* If FP and VMX are already loaded, we have all the state we need */
+	if ((orig_msr & (MSR_FP | MSR_VEC)) == (MSR_FP | MSR_VEC)) {
+		regs->msr |= MSR_VSX;
+		return;
+	}
+
 	/* This reclaims FP and/or VR regs if they're already enabled */
 	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
 
 	regs->msr |= MSR_VEC | MSR_FP | current->thread.fpexc_mode |
 		MSR_VSX;
-	/* This loads & recheckpoints FP and VRs. */
-	tm_recheckpoint(&current->thread, regs->msr);
-	current->thread.used_vsr = 1;
+
+	/* This loads & recheckpoints FP and VRs; but we have
+	 * to be sure not to overwrite previously-valid state.
+	 */
+	tm_recheckpoint(&current->thread, regs->msr & ~orig_msr);
+
+	if (orig_msr & MSR_FP)
+		do_load_up_transact_fpu(&current->thread);
+	if (orig_msr & MSR_VEC)
+		do_load_up_transact_altivec(&current->thread);
 }
-#endif
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 void performance_monitor_exception(struct pt_regs *regs)
-- 
1.8.4.2
