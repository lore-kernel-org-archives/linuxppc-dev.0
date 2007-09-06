Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9C09DDDF38
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 05:15:08 +1000 (EST)
Date: Thu, 6 Sep 2007 14:15:16 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH 2/2] Generic clockevents and no-idle-HZ for PowerPC
Message-ID: <20070906191516.GA20090@lixom.net>
References: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Nice! I've been looking forward to these patches. Should help keep power
consumption down on machines with powersavings support for idle.

On Fri, Sep 07, 2007 at 12:44:46AM +1000, Paul Mackerras wrote:

> @@ -749,6 +805,8 @@ void __init clocksource_init(void)
>  	printk(KERN_INFO "clocksource: %s mult[%x] shift[%d] registered\n",
>  	       clocksource_timebase.name,
>  	       clocksource_timebase.mult, clocksource_timebase.shift);
> +
> +	init_decrementer_clockevent();
>  }
>  
>  /* This function is only called on the boot processor */
> @@ -874,8 +932,7 @@ void __init time_init(void)
>  	/* Register the clocksource */
>  	clocksource_init();
>  
> -	/* Not exact, but the timer interrupt takes care of this */
> -	set_dec(tb_ticks_per_jiffy);
> +	set_dec(DECREMENTER_MAX);
>  }

I don't think that set_dec() is needed any more. I get a very long
delay during "Calibrating delay loop..." with it there.

Looks like decrementer_set_next_event() already sets a reasonable
decementer value, it's called through the notify chain set off
from register_decrementer_clockevent() -> ... -> tick_notify() ->
tick_setup_periodic() -> clockevents_program_event().


-Olof
