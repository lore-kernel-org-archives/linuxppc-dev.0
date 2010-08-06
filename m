Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB1CF1007D2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 15:09:58 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id o76511lt020448
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Aug 2010 10:31:01 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7659tBk4333596
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Aug 2010 10:39:55 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7659rLt019193
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Aug 2010 10:39:55 +0530
Date: Fri, 6 Aug 2010 10:39:36 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
Message-ID: <20100806050936.GI3282@dirshya.in.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com> <4C491E14.9010100@us.ibm.com>
	<1279861767.1970.73.camel@pasglop> <4C5B7114.8030009@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4C5B7114.8030009@us.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Darren Hart <dvhltc@us.ibm.com> [2010-08-05 19:19:00]:

> On 07/22/2010 10:09 PM, Benjamin Herrenschmidt wrote:
> > On Thu, 2010-07-22 at 21:44 -0700, Darren Hart wrote:
> > 
> >>   suggestion I updated the instrumentation to display the
> >> local_save_flags and irqs_disabled_flags:
> > 
> >> Jul 22 23:36:58 igoort1 kernel: local flags: 0, irqs disabled: 1
> >> Jul 22 23:36:58 igoort1 kernel: before H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
> >> Jul 22 23:36:58 igoort1 kernel: after H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
> >>
> >> I'm not sure if I'm reading that right, but I believe interrupts are
> >> intended to be disabled here. If accomplished via the
> >> spin_lock_irqsave() this would behave differently on RT. However, this
> >> path disables the interrupts handled by xics, all but the IPIs anyway.
> >> On RT I disabled the decrementer as well.
> >>
> >> Is it possible for RT to be receiving other interrupts here?
> > 
> > Also you may want to call hard_irq_disable() to -really- disable
> > interrupts ... since we do lazy-disable on powerpc
> > 
> 
> A quick update and request for direction wrt the cede hcall, interrupt handling, and the stack pointer.
> 
> I've added patches one at a time, eliminating bugs with preempt_rt
> (tip/rt/head). With my current patchset I have no crashes with a single run of
> random_online.sh (stress testing to hit the hang will sees is my todo for
> tomorrow).
> 
> Current patchset includes:
> patches/0001-wms-fix01.patch # P7 lazy flushing thing
> 
> # next four are sent to / queued for mainline
> patches/powerpc-increase-pseries_cpu_die-delay.patch
> patches/powerpc-enable-preemption-before-cpu_die.patch
> patches/powerpc-silence-__cpu_up-under-normal-operation.patch
> patches/powerpc-silence-xics_migrate_irqs_away-during-cpu-offline.patch
> 
> # this one needs to be cleaned up and sent to mainline
> patches/powerpc-wait-for-cpu-to-go-inactive.patch
> 
> patches/powerpc-disable-decrementer-on-offline.patch
> patches/powerpc-cpu_die-preempt-hack.patch # reset preempt_count to 0 after cede
> patches/powerpc-cede-processor-inst.patch # instrumentation
> patches/powerpc-hard_irq_disable.patch # hard_irq_disable before cede
> patches/powerpc-pad-thread_info.patch
> 
> I didn't include all the patches as the relevant bits are included below in
> code form.
> 
> With the instrumentation, it's clear the change to preempt_count() is targeted
> (since I added padding before and after preempt_count in the thread_info
> struct) and preempt_count is still changed. It is also clear that it isn't just
> a stray decrement since I set preempt_count() to 4 prior to calling cede and it
> still is 0xffffffff after the hcall. Also note that the stack pointer doesn't
> change across the cede call and neither does any other part of the thread_info
> structure.
> 
> Adding hard_irq_disable() did seem to affect things somewhat. Rather than a
> serialized list of before/after thread_info prints around cede, I see
> several befores then several afters. But the preempt_count is still modified.
> 
> The relevant code looks like this (from pseries_mach_cpu_die())
> 
>                         hard_irq_disable(); /* this doesn't fix things... but
> 			                       does change behavior a bit */
>                         preempt_count() = 0x4; 
>                         asm("mr %0,1" : "=r" (sp));  /* stack pointer is in R1 */
>                         printk("before cede: sp=%lx pcnt=%x\n", sp, preempt_count()); 
>                         print_thread_info(); 
>                         extended_cede_processor(cede_latency_hint); 
>                         asm("mr %0,1" : "=r" (sp)); 
>                         printk("after cede: sp=%lx pcnt=%x\n", sp, preempt_count()); 
>                         print_thread_info(); 
>                         preempt_count() = 0; 
> 
> 
> With these patches applied, the output across cede looks like:
> 
> before cede: sp=c000000000b57150 pcnt=4
> *** current->thread_info ***
> ti->task: c000000000aa1410
> ti->exec_domain: c000000000a59958
> ti->cpu: 0
> ti->stomp_on_me: 57005 /* 0xDEAD - forgot to print in hex */
> ti->preempt_count: 4
> ti->stomp_on_me_too: 48879 /* 0xBEEF - forgot to print in hex */
> ti->local_flags: 0
> *** end thread_info ***
> after cede: sp=c000000000b57150 pcnt=ffffffff
> *** current->thread_info ***
> ti->task: c000000000aa1410
> ti->exec_domain: c000000000a59958
> ti->cpu: 0

Is this print sufficient to prove that we did not jump CPU?

We agree that decrementer can possibly expire and we could have gone
to the handler and come back just like we would do in an idle loop.
This will not happen always, but I could see a window of time during
which this may happen.  But that should not change the preempt_count
unconditionally to -1 with the same stack pointer.

> ti->stomp_on_me: 57005
> ti->preempt_count: ffffffff
> ti->stomp_on_me_too: 48879
> ti->local_flags: 0

Is there a method to identify whether we had executed any of the
interrupt handler while in this code?

> *** end thread_info ***
> 
> Are there any additional thoughts on what might be causing preempt_count to change?
> I was thinking that cede might somehow force it to 0 (or perhaps one of the
> preempt_count explicit value setters in irq.c) and then decrement it - but that dec
> should trigger an error in the dec_preempt_count() as I have CONFIG_DEBUG_PREEMPT=y.

Decrementer is only the suspect, we have not yet proved that the dec
handler is being executed.  Can somebody be using our stack?  The
pointer is same.. but do we still own it?  I cannot think of how
somebody else could be using this cpu's stack... but just a thought to
explain this anomaly.

--Vaidy
