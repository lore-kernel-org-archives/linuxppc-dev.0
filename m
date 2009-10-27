Return-Path: <anton@ozlabs.org>
Date: Tue, 27 Oct 2009 15:49:14 +1100
From: Anton Blanchard <anton@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, benh@kernel.crashing.org
Subject: [PATCH 2/6] powerpc: tracing: Add powerpc tracepoints for timer
	entry and exit
Message-ID: <20091027044914.GC3085@kryten>
References: <20091027044742.GB3085@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091027044742.GB3085@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We can monitor the effectiveness of our power management of both the
kernel and hypervisor by probing the timer interrupt. For example, on
this box we see 10.37s timer interrupts on an idle core:

<idle>-0     [010]  3900.671297: timer_interrupt_entry: pt_regs=c0000000ce1e7b10
<idle>-0     [010]  3900.671302: timer_interrupt_exit: pt_regs=c0000000ce1e7b10

<idle>-0     [010]  3911.042963: timer_interrupt_entry: pt_regs=c0000000ce1e7b10
<idle>-0     [010]  3911.042968: timer_interrupt_exit: pt_regs=c0000000ce1e7b10

<idle>-0     [010]  3921.414630: timer_interrupt_entry: pt_regs=c0000000ce1e7b10
<idle>-0     [010]  3921.414635: timer_interrupt_exit: pt_regs=c0000000ce1e7b10

Since we have a 207MHz decrementer it will go negative and fire every 10.37s
even if Linux is completely idle.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/kernel/time.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/time.c	2009-10-07 17:21:21.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/time.c	2009-10-07 17:21:52.000000000 +1100
@@ -54,6 +54,7 @@
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/perf_event.h>
+#include <asm/trace.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -571,6 +572,8 @@ void timer_interrupt(struct pt_regs * re
 	struct clock_event_device *evt = &decrementer->event;
 	u64 now;
 
+	trace_timer_interrupt_entry(regs);
+
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continuue to take decrementer exceptions */
 	set_dec(DECREMENTER_MAX);
@@ -590,6 +593,7 @@ void timer_interrupt(struct pt_regs * re
 		now = decrementer->next_tb - now;
 		if (now <= DECREMENTER_MAX)
 			set_dec((int)now);
+		trace_timer_interrupt_exit(regs);
 		return;
 	}
 	old_regs = set_irq_regs(regs);
@@ -620,6 +624,8 @@ void timer_interrupt(struct pt_regs * re
 
 	irq_exit();
 	set_irq_regs(old_regs);
+
+	trace_timer_interrupt_exit(regs);
 }
 
 void wakeup_decrementer(void)
Index: linux.trees.git/arch/powerpc/include/asm/trace.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/trace.h	2009-10-07 17:22:25.000000000 +1100
+++ linux.trees.git/arch/powerpc/include/asm/trace.h	2009-10-07 17:23:20.000000000 +1100
@@ -42,6 +42,40 @@ TRACE_EVENT(irq_exit,
 	TP_printk("pt_regs=%p", __entry->regs)
 );
 
+TRACE_EVENT(timer_interrupt_entry,
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
+TRACE_EVENT(timer_interrupt_exit,
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
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
