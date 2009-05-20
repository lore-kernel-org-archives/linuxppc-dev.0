Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85B3FDE081
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 07:56:31 +1000 (EST)
Subject: Re: Musings on PCI busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20090520.122453.169463011.davem@davemloft.net>
References: <1242788490.16901.133.camel@pasglop>
	<20090519.225118.58497608.davem@davemloft.net>
	<1242802267.16901.187.camel@pasglop>
	<20090520.122453.169463011.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 21 May 2009 07:56:09 +1000
Message-Id: <1242856569.16901.199.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I mean that all OF devices have fully resolved MMIO resources.  So
> very early serial devices that sit in I/O space on sparc64 end
> up being OF device drivers.  See for example, drivers/net/sunsu.c
> which is simply a 8250 chip that sits behind Sun's I/O space bus
> that sits on PCI and provides things normally found via ISA on
> x86 machines.  Another example is drivers/serial/sunsab.c

Right. On Cell, we use the "normal" 8250 driver, via of_serial which
basically initializes it from the of device and associated resources.

It gets a bit messy because we -also- create a platform driver that can
be matched by 8250, in fact, we have a bit of generic powerpc code that
does that early at boot, initializes our low level very early udbg
thingy with it and creates the platform devices.

And then the serial port can -also- be detected by 8250_pci.c when it's
on a PCI based UART :-)

Now, generally thinks work fine even if you use all 3 drivers because
they have the same resources and 8250 has some smarts to figure that out
and not re-create ports. It somewhat fails in the case where we end up
with IO looking like MMIO on one side and looking like PCI IO on another
tho.

We -could- try to standardize on a single of those 3 methods of course.
The of_serial one has some appeal but I quite like the platform driver
approach at this stage because we have code to handle all sort of weirdo
special cases in there (more or less insane device-tree's, weird SoC's,
etc...) and still pump out something 8250_platform can grok, and that
code can run -very- early and provide a udbg backend for early debug and
xmon usage.

> I would make these device drivers OF device drivers.
> 
> Another option is to make use of the "address" property if present.
> You can bypass all of the hassle of figuring out what the 'reg'
> property resolves to by using that and if the device is the
> console it is pretty reliable to expect OF to provide that "address"
> property.
> 
> Of course this doesn't work well for non-console devices.

Also we have various broken firmwares with non usable "address"
properties to deal with.

Ben.
