Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CEC82140112
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 23:41:22 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 9 May 2014 07:41:20 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 55B483E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 07:41:16 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s49DfG5h9175416
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 15:41:16 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s49Dj657019365
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 07:45:06 -0600
Date: Fri, 9 May 2014 06:41:13 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can result
 in timer interrupt hang
Message-ID: <20140509134113.GP8754@linux.vnet.ibm.com>
References: <20140509174712.55fe72d0@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140509174712.55fe72d0@kryten>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 09, 2014 at 05:47:12PM +1000, Anton Blanchard wrote:
> I am seeing an issue where a CPU running perf eventually hangs.
> Traces show timer interrupts happening every 4 seconds even
> when a userspace task is running on the CPU.

Is this by chance every 4.2 seconds?  The reason I ask is that
Paul Clarke and I are seeing an interrupt every 4.2 seconds when
he runs NO_HZ_FULL, and are trying to get rid of it.  ;-)

						Thanx, Paul

>                                              /proc/timer_list
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
> 
> 
