Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA098DDD0E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 11:50:59 +1100 (EST)
In-Reply-To: <20070223003317.GA18508@localhost.localdomain>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<20070222225707.GB15387@localhost.localdomain>
	<621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
	<20070223003317.GA18508@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1be2170fcb25fdc4ac52c93444269737@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 01:50:53 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> The only point to 3 would be if we make the MAL a
>>> child of its interrupt nexus, thereby ensuring that the address forms
>>> match.
>>
>> No, you cannot do that.  There is no extra device
>> there in reality so it shouldn't be in the device tree
>> either.  Also, it just doesn't work.
>
> Exactly, there's no extra device in reality.

There is no extra device ***THERE*** in reality, i.e.
between the MAL and the PLB it sits on.  There certainly
_is_ ***AN*** extra device: a bunch of wires routing
different IRQs toi different interrupt controllers.

> So I don't see that it's
> any more bogus to put the fake device as the MAL's parent than as the
> MAL's child or sibling or anywhere else in the tree.

It's not nice to hang random devices at "random" spots
in the tree, but it can't be helped if there is no place
other than in the interrupt tree.  But you simply cannot
make a node that has nothing to do with addressable devices
the parent of a node that *is* an addressable device!

> To represent this without either the nexus-in-node or an extra bogus
> node,

Not bogus.

> we need something like interrupt-array.

Again, the "interrupt-array" helps only this one specific
case, and not the general case *at all*.

> Which is why I like the
> idea.

And I don't :-)

>> You don't want this nexus node to be anywhere inside
>> the "normal" device tree -- it doesn't sit there in
>> hardware, it shouldn't sit there in the device tree,
>> that will only cause problems.
>
> So why did you suggest its existance in the first place?

It is existing hardware.  We need to represent it here.
We just cannot put it anywhere in the tree of addressable
devices since it's not addressable.

> If it shouldn't be here, it shouldn't be anywhere else either.

Bollocks.  If you put the node elsewhere you wouldn't
be pretending that all traffic to/from the MAL goes
through this node.

>>> That's kind of
>>> irrelevant here, since MAL is DCR controlled,
>>
>> Yeah, so MAL should have the DCR reg in its "reg"
>> property.  It needs *something* there -- what if
>> you had two MALs?
>
> No, because that would potentially collide with "reg" properties in
> its siblings which have MMIO addresses on the parent bus.

And since the MAL is not addressable on the PLB it shouldn't
sit on the PLB in the device tree.  It can DMA to the PLB sure,
but DMA isn't represented in the device tree.  The device
tree is the the tree that says "if I want to access this device
what device do I reach it over".

>>> but would matter if we
>>> had a similar situation with a device that had MMIO registers (and
>>> therefore a "reg" property).
>>
>> Sorry, I'm going to shout: "reg" HAS NOTHING TO DO
>> WITH MMIO.
>
> Not in general, no, but here specifically it does.  "reg" has to match
> the address type of the parent bus, in this case that's MMIO.  But the
> MAL *is* on the PLB (it's a PLB master, in fact), but it has no
> address on the PLB.

Yes.  So it's not addressable on the PLB.  So it cannot have
its unit address represent a PLB address.  So it cannot have
the PLB bus as parent.

>>> For MAL, since it has no "reg", we set
>>> the interrupt-map-mask to ignore the unit address.
>>
>> So you're saying your "#address-cells" is not 0, but
>> you have no "reg" property?  Congratulations, you
>> built yourself a wildcard package.
>
> How else would you represent a device which exists on the bus, but
> which has no address on the bus?

If it's not addressable on the bus, it's not represented
on that bus.  Busmasters are represented differently
(typically not at all; in a few cases you need to explicitly
link up devices with IOMMUs).


Segher
