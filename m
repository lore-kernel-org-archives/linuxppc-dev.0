Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB33CDDE38
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 07:20:37 +1100 (EST)
Message-ID: <47336035.4020609@freescale.com>
Date: Thu, 08 Nov 2007 13:15:01 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC] powermac: proper sleep management
References: <1194523729.6294.18.camel@johannes.berg>
In-Reply-To: <1194523729.6294.18.camel@johannes.berg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg wrote:
> +/*
> + * overrides the weak arch_suspend_disable_irqs in kernel/power/main.c
> + *
> + * XXX: Once Scott Wood's patch is merged, this needs to use the ppc_md
> + *	hooks that patch adds!
> + */
> +void arch_suspend_disable_irqs(void)
> +{
> +#ifdef CONFIG_PMAC_BACKLIGHT
> +	/* Tell backlight code not to muck around with the chip anymore */
> +	pmu_backlight_set_sleep(1);
> +#endif
 > +
> +	/* Call platform functions marked "on sleep" */
> +	pmac_pfunc_i2c_suspend();
> +	pmac_pfunc_base_suspend();

Shouldn't these be done from suspend methods of the relevant drivers?
I don't understand why this needs to go in the disable IRQ hook.

-Scott
