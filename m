Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CCC7214008A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 01:41:00 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sat, 10 May 2014 09:40:57 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 125CFC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 11:40:50 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4AFesk06029660
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 15:40:54 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4AFerKB022555
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 11:40:54 -0400
Message-ID: <536E477F.2070009@linux.vnet.ibm.com>
Date: Sat, 10 May 2014 21:06:31 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can result
 in timer interrupt hang
References: <20140509174712.55fe72d0@kryten>
 <536CA561.8010803@linux.vnet.ibm.com> <1399695993.4481.47.camel@pasglop>
In-Reply-To: <1399695993.4481.47.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
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

On 05/10/2014 09:56 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2014-05-09 at 15:22 +0530, Preeti U Murthy wrote:
>> in __timer_interrupt() outside the _else_ loop? This will ensure that no
>> matter what, before exiting timer interrupt handler we check for pending
>> irq work.
> 
> We still need to make sure that set_next_event() doesn't move the
> dec beyond the next tick if there is a pending timer... maybe we

Sorry, but didn't get this. s/if there is pending timer/if there is
pending irq work ?

> can fix it like this:

We can call set_next_event() from events like hrtimer_cancel() or
hrtimer_forward() as well. In that case we don't come to
decrementer_set_next_event() from __timer_interrupt(). Then, if we race
with irq work, we *do not do* a set_dec(1) ( I am referring to the patch
below ), we might never set the decrementer to fire immediately right?

Or does this scenario never arise?

Regards
Preeti U Murthy
> 
> static int decrementer_set_next_event(unsigned long evt,
> 				      struct clock_event_device *dev)
> {
> 	__get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
> 
> 	/* Don't adjust the decrementer if some irq work is pending */
> 	if (!test_irq_work_pending())
> 		set_dec(evt);
> 
> 	return 0;
> }
> 
> Along with a single occurrence of:
> 
> 	if (test_irq_work_pending())
> 		set_dec(1);
> 
> At the end of __timer_interrupt(), outside if the current else {}
> case, this should work, don't you think ?
> 
> What about this completely untested patch ?
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 122a580..ba7e83b 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -503,12 +503,13 @@ void __timer_interrupt(void)
>                 now = *next_tb - now;
>                 if (now <= DECREMENTER_MAX)
>                         set_dec((int)now);
> -               /* We may have raced with new irq work */
> -               if (test_irq_work_pending())
> -                       set_dec(1);
>                 __get_cpu_var(irq_stat).timer_irqs_others++;
>         }
> 
> +       /* We may have raced with new irq work */
> +       if (test_irq_work_pending())
> +               set_dec(1);
> +
>  #ifdef CONFIG_PPC64
>         /* collect purr register values often, for accurate calculations */
>         if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
> @@ -813,15 +814,11 @@ static void __init clocksource_init(void)
>  static int decrementer_set_next_event(unsigned long evt,
>                                       struct clock_event_device *dev)
>  {
> -       /* Don't adjust the decrementer if some irq work is pending */
> -       if (test_irq_work_pending())
> -               return 0;
>         __get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
> -       set_dec(evt);
> 
> -       /* We may have raced with new irq work */
> -       if (test_irq_work_pending())
> -               set_dec(1);
> +       /* Don't adjust the decrementer if some irq work is pending */
> +       if (!test_irq_work_pending())
> +               set_dec(evt);
> 
>         return 0;
>  }
> 
> 
> 
> 
