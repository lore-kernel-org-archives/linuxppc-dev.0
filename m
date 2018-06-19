Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419CgJ6V8nzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 02:13:16 +1000 (AEST)
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
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH -tip v6 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in powerpc kprobes code
Date: Wed, 20 Jun 2018 01:12:51 +0900
Message-Id: <152942477127.15209.8982613703787878618.stgit@devbox>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
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

Don't call the ->break_handler() from the powerpc kprobes code,
because it was only used by jprobes which got removed.

This also removes skip_singlestep() and embeds it in the
caller, kprobe_ftrace_handler(), which simplifies regs->nip
operation around there.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 Changes in v6
   - Fix patch description
   - Move post handler emulation into kprobe_ftrace_handler().
---
 arch/powerpc/include/asm/kprobes.h   |   10 -------
 arch/powerpc/kernel/kprobes-ftrace.c |   46 +++++++++-------------------------
 arch/powerpc/kernel/kprobes.c        |   31 ++++++++---------------
 3 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index 674036db558b..785c464b6588 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -102,16 +102,6 @@ extern int kprobe_exceptions_notify(struct notifier_block *self,
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
-#ifdef CONFIG_KPROBES_ON_FTRACE
-extern int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-			   struct kprobe_ctlblk *kcb);
-#else
-static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-				  struct kprobe_ctlblk *kcb)
-{
-	return 0;
-}
-#endif
 #else
 static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
 static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 1b316331c2d9..070d1d862444 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -25,35 +25,6 @@
 #include <linux/preempt.h>
 #include <linux/ftrace.h>
 
-static nokprobe_inline
-int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
-{
-	/*
-	 * Emulate singlestep (and also recover regs->nip)
-	 * as if there is a nop
-	 */
-	regs->nip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
-	if (unlikely(p->post_handler)) {
-		kcb->kprobe_status = KPROBE_HIT_SSDONE;
-		p->post_handler(p, regs, 0);
-	}
-	__this_cpu_write(current_kprobe, NULL);
-	if (orig_nip)
-		regs->nip = orig_nip;
-	return 1;
-}
-
-int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		    struct kprobe_ctlblk *kcb)
-{
-	if (kprobe_ftrace(p))
-		return __skip_singlestep(p, regs, kcb, 0);
-	else
-		return 0;
-}
-NOKPROBE_SYMBOL(skip_singlestep);
-
 /* Ftrace callback handler for kprobes */
 void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
@@ -71,8 +42,6 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
 	} else {
-		unsigned long orig_nip = regs->nip;
-
 		/*
 		 * On powerpc, NIP is *before* this instruction for the
 		 * pre handler
@@ -81,9 +50,18 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-		if (!p->pre_handler || !p->pre_handler(p, regs))
-			__skip_singlestep(p, regs, kcb, orig_nip);
-		else {
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 * Emulate singlestep (and also recover regs->nip)
+			 * as if there is a nop
+			 */
+			regs->nip += MCOUNT_INSN_SIZE;
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			__this_cpu_write(current_kprobe, NULL);
+		} else {
 			/*
 			 * If pre_handler returns !0, it sets regs->nip and
 			 * resets current kprobe. In this case, we should not
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 600678fce0a8..f06747e2e70d 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -317,25 +317,17 @@ int kprobe_handler(struct pt_regs *regs)
 			}
 			prepare_singlestep(p, regs);
 			return 1;
-		} else {
-			if (*addr != BREAKPOINT_INSTRUCTION) {
-				/* If trap variant, then it belongs not to us */
-				kprobe_opcode_t cur_insn = *addr;
-				if (is_trap(cur_insn))
-		       			goto no_kprobe;
-				/* The breakpoint instruction was removed by
-				 * another cpu right after we hit, no further
-				 * handling of this interrupt is appropriate
-				 */
-				ret = 1;
+		} else if (*addr != BREAKPOINT_INSTRUCTION) {
+			/* If trap variant, then it belongs not to us */
+			kprobe_opcode_t cur_insn = *addr;
+
+			if (is_trap(cur_insn))
 				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				if (!skip_singlestep(p, regs, kcb))
-					goto ss_probe;
-				ret = 1;
-			}
+			/* The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -350,7 +342,7 @@ int kprobe_handler(struct pt_regs *regs)
 			 */
 			kprobe_opcode_t cur_insn = *addr;
 			if (is_trap(cur_insn))
-		       		goto no_kprobe;
+				goto no_kprobe;
 			/*
 			 * The breakpoint instruction was removed right
 			 * after we hit it.  Another cpu has removed
@@ -370,7 +362,6 @@ int kprobe_handler(struct pt_regs *regs)
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
-ss_probe:
 	if (p->ainsn.boostable >= 0) {
 		ret = try_to_emulate(p, regs);
 
