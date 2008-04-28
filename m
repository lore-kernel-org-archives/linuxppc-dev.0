Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A2D5DDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 16:28:45 +1000 (EST)
Message-Id: <050B2709-5AD6-4228-B963-6A60D254B15C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Chen Gong <g.chen@freescale.com>
In-Reply-To: <1209363637-22739-1-git-send-email-g.chen@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATHC V3] Watchdog on MPC85xx SMP system
Date: Mon, 28 Apr 2008 01:28:32 -0500
References: <1209363637-22739-1-git-send-email-g.chen@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	lkml Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2008, at 1:20 AM, Chen Gong wrote:
> On Book-E SMP systems each core has its own private watchdog.
> If only one watchdog is enabled, when the core that doesn't
> enable the watchdog is hung, system can't reset because no
> watchdog is running on it. That's bad. It means we must enable
> watchdogs on both cores.
>
> We can use smp_call_function() to send appropriate messages to all  
> the other
> cores to enable and update the watchdog.
>
> Signed-off-by: Chen Gong <g.chen@freescale.com>

In the future Wim should be copied as maintainer of WATCHDOG drivers  
in the kernel.

- k

>
> ---
> Tested on MPC8572DS platform.
>
> drivers/char/watchdog/booke_wdt.c |   34 ++++++++++++++++++++++++++ 
> +-------
> 1 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/ 
> watchdog/booke_wdt.c
> index d362f5b..b3a37d0 100644
> --- a/drivers/char/watchdog/booke_wdt.c
> +++ b/drivers/char/watchdog/booke_wdt.c
> @@ -6,7 +6,12 @@
>  * Author: Matthew McClintock
>  * Maintainer: Kumar Gala <galak@kernel.crashing.org>
>  *
> - * Copyright 2005 Freescale Semiconductor Inc.
> + * Copyright 2005, 2008 Freescale Semiconductor Inc.
> + *
> + * Changelog:
> + * 	2008-04-28 Chen Gong <g.chen@freescale.com>
> + * 	Add SMP support for MPC85xx system. Tested on
> + * 	MPC8572DS platform
>  *
>  * This program is free software; you can redistribute  it and/or  
> modify it
>  * under  the terms of  the GNU General  Public License as published  
> by the
> @@ -16,6 +21,7 @@
>
> #include <linux/module.h>
> #include <linux/fs.h>
> +#include <linux/smp.h>
> #include <linux/miscdevice.h>
> #include <linux/notifier.h>
> #include <linux/watchdog.h>
> @@ -47,23 +53,31 @@ u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
> #define WDTP(x)		(TCR_WP(x))
> #endif
>
> +static DEFINE_SPINLOCK(booke_wdt_lock);
> +
> +static void __booke_wdt_ping(void *data)
> +{
> +	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
> +}
> +
> /*
>  * booke_wdt_ping:
>  */
> static __inline__ void booke_wdt_ping(void)
> {
> -	mtspr(SPRN_TSR, TSR_ENW|TSR_WIS);
> +	smp_call_function(__booke_wdt_ping, NULL, 0, 0);
> +	__booke_wdt_ping(NULL);
> }
>
> /*
> - * booke_wdt_enable:
> + * __booke_wdt_enable:
>  */
> -static __inline__ void booke_wdt_enable(void)
> +static __inline__ void __booke_wdt_enable(void *data)
> {
> 	u32 val;
>
> 	/* clear status before enabling watchdog */
> -	booke_wdt_ping();
> +	__booke_wdt_ping(NULL);
> 	val = mfspr(SPRN_TCR);
> 	val |= (TCR_WIE|TCR_WRC(WRC_CHIP)|WDTP(booke_wdt_period));
>
> @@ -137,12 +151,15 @@ static int booke_wdt_ioctl (struct inode  
> *inode, struct file *file,
>  */
> static int booke_wdt_open (struct inode *inode, struct file *file)
> {
> +	spin_lock(&booke_wdt_lock);
> 	if (booke_wdt_enabled == 0) {
> 		booke_wdt_enabled = 1;
> -		booke_wdt_enable();
> +		__booke_wdt_enable(NULL);
> +		smp_call_function(__booke_wdt_enable, NULL, 0, 0);
> 		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled  
> (wdt_period=%d)\n",
> 				booke_wdt_period);
> 	}
> +	spin_unlock(&booke_wdt_lock);
>
> 	return nonseekable_open(inode, file);
> }
> @@ -183,11 +200,14 @@ static int __init booke_wdt_init(void)
> 		return ret;
> 	}
>
> +	spin_lock(&booke_wdt_lock);
> 	if (booke_wdt_enabled == 1) {
> 		printk (KERN_INFO "PowerPC Book-E Watchdog Timer Enabled  
> (wdt_period=%d)\n",
> 				booke_wdt_period);
> -		booke_wdt_enable();
> +		__booke_wdt_enable(NULL);
> +		smp_call_function(__booke_wdt_enable, NULL, 0, 0);
> 	}
> +	spin_unlock(&booke_wdt_lock);
>
> 	return ret;
> }
> -- 
> 1.5.4
