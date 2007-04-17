Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 558F3DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 06:27:21 +1000 (EST)
Date: Tue, 17 Apr 2007 15:27:12 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070417152712.51c7348f.kim.phillips@freescale.com>
In-Reply-To: <788e650fbb3f95eaf1bfb6955f9cef17@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<20070416115729.292c10b1.kim.phillips@freescale.com>
	<53810df560c7af272cd1c71c9d5fa1ab@kernel.crashing.org>
	<20070416193110.77b63e4b.kim.phillips@freescale.com>
	<788e650fbb3f95eaf1bfb6955f9cef17@kernel.crashing.org>
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

On Tue, 17 Apr 2007 12:25:51 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >> You can put "rgmii" or whatever in the "compatible" property
> >> as well.
> >>
> > I don't understand how intermixing PHY device compatibility with the
> > UCC connection to the PHY would be a good thing.
> 
> "compatible" means "what kind of device is this", for the
> purposes of a client program (i.e., Linux) matching a
> driver to it (i.e., it should say what kind of PHY it
> is, and phylib should use that info -- in most cases,
> it won't need more than the least specific entry in
> "compatible", i.e. "rgmii" or whatever.
> 

sorry, I disagree; for me, a compatible entry in the PHY node would look
something like "marvell" or "m88e11x1".  "rgmii" might indeed be
something that PHY supports, but it tells the driver nothing about how
to enable it (whereas "m88e11x1" would).  The rgmii designation in
question in this thread is not a property of the PHY, but of the board.

> >>> If I were to put the properties in the PHY node, I wouldn't be able 
> >>> to
> >>> describe a 1000Mbit/s capable UCC connected to a 100Mbit/s capable 
> >>> PHY,
> >>> or vice versa.
> >>
> >> Of course you can.  The "compatible" in the enet node
> >> implies it can do 1000Mbps; the "compatible" in the
> >> PHY node implies it does 100Mbps.
> >
> > compatible in the UCC node is currently set to "ucc_geth", which does
> > not necessarily imply that that UCC can do 1000Mbit/s.  Some UCCs can
> > only do 100Mbit/s.
> 
> So those UCCs should have a different "compatible" entry.
> It's not rocket science.
> 

It's referring to the name of the driver, as is compatible "gianfar".
other values could be "fsl_atm" or "ucc_uart", or whatever other
communications protocol a UCC can manage (to which, btw, max-speed would
be easily extensible).

> > We currently do not have hardware that connects UCC with max-speed x
> > with a PHY with max. speed capability of y, where x != y, so there is
> > currently no need to specify the speed of the PHY.  Not that that would
> > be needed; the phylib would call ucc_geth's adjust_link with the new
> > speed.  Note that the max-speed property is used to set registers in 
> > the
> > UCC only.
> 
> max-speed of connection = min(max-speed of enet, max-speed
> of PHY) -- and both of those are implied by their respective
> "compatible" properties.
> 

Again, max-speed is exclusively for configuring the UCC itself,
regardless of the connection speed.

Kim
