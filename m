Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32FD5DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 10:31:18 +1000 (EST)
Date: Mon, 16 Apr 2007 19:31:10 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070416193110.77b63e4b.kim.phillips@freescale.com>
In-Reply-To: <53810df560c7af272cd1c71c9d5fa1ab@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<95a9680c565aa196a4ef78964ef9dee1@kernel.crashing.org>
	<20070416102533.0f87396f.kim.phillips@freescale.com>
	<C793D7D1-CA26-4DCB-B513-56E927BF6BA9@kernel.crashing.org>
	<ba8618e3bd28389b66262e549387ac8d@kernel.crashing.org>
	<20070416115729.292c10b1.kim.phillips@freescale.com>
	<53810df560c7af272cd1c71c9d5fa1ab@kernel.crashing.org>
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

On Tue, 17 Apr 2007 01:18:56 +0200
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > I don't need to know what type the PHY is, e.g. whether it's m88e11x1
> > compatible or not, the phylib handles that.
> 
> You need to tell the phylib what kind of bus the PHY uses.

sure, and ucc_geth does just that based on the interface-type property,
in addition to correspondingly programming the UCC.

> You can put "rgmii" or whatever in the "compatible" property
> as well.
> 
I don't understand how intermixing PHY device compatibility with the
UCC connection to the PHY would be a good thing.

> > If I were to put the properties in the PHY node, I wouldn't be able to
> > describe a 1000Mbit/s capable UCC connected to a 100Mbit/s capable PHY,
> > or vice versa.
> 
> Of course you can.  The "compatible" in the enet node
> implies it can do 1000Mbps; the "compatible" in the
> PHY node implies it does 100Mbps.

compatible in the UCC node is currently set to "ucc_geth", which does
not necessarily imply that that UCC can do 1000Mbit/s.  Some UCCs can
only do 100Mbit/s.

We currently do not have hardware that connects UCC with max-speed x
with a PHY with max. speed capability of y, where x != y, so there is
currently no need to specify the speed of the PHY.  Not that that would
be needed; the phylib would call ucc_geth's adjust_link with the new
speed.  Note that the max-speed property is used to set registers in the
UCC only.

Kim
