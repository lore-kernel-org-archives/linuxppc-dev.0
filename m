Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 4F80CDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 06:15:49 +1100 (EST)
Date: Wed, 18 Feb 2009 14:15:42 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] for both tip and powerpc
Message-ID: <alpine.DEB.1.10.0902181408160.11411@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ingo and Benjamin,

As discussed, I made a branch called mainline/function-graph-tracer 
based off of Linus's commit:

commit d2f8d7ee1a9b4650b4e43325b321801264f7c37a
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Feb 13 15:31:30 2009 -0800

    Linux 2.6.29-rc5


and cherry picked the below change. I added Ingo's Acked-by as well. If 
both of you pull this change in (assuming both trees are already based 
off of Linus's 2.6.29-rc5) then there should be no conflicts when this 
gets merged back to Linus's tree.

I will not touch this branch again, until it is officially in mainline.

Please pull the latest mainline/function-graph tree, which can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
mainline/function-graph


Steven Rostedt (1):
      tracing/function-graph-tracer: make arch generic push pop functions

----
 arch/x86/include/asm/ftrace.h        |   25 -----------
 arch/x86/kernel/dumpstack.c          |    1 +
 arch/x86/kernel/ftrace.c             |   75 +---------------------------------
 include/linux/ftrace.h               |   24 +++++++++++
 kernel/trace/trace_functions_graph.c |   75 ++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 99 deletions(-)
---------------------------
commit 712406a6bf59ebf4a00358bb59a4a2a1b2953d90
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Mon Feb 9 10:54:03 2009 -0800

    tracing/function-graph-tracer: make arch generic push pop functions
    
    There is nothing really arch specific of the push and pop functions
    used by the function graph tracer. This patch moves them to generic
    code.
    
    Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
    Acked-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Steven Rostedt <srostedt@redhat.com>

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index b55b4a7..db24c22 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -55,29 +55,4 @@ struct dyn_arch_ftrace {
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-
-#ifndef __ASSEMBLY__
-
-/*
- * Stack of return addresses for functions
- * of a thread.
- * Used in struct thread_info
- */
-struct ftrace_ret_stack {
-	unsigned long ret;
-	unsigned long func;
-	unsigned long long calltime;
-};
-
-/*
- * Primary handler of a function return.
- * It relays on ftrace_return_to_handler.
- * Defined in entry_32/64.S
- */
-extern void return_to_handler(void);
-
-#endif /* __ASSEMBLY__ */
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-
 #endif /* _ASM_X86_FTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 6b1f6f6..c085229 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -10,6 +10,7 @@
 #include <linux/kdebug.h>
 #include <linux/module.h>
 #include <linux/ptrace.h>
+#include <linux/ftrace.h>
 #include <linux/kexec.h>
 #include <linux/bug.h>
 #include <linux/nmi.h>
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 231bdd3..76f7141 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -389,79 +389,6 @@ void ftrace_nmi_exit(void)
 
 #endif /* !CONFIG_DYNAMIC_FTRACE */
 
-/* Add a function return address to the trace stack on thread info.*/
-static int push_return_trace(unsigned long ret, unsigned long long time,
-				unsigned long func, int *depth)
-{
-	int index;
-
-	if (!current->ret_stack)
-		return -EBUSY;
-
-	/* The return trace stack is full */
-	if (current->curr_ret_stack == FTRACE_RETFUNC_DEPTH - 1) {
-		atomic_inc(&current->trace_overrun);
-		return -EBUSY;
-	}
-
-	index = ++current->curr_ret_stack;
-	barrier();
-	current->ret_stack[index].ret = ret;
-	current->ret_stack[index].func = func;
-	current->ret_stack[index].calltime = time;
-	*depth = index;
-
-	return 0;
-}
-
-/* Retrieve a function return address to the trace stack on thread info.*/
-static void pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret)
-{
-	int index;
-
-	index = current->curr_ret_stack;
-
-	if (unlikely(index < 0)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		/* Might as well panic, otherwise we have no where to go */
-		*ret = (unsigned long)panic;
-		return;
-	}
-
-	*ret = current->ret_stack[index].ret;
-	trace->func = current->ret_stack[index].func;
-	trace->calltime = current->ret_stack[index].calltime;
-	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = index;
-	barrier();
-	current->curr_ret_stack--;
-
-}
-
-/*
- * Send the trace to the ring-buffer.
- * @return the original return address.
- */
-unsigned long ftrace_return_to_handler(void)
-{
-	struct ftrace_graph_ret trace;
-	unsigned long ret;
-
-	pop_return_trace(&trace, &ret);
-	trace.rettime = cpu_clock(raw_smp_processor_id());
-	ftrace_graph_return(&trace);
-
-	if (unlikely(!ret)) {
-		ftrace_graph_stop();
-		WARN_ON(1);
-		/* Might as well panic. What else to do? */
-		ret = (unsigned long)panic;
-	}
-
-	return ret;
-}
-
 /*
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
@@ -521,7 +448,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 
 	calltime = cpu_clock(raw_smp_processor_id());
 
-	if (push_return_trace(old, calltime,
+	if (ftrace_push_return_trace(old, calltime,
 				self_addr, &trace.depth) == -EBUSY) {
 		*parent = old;
 		return;
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 677432b..a7f8134 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -380,6 +380,30 @@ struct ftrace_graph_ret {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 /*
+ * Stack of return addresses for functions
+ * of a thread.
+ * Used in struct thread_info
+ */
+struct ftrace_ret_stack {
+	unsigned long ret;
+	unsigned long func;
+	unsigned long long calltime;
+};
+
+/*
+ * Primary handler of a function return.
+ * It relays on ftrace_return_to_handler.
+ * Defined in entry_32/64.S
+ */
+extern void return_to_handler(void);
+
+extern int
+ftrace_push_return_trace(unsigned long ret, unsigned long long time,
+			 unsigned long func, int *depth);
+extern void
+ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret);
+
+/*
  * Sometimes we don't want to trace a function with the function
  * graph tracer but we want them to keep traced by the usual function
  * tracer if the function graph tracer is not configured.
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 930c08e..dce71a5 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -42,6 +42,81 @@ static struct tracer_flags tracer_flags = {
 /* pid on the last trace processed */
 static pid_t last_pid[NR_CPUS] = { [0 ... NR_CPUS-1] = -1 };
 
+/* Add a function return address to the trace stack on thread info.*/
+int
+ftrace_push_return_trace(unsigned long ret, unsigned long long time,
+			 unsigned long func, int *depth)
+{
+	int index;
+
+	if (!current->ret_stack)
+		return -EBUSY;
+
+	/* The return trace stack is full */
+	if (current->curr_ret_stack == FTRACE_RETFUNC_DEPTH - 1) {
+		atomic_inc(&current->trace_overrun);
+		return -EBUSY;
+	}
+
+	index = ++current->curr_ret_stack;
+	barrier();
+	current->ret_stack[index].ret = ret;
+	current->ret_stack[index].func = func;
+	current->ret_stack[index].calltime = time;
+	*depth = index;
+
+	return 0;
+}
+
+/* Retrieve a function return address to the trace stack on thread info.*/
+void
+ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret)
+{
+	int index;
+
+	index = current->curr_ret_stack;
+
+	if (unlikely(index < 0)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		/* Might as well panic, otherwise we have no where to go */
+		*ret = (unsigned long)panic;
+		return;
+	}
+
+	*ret = current->ret_stack[index].ret;
+	trace->func = current->ret_stack[index].func;
+	trace->calltime = current->ret_stack[index].calltime;
+	trace->overrun = atomic_read(&current->trace_overrun);
+	trace->depth = index;
+	barrier();
+	current->curr_ret_stack--;
+
+}
+
+/*
+ * Send the trace to the ring-buffer.
+ * @return the original return address.
+ */
+unsigned long ftrace_return_to_handler(void)
+{
+	struct ftrace_graph_ret trace;
+	unsigned long ret;
+
+	ftrace_pop_return_trace(&trace, &ret);
+	trace.rettime = cpu_clock(raw_smp_processor_id());
+	ftrace_graph_return(&trace);
+
+	if (unlikely(!ret)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		/* Might as well panic. What else to do? */
+		ret = (unsigned long)panic;
+	}
+
+	return ret;
+}
+
 static int graph_trace_init(struct trace_array *tr)
 {
 	int cpu, ret;
