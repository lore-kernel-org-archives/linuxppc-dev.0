Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E85667B92
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 10:05:03 +1000 (EST)
Subject: Re: Trouble with 85xx CDS cascade irq (i8259)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <7B853E2B-4156-4601-A272-9A9098310240@freescale.com>
References: <7B853E2B-4156-4601-A272-9A9098310240@freescale.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 02:04:54 +0200
Message-Id: <1155773094.11312.130.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm currently working on getting the 85xx platform working with the  
> new IRQ code.  Specifically, I'm working on the 8555 CDS right now.   
> The 85xx CDS consists of a PCI carrier card (with the 8555 processor,  
> serial, and networking interfaces), placed in one of 4 PCI slots on a  
> custom motherboard (the Arcadia).  The PCI interrupts are routed into  
> the carrier card through the standard PCI interrupt pins, which  
> requires some mucking around with interrupt assignments depending on  
> which slot the card is in.  There is also a VIA chipset on the  
> Arcadia motherboard, which provides IDE (among other things), and the  
> i8259 PIC in there is routed in through PCI interrupt A.

 <bell rings>  VIA chipsets are known to do very strange things with
interrupt routing depending on magic bits in some PCI config space
registers </bell rings>. No specifics in mind right now though...

One of the issue with some of those legacy chipsets is that they tend to
route IDE IRQs to 14 and 15 regardless of the PCI interrupt assigned to
the controller (that is they don't completely follow the native mode).
You might need a specific hack to set the right IRQs for your IDE
channels thus as the driver might not have a clue.

As you can see, init_hwif_via82cxxx() already has ugly hackes. A cleaner
way to do that would be to use the hook I added for such things:
pci_get_legacy_ide_irq(). It's currently used by the amd74xx driver but
via82cxxx could be fixd too. It will, on powerpc, call into a ppc_md.
hook that you can use to "fixup" your IDE interrupts manually from the
platform code.

 .../...

> At this point, I have determined that I am caught in a never-ending  
> cycle of interrupts on the i8259 cascade (that is, the mpic interrupt  
> that the i8259 is cascaded through).  i8259_irq() returns that it's  
> irq 7.

7 doesn't seem like a proper i8259 irq in that setup ... 
=
>                  /*
>                   * Since only primary interface works, force the
>                   * IDE function to standard primary IDE interrupt
>                   * w/ 8259 offset
>                   */
>                  dev->irq = 14;
>                  pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev- 
>  >irq);
>                  pci_dev_put(dev);
>          }

The above looks ok, but make sure that's really what the driver is
using ... Since it's a legacy irq, it should indeed not need any virtual
mapping (irqs below 16 are reserved for i8259)

So overall, sounds good to me, there is something lurking around but I
can't see it. (BTW. Why do you need to fixup all those IRQs ? Can't you
just have a proper interrupt-map ?

Ben.
