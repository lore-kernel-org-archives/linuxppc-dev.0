Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F984DDE09
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 08:33:21 +1000 (EST)
In-Reply-To: <20070903145814.101070@gmx.net>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Date: Tue, 4 Sep 2007 00:32:57 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>   	pci@80000000 {
>>> 		device_type = "pci";
>>> 		bus-frequency = <01fca055>;		// 33.3MHz
>>> 		bus-range = <0 1>;
>>> 		reg = <80000000 7f000000>;				//
>>> Whole PCI space.
>>
>> 'reg' and 'ranges' should not typically overlap.  'reg' should only
>> encode control registers for the bridge, not the whole PCI space (not
>> that I'm even entirely sure what you mean by that).
> Hmm, strange. I'm sure I found this in another device tree. I define
> "whole PCI space" as PCI (prefetchable) memory and PCI I/O space.

PCI memory space sits on the PCI bus, not on the PCI host bridge,
so is not part of "reg" but is part of "ranges" here, since it is
direct mapped into the host's address space.

PCI legacy I/O is not direct mapped: there is no legacy I/O on a
PowerPC system bus.  So, it can not be mentioned in the "ranges"
property, but the PHB registers used to access it should be shown
in the "reg" property.  It could be a simple linear window (it
sounds like it is here?), but it could for example also be implemented
via an address/data register pair.

The order of the "reg" entries depends on the exact model of PCI
bridge, so a device binding for it has to be written.

>>> 		host@0 {
>>
>> The unit address (after the @) should be derived from the first range
>> listed in the 'reg' property.  It's a bus address, not a slot number.
> AFAIK it's the device number, which is 0 for this host/PCI bridge.

The unit address is relative to the parent bus.  The PCI host bridge
is not its own parent ;-)


Segher
