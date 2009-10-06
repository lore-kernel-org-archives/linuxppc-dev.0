Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 89236B7BB2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 14:04:18 +1100 (EST)
Subject: Re: [PATCH] powerpc: tracing: Add powerpc tracepoints for
	interrupt entry and exit
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091006021903.GC16073@kryten>
References: <20091006021903.GC16073@kryten>
Content-Type: text/plain
Date: Mon, 05 Oct 2009 22:34:52 -0400
Message-Id: <1254796492.13160.218.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-06 at 13:19 +1100, Anton Blanchard wrote:
> This patch adds powerpc specific tracepoints for interrupt entry and exit.
> 
> While we already have generic irq_handler_entry and irq_handler_exit
> tracepoints there are cases on our virtualised powerpc machines where an
> interrupt is presented to the OS, but subsequently handled by the hypervisor.
> This means no OS interrupt handler is invoked.
> 
> Here is an example on a POWER6 machine with the patch below applied:

Hi Anton,

Thanks for the patch.

>  
> <idle>-0     [006]  3243.949840744: irq_entry: pt_regs=c0000000ce31fb10
> <idle>-0     [006]  3243.949850520: irq_exit: pt_regs=c0000000ce31fb10
> 
> <idle>-0     [007]  3243.950218208: irq_entry: pt_regs=c0000000ce323b10
> <idle>-0     [007]  3243.950224080: irq_exit: pt_regs=c0000000ce323b10
> 
> <idle>-0     [000]  3244.021879320: irq_entry: pt_regs=c000000000a63aa0
> <idle>-0     [000]  3244.021883616: irq_handler_entry: irq=87 handler=eth0
> <idle>-0     [000]  3244.021887328: irq_handler_exit: irq=87 return=handled
> <idle>-0     [000]  3244.021897408: irq_exit: pt_regs=c000000000a63aa0
> 
> Here we see two phantom interrupts (no handler was invoked), followed
> by a real interrupt for eth0. Without the tracepoints in this patch we
> would have missed the phantom interrupts.
> 
> Since these would be the first arch specific tracepoints, I'd like to make
> sure we agree on naming. The tracepoints live in events/powerpc/*, but I'm
> wondering if the tracepoint name should also contain the arch name, eg
> powerpc_irq_entry/powerpc_irq_exit. Thoughts?
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> --
> 
> Index: linux.trees.git/arch/powerpc/kernel/irq.c
> ===================================================================
> --- linux.trees.git.orig/arch/powerpc/kernel/irq.c	2009-10-06 11:11:44.000000000 +1100
> +++ linux.trees.git/arch/powerpc/kernel/irq.c	2009-10-06 11:15:09.000000000 +1100
> @@ -54,6 +54,8 @@
>  #include <linux/pci.h>
>  #include <linux/debugfs.h>
>  #include <linux/perf_event.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/powerpc.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/system.h>
> @@ -325,6 +327,8 @@ void do_IRQ(struct pt_regs *regs)
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  	unsigned int irq;
>  
> +	trace_irq_entry(regs);
> +
>  	irq_enter();
>  
>  	check_stack_overflow();
> @@ -348,6 +352,8 @@ void do_IRQ(struct pt_regs *regs)
>  		timer_interrupt(regs);
>  	}
>  #endif
> +
> +	trace_irq_exit(regs);
>  }
>  
>  void __init init_IRQ(void)
> Index: linux.trees.git/include/trace/events/powerpc.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.trees.git/include/trace/events/powerpc.h	2009-10-06 11:14:05.000000000 +1100

I think this may do better in a file like:

arch/powerpc/kernel/trace.h

You can look at the sample code and Makefile in samples/trace_events/
that shows how to make it work outside the include/trace/events
directory.

I really would like to avoid placing arch specific files in a generic
directory, especially when there's a way to do it in the arch directory
itself.

This also contains the arch code a bit better.

Thanks,

-- Steve

> @@ -0,0 +1,47 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM powerpc
> +
> +#if !defined(_TRACE_POWERPC_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_POWERPC_H
> +
> +#include <linux/ptrace.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(irq_entry,
> +
> +	TP_PROTO(struct pt_regs *regs),
> +
> +	TP_ARGS(regs),
> +
> +	TP_STRUCT__entry(
> +		__field(struct pt_regs *, regs)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->regs = regs;
> +	),
> +
> +	TP_printk("pt_regs=%p", __entry->regs)
> +);
> +
> +TRACE_EVENT(irq_exit,
> +
> +	TP_PROTO(struct pt_regs *regs),
> +
> +	TP_ARGS(regs),
> +
> +	TP_STRUCT__entry(
> +		__field(struct pt_regs *, regs)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->regs = regs;
> +	),
> +
> +	TP_printk("pt_regs=%p", __entry->regs)
> +);
> +
> +#endif /* _TRACE_POWERPC_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
