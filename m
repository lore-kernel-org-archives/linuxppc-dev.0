Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id D287DDDE38
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 00:10:34 +1100 (EST)
Date: Tue, 6 Feb 2007 13:42:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 07/10] powermac: support G5 CPU hotplug
Message-ID: <20070206124212.GD8662@elf.ucw.cz>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185837.640324000@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205185837.640324000@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
> disabled are put into an idle loop with interrupts hard-disabled, to wake
> them up again we kick them just like when bringing them up.
> 
> Maybe there's some way to actually turn off those CPUs even more?
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- mb-wireless.orig/arch/powerpc/kernel/smp.c	2007-02-05 16:07:09.274524763 +0100
> +++ mb-wireless/arch/powerpc/kernel/smp.c	2007-02-05 18:15:51.114524763 +0100
> @@ -558,6 +558,11 @@ int __devinit start_secondary(void *unus
>  
>  	local_irq_enable();
>  
> +	/* it seems to be possible that we died from within
> +	 * an interrupt ... reset the in-irq counts */
> +	task_thread_info(paca[cpu].__current)->preempt_count &=
> +		~(SOFTIRQ_MASK|HARDIRQ_MASK);
> +
>  	cpu_idle();
>  	return 0;

This is quite a nasty hack. Are you sure?

I've seen similar weirdness on pc, and it was caused by
swsusp-copying-code using FPU and incrementing preempt_count...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
