Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CD7F2DDFAA
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 06:46:15 +1000 (EST)
Date: Thu, 26 Apr 2007 15:46:34 -0500
To: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] [2.6.22] pasemi: hardware rng driver
Message-ID: <20070426204634.GD17302@lixom.net>
References: <20070425204512.GB19781@lixom.net>
	<200704261122.03452.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704261122.03452.mb@bu3sch.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Michael,

All good points, fixed in v3 (posted shortly).


Thanks,

-Olof

On Thu, Apr 26, 2007 at 11:22:03AM +0200, Michael Buesch wrote:
> On Wednesday 25 April 2007 22:45:12 Olof Johansson wrote:
> > +static int __devinit rng_probe(struct of_device *ofdev,
> > +				     const struct of_device_id *match)
> > +{
> > +	struct device_node *rng_np;
> > +	struct resource res;
> > +	int err = 0;
> > +
> > +	rng_np = of_find_compatible_node(NULL, "rng", "1682m-rng");
> > +	if (!rng_np)
> > +		return -ENODEV;
> > +
> > +	err = of_address_to_resource(rng_np, 0, &res);
> > +	of_node_put(rng_np);
> > +
> > +	if (err)
> > +		return -EINVAL;
> 
> I think EINVAL is not the correct error code. I'd suggest ENODEV.
> 
> > +	if (!rng_regs)
> > +		rng_regs = ioremap(res.start, 0x100);
> > +
> > +	if (!rng_regs)
> > +		return -EPERM;
> 
> I think EPERM is not the correct error code. I'd suggest ENOMEM.
> 
> > +	printk(KERN_INFO "Registering PA Semi RNG\n");
> > +
> > +	return hwrng_register(&pasemi_rng);
> 
> Resource leak.
> Please do something like
> 
> 	err = hwrng_register(&pasemi_rng);
> 	if (err)
> 		iounmap(rng_regs);
> 	return err;
> 
> > +}
> > +
> > +static int rng_remove(struct of_device *dev)
> > +{
> > +	iounmap(rng_regs);
> > +	hwrng_unregister(&pasemi_rng);
> 
> Swap these to prevent race conditions.
> 
> > +
> > +	return 0;
> > +}
> 
> 
> 
> -- 
> Greetings Michael.
