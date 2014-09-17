Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0C451A0A62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 17:07:07 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 rostedt@goodmis.org
Subject: [PATCH 2/3] powerpc/ftrace: Remove mod_return_to_handler
Date: Wed, 17 Sep 2014 17:07:03 +1000
Message-Id: <1410937624-25140-2-git-send-email-anton@samba.org>
In-Reply-To: <1410937624-25140-1-git-send-email-anton@samba.org>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mod_return_to_handler is the same as return_to_handler, except
it handles the change of the TOC (r2). Add this into
return_to_handler and remove mod_return_to_handler.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_64.S | 24 +-----------------------
 arch/powerpc/kernel/ftrace.c   | 14 ++------------
 arch/powerpc/kernel/process.c  |  9 +--------
 3 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 5bbd1bc..955d509 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1235,28 +1235,6 @@ _GLOBAL(ftrace_graph_caller)
 
 _GLOBAL(return_to_handler)
 	/* need to save return values */
-	std	r4,  -24(r1)
-	std	r3,  -16(r1)
-	std	r31, -8(r1)
-	mr	r31, r1
-	stdu	r1, -112(r1)
-
-	bl	ftrace_return_to_handler
-	nop
-
-	/* return value has real return address */
-	mtlr	r3
-
-	ld	r1, 0(r1)
-	ld	r4,  -24(r1)
-	ld	r3,  -16(r1)
-	ld	r31, -8(r1)
-
-	/* Jump back to real return address */
-	blr
-
-_GLOBAL(mod_return_to_handler)
-	/* need to save return values */
 	std	r4,  -32(r1)
 	std	r3,  -24(r1)
 	/* save TOC */
@@ -1266,7 +1244,7 @@ _GLOBAL(mod_return_to_handler)
 	stdu	r1, -112(r1)
 
 	/*
-	 * We are in a module using the module's TOC.
+	 * We might be called from a module.
 	 * Switch to our TOC to run inside the core kernel.
 	 */
 	ld	r2, PACATOC(r13)
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 390311c..abf7921 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -510,10 +510,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 }
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
-#ifdef CONFIG_PPC64
-extern void mod_return_to_handler(void);
-#endif
-
 /*
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
@@ -523,7 +519,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 	unsigned long old;
 	int faulted;
 	struct ftrace_graph_ent trace;
-	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long return_hooker;
 
 	if (unlikely(ftrace_graph_is_dead()))
 		return;
@@ -531,13 +527,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-#ifdef CONFIG_PPC64
-	/* non core kernel code needs to save and restore the TOC */
-	if (REGION_ID(self_addr) != KERNEL_REGION_ID)
-		return_hooker = (unsigned long)&mod_return_to_handler;
-#endif
-
-	return_hooker = ppc_function_entry((void *)return_hooker);
+	return_hooker = ppc_function_entry(return_to_handler);
 
 	/*
 	 * Protect against fault, even if it shouldn't
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index aa1df89..080c0b9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1531,13 +1531,6 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	int curr_frame = current->curr_ret_stack;
 	extern void return_to_handler(void);
 	unsigned long rth = (unsigned long)return_to_handler;
-	unsigned long mrth = -1;
-#ifdef CONFIG_PPC64
-	extern void mod_return_to_handler(void);
-	rth = *(unsigned long *)rth;
-	mrth = (unsigned long)mod_return_to_handler;
-	mrth = *(unsigned long *)mrth;
-#endif
 #endif
 
 	sp = (unsigned long) stack;
@@ -1562,7 +1555,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		if (!firstframe || ip != lr) {
 			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-			if ((ip == rth || ip == mrth) && curr_frame >= 0) {
+			if ((ip == rth) && curr_frame >= 0) {
 				printk(" (%pS)",
 				       (void *)current->ret_stack[curr_frame].ret);
 				curr_frame--;
-- 
1.9.1
