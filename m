Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B862F1A0A72
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 17:07:09 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 rostedt@goodmis.org
Subject: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Date: Wed, 17 Sep 2014 17:07:04 +1000
Message-Id: <1410937624-25140-3-git-send-email-anton@samba.org>
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

Instead of passing in the stack address of the link register
to be modified, just pass in the old value and return the
new value and rely on ftrace_graph_caller to do the
modification.

This removes the exception handling around the stack update -
it isn't needed and we weren't consistent about it. Later on
we would do an unprotected modification:

       if (!ftrace_graph_entry(&trace)) {
               *parent = old;

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/entry_32.S | 10 +++++--
 arch/powerpc/kernel/entry_64.S | 11 ++++++--
 arch/powerpc/kernel/ftrace.c   | 59 ++++++++++--------------------------------
 3 files changed, 30 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 22b45a4..ad837d8 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1424,12 +1424,18 @@ _GLOBAL(ftrace_graph_caller)
 	lwz	r4, 44(r1)
 	subi	r4, r4, MCOUNT_INSN_SIZE
 
-	/* get the parent address */
-	addi	r3, r1, 52
+	/* Grab the LR out of the caller stack frame */
+	lwz	r3,52(r1)
 
 	bl	prepare_ftrace_return
 	nop
 
+        /*
+         * prepare_ftrace_return gives us the address we divert to.
+         * Change the LR in the callers stack frame to this.
+         */
+	stw	r3,52(r1)
+
 	MCOUNT_RESTORE_FRAME
 	/* old link register ends up in ctr reg */
 	bctr
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 955d509..9caab69 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1221,13 +1221,20 @@ _GLOBAL(ftrace_graph_caller)
 	ld	r4, 128(r1)
 	subi	r4, r4, MCOUNT_INSN_SIZE
 
-	/* get the parent address */
+	/* Grab the LR out of the caller stack frame */
 	ld	r11, 112(r1)
-	addi	r3, r11, 16
+	ld	r3, 16(r11)
 
 	bl	prepare_ftrace_return
 	nop
 
+	/*
+	 * prepare_ftrace_return gives us the address we divert to.
+	 * Change the LR in the callers stack frame to this.
+	 */
+	ld	r11, 112(r1)
+	std	r3, 16(r11)
+
 	ld	r0, 128(r1)
 	mtlr	r0
 	addi	r1, r1, 112
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index abf7921..d795031 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -512,67 +512,34 @@ int ftrace_disable_ftrace_graph_caller(void)
 
 /*
  * Hook the return address and push it in the stack of return addrs
- * in current thread info.
+ * in current thread info. Return the address we want to divert to.
  */
-void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
+unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 {
-	unsigned long old;
-	int faulted;
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker;
 
 	if (unlikely(ftrace_graph_is_dead()))
-		return;
+		goto out;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
-		return;
+		goto out;
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	/*
-	 * Protect against fault, even if it shouldn't
-	 * happen. This tool is too much intrusive to
-	 * ignore such a protection.
-	 */
-	asm volatile(
-		"1: " PPC_LL "%[old], 0(%[parent])\n"
-		"2: " PPC_STL "%[return_hooker], 0(%[parent])\n"
-		"   li %[faulted], 0\n"
-		"3:\n"
-
-		".section .fixup, \"ax\"\n"
-		"4: li %[faulted], 1\n"
-		"   b 3b\n"
-		".previous\n"
-
-		".section __ex_table,\"a\"\n"
-			PPC_LONG_ALIGN "\n"
-			PPC_LONG "1b,4b\n"
-			PPC_LONG "2b,4b\n"
-		".previous"
-
-		: [old] "=&r" (old), [faulted] "=r" (faulted)
-		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)
-		: "memory"
-	);
-
-	if (unlikely(faulted)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		return;
-	}
-
-	trace.func = self_addr;
+	trace.func = ip;
 	trace.depth = current->curr_ret_stack + 1;
 
 	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		*parent = old;
-		return;
-	}
+	if (!ftrace_graph_entry(&trace))
+		goto out;
+
+	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0) == -EBUSY)
+		goto out;
 
-	if (ftrace_push_return_trace(old, self_addr, &trace.depth, 0) == -EBUSY)
-		*parent = old;
+	parent = return_hooker;
+out:
+	return parent;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-- 
1.9.1
