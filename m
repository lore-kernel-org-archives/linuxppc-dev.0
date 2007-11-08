Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FD20DDE1E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 10:20:33 +1100 (EST)
Subject: Re: [RFC] powermac: proper sleep management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <47336035.4020609@freescale.com>
References: <1194523729.6294.18.camel@johannes.berg>
	<47336035.4020609@freescale.com>
Content-Type: text/plain
Date: Fri, 09 Nov 2007 10:19:16 +1100
Message-Id: <1194563956.6561.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-08 at 13:15 -0600, Scott Wood wrote:
> Johannes Berg wrote:
> > +/*
> > + * overrides the weak arch_suspend_disable_irqs in kernel/power/main.c
> > + *
> > + * XXX: Once Scott Wood's patch is merged, this needs to use the ppc_md
> > + *	hooks that patch adds!
> > + */
> > +void arch_suspend_disable_irqs(void)
> > +{
> > +#ifdef CONFIG_PMAC_BACKLIGHT
> > +	/* Tell backlight code not to muck around with the chip anymore */
> > +	pmu_backlight_set_sleep(1);
> > +#endif
>  > +
> > +	/* Call platform functions marked "on sleep" */
> > +	pmac_pfunc_i2c_suspend();
> > +	pmac_pfunc_base_suspend();
> 
> Shouldn't these be done from suspend methods of the relevant drivers?
> I don't understand why this needs to go in the disable IRQ hook.

The pmac_pfunc thing is low level platform stuff, no driver involved
there, this is the right place to do it.

As for the backlight bits, that could indeed be moved around I suppose,
I'd keep it there for now and look at cleaning the PMU driver
suspend/resume path in a second step.

Ben.
