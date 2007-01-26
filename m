Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4781FDE08D
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 09:28:56 +1100 (EST)
Message-ID: <45BA80A1.8040900@pobox.com>
Date: Fri, 26 Jan 2007 17:28:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
References: <1167679875.22068.350.camel@pmac.infradead.org>
In-Reply-To: <1167679875.22068.350.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
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
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

applied
