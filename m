Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0CEAFDDE01
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 12:01:45 +1100 (EST)
Date: Sun, 4 Nov 2007 19:10:45 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] pasemi: clean up gpio_mdio init
Message-ID: <20071105011045.GA14077@lixom.net>
References: <472DF914.7020601@tiscali.nl> <20071104174701.GB10191@lixom.net>
	<472E0569.7070601@tiscali.nl> <20071104213709.GA13266@lixom.net>
	<20071105112307.13d4b8bb.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071105112307.13d4b8bb.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Roel Kluin <12o3l@tiscali.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Nov 05, 2007 at 11:23:07AM +1100, Stephen Rothwell wrote:

> Just a couple of small things ...

Thanks! Unless someone finds something bigger, I'll update this before
I push it out through git, but I won't repost.

> On Sun, 4 Nov 2007 15:37:09 -0600 Olof Johansson <olof@lixom.net> wrote:
> >
> > +		ip = of_get_property(phy_dn, "interrupts", NULL);
> > +		regp = of_get_property(phy_dn, "reg", NULL);
> > +		if (!ip || !regp)
> > +			continue;
> > +		new_bus->irq[*regp] = irq_create_mapping(NULL, *ip);
> 
> Paranoid me says to check that *regp is in range.

Yeah, good point.

> 
> >  int gpio_mdio_init(void)
> >  {
> > +	struct device_node *np;
> > +
> > +	np = of_find_compatible_node(NULL, "gpio", "1682m-gpio");
> > +	if (!np)
> > +		return -ENODEV;
> > +	gpio_regs = of_iomap(np, 0);
> 
> 	of_node_put(np);		?

Yup.


Thanks for the review,

-Olof
