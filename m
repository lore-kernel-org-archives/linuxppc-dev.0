Return-Path: <anton@ozlabs.org>
Date: Tue, 27 Oct 2009 15:47:42 +1100
From: Anton Blanchard <anton@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, benh@kernel.crashing.org
Subject: [PATCH 1/6] powerpc: tracing: Add powerpc tracepoints for
	interrupt entry and exit
Message-ID: <20091027044742.GB3085@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch adds powerpc specific tracepoints for interrupt entry and exit.

While we already have generic irq_handler_entry and irq_handler_exit
tracepoints there are cases on our virtualised powerpc machines where an
interrupt is presented to the OS, but subsequently handled by the hypervisor.
This means no OS interrupt handler is invoked.

Here is an example on a POWER6 machine with the patch below applied:
 
<idle>-0     [006]  3243.949840744: irq_entry: pt_regs=c0000000ce31fb10
<idle>-0     [006]  3243.949850520: irq_exit: pt_regs=c0000000ce31fb10

<idle>-0     [007]  3243.950218208: irq_entry: pt_regs=c0000000ce323b10
<idle>-0     [007]  3243.950224080: irq_exit: pt_regs=c0000000ce323b10

<idle>-0     [000]  3244.021879320: irq_entry: pt_regs=c000000000a63aa0
<idle>-0     [000]  3244.021883616: irq_handler_entry: irq=87 handler=eth0
<idle>-0     [000]  3244.021887328: irq_handler_exit: irq=87 return=handled
<idle>-0     [000]  3244.021897408: irq_exit: pt_regs=c000000000a63aa0

Here we see two phantom interrupts (no handler was invoked), followed
by a real interrupt for eth0. Without the tracepoints in this patch we
would have missed the phantom interrupts.

Signed-off-by: Anton Blanchard <anton@samba.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
--

No change to this patch.

Index: linux.trees.git/arch/powerpc/include/asm/trace.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux.trees.git/arch/powerpc/include/asm/trace.h	2009-10-17 08:45:08.000000000 +1100
@@ -0,0 +1,53 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM powerpc
+
+#if !defined(_TRACE_POWERPC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_POWERPC_H
+
+#include <linux/tracepoint.h>
+
+struct pt_regs;
+
+TRACE_EVENT(irq_entry,
+
+	TP_PROTO(struct pt_regs *regs),
+
+	TP_ARGS(regs),
+
+	TP_STRUCT__entry(
+		__field(struct pt_regs *, regs)
+	),
+
+	TP_fast_assign(
+		__entry->regs = regs;
+	),
+
+	TP_printk("pt_regs=%p", __entry->regs)
+);
+
+TRACE_EVENT(irq_exit,
+
+	TP_PROTO(struct pt_regs *regs),
+
+	TP_ARGS(regs),
+
+	TP_STRUCT__entry(
+		__field(struct pt_regs *, regs)
+	),
+
+	TP_fast_assign(
+		__entry->regs = regs;
+	),
+
+	TP_printk("pt_regs=%p", __entry->regs)
+);
+
+#endif /* _TRACE_POWERPC_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH asm
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
Index: linux.trees.git/arch/powerpc/kernel/irq.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/irq.c	2009-10-17 08:44:32.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/irq.c	2009-10-17 08:45:44.000000000 +1100
@@ -70,6 +70,8 @@
 #include <asm/firmware.h>
 #include <asm/lv1call.h>
 #endif
+#define CREATE_TRACE_POINTS
+#include <asm/trace.h>
 
 int __irq_offset_value;
 static int ppc_spurious_interrupts;
@@ -325,6 +327,8 @@ void do_IRQ(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned int irq;
 
+	trace_irq_entry(regs);
+
 	irq_enter();
 
 	check_stack_overflow();
@@ -348,6 +352,8 @@ void do_IRQ(struct pt_regs *regs)
 		timer_interrupt(regs);
 	}
 #endif
+
+	trace_irq_exit(regs);
 }
 
 void __init init_IRQ(void)
