Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CFE3EDDF40
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 17:06:00 +1000 (EST)
Date: Thu, 26 Jun 2008 02:05:48 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/booke: Add kprobes support for booke style
	processors
Message-ID: <Pine.LNX.4.64.0806260204220.13731@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: madhvesh.s@ap.sony.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is based on work done by Madhvesh. R. Sulibhavi back in
March 2007.

We refactor some of the single step handling since it differs between
"classic" and "booke" powerpc cores.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 Documentation/kprobes.txt     |    1 +
 arch/powerpc/kernel/kprobes.c |   25 +++++++++++++++++++------
 arch/powerpc/kernel/traps.c   |   26 +++++++++++++++++---------
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 6877e71..a79633d 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -172,6 +172,7 @@ architectures:
 - ia64 (Does not support probes on instruction slot1.)
 - sparc64 (Return probes not yet implemented.)
 - arm
+- ppc

 3. Configuring Kprobes

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 74693d9..4ba2af1 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -34,6 +34,13 @@
 #include <asm/cacheflush.h>
 #include <asm/sstep.h>
 #include <asm/uaccess.h>
+#include <asm/system.h>
+
+#ifdef CONFIG_BOOKE
+#define MSR_SINGLESTEP	(MSR_DE)
+#else
+#define MSR_SINGLESTEP	(MSR_SE)
+#endif

 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
@@ -53,7 +60,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		ret = -EINVAL;
 	}

-	/* insn must be on a special executable page on ppc64 */
+	/* insn must be on a special executable page on ppc64.  This is
+	 * not explicitly required on ppc32 (right now), but it doesn't hurt */
 	if (!ret) {
 		p->ainsn.insn = get_insn_slot();
 		if (!p->ainsn.insn)
@@ -100,7 +108,11 @@ static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 	 * possible we'd get the single step reported for an exception handler
 	 * like Decrementer or External Interrupt */
 	regs->msr &= ~MSR_EE;
-	regs->msr |= MSR_SE;
+	regs->msr |= MSR_SINGLESTEP;
+#ifdef CONFIG_BOOKE
+	regs->msr &= ~MSR_CE;
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#endif

 	/*
 	 * On powerpc we should single step on the original
@@ -163,7 +175,8 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			kprobe_opcode_t insn = *p->ainsn.insn;
 			if (kcb->kprobe_status == KPROBE_HIT_SS &&
 					is_trap(insn)) {
-				regs->msr &= ~MSR_SE;
+				/* Turn off 'trace' bits */
+				regs->msr &= ~MSR_SINGLESTEP;
 				regs->msr |= kcb->kprobe_saved_msr;
 				goto no_kprobe;
 			}
@@ -404,10 +417,10 @@ out:

 	/*
 	 * if somebody else is singlestepping across a probe point, msr
-	 * will have SE set, in which case, continue the remaining processing
+	 * will have DE/SE set, in which case, continue the remaining processing
 	 * of do_debug, as if this is not a probe hit.
 	 */
-	if (regs->msr & MSR_SE)
+	if (regs->msr & MSR_SINGLESTEP)
 		return 0;

 	return 1;
@@ -430,7 +443,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * normal page fault.
 		 */
 		regs->nip = (unsigned long)cur->addr;
-		regs->msr &= ~MSR_SE;
+		regs->msr &= ~MSR_SINGLESTEP; /* Turn off 'trace' bits */
 		regs->msr |= kcb->kprobe_saved_msr;
 		if (kcb->kprobe_status == KPROBE_REENTER)
 			restore_previous_kprobe(kcb);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4b5b7ff..b463d48 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1030,21 +1030,29 @@ void SoftwareEmulation(struct pt_regs *regs)

 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)

-void DebugException(struct pt_regs *regs, unsigned long debug_status)
+void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
 	if (debug_status & DBSR_IC) {	/* instruction completion */
 		regs->msr &= ~MSR_DE;
+
+		/* Disable instruction completion */
+		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
+		/* Clear the instruction completion event */
+		mtspr(SPRN_DBSR, DBSR_IC);
+
+		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
+			       5, SIGTRAP) == NOTIFY_STOP) {
+			return;
+		}
+
+		if (debugger_sstep(regs))
+			return;
+
 		if (user_mode(regs)) {
 			current->thread.dbcr0 &= ~DBCR0_IC;
-		} else {
-			/* Disable instruction completion */
-			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
-			/* Clear the instruction completion event */
-			mtspr(SPRN_DBSR, DBSR_IC);
-			if (debugger_sstep(regs))
-				return;
 		}
-		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
+
+		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
 	}
 }
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
-- 
1.5.5.1
