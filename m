Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D8DDDDF24
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:36:31 +1000 (EST)
In-Reply-To: <20070904114945.303440@gmx.net>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3acb0846724373a8f9edcf4650cc5455@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Date: Thu, 6 Sep 2007 15:36:30 +0200
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

>> PCI memory space sits on the PCI bus, not on the PCI host bridge,
>> so is not part of "reg" but is part of "ranges" here, since it is
>> direct mapped into the host's address space.
> That's right, but what about this example here (from a Pegasos II):
>
> /proc/device-tree/pci@80000000:

> reg              80000000 40000000

> ranges           01000000 00000000 00000000 fe000000 00000000 00010000
> 		 02000000 00000000 80000000 80000000 00000000 40000000

That's just broken.

> AFAIU the reg property overlaps the ranges property for the PCI memory
> space from 0x80000000 to 0xC0000000 or the CPU address space at the
> same location!?

reg = < something for pci config space >,
       < fe000000 10000 >

ranges = < 02000000 0 80000000  80000000  0 40000000 >

>> PCI legacy I/O is not direct mapped: there is no legacy I/O on a
>> PowerPC system bus.  So, it can not be mentioned in the "ranges"
>> property, but the PHB registers used to access it should be shown
>> in the "reg" property.  It could be a simple linear window (it
>> sounds like it is here?), but it could for example also be implemented
>> via an address/data register pair.
> Yes, it is a simple linear address window. I'll remove its address 
> range
> from the reg property.

No, please remove it from the "ranges" property, instead.

>> The order of the "reg" entries depends on the exact model of PCI
>> bridge, so a device binding for it has to be written.
> Only the Pegasos I and the AmigaOne use this PCI bridge. I guess it 
> should
> be enough to check for the board type, but a compatible property 
> doesn't
> hurt.

Please always use "compatible" to probe any devices.


Segher
