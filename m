Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D93EDDE451
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 06:16:54 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/2] port ndfc driver to of platform
Date: Thu, 14 Aug 2008 22:16:45 +0200
References: <20080801233000.3574434f@lappy.seanm.ca>
	<200808141153.07983.arnd@arndb.de>
	<20080814120829.1ad4ed74@lappy.seanm.ca>
In-Reply-To: <20080814120829.1ad4ed74@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808142216.45763.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 14 August 2008, Sean MacLennan wrote:
> On Thu, 14 Aug 2008 11:53:07 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
> > > +	ndfc->ndfcbase = ioremap(reg[1], reg[2]);
> > 
> > This could be better expressed as of_iomap().
> 
> I tried of_iomap(), but it doesn't seem to like the 3 value reg. i.e.
> It doesn't skip the chip select. And since I need to read the reg
> property to get the chip select any way, I just used the value directly.

If of_iomap and of_address_to_resource don't work properly, there
is probably something wrong in your device tree, maybe an incorrect
#size-cells or #address-cells or ranges property in one of
the parents. You need to fix this anyway.

> > > -	platform_set_drvdata(pdev, ndfc);
> > > +	__raw_writel(ccr, ndfc->ndfcbase + NDFC_CCR);
> > >  
> > > -	printk("NDFC NAND Driver initialized. Chip-Rev: 0x%08x\n",
> > > -	       __raw_readl(ndfc->ndfcbase + NDFC_REVID));
> > > +	/* Set the bank settings */
> > > +	reg = of_get_property(ofdev->node, "bank_settings", NULL);
> > > +	bank_settings = reg ? *reg : 0x80002222;
> > 
> > Your device tree does have a bank_setting, so why not assume that
> > all others will have it as well? I would remove the default.
> 
> I am thinking of making the bank settings an optional value. I assume
> most people with 44x chips with NAND will be using u-boot. If you
> enable NAND in u-boot, it should configure the bank settings for you.
> 
> I put the bank setting in my dts just to show a "complete"
> configuration.

Ok, I guess that in the absence of the property, you should not do anything
with this value then, rather than assuming a default.

	Arnd <><
