Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F5DCB7106
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2011 12:06:27 +1100 (EST)
Subject: Re: [PATCH] watchdog: booke_wdt: clean up status messages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1295299780-27338-1-git-send-email-timur@freescale.com>
References: <1295299780-27338-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 12:06:12 +1100
Message-ID: <1297040772.14982.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, wim@iguana.be, linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-01-17 at 15:29 -0600, Timur Tabi wrote:
> Improve the status messages that are displayed during some operations of the
> PowerPC watchdog timer driver.  When the watchdog is enabled, the timeout is
> displayed as a number of seconds, instead of an obscure "period".  The "period"
> is the position of a bit in a 64-bit timer register.  The higher the value,
> the quicker the watchdog timeout occurs.  Some people chose a high "period"
> value for the timer and get confused as to why the board resets within a
> few seconds.
> 
> Messages displayed during open and close are now debug messages, so that they
> don't clutter the console by default.  Finally, printk() is replaced with the
> pr_xxx() equivalent.

Minor nit bu
>  
> -	printk(KERN_INFO "PowerPC Book-E Watchdog Timer Loaded\n");
> +	pr_info("PowerPC Book-E Watchdog Timer Loaded\n");
>  	ident.firmware_version = cur_cpu_spec->pvr_value;
>  
>  	ret = misc_register(&booke_wdt_miscdev);
>  	if (ret) {
> -		printk(KERN_CRIT "Cannot register miscdev on minor=%d: %d\n",
> -				WATCHDOG_MINOR, ret);
> +		pr_err("booke_wdt: cannot register device (minor=%u, ret=%i)\n",
> +		       WATCHDOG_MINOR, ret);
>  		return ret;
>  	}
>  
>  	spin_lock(&booke_wdt_lock);
>  	if (booke_wdt_enabled == 1) {
> -		printk(KERN_INFO
> -		      "PowerPC Book-E Watchdog Timer Enabled (wdt_period=%d)\n",
> -				booke_wdt_period);
> +		pr_info("booke_wdt: watchdog enabled (timeout = %llu sec)\n",
> +			period_to_sec(booke_wdt_period));
>  		on_each_cpu(__booke_wdt_enable, NULL, 0);
>  	}

If you're going to cleanup the messages, then I think displaying:

PowerPC Book-E Watchdog Timer Loaded
booke_wdt: watchdog enabled (timeout = xxx sec)

Isn't very nice.

Lacks consistency ... you can prefix both lines the same way, or
maybe better print only one line with all the necessary info.

Ben.
