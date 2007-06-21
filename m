Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EB03DDED9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 09:22:57 +1000 (EST)
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20070621132059.25900@gmx.net>
References: <20070618185715.321010@gmx.net>
	<1182429406.24740.6.camel@localhost.localdomain>
	<20070621132059.25900@gmx.net>
Content-Type: text/plain
Date: Fri, 22 Jun 2007 09:22:49 +1000
Message-Id: <1182468169.24740.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Haven't looked at your .dts yet but it should be "interrupt-controller",
> > compatible "chrp,iic" or "i8259", with a #interrupt-cells of 2 and
> > interrupts following the standard ISA encoding. You probably also want
> > an interrupt-parent property in the isa bridge node pointing back to the
> > 8259 so it becomes the default for all ISA devices.

> What about PCI devices? Wouldn't it better to define the interrupt-parent property in the PCI bus node?

PCI devices generally have their interrupts specified by an
interrupt-map in the PCI bridge.

Do you have the recommended practice "interrupt mapping" standard ?

It also allowed to make it optional to have nodes for the PCI devices in
slots, you can provide the mapping of all 4 INT# lines in the bridge
node and linux can use it when probing for devices, so your bootwrapper
doesn't have to know what's in the slots and doesn't have to create
device nodes for those.

Ben.
