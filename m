Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B46ACDDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 15:31:41 +1000 (EST)
Date: Tue, 3 Jun 2008 00:30:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: [RFC] Kprobes for book-e
Message-ID: <Pine.LNX.4.64.0806030027340.27857@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: madhvesh.s@ap.sony.com, rsmadhvesh@vsnl.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a patch that adds kprobes support for book-e style debug.  Its
based on the patch posted by Madhvesh and assumes the exception cleanup
that I've already posted.

Post to get any feedback.  The code needs some cleaning up but wanted to
see if there were any initial comments.

- k

---
 arch/powerpc/kernel/kprobes.c |   35 +++++++++++++++++++++++++++++++----
 arch/powerpc/kernel/misc_32.S |    2 +-
 arch/powerpc/kernel/traps.c   |   26 +++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 23545a2..2c9940c 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -35,6 +35,21 @@
 #include <asm/sstep.h>
 #include <asm/uaccess.h>

+
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#define single_stepping(regs)	(current->thread.dbcr0 & DBCR0_IC)
+#define clear_single_step(regs)	(current->thread.dbcr0 &= ~DBCR0_IC)
+#else
+#define single_stepping(regs)	((regs)->msr & MSR_SE)
+#define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
+#endif
+
+#ifdef CONFIG_BOOKE
+#define MSR_SINGLESTEP	(MSR_DE)
+#else
+#define MSR_SINGLESTEP	(MSR_SE)
+#endif
+
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);

@@ -53,7 +68,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		ret = -EINVAL;
 	}

-	/* insn must be on a special executable page on ppc64 */
+	/* insn must be on a special executable page on ppc64.  This is
+	 * explicitly required on ppc32 (right now), but it doesn't hurt */
 	if (!ret) {
 		p->ainsn.insn = get_insn_slot();
 		if (!p->ainsn.insn)
@@ -95,7 +111,14 @@ void __kprobes arch_remove_kprobe(struct kprobe *p)

 static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 {
+#ifdef CONFIG_BOOKE
+	regs->msr &= ~(MSR_EE); /* Turn off 'Externel Interrupt' bits */
+	regs->msr &= ~(MSR_CE); /* Turn off 'Critical Interrupt' bits */
+	regs->msr |= MSR_DE;
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#else
 	regs->msr |= MSR_SE;
+#endif

 	/*
 	 * On powerpc we should single step on the original
@@ -124,6 +147,10 @@ static void __kprobes set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
 				struct kprobe_ctlblk *kcb)
 {
 	__get_cpu_var(current_kprobe) = p;
+#ifdef CONFIG_BOOKE
+	regs->msr |= (MSR_EE); /* Turn on 'External Interrupt' bits */
+	regs->msr |= (MSR_CE); /* Turn on 'Critical Interrupt' bits */
+#endif
 	kcb->kprobe_saved_msr = regs->msr;
 }

@@ -158,7 +185,7 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			kprobe_opcode_t insn = *p->ainsn.insn;
 			if (kcb->kprobe_status == KPROBE_HIT_SS &&
 					is_trap(insn)) {
-				regs->msr &= ~MSR_SE;
+				regs->msr &= ~MSR_SINGLESTEP; /* Turn off 'trace' bits */
 				regs->msr |= kcb->kprobe_saved_msr;
 				goto no_kprobe;
 			}
@@ -398,7 +425,7 @@ out:
 	 * will have SE set, in which case, continue the remaining processing
 	 * of do_debug, as if this is not a probe hit.
 	 */
-	if (regs->msr & MSR_SE)
+	if (single_stepping(regs))
 		return 0;

 	return 1;
@@ -421,7 +448,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * normal page fault.
 		 */
 		regs->nip = (unsigned long)cur->addr;
-		regs->msr &= ~MSR_SE;
+		regs->msr &= ~MSR_SINGLESTEP; /* Turn off 'trace' bits */
 		regs->msr |= kcb->kprobe_saved_msr;
 		if (kcb->kprobe_status == KPROBE_REENTER)
 			restore_previous_kprobe(kcb);
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 89aaaa6..6321ae3 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -489,7 +489,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
  *
  * flush_icache_range(unsigned long start, unsigned long stop)
  */
-_GLOBAL(__flush_icache_range)
+_KPROBE(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
 END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4b5b7ff..dc97207 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1030,10 +1030,34 @@ void SoftwareEmulation(struct pt_regs *regs)

 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)

-void DebugException(struct pt_regs *regs, unsigned long debug_status)
+void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 {
 	if (debug_status & DBSR_IC) {	/* instruction completion */
 		regs->msr &= ~MSR_DE;
+
+#ifdef CONFIG_KPROBES
+		/* Disable instruction completion */
+		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
+		/* Clear the instruction completion event */
+		mtspr(SPRN_DBSR, DBSR_IC);
+
+		/*
+		 * On Book E and perhaps other processsors, singlestep is
+		 * handled on the critical exception stack.  This causes
+		 * current_thread_info() to fail, since it locates the
+		 * thread_info by masking off the low bits of the current
+		 * stack pointer.  We work around this issue by copying
+		 * the thread_info from the kernel stack before calling
+		 * kprobe_post_handler, and copying it back afterwards.
+		 * On most processors the copy is avoided since
+		 * exception_thread_info == thread_info.
+		 */
+		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
+			       5, SIGTRAP) == NOTIFY_STOP) {
+			return;
+		}
+#endif
+
 		if (user_mode(regs)) {
 			current->thread.dbcr0 &= ~DBCR0_IC;
 		} else {
-- 
1.5.4.5
