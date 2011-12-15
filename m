Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E83C81007D7
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2011 11:37:46 +1100 (EST)
Message-ID: <1323909460.21839.42.camel@pasglop>
Subject: Re: [PATCH 3/4] ppc32/kprobe: complete kprobe and migrate exception
 frame
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Date: Thu, 15 Dec 2011 11:37:40 +1100
In-Reply-To: <4EE72AB8.4090502@windriver.com>
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>
 <1323679853-31751-4-git-send-email-tiejun.chen@windriver.com>
 <1323731987.19891.40.camel@pasglop> <4EE6DA8C.8090107@windriver.com>
 <4EE72AB8.4090502@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-12-13 at 18:36 +0800, tiejun.chen wrote:
> >> You need to hook into "resume_kernel" instead.
> >
> 
> I regenerate this with hooking into resume_kernel in below.

 .../...

> I assume it may not necessary to reorganize ret_from_except for *ppc32* .

It might be cleaner but I can do that myself later.

> >>>  do_user_signal:			/* r10 contains MSR_KERNEL here */
> >>>  	ori	r10,r10,MSR_EE
> >>>  	SYNC
> >>> @@ -1202,6 +1204,30 @@ do_user_signal:			/* r10 contains MSR_KERNEL here */
> >>>  	REST_NVGPRS(r1)
> >>>  	b	recheck
> >>>  
> >>> +restore_kprobe:
> >>> +	lwz	r3,GPR1(r1)
> >>> +	subi    r3,r3,INT_FRAME_SIZE; /* Allocate a trampoline exception frame */
> >>> +	mr	r4,r1
> >>> +	bl	copy_exc_stack	/* Copy from the original to the trampoline */
> >>> +
> >>> +	/* Do real stw operation to complete stwu */
> >>> +	mr	r4,r1
> >>> +	addi	r4,r4,INT_FRAME_SIZE	/* Get kprobed entry */
> >>> +	lwz	r5,GPR1(r1)		/* Backup r1 */
> >>> +	stw	r4,GPR1(r1)		/* Now store that safely */
> >> The above confuses me. Shouldn't you do instead something like
> >>
> >> 	lwz	r4,GPR1(r1)
> 
> Now GPR1(r1) is already pointed with new r1 in emulate_step().

Right

> >> 	subi	r3,r4,INT_FRAME_SIZE
> 
> Here we need this, 'mr r4,r1', since r1 holds current exception stack.

Right.

> >> 	li	r5,INT_FRAME_SIZE
> >> 	bl	memcpy
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

I see so you simply assume that the old r1 value is the current r1 +
INT_FRAME_SIZE, which is probably fair enough.

BTW. we should probably WARN_ON if emulate_step tries to set the new TIF
flag and sees it already set since that means we'll lose the previous
value.

> >>
> > 
> > Anyway I'll try this if you think memcpy is fine/safe in exception return codes.
> > 
> >> To start with, then you need to know the "old" r1 value which may or may
> >> not be related to your current r1. The emulation code should stash it
> > 
> > If the old r1 is not related to our current r1, it shouldn't be possible to go
> > restore_kprob since we set that new flag only for the current.
> > 
> > If I'm wrong please correct me :)
> 
> If you agree what I say above, and its also avoid any issue introduced with
> orig_gpr3, please check the follow:
> =========
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 56212bc..277029d 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -813,9 +813,40 @@ restore_user:
> 
>  #ifdef CONFIG_PREEMPT
>         b       restore
> +#endif

The above means that if !PREEMPT, a userspace return -will- fo into
your new code, while with PREEMPT it won't. This is inconsistent. Now
we should never need that for userspace returns (and indeed you should
double check in emulate step that you are only applying this when
regs->msr & MSR_PR is 0). The above branch should basically become
unconditional.

> -/* N.B. the only way to get here is from the beq following ret_from_except. */
>  resume_kernel:
> +#ifdef CONFIG_KPROBES

Don't make this KPROBES specific. Anything using emulate_step (such as
xmon) might need that too.

> +       /* check current_thread_info, _TIF_EMULATE_STACK_STORE */
> +       rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
> +       lwz     r0,TI_FLAGS(r9)
> +       andis.  r0,r0,_TIF_EMULATE_STACK_STORE@h
> +       beq+    restore_kernel

So you are introducing a new symbol restore_kernel, you could just
branch to "restore". However, that would mean putting the preempt
case before the kprobe case. But don't we want to do that anyway ?

I don't like keeping that "offsetted" return stack accross a preempt.

> +       addi    r9,r1,INT_FRAME_SIZE    /* Get the kprobed function entry */
> +
> +       lwz     r3,GPR1(r1)
> +       subi    r3,r3,INT_FRAME_SIZE    /* dst: Allocate a trampoline exception
> frame */
> +       mr      r4,r1                   /* src:  current exception frame */
> +       li      r5,INT_FRAME_SIZE       /* size: INT_FRAME_SIZE */
> +       mr      r1,r3                   /* Reroute the trampoline frame to r1 */
> +       bl      memcpy                  /* Copy from the original to the
> trampoline */
> +
> +       /* Do real store operation to complete stwu */
> +       lwz     r5,GPR1(r1)
> +       stw     r9,0(r5)
>
> +       /* Clear _TIF_EMULATE_STACK_STORE flag */
> +       rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
> +       lwz     r0,TI_FLAGS(r9)
> +       rlwinm  r0,r0,0,_TIF_EMULATE_STACK_STORE
> +       stw     r0,TI_FLAGS(r9)

I think this needs to be an atomic operation, another CPU can be trying
to set _NEED_RESCHED at the same time.

> +restore_kernel:
> +#endif
> +
> +#ifdef CONFIG_PREEMPT
> +/* N.B. the only way to get here is from the beq following ret_from_except. */
>         /* check current_thread_info->preempt_count */
>         rlwinm  r9,r1,0,0,(31-THREAD_SHIFT)
>         lwz     r0,TI_PREEMPT(r9)
> @@ -844,8 +875,6 @@ resume_kernel:
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

Cheers,
Ben.
