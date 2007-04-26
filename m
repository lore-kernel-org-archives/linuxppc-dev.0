Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24F9CDDF92
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 19:45:37 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [2.6.22] pasemi: hardware rng driver
Date: Thu, 26 Apr 2007 11:22:03 +0200
References: <20070425204512.GB19781@lixom.net>
In-Reply-To: <20070425204512.GB19781@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261122.03452.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 April 2007 22:45:12 Olof Johansson wrote:
> +static int __devinit rng_probe(struct of_device *ofdev,
> +				     const struct of_device_id *match)
> +{
> +	struct device_node *rng_np;
> +	struct resource res;
> +	int err = 0;
> +
> +	rng_np = of_find_compatible_node(NULL, "rng", "1682m-rng");
> +	if (!rng_np)
> +		return -ENODEV;
> +
> +	err = of_address_to_resource(rng_np, 0, &res);
> +	of_node_put(rng_np);
> +
> +	if (err)
> +		return -EINVAL;

I think EINVAL is not the correct error code. I'd suggest ENODEV.

> +	if (!rng_regs)
> +		rng_regs = ioremap(res.start, 0x100);
> +
> +	if (!rng_regs)
> +		return -EPERM;

I think EPERM is not the correct error code. I'd suggest ENOMEM.

> +	printk(KERN_INFO "Registering PA Semi RNG\n");
> +
> +	return hwrng_register(&pasemi_rng);

Resource leak.
Please do something like

	err = hwrng_register(&pasemi_rng);
	if (err)
		iounmap(rng_regs);
	return err;

> +}
> +
> +static int rng_remove(struct of_device *dev)
> +{
> +	iounmap(rng_regs);
> +	hwrng_unregister(&pasemi_rng);

Swap these to prevent race conditions.

> +
> +	return 0;
> +}



-- 
Greetings Michael.
