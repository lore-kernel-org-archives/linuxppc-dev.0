Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the
	kprobe-based event tracer
In-reply-to: <4B2B0EBF.5040302@linux.vnet.ibm.com>
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com> <13884.1261016575@neuling.org>
	<4B29EE5F.9020801@linux.vnet.ibm.com>
	<12450.1261043861@neuling.org>
	<4B2B0EBF.5040302@linux.vnet.ibm.com>
Date: Mon, 21 Dec 2009 07:59:15 +1100
Message-ID: <10270.1261342755@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <4B2B0EBF.5040302@linux.vnet.ibm.com> you wrote:
> Michael Neuling wrote:
> > In message <4B29EE5F.9020801@linux.vnet.ibm.com> you wrote:
> >> Hi Michael,
> >>
> >> Michael Neuling wrote:
> >>>> + * regs_get_argument_nth() - get Nth argument at function call
> >>>> + * @regs:	pt_regs which contains registers at function entry.
> >>>> + * @n:		argument number.
> >>>> + *
> >>>> + * regs_get_argument_nth() returns @n th argument of a function call.
> >>>> + * Since usually the kernel stack will be changed right after function 
en
> > try
> >>> ,
> >>>> + * you must use this at function entry. If the @n th entry is NOT in th
e
> >>>> + * kernel stack or pt_regs, this returns 0.
> >>>> + */
> >>>> +unsigned long regs_get_argument_nth(struct pt_regs *regs, unsigned int 
n)
> >>>> +{
> >>>> +	if (n < ARRAY_SIZE(arg_offs_table))
> >>>> +		return *(unsigned long *)((char *)regs + arg_offs_table
[n]);
> >>>> +	else {
> >>>> +		/*
> >>>> +		 * If more arguments are passed that can be stored in
> >>>> +		 * registers, the remaining arguments are stored in the
> >>>> +		 * parameter save area located at fixed offset from sta
ck
> >>>> +		 * pointer.
> >>>> +		 * Following the PowerPC ABI, the first few arguments a
re
> >>>> +		 * actually passed in registers (r3-r10), with equivale
nt space
> >>>> +		 * left unused in the parameter save area.
> >>>> +		 */
> >>>> +		n += (PARAMETER_SAVE_AREA_OFFSET / sizeof(unsigned long
));
> >>>> +		return regs_get_kernel_stack_nth(regs, n);
> >>> How do we handle FP args?
> >> Currently this patch does not support FP args.
> > 
> > This might be OK.  I don't think we use floating point parameters in any
> > function definitions in the kernel.  
> > 
> > We do use altivec in the raid6 driver (drivers/md/raid6altivec.uc) but
> > they are static inline, so they probably don't even end up as
> > functions.  
> > 
> > I guess we need to make sure that we're not limiting the interface in
> > such a way that we can't support it later if the above changes.  
> > 
> > regs_get_argument_nth returns an unsigned long which makes returning a
> > 128 bit VMX register impossible.  This might be a show stopper for me.
> > How are the x86 guys dealing with this?
> > 
> Nope, x86 does not deal with bigger registers (Masami, correct me if I 
> am wrong). The return data type is opaque to user. Hence this enables us 
> to handle any such situations in future without effecting user space API.

How is it opaque?  It's an unsigned long?  Is this function different to
what is presented to userspace?

Mikey

> >>>> +	}
> >>>> +}
> >>>> +/*
> >>>>   * does not yet catch signals sent when the child dies.
> >>>>   * in exit.c or in signal.c.
> >>>>   */
> >>>> Index: linux-2.6-tip/kernel/trace/Kconfig
> >>>> ===================================================================
> >>>> --- linux-2.6-tip.orig/kernel/trace/Kconfig
> >>>> +++ linux-2.6-tip/kernel/trace/Kconfig
> >>>> @@ -464,7 +464,7 @@ config BLK_DEV_IO_TRACE
> >>>>  
> >>>>  config KPROBE_EVENT
> >>>>  	depends on KPROBES
> >>>> -	depends on X86
> >>>> +	depends on X86 || PPC
> >>>>  	bool "Enable kprobes-based dynamic events"
> >>>>  	select TRACING
> >>>>  	default y
> >>>>
> >>>> _______________________________________________
> >>>> Linuxppc-dev mailing list
> >>>> Linuxppc-dev@lists.ozlabs.org
> >>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >>>>
> >> Thanks for reviewing.
> > 
> > We are creating a new user space API here, so I'm keen for others to take
> > a good look at the interface before we commit to something we are going
> > to have to keep forever.  
> > 
> > Who is the main consumer of this (/me is pretty ignorant of kprobes)?
> > What do they think of the interface?
> > 
> The user space API are already present in the upstream kernel and 
> currently only supported architecture is x86. This patch provides ppc 
> architecture specific interfaces that enables powerpc also in par with x86.
> 
> The main consumer would be kernel developers who would like to see 
> register values, arguments and stack when the probe hits at given text 
> address.
>
> > Mikey
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
