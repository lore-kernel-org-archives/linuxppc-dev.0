Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id C5E92B7B7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Oct 2009 00:43:36 +1100 (EST)
Subject: Re: [PATCH] powerpc: tracing: Add powerpc tracepoints for
	interrupt entry and exit
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091006040554.GD16073@kryten>
References: <20091006021903.GC16073@kryten>
	<1254796492.13160.218.camel@gandalf.stny.rr.com>
	<20091006040554.GD16073@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 09:38:33 -0400
Message-Id: <1254836313.13160.223.camel@gandalf.stny.rr.com>
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

On Tue, 2009-10-06 at 15:05 +1100, Anton Blanchard wrote:
> Hi Steve,
> 
> > I think this may do better in a file like:
> > 
> > arch/powerpc/kernel/trace.h
> > 
> > You can look at the sample code and Makefile in samples/trace_events/
> > that shows how to make it work outside the include/trace/events
> > directory.
> > 
> > I really would like to avoid placing arch specific files in a generic
> > directory, especially when there's a way to do it in the arch directory
> > itself.
> > 
> > This also contains the arch code a bit better.
> 
> Much nicer! I put the header file into include/asm/trace.h so an out of
> tree kernel module can find it easily. Does that sound reasonable?

Sure.

> 
> Also, I ended up with an interesting include issue in trace-events.c:
> 
> 
> In file included from include/linux/slab.h:162,
>                  from include/linux/percpu.h:5,
>                  from /root/linux-tip/arch/powerpc/include/asm/tlbflush.h:86,
>                  from /root/linux-tip/arch/powerpc/include/asm/pgtable-ppc64.h:121,
>                  from /root/linux-tip/arch/powerpc/include/asm/pgtable.h:23,
>                  from include/linux/mm.h:39,
>                  from include/linux/ring_buffer.h:5,
>                  from include/linux/ftrace_event.h:4,
>                  from include/trace/ftrace.h:19,
>                  from include/trace/define_trace.h:61,
>                  from /root/linux-tip/arch/powerpc/include/asm/trace.h:52,
>                  from arch/powerpc/kernel/trace-events.c:2:
> include/linux/slub_def.h: In function ‘kmalloc_large’:
> include/linux/slub_def.h:236: error: implicit declaration of function ‘trace_kmalloc’
> include/linux/slub_def.h: In function ‘kmalloc_node’:
> include/linux/slub_def.h:296: error: implicit declaration of function ‘trace_kmalloc_node’
> 
> 
> Which I could work around by including linux/slab.h before creating
> the asm/trace.h tracepoints. I assume we don't see this elsewhere because
> any non trivial file includes linux/slab.h somewhere :)

Yeah, you need to have normal includes before adding the
CREATE_TRACE_POINTS macro.

Thanks,

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> 
> Anton
> --
> 
> This patch adds powerpc specific tracepoints for interrupt entry and exit.
> 
> While we already have generic irq_handler_entry and irq_handler_exit
> tracepoints there are cases on our virtualised powerpc machines where an
> interrupt is presented to the OS, but subsequently handled by the hypervisor.
> This means no OS interrupt handler is invoked.
> 
> Here is an example on a POWER6 machine with the patch below applied:
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
> Index: linux.trees.git/arch/powerpc/include/asm/trace.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.trees.git/arch/powerpc/include/asm/trace.h	2009-10-06 14:54:25.000000000 +1100
> @@ -0,0 +1,53 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM powerpc
> +
> +#if !defined(_TRACE_POWERPC_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_POWERPC_H
> +
> +#include <linux/tracepoint.h>
> +
> +struct pt_regs;
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
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +
> +#define TRACE_INCLUDE_PATH asm
> +#define TRACE_INCLUDE_FILE trace
> +
> +#include <trace/define_trace.h>
> Index: linux.trees.git/arch/powerpc/kernel/Makefile
> ===================================================================
> --- linux.trees.git.orig/arch/powerpc/kernel/Makefile	2009-10-06 14:02:03.000000000 +1100
> +++ linux.trees.git/arch/powerpc/kernel/Makefile	2009-10-06 14:38:51.000000000 +1100
> @@ -115,6 +115,8 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
>  obj-y				+= ppc_save_regs.o
>  endif
>  
> +obj-$(CONFIG_TRACEPOINTS)	+= trace-events.o
> +
>  # Disable GCOV in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
>  GCOV_PROFILE_ftrace.o := n
> Index: linux.trees.git/arch/powerpc/kernel/trace-events.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux.trees.git/arch/powerpc/kernel/trace-events.c	2009-10-06 14:44:57.000000000 +1100
> @@ -0,0 +1,3 @@
> +#include <linux/slab.h>
> +#define CREATE_TRACE_POINTS
> +#include <asm/trace.h>
> Index: linux.trees.git/arch/powerpc/kernel/irq.c
> ===================================================================
> --- linux.trees.git.orig/arch/powerpc/kernel/irq.c	2009-10-06 14:02:15.000000000 +1100
> +++ linux.trees.git/arch/powerpc/kernel/irq.c	2009-10-06 14:13:08.000000000 +1100
> @@ -54,6 +54,7 @@
>  #include <linux/pci.h>
>  #include <linux/debugfs.h>
>  #include <linux/perf_event.h>
> +#include <asm/trace.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/system.h>
> @@ -325,6 +326,8 @@ void do_IRQ(struct pt_regs *regs)
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  	unsigned int irq;
>  
> +	trace_irq_entry(regs);
> +
>  	irq_enter();
>  
>  	check_stack_overflow();
> @@ -348,6 +351,8 @@ void do_IRQ(struct pt_regs *regs)
>  		timer_interrupt(regs);
>  	}
>  #endif
> +
> +	trace_irq_exit(regs);
>  }
>  
>  void __init init_IRQ(void)
