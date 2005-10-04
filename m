Return-Path: <george@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id AF8516845A
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Oct 2005 05:44:37 +1000 (EST)
Message-ID: <4342D490.5020409@mvista.com>
Date: Tue, 04 Oct 2005 12:14:24 -0700
From: George Anzinger <george@mvista.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859479@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859479@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clock skew on B/W G3
Reply-To: george@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
>  
> 
> 
>>-----Original Message-----
>>From: Paul Mackerras [mailto:paulus@samba.org] 
>>Sent: Tuesday, October 04, 2005 07:49
>>Subject: RE: clock skew on B/W G3
>>
>>I do not believe CLOCK_TICK_RATE affects timekeeping at all on ppc or
>>ppc64 machines, but I could be wrong.  Can you show us where and how
>>CLOCK_TICK_RATE affects things?
> 
> 
> I looked very closely at htis thing earlier this summer because of an
> embedded board that drifted quite severly (15sec a day) with a very
> accureate BITS clock as clock source.
> 
> Here goes:
> In arch/ppc/kernel/time.c
> timer_interrupt() gets called every decrementer timeout (about every
> 1/CONFIG_HZ seconds, accuracy depends on how easily your decrementer
> cliock can be divided by CONFIG_HZ)
> this calls do_timer() to do the timer increment.
> 
> do_timer is in kernel/timer.c and calls update_times().
> update_times() calls update_wall_time() which in turns calls
> update_wall_time_one_tick()
> 
> update_wall_time_one_tick()uses tick_nsec to increment xtime.
> 
> tick_nsec is defined as: (kernel/timer.c:561)
> unsigned long tick_nsec = TICK_NSEC;
> 
> TICK_NSEC is defined as: (include/linux/jiffies.h:64)
> #define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))
> 
> ACTHZ is defined as: (include/linux/jiffies.h:61)
> #define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
> 
> LATCH is defined as: (include/linux/jiffies.h:46)
> #define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)
> 
> which means that tick_nsec depends on CLOCK_TICK_RATE to get its value.
> 
> defined as:
> #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */

But this is defined in include/asm/???.h  so you should be able to set something more to your liking 
(or rather to your archs liking).  It is true that it SHOULD be defined as it is used to define 
TICK_NSEC which is used to define the jiffies<-->timeval/timespec conversions which would be VERY 
slow it it were a variable.

George
-- 

> 
> this clock is completely wrong for most/all ppc. 
> It happens to generate a tick_nsec of 999848 which is close enough to
> 1000000 that most people does not notice.
> (tick_nsec is number of nsec per timer tick)
> 
> When HZ is 250, TICK_NSEC becomes 4000250.
> While this might not completely explain a 20% change in clock sped, it
> it clearly not acurate either.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
