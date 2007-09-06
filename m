Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44039DDF20
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:41:59 +1000 (EST)
In-Reply-To: <20070904122040.276440@gmx.net>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<1188808900.5972.133.camel@localhost.localdomain>
	<ad58529dfd4a248ab904c2c5871258bf@kernel.crashing.org>
	<20070903101234.GA12212@localhost.localdomain>
	<20070903161156.306700@gmx.net>
	<6858c7a36ed061265937daa7b14cc5ac@kernel.crashing.org>
	<20070904122040.276440@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d6f9e35f29d20d697e2f9176011adb70@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Date: Thu, 6 Sep 2007 15:41:57 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> BTW: It looks like the Pegasos II device tree defines device_type = 
> "spi"
> for the IDE controller. Is that correct?

There is no standard binding for an "spi" device type.  I have no
idea which of various "SPI" kind of devices is meant here; and none
of the ones I know of have anything to do with ATA anyway.

In short, it probably is incorrect.

Also, in general, you shouldn't use "device_type" in flat device
trees (the main exceptions are: some/most bus nodes, cpu nodes,
some other "standard" nodes).

>> There is no such thing as "interrupt 14 and 15" on PCI.  You can use
>> the interrupt mapping recommended practice to show two interrupts
>> (and their polarity, and how they are routed to the relevant interrupt
>> controller) in the IDE node.
> But I'll still need a quirk in the IDE driver, because it doesn't make
> use of any interrupt routing information in the device tree. If so, I
> can omit the whole IDE controller device node and simply rely on the
> IDE driver's probe functions and the Pegasos IDE IRQ quirk.
> I wonder how this issue will be handled for libata and the via-pata
> driver, since IIRC this one doesn't contain the Pegasos IDE IRQ quirk.

I imagine the ata quirk would ask the arch or platform code about
the interrupts used; it in turn can query the device tree.


Segher
