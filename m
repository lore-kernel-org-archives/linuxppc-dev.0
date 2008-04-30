Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB725DDF62
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:13:23 +1000 (EST)
Message-Id: <12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209592495.18023.246.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
Date: Wed, 30 Apr 2008 17:13:14 -0500
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 4:54 PM, Benjamin Herrenschmidt wrote:
>
> On Wed, 2008-04-30 at 04:27 -0500, Kumar Gala wrote:
>> * Cleanup the code a bit my allocating an INT_FRAME on our exception
>>  stack there by make references go from GPR11-INT_FRAME_SIZE(r8) to
>>  just GPR(r8)
>            ^^ 11 ?

r8 is correct for my example.  My point is s/GPR11-INT_FRAME_SIZE/GPR11/

>> * simplify {lvl}_transfer_to_handler code by moving the copying of  
>> the
>>  temp registers we use if we come from user space into the PROLOG
>> * If the exception came from kernel mode copy thread_info flags,
>>  preempt, and task pointer from the process thread_info.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>
>> I'm not sure if the copying of TI_FLAGS, TI_PREEMPT, and TI_TASK
>> are really needed.  I'm a bit concerned what to do if we get a
>> CriticalInput while in kernel mode and the handler causes a  
>> reschedule.
>
> Well, reschedule or signal, either way, you can't handle them on the  
> way
> out. Maybe an option there is to set the flag in the normal kernel
> stack's thread info and trigger an interrupt asap via the PIT so  
> things
> get handled ?

If we don't handle reschedule or signal will we actually not function  
properly?  I assume reschedule isn't an issue, but could we lose a  
signal?

>> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/ 
>> head_booke.h
>> index d647e05..78baec5 100644
>> --- a/arch/powerpc/kernel/head_booke.h
>> +++ b/arch/powerpc/kernel/head_booke.h
>> @@ -78,12 +78,12 @@
>> 	slwi	r8,r8,2;				\
>> 	addis	r8,r8,level##_STACK_TOP@ha;		\
>> 	lwz	r8,level##_STACK_TOP@l(r8);		\
>> -	addi	r8,r8,THREAD_SIZE;
>> +	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
>> #else
>> #define BOOKE_LOAD_EXC_LEVEL_STACK(level)		\
>> 	lis	r8,level##_STACK_TOP@ha;		\
>> 	lwz	r8,level##_STACK_TOP@l(r8);		\
>> -	addi	r8,r8,THREAD_SIZE;
>> +	addi	r8,r8,THREAD_SIZE-INT_FRAME_SIZE;
>> #endif
>
> Nothing specific to your patch, but those level##_STACK_TOP seem to
> be pretty badly named if you end up -adding- THREAD_SIZE to actually
> get to the stack's top. Do they really contain the stack top or do
> they in fact contain the stack base/bottom ?

That might be stale from how the old code worked.  I can never  
remember what we consider the top and bottom of the stack.  (please  
remind me and I'll fixup the comments and variables).

>> /*
>> @@ -97,22 +97,35 @@
>> #define EXC_LEVEL_EXCEPTION_PROLOG(exc_level, exc_level_srr0,  
>> exc_level_srr1) \
>> 	mtspr	exc_level##_SPRG,r8;					     \
>> 	BOOKE_LOAD_EXC_LEVEL_STACK(exc_level);/* r8 points to the  
>> exc_level stack*/ \
>> -	stw	r10,GPR10-INT_FRAME_SIZE(r8);				     \
>> -	stw	r11,GPR11-INT_FRAME_SIZE(r8);				     \
>> +	stw	r9,GPR9(r8);		/* save various registers	   */\
>> +	stw	r10,GPR10(r8);						     \
>> +	stw	r11,GPR11(r8);						     \
>> +	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
>> +	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
>> +	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE; /* Alloc exception frm */\
>
> So you do the above whether it will actually be needed or not right ?

good point I can move this down.

>> 	mfcr	r10;			/* save CR in r10 for now	   */\
>> -	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
>> -	andi.	r11,r11,MSR_PR;						     \
>> -	mr	r11,r8;							     \
>> -	mfspr	r8,exc_level##_SPRG;					     \
>> +	mfspr	r9,exc_level_srr1;	/* check whether user or kernel    */\
>> +	andi.	r9,r9,MSR_PR;						     \
>> 	beq	1f;							     \
>> 	/* COMING FROM USER MODE */					     \
>> -	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\
>> -	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
>> -	addi	r11,r11,THREAD_SIZE;					     \
>> -1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame      
>> */\
>> +	lwz	r9,GPR9(r8);		/* copy regs from exception stack  */\
>> +	stw	r9,GPR9(r11);						     \
>> +	lwz	r9,GPR10(r8);						     \
>> +	stw	r9,GPR10(r11);						     \
>> +	lwz	r9,GPR11(r8);						     \
>> +	stw	r9,GPR11(r11);						     \
>> +	b	2f;							     \
>
> Are we concerned with performances here or not ? Because using the  
> same
> reg all along isn't the best ...

I thought about that.  The only case its a bit of an issue is for  
CriticalInput.  I don't see Watchdog, Debug, or MachineCheck as being  
performance critical.  I can use r10 if I save and restored the CR or  
some other register.

>> +	/* COMING FROM PRIV MODE */					     \
>> +1:	lwz	r9,TI_FLAGS-THREAD_SIZE(r11);				     \
>> +	stw	r9,TI_FLAGS-THREAD_SIZE(r8);				     \
>> +	lwz	r9,TI_PREEMPT-THREAD_SIZE(r11);				     \
>> +	stw	r9,TI_PREEMPT-THREAD_SIZE(r8);				     \
>> +	lwz	r9,TI_TASK-THREAD_SIZE(r11);				     \
>> +	stw	r9,TI_TASK-THREAD_SIZE(r8);				     \
>> +	mr	r11,r8;							     \
>
> Don't you want to also stick in HARDIRQ_OFFSET in preempt_count or
> leave that to C code ?

just leaving it to C code.  I assume that preempt_count should be the  
same value on entry and exit.  Do think we should set HARDIRQ_OFFSET  
for debug level exceptions?

> Also, you might want at one point to tell
> lockdep about IRQs being disabled in case they were enabled when
> you took the exception. (Do that after you've saved enough
> stuff of crouse)

Where should I look for an example of how to convey that information  
to lockdep?

- k
