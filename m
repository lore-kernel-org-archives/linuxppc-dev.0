Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B36C4DDF39
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 16:08:50 +1000 (EST)
In-Reply-To: <20070618185715.321010@gmx.net>
References: <20070618185715.321010@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <136ef2695edbe7c8a535b5b4c7a669bf@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Tue, 19 Jun 2007 08:08:42 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: ppcdev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Your "To:" header was broken...]


> 1. The AmigaOne makes use of different G3 (750Cx, 750GL, 750GX) and G4 
> (7400, 7450, 7455, 7457) CPUs. The current dts file defines a cpu node 
> with the name "PowerPC,7xxx@0" and the bootwrapper just fills in the 
> cpu-, bus- and timebase frequencies. Is this the recommended way, or 
> should the bootwrapper create a fresh cpu node with the correct name 
> of the CPU (e.g. "PowerPC,7455@ 0" - I guess this would require a 
> table with all PVR values and their corresponding CPU name. Or is 
> there a function in the kernel that do this?).

Just name the cpu nodes "cpu@0" etc.  The "generic names"
recommended practice wants this, and the node names here
aren't actually used by anything anyway, except they look
nice to the user.  The PowerPC ISA binding predates the
generic names r.p. btw.

> 2. I tried to define all ISA devices, which are integrated in the 
> southbridge (VT82C686B). Currently these are child nodes of the device 
> tree root.

This cannot work on PowerPC since PowerPC doesn't have
legacy I/O on the system bus.

> Should they be child nodes of the southbridge's PCI-to-ISA device node?

Yes.

> If so, where should I specify the register address ranges (reg 
> property)? In the PCI device node or in the ISA device nodes, as it is 
> now?

Both.  Each device has a "reg" property that describes that
device's registers relative to the addressing on the bus it
sits on.  All busses that do a direct one-to-one mapping of
some address range (perhaps with a translation) have a "ranges"
property describing that.

> 3. The dts files define the device_type of a serial port as "serial", 
> whereas the OF spec says "pnpPNP,501". What's the difference between 
> the two?

"device_type" is "serial", "compatible" is "pnpPNP,whatever".

Where in the OF specs did you find this pnpPNP thing btw?

> 4. I couldn't find any information for a device tree representation of 
> the i8259 interrupt controller in the booting-without-of.txt file. Is 
> my implementation correct (inspired by the OF documents)?

"name" = "device_type" = "interrupt-controller".
"compatible" is one of those pnpPNP things.

> I would be grateful, if you could take a look at my dts file and 
> comment on every line that doesn't meet your views.

Please send the thing inline, not as an attachment.


Segher
