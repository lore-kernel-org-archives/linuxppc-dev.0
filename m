Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1887ADDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 13:51:32 +1100 (EST)
In-Reply-To: <1171506164.20192.228.camel@localhost.localdomain>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<1171488643.20192.177.camel@localhost.localdomain>
	<7fa77edce7aeb8a41d03b8b422f7f71b@kernel.crashing.org>
	<1171500782.20192.204.camel@localhost.localdomain>
	<692d02b69479653f689a50a1257f43e9@kernel.crashing.org>
	<1171506164.20192.228.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dbdca7d552aa5656915ef3d8e95365df@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 03:51:26 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It doesn't really hurt to have a "#a = 0" prop, but it's
>> better to just not have a #a prop if you shouldn't have one.
>
> Let's have one for now. I think that's how I documented it and it works
> fine while I'm not sure the kernel code will cope with not having it 
> (it
> may ... or not).

It *used* to work some months ago, at least.

> There are various issues with the OF bindings, especially the imap one
> (and some pretty bad bugs in it)

You keep saying this but I can't find any (except in the
examples, there are some really obvious bugs there -- but
examples aren't part of the binding /per se/).  Can you
please tell me what these bugs are?

> and that's one of the reason I prefer
> not leaving anything to be "implicit" like this case.

It is not implicit; it is an exception.  It really is
wrong to have the #address-cells property in a node
like this (though pretty much harmless in practice).

> It want explicit
> mention of #address-cells/#size-cells/#interrupt-cells at all levels
> where they might enter the parser.

But they *cannot* be used by the parser (for memory
regions) here; and the parser for interrupt mappings
better handle this case correctly (and like I said,
I believe it does, at least in some cases ;-) ).

What you're really saying is "my code might handle
edge cases incorrectly, so please enter incorrect
input to avoid those cases".


Segher
