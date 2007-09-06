Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D510DDEF5
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 23:56:47 +1000 (EST)
In-Reply-To: <20070905024805.GE17189@localhost.localdomain>
References: <20070831175006.17240@gmx.net>
	<20070903013431.GG31499@localhost.localdomain>
	<20070903145814.101070@gmx.net>
	<f460b176a7c30dae101bfc00d1d4b8e9@kernel.crashing.org>
	<20070904114945.303440@gmx.net>
	<20070905024805.GE17189@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <22dc6fa3382b591fe721c1b9dee88097@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] AmigaOne device tree source v2
Date: Thu, 6 Sep 2007 15:56:38 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> That looks totally bogus.  Unlike Segher, I think there are a few
> cases where overlapping reg and ranges can make sense

That's not unlike me -- I may have lower tolerance for it though :-)

> (PCI bridges
> where config space is accessed indirectly via MMIO registers which lie
> in the legacy ISA IO space is an example).

That's a good example yes.

> But this doesn't look like
> such a case - it just looks like whoever did the device tree
> misunderstood the distinction between reg and ranges.

Indeed.

>>> PCI legacy I/O is not direct mapped: there is no legacy I/O on a
>>> PowerPC system bus.  So, it can not be mentioned in the "ranges"
>>> property, but the PHB registers used to access it should be shown
>>> in the "reg" property.  It could be a simple linear window (it
>>> sounds like it is here?), but it could for example also be 
>>> implemented
>>> via an address/data register pair.
>
> Err... huh?  The legacy IO space is assigned a block of addresses in
> 3-word "OF-PCI-space by the PCI binding.  When that is translated into
> an MMIO range by the bridge, there's no reason that can't be encoded
> into the ranges property.

Sure, it can be encoded like that.  But does it make sense?
You cannot use legacy I/O space as normal memory space.

On an arch like x86, where "I/O addresses" exist on the system
bus as well, it would make sense, since you can translate I/O
addresses to I/O addresses that way (except on x86 even it cannot
be done either, since I/O addresses cannot be encoded on the root
bus -- at least not in existing device trees.  There is no official
x86 binding yet though).

Also, from a driver standpoint, a PHB driver needs to find out
two main things about the bridge: a) how and where to generate
config cycles; b) how and where to generate legacy I/O cycles.
It is told "how" by the "compatible" property, and "where" by
the "reg" property, normally.

But yes, you _can_ use "ranges" for this purpose on PHBs where
legacy I/O is linearly mapped.  It just doesn't make much sense.
The binding for your specific PHB should tell you what to do.

>> Only the Pegasos I and the AmigaOne use this PCI bridge. I guess it 
>> should
>> be enough to check for the board type, but a compatible property 
>> doesn't
>> hurt.
>
> The whole damn point of the device tree is to avoid using this kind of
> non-local information "I know what the board type is over there, so it
> must be this PCI bridge over here".  The node should have a compatible
> property which is sufficient to select the right bridge driver.

Yeah.  _Even if_ the kernel decides to cheat by hardcoding certain
board information, that doesn't mean the device tree shouldn't
encode that info, too.

> I think this is typically badly done at the moment, simply because PCI
> has historically been set up by the platform code, rather than by a
> "host bridge driver" in the mould of other drivers.  I don't see that
> changing real soon, but that doesn't mean we shouldn't at least put
> enough information in the device tree to make it possible.

Exactly.


Segher
