Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE2EEDDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 20:34:37 +1000 (EST)
In-Reply-To: <20070417201350.12727df7.kim.phillips@freescale.com>
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
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <524e7cf7aec7be8289ab2f99df8a0776@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Wed, 18 Apr 2007 12:34:27 +0200
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

>>> sorry, I disagree; for me, a compatible entry in the PHY node would
>>> look
>>> something like "marvell"
>>
>> which would be completely wrong
>>
> that depends on what degree the manufacturer's PHYs are compatible.

No, if all there PHYs are compatible (and you have some
guarantee that all there future PHYs will be as well!)
it should read "marvell-phy" (or better, "MRVL,ethernet-phy"
or something similar).

>>> or "m88e11x1".
>>
>> It should be something like "m88e11x1\0m88e1xxx\0rgmii" instead.
>
> m88e11x1 implies rgmii, including all the other interfaces the PHY
> supports (gmii, mii, tbi, etc.).

If you don't put the less-specific entries there, only clients
(OSes) that know about the exact name can use that PHY.  So if
there is a minor upgrade of you board and it has a m88e11x2
instead, your OS needs an update to work with your new device
tree.  Not an ideal situation.

> ..but I'm not interested in specifying what interfaces the PHY 
> supports.

But you *have* to.  The device tree describes the hardware,
it is not a configuration file for Linux to use as it sees fit.

>>>> max-speed of connection = min(max-speed of enet, max-speed
>>>> of PHY) -- and both of those are implied by their respective
>>>> "compatible" properties.
>>>
>>> Again, max-speed is exclusively for configuring the UCC itself,
>>> regardless of the connection speed.
>>
>> If that is really true, and the value of that property
>> has nothing to do with the MAC<->PHY data channel, it should
>> have a different (not that generic) name.
>
> can you elaborate on why, including an example of what you'd think 
> would
> be a better one?

Very generic names should only be used by very generic bindings.
If a very specific device binding (like yours) uses a property
name like that, there is a high chance it will clash with a more
generic binding it uses (PCI, ethernet, network, ...) -- perhaps
with a *future* version of such a binding.

Also, it isn't a great name /an sich/: "max-speed" -- maximum
speed of what?


Segher
