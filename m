Return-Path: <SRS0+b1a8919817a61a648e9e+1226+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 535B3DDE40
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 08:15:19 +1100 (EST)
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
From: David Woodhouse <dwmw2@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20070101212236.34526225@localhost.localdomain>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<20070101212236.34526225@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 21:15:32 +0000
Message-Id: <1167686134.18169.3.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-01-01 at 21:22 +0000, Alan wrote:
> On Mon, 01 Jan 2007 19:31:15 +0000
> David Woodhouse <dwmw2@infradead.org> wrote:
> > There's probably a better way to do this -- especially if we observe
> > that the _only_ case in which this seemingly-generic
> > "pci_get_legacy_ide_irq()" function returns anything other than 14 and
> > 15 for primary and secondary respectively is the case of the AMD8111 on
> > the Maple board -- couldn't we handle that with a special case in the
> > pata_amd driver, or perhaps with a PCI quirk for Maple to switch it into
> > native mode during early boot and assign resources properly?
> 
> There are lots of platforms where the primary/secondary address depends
> upon the board/architecture. PPC actually has functions for this in the
> machine specific goo used by the old driver for one example
> > 
> > Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 
> NAK: Alan Cox <alan@redhat.com>
> 
> Please reuse the existing PPC methods that drivers/ide calls into.

Er, that would be pci_get_legacy_ide_irq(), which is what I _have_ used.

As I said, the Maple board is the _only_ user, across all architectures
and all PowerPC platforms, of pci_get_legacy_ide_irq(). And the AMD74xx
driver is the only driver which calls it -- for Maple. Hence the
suggestion that perhaps there's a better way to do it.

-- 
dwmw2
