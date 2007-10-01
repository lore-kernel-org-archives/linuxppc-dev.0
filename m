Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EC95DDDE4
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 09:36:15 +1000 (EST)
In-Reply-To: <1191279244.6310.32.camel@pasglop>
References: <20071001210025.314240@gmx.net> <20071001211120.156280@gmx.net>
	<d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>
	<1191279244.6310.32.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <50f54f0408de0edb81c773c27ee3bd54@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Problem with OF interrupt parsing code
Date: Tue, 2 Oct 2007 01:36:25 +0200
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> This is an interrupt controller (it has an "interrupt-controller"
>> property, and it has no interrupt parent (there is no 
>> "interrupt-parent"
>> property, for interrupt controllers you do not follow the "normal" 
>> tree
>> parent), so it is the root interrupt controller and there is no loop.
>>
>> It seems from your description that the Linux code is using the tree
>> parent as interrupt parent even for interrupt controller nodes.  This
>> is wrong behaviour.
>
> It shoudn't normally happen. The reason it -does- happen in fact is 
> that
> the above node is also missing the #interrupt-cells property, which
> cause the parent-lookup routine to skip it before it gets a chance to
> see that there's an "interrupt-controller" property in there.
>
> I'm not sure whether linux behaviour is a bug or not since I believe we
> are clearly in undefined-land as an interrupt controller should always
> have a #interrupt-cells property.

That isn't required for legacy (pieces of) trees that don't go
through an interrupt-map, actually (but strongly recommended of
course) -- and I'm not sure how valid a tree that uses the imap
recommended practice for only part of the tree is really ;-)

Either way, the Linux code should use the explicit information (the
lack of "interrupt-parent" in a node with "interrupt-controller")
to determine whether a node is the root interrupt controller, instead
of some implicit information.  You can then more clearly do sanity
checking on "#interrupt-cells" etc.


Segher
