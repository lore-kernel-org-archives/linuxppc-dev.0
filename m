Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CCF7C140076
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 08:26:09 +1000 (EST)
Message-ID: <1399760754.17624.21.camel@pasglop>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can
 result in timer interrupt hang
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Sun, 11 May 2014 08:25:54 +1000
In-Reply-To: <536E477F.2070009@linux.vnet.ibm.com>
References: <20140509174712.55fe72d0@kryten>
 <536CA561.8010803@linux.vnet.ibm.com> <1399695993.4481.47.camel@pasglop>
 <536E477F.2070009@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-05-10 at 21:06 +0530, Preeti U Murthy wrote:
> On 05/10/2014 09:56 AM, Benjamin Herrenschmidt wrote:
> > On Fri, 2014-05-09 at 15:22 +0530, Preeti U Murthy wrote:
> >> in __timer_interrupt() outside the _else_ loop? This will ensure that no
> >> matter what, before exiting timer interrupt handler we check for pending
> >> irq work.
> > 
> > We still need to make sure that set_next_event() doesn't move the
> > dec beyond the next tick if there is a pending timer... maybe we
> 
> Sorry, but didn't get this. s/if there is pending timer/if there is
> pending irq work ?

Yes, sorry :-) That's what I meant.

> > can fix it like this:
> 
> We can call set_next_event() from events like hrtimer_cancel() or
> hrtimer_forward() as well. In that case we don't come to
> decrementer_set_next_event() from __timer_interrupt(). Then, if we race
> with irq work, we *do not do* a set_dec(1) ( I am referring to the patch
> below ), we might never set the decrementer to fire immediately right?
> 
> Or does this scenario never arise?

So my proposed patch handles that no ?

With that patch, we do the set_dec(1) in two cases:

 - The existing arch_irq_work_raise() which is unchanged

 - At the end of __timer_interrupt() if an irq work is still pending

And the patch also makes decrementer_set_next_event() not modify the
decrementer if an irq work is pending, but *still* adjust next_tb unlike
what the code does now.

Thus the timer interrupt, when it happens, will re-adjust the dec
properly using next_tb.

Do we still miss a case ?

Cheers,
Ben.

> Regards
> Preeti U Murthy
> > 
> > static int decrementer_set_next_event(unsigned long evt,
> > 				      struct clock_event_device *dev)
> > {
> > 	__get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
> > 
> > 	/* Don't adjust the decrementer if some irq work is pending */
> > 	if (!test_irq_work_pending())
> > 		set_dec(evt);
> > 
> > 	return 0;
> > }
> > 
> > Along with a single occurrence of:
> > 
> > 	if (test_irq_work_pending())
> > 		set_dec(1);
> > 
> > At the end of __timer_interrupt(), outside if the current else {}
> > case, this should work, don't you think ?
> > 
> > What about this completely untested patch ?
> > 
> > diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> > index 122a580..ba7e83b 100644
> > --- a/arch/powerpc/kernel/time.c
> > +++ b/arch/powerpc/kernel/time.c
> > @@ -503,12 +503,13 @@ void __timer_interrupt(void)
> >                 now = *next_tb - now;
> >                 if (now <= DECREMENTER_MAX)
> >                         set_dec((int)now);
> > -               /* We may have raced with new irq work */
> > -               if (test_irq_work_pending())
> > -                       set_dec(1);
> >                 __get_cpu_var(irq_stat).timer_irqs_others++;
> >         }
> > 
> > +       /* We may have raced with new irq work */
> > +       if (test_irq_work_pending())
> > +               set_dec(1);
> > +
> >  #ifdef CONFIG_PPC64
> >         /* collect purr register values often, for accurate calculations */
> >         if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
> > @@ -813,15 +814,11 @@ static void __init clocksource_init(void)
> >  static int decrementer_set_next_event(unsigned long evt,
> >                                       struct clock_event_device *dev)
> >  {
> > -       /* Don't adjust the decrementer if some irq work is pending */
> > -       if (test_irq_work_pending())
> > -               return 0;
> >         __get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
> > -       set_dec(evt);
> > 
> > -       /* We may have raced with new irq work */
> > -       if (test_irq_work_pending())
> > -               set_dec(1);
> > +       /* Don't adjust the decrementer if some irq work is pending */
> > +       if (!test_irq_work_pending())
> > +               set_dec(evt);
> > 
> >         return 0;
> >  }
> > 
> > 
> > 
> > 
