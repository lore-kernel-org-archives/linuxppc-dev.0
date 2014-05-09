Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D8BB0140112
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 19:57:09 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 9 May 2014 03:57:06 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id ECA643E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 03:57:02 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s499twMT6554008
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 11:55:59 +0200
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s499v1tk029929
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 03:57:02 -0600
Message-ID: <536CA561.8010803@linux.vnet.ibm.com>
Date: Fri, 09 May 2014 15:22:33 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can result
 in timer interrupt hang
References: <20140509174712.55fe72d0@kryten>
In-Reply-To: <20140509174712.55fe72d0@kryten>
Content-Type: text/plain; charset=UTF-8
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On 05/09/2014 01:17 PM, Anton Blanchard wrote:
> I am seeing an issue where a CPU running perf eventually hangs.
> Traces show timer interrupts happening every 4 seconds even
> when a userspace task is running on the CPU. /proc/timer_list
> also shows pending hrtimers have not run in over an hour,
> including the scheduler.
> 
> Looking closer, decrementers_next_tb is getting set to
> 0xffffffffffffffff, and at that point we will never take
> a timer interrupt again.
> 
> In __timer_interrupt() we set decrementers_next_tb to
> 0xffffffffffffffff and rely on ->event_handler to update it:
> 
>         *next_tb = ~(u64)0;
>         if (evt->event_handler)
>                 evt->event_handler(evt);
> 
> In this case ->event_handler is hrtimer_interrupt. This will eventually
> call back through the clockevents code with the next event to be
> programmed:
> 
> static int decrementer_set_next_event(unsigned long evt,
>                                       struct clock_event_device *dev)
> {
>         /* Don't adjust the decrementer if some irq work is pending */
>         if (test_irq_work_pending())
>                 return 0;
>         __get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
> 
> If irq work came in between these two points, we will return
> before updating decrementers_next_tb and we never process a timer
> interrupt again.
> 
> This looks to have been introduced by 0215f7d8c53f (powerpc: Fix races
> with irq_work). Fix it by removing the early exit and relying on
> code later on in the function to force an early decrementer:
> 
>        /* We may have raced with new irq work */
>        if (test_irq_work_pending())
>                set_dec(1);
> 

There is another scenario we are missing. Its not necessary that on a
timer interrupt the event handler will call back through the
set_next_event().
If there are no pending timers then the event handler will not bother
programming the tick device and simply return.IOW, set_next_event() will
not be called. In that case we will miss taking care of pending irq work
altogether.

__timer_interrupt() -> event_handler -> next_time = KTIME_MAX ->
__timer_interrupt().

In __timer_interrupt() we do not check for pending irq anywhere after
the call to the event handler and we hence miss servicing irqs in the
above scenario.

How about you also move the check:
 if (test_irq_pending())
   set_dec(1)

in __timer_interrupt() outside the _else_ loop? This will ensure that no
matter what, before exiting timer interrupt handler we check for pending
irq work.

Regards
Preeti U Murthy

> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org # 3.14+
> ---
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 122a580..4f0b676 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -813,9 +888,6 @@ static void __init clocksource_init(void)
>  static int decrementer_set_next_event(unsigned long evt,
>  				      struct clock_event_device *dev)
>  {
> -	/* Don't adjust the decrementer if some irq work is pending */
> -	if (test_irq_work_pending())
> -		return 0;
>  	__get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
>  	set_dec(evt);

How about if you move the test_irq_work_pending
Why do we have test_irq_work_pending() later in the function
decrementer_set_next_event()?
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
