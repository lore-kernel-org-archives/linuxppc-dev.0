Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09894DDF24
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 04:32:19 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8B7E97@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7E97@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E83A767-0E8C-41E3-A9C7-A231CD841EAF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
Date: Thu, 8 Feb 2007 11:31:25 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 3:06 AM, Zhu Ebony-r57400 wrote:

>
>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, February 08, 2007 3:33 PM
>> To: Zhu Ebony-r57400
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [patch][5/5] powerpc V2: Add the general support
>> for Embedded Floating-Point instructions
>>
>>
>> On Feb 7, 2007, at 9:55 PM, ebony.zhu@freescale.com wrote:
>>
>>> Add the general support for Embedded Floating-Point instructions to
>>> fully comply with IEEE-754.
>>>
>>> Signed-off-by:Ebony Zhu <ebony.zhu@freescale.com>
>>> ---
>>>  arch/powerpc/kernel/head_fsl_booke.S |    4
>>>  arch/powerpc/kernel/traps.c          |   57 +++++
>>>  arch/powerpc/math-emu/Makefile       |   25 ++
>>>  arch/powerpc/math-emu/sfp-machine.h  |    2
>>>  arch/powerpc/math-emu/spe.h          |    1
>>>  arch/powerpc/sysdev/Makefile         |    1
>>>  arch/powerpc/sysdev/sigfpe_handler.c |  361 +++++++++++++++++++++++
>>> +++++++++++
>>>  7 files changed, 442 insertions(+), 9 deletions(-)
>>
>> I thought we were going to have some general Kconfig option
>> to enable all this?  EMDEDDED_FP_IEEE or something like that
>
> So that users have chance to enable/disable fully IEEE compliance?
> Segher
> had mentioned this, and it sounds reasonable.

Its alot of code to bring in if you don't care about IEEE compliance.

>>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/
>>> kernel/head_fsl_booke.S
>>> index 66877bd..0d05db0 100644
>>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>>> @@ -705,7 +705,7 @@ #else
>>>  #endif /* CONFIG_SPE */
>>>
>>>  	/* SPE Floating Point Round */
>>> -	EXCEPTION(0x2050, SPEFloatingPointRound, unknown_exception,
>>> EXC_XFER_EE)
>>> +	EXCEPTION(0x2050, SPEFloatingPointRound,
>>> SPEFloatingPointException_Round, EXC_XFER_EE)
>>>
>>>  	/* Performance Monitor */
>>>  	EXCEPTION(0x2060, PerformanceMonitor,
>>> performance_monitor_exception, EXC_XFER_STD)
>>> @@ -840,6 +840,8 @@ load_up_spe:
>>>  	oris	r5,r5,MSR_SPE@h
>>>  	mtmsr	r5			/* enable use of SPE now */
>>>  	isync
>>> +	li	r5,(SPEFSCR_FINVE | SPEFSCR_FDBZE | SPEFSCR_FUNFE |
>>> SPEFSCR_FOVFE)
>>> +	mtspr   SPRN_SPEFSCR,r5
>>
>> We should do this via INIT_THREAD, is there a reason that you
>> want to
>> set these always?
>
> I just thought it's the first time that an SPE instruction is
> encountered, so I
> enable the exceptions here.

Lets do this via INIT_THREAD instead, its cleaner. (just remember to  
add the proper ifdef protection for SPE_IEEE

>>>  /*
>>>   * For SMP, we don't do lazy SPE switching because it just gets too
>>>   * horrendously complex, especially when a task switches
>> from one CPU
>>> diff --git a/arch/powerpc/kernel/traps.c
>> b/arch/powerpc/kernel/traps.c
>>> index 6915b91..30ab0f7 100644
>>> --- a/arch/powerpc/kernel/traps.c
>>> +++ b/arch/powerpc/kernel/traps.c
>>> @@ -986,9 +986,16 @@ #endif /* CONFIG_FSL_BOOKE */
>>>  #ifdef CONFIG_SPE
>>>  void SPEFloatingPointException(struct pt_regs *regs)
>>>  {
>>> +	extern int spedata_handler(struct pt_regs *regs);
>>>  	unsigned long spefscr;
>>>  	int fpexc_mode;
>>>  	int code = 0;
>>> +	int err;
>>> +	
>>> +	preempt_disable();
>>> +	if (regs->msr & MSR_SPE)
>>> +		giveup_spe(current);
>>> +	preempt_enable();
>>
>> use flush_spe_to_thread(current);
>
> OK. It works, and I'll change it.
>
>>
>>>
>>>  	spefscr = current->thread.spefscr;
>>>  	fpexc_mode = current->thread.fpexc_mode;
>>> @@ -1013,9 +1020,55 @@ void SPEFloatingPointException(struct pt
>>>  		code = FPE_FLTRES;
>>>
>>>  	current->thread.spefscr = spefscr;
>>> +	err = spedata_handler(regs);
>>> +	if (err == 0) {
>>> +		regs->nip += 4;		/* skip emulated instruction */
>>> +		emulate_single_step(regs);
>>> +		return;
>>> +	}
>>
>> Take a look at the path I put up that reworks the error
>> handling from
>> do_mathemu() we need to be doing something similar (in parsing
>> spefscr/fpexc_mode to setup code properly)
>
> It's new in trap.c? I'll look into it.

Pretty recent commit, in Paul's tree, not yet in linus's.

(or look at my last pull request email to paul)

>>> -	_exception(SIGFPE, regs, code, regs->nip);
>>> -	return;
>>> +	if (err == -EFAULT) {
>>> +		/* got an error reading the instruction */
>>> +		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
>>> +	} else if (err == -EINVAL) {
>>> +		/* didn't recognize the instruction */
>>> +		printk(KERN_ERR "unrecognized spe instruction "
>>> +		       "in %s at %lx\n", current->comm, regs->nip);
>>
>> We should probably just SIGSEGV in this case since will never make
>> forward progress once we hit this case.
>
> Won't it hit the case that the instruction is not an spe instruction?

No, since we will not get this exception on something that's not an  
SPE instruction.

>>> diff --git a/arch/powerpc/math-emu/Makefile
>> b/arch/powerpc/math-emu/
>>> Makefile
>>> index 29bc912..2da11ba 100644
>>> --- a/arch/powerpc/math-emu/Makefile
>>> +++ b/arch/powerpc/math-emu/Makefile
>>> @@ -1,16 +1,29 @@
>>>
>>> -obj-y				:= math.o fmr.o lfd.o stfd.o
>>> -
>>> -obj-$(CONFIG_MATH_EMULATION)	+= fabs.o fadd.o
>> fadds.o fcmpo.o
>>> fcmpu.o \
>>> +obj-y				:= fabs.o fneg.o
>> types.o udivmodti4.o
>>
>> This isn't right, we don't want to always build these files.
>>
> fabs.o/fneg.o should be built in the case
> that CONFIG_MATH_EMULATION or CONFIG_SPE or both are
> enabled. Because I reused fabs.c and fneg.c to implement instruction
> efdabs and
> efdneg. Therefore, these two files should be build once we have chance
> to build the files in directory math-emu. Types.c and udivmodti4.c
> contain the function
> that both math emulation instructions and spe instructions may  
> call, so
> they always need
> to be built.

Right, but doesn't the new rule say to always build, regardless if  
CONFIG_MATH_EMULATION or CONFIG_SPE are set?

Why not just duplicate fabs.o fneg.o ... in both lists.  I don't  
think that will cause any harm.

- k
