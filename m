Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCF5D1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:08:31 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o6N58SsN021023
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:08:28 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N58Vcm1749174
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:08:31 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6N58TOI008234
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 15:08:31 +1000
Date: Fri, 23 Jul 2010 10:38:14 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
Message-ID: <20100723050814.GA26162@dirshya.in.ibm.com>
References: <4C488CCD.60004@us.ibm.com> <1279837509.1970.24.camel@pasglop>
	<4C48DADE.1050409@us.ibm.com> <4C491E14.9010100@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4C491E14.9010100@us.ibm.com>
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

* Darren Hart <dvhltc@us.ibm.com> [2010-07-22 21:44:04]:

> On 07/22/2010 04:57 PM, Darren Hart wrote:
> > On 07/22/2010 03:25 PM, Benjamin Herrenschmidt wrote:
> >> On Thu, 2010-07-22 at 11:24 -0700, Darren Hart wrote:
> >>>
> >>> 1) How can the preempt_count() get mangled across the H_CEDE hcall?
> >>> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?
> >>
> >> The preempt count is on the thread info at the bottom of the stack.
> >>
> >> Can you check the stack pointers ?
> > 
> > Hi Ben, thanks for looking.
> > 
> > I instrumented the area around extended_cede_processor() as follows
> > (please confirm I'm getting the stack pointer correctly).
> > 
> > while (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
> > 	asm("mr %0,1" : "=r" (sp));
> > 	printk("before H_CEDE current->stack: %lx, pcnt: %x\n", sp, preempt_count());
> > 	extended_cede_processor(cede_latency_hint);
> > 	asm("mr %0,1" : "=r" (sp));
> > 	printk("after H_CEDE current->stack: %lx, pcnt: %x\n", sp, preempt_count());
> >   }
> > 
> > 
> > On Mainline (2.6.33.6, CONFIG_PREEMPT=y) I see this:
> > Jul 22 18:37:08 igoort1 kernel: before H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
> > Jul 22 18:37:08 igoort1 kernel: after H_CEDE current->stack:  c00000010e9e3ce0, pcnt: 1
> > 
> > This surprised me as preempt_count is 1 before and after, so no
> > corruption appears to occur on mainline. This makes the pcnt of 65 I see
> > without the preempt_count()=0 hack very strange. I ran several hundred
> > off/on cycles. The issue of preempt_count being 1 is still addressed by
> > this patch however.
> > 
> > On PREEMPT_RT (2.6.33.5-rt23 - tglx, sorry, rt/2.6.33 next time, promise):
> > Jul 22 18:51:11 igoort1 kernel: before H_CEDE current->stack: c000000089bcfcf0, pcnt: 1
> > Jul 22 18:51:11 igoort1 kernel: after H_CEDE current->stack:  c000000089bcfcf0, pcnt: ffffffff
> > 
> > In both cases the stack pointer appears unchanged.
> > 
> > Note: there is a BUG triggered in between these statements as the
> > preempt_count causes the printk to trigger:
> > Badness at kernel/sched.c:5572
> 
> At Steven's suggestion I updated the instrumentation to display the
> local_save_flags and irqs_disabled_flags:
> 
> while (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
>         local_save_flags(flags);
>         printk("local flags: %lx, irqs disabled: %d\n", flags, irqs_disabled_flags(flags));
>         asm("mr %0,1" : "=r" (sp));
>         printk("before H_CEDE current->stack: %lx, pcnt: %x\n", sp, preempt_count());
>         extended_cede_processor(cede_latency_hint);
>         asm("mr %0,1" : "=r" (sp));
>         printk("after H_CEDE current->stack: %lx, pcnt: %x\n", sp, preempt_count());
> }
> 
> 
> Jul 22 23:36:58 igoort1 kernel: local flags: 0, irqs disabled: 1
> Jul 22 23:36:58 igoort1 kernel: before H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
> Jul 22 23:36:58 igoort1 kernel: after H_CEDE current->stack: c00000010e9e3ce0, pcnt: 1
> 
> I'm not sure if I'm reading that right, but I believe interrupts are
> intended to be disabled here. If accomplished via the
> spin_lock_irqsave() this would behave differently on RT. However, this
> path disables the interrupts handled by xics, all but the IPIs anyway.
> On RT I disabled the decrementer as well.
> 
> Is it possible for RT to be receiving other interrupts here?

Yes.  extended_cede_processor() will return with interrupts enabled in
the cpu. (This is done by the hypervisor).  Under normal cases we
cannot be interrupted because no IO interrupts are routed to us after
xics_teardown_cpu() and since the CPU is out of the map, nobody will
send us IPIs.

Though H_CEDE will return with interrupts enabled, it is unlikely that
an interrupt can be delivered in this context.

--Vaidy
