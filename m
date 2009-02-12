Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 9E8BADDDAC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 12:13:45 +1100 (EST)
Message-Id: <20090212011343.074329920@goodmis.org>
References: <20090212011051.265346435@goodmis.org>
Date: Wed, 11 Feb 2009 20:10:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7][RFC] powerpc64,
	tracing: add function graph tracer with dynamic tracing
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Steven Rostedt <srostedt@redhat.com>

This is the port of the function graph tracer to PowerPC with
dynamic tracing.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
---
 arch/powerpc/Kconfig           |    2 +-
 arch/powerpc/kernel/entry_64.S |    8 ++++++-
 arch/powerpc/kernel/ftrace.c   |   47 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ca4647e..6e1ee1b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -111,7 +111,7 @@ config PPC
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUNCTION_GRAPH_TRACER if !DYNAMIC_FTRACE && PPC64
+	select HAVE_FUNCTION_GRAPH_TRACER if PPC64
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index a32699e..9f61fd6 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -908,6 +908,12 @@ _GLOBAL(ftrace_caller)
 ftrace_call:
 	bl	ftrace_stub
 	nop
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+.globl ftrace_graph_call
+ftrace_graph_call:
+	b	ftrace_graph_stub
+_GLOBAL(ftrace_graph_stub)
+#endif
 	ld	r0, 128(r1)
 	mtlr	r0
 	addi	r1, r1, 112
@@ -946,7 +952,7 @@ _GLOBAL(ftrace_stub)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-ftrace_graph_caller:
+_GLOBAL(ftrace_graph_caller)
 	/* load r4 with local address */
 	ld	r4, 128(r1)
 	subi	r4, r4, MCOUNT_INSN_SIZE
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index c9b1547..7538b94 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -43,7 +43,8 @@ static unsigned char *ftrace_nop_replace(void)
 	return (char *)&ftrace_nop;
 }
 
-static unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
+static unsigned char *
+ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 {
 	static unsigned int op;
 
@@ -55,8 +56,9 @@ static unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	 */
 	addr = GET_ADDR(addr);
 
-	/* Set to "bl addr" */
-	op = 0x48000001 | (ftrace_calc_offset(ip, addr) & 0x03fffffc);
+	/* if (link) set op to 'bl' else 'b' */
+	op = 0x48000000 | (link ? 1 : 0);
+	op |= (ftrace_calc_offset(ip, addr) & 0x03fffffc);
 
 	/*
 	 * No locking needed, this must be called via kstop_machine
@@ -344,7 +346,7 @@ int ftrace_make_nop(struct module *mod,
 	 */
 	if (test_24bit_addr(ip, addr)) {
 		/* within range */
-		old = ftrace_call_replace(ip, addr);
+		old = ftrace_call_replace(ip, addr, 1);
 		new = ftrace_nop_replace();
 		return ftrace_modify_code(ip, old, new);
 	}
@@ -484,7 +486,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	if (test_24bit_addr(ip, addr)) {
 		/* within range */
 		old = ftrace_nop_replace();
-		new = ftrace_call_replace(ip, addr);
+		new = ftrace_call_replace(ip, addr, 1);
 		return ftrace_modify_code(ip, old, new);
 	}
 
@@ -513,7 +515,7 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	int ret;
 
 	memcpy(old, &ftrace_call, MCOUNT_INSN_SIZE);
-	new = ftrace_call_replace(ip, (unsigned long)func);
+	new = ftrace_call_replace(ip, (unsigned long)func, 1);
 	ret = ftrace_modify_code(ip, old, new);
 
 	return ret;
@@ -532,6 +534,39 @@ int __init ftrace_dyn_arch_init(void *data)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern void ftrace_graph_call(void);
+extern void ftrace_graph_stub(void);
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+	unsigned long addr = (unsigned long)(&ftrace_graph_caller);
+	unsigned long stub = (unsigned long)(&ftrace_graph_stub);
+	unsigned char old[MCOUNT_INSN_SIZE], *new;
+
+	new = ftrace_call_replace(ip, stub, 0);
+	memcpy(old, new, MCOUNT_INSN_SIZE);
+	new = ftrace_call_replace(ip, addr, 0);
+
+	return ftrace_modify_code(ip, old, new);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+	unsigned long addr = (unsigned long)(&ftrace_graph_caller);
+	unsigned long stub = (unsigned long)(&ftrace_graph_stub);
+	unsigned char old[MCOUNT_INSN_SIZE], *new;
+
+	new = ftrace_call_replace(ip, addr, 0);
+	memcpy(old, new, MCOUNT_INSN_SIZE);
+	new = ftrace_call_replace(ip, stub, 0);
+
+	return ftrace_modify_code(ip, old, new);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 /*
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
-- 
1.5.6.5

-- 
