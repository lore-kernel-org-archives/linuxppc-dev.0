Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6A580DDF0D
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 17:34:10 +1100 (EST)
Subject: Re: [PATCH 2/3] powermac: proper time of day after resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20061213123945.386891000@sipsolutions.net>>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.386891000@sipsolutions.net>>
Content-Type: text/plain
Date: Wed, 24 Jan 2007 17:34:04 +1100
Message-Id: <1169620444.18754.66.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-13 at 13:38 +0100, Johannes Berg wrote:
> plain text document attachment (time-resume.patch)
> This patch converts the time restore code from a PMU notifier to a regular
> sys device so I can profit from it even when I don't suspend through the
> PMU, i.e. suspend to disk.
> 
> Also another step towards dropping pmu_sleep_notifier completely.

I'd rather do it differently: On suspend, read the RTC and save the
value. On resume, read it again, diff the values, and add that to the
current time.

Ben.

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---
> Tested on my powermac with my suspend code there but not yet on the
> powerbook.
> 
> It seems that this could be done in the generic instead of the arch
> dependent code since we have a machine op for getting the boot time...
> Should we?
> 
> --- linux-2.6-git.orig/arch/powerpc/platforms/powermac/time.c	2006-12-12 16:54:10.573639512 +0100
> +++ linux-2.6-git/arch/powerpc/platforms/powermac/time.c	2006-12-12 16:54:16.805639512 +0100
> @@ -298,36 +298,56 @@ int __init via_calibrate_decr(void)
>  #endif
>  
>  #ifdef CONFIG_PM
> +
> +static unsigned long time_diff;
> +
>  /*
>   * Reset the time after a sleep.
>   */
> -static int
> -time_sleep_notify(struct pmu_sleep_notifier *self, int when)
> +static int timer_resume(struct sys_device *dev)
> +{
> +	struct timespec tv;
> +
> +	tv.tv_sec = pmac_get_boot_time() + time_diff;
> +	tv.tv_nsec = 0;
> +	do_settimeofday(&tv);
> +
> +	return 0;
> +}
> +
> +static int timer_suspend(struct sys_device *dev, pm_message_t state)
>  {
> -	static unsigned long time_diff;
>  	unsigned long flags;
>  	unsigned long seq;
> -	struct timespec tv;
>  
> -	switch (when) {
> -	case PBOOK_SLEEP_NOW:
> -		do {
> -			seq = read_seqbegin_irqsave(&xtime_lock, flags);
> -			time_diff = xtime.tv_sec - pmac_get_boot_time();
> -		} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
> -		break;
> -	case PBOOK_WAKE:
> -		tv.tv_sec = pmac_get_boot_time() + time_diff;
> -		tv.tv_nsec = 0;
> -		do_settimeofday(&tv);
> -		break;
> -	}
> -	return PBOOK_SLEEP_OK;
> +	do {
> +		seq = read_seqbegin_irqsave(&xtime_lock, flags);
> +		time_diff = xtime.tv_sec - pmac_get_boot_time();
> +	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
> +
> +	return 0;
>  }
>  
> -static struct pmu_sleep_notifier time_sleep_notifier = {
> -	time_sleep_notify, SLEEP_LEVEL_MISC,
> +static struct sysdev_class timer_sysclass = {
> +	.resume = timer_resume,
> +	.suspend = timer_suspend,
> +	set_kset_name("timer"),
> +};
> +
> +static struct sys_device device_timer = {
> +	.id = 0,
> +	.cls = &timer_sysclass,
>  };
> +
> +static int time_init_device(void)
> +{
> +	int error = sysdev_class_register(&timer_sysclass);
> +	if (!error)
> +		error = sysdev_register(&device_timer);
> +	return error;
> +}
> +
> +device_initcall(time_init_device);
>  #endif /* CONFIG_PM */
>  
>  /*
> @@ -335,11 +355,6 @@ static struct pmu_sleep_notifier time_sl
>   */
>  void __init pmac_calibrate_decr(void)
>  {
> -#if defined(CONFIG_PM) && defined(CONFIG_ADB_PMU)
> -	/* XXX why here? */
> -	pmu_register_sleep_notifier(&time_sleep_notifier);
> -#endif
> -
>  	generic_calibrate_decr();
>  
>  #ifdef CONFIG_PPC32
> 
> --
