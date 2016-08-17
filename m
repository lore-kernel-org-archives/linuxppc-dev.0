Return-Path: <prvs=0037b07ebe=holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDspN27StzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 00:59:55 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Dave Hansen <dave.hansen@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
 <57B1EBAE.6030503@linux.intel.com>
CC: "mingo@kernel.org" <mingo@kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
From: Holger Brunck <holger.brunck@keymile.com>
Message-ID: <e5cbd015-eeb5-31b5-0829-14cc8500dc6d@keymile.com>
Date: Wed, 17 Aug 2016 16:59:45 +0200
MIME-Version: 1.0
In-Reply-To: <57B1EBAE.6030503@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/08/16 18:19, Dave Hansen wrote:
> On 08/15/2016 07:35 AM, Holger Brunck wrote:
>> I tried this but unfortunately the error only occurs while remote debugging.
>> Locally with gdb everything works fine. BTW we double-checked with a 85xx ppc
>> target which is also 32-bit and it ends up with the same behaviour.
>>
>> I was also investigating where I have to move the line in the struct task_struct
>> and it turns out to be like this (diff to 4.7 kernel):
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 253538f..4868874 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1655,7 +1655,9 @@ struct task_struct {
>>         struct signal_struct *signal;
>>         struct sighand_struct *sighand;
>>
>> +       // struct thread_struct thread;   // until here everything is fine
>>         sigset_t blocked, real_blocked;
>> +       struct thread_struct thread;      // from here it's broken
>>         sigset_t saved_sigmask; /* restored if set_restore_sigmask() was used */
>>         struct sigpending pending;
> 
> Wow, thanks for all the debugging here!
> 
> So, we know it has to do with signals, thread_info, and probably only
> affects 32-bit powerpc.  Seems awfully weird.  Have you checked with any
> of the 64-bit powerpc guys to see if they have any ideas?
> 
> I went grepping around for a bit.
> 
> Where is the task_struct stored?  Is it on-stack on ppc32 or something?
>  The thread_info is, I assume, but I see some THREAD_INFO vs. THREAD
> (thread struct) math happening in here, which confuses me:
> 
>         .globl  ret_from_debug_exc
> ret_from_debug_exc:
>         mfspr   r9,SPRN_SPRG_THREAD
>         lwz     r10,SAVED_KSP_LIMIT(r1)
>         stw     r10,KSP_LIMIT(r9)
>         lwz     r9,THREAD_INFO-THREAD(r9)
>         CURRENT_THREAD_INFO(r10, r1)
>         lwz     r10,TI_PREEMPT(r10)
>         stw     r10,TI_PREEMPT(r9)
>         RESTORE_xSRR(SRR0,SRR1);
>         RESTORE_xSRR(CSRR0,CSRR1);
>         RESTORE_MMU_REGS;
>         RET_FROM_EXC_LEVEL(SPRN_DSRR0, SPRN_DSRR1, PPC_RFDI)
> 

yeah but here you are in arch/powerpc/kernel/head_booke.h and IIUIC my
architecture uses arch/powerpc/kernel/head_32.S

Some small updates from my side. I was able to simplify the setup. I don't need
my (quite complex) application. I now have a small C - program which starts
three threads simply running a while loop and doing printouts every now and
then. And I still can reproduce the error. So we simply need threads a gdbserver
session, ppc32 and a single step while the threads are already running.

I added some debug prints within the kernel common signal code and the specific
powerpc code and enabled the debug trace from the gdbserver. What I see is that
gdbserver sends for each thread a SIGSTOP to the kernel and waits for a
response. The kernel does receive all the signals but only respond to some of
them in the error case. Which then matches with my "ps" output as I see that
some threads are not in the state pthread_stop and then the gdbserver gets
suspended. I think the interesting part is in arch/powerpc/kernel/signal_32.c
with it's function handle_signal32. For the threads successfully stopped this
function is called once. If the kernel receives two SIGSTOP before calling the
function we end up in the error case. Now my question does anyone know if this
function should handle several pending signals at once if present or will it be
called once per signal?

> But, I'm really at a loss to explain this.  It still seems like a deeply
> ppc-specific issue.  We can obviously work around it with an #ifdef for
> your platform, but that's awfully hackish and hides the real bug,
> whatever it is.
> 

what I could do is to reuse the define CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and
if it's not set I use the thread_struct at it's old position. I know it would
only mask the error and I guess it's not acceptable for mainline but as my time
is limited I could live with such an OOT patch for my board.

Best regards
Holger
