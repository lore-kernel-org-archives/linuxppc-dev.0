Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 6ED0CDDF9E
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:33:57 +1000 (EST)
Message-ID: <47162B6F.40903@ru.mvista.com>
Date: Wed, 17 Oct 2007 19:34:07 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
References: <1190345162.620000.305760830507.qpush@thor>
In-Reply-To: <1190345162.620000.305760830507.qpush@thor>
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

> With these functions implemented we cooperate better with the generic
> timekeeping code.  This obsoletes the need for the timer sysdev as a bonus.

    Aha, I'm seeing it's not merged to mainline yet!  And this can't be merged 
to -rt patch either, beucase -rt alsready has read_persistent_clock() 
implemented since around 2.6.18-rt...

> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

> ---

> Patch set updated to powerpc/for-2.6.24

> * Compile tested for arch/powerpc/configs/*_defconfig
> * Booted on pSeries, iSeries, Cell and PS3

>  arch/powerpc/Kconfig         |    3 +
>  arch/powerpc/kernel/time.c   |   85 ++++++++++-------------------------
>  arch/powerpc/sysdev/Makefile |    5 --
>  arch/powerpc/sysdev/timer.c  |   81 ---------------------------------
>  4 files changed, 29 insertions(+), 145 deletions(-)
> 
> Index: working/arch/powerpc/Kconfig
> ===================================================================
> --- working.orig/arch/powerpc/Kconfig
> +++ working/arch/powerpc/Kconfig
> @@ -21,6 +21,9 @@ config MMU
>  	bool
>  	default y
>  
> +config GENERIC_CMOS_UPDATE
> +	def_bool y
> +
>  config GENERIC_HARDIRQS
>  	bool
>  	default y
> Index: working/arch/powerpc/kernel/time.c
> ===================================================================
> --- working.orig/arch/powerpc/kernel/time.c
> +++ working/arch/powerpc/kernel/time.c
> @@ -881,12 +837,35 @@ void __init generic_calibrate_decr(void)
>  #endif
>  }
>  
> -unsigned long get_boot_time(void)
> +int update_persistent_clock(struct timespec now)
>  {
>  	struct rtc_time tm;
>  
> -	if (ppc_md.get_boot_time)
> -		return ppc_md.get_boot_time();
> +	if (!ppc_md.set_rtc_time)
> +		return 0;
> +
> +	to_tm(now.tv_sec + 1 + timezone_offset, &tm);
> +	tm.tm_year -= 1900;
> +	tm.tm_mon -= 1;
> +
> +	return ppc_md.set_rtc_time(&tm);
> +}
> +
> +unsigned long read_persistent_clock(void)
> +{
> +	struct rtc_time tm;
> +	static int first = 1;
> +
> +	/* XXX this is a litle fragile but will work okay in the short term */
> +	if (first) {
> +		first = 0;
> +		if (ppc_md.time_init)
> +			timezone_offset = ppc_md.time_init();
> +
> +		/* get_boot_time() isn't guaranteed to be safe to call late */
> +		if (ppc_md.get_boot_time)
> +			return ppc_md.get_boot_time() -timezone_offset;
> +	}

    This looks incomplete.

> @@ -898,14 +877,10 @@ unsigned long get_boot_time(void)
>  void __init time_init(void)
>  {
>  	unsigned long flags;
> -	unsigned long tm = 0;
>  	struct div_result res;
>  	u64 scale, x;
>  	unsigned shift;
>  
> -        if (ppc_md.time_init != NULL)
> -                timezone_offset = ppc_md.time_init();
> -
>  	if (__USE_RTC()) {
>  		/* 601 processor: dec counts down by 128 every 128ns */
>  		ppc_tb_freq = 1000000000;
> @@ -980,19 +955,14 @@ void __init time_init(void)
>  	/* Save the current timebase to pretty up CONFIG_PRINTK_TIME */
>  	boot_tb = get_tb_or_rtc();
>  
> -	tm = get_boot_time();
> -
>  	write_seqlock_irqsave(&xtime_lock, flags);

    Is there any sense of grabbing xtime_lock in time_init() when you've 
implemented read_persistent_clock()?

>  
>  	/* If platform provided a timezone (pmac), we correct the time */
>          if (timezone_offset) {
>  		sys_tz.tz_minuteswest = -timezone_offset / 60;
>  		sys_tz.tz_dsttime = 0;
> -		tm -= timezone_offset;
>          }
>  
> -	xtime.tv_sec = tm;
> -	xtime.tv_nsec = 0;

    Huh? The 'xtime' should now be set by the *generic* timekeeping code using 
read_persistent_clock() -- or else what's the point to implement the function? :-/

> @@ -1010,9 +980,6 @@ void __init time_init(void)
>  
>  	time_freq = 0;
>  
> -	last_rtc_update = xtime.tv_sec;
> -	set_normalized_timespec(&wall_to_monotonic,
> -	                        -xtime.tv_sec, -xtime.tv_nsec);
>  	write_sequnlock_irqrestore(&xtime_lock, flags);

    That 'xtime_lock' grabbing should be gone with this patch, and is not. NAK.

WBR, Sergei
