Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the
	kprobe-based event tracer
In-reply-to: <4B29EE5F.9020801@linux.vnet.ibm.com>
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com> <13884.1261016575@neuling.org>
	<4B29EE5F.9020801@linux.vnet.ibm.com>
Date: Thu, 17 Dec 2009 20:57:41 +1100
Message-ID: <12450.1261043861@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4B29EE5F.9020801@linux.vnet.ibm.com> you wrote:
> Hi Michael,
> 
> Michael Neuling wrote:
> >> Index: linux-2.6-tip/arch/powerpc/include/asm/ptrace.h
> >> ===================================================================
> >> --- linux-2.6-tip.orig/arch/powerpc/include/asm/ptrace.h
> >> +++ linux-2.6-tip/arch/powerpc/include/asm/ptrace.h
> >> @@ -83,6 +83,7 @@ struct pt_regs {
> >>  
> >>  #define instruction_pointer(regs) ((regs)->nip)
> >>  #define user_stack_pointer(regs) ((regs)->gpr[1])
> >> +#define kernel_stack_pointer(regs) ((regs)->gpr[1])
> >>  #define regs_return_value(regs) ((regs)->gpr[3])
> >>  
> >>  #ifdef CONFIG_SMP
> >> @@ -131,6 +132,69 @@ do {						
> > 			      \
> >>  } while (0)
> >>  #endif /* __powerpc64__ */
> >>  
> >> +/* Query offset/name of register from its name/offset */
> >> +#include <linux/stddef.h>
> >> +#include <linux/thread_info.h>
> > 
> > Includes should be at the start of the file
> > 
> The compilation throws many errors when moved to start of the file. This 
> file has lots of #ifdef and found this place to be perfect for compilation.

Ok, no problem.

> 
> >> +/**
> >> + * regs_query_register_name() - query register name from its offset
> >> + * @offset:	the offset of a register in struct pt_regs.
> >> + *
> >> + * regs_query_register_name() returns the name of a register from its
> >> + * offset in struct pt_regs. If the @offset is invalid, this returns NULL
;
> >> + */
> >> +const char *regs_query_register_name(unsigned int offset)
> >> +{
> >> +	const struct pt_regs_offset *roff;
> >> +	for (roff = regoffset_table; roff->name != NULL; roff++)
> >> +		if (roff->offset == offset)
> >> +			return roff->name;
> >> +	return NULL;
> >> +}
> >> +
> >> +static const int arg_offs_table[] = {
> >> +	[0] = offsetof(struct pt_regs, gpr[3]),
> >> +	[1] = offsetof(struct pt_regs, gpr[4]),
> >> +	[2] = offsetof(struct pt_regs, gpr[5]),
> >> +	[3] = offsetof(struct pt_regs, gpr[6]),
> >> +	[4] = offsetof(struct pt_regs, gpr[7]),
> >> +	[5] = offsetof(struct pt_regs, gpr[8]),
> >> +	[6] = offsetof(struct pt_regs, gpr[9]),
> >> +	[7] = offsetof(struct pt_regs, gpr[10])
> >> +};
> >> +
> >> +/**
> >> + * regs_get_argument_nth() - get Nth argument at function call
> >> + * @regs:	pt_regs which contains registers at function entry.
> >> + * @n:		argument number.
> >> + *
> >> + * regs_get_argument_nth() returns @n th argument of a function call.
> >> + * Since usually the kernel stack will be changed right after function en
try
> > ,
> >> + * you must use this at function entry. If the @n th entry is NOT in the
> >> + * kernel stack or pt_regs, this returns 0.
> >> + */
> >> +unsigned long regs_get_argument_nth(struct pt_regs *regs, unsigned int n)
> >> +{
> >> +	if (n < ARRAY_SIZE(arg_offs_table))
> >> +		return *(unsigned long *)((char *)regs + arg_offs_table[n]);
> >> +	else {
> >> +		/*
> >> +		 * If more arguments are passed that can be stored in
> >> +		 * registers, the remaining arguments are stored in the
> >> +		 * parameter save area located at fixed offset from stack
> >> +		 * pointer.
> >> +		 * Following the PowerPC ABI, the first few arguments are
> >> +		 * actually passed in registers (r3-r10), with equivalent space
> >> +		 * left unused in the parameter save area.
> >> +		 */
> >> +		n += (PARAMETER_SAVE_AREA_OFFSET / sizeof(unsigned long));
> >> +		return regs_get_kernel_stack_nth(regs, n);
> > 
> > How do we handle FP args?
> 
> Currently this patch does not support FP args.

This might be OK.  I don't think we use floating point parameters in any
function definitions in the kernel.  

We do use altivec in the raid6 driver (drivers/md/raid6altivec.uc) but
they are static inline, so they probably don't even end up as
functions.  

I guess we need to make sure that we're not limiting the interface in
such a way that we can't support it later if the above changes.  

regs_get_argument_nth returns an unsigned long which makes returning a
128 bit VMX register impossible.  This might be a show stopper for me.
How are the x86 guys dealing with this?

> > 
> >> +	}
> >> +}
> >> +/*
> >>   * does not yet catch signals sent when the child dies.
> >>   * in exit.c or in signal.c.
> >>   */
> >> Index: linux-2.6-tip/kernel/trace/Kconfig
> >> ===================================================================
> >> --- linux-2.6-tip.orig/kernel/trace/Kconfig
> >> +++ linux-2.6-tip/kernel/trace/Kconfig
> >> @@ -464,7 +464,7 @@ config BLK_DEV_IO_TRACE
> >>  
> >>  config KPROBE_EVENT
> >>  	depends on KPROBES
> >> -	depends on X86
> >> +	depends on X86 || PPC
> >>  	bool "Enable kprobes-based dynamic events"
> >>  	select TRACING
> >>  	default y
> >>
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@lists.ozlabs.org
> >> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >>
> 
> Thanks for reviewing.

We are creating a new user space API here, so I'm keen for others to take
a good look at the interface before we commit to something we are going
to have to keep forever.  

Who is the main consumer of this (/me is pretty ignorant of kprobes)?
What do they think of the interface?

Mikey
