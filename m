Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 482A81007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 21:11:52 +1100 (EST)
Message-ID: <4EE724BD.3090709@windriver.com>
Date: Tue, 13 Dec 2011 18:11:09 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] ppc32/kprobe: complete kprobe and migrate exception
 frame
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>	
 <1323679853-31751-4-git-send-email-tiejun.chen@windriver.com>
 <1323731987.19891.40.camel@pasglop> <4EE6DA8C.8090107@windriver.com>
 <4EE70B13.7000102@windriver.com>
In-Reply-To: <4EE70B13.7000102@windriver.com>
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

Sorry please ignore this email since I'm missing something here :(

Tiejun

tiejun.chen wrote:
>>> You need to hook into "resume_kernel" instead.
>> Maybe I'm misunderstanding what you mean since as I recall you suggestion we
>> should do this at the end of do_work.
>>
> 
> I regenerate this with hooking into resume_kernel in below.
> 
>>> Also, we may want to simplify the whole thing, instead of checking user
>>> vs. kernel first etc... we could instead have a single _TIF_WORK_MASK
>>> which includes both the bits for user work and the new bit for kernel
>>> work. With preempt, the kernel work bits would also include
>>> _TIF_NEED_RESCHED.
>>>
>>> Then you have in the common exit path, a single test for that, with a
>>> fast path that skips everything and just goes to "restore" for both
>>> kernel and user.
>>>
>>> The only possible issue is the setting of dbcr0 for BookE and 44x and we
>>> can keep that as a special case keyed of MSR_PR in the resume path under
>>> ifdef BOOKE (we'll probably sanitize that later with some different
>>> rework anyway). 
>>>
>>> So the exit path because something like:
>>>
>>> ret_from_except:
>>> 	.. hard disable interrupts (unchanged) ...
>>> 	read TIF flags
>>> 	andi with _TIF_WORK_MASK
>>> 		nothing set -> restore
>>> 	check PR
>>> 		set -> do_work_user
>>> 		no set -> do_work_kernel (kprobes & preempt)
>>> 		(both loop until relevant _TIF flags are all clear)
>>> restore:
>>> 	#ifdef BOOKE & 44x test PR & do dbcr0 stuff if needed
>>> 	... nornal restore ...
>> Do you mean we should reorganize current ret_from_except for ppc32 as well?
> 
> I assume it may not necessary to reorganize ret_from_except for *ppc32*.
> 
>>>>  do_user_signal:			/* r10 contains MSR_KERNEL here */
>>>>  	ori	r10,r10,MSR_EE
>>>>  	SYNC
>>>> @@ -1202,6 +1204,30 @@ do_user_signal:			/* r10 contains MSR_KERNEL here */
>>>>  	REST_NVGPRS(r1)
>>>>  	b	recheck
>>>>  
>>>> +restore_kprobe:
>>>> +	lwz	r3,GPR1(r1)
>>>> +	subi    r3,r3,INT_FRAME_SIZE; /* Allocate a trampoline exception frame */
>>>> +	mr	r4,r1
>>>> +	bl	copy_exc_stack	/* Copy from the original to the trampoline */
>>>> +
>>>> +	/* Do real stw operation to complete stwu */
>>>> +	mr	r4,r1
>>>> +	addi	r4,r4,INT_FRAME_SIZE	/* Get kprobed entry */
>>>> +	lwz	r5,GPR1(r1)		/* Backup r1 */
>>>> +	stw	r4,GPR1(r1)		/* Now store that safely */
>>> The above confuses me. Shouldn't you do instead something like
>>>
>>> 	lwz	r4,GPR1(r1)
> 
> Now GPR1(r1) is already pointed with new r1 in emulate_step().
> 
>>> 	subi	r3,r4,INT_FRAME_SIZE
> 
> Here we need this, 'mr r4,r1', since r1 holds current exception stack.
> 
>>> 	li	r5,INT_FRAME_SIZE
>>> 	bl	memcpy
> 
> Then the current exception stack is migrated below the kprobed function stack.
> 
> stack flow:
> 
> --------------------------  -> old r1 when hit 'stwu r1, -AA(r1)' in our
>         ^       ^           kprobed function entry.
>         |       |
>         |       |------------> AA allocated for the kprobed function
>         |       |
>         |       v
> --------|-----------------  -> new r1, also GPR1(r1). It holds the kprobed
>    ^    |                   function stack , -AA(r1).
>    |    |
>    |    |--------------------> INT_FRAME_SIZE for program exception
>    |    |
>    |    v
> ---|---------------------  -> r1 is updated to hold program exception stack.
>    |
>    |
>    |------------------------> migrate the exception stack (r1) below the
>    |                        kprobed after memcpy with INT_FRAME_SIZE.
>    v
> -------------------------  -> reroute this as r1 for program exception stack.
> 
>> Anyway I'll try this if you think memcpy is fine/safe in exception return codes.
>>
>>> To start with, then you need to know the "old" r1 value which may or may
>>> not be related to your current r1. The emulation code should stash it
>> If the old r1 is not related to our current r1, it shouldn't be possible to go
>> restore_kprob since we set that new flag only for the current.
> 		
> If you agree what I say above, please check the follow:
> ======
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 56212bc..b6554c1 100644
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 56212bc..b6554c1 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -813,12 +813,40 @@ restore_user:
> 
>  #ifdef CONFIG_PREEMPT
>         b       restore
> +#endif
> 
> -/* N.B. the only way to get here is from the beq following ret_from_except. */
>  resume_kernel:
>         /* check current_thread_info->preempt_count */
>         rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
>         lwz     r0,TI_PREEMPT(r9)
> +       andis.  r0,r0,_TIF_EMULATE_STACK_STORE@h
> +       beq+    restore
> +
> +       lwz     r3,GPR1(r1)
> +       subi    r3,r3,INT_FRAME_SIZE    /* Allocate a trampoline exception frame */
> +       mr      r4,r1
> +       li      r5,INT_FRAME_SIZE
> +       bl      memcpy                  /* Copy from the original to the
> trampoline */
> +
> +       /* Do real store operation to complete stwu */
> +       addi    r4,r1,INT_FRAME_SIZE    /* Get the kprobed function entry */
> +       lwz     r5,GPR1(r1)
> +       stw     r4,0(r5)                /* Now store that safely */
> +
> +       /* Reroute the trampoline frame to r1 */
> +       subi    r1,r5,INT_FRAME_SIZE
> +
> +       /* Clear _TIF_EMULATE_STACK_STORE flag */
> +       rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
> +       lwz     r0,TI_FLAGS(r9)
> +       rlwinm  r0,r0,0,_TIF_EMULATE_STACK_STORE
> +       stw     r0,TI_FLAGS(r9)
> +
> +#ifdef CONFIG_PREEMPT
> +/* N.B. the only way to get here is from the beq following ret_from_except. */
> +       /* check current_thread_info->preempt_count */
> +       rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
> +       lwz     r0,TI_PREEMPT(r9)
>         cmpwi   0,r0,0          /* if non-zero, just restore regs and return */
>         bne     restore
>         lwz     r0,TI_FLAGS(r9)
> @@ -844,8 +872,6 @@ resume_kernel:
>          */
>         bl      trace_hardirqs_on
>  #endif
> -#else
> -resume_kernel:
>  #endif /* CONFIG_PREEMPT */
> 
>         /* interrupts are hard-disabled at this point */
> 
> Tiejun
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
