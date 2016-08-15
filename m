Return-Path: <dave.hansen@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sCghB2RcczDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 02:20:25 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Holger Brunck <holger.brunck@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <57B1EBAE.6030503@linux.intel.com>
Date: Mon, 15 Aug 2016 09:19:58 -0700
MIME-Version: 1.0
In-Reply-To: <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2016 07:35 AM, Holger Brunck wrote:
> I tried this but unfortunately the error only occurs while remote debugging.
> Locally with gdb everything works fine. BTW we double-checked with a 85xx ppc
> target which is also 32-bit and it ends up with the same behaviour.
> 
> I was also investigating where I have to move the line in the struct task_struct
> and it turns out to be like this (diff to 4.7 kernel):
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 253538f..4868874 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1655,7 +1655,9 @@ struct task_struct {
>         struct signal_struct *signal;
>         struct sighand_struct *sighand;
> 
> +       // struct thread_struct thread;   // until here everything is fine
>         sigset_t blocked, real_blocked;
> +       struct thread_struct thread;      // from here it's broken
>         sigset_t saved_sigmask; /* restored if set_restore_sigmask() was used */
>         struct sigpending pending;

Wow, thanks for all the debugging here!

So, we know it has to do with signals, thread_info, and probably only
affects 32-bit powerpc.  Seems awfully weird.  Have you checked with any
of the 64-bit powerpc guys to see if they have any ideas?

I went grepping around for a bit.

Where is the task_struct stored?  Is it on-stack on ppc32 or something?
 The thread_info is, I assume, but I see some THREAD_INFO vs. THREAD
(thread struct) math happening in here, which confuses me:

        .globl  ret_from_debug_exc
ret_from_debug_exc:
        mfspr   r9,SPRN_SPRG_THREAD
        lwz     r10,SAVED_KSP_LIMIT(r1)
        stw     r10,KSP_LIMIT(r9)
        lwz     r9,THREAD_INFO-THREAD(r9)
        CURRENT_THREAD_INFO(r10, r1)
        lwz     r10,TI_PREEMPT(r10)
        stw     r10,TI_PREEMPT(r9)
        RESTORE_xSRR(SRR0,SRR1);
        RESTORE_xSRR(CSRR0,CSRR1);
        RESTORE_MMU_REGS;
        RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, PPC_RFDI)

But, I'm really at a loss to explain this.  It still seems like a deeply
ppc-specific issue.  We can obviously work around it with an #ifdef for
your platform, but that's awfully hackish and hides the real bug,
whatever it is.

My suspicion is that there's a bug in the 32-bit ppc assembly somewhere.
 I don't see any references to 'blocked' or 'real_blocked' in assembly
though.  You could add a bunch of padding instead of moving the
thread_struct and see if that does anything, but that's really a stab in
the dark.
