Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 166541007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 15:55:21 +1100 (EST)
Message-ID: <4EE6DA8C.8090107@windriver.com>
Date: Tue, 13 Dec 2011 12:54:36 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] ppc32/kprobe: complete kprobe and migrate exception
 frame
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>	
 <1323679853-31751-4-git-send-email-tiejun.chen@windriver.com>
 <1323731987.19891.40.camel@pasglop>
In-Reply-To: <1323731987.19891.40.camel@pasglop>
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

Benjamin Herrenschmidt wrote:
> On Mon, 2011-12-12 at 16:50 +0800, Tiejun Chen wrote:
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
>>  arch/powerpc/kernel/entry_32.S |   26 ++++++++++++++++++++++++++
>>  1 files changed, 26 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>> index 56212bc..d56e311 100644
>> --- a/arch/powerpc/kernel/entry_32.S
>> +++ b/arch/powerpc/kernel/entry_32.S
>> @@ -1185,6 +1185,8 @@ recheck:
>>  	bne-	do_resched
>>  	andi.	r0,r9,_TIF_USER_WORK_MASK
>>  	beq	restore_user
>> +	andis.	r0,r9,_TIF_DELAYED_KPROBE@h
>> +	bne-	restore_kprobe
> 
> Same comment as earlier about name. Note that you're not hooking in the
> right place. "recheck" is only reached if you -already- went out of the
> normal exit path and only when going back to user space unless I'm
> missing something (which is really the case you don't care about).
> 
> You need to hook into "resume_kernel" instead.

Maybe I'm misunderstanding what you mean since as I recall you suggestion we
should do this at the end of do_work.

> 
> Also, we may want to simplify the whole thing, instead of checking user
> vs. kernel first etc... we could instead have a single _TIF_WORK_MASK
> which includes both the bits for user work and the new bit for kernel
> work. With preempt, the kernel work bits would also include
> _TIF_NEED_RESCHED.
> 
> Then you have in the common exit path, a single test for that, with a
> fast path that skips everything and just goes to "restore" for both
> kernel and user.
> 
> The only possible issue is the setting of dbcr0 for BookE and 44x and we
> can keep that as a special case keyed of MSR_PR in the resume path under
> ifdef BOOKE (we'll probably sanitize that later with some different
> rework anyway). 
> 
> So the exit path because something like:
> 
> ret_from_except:
> 	.. hard disable interrupts (unchanged) ...
> 	read TIF flags
> 	andi with _TIF_WORK_MASK
> 		nothing set -> restore
> 	check PR
> 		set -> do_work_user
> 		no set -> do_work_kernel (kprobes & preempt)
> 		(both loop until relevant _TIF flags are all clear)
> restore:
> 	#ifdef BOOKE & 44x test PR & do dbcr0 stuff if needed
> 	... nornal restore ...

Do you mean we should reorganize current ret_from_except for ppc32 as well?

> 
>>  do_user_signal:			/* r10 contains MSR_KERNEL here */
>>  	ori	r10,r10,MSR_EE
>>  	SYNC
>> @@ -1202,6 +1204,30 @@ do_user_signal:			/* r10 contains MSR_KERNEL here */
>>  	REST_NVGPRS(r1)
>>  	b	recheck
>>  
>> +restore_kprobe:
>> +	lwz	r3,GPR1(r1)
>> +	subi    r3,r3,INT_FRAME_SIZE; /* Allocate a trampoline exception frame */
>> +	mr	r4,r1
>> +	bl	copy_exc_stack	/* Copy from the original to the trampoline */
>> +
>> +	/* Do real stw operation to complete stwu */
>> +	mr	r4,r1
>> +	addi	r4,r4,INT_FRAME_SIZE	/* Get kprobed entry */
>> +	lwz	r5,GPR1(r1)		/* Backup r1 */
>> +	stw	r4,GPR1(r1)		/* Now store that safely */
> 
> The above confuses me. Shouldn't you do instead something like
> 
> 	lwz	r4,GPR1(r1)
> 	subi	r3,r4,INT_FRAME_SIZE
> 	li	r5,INT_FRAME_SIZE
> 	bl	memcpy
> 

Anyway I'll try this if you think memcpy is fine/safe in exception return codes.

> To start with, then you need to know the "old" r1 value which may or may
> not be related to your current r1. The emulation code should stash it

If the old r1 is not related to our current r1, it shouldn't be possible to go
restore_kprob since we set that new flag only for the current.

If I'm wrong please correct me :)

Thanks
Tiejun

> into the int frame in an unused slot such as "orig_gpr3" (since that
> only pertains to restarting syscalls which we aren't doing here).
> 
> Then you adjust your r1 and do something like
> 
> 	lwz	r3,GPR1(r1)
> 	lwz	r0,ORIG_GPR3(r1)
> 	stw	r0,0(r3)
> 
> To perform the store, before doing the rest:
>  
>> +	/* Reroute the trampoline frame to r1 */
>> +	subi    r5,r5,INT_FRAME_SIZE
>> +	mr	r1,r5
>> +
>> +	/* Clear _TIF_DELAYED_KPROBE flag */
>> +	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
>> +	lwz	r0,TI_FLAGS(r9)
>> +	rlwinm	r0,r0,0,_TIF_DELAYED_KPROBE
>> +	stw	r0,TI_FLAGS(r9)
>> +
>> +	b	restore
>> +
>>  /*
>>   * We come here when we are at the end of handling an exception
>>   * that occurred at a place where taking an exception will lose
