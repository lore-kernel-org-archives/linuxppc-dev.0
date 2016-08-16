Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDRTt5QRmzDr4c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 08:14:10 +1000 (AEST)
Message-ID: <1471385632.19495.24.camel@kernel.crashing.org>
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, Holger Brunck
 <holger.brunck@keymile.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>
Date: Wed, 17 Aug 2016 08:13:52 +1000
In-Reply-To: <57B1EBAE.6030503@linux.intel.com>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
 <57B1EBAE.6030503@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-15 at 09:19 -0700, Dave Hansen wrote:
> 
> Wow, thanks for all the debugging here!

Yup, thanks, that's really odd... I wonder if one of those
structures is accessed beyond it's boundary, either the sigset
or the thread struct, causing corruption of neighbouring fields
in task struct...

Can you try adding a little canary on both sides (make it not-so-little 
maybe a few words) which you initialize to a known pattern and check
every now and then ?

> So, we know it has to do with signals, thread_info, and probably only
> affects 32-bit powerpc.  Seems awfully weird.  Have you checked with
> any
> of the 64-bit powerpc guys to see if they have any ideas?
> 
> I went grepping around for a bit.
> 
> Where is the task_struct stored?  Is it on-stack on ppc32 or
> something?

No it's allocated normally.

>  The thread_info is,

Yes, thread_info is at the bottom of stack

>  I assume, but I see some THREAD_INFO vs. THREAD
> (thread struct) math happening in here, which confuses me:
>  
>         .globl  ret_from_debug_exc
> ret_from_debug_exc:
>         mfspr   r9,SPRN_SPRG_THREAD
>         lwz     r10,SAVED_KSP_LIMIT(r1)
>         stw     r10,KSP_LIMIT(r9)
>         lwz     r9,THREAD_INFO-THREAD(r9)

This calculates the offset between the thread struct and the pointer
to thread info inside task struct and loads that pointer into r9

>         CURRENT_THREAD_INFO(r10, r1)
>         lwz     r10,TI_PREEMPT(r10)
>         stw     r10,TI_PREEMPT(r9)
>         RESTORE_xSRR(SRR0,SRR1);
>         RESTORE_xSRR(CSRR0,CSRR1);
>         RESTORE_MMU_REGS;
>         RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, PPC_RFDI)

Basically the above code transfers TI_PREEMPT from the "current"
thread info which I believe would be on some exception/interrupt
stack into the current task thread info.

> But, I'm really at a loss to explain this.  It still seems like a
> deeply
> ppc-specific issue.  We can obviously work around it with an #ifdef
> for
> your platform, but that's awfully hackish and hides the real bug,
> whatever it is.
> 
> My suspicion is that there's a bug in the 32-bit ppc assembly
> somewhere.
>  I don't see any references to 'blocked' or 'real_blocked' in
> assembly
> though.  You could add a bunch of padding instead of moving the
> thread_struct and see if that does anything, but that's really a stab
> in
> the dark.
