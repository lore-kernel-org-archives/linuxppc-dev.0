Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E36F9DDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 02:24:04 +1000 (EST)
Message-ID: <46C47A1D.5030303@freescale.com>
Date: Thu, 16 Aug 2007 11:23:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: external IRQ's
References: <f87675ee0708160751u14f96dbcs3ad35a147b70a3f3@mail.gmail.com>
In-Reply-To: <f87675ee0708160751u14f96dbcs3ad35a147b70a3f3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

robert lazarski wrote:
> 1) Do I need to define those external IRQ's in both a device tree file
> under arch/powerpc/boot/dts and also in C code under
> arch/powerpc/platforms/85xx ?

Just in the dts.

> 2) I've been told on another list that "External interrupts start at
> zero (internal interrupt numbers have 0x10 added to them), so the
> first cell should correspond to the external IRQ
> number."  I'm having a hard time applying that advice to a MDIO node
> and ethernet node in the device tree. For example, the CDS board for
> 8548 has the following:
> 
> mdio@24520 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         device_type = "mdio";
>                         compatible = "gianfar";
>                         reg = <24520 20>;
>                         phy0: ethernet-phy@0 {
>                                 interrupt-parent = <&mpic>;
>                                 interrupts = <35 0>;
>                                 reg = <0>;
>                                 device_type = "ethernet-phy";
>                         };
>                         ...
> };

I don't know what version of the dts you're looking at, but the one in 
the current Linux tree has <5 1>, not <35 0>.

> I'm also not getting the ethernet interrupts in the above cds example:
> 
> interrupts = <d 2 e 2 12 2>;
> 
> Why start with 'd' and 'e' ?  I noticed many if not all boards do that.

In the current dts, it's <1d 2 1e 2 22 2>.

It appears that the interrupt numbering was changed not too long ago, 
and that external interrupts used to be numbered above the internal ones.

-Scott
