Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B88BDDF5B
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 22:12:50 +1100 (EST)
In-Reply-To: <20070322002911.GD2295@localhost.localdomain>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
	<20070322002911.GD2295@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <28ff7492856c7220f060cd113329e62f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Date: Thu, 22 Mar 2007 12:11:45 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Segher, what is the the 'other alias' mechanism you are referring
>>> to that should be dropped?  Is it this proposed linux,network-index
>>> property?  or something else?
>>
>> Just the
>>
>> 	pic0: pic@700 {
>> 		...
>> 	}
>>
>> labeling thing -- it becomes redundant when the flat tree
>> stuff would support OF-style aliases, so it can be phased
>> out then.
>
> dtc labels are *not* an alias mechanism: they're essentially a
> compile-time rather than run-time concept

Sure.  For flat device trees, you can evaluate the OF-style
aliases at compile time, too.

> and they can reference
> properties as well as nodes

I didn't know this though.  If that's useful (I don't see how
right now), you want to keep labels I suppose.

> Putting the aliases in a separate node is far less usable for the
> things labels are useful for than putting the label directly on the
> node.  Replacing labels with the OF alias mechanism is not sensible.

Well I dunno, it's used quite often in "real" OF to create
cross-references between the nodes, and I always found it
very handy.  There's no semantic difference (except with
aliases you can refer to nodes below the alias), and no big
syntactic difference either (well with labels you spread the
"short names" all over the tree, no relation between them
is immediately obvious).

> That said, auto-generating OF-style aliases from labels for the
> benefit of run-time users might be worthwhile.

Or the other way around.  Or both!

> And using /aliases
> would work about as well as the "linux,network-index" trick.

Better, like I explained already.


Segher
