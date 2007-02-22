Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CB06DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 00:40:03 +1100 (EST)
In-Reply-To: <20070222103410.GB11014@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Thu, 22 Feb 2007 12:06:09 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stuart Yoder <b08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Not really a hack, this is documented in the interrupt
>> binding:
>
> No, it really is a hack, I'm afraid.  interrupt-map doesn't in general
> make sense for mapping interrupt-children which are not physical
> children.  Why?  Because the interrupt map includes unit specifiers,
> which means the expected addressing format in the interrupt map must
> match that of the reg property in every node mapped through it.

Hrm I guess I misunderstood the way you do things now.
Could you give an example?  I'm too lazy to look up
the DTS file :-)

> We get away with it in this case because we ignore the unit specifier
> part,

That's perfectly fine for many interrupt maps.

> and the kernel parser happens to use the interrupt parent's
> #address-cells value, rather than the physical parent's.

For the child interrupt specifiers, the "#address-cells"
value in the node containing the "interrupt-map" itself
should be used.  For the parent interrupt specifier, the
"#address-cells" value in whatever node the "interrupt-map"
for the matching entry points to should be used.

It sounds like the kernel does the right thing here?

[Of course the #a value better be the same as the value
in the physical parent, and all nodes mapping via a
particular "interrupt-map" better have unique unit
address for that map].

>>> 3.3.  "interrupt-map" property
>>> At any level in the interrupt tree, a mapping may need to take
>>> place between the child interrupt domain and the parent=92s.  This
>>> is represented by a new property called "interrupt-map".
>>
>> Note it says "*any* level".
>
> We could do this properly via an interrupt map by placing the MAL
> under a MAL-interrupt-nexus node, which exists to do nothing but remap
> the interrupts.  That's pretty horrible, though.

It doesn't have to physically be under there, only in the
*interrupt* tree.  This situation isn't specific to your
situation; it happens in other cases with weird wiring
too.

>> As an added bonus you end up
>> with one single namespace for the interrupts (one interrupt
>> domain in interrupt-mapping speak), which is probably what
>> the chip documentation does as well.
>
> No, actually.  Afaict for the 4xx chips, the user manuals just give
> the interrupt mapping in tables in the the chapter on the interrupt
> controllers.  There's a separate table, with separate interrupt
> numbers for each UIC.

Oh okay.


Segher
