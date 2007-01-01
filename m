Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75D68DDF91
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 08:24:43 +1100 (EST)
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1167683166.22068.378.camel@pmac.infradead.org>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<1167682254.23340.131.camel@localhost.localdomain>
	<1167683166.22068.378.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 08:23:14 +1100
Message-Id: <1167686594.23340.139.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-01 at 20:26 +0000, David Woodhouse wrote:
> On Tue, 2007-01-02 at 07:10 +1100, Benjamin Herrenschmidt wrote:
> > 
> > I'm not sure you can switch it to native mode in sw... worth double
> > checking though. All boards based on 8111 on powerpc have this problem,
> > I think. What of the js20 and js21 with IBM firmware ? Or does it have
> > the ide strapped to native mode ?
> 
> No idea, but it doesn't implement ppc_md.pci_get_legacy_ide_irq(). Only
> Maple does -- maybe the others actually manage to route it to IRQ 14 and
> 15?

Not with the new IRQ numbering scheme in which only a 8259 can get
those. Thus it must be native.

> Perhaps we could do that on Maple too -- after all, IRQ numbers in Linux
> are just a fiction which don't have to match the hardware documentation
> in any way.

I suppose I could add a function to hard-code a mapping but that would
have a few issues with the way I do virtual IRQs... I really assume that
1 to 15 are reserved for 8259. But we can hack it... I'd rather not
though and keep a hook for IDE etc...

There's another problem which is PCI IDE cards with the chip in legacy
mode... I've seen all sort of HW horrors in the area (like routing them
to INT#A and INT#B on a single function, sic....) or there's also the
case of the VIA chipset in pegasos which claims to be native mode but
routes IDE IRQs to 14 and 15 and not PIRQ...

Ben.
