Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id A92FF2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 13:35:16 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] ehci-platform: Merge ppc-of EHCI driver into the
 ehci-platform driver
Date: Thu, 07 Nov 2013 13:35:44 +1100
Message-ID: <6068608.Ksk8ll9RUd@mexican>
In-Reply-To: <1383767820.4776.124.camel@pasglop>
References: <Pine.LNX.4.44L0.1311051004080.1360-100000@iolanthe.rowland.org>
 <1690980.YlPWToa1rW@mexican> <1383767820.4776.124.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 7 Nov 2013 06:57:00 Benjamin Herrenschmidt wrote:
> On Wed, 2013-11-06 at 18:39 +1100, Alistair Popple wrote:

[snip]

> 
> I would go even further and add the 44x workarounds to the normal
> platform device, with a compatible check in there. That isn't the
> first time we add quirks to an existing driver.

Ok, easily done. I guess I was just cautious of adding a bunch of platform 
specific code into an otherwise generic driver as there seems to be a number 
of other platforms with their own quirks and it would be easy to end up with a 
driver full of platform specific quirks.

That said it is probably better than the current situation in which each 
platform has its own copy/variation of the generic code in ehci-platform.

Unless anyone is against this I will merge the 440EPX specific quirks into the 
ehci-platform driver and submit it as part of the next version of the Akebono 
patch series.

> > +	/* Initialise platform data from device tree if available. */
> > +	if (!dn) {
> 
> That was supposed to be if (dn) no ?

It sure was, thanks.

> 
> > +		if (of_get_property(dn, "big-endian", NULL)) {
> > +			pdata->big_endian_mmio = 1;
> > +			pdata->big_endian_desc = 1;
> > +		}
> > +		if (of_get_property(dn, "big-endian-regs", NULL))
> > +			pdata->big_endian_mmio = 1;
> > +		if (of_get_property(dn, "big-endian-desc", NULL))
> > +			pdata->big_endian_desc = 1;
> > +	}
> > +
> > 
> >  	irq = platform_get_irq(dev, 0);
> >  	if (irq < 0) {
> >  	
> >  		dev_err(&dev->dev, "no irq provided");
> > 
> > @@ -203,9 +216,10 @@ static int ehci_platform_resume(struct device *dev)
> > 
> >  #define ehci_platform_resume	NULL
> >  #endif /* CONFIG_PM */
> > 
> > -static const struct of_device_id vt8500_ehci_ids[] = {
> > +static const struct of_device_id ehci_platform_ids[] = {
> > 
> >  	{ .compatible = "via,vt8500-ehci", },
> >  	{ .compatible = "wm,prizm-ehci", },
> > 
> > +	{ .compatible = "usb-ehci", },
> > 
> >  	{}
> >  
> >  };
> 
> Cheers,
> Ben.
