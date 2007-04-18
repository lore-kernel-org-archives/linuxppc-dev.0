Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36CA7DDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 11:13:59 +1000 (EST)
Date: Tue, 17 Apr 2007 20:13:50 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070417201350.12727df7.kim.phillips@freescale.com>
In-Reply-To: <f170b2c44ae8a76dd4d35ceb94a624b0@kernel.crashing.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Apr 2007 01:18:24 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >> "compatible" means "what kind of device is this", for the
> >> purposes of a client program (i.e., Linux) matching a
> >> driver to it (i.e., it should say what kind of PHY it
> >> is, and phylib should use that info -- in most cases,
> >> it won't need more than the least specific entry in
> >> "compatible", i.e. "rgmii" or whatever.
> >>
> >
> > sorry, I disagree; for me, a compatible entry in the PHY node would 
> > look
> > something like "marvell"
> 
> which would be completely wrong
> 
that depends on what degree the manufacturer's PHYs are compatible.

> > or "m88e11x1".
> 
> It should be something like "m88e11x1\0m88e1xxx\0rgmii" instead.

m88e11x1 implies rgmii, including all the other interfaces the PHY
supports (gmii, mii, tbi, etc.).

..but I'm not interested in specifying what interfaces the PHY supports.

> A "compatible" property can contain many values, ordered from
> most exact to least exact.
> 
> > "rgmii" might indeed be
> > something that PHY supports, but it tells the driver nothing about how
> > to enable it (whereas "m88e11x1" would).  The rgmii designation in
> > question in this thread is not a property of the PHY, but of the board.
> 
> It certainly is a property of the PHY as well.
> 
sure.

> >> So those UCCs should have a different "compatible" entry.
> >> It's not rocket science.
> >
> > It's referring to the name of the driver,
> 
> No, not at all.  No device tree entry name/value has any
> direct correspondence with Linux device driver names
> (in principle; things can "accidentally" have the same
> name, of course).

well that may be the case here then.

> >> max-speed of connection = min(max-speed of enet, max-speed
> >> of PHY) -- and both of those are implied by their respective
> >> "compatible" properties.
> >>
> >
> > Again, max-speed is exclusively for configuring the UCC itself,
> > regardless of the connection speed.
> 
> If that is really true, and the value of that property
> has nothing to do with the MAC<->PHY data channel, it should
> have a different (not that generic) name.
> 

can you elaborate on why, including an example of what you'd think would
be a better one?

Kim
