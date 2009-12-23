Return-Path: <mhiramat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 52B22B7BC0
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 12:29:53 +1100 (EST)
Message-ID: <4B317324.3000708@redhat.com>
Date: Tue, 22 Dec 2009 20:32:20 -0500
From: Masami Hiramatsu <mhiramat@redhat.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the kprobe-based
	event tracer
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com> <13884.1261016575@neuling.org>
	<4B29EE5F.9020801@linux.vnet.ibm.com>
	<12450.1261043861@neuling.org>
	<4B2B0EBF.5040302@linux.vnet.ibm.com>
	<4B2B934C.1060807@redhat.com> <9823.1261342444@neuling.org>
In-Reply-To: <9823.1261342444@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> In message <4B2B934C.1060807@redhat.com> you wrote:
>>
>>
>> Mahesh Jagannath Salgaonkar wrote:
>>> Michael Neuling wrote:
>>>> In message <4B29EE5F.9020801@linux.vnet.ibm.com> you wrote:
>>>>> Hi Michael,
>>>>>
>>>>> Michael Neuling wrote:
>>>>>>> + * regs_get_argument_nth() - get Nth argument at function call
>>>>>>> + * @regs:    pt_regs which contains registers at function entry.
>>>>>>> + * @n:        argument number.
>>>>>>> + *
>>>>>>> + * regs_get_argument_nth() returns @n th argument of a function call.
>>>>>>> + * Since usually the kernel stack will be changed right after
>>>>>>> function en
>>>> try
>>>>>> ,
>>>>>>> + * you must use this at function entry. If the @n th entry is NOT
>>>>>>> in the
>>>>>>> + * kernel stack or pt_regs, this returns 0.
>>>>>>> + */
>>>>>>> +unsigned long regs_get_argument_nth(struct pt_regs *regs, unsigned
>>>>>>> int n)
>>>>>>> +{
>>>>>>> +    if (n < ARRAY_SIZE(arg_offs_table))
>>>>>>> +        return *(unsigned long *)((char *)regs + arg_offs_table[n]);
>>>>>>> +    else {
>>>>>>> +        /*
>>>>>>> +         * If more arguments are passed that can be stored in
>>>>>>> +         * registers, the remaining arguments are stored in the
>>>>>>> +         * parameter save area located at fixed offset from stack
>>>>>>> +         * pointer.
>>>>>>> +         * Following the PowerPC ABI, the first few arguments are
>>>>>>> +         * actually passed in registers (r3-r10), with equivalent
>>>>>>> space
>>>>>>> +         * left unused in the parameter save area.
>>>>>>> +         */
>>>>>>> +        n += (PARAMETER_SAVE_AREA_OFFSET / sizeof(unsigned long));
>>>>>>> +        return regs_get_kernel_stack_nth(regs, n);
>>>>>> How do we handle FP args?
>>>>> Currently this patch does not support FP args.
>>>>
>>>> This might be OK.  I don't think we use floating point parameters in any
>>>> function definitions in the kernel. 
>>>> We do use altivec in the raid6 driver (drivers/md/raid6altivec.uc) but
>>>> they are static inline, so they probably don't even end up as
>>>> functions. 
>>>> I guess we need to make sure that we're not limiting the interface in
>>>> such a way that we can't support it later if the above changes. 
>>>> regs_get_argument_nth returns an unsigned long which makes returning a
>>>> 128 bit VMX register impossible.  This might be a show stopper for me.
>>>> How are the x86 guys dealing with this?
>>>>
>>> Nope, x86 does not deal with bigger registers (Masami, correct me if I
>>> am wrong). The return data type is opaque to user. Hence this enables us
>>> to handle any such situations in future without effecting user space API.
>>
>> Right, we don't use those bigger registers in the kernel context.
>> (some special functions use it inside, but most of codes
>>  are just using general regs)
> 
> Sure, but kernel interfaces are for now.  What happens if this changes in
> the future?
> 
>> And regs_get_argument_nth is just an accessor of pt_regs field.
>> This means that it just provides field in pt_regs.
> 
> Sure, that's how it's implemented, but that's not what the name of the
> function suggests it does.

Hmm, OK, maybe I see what you think.
Actually, this function doesn't cover all functions in the kernel
even on x86, because each ABI depends on how function is defined,
e.g. func(fmt,...) and asmlinkage(i386) function will put all
arguments on the stack.

Originally, I had introduced this function only for helping user
of kprobe-tracer who wants to trace function arguments without
any arch specific knowledge. However, now we have perf-probe which
can analyze debuginfo to find function arguments and local variables.
So, this function is a bit out-of-dated :-)

How about removing this function from this patch? I can also
update kprobe-tracer to drop the function argument support.
Instead of that, I think it is enough to add a description of
how to get function arguments in Documentation/trace/kprobetrace.txt

Thank you,

> 
> Mikey
> 
>>
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +/*
>>>>>>>   * does not yet catch signals sent when the child dies.
>>>>>>>   * in exit.c or in signal.c.
>>>>>>>   */
>>>>>>> Index: linux-2.6-tip/kernel/trace/Kconfig
>>>>>>> ===================================================================
>>>>>>> --- linux-2.6-tip.orig/kernel/trace/Kconfig
>>>>>>> +++ linux-2.6-tip/kernel/trace/Kconfig
>>>>>>> @@ -464,7 +464,7 @@ config BLK_DEV_IO_TRACE
>>>>>>>  
>>>>>>>  config KPROBE_EVENT
>>>>>>>      depends on KPROBES
>>>>>>> -    depends on X86
>>>>>>> +    depends on X86 || PPC
>>>>>>>      bool "Enable kprobes-based dynamic events"
>>>>>>>      select TRACING
>>>>>>>      default y
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Linuxppc-dev mailing list
>>>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>>>>
>>>>> Thanks for reviewing.
>>>>
>>>> We are creating a new user space API here, so I'm keen for others to take
>>>> a good look at the interface before we commit to something we are going
>>>> to have to keep forever. 
>>>> Who is the main consumer of this (/me is pretty ignorant of kprobes)?
>>>> What do they think of the interface?
>>>>
>>> The user space API are already present in the upstream kernel and
>>> currently only supported architecture is x86. This patch provides ppc
>>> architecture specific interfaces that enables powerpc also in par with x86.
>>
>> Yes, there is a kprobe tracer in ftrace (see Documentation/trace/kprobetrace.
> txt).
>> and this tracer is only for probing kernel (not userspace).
>>
>>>
>>> The main consumer would be kernel developers who would like to see
>>> register values, arguments and stack when the probe hits at given text
>>> address.
>>
>> Right.
>>
>> BTW, there is a user-space tools we have (tools/perf/builtin-probe.c).
>> Currently, it's only for x86. Mahesh, You just need to add a register
>> translation table in tools/perf/util/probe-finder.c for ppc support.
>>
>> Thank you!
>>
>> -- 
>> Masami Hiramatsu
>>
>> Software Engineer
>> Hitachi Computer Products (America), Inc.
>> Software Solutions Division
>>
>> e-mail: mhiramat@redhat.com
>>

-- 
Masami Hiramatsu

Software Engineer
Hitachi Computer Products (America), Inc.
Software Solutions Division

e-mail: mhiramat@redhat.com
