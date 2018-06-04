Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zzw33l2zzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 01:52:19 +1000 (AEST)
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH -tip v5 07/27] powerpc/kprobes: Remove jprobe powerpc
 implementation
Date: Tue,  5 Jun 2018 00:51:53 +0900
Message-Id: <152812751377.10068.6090934299713110701.stgit@devbox>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/powerpc. This also reverts commits
related __is_active_jprobe() function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/kprobes.h             |    2 -
 arch/powerpc/kernel/kprobes-ftrace.c           |   15 -------
 arch/powerpc/kernel/kprobes.c                  |   54 ------------------------
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 ++---------------
 4 files changed, 5 insertions(+), 105 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 9f3be5c8a4a3..674036db558b 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -88,7 +88,6 @@ struct prev_kprobe {
 struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_saved_msr;
-	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
 };
 
@@ -104,7 +103,6 @@ extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
 #ifdef CONFIG_KPROBES_ON_FTRACE
-extern int __is_active_jprobe(unsigned long addr);
 extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 			   struct kprobe_ctlblk *kcb);
 #else
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 7a1f99f1b47f..1b316331c2d9 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -25,21 +25,6 @@
 #include <linux/preempt.h>
 #include <linux/ftrace.h>
 
-/*
- * This is called from ftrace code after invoking registered handlers to
- * disambiguate regs->nip changes done by jprobes and livepatch. We check if
- * there is an active jprobe at the provided address (mcount location).
- */
-int __is_active_jprobe(unsigned long addr)
-{
-	if (!preemptible()) {
-		struct kprobe *p = raw_cpu_read(current_kprobe);
-		return (p && (unsigned long)p->addr == addr) ? 1 : 0;
-	}
-
-	return 0;
-}
-
 static nokprobe_inline
 int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index e4c5bf33970b..600678fce0a8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -611,60 +611,6 @@ unsigned long arch_deref_entry_point(void *entry)
 }
 NOKPROBE_SYMBOL(arch_deref_entry_point);
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	memcpy(&kcb->jprobe_saved_regs, regs, sizeof(struct pt_regs));
-
-	/* setup return addr to the jprobe handler routine */
-	regs->nip = arch_deref_entry_point(jp->entry);
-#ifdef PPC64_ELF_ABI_v2
-	regs->gpr[12] = (unsigned long)jp->entry;
-#elif defined(PPC64_ELF_ABI_v1)
-	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
-#endif
-
-	/*
-	 * jprobes use jprobe_return() which skips the normal return
-	 * path of the function, and this messes up the accounting of the
-	 * function graph tracer.
-	 *
-	 * Pause function graph tracing while performing the jprobe function.
-	 */
-	pause_graph_tracing();
-
-	return 1;
-}
-NOKPROBE_SYMBOL(setjmp_pre_handler);
-
-void __used jprobe_return(void)
-{
-	asm volatile("jprobe_return_trap:\n"
-		     "trap\n"
-		     ::: "memory");
-}
-NOKPROBE_SYMBOL(jprobe_return);
-
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
-		pr_debug("longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
-				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
-		return 0;
-	}
-
-	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
-	/* It's OK to start function graph tracing again */
-	unpause_graph_tracing();
-	preempt_enable_no_resched();
-	return 1;
-}
-NOKPROBE_SYMBOL(longjmp_break_handler);
-
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
 	.pre_handler = trampoline_probe_handler
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 3f3e81852422..4e84a713e80a 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -99,39 +99,13 @@ ftrace_call:
 	bl	ftrace_stub
 	nop
 
-	/* Load the possibly modified NIP */
-	ld	r15, _NIP(r1)
-
+	/* Load ctr with the possibly modified NIP */
+	ld	r3, _NIP(r1)
+	mtctr	r3
 #ifdef CONFIG_LIVEPATCH
-	cmpd	r14, r15	/* has NIP been altered? */
+	cmpd	r14, r3		/* has NIP been altered? */
 #endif
 
-#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_KPROBES_ON_FTRACE)
-	/* NIP has not been altered, skip over further checks */
-	beq	1f
-
-	/* Check if there is an active jprobe on us */
-	subi	r3, r14, 4
-	bl	__is_active_jprobe
-	nop
-
-	/*
-	 * If r3 == 1, then this is a kprobe/jprobe.
-	 * else, this is livepatched function.
-	 *
-	 * The conditional branch for livepatch_handler below will use the
-	 * result of this comparison. For kprobe/jprobe, we just need to branch to
-	 * the new NIP, not call livepatch_handler. The branch below is bne, so we
-	 * want CR0[EQ] to be true if this is a kprobe/jprobe. Which means we want
-	 * CR0[EQ] = (r3 == 1).
-	 */
-	cmpdi	r3, 1
-1:
-#endif
-
-	/* Load CTR with the possibly modified NIP */
-	mtctr	r15
-
 	/* Restore gprs */
 	REST_GPR(0,r1)
 	REST_10GPRS(2,r1)
@@ -149,10 +123,7 @@ ftrace_call:
 	addi r1, r1, SWITCH_FRAME_SIZE
 
 #ifdef CONFIG_LIVEPATCH
-        /*
-	 * Based on the cmpd or cmpdi above, if the NIP was altered and we're
-	 * not on a kprobe/jprobe, then handle livepatch.
-	 */
+        /* Based on the cmpd above, if the NIP was altered handle livepatch */
 	bne-	livepatch_handler
 #endif
 
