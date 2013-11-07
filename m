Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id E24162C0246
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 14:34:42 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 4/7] IBM Akebono: Add support to the OHCI platform driver
 for Akebono
Date: Thu, 07 Nov 2013 14:34:55 +1100
Message-ID: <1462812.9fJW2bi87G@mexican>
In-Reply-To: <Pine.LNX.4.44L0.1311051002131.1360-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1311051002131.1360-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Nov 2013 10:04:02 Alan Stern wrote:

[snip]

> > 
> > +	/* Platforms using DT don't always provide platform data.
> > +	 * This should provide reasonable defaults. */
> 
> 	/*
> 	 * The accepted format for multi-line
> 	 * comments is like this.
> 	 */
> 

Ok, I'll fix that for the next revision.

> > +	if (!pdata)
> > +		dev->dev.platform_data = pdata = &ohci_platform_defaults;
> > +
> > 
> >  	irq = platform_get_irq(dev, 0);
> >  	if (irq < 0) {
> >  	
> >  		dev_err(&dev->dev, "no irq provided");
> > 
> > @@ -171,6 +175,11 @@ static int ohci_platform_resume(struct device *dev)
> > 
> >  #define ohci_platform_resume	NULL
> >  #endif /* CONFIG_PM */
> > 
> > +static const struct of_device_id ohci_of_match[] = {
> > +	{ .compatible = "ibm,akebono-ohci", },
> > +	{},
> > +};
> > +
> > 
> >  static const struct platform_device_id ohci_platform_table[] = {
> >  
> >  	{ "ohci-platform", 0 },
> >  	{ }
> > 
> > @@ -191,6 +200,7 @@ static struct platform_driver ohci_platform_driver = {
> > 
> >  		.owner	= THIS_MODULE,
> >  		.name	= "ohci-platform",
> >  		.pm	= &ohci_platform_pm_ops,
> > 
> > +		.of_match_table = ohci_of_match,
> > 
> >  	}
> >  
> >  };
> 
> Update the comment formatting, and then you can resubmit with
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks. Based on the discussion for the EHCI driver I would like to change the 
compatibility string to "usb-ochi" (instead of "ibm,akebono-ohci"). Are you 
still happy for me to add the Acked-by with the alternate compatibility (and 
of course the formatting fix)? No other drivers currently use "usb-ochi" so it 
shouldn't require any merging of drivers.

Regards,

Alistair
