Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F193414009B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 May 2014 19:03:40 +1000 (EST)
Message-ID: <1399799008.17624.43.camel@pasglop>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can
 result in timer interrupt hang
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Sun, 11 May 2014 19:03:28 +1000
In-Reply-To: <536F384C.3070409@linux.vnet.ibm.com>
References: <20140509174712.55fe72d0@kryten>
 <536CA561.8010803@linux.vnet.ibm.com> <1399695993.4481.47.camel@pasglop>
 <536E477F.2070009@linux.vnet.ibm.com> <1399760754.17624.21.camel@pasglop>
 <536F3192.2050004@linux.vnet.ibm.com> <1399797477.17624.40.camel@pasglop>
 <536F384C.3070409@linux.vnet.ibm.com>
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

On Sun, 2014-05-11 at 14:13 +0530, Preeti U Murthy wrote:
> 
> Isn't this patch required too?
> 
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
> 
> The event_handler cannot be relied upon to call
> decrementer_set_next_event() all the time. This is in the case where
> there are no pending timers. In that case we need to have the check on
> irq work pending at the end of __timer_interrupt() no?

I don't think we need to move the test no. If there's a pending
irq_work, at that point, it will have done set_dec when being queued up.
So we only care about cases where we might change the decrementer.

If the event handler doesn't call decrementer_set_next_event() then
nothing will modify the decrementer and it will still trigger soon.

Cheers,
Ben.
