Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41002C3csSzF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 01:57:39 +1000 (AEST)
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
Subject: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
Date: Tue,  5 Jun 2018 00:57:13 +0900
Message-Id: <152812783350.10068.4690566636762511152.stgit@devbox>
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

Don't call the ->break_handler() from the arm kprobes code,
because it was only used by jprobes which got removed.

This also makes skip_singlestep() a static function since
only ftrace-kprobe.c is using this function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/kprobes.h   |   10 ----------
 arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
 arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
 3 files changed, 14 insertions(+), 43 deletions(-)

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
index 1b316331c2d9..3869b0e5d5c7 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -26,8 +26,8 @@
 #include <linux/ftrace.h>
 
 static nokprobe_inline
-int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
-		      struct kprobe_ctlblk *kcb, unsigned long orig_nip)
+int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
+		    struct kprobe_ctlblk *kcb, unsigned long orig_nip)
 {
 	/*
 	 * Emulate singlestep (and also recover regs->nip)
@@ -44,16 +44,6 @@ int __skip_singlestep(struct kprobe *p, struct pt_regs *regs,
 	return 1;
 }
 
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
@@ -82,7 +72,7 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 		if (!p->pre_handler || !p->pre_handler(p, regs))
-			__skip_singlestep(p, regs, kcb, orig_nip);
+			skip_singlestep(p, regs, kcb, orig_nip);
 		else {
 			/*
 			 * If pre_handler returns !0, it sets regs->nip and
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
 
