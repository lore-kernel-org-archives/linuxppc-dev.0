Return-Path: <SRS0+b1a8919817a61a648e9e+1226+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75E54DDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 08:43:31 +1100 (EST)
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
From: David Woodhouse <dwmw2@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20070101213444.2794563b@localhost.localdomain>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<20070101212236.34526225@localhost.localdomain>
	<1167686134.18169.3.camel@shinybook.infradead.org>
	<20070101213444.2794563b@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 21:43:45 +0000
Message-Id: <1167687826.18169.9.camel@shinybook.infradead.org>
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

On Mon, 2007-01-01 at 21:34 +0000, Alan wrote:
> > Er, that would be pci_get_legacy_ide_irq(), which is what I _have_ used.
> 
> Ok un-NAK that, I didn't realise there was a wrapper to those methods too.
> 
> > As I said, the Maple board is the _only_ user, across all architectures
> > and all PowerPC platforms, of pci_get_legacy_ide_irq(). And the AMD74xx
> 
> The Motorola's also used to use funny IRQ numbers for IDE legacy - or are
> they no longer supported

Well, there's no other implementation of pci_get_legacy_ide_irq() (other
than the default {15,14}) except for Maple, throughout all of arch/ppc
and arch/powerpc.

> > driver is the only driver which calls it -- for Maple. Hence the
> > suggestion that perhaps there's a better way to do it.
> 
> IRQ routing is platform not driver. Let's keep it that way.

Well, yes -- that's what my patch does. I was just thinking that since
this is the _only_ platform which currently uses it, it might be worth
fixing it differently -- by changing the platform setup code to either
route the interrupts to match what the generic code expects, or switch
the controller to native mode.

I'm happy enough with the patch I sent too though.

-- 
dwmw2
