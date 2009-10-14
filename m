Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7FF0FB7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 17:18:02 +1100 (EST)
Subject: Re: [PATCH] powerpc: tracing: Add powerpc tracepoints for
	interrupt entry and exit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091006040554.GD16073@kryten>
References: <20091006021903.GC16073@kryten>
	<1254796492.13160.218.camel@gandalf.stny.rr.com>
	<20091006040554.GD16073@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Oct 2009 17:17:51 +1100
Message-Id: <1255501071.2347.42.camel@pasglop>
Mime-Version: 1.0
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-06 at 15:05 +1100, Anton Blanchard wrote:

> This patch adds powerpc specific tracepoints for interrupt entry and exit.

 .../....

Breaks 6xx_defconfig:

In file included from /home/benh/linux-powerpc-test/include/linux/device.h:23,
                 from /home/benh/linux-powerpc-test/arch/powerpc/include/asm/io.h:21,
                 from /home/benh/linux-powerpc-test/arch/powerpc/include/asm/pgtable-ppc32.h:9,
                 from /home/benh/linux-powerpc-test/arch/powerpc/include/asm/pgtable.h:25,
                 from /home/benh/linux-powerpc-test/include/linux/mm.h:39,
                 from /home/benh/linux-powerpc-test/include/linux/ring_buffer.h:5,
                 from /home/benh/linux-powerpc-test/include/linux/ftrace_event.h:4,
                 from /home/benh/linux-powerpc-test/include/trace/ftrace.h:19,
                 from /home/benh/linux-powerpc-test/include/trace/define_trace.h:61,
                 from /home/benh/linux-powerpc-test/arch/powerpc/include/asm/trace.h:53,
                 from /home/benh/linux-powerpc-test/arch/powerpc/kernel/trace-events.c:3:
/home/benh/linux-powerpc-test/include/linux/module.h: In function ‘__module_get’:
/home/benh/linux-powerpc-test/include/linux/module.h:471: error: implicit declaration of function ‘trace_module_get’

Cheers,
Ben.

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
