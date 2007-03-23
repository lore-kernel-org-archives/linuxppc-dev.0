Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AD96EDE035
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 23:35:17 +1100 (EST)
In-Reply-To: <20070323032440.GD28006@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172848.GG29784@ld0162-tx32.am.freescale.net>
	<20070317012654.GE3969@localhost.localdomain>
	<c01196ee10aa2b13278465a835a49fdf@kernel.crashing.org>
	<20070321234226.GB2295@localhost.localdomain>
	<7ce9c69ae76258f47790c5ceb851a355@kernel.crashing.org>
	<20070323032440.GD28006@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <24d3db180f457c9a6e659a68bd4287ab@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 07/17] bootwrapper: Add dt_set_memory(),
	to fill in the /memory node.
Date: Fri, 23 Mar 2007 13:34:55 +0100
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

>>>>> However, #address-cells=2, #size-cells=1 is common enough that we
>>>>> really need to support that case.
>>>>
>>>> On the root node?!?  Who would do such a strange thing?
>>>
>>> Ebony, for one, it works nicely for a 32-bit system with >32-bit bus.
>>
>> It means you cannot have a 4GB-or-bigger region below your
>> root node.  Dunno if Ebony ever needs one, for I/O mapping
>> perhaps?
>
> Nope.  0-4GB is RAM, 4-8 is in-built IO, 8-12 is PCI IO, and I forget
> what 12-16 is, if anything.

Let's take the first of these -- 4GB of RAM.  Not that
you'll ever see an Ebony with that much memory of course ;-)

How do you express 4GB of memory when #a=2 #s=1?  Something
like

reg = < 0 0  ffffffff   0 fffffff  1 >

and you're lucky this is actually allowed in a memory
node, some other nodes/properties won't allow you to.

Contrast this to #a=2 #s=2 where you simply say

reg = < 0 0  1 0 >

>>> Apple G5s do it too.
>>
>> And they do a an awful workaround for their memory node
>> because of this.
>>
>> Is their any reason why you couldn't use #a=#s=2 on 32-bit
>> systems?  The root node is one contiguous hunk of address
>> space, so the biggest (theoretically) possible size is equal
>> to the biggest address (+1).  It's not hard to come up with
>> an example where you need a size of 4GB or more.
>
> Well, yes, we could.  I believe the only reason Apple does it is to
> make the tree a little more compact.

I think the main reason is that their 64-bit OF actually
is a 32-bit one with lots of weird extras tugged on ;-)

> But the point is that trees are
> out there with #a=2 #s=1, so the fixup code ought to be able to handle
> them.

Yes of course, I'm not disagreeing there -- I'm just
saying that for boards where we do have control over
the device tree we should discourage this monstrosity :-)


Segher
