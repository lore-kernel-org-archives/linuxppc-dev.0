Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 4BABADDF6A
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 02:08:27 +1000 (EST)
Date: Thu, 14 Aug 2008 12:08:29 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/2] port ndfc driver to of platform
Message-ID: <20080814120829.1ad4ed74@lappy.seanm.ca>
In-Reply-To: <200808141153.07983.arnd@arndb.de>
References: <20080801233000.3574434f@lappy.seanm.ca>
	<20080804132459.3fc12f59@lappy.seanm.ca>
	<20080813173629.32ec73ee@lappy.seanm.ca>
	<200808141153.07983.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Aug 2008 11:53:07 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> > +	ndfc->ndfcbase = ioremap(reg[1], reg[2]);
> 
> This could be better expressed as of_iomap().

I tried of_iomap(), but it doesn't seem to like the 3 value reg. i.e.
It doesn't skip the chip select. And since I need to read the reg
property to get the chip select any way, I just used the value directly.

> 
> > -	platform_set_drvdata(pdev, ndfc);
> > +	__raw_writel(ccr, ndfc->ndfcbase + NDFC_CCR);
> >  
> > -	printk("NDFC NAND Driver initialized. Chip-Rev: 0x%08x\n",
> > -	       __raw_readl(ndfc->ndfcbase + NDFC_REVID));
> > +	/* Set the bank settings */
> > +	reg = of_get_property(ofdev->node, "bank_settings", NULL);
> > +	bank_settings = reg ? *reg : 0x80002222;
> 
> Your device tree does have a bank_setting, so why not assume that
> all others will have it as well? I would remove the default.

I am thinking of making the bank settings an optional value. I assume
most people with 44x chips with NAND will be using u-boot. If you
enable NAND in u-boot, it should configure the bank settings for you.

I put the bank setting in my dts just to show a "complete"
configuration.

Cheers,
   Sean
