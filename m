Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61CB0DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 09:18:48 +1000 (EST)
In-Reply-To: <20070417152712.51c7348f.kim.phillips@freescale.com>
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
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f170b2c44ae8a76dd4d35ceb94a624b0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Date: Wed, 18 Apr 2007 01:18:24 +0200
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

>> "compatible" means "what kind of device is this", for the
>> purposes of a client program (i.e., Linux) matching a
>> driver to it (i.e., it should say what kind of PHY it
>> is, and phylib should use that info -- in most cases,
>> it won't need more than the least specific entry in
>> "compatible", i.e. "rgmii" or whatever.
>>
>
> sorry, I disagree; for me, a compatible entry in the PHY node would 
> look
> something like "marvell"

which would be completely wrong

> or "m88e11x1".

It should be something like "m88e11x1\0m88e1xxx\0rgmii" instead.
A "compatible" property can contain many values, ordered from
most exact to least exact.

> "rgmii" might indeed be
> something that PHY supports, but it tells the driver nothing about how
> to enable it (whereas "m88e11x1" would).  The rgmii designation in
> question in this thread is not a property of the PHY, but of the board.

It certainly is a property of the PHY as well.

>> So those UCCs should have a different "compatible" entry.
>> It's not rocket science.
>
> It's referring to the name of the driver,

No, not at all.  No device tree entry name/value has any
direct correspondence with Linux device driver names
(in principle; things can "accidentally" have the same
name, of course).

>> max-speed of connection = min(max-speed of enet, max-speed
>> of PHY) -- and both of those are implied by their respective
>> "compatible" properties.
>>
>
> Again, max-speed is exclusively for configuring the UCC itself,
> regardless of the connection speed.

If that is really true, and the value of that property
has nothing to do with the MAC<->PHY data channel, it should
have a different (not that generic) name.


Segher
