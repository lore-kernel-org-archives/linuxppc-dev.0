Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5295DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 08:12:30 +1100 (EST)
Date: Mon, 1 Jan 2007 21:22:36 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
Message-ID: <20070101212236.34526225@localhost.localdomain>
In-Reply-To: <1167679875.22068.350.camel@pmac.infradead.org>
References: <1167679875.22068.350.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 01 Jan 2007 19:31:15 +0000
David Woodhouse <dwmw2@infradead.org> wrote:
> There's probably a better way to do this -- especially if we observe
> that the _only_ case in which this seemingly-generic
> "pci_get_legacy_ide_irq()" function returns anything other than 14 and
> 15 for primary and secondary respectively is the case of the AMD8111 on
> the Maple board -- couldn't we handle that with a special case in the
> pata_amd driver, or perhaps with a PCI quirk for Maple to switch it into
> native mode during early boot and assign resources properly?

There are lots of platforms where the primary/secondary address depends
upon the board/architecture. PPC actually has functions for this in the
machine specific goo used by the old driver for one example
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

NAK: Alan Cox <alan@redhat.com>

Please reuse the existing PPC methods that drivers/ide calls into.
