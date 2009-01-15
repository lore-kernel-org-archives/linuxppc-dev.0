Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3FC7DE27D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 16:34:53 +1100 (EST)
Message-Id: <4C97C40F-4A5F-4B29-80CB-25402B92060E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: ken@williamsclan.us
In-Reply-To: <601774780901142115v688a2c76p619dfb80b72f5ea8@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: interrupt number assignment dts file help
Date: Wed, 14 Jan 2009 23:34:46 -0600
References: <601774780901142115v688a2c76p619dfb80b72f5ea8@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 14, 2009, at 11:15 PM, Ken Williams wrote:

> I am trying to configure a dts file for the pci subsystem of a  
> MPC8540 based system.
>
> I am expecting (hoping) that the value specified in the interrupts  
> property (98 in this example)
> will be used as the virtual interrupt number and that I can later do  
> a request_irq using that number.

The .dts deals with physical interrupt numbers.  Virtual IRQs is a  
linux concept.

> kernel: 2.6.26.3
>
> The board level configuration is:
>  ADR29 connected to IDSEL
>  using INTA# only
>  The PCI interrupt is connected to external IRQ2
>
> What I see is that inside irq_create_mapping, a call to  
> irq_find_mapping produces a null virq,
> so irq_alloc_virt is called and comes back with x12.  Can I assign  
> the number to 98 (x62)
> using the dts?  Any help would be greatly appreciated.

Do you want INTA# or the PCI error interrupt?

I'm guessing INT A#.

Here's an example from the mpc8540ads.dts:

         pci0: pci@e0008000 {
                 cell-index = <0>;
                 interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
                 interrupt-map = <
...
                         /* IDSEL 0x03 */
                         0x1800 0x0 0x0 0x1 &mpic 0x4 0x1
                         0x1800 0x0 0x0 0x2 &mpic 0x1 0x1
                         0x1800 0x0 0x0 0x3 &mpic 0x2 0x1
                         0x1800 0x0 0x0 0x4 &mpic 0x3 0x1


...

So the interrupt-map here deals w/PCI INTA# to INTD#.

(0x1800 0x0 0x0) (0x1) &mpic ((0x4) (0x1))
(pci address) (intA) pic-handle (pic HW IRQ) (irq sense info)

So to decode the example we have for IDSEL 0x03:
INTA: irq 4
INTB: irq 1
INTC: irq 2
INTD: irq 3

If you have a proper PCI driver in linux you shouldn't have to deal  
with virtual IRQs at all.

- k
