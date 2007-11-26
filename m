Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (pip9.gyao.ne.jp [61.122.117.247])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88AAFDDEEA
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 12:41:02 +1100 (EST)
Date: Mon, 26 Nov 2007 10:40:51 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Anton Vorontsov <cbou@mail.ru>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Message-ID: <20071126014051.GA23760@linux-sh.org>
References: <20071123175229.GA27143@localhost.localdomain>
	<4747751D.4060802@garzik.org> <20071124072613.GA7303@linux-sh.org>
	<20071126002314.GA20104@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071126002314.GA20104@zarina>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 26, 2007 at 03:23:14AM +0300, Anton Vorontsov wrote:
> On Sat, Nov 24, 2007 at 04:26:13PM +0900, Paul Mundt wrote:
> > On Fri, Nov 23, 2007 at 07:49:33PM -0500, Jeff Garzik wrote:
> > > Anton Vorontsov wrote:
> > > >Here is the PATA Platform driver using OF infrastructure.
> > > >
> > > >Mostly it's just a wrapper around a bit modified pata_platform
> > > >driver.
> > > >
> > > >Patches are well split for the easier review:
> > > >
> > > >First one factors out platform_device specific bits and modifies
> > > >pata_platform to be a library-alike driver (with platform_device
> > > >default binding).
> > > >
> > The only issue I have here is that this library-like version has subtle
> > semantic changes that will break existing drivers.
> 
> Actually I've tried to keep semantics intact:
> 
> +static int __devinit pata_platform_probe(struct platform_device *pdev)
> [...]
> +       /*
> +        * And the IRQ
> +        */
> +       irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       if (irq_res)
> +               irq_res->flags = pp_info ? pp_info->irq_flags : 0;
> [...]
> 
> So, I'm passing flags from the platform data. Did you overlook these
> bits, or I'm still changing semantics somewhere else?
> 
Oh, I overlooked that. Using irq_res->flags as a temporary for
pp_info->irq_flags seems a bit hacky, but as long as pp_info->irq_flags
semantics are intact, I'm not too violently opposed to this anyways.

> > Incidentally, we already have an include/linux/pata_platform.h. If this
> > is going to be library-like, through the prototypes in there, rather than
> > splitting them up betewen include/linux and drivers/ata. We don't need
> > two headers.
> 
> My intention was: keep "private" declarations in the drivers/ata/ and
> "public" in the include/linux/ -- to not confuse pata_platform users
> by __pata_platform_* internal stuff. But okay, I'll merge them.
> 
I suppose that depends on whether the intent is that all pata_platform
users will be stuck in drivers/ata or not. If this is treated as more of
a library, implementations can simply bury themselves in arch/ land if
they feel like it.
