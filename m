Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFA65DDE3B
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 18:02:27 +1000 (EST)
In-Reply-To: <4663203F.30301@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<4662FA67.3020107@ru.mvista.com>
	<a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
	<4663060C.2020906@ru.mvista.com>
	<c077dedaa90bf4fb3af1c5c8c4b39c85@kernel.crashing.org>
	<46630F8F.6080708@ru.mvista.com>
	<bd28eac8eb60db8aaff74f91c76d4196@kernel.crashing.org>
	<4663203F.30301@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <684998b70818959ac54de4e6c2aa927c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Mon, 4 Jun 2007 10:02:16 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> flash node obviously needs _some_ parent node though --
>> this is a tree after all.
>
>   Yes, of course it always has a perent. The question is which parent 
> it should be. :-)

Almosts always the correct choice is the physical
bridge/controller for the bus the flash sits on.

>> That is described in the "reg" property of the flash
>> node, just like for any other node.
>
>    Ah. So simple. :-)
>    What I failed to realize so far was that "ranges" imply 1:1 address 
> correspondence. But not all is so simple, I'm afraid. The flash chips 
> themselves could be connected to their bus in some weird fashion, I'm 
> afraid

In that case it is not direct-mapped, you have no "ranges"
in the parent node, and the kernel driver for the parent
node will know how to access its child bus.

>> It seems we really need more howto-style docs...
>
>    It may indeed be non-trivial task to find all the necessary specs 
> besides 1285 itself -- I just happened to know where to grab them 
> beforehand:

1275

> http://www.openbios.org/Bindings

There is only a subset there.  http://playground.sun.com/1275/
is the canonical location; there is a bunch of good docs in
the Sun library thing too (search for "FCode" or "OpenBoot").
Much of that has to do with using real OF, but lots of it is
valid/useful for a bare device tree as well.


Segher
