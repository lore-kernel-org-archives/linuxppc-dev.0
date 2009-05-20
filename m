Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 562BCDE18A
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 05:24:59 +1000 (EST)
Date: Wed, 20 May 2009 12:24:53 -0700 (PDT)
Message-Id: <20090520.122453.169463011.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: Musings on PCI busses
From: David Miller <davem@davemloft.net>
In-Reply-To: <1242802267.16901.187.camel@pasglop>
References: <1242788490.16901.133.camel@pasglop>
	<20090519.225118.58497608.davem@davemloft.net>
	<1242802267.16901.187.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, thunderbird2k@gmail.com, John.Linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 20 May 2009 16:51:07 +1000

> On Tue, 2009-05-19 at 22:51 -0700, David Miller wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Date: Wed, 20 May 2009 13:01:30 +1000
>> 
>> > For example, some of the OF parsing bits may fail to convert memory
>> > addresses to IO addresses if the PCI host bridges have not been
>> > discovered yet, potentially causing issues with matching of resources
>> > between the early serial stuff and the generic serial driver (if you
>> > use an IO driven UART, the PCI 8250 driver may not properly figure out
>> > that what it's finding in its IO BARs is actually the same port as
>> > what it gets from the platform code as the later will end up with
>> > memory addresses rather than IO ones). That's one example.
>> 
>> FWIW, I never run into this issue on sparc64 exactly because I
>> fully resolve all resources when I populate the OF device tree
>> in the kernel.
> 
> What do you mean by fully resolve ? IE. The issue above is specific to
> IO space, which you can resolve both as MMIO, or as "IO" which in linux
> means going through the special mapping for IO which allows the use of
> the inX/outX instructions...

I mean that all OF devices have fully resolved MMIO resources.  So
very early serial devices that sit in I/O space on sparc64 end
up being OF device drivers.  See for example, drivers/net/sunsu.c
which is simply a 8250 chip that sits behind Sun's I/O space bus
that sits on PCI and provides things normally found via ISA on
x86 machines.  Another example is drivers/serial/sunsab.c

> One of the issues we may have here on powerpc is that our very early
> probe of serial ports (so we get some debug output early) may get to
> those resources while the serial driver later sees the actual
> IORESOURCE_IO resources coming from the PCI probe, and is unable to
> figure that they are the same things.

I would make these device drivers OF device drivers.

Another option is to make use of the "address" property if present.
You can bypass all of the hassle of figuring out what the 'reg'
property resolves to by using that and if the device is the
console it is pretty reliable to expect OF to provide that "address"
property.

Of course this doesn't work well for non-console devices.
