Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 1D54AB7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Oct 2009 04:05:45 +1100 (EST)
Subject: Re: [PATCH] powerpc: tracing: Add powerpc tracepoints for
	interrupt entry and exit
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20091018110109.GJ4808@kryten>
References: <20091006021903.GC16073@kryten>
	<1254796492.13160.218.camel@gandalf.stny.rr.com>
	<20091006040554.GD16073@kryten> <1255501071.2347.42.camel@pasglop>
	<20091018110109.GJ4808@kryten>
Content-Type: text/plain
Date: Mon, 19 Oct 2009 13:00:42 -0400
Message-Id: <1255971642.18347.138.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	Frederic Weisbecker <fweisbec@gmail.com>
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-10-18 at 22:01 +1100, Anton Blanchard wrote:
> Hi Ben,
> 
> > Breaks 6xx_defconfig:
> 
> Yuck. Since the CREATE_TRACE_POINTS stuff appears to need a non trivial number
> of includes it might be best just to fold it into one of the tracepoint call
> sites like this.
> 
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

I'm fine with the name "powerpc".

Acked-by: Steven Rostedt <rostedt@goodmis.org>
