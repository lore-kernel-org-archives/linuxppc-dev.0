Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D0BFFDE0B8
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 03:40:26 +1000 (EST)
Message-ID: <4713A616.3090103@ru.mvista.com>
Date: Mon, 15 Oct 2007 21:40:38 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
References: <20070921032603.0D3EA32C887@thor>
In-Reply-To: <20070921032603.0D3EA32C887@thor>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Tony Breeds wrote:

> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

    I don't see my own signoff or at least a reference to my prior work in
this patch or even at -rt patch -- despite this code ha clearly borrowed from
it.  And I'm not sure why this crippled version (lacking 40x/ Book E specific
clockevents implementation) is preferred over mine, unless this implementation
was only aimed at PPC64 machines...

> Index: working/arch/powerpc/Kconfig
> ===================================================================
> --- working.orig/arch/powerpc/Kconfig
> +++ working/arch/powerpc/Kconfig
> @@ -30,6 +30,9 @@ config GENERIC_TIME
>  config GENERIC_TIME_VSYSCALL
>  	def_bool y
>
> +config GENERIC_CLOCKEVENTS
> +	def_bool y
> +
>  config GENERIC_HARDIRQS
>  	bool
>  	default y

    Also, have the deterministic CPU accounting incompatibility with
clockevents been dealt with?

> Index: working/arch/powerpc/kernel/time.c
> ===================================================================
> --- working.orig/arch/powerpc/kernel/time.c
> +++ working/arch/powerpc/kernel/time.c
[...]
> @@ -519,10 +541,12 @@ void __init iSeries_time_init_early(void
>  void timer_interrupt(struct pt_regs * regs)
>  {
>  	struct pt_regs *old_regs;
> -	int next_dec;
>  	int cpu = smp_processor_id();
> -	unsigned long ticks;
> -	u64 tb_next_jiffy;
> +	struct clock_event_device *evt = &per_cpu(decrementers, cpu);
> +
> +	/* Ensure a positive value is written to the decrementer, or else
> +	 * some CPUs will continuue to take decrementer exceptions */
> +	set_dec(DECREMENTER_MAX);

    BookE and 40x CPUs don't need this.

>  #ifdef CONFIG_PPC32
>  	if (atomic_read(&ppc_n_lost_interrupts) != 0)
> @@ -532,7 +556,6 @@ void timer_interrupt(struct pt_regs * re
>  	old_regs = set_irq_regs(regs);
>  	irq_enter();
>  
> -	profile_tick(CPU_PROFILING);
>  	calculate_steal_time();
>  
>  #ifdef CONFIG_PPC_ISERIES
> @@ -540,44 +563,20 @@ void timer_interrupt(struct pt_regs * re
>  		get_lppaca()->int_dword.fields.decr_int = 0;
>  #endif
>  
> -	while ((ticks = tb_ticks_since(per_cpu(last_jiffy, cpu)))
> -	       >= tb_ticks_per_jiffy) {
> -		/* Update last_jiffy */
> -		per_cpu(last_jiffy, cpu) += tb_ticks_per_jiffy;
> -		/* Handle RTCL overflow on 601 */
> -		if (__USE_RTC() && per_cpu(last_jiffy, cpu) >= 1000000000)
> -			per_cpu(last_jiffy, cpu) -= 1000000000;

    I don't see where the patch removes those variables themselves...

[...]

> -		write_seqlock(&xtime_lock);
> -		tb_next_jiffy = tb_last_jiffy + tb_ticks_per_jiffy;
> -		if (__USE_RTC() && tb_next_jiffy >= 1000000000)
> -			tb_next_jiffy -= 1000000000;
> -		if (per_cpu(last_jiffy, cpu) >= tb_next_jiffy) {
> -			tb_last_jiffy = tb_next_jiffy;
> -			do_timer(1);
> -		}
> -		write_sequnlock(&xtime_lock);
> -	}

    Again, where those variables are removed?

> -	
> -	next_dec = tb_ticks_per_jiffy - ticks;
> -	set_dec(next_dec);
> +	if (evt->event_handler)
> +		evt->event_handler(evt);
> +	else
> +		evt->set_next_event(DECREMENTER_MAX, evt);

    We have already set it to DECREMENTER_MAX at the start of the function.
Please remove the 'else' part...

> @@ -797,6 +796,53 @@ void __init clocksource_init(void)
>  	       clock->name, clock->mult, clock->shift);
>  }
>  
> +static int decrementer_set_next_event(unsigned long evt,
> +				      struct clock_event_device *dev)
> +{
> +	set_dec(evt);

    I'd use (evt - 1) since the interrupt gets generated at 0xffffffff count, 
not 0 (on classic CPUs).  With you removing of the code that compensated for 
the errors, they will accumulate.  And no, this wouldn't be enough anyway, 
since on 40x and Book E you'll need to set it for evt anyway, since the 
interrupt happens at 0 count...
    NAK the patch.  And I really don't understand why you're throwing alway 
already tested/working code...

> +	return 0;
> +}
> +
> +static void decrementer_set_mode(enum clock_event_mode mode,
> +				 struct clock_event_device *dev)
> +{
> +	if (mode != CLOCK_EVT_MODE_ONESHOT)
> +		decrementer_set_next_event(DECREMENTER_MAX, dev);
> +}
> +
> +static void register_decrementer_clockevent(int cpu)
> +{
> +	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
> +
> +	*dec = decrementer_clockevent;
> +	dec->cpumask = cpumask_of_cpu(cpu);
> +
> +	printk(KERN_ERR "clockevent: %s mult[%lx] shift[%d] cpu[%d]\n",

    This is a mistake indeed. :-P

WBR, Sergei
