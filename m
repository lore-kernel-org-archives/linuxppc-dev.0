Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B07F2DDEEF
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:25:18 +1000 (EST)
Date: Tue, 17 Jul 2007 17:25:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Message-ID: <20070717222507.GA4682@ld0162-tx32.am.freescale.net>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA3030669AF@az33exm25.fsl.freescale.net>
	<28A3F6B9-512B-4D86-8E0D-A7680CCE2354@kernel.crashing.org>
	<1184622446.25235.89.camel@localhost.localdomain>
	<C2D29334-489F-49B0-8220-0D94E89FEAC3@kernel.crashing.org>
	<1184707558.25235.159.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1184707558.25235.159.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2007 at 07:25:57AM +1000, Benjamin Herrenschmidt wrote:
> > > which is why I tend to prefer having it
> > > explicitely in the interrupt controller node :-)
> > 
> > Which is simply incorrect.
> 
> It's absolutely not. Please, stop that moronic pin-head behaviour and
> find me a single case where that would actually be a problem of any sort
> or form.

It could lead someone to the erroneous conclusion that an #address-cells
other than zero in an interrupt controller that is not a device parent is
in any way a sane or supported thing to do.

It could lead people to write code that doesn't handle the absence of
#address-cells in such a node properly.

It could lead to flamewars. :-)

> > You mean, the magic default values you used for #address-cells
> > and #size-cells?  That was simply a bug, someone forgot to read
> > the documentation...
> 
> No, defaults are crap, period.

If there's only one value that could possibly make sense, it *not* being
the default is crap.

> See above. Besides, as I said, default values are crap. And no, it's not
> obvious which nodes define a physical address space or not, at least not
> for a generic parser.

The obvious way (which indeed isn't what the suggested algorithm does --
but the suggested algorithm doesn't do anything sensible) is that if you
got to the node via an interrupt-parent or interrupt-map, it doesn't use
#address-cells, and if you got to it by going to the regular device tree
parent, it does.

Pretty much any time you use the unit address in a context other than the
bus parent, things cease making sense.

> > In some areas, perhaps.  And it would be nice to bring those
> > areas to the attention of the working group, instead of just
> > to complain.
> 
> The working group is dead and some of the ex members of it expressed
> their lack of interest in pursuing these matters.

There is the ePAPR working group, though.

-Scott
