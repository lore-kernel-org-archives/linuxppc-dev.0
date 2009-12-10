Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5ED13B6F0C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 07:19:44 +1100 (EST)
Subject: Re: Floating point in the kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20091210131311.78cab78c@lappy.seanm.ca>
References: <20091210131311.78cab78c@lappy.seanm.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Dec 2009 07:19:39 +1100
Message-ID: <1260476379.16132.224.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-10 at 13:13 -0500, Sean MacLennan wrote:
> One of our drivers has code that was originally running on a DSP. The
> code makes heavy use of floating point. We have isolated all the
> floating point to one kthread in the driver. Using enable_kernel_fp()
> this has worked well.
> 
> But under a specific heavy RTP load, we started getting kernel panics.
> To make a long story short, the scheduler disables FP when you are
> context switched out. When you come back and access a FP instruction,
> you trap and call load_up_fpu() and everything is fine..... unless you
> are in the kernel. If you are in the kernel, like our kthread is, you
> get a "kernel FP unavailable exception".

Right, you must not use floating point in the kernel -and- expect it to
survive schedule. You should use preempt_disable() and ensure you don't
schedule() around a block using the FP.

Note that you may also lose the FP register content if you schedule.

> Basically we got away with it for two years because the thread is at
> high priority (-20) and tries very hard to finish within 1ms. But the
> RTP high load causes us to context switch out and crash. The following
> patch fixes this:
> 
> diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
> index 50504ae..3476de9 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -383,7 +383,7 @@ label:
>  #define FP_UNAVAILABLE_EXCEPTION                                             \
>         START_EXCEPTION(FloatingPointUnavailable)                             \
>         NORMAL_EXCEPTION_PROLOG;                                              \
> -       beq     1f;                                                           \
> +       /* SAM beq      1f; */                                          \
>         bl      load_up_fpu;            /* if from user, just load it up */   \
>         b       fast_exception_return;                                        \
>  1:     addi    r3,r1,STACK_FRAME_OVERHEAD;                                   \
> 
> With the patch we run fine, at the expense that we lose the ability to
> catch real FP unavailable exceptions in the kernel. It is because of
> this loss that I have not submitted this patch.

I'm not sure that will work in all cases, you are playing a bit with
fire :-) I suppose I could think it through after breakfast but my first
thought is "don't do that !". Among other things you may not have a
pt_regs to save the registers to.

> We also hit another problem under high RTP load... and this is the
> patch that fixes it:
> 
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index fc8f5b1..051a02c 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -83,6 +83,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>         stfd    fr0,THREAD_FPSCR(r4)
>         PPC_LL  r5,PT_REGS(r4)
>         toreal(r5)
> +
> +       /* Under heavy RTP load the hsp thread can have a NULL pt_regs. */
> +       PPC_LCMPI       0,r5,0
> +       beq     1f
> +

Right and that means you just lost the content of your FP registers.

>         PPC_LL  r4,_MSR-STACK_FRAME_OVERHEAD(r5)
>         li      r10,MSR_FP|MSR_FE0|MSR_FE1
>         andc    r4,r4,r10               /* disable FP for previous task */
> 
> So, if you are still reading this far, I am just looking for any
> suggestions. Are there better ways of handling this? Have I
> missed something? Anybody know why pt_regs might be NULL?

Just don't schedule when you enable_kernel_fp() or move your workload to
userspace :-)

Cheers,
Ben.

> Cheers,
>    Sean
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
