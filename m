Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF34FDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Nov 2008 16:49:35 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Device tree and IRQ for chip on PCI
Date: Tue, 18 Nov 2008 06:49:28 +0100
References: <492189ED.6050700@selcomgroup.com>
In-Reply-To: <492189ED.6050700@selcomgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811180649.28792.matthias.fuchs@esd-electronics.com>
Cc: Matteo Fortini <m.fortini@selcomgroup.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Matteo,

> I have a chip connected on the PCI bus on an MPC512x, but if I get the
> IRQ property from the PCI chip, it is not set up by Linux.
It's not clear to me what you mean by this. 
Do you see an interrupt assigned to your pci device's PCI_INTERRUPT_LINE 
register? Check lspci output.

> The IRQ line goes directly from the chip to the MPC512x uc, so I don't
> know if I should create a separate node just to get the interrupt, or I
No. The pci node in  the DT should be ok.
Because you posted to an embedded list, I need to ask this: are you using a 
custom hardware? Does the DT fit to your board's interrupt / IDSEL routing?

Matthias

> should expect the pci functions to assign it an interrupt based on the
> PCI bus.
>
> The description for the PCI bus is like this:
>         pci: pci@80008500 {
>                 interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
>                 interrupt-map = <
>                                 // IDSEL 0x15 - Slot PCI
>                                  0xa800 0x0 0x0 0x1 &ipic 0x0 0x8
>                                  0xa800 0x0 0x0 0x2 &ipic 0x1 0x8
>                                  0xa800 0x0 0x0 0x3 &ipic 0x2 0x8
>                                  0xa800 0x0 0x0 0x4 &ipic 0x3 0x8
>
>                                 >;
>
>                 interrupt-parent = < &ipic >;
>                 interrupts = <17 0x8>;
>                 bus-range = <0 0>;
>                 ranges = <0x42000000 0x0 0xa0000000 0xa0000000 0x0
> 0x10000000
>                           0x02000000 0x0 0xb0000000 0xb0000000 0x0
> 0x10000000
>                           0x01000000 0x0 0x00000000 0x84000000 0x0
> 0x01000000>;
>                 clock-frequency = <66000000>;
>                 #interrupt-cells = <1>;
>                 #size-cells = <2>;
>                 #address-cells = <3>;
>                 reg = <0x80008500 0x100>;
>                 compatible = "fsl,mpc5121-pci";
>                 device_type = "pci";
>         };
