Return-Path: <george@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 6C30368076
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 10:09:39 +1000 (EST)
Message-ID: <42F9453F.8030905@mvista.com>
Date: Tue, 09 Aug 2005 17:07:27 -0700
From: George Anzinger <george@mvista.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>,
	Rune Torgersen <runet@innovsys.com>, linuxppc-embedded@ozlabs.org
References: <42F94091.90309@am.sony.com>
In-Reply-To: <42F94091.90309@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Fwd: Wall clock accuracy]
Reply-To: george@mvista.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> FYI...
> 
> -------- Original Message --------
> Subject: Wall clock accuracy
> Date: Tue, 9 Aug 2005 10:23:19 -0500
> From: Rune Torgersen <runet@innovsys.com>
> To: <linuxppc-embedded@ozlabs.org>
> 
> Hi
> 
> I have discovered that the accuracy of the wallclock (xtime) on ppc is
> not very good.
> I am running a custom telco board based on a 8266, and the main busclock
> is derived off of a T1 reference clock.
> I was noticing a huge number of logentries fron OpenNTPD about
> adjustiing the clock, so I started to check.
> The drift of the walltime was a little over 7 seconds in 15 hours (7
> seconds slow) (equals about 130us per s)
> 
> When I checked around, I found that xtime is updated in kernel/time.c
> and is updated by time_nsec nanoseconds per timer interrupt. 
> This value is hardcoded (through some obscure macros) to be 999848
> ns/timertick. Tis is 152ns slow per timertick. This works out to be
> 152us per second, almost the value I found.

The problem here is that the CLOCK_TICK_RATE is not correctly defined. 
This should be the rate at which the decrementer is clocked in hertz. 
If this is properly defined the tick_nsec value will be what works to to 
be an integral number of these that gives an nsec value less than or 
equal to what LATCH says you should be using for the number of 
decrementer counts in a jiffie.  It is important that this be correctly 
defined so that a) LATCH is right and b) the jiffies to/from conversions 
are done right.  These conversions rely on TICK_NSEC to get the right 
answer.  (Also, so you don't step into a computing mess, it is important 
that these be defined at compile time so the compiler can do the heavy 
lifting.  If defined as variables the conversions will take a LOT longer 
(and use more code to boot).)

If you are getting 999848, it would appear that you are using the x86 
value which, I assume, is NOT right for a PPC, but then the PPC is NOT 
my strong suit...

George
> 
> I have tried a few workarounds, and made one that modifies time_nsec
> before update_wall_time_one_tick() is called.
> With this fix (which is 8260 specific at the time) I have less than 1 ms
> drift after 5 days.
> 
> The fix works by calculating how many ns and fractions of ns there is in
> one timer-tick (one jiffie).
> Then, at each timer interrupt, I accumulate the ns fractions, and add
> whole ns to the timer when needed.
> 
> This is tested on 8266 under 80.00MHz and 82.575360MHz main busclock. It
> also works correct if HZ=1024 instead of 1000
> 
> It is not meant as a patch to be added to the kernel right now, but more
> of a possible solution to a problem that it doesn't seem anybody has
> noticed before.
> 
> Index: arch/ppc/kernel/time.c
> ===================================================================
> --- arch/ppc/kernel/time.c	(revision 20)
> +++ arch/ppc/kernel/time.c	(working copy)
> @@ -119,6 +119,11 @@
>  EXPORT_SYMBOL(profile_pc);
>  #endif
>  
> +
> +#ifdef CONFIG_8260
> +extern unsigned long get_ns_delta(void); /*
> arch/ppc/syslib/m8260_setup.c */
> +extern unsigned long tick_nsec;          /* kernel/time.c */
> +#endif
>  /*
>   * timer_interrupt - gets called when the decrementer overflows,
>   * with interrupts disabled.
> @@ -148,6 +153,10 @@
>  		/* We are in an interrupt, no need to save/restore flags
> */
>  		write_seqlock(&xtime_lock);
>  		tb_last_stamp = jiffy_stamp;
> +
> +#ifdef CONFIG_8260		
> +		tick_nsec = get_ns_delta();
> +#endif		
>  		do_timer(regs);
>  
>  		/*
> @@ -179,7 +188,7 @@
>  		write_sequnlock(&xtime_lock);
>  	}
>  	if ( !disarm_decr[smp_processor_id()] )
> -		set_dec(next_dec);
> +		set_dec(next_dec-1);
>  	last_jiffy_stamp(cpu) = jiffy_stamp;
>  
>  	if (ppc_md.heartbeat && !ppc_md.heartbeat_count--)
> Index: arch/ppc/syslib/m8260_setup.c
> ===================================================================
> --- arch/ppc/syslib/m8260_setup.c	(revision 20)
> +++ arch/ppc/syslib/m8260_setup.c	(working copy)
> @@ -31,6 +31,8 @@
>  
>  #include "cpm2_pic.h"
>  
> +#include <linux/module.h>    
> +
>  unsigned char __res[sizeof(bd_t)];
>  
>  extern void cpm2_reset(void);
> @@ -82,16 +84,63 @@
>  /* The decrementer counts at the system (internal) clock frequency
>   * divided by four.
>   */
> +unsigned long tb_time_nsec;
> +unsigned long tb_frac_nsec;
> +unsigned long tb_frac_limit;     
> + 
> +extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> + 
>  static void __init
>  m8260_calibrate_decr(void)
> +{    
> +    bd_t *binfo = (bd_t *)__res;
> +    int freq, divisor, tick_freq;
> +    uint64_t tmp;
> +    printk("Calibrating Decrementer\n");
> +
> +    freq = binfo->bi_busfreq;
> +    divisor = 4;
> +    
> +    /* get rounded off decrementer frequency */
> +    tick_freq = (freq + 3) / 4;
> +    
> +    /* get number of timebase ticks per jiffy (timerint) */
> +    tb_ticks_per_jiffy = (tick_freq + (HZ/2)) / HZ;
> +    tb_to_us = mulhwu_scale_factor(tick_freq, 1000000);
> +
> +    /* calculate timer interrupt interval in nano seconds */
> +    tmp = 1000000000ULL * (u64)tb_ticks_per_jiffy;
> +    __div64_32(&tmp, tick_freq);
> +    tb_time_nsec = tmp;
> +    
> +    /* calculate fractions of nanosecons per timer interrupt */
> +    tb_frac_limit = 100000UL;
> +    tmp = 1000000000ULL * (u64)tb_ticks_per_jiffy * tb_frac_limit;
> +    __div64_32(&tmp, tick_freq);
> +    tb_frac_nsec = (u32)(tmp - (u64)tb_time_nsec * (u64)tb_frac_limit);
> +    
> +    printk("busfreq = %u\n", freq);
> +    printk("tb_ticks_per_jiffy = %u\ntb_to_us = %u\n",
> tb_ticks_per_jiffy, tb_to_us);
> +    printk("tick_freq = %u\ntime_nsec = %u\ntb_frac_nsec = %u\n",
> tick_freq, tb_time_nsec, tb_frac_nsec);
> +}
> +
> +unsigned long get_ns_delta(void)
>  {
> -	bd_t *binfo = (bd_t *)__res;
> -	int freq, divisor;
> +    static uint32_t frac = 0;
>  
> -	freq = binfo->bi_busfreq;
> -        divisor = 4;
> -        tb_ticks_per_jiffy = freq / HZ / divisor;
> -	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
> +    unsigned long delta_ns;
> +
> +    delta_ns = tb_time_nsec;
> +
> +    /* adjust for inaccuracy in calculation */
> +    frac += tb_frac_nsec;
> +    if (frac >= tb_frac_limit)
> +    {
> +        delta_ns += frac / tb_frac_limit;
> +        frac %= tb_frac_limit;
> +    }
> +    
> +    return delta_ns;
>  }
>  
>  /* The 8260 has an internal 1-second timer update register that
> 
> Rune Torgersen
> System Developer
> Innovative Systems LLC
> 1000 Innovative Drive
> Mitchell, SD 57301
> Ph: 605-995-6120
> www.innovsys.com
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
