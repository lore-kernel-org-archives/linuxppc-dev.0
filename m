Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B5CDDDE19
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 07:26:20 +1000 (EST)
Message-ID: <470165F6.7030505@freescale.com>
Date: Mon, 01 Oct 2007 16:26:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Problem with OF interrupt parsing code
References: <20071001210025.314240@gmx.net>
In-Reply-To: <20071001210025.314240@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard Pircher wrote:
> First some information about my target setup. I didn't specify an
> interrupt-map and interrupt-map-mask property in the pci node, because
> AFAIK there are three different AmigaOne models with different IRQ
> routing.

So detect which one you're running on in the bootwrapper, and fix up (or 
select) the device tree appropriately.

> Secondly the AmigaOne is a desktop system with 4 PCI/AGP slots,
> thus I can't specify device nodes for all possible devices. By looking at
> pci_read_irq_line() in pci_common.c it should be possible for the kernel
> to fall back to the interrupt settings in the PCI config space of every
> device.

Those interrupt settings are purely a communication vector from firmware 
to OS.  Is your firmware putting i8259 interrupt numbers in there, and 
did you set the default interrupt controller?

> The problem occurs now, if there is no device node defined for another
> PCI device. In this case, of_irq_map_pci() checks for an interrupt pin,
> searches again for the host bridge node and calls of_irq_map_raw() with
> the device node of the host bridge. The function finds the
> #interrupt-cells, #address-cells, interrupt-controller properties, but
> fails to find the interrupt-map property (because it's missing in the
> device tree). Therefore the function then tries to find a new parent,
> which leads to an endless loop (it always selects the PCI2ISA southbridge
> in the device tree).

That seems likely... there should probably be some loop detection.

-Scott
