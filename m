Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 490A2B7C00
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 11:49:42 +1100 (EST)
Subject: Re: [PATCH v3] powerpc/ppc64: Use preempt_schedule_irq instead of
	preempt_schedule
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine <vbarshak@ru.mvista.com>
In-Reply-To: <4AE8CA95.7060402@ru.mvista.com>
References: <20091019182858.GA10495@ru.mvista.com>
	<1256601324.2076.49.camel@pasglop> <1256622077.11607.85.camel@pasglop>
	<4AE89936.6080803@ru.mvista.com> <1256761844.26770.2.camel@pasglop>
	<4AE8B761.3090902@ru.mvista.com> <1256765834.26770.6.camel@pasglop>
	<4AE8CA95.7060402@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Oct 2009 11:49:33 +1100
Message-ID: <1256777373.26770.14.camel@pasglop>
Mime-Version: 1.0
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Yes, the MSR_EE is cleared before we jump to do_work. I'm OK with 
> clearing the hardirqenable flag. I just assumed that the hardirq flag 
> was supposed to reflect the MSR_EE state, so it looked a bit odd 
> clearing the MSR_EE at one place and then reflecting the change at another.

Yeah well, it is supposed to reflect EE in the "general case", it's just
that in the exception entry/exit, we take shortcuts when turning EE off
for short amount of times without reflecting it in the PACA. This is
why, in this case, since we are going back to C code, I want to have it
"fixed up" to reflect reality.

Cheers,
Ben.

> Anyway, the patch works fine.
> 
> Thanks,
> Val.
> 
> So either we
> > set it back, or we clear HARDIRQEN to reflect it. It will be re-enable
> > as soon as preempt_schedule_irq() calls local_irq_enable() which is soon
> > enough anyways.
> > 
> > Also that avoids perf interrupt sneaking in since those act as NMIs in
> > that regard and -will- get in even when soft disabled.
> > 
> > Cheers,
> > Ben.
> > 
> >> Thanks,
> >> Val.
> >>> Ben.
> >>>
> >>>> Thanks,
> >>>> Val.
> >>>>
> >>>>> +	TRACE_DISABLE_INTS
> >>>>> +
> >>>>> +	/* Call the scheduler with soft IRQs off */
> >>>>> +1:	bl	.preempt_schedule_irq
> >>>>> +
> >>>>> +	/* Hard-disable interrupts again (and update PACA) */
> >>>>>  #ifdef CONFIG_PPC_BOOK3E
> >>>>> -	wrteei	1
> >>>>> -	bl	.preempt_schedule
> >>>>>  	wrteei	0
> >>>>>  #else
> >>>>> -	ori	r10,r10,MSR_EE
> >>>>> -	mtmsrd	r10,1		/* reenable interrupts */
> >>>>> -	bl	.preempt_schedule
> >>>>>  	mfmsr	r10
> >>>>> -	clrrdi	r9,r1,THREAD_SHIFT
> >>>>> -	rldicl	r10,r10,48,1	/* disable interrupts again */
> >>>>> +	rldicl	r10,r10,48,1
> >>>>>  	rotldi	r10,r10,16
> >>>>>  	mtmsrd	r10,1
> >>>>>  #endif /* CONFIG_PPC_BOOK3E */
> >>>>> +	li	r0,0
> >>>>> +	stb	r0,PACAHARDIRQEN(r13)
> >>>>> +
> >>>>> +	/* Re-test flags and eventually loop */
> >>>>> +	clrrdi	r9,r1,THREAD_SHIFT
> >>>>>  	ld	r4,TI_FLAGS(r9)
> >>>>>  	andi.	r0,r4,_TIF_NEED_RESCHED
> >>>>>  	bne	1b
> >>>>>  	b	restore
> >>>>>  
> >>>>>  user_work:
> >>>>> -#endif
> >>>>> +#endif /* CONFIG_PREEMPT */
> >>>>> +
> >>>>>  	/* Enable interrupts */
> >>>>>  #ifdef CONFIG_PPC_BOOK3E
> >>>>>  	wrteei	1
> >>>
> > 
> > 
