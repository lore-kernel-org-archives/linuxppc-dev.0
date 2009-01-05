Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0282CDE1ED
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 08:18:50 +1100 (EST)
Subject: Re: [QUESTION] 440EPx with PCI to PCIe bridge error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <496268E7.5090907@harris.com>
References: <496268E7.5090907@harris.com>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 08:18:38 +1100
Message-Id: <1231190318.14860.17.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-05 at 15:09 -0500, Steven A. Falco wrote:
> I have a Sequoia board (440EPx) with kernel 2.6.27.9.  I've recently
> plugged in a PLX adapter board to convert one of the PCI connectors
> on the Sequoia to PCIe.
> 
> When the kernel boots, I get the following error messages regarding
> mem resource allocation.  Device 0000:00:0c.0 is the PCI<->PCIe bridge,
> and device 0000:01:00.0 is an FPGA PCIe evaluation board.

Please enable DEBUG in arch/powerpc/kernel/pci-common.c and pci_32.c and
send us a full log. It might also be useful to do that on top of 2.6.28
in case some of the changes that went in after .27 make a difference.

I think I'll turn those DEBUG into something that can be enabled from
the kernel command line one of these days :-)

Cheers,
Ben.

> 	PCI host bridge /plb/pci@1ec000000 (primary) ranges:
> 	 MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000
> 	  IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
> 	4xx PCI DMA offset set to 0x00000000
> 	PCI: Probing PCI hardware
> 	PCI: Hiding 4xx host bridge resources 0000:00:00.0
> 	pci 0000:00:0c.0: PME# supported from D0 D1 D3hot
> 	pci 0000:00:0c.0: PME# disabled
> 	pci 0000:00:0c.0: BAR 8: can't allocate mem resource [0x180000000-0x18fffffff]
> 	pci 0000:01:00.0: BAR 1: can't allocate mem resource [0x1f0000000-0x1ffffffff]
> 	pci 0000:01:00.0: BAR 0: can't allocate mem resource [0x180000000-0x18007ffff]
> 	pci 0000:00:0c.0: PCI bridge, secondary bus 0000:01
> 	pci 0000:00:0c.0:   IO window: disabled
> 	pci 0000:00:0c.0:   MEM window: disabled
> 	pci 0000:00:0c.0:   PREFETCH window: disabled
> 
> Plain PCI cards plugged directly into the Sequoia work fine.  Is there
> something I have to add to the .dts file to represent the PCI<->PCIe
> bridge?
> 
> 	Thanks,
> 	Steve
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
