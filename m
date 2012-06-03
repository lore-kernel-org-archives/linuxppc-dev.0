Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CB3CB6FA9
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2012 15:02:45 +1000 (EST)
Message-ID: <4FCAEF8F.70305@windriver.com>
Date: Sun, 3 Jun 2012 13:01:03 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/3] ppc32/kprobe: complete kprobe and migrate exception
 frame
References: <1323946810-4868-1-git-send-email-tiejun.chen@windriver.com>
 <1323946810-4868-3-git-send-email-tiejun.chen@windriver.com>
 <1336621805.3881.38.camel@pasglop>
In-Reply-To: <1336621805.3881.38.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2012 11:50 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2011-12-15 at 19:00 +0800, Tiejun Chen wrote:
>> We can't emulate stwu since that may corrupt current exception stack.
>> So we will have to do real store operation in the exception return code.
>>
>> Firstly we'll allocate a trampoline exception frame below the kprobed
>> function stack and copy the current exception frame to the trampoline.
>> Then we can do this real store operation to implement 'stwu', and reroute
>> the trampoline frame to r1 to complete this exception migration.
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>  arch/powerpc/kernel/entry_32.S |   35 +++++++++++++++++++++++++++++++++++
>>  1 files changed, 35 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>> index 56212bc..0cdd27d 100644
>> --- a/arch/powerpc/kernel/entry_32.S
>> +++ b/arch/powerpc/kernel/entry_32.S
>> @@ -850,6 +850,41 @@ resume_kernel:
>>  
>>  	/* interrupts are hard-disabled at this point */
>>  restore:
>> +	lwz	r3,_MSR(r1)	/* Returning to user mode? */
>> +	andi.	r0,r3,MSR_PR
>> +	bne	1f	
> 
>  .../...
> 

Sorry for this delay response since I can't take time to do this last week :(

> Wouldn't it be better to use resume_kernel here ?

Agreed :)

> 
> IE. We already have restore_user vs. resume_kernel labels, including
> the PR test. In the !PREEMPT case, resume_kernel is empty but it's
> there, so you can just "populate" it, ie, something like:
> 
> restore_user:
> 	... existing dbcr0 stuff ...
> 	b restore
> 
> resume_kernel: <-- removed the ifdef CONFIG_PREEMPT
> 
> 	... Do the stack store business here...
> 
> #ifdef CONFIG_PREEMPT
> 	... move the preempt code here...
> #endif
> 
> restore:
> 	... existing stuff ...
> 
> Also, the added advantage is that the code to calc
> the thread info pointer and load the TI_FLAG can be
> shared now between your stuff and preempt, ie:
> 
> resume_kernel:
> 	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
> 	lwz	r0,TI_FLAGS(r9)
> 	andis.	r0,r0,_TIF_EMULATE_STACK_STORE@h
> 	bne-	emulate_stack_store
> #ifdef CONFIG_PREEMPT
> 	lwz	r8,TI_PREEMPT(r9) <-- note use of r8 instead of r0,
>                                       I -think- r8 can be clobbered
>                                       here but pls dbl check

Its should be safe.

> 	cmpwi	0,r8,0
> 	bne	restore
> 	andi.	r0,r0,_TIF_NEED_RESCHED
> 	etc...

Please check if next, v3, is fine.

>  	
>> +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
>> +	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
>> +	lwz	r0,TI_FLAGS(r9)
>> +	andis.	r0,r0,_TIF_EMULATE_STACK_STORE@h
>> +	beq+	1f	
>> +
>> +	addi	r9,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
>> +
>> +	lwz	r3,GPR1(r1)
>> +	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
>> +	mr	r4,r1			/* src:  current exception frame */
>> +	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
>> +	mr	r1,r3			/* Reroute the trampoline frame to r1 */
>> +	bl	memcpy			/* Copy from the original to the trampoline */
>> +
>> +	/* Do real store operation to complete stwu */
>> +	lwz	r5,GPR1(r1)
>> +	stw	r9,0(r5)
> 
> Ok, I think I -finally- understand your trick of using r1 +
> INT_FRAME_SIZE as the value to store :-) It makes sense and it's
> actually a nice hack :-)
> 
> I would recommend that in the C code part of the emulation, you
> add some sanity checking to make sure we don't overflow the
> kernel stack etc... it should come in generally handy especially
> if what's your trying to debug with kprobes is a kernel stack
> overflow :-)

Added.

> 
>> +	/* Clear _TIF_EMULATE_STACK_STORE flag */
>> +	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
>> +	lis	r11,_TIF_EMULATE_STACK_STORE@h
>> +	addi	r9,r9,TI_FLAGS
>> +0:	lwarx	r8,0,r9
>> +	andc	r8,r8,r11
>> +#ifdef CONFIG_IBM405_ERR77
>> +	dcbt	0,r9
>> +#endif
>> +	stwcx.	r8,0,r9
>> +	bne-	0b
>> +1:
>> +
>>  #ifdef CONFIG_44x
>>  BEGIN_MMU_FTR_SECTION
>>  	b	1f
> 
> BTW. Are you going to do a ppc64 variant of that patch ?

I'd like to go ppc64 ASAP once we did on ppc32 is good enough :)

Tiejun

> 
> Cheers,
> Ben.
> 
> 
> 
> 
