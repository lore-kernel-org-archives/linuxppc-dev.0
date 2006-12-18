Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D88667C01
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 08:52:22 +1100 (EST)
In-Reply-To: <20061218164229.6a8b0df7@localhost>
References: <20061218163846.337fed65@localhost>
	<20061218164229.6a8b0df7@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 0/1] ipmi: update: add autosensing of ipmi devices on
	powerpc using of device tree
Date: Mon, 18 Dec 2006 22:52:07 +0100
To: Christian Krafft <krafft@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Krafft <krafft@linux.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The driver will be probed for all devices with the type ipmi. It's  
> supporting
> devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
> Only ipmi-kcs could be tested.

I'd only include that one then.  But the code is trivial,
the risk is minimal, why not.


> +/* only exists on powerpc */
> +#ifdef CONFIG_PPC_OF
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>
> +#endif

Comment is inexact -- just kill it.

> +static int ipmi_of_probe(struct of_device *dev,
> +			 const struct of_device_id *match)

Shouldn't this (and everything else) be some kind of __init?

> +	regsize = get_property(np, "reg-size", NULL);
> +	regspacing = get_property(np, "reg-spacing", NULL);
> +	regshift = get_property(np, "reg-shift", NULL);

You should check whether you get exactly 4 bytes back or not.

> +	info->si_type		= (enum si_type) match->data;

That lands you a compiler warning (cast from pointer to shorter
integer) on 64-bit.

> +	if (!regsize)
> +		info->io.regsize = DEFAULT_REGSPACING;
> +	else
> +		info->io.regsize = *regsize;

info->io_regsize = regsize ? *regsize : DEFAULT_REGSIZE;

[Please note that fixes a copy/paste bug, too].

> +	dev_dbg(&dev->dev, "addr 0x%lx regsize %ld spacing %ld irq %x\n",
> +		info->io.addr_data, info->io.regsize, info->io.regspacing,
> +		info->irq);

Please all addresses/sizes/spacings in hexadecimal?  And
you might want to output regshift, too.

> +static int ipmi_of_remove(struct of_device *dev)
> +{
> +	/* should call
> +	 * cleanup_one_si(dev->dev.driver_data); */

So fix that :-)

> +	return 0;
> +}

> +static struct of_device_id ipmi_match[] =
> +{
> +	{ .type = "ipmi", .compatible = "ipmi-kcs",  .data = (void*) 
> SI_KCS },
> +	{ .type = "ipmi", .compatible = "ipmi-smic", .data = (void*) 
> SI_SMIC },
> +	{ .type = "ipmi", .compatible = "ipmi-bt",   .data = (void*)SI_BT },

That cast-to-pointer is what gives you that warning when
casting back.  Is there no better solution?


All pretty minor, but please fix.  Looks like you're almost
there :-)


Segher
