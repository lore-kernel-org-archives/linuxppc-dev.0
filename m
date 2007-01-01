Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6EDFDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 07:12:18 +1100 (EST)
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1167679875.22068.350.camel@pmac.infradead.org>
References: <1167679875.22068.350.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 07:10:51 +1100
Message-Id: <1167682254.23340.131.camel@localhost.localdomain>
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

On Mon, 2007-01-01 at 19:31 +0000, David Woodhouse wrote:
> On the Maple board, the AMD8111 IDE is in legacy mode... except that it
> appears on IRQ 20 instead of IRQ 15. For drivers/ide this was handled by
> the architecture's "pci_get_legacy_ide_irq()" function, but in libata we
> just hard-code the numbers 14 and 15.
> 
> This patch provides asm-powerpc/libata-portmap.h which maps the IRQ as
> appropriate, having added a pci_dev argument to the
> ATA_{PRIM,SECOND}ARY_IRQ macros.
> 
> There's probably a better way to do this -- especially if we observe
> that the _only_ case in which this seemingly-generic
> "pci_get_legacy_ide_irq()" function returns anything other than 14 and
> 15 for primary and secondary respectively is the case of the AMD8111 on
> the Maple board -- couldn't we handle that with a special case in the
> pata_amd driver, or perhaps with a PCI quirk for Maple to switch it into
> native mode during early boot and assign resources properly?

I'm not sure you can switch it to native mode in sw... worth double
checking though. All boards based on 8111 on powerpc have this problem,
I think. What of the js20 and js21 with IBM firmware ? Or does it have
the ide strapped to native mode ?

In the meantime, your patch seems like the way to go.

Ben.
