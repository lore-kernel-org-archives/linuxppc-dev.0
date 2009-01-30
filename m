Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7009DDDFC8
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 08:02:11 +1100 (EST)
Subject: Re: Broken PCI on Sequoia
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0901301334220.13283@vixen.sonytel.be>
References: <alpine.LRH.2.00.0901291819440.22142@vixen.sonytel.be>
	<1233267061.18767.5.camel@pasglop>
	<20090130001842.GB3943@zod.rchland.ibm.com>
	<1233281333.18767.15.camel@pasglop>
	<alpine.LRH.2.00.0901301334220.13283@vixen.sonytel.be>
Content-Type: text/plain
Date: Sat, 31 Jan 2009 08:02:03 +1100
Message-Id: <1233349323.18767.31.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> | PCI host bridge /plb/pci@1ec000000 (primary) ranges:
> |  MEM 0x0000000180000000..0x00000001bfffffff -> 0x0000000080000000 
> |   IO 0x00000001e8000000..0x00000001e800ffff -> 0x0000000000000000
> |   IO 0x00000001e8800000..0x00000001ebffffff -> 0x0000000000000000
> |  \--> Skipped (too many) !
> | 4xx PCI DMA offset set to 0x00000000
> | ppc4xx_configure_pci_PMMs: i = 0, hose->pci_mem_offset = 0x100000000
> | ppc4xx_setup_one_pci_PMM:     hose = 0xcf825000
> | ppc4xx_setup_one_pci_PMM:     reg = 0xd1000000
> | ppc4xx_setup_one_pci_PMM:     plb_addr = 0x180000000
> | ppc4xx_setup_one_pci_PMM:     pci_addr = 0x80000000
> | ppc4xx_setup_one_pci_PMM:     size = 0x40000000
> | ppc4xx_setup_one_pci_PMM:     flags = 0x200
> | ppc4xx_setup_one_pci_PMM:     index = 0
> | /plb/pci@1ec000000: Resource out of range
>                       ^^^^^^^^^^^^^^^^^^^^^
> because plb_addr + size lies outside 32-bit space.

Ok so the code was buggy already, the ISA hole patch just makes it
trigger...

For that sort of 4xx PHB (ie, the PCI 2.x ones, not the PCI-X nor the
PCI-E), we only know how to program 32-bit of PLB address. IE. The old
code would have cropped the plb_addr when writing to the register, the
new code complains.

I suspect some implementation support a register to put the "high" part
of the PLB address, and that it already contains 1, so the old code
would have worked by chance, the new code doesn't because it bails out.

I need to check the doco for your CPU or any other using that cell to
see who supports what regarding the location of the outbound windows in
PLB space. I think the original 440GP which I used as a basis for the
PCI 2.x host bridge only supports 32-bits here but maybe I'm just
confused.

I'll have a look next week.

Cheers,
Ben
