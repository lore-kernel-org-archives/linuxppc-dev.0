Return-Path: <dvhltc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28E1FB6EEE
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 17:13:31 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o767AqFL003534
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Aug 2010 03:10:52 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o767DSGN1957974
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Aug 2010 03:13:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o767DQnC013231
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Aug 2010 04:13:28 -0300
Message-ID: <4C5BB613.6050002@us.ibm.com>
Date: Fri, 06 Aug 2010 00:13:23 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com> <4C491E14.9010100@us.ibm.com>
	<1279861767.1970.73.camel@pasglop> <4C5B7114.8030009@us.ibm.com>
	<20100806050936.GI3282@dirshya.in.ibm.com>
In-Reply-To: <20100806050936.GI3282@dirshya.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2010 10:09 PM, Vaidyanathan Srinivasan wrote:
> * Darren Hart<dvhltc@us.ibm.com>  [2010-08-05 19:19:00]:
> 
>> On 07/22/2010 10:09 PM, Benjamin Herrenschmidt wrote:
>>> On Thu, 2010-07-22 at 21:44 -0700, Darren Hart wrote:
>>>
>>>>    suggestion I updated the instrumentation to display the
>>>> local_save_flags and irqs_disabled_flags:
>>>
>>>> Jul 22 23:36:58 igoort1 kernel: local flags: 0, irqs disabled: 1
>>>> Jul 22 23:36:58 igoort1 kernel: before H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
>>>> Jul 22 23:36:58 igoort1 kernel: after H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
>>>>
>>>> I'm not sure if I'm reading that right, but I believe interrupts are
>>>> intended to be disabled here. If accomplished via the
>>>> spin_lock_irqsave() this would behave differently on RT. However, this
>>>> path disables the interrupts handled by xics, all but the IPIs anyway.
>>>> On RT I disabled the decrementer as well.
>>>>
>>>> Is it possible for RT to be receiving other interrupts here?
>>>
>>> Also you may want to call hard_irq_disable() to -really- disable
>>> interrupts ... since we do lazy-disable on powerpc
>>>
>>
>> A quick update and request for direction wrt the cede hcall, interrupt handling, and the stack pointer.
>>
>> I've added patches one at a time, eliminating bugs with preempt_rt
>> (tip/rt/head). With my current patchset I have no crashes with a single run of
>> random_online.sh (stress testing to hit the hang will sees is my todo for
>> tomorrow).
>>
>> Current patchset includes:
>> patches/0001-wms-fix01.patch # P7 lazy flushing thing
>>
>> # next four are sent to / queued for mainline
>> patches/powerpc-increase-pseries_cpu_die-delay.patch
>> patches/powerpc-enable-preemption-before-cpu_die.patch
>> patches/powerpc-silence-__cpu_up-under-normal-operation.patch
>> patches/powerpc-silence-xics_migrate_irqs_away-during-cpu-offline.patch
>>
>> # this one needs to be cleaned up and sent to mainline
>> patches/powerpc-wait-for-cpu-to-go-inactive.patch
>>
>> patches/powerpc-disable-decrementer-on-offline.patch
>> patches/powerpc-cpu_die-preempt-hack.patch # reset preempt_count to 0 after cede
>> patches/powerpc-cede-processor-inst.patch # instrumentation
>> patches/powerpc-hard_irq_disable.patch # hard_irq_disable before cede
>> patches/powerpc-pad-thread_info.patch
>>
>> I didn't include all the patches as the relevant bits are included below in
>> code form.
>>
>> With the instrumentation, it's clear the change to preempt_count() is targeted
>> (since I added padding before and after preempt_count in the thread_info
>> struct) and preempt_count is still changed. It is also clear that it isn't just
>> a stray decrement since I set preempt_count() to 4 prior to calling cede and it
>> still is 0xffffffff after the hcall. Also note that the stack pointer doesn't
>> change across the cede call and neither does any other part of the thread_info
>> structure.
>>
>> Adding hard_irq_disable() did seem to affect things somewhat. Rather than a
>> serialized list of before/after thread_info prints around cede, I see
>> several befores then several afters. But the preempt_count is still modified.
>>
>> The relevant code looks like this (from pseries_mach_cpu_die())
>>
>>                          hard_irq_disable(); /* this doesn't fix things... but
>> 			                       does change behavior a bit */
>>                          preempt_count() = 0x4;
>>                          asm("mr %0,1" : "=r" (sp));  /* stack pointer is in R1 */
>>                          printk("before cede: sp=%lx pcnt=%x\n", sp, preempt_count());
>>                          print_thread_info();
>>                          extended_cede_processor(cede_latency_hint);
>>                          asm("mr %0,1" : "=r" (sp));
>>                          printk("after cede: sp=%lx pcnt=%x\n", sp, preempt_count());
>>                          print_thread_info();
>>                          preempt_count() = 0;
>>
>>
>> With these patches applied, the output across cede looks like:
>>
>> before cede: sp=c000000000b57150 pcnt=4
>> *** current->thread_info ***
>> ti->task: c000000000aa1410
>> ti->exec_domain: c000000000a59958
>> ti->cpu: 0
>> ti->stomp_on_me: 57005 /* 0xDEAD - forgot to print in hex */
>> ti->preempt_count: 4
>> ti->stomp_on_me_too: 48879 /* 0xBEEF - forgot to print in hex */
>> ti->local_flags: 0
>> *** end thread_info ***
>> after cede: sp=c000000000b57150 pcnt=ffffffff
>> *** current->thread_info ***
>> ti->task: c000000000aa1410
>> ti->exec_domain: c000000000a59958
>> ti->cpu: 0
> 
> Is this print sufficient to prove that we did not jump CPU?

Probably not, but the following should be sufficient. Note that the
dump occurs on "CPU: 6" which matches the CPU noted in the ti->cpu
before and after the cede call.

*** current->thread_info ***
ti->task: c00000008e7b2240
ti->exec_domain: c000000000a59958
ti->cpu: 6
ti->stomp_on_me: 57005
ti->preempt_count: 4
ti->stomp_on_me_too: 48879
ti->local_flags: 0
*** end thread_info ***
------------[ cut here ]------------
Badness at kernel/sched.c:3698
NIP: c0000000006987e4 LR: c0000000006987c8 CTR: c00000000005c668
REGS: c00000010e713800 TRAP: 0700   Not tainted  (2.6.33-rt-dvhrt05-02358-g61223dd-dirty)
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 24000082  XER: 20000000
TASK = c00000008e7b2240[0] 'swapper' THREAD: c00000010e710000 CPU: 6
GPR00: 0000000000000000 c00000010e713a80 c000000000b54f88 0000000000000001 
GPR04: c00000010e713d08 ffffffffffffffff 00000000000000e0 800000000d049138 
GPR08: 0000000000000000 c000000000ca5420 0000000000000001 c000000000bc22e8 
GPR12: 0000000000000002 c000000000ba5080 0000000000000000 000000000f394b6c 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: c000000000ba50c0 0000000000000004 0000000000000002 0000000000000000 
GPR24: 0000000000000004 c00000010e713cd0 c0000000009f1ecc c00000000088aaff 
GPR28: 0000000000000000 0000000000000001 c000000000ad7610 c00000010e713a80 
NIP [c0000000006987e4] .add_preempt_count+0x6c/0xe0
LR [c0000000006987c8] .add_preempt_count+0x50/0xe0
Call Trace:
[c00000010e713a80] [c00000010e713b30] 0xc00000010e713b30 (unreliable)
[c00000010e713b10] [c0000000000824b4] .vprintk+0xac/0x480
[c00000010e713c40] [c00000000069bcbc] .printk+0x48/0x5c
[c00000010e713cd0] [c00000000005c190] .pseries_mach_cpu_die+0x1c4/0x39c
[c00000010e713db0] [c00000000001e7e0] .cpu_die+0x4c/0x68
[c00000010e713e30] [c000000000017de0] .cpu_idle+0x1f8/0x220
[c00000010e713ed0] [c0000000006a17c4] .start_secondary+0x394/0x3d4
[c00000010e713f90] [c000000000008264] .start_secondary_prolog+0x10/0x14
Instruction dump:
78290464 80090018 2f800000 40fc002c 4bd089c1 60000000 2fa30000 419e006c 
e93e87e0 80090000 2f800000 409e005c <0fe00000> 48000054 e97e8398 78290464 
after cede: sp=c00000010e713cd0 pcnt=ffffffff
*** current->thread_info ***
ti->task: c00000008e7b2240
ti->exec_domain: c000000000a59958
ti->cpu: 6
ti->stomp_on_me: 57005
ti->preempt_count: fffffffe
ti->stomp_on_me_too: 48879
ti->local_flags: 0
*** end thread_info ***


> We agree that decrementer can possibly expire and we could have gone
> to the handler and come back just like we would do in an idle loop.

I disable the decrementer in the stop_cpu path... that may not be
sufficient for the pseries_mach_cpu_die() path, I'll have to experiment.

However, even if it did, it shouldn't be just changing the value,
especially not to something illegal.

> This will not happen always, but I could see a window of time during
> which this may happen.  But that should not change the preempt_count
> unconditionally to -1 with the same stack pointer.
> 
>> ti->stomp_on_me: 57005
>> ti->preempt_count: ffffffff
>> ti->stomp_on_me_too: 48879
>> ti->local_flags: 0
> 
> Is there a method to identify whether we had executed any of the
> interrupt handler while in this code?

I'd like to know as well. If anyone knows, please share. Otherwise
I'll be trying to sort that out tomorrow.

> 
>> *** end thread_info ***
>>
>> Are there any additional thoughts on what might be causing preempt_count to change?
>> I was thinking that cede might somehow force it to 0 (or perhaps one of the
>> preempt_count explicit value setters in irq.c) and then decrement it - but that dec
>> should trigger an error in the dec_preempt_count() as I have CONFIG_DEBUG_PREEMPT=y.
> 
> Decrementer is only the suspect, we have not yet proved that the dec
> handler is being executed.  Can somebody be using our stack?  The
> pointer is same.. but do we still own it?  I cannot think of how
> somebody else could be using this cpu's stack... but just a thought to
> explain this anomaly.
> 
> --Vaidy


Thanks for the thoughts,

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
