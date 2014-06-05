Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AFB81A0041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 11:26:22 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 5 Jun 2014 11:26:19 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6A86C357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 11:26:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s551Q1Lw11076080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 11:26:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s551QG7s029254
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 11:26:16 +1000
Message-ID: <538FC737.4030305@au1.ibm.com>
Date: Thu, 05 Jun 2014 11:26:15 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc: correct DSCR during TM context switch
References: <f1ddc3bc4b970a480367a45cdca51e879cb14df0.1401852531.git.sam.bobroff@au1.ibm.com>	
 <1401867077.9903.3.camel@concordia>
 <1401876215.32587.58.camel@ale.ozlabs.ibm.com>
In-Reply-To: <1401876215.32587.58.camel@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: aik@ozlabs.ru, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/14 20:03, Michael Neuling wrote:
> On Wed, 2014-06-04 at 17:31 +1000, Michael Ellerman wrote:
>> Hi Sam,
>>
>> Comments inline ..
> 
> Ditto....

Responses inline...

>> On Wed, 2014-06-04 at 13:33 +1000, Sam Bobroff wrote:
>>> Correct the DSCR SPR becoming temporarily corrupted when a task is
>>> context switched when within a transaction. It is corrected when
>>> the transaction is aborted (which will happen after a context switch)
>>> but if the task has suspended (TSUSPEND) the transaction the incorrect
>>> value can be seen.
>>
>> I don't quite follow this description. How is it corrected when the transaction
>> is aborted, and when does that usually happen? If that happens the task can't
>> ever see the corrupted value?
>>
>> To hit the suspended case, the task starts a transaction, suspends it, is then
>> context switched out and back in, and at that point it can see the wrong value?
> 
> Yep, that's it and it's corrupted until the transaction is rolled back
> (normally at the tresume).  At the tresume it gets rolled back to the
> checkpointed value at tbegin and is no longer corrupt.
>

I'll re-work the explanation to be clearer about how it becomes corrupt and how it is corrected.

>>> The problem is caused by saving a thread's DSCR afterNo it's lost at that point as we've not saved it and it was overwritten when we did the treclaim.   it has already
>>> been reverted to the CPU's default value:
>>>
>>> __switch_to() calls __switch_to_tm()
>>> 	which calls tm_reclaim_task()
>>> 	which calls tm_reclaim_thread()
>>> 	which calls tm_reclaim() where the DSCR is reset
>>
>> Where the DSCR is set to DSCR_DEFAULT ? Or now PACA_DSCR since your previous
>> patches?
>>
>> Could we instead fix the bug there by reverting to the thread's DSCR value?
> 
> We really need to save it earlier, before the treclaim which will
> override it.

I'll try to improve this explanation as well.
 
>>> __switch_to() calls _switch
>>> 	_switch() saves the DSCR to thread.dscrTBEGIN
>>>
>>> The fix is to treat the DSCR similarly to the TAR and save it early
>>> in __switch_to().
>>>
>>> The program below will expose the problem:
>>
>>
>> Can you drop this in tools/testing/selftests/powerpc/tm ?
>>
>> You'll need to create that directory, you can ape the Makefile from the pmu
>> directory, it should be fairly obvious. See the pmu tests for how to integrate
>> with the test harness etc., or bug me if it's not straight forward.

Will do :-)

>>> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
>>> index 2737f46..3efd0e5 100644
>>> --- a/arch/powerpc/include/asm/switch_to.h
>>> +++ b/arch/powerpc/include/asm/switch_to.h
>>> @@ -16,13 +16,15 @@ struct thread_struct;
>>>  extern struct task_struct *_switch(struct thread_struct *prev,
>>>  				   struct thread_struct *next);
>>>  #ifdef CONFIG_PPC_BOOK3S_64
>>> -static inline void save_tar(struct thread_struct *prev)
>>> +static inline void save_early_sprs(struct thread_struct *prev)
>>>  {
>>>  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>>>  		prev->tar = mfspr(SPRN_TAR);
>>> +	if (cpu_has_feature(CPU_FTR_DSCR))
>>> +		prev->dscr = mfspr(SPRN_DSCR);
>>>  }
>>
>> Are we going to end up saving more SPRs in this code? What makes the TAR & DSCR
>> special vs everything else?
> 
> There are only a limited set of SPRs that TM checkpoints.  The full list
> is CR, LR, CTR, FPSCR, AMR, PPR, VRSAVE, VSCR, DSCR, and TAR.  
> 
> http://www.scribd.com/doc/142877680/PowerISA-v2-07#outer_page_826
> 
> CR, LR, CTR, PPR are handled really early in the exception handler
> 
> FPSCR, VSCR are done in the FP/VMX/VSX code.
> 
> AMR we don't care about.
> 
> That just leaves the DSCR and the TAR for here....
> 
> ... and the VRSAVE.  Sam: did you have a patch to save that one early
> too?  I think we talked about it but forgot, or did we decide that it's
> always broken anyway so we don't care? :-D

I thought we'd decided that VRSAVE was already probably broken ;-)

I haven't tested VRSAVE yet so we don't know if it's actually getting corrupted in this situation (although it seems likely), and from a quick look at the code it's not being treated like DSCR or TAR at the moment so I would need to investigate it separately.

> Mikey
> 
>> The nice thing about doing this in asm is it's nop'ed out for cpus that don't
>> have the DSCR. What does the generated code for this look like?
>>
>>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>>> index 662c6dd..a107f4a 100644
>>> --- a/arch/powerpc/kernel/entry_64.S
>>> +++ b/arch/powerpc/kernel/entry_64.S
>>> @@ -432,12 +432,6 @@ BEGIN_FTR_SECTION
>>>  	std	r24,THREAD_VRSAVE(r3)
>>>  END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>>>  #endif /* CONFIG_ALTIVEC */
>>> -#ifdef CONFIG_PPC64
>>> -BEGIN_FTR_SECTION
>>> -	mfspr	r25,SPRN_DSCR
>>> -	std	r25,THREAD_DSCR(r3)
>>> -END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
>>> -#endif
>>>  	and.	r0,r0,r22
>>>  	beq+	1f
>>>  	andc	r22,r22,r0
>>

I wondered a little about this as well. The C code calls this function:

static inline int cpu_has_feature(unsigned long feature)
{
	return (CPU_FTRS_ALWAYS & feature) ||
	       (CPU_FTRS_POSSIBLE
		& cur_cpu_spec->cpu_features
		& feature);
}

And if I'm extracting it correctly, it ends up like this (17 == SPRN_DSCR):

   0x0000000000000bac <__switch_to+108>:        rldicl. r8,r9,20,63
   0x0000000000000bb0 <__switch_to+112>:        beq     0xbc0 <__switch_to+128>
   0x0000000000000bb4 <__switch_to+116>:        mfspr   r9,17
   0x0000000000000bb8 <__switch_to+120>:        std     r9,4280(r31)
   0x0000000000000bbc <__switch_to+124>:        ld      r9,16(r10)

I don't think I can comment on it's performance myself; I'll wait for someone more knowledgeable :-)

Converting this to ASM could be out of scope for this fix, but it doesn't seem like it would be hard. (I assume we'd want to convert both the TAR and DSCR parts.)

>> cheers

Cheers,
Sam.
