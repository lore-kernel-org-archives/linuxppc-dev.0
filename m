Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B60F2DDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 22:37:06 +1000 (EST)
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20070618185715.321010@gmx.net>
References: <20070618185715.321010@gmx.net>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 22:36:46 +1000
Message-Id: <1182429406.24740.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 2. I tried to define all ISA devices, which are integrated in the
> southbridge (VT82C686B). Currently these are child nodes of the device
> tree root. Should they be child nodes of the southbridge's PCI-to-ISA
> device node? If so, where should I specify the register address ranges
> (reg property)? In the PCI device node or in the ISA device nodes, as
> it is now?

You should have /pci/isa <--- this is the PCI2ISA bridge

and the ISA devices below that. Best is I send you an example of a CHRP
or pSeries devie-tree with ISA stuff on it tomorrow. Ping me if I
forget.

> 3. The dts files define the device_type of a serial port as "serial",
> whereas the OF spec says "pnpPNP,501". What's the difference between
> the two?

Use the pnp stuff for "compatible", you can mostly ignore device_type or
set it to the same as name.

> 4. I couldn't find any information for a device tree representation of
> the i8259 interrupt controller in the booting-without-of.txt file. Is
> my implementation correct (inspired by the OF documents)?

Haven't looked at your .dts yet but it should be "interrupt-controller",
compatible "chrp,iic" or "i8259", with a #interrupt-cells of 2 and
interrupts following the standard ISA encoding. You probably also want
an interrupt-parent property in the isa bridge node pointing back to the
8259 so it becomes the default for all ISA devices.

> I would be grateful, if you could take a look at my dts file and
> comment on every line that doesn't meet your views.

Will do as soon as I find some time...

Ben.
