Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF266DDE05
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 18:34:49 +1000 (EST)
In-Reply-To: <20070418164849.6f0fd817.kim.phillips@freescale.com>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<20070416115729.292c10b1.kim.phillips@freescale.com>
	<53810df560c7af272cd1c71c9d5fa1ab@kernel.crashing.org>
	<20070416193110.77b63e4b.kim.phillips@freescale.com>
	<788e650fbb3f95eaf1bfb6955f9cef17@kernel.crashing.org>
	<20070417152712.51c7348f.kim.phillips@freescale.com>
	<f170b2c44ae8a76dd4d35ceb94a624b0@kernel.crashing.org>
	<20070417201350.12727df7.kim.phillips@freescale.com>
	<524e7cf7aec7be8289ab2f99df8a0776@kernel.crashing.org>
	<20070418164849.6f0fd817.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d16d2a0d1742a32e45597baabfc3735a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Fri, 20 Apr 2007 10:34:41 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> ..but I'm not interested in specifying what interfaces the PHY
>>> supports.
>>
>> But you *have* to.  The device tree describes the hardware,
>> it is not a configuration file for Linux to use as it sees fit.
>
> not for the purposes of this patch; ucc_geth passes interface_type,

It doesn't matter what the Linux code does.  The device tree
describes the hardware, it is not a configuration file for
Linux to use as it sees fit.

> a
> property of the board describing the connection between the MAC and PHY
> (not a list of what connection types the PHY is capable of) to the
> phylib, and the phylib is left to probe, identify, and configure the 
> PHY
> appropriately.

Sure there's an argument for describing what type of
interface the PHY is connected on, if it supports more
than one -- but that should be a property in the PHY
node, not the controller node, since you can have multiple
PHYs connected to the same controller, possibly on
different interfaces each.

The m88e11x1 phylib code seems to ignore the "interface"
parameter completely btw.

>>>>> Again, max-speed is exclusively for configuring the UCC itself,
>>>>> regardless of the connection speed.
>>>>
>>>> If that is really true, and the value of that property
>>>> has nothing to do with the MAC<->PHY data channel, it should
>>>> have a different (not that generic) name.
>>>
>>> can you elaborate on why, including an example of what you'd think
>>> would
>>> be a better one?
>>
>> Very generic names should only be used by very generic bindings.
>
> it's intentionally generic; UCCs are Universal Communications
> Controllers and implement many communications protocols.

So?  That doesn't put the UCC device binding on the same
level as, say, PCI or the base OF definition.

>> If a very specific device binding (like yours) uses a property
>> name like that, there is a high chance it will clash with a more
>> generic binding it uses (PCI, ethernet, network, ...) -- perhaps
>> with a *future* version of such a binding.
>>
> I'm sure future versions will be able to adjust accordingly :)

Do you really think that when future changes are made to
base OF, or the PCI binding, or similar, that people will
even stop to consider what you did in your (unofficial)
binding and try to stay compatible to it?  Can I have
some of those pills?

>> Also, it isn't a great name /an sich/: "max-speed" -- maximum
>> speed of what?
>
> ?  it's fine - it's in the context of a communications device.
> Can you come up with something better?

Sure.  "ucc,max-speed" solves one problem; "max-comm-speed"
solves another.  I'm sure there are better names possible,
so please find one.  Giving good names to things is hard,
so good luck.


Segher
