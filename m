Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6230DDD0E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 11:07:32 +1100 (EST)
In-Reply-To: <20070222225707.GB15387@localhost.localdomain>
References: <b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<20070222225707.GB15387@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <621751322ddfe998a15538e8d3903b93@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Fri, 23 Feb 2007 01:07:25 +0100
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

>> Option #3 -- define new, logical interrupt nexus to do
>> the mapping.

> There's no point to option 3 as given.  If we're going to use an
> interrupt nexus, and rely on the fact that the physical versus
> interrupt tree addressing mismatch doesn't matter in this case, then
> we might as well put the interrupt nexus into the node itself,
> i.e. option 1.

That can give problems if there are interrupts in one
of the descendants of the node.  It's also just nasty,
don't you agree?

> The only point to 3 would be if we make the MAL a
> child of its interrupt nexus, thereby ensuring that the address forms
> match.

No, you cannot do that.  There is no extra device
there in reality so it shouldn't be in the device tree
either.  Also, it just doesn't work.

> Something like:
>
> malint-nexus {
> 	#interrupt-cells = <1>;
> 	ranges;
> 	interrupt-map = <0 0 0 &UIC0 a 4
> 		.... >;
> 	interrupt-map-mask = <ffffffff 0 0>;

If you have a "ranges" property you need a
"#address-cells" and a "#size-cells" property
too -- it just doesn't make any sense otherwise.

You don't want this nexus node to be anywhere inside
the "normal" device tree -- it doesn't sit there in
hardware, it shouldn't sit there in the device tree,
that will only cause problems.

> Note the empty ranges property (passthrough).

There is nothing to pass anything through though,
this node shouldn't be here.

> That's kind of
> irrelevant here, since MAL is DCR controlled,

Yeah, so MAL should have the DCR reg in its "reg"
property.  It needs *something* there -- what if
you had two MALs?

> but would matter if we
> had a similar situation with a device that had MMIO registers (and
> therefore a "reg" property).

Sorry, I'm going to shout: "reg" HAS NOTHING TO DO
WITH MMIO.

> For MAL, since it has no "reg", we set
> the interrupt-map-mask to ignore the unit address.

So you're saying your "#address-cells" is not 0, but
you have no "reg" property?  Congratulations, you
built yourself a wildcard package.


Segher
