Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 590D51007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:11:41 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBI68LoS008973
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:08:21 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBI6Beif1478898
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:11:40 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBI6BdtX013949
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:11:40 +1100
Message-ID: <4B2B0EBF.5040302@linux.vnet.ibm.com>
Date: Fri, 18 Dec 2009 10:40:23 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the kprobe-based
	event tracer
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com> <13884.1261016575@neuling.org>
	<4B29EE5F.9020801@linux.vnet.ibm.com>
	<12450.1261043861@neuling.org>
In-Reply-To: <12450.1261043861@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> In message <4B29EE5F.9020801@linux.vnet.ibm.com> you wrote:
>> Hi Michael,
>>
>> Michael Neuling wrote:
>>>> + * regs_get_argument_nth() - get Nth argument at function call
>>>> + * @regs:	pt_regs which contains registers at function entry.
>>>> + * @n:		argument number.
>>>> + *
>>>> + * regs_get_argument_nth() returns @n th argument of a function call.
>>>> + * Since usually the kernel stack will be changed right after function en
> try
>>> ,
>>>> + * you must use this at function entry. If the @n th entry is NOT in the
>>>> + * kernel stack or pt_regs, this returns 0.
>>>> + */
>>>> +unsigned long regs_get_argument_nth(struct pt_regs *regs, unsigned int n)
>>>> +{
>>>> +	if (n < ARRAY_SIZE(arg_offs_table))
>>>> +		return *(unsigned long *)((char *)regs + arg_offs_table[n]);
>>>> +	else {
>>>> +		/*
>>>> +		 * If more arguments are passed that can be stored in
>>>> +		 * registers, the remaining arguments are stored in the
>>>> +		 * parameter save area located at fixed offset from stack
>>>> +		 * pointer.
>>>> +		 * Following the PowerPC ABI, the first few arguments are
>>>> +		 * actually passed in registers (r3-r10), with equivalent space
>>>> +		 * left unused in the parameter save area.
>>>> +		 */
>>>> +		n += (PARAMETER_SAVE_AREA_OFFSET / sizeof(unsigned long));
>>>> +		return regs_get_kernel_stack_nth(regs, n);
>>> How do we handle FP args?
>> Currently this patch does not support FP args.
> 
> This might be OK.  I don't think we use floating point parameters in any
> function definitions in the kernel.  
> 
> We do use altivec in the raid6 driver (drivers/md/raid6altivec.uc) but
> they are static inline, so they probably don't even end up as
> functions.  
> 
> I guess we need to make sure that we're not limiting the interface in
> such a way that we can't support it later if the above changes.  
> 
> regs_get_argument_nth returns an unsigned long which makes returning a
> 128 bit VMX register impossible.  This might be a show stopper for me.
> How are the x86 guys dealing with this?
> 
Nope, x86 does not deal with bigger registers (Masami, correct me if I 
am wrong). The return data type is opaque to user. Hence this enables us 
to handle any such situations in future without effecting user space API.

>>>> +	}
>>>> +}
>>>> +/*
>>>>   * does not yet catch signals sent when the child dies.
>>>>   * in exit.c or in signal.c.
>>>>   */
>>>> Index: linux-2.6-tip/kernel/trace/Kconfig
>>>> ===================================================================
>>>> --- linux-2.6-tip.orig/kernel/trace/Kconfig
>>>> +++ linux-2.6-tip/kernel/trace/Kconfig
>>>> @@ -464,7 +464,7 @@ config BLK_DEV_IO_TRACE
>>>>  
>>>>  config KPROBE_EVENT
>>>>  	depends on KPROBES
>>>> -	depends on X86
>>>> +	depends on X86 || PPC
>>>>  	bool "Enable kprobes-based dynamic events"
>>>>  	select TRACING
>>>>  	default y
>>>>
>>>> _______________________________________________
>>>> Linuxppc-dev mailing list
>>>> Linuxppc-dev@lists.ozlabs.org
>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>
>> Thanks for reviewing.
> 
> We are creating a new user space API here, so I'm keen for others to take
> a good look at the interface before we commit to something we are going
> to have to keep forever.  
> 
> Who is the main consumer of this (/me is pretty ignorant of kprobes)?
> What do they think of the interface?
> 
The user space API are already present in the upstream kernel and 
currently only supported architecture is x86. This patch provides ppc 
architecture specific interfaces that enables powerpc also in par with x86.

The main consumer would be kernel developers who would like to see 
register values, arguments and stack when the probe hits at given text 
address.
> Mikey
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
