Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id EB6F3B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Oct 2010 01:14:25 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix hcall tracepoint recursion
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20101021215212.4a982c85@kryten>
References: <4C85A88D.10700@cn.fujitsu.com>
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>
	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>
	<4CB55FE6.6000604@cn.fujitsu.com> <4CB5615C.4070406@cn.fujitsu.com>
	<4CB59825.7060504@cn.fujitsu.com>
	<1286995066.4893.17.camel@subratamodak.linux.ibm.com>
	<4CBBBCB0.8070406@cn.fujitsu.com>  <20101021215212.4a982c85@kryten>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Fri, 22 Oct 2010 10:14:16 -0400
Message-ID: <1287756856.16971.637.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: ltp-list@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>,
	linuxppc-dev@lists.ozlabs.org, Li Zefan <lizf@cn.fujitsu.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-10-21 at 21:52 +1100, Anton Blanchard wrote:

> Anton
> --
> 
> Subject: [PATCH] powerpc: Fix hcall tracepoint recursion
> 
> Spinlocks on shared processor partitions use H_YIELD to notify the
> hypervisor we are waiting on another virtual CPU. Unfortunately this means
> the hcall tracepoints can recurse.
> 
> The patch below adds a percpu depth and checks it on both the entry and
> exit hcall tracepoints.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: powerpc.git/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:32:00.980003644 +1100
> +++ powerpc.git/arch/powerpc/platforms/pseries/lpar.c	2010-10-21 17:34:54.942681273 +1100
> @@ -701,6 +701,13 @@ EXPORT_SYMBOL(arch_free_page);
>  /* NB: reg/unreg are called while guarded with the tracepoints_mutex */
>  extern long hcall_tracepoint_refcount;
>  
> +/* 
> + * Since the tracing code might execute hcalls we need to guard against
> + * recursion. One example of this are spinlocks calling H_YIELD on
> + * shared processor partitions.
> + */
> +static DEFINE_PER_CPU(unsigned int, hcall_trace_depth);
> +
>  void hcall_tracepoint_regfunc(void)
>  {
>  	hcall_tracepoint_refcount++;
> @@ -713,12 +720,42 @@ void hcall_tracepoint_unregfunc(void)
>  
>  void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
>  {
> +	unsigned long flags;
> +	unsigned int *depth;
> +
> +	local_irq_save(flags);
> +
> +	depth = &__get_cpu_var(hcall_trace_depth);
> +
> +	if (*depth)
> +		goto out;
> +
> +	(*depth)++;
>  	trace_hcall_entry(opcode, args);
> +	(*depth)--;
> +
> +out:
> +	local_irq_restore(flags);
>  }
>  
>  void __trace_hcall_exit(long opcode, unsigned long retval,
>  			unsigned long *retbuf)
>  {
> +	unsigned long flags;
> +	unsigned int *depth;
> +
> +	local_irq_save(flags);
> +
> +	depth = &__get_cpu_var(hcall_trace_depth);
> +
> +	if (*depth)
> +		goto out;
> +
> +	(*depth)++;
>  	trace_hcall_exit(opcode, retval, retbuf);
> +	(*depth)--;
> +
> +out:
> +	local_irq_restore(flags);
>  }
>  #endif

That's similar to the example that I wrote, but without the encapsulated
code and with disabling interrupts for the reasons you gave.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
