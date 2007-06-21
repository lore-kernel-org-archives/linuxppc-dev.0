Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4AD2DDF1E
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 00:39:01 +1000 (EST)
In-Reply-To: <20070621132059.25900@gmx.net>
References: <20070618185715.321010@gmx.net>
	<1182429406.24740.6.camel@localhost.localdomain>
	<20070621132059.25900@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5e4e419b28d588fa6ee40e2aeb93de2c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Thu, 21 Jun 2007 16:38:49 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> You probably also want
>> an interrupt-parent property in the isa bridge node pointing back to 
>> the
>> 8259 so it becomes the default for all ISA devices.
> What about PCI devices? Wouldn't it better to define the 
> interrupt-parent property in the PCI bus node?

Devices on an ISA bus have their interrupts encoded according
to the ISA bus binding; this is exactly the format that the
ISA interrupt controller (the 8259) expects, so by setting
the interrupt-parent on the bus node to point to the 8259 (and
not doing interrupt mapping in the ISA child nodes) all works
exactly as planned.

Devices on a PCI bus have their interrupts encoded according
to the PCI bus binding; this is a very much different format
so you better have a real mapping (probably in the PCI host
bridge) translating it to ISA interrupts (and pointing it there),
if that's how the interrupts are routed on your box.

I hope this helps, it's a bit hard to explain without whiteboard :-)


Segher
