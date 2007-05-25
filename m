Return-Path: <dgibson@ozlabs.org>
Date: Fri, 25 May 2007 12:00:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
Message-ID: <20070525020059.GA13575@localhost.localdomain>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2994f78d2591e45517247003d613bb98@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 25, 2007 at 01:54:35AM +0200, Segher Boessenkool wrote:
> > For powerpc, I have a solution at hand, it's the device-tree :-)
> >
> > Any struct device in the system can have a device node pointer via the
> > dev_sysdata thingy I added recently. So we can have some code for
> > powerpc that properly hooks up the PHY to an (optional) device-node
> > which can then contains properties describing what kind of workarounds
> > need to be applied.
> >
> > For example, we can have a txc-rxc-delay-disable property on Holly.
> 
> This is equivalent to the ethernet driver passing this information
> to phylib via the init arguments.
> 
> You still have the same problems as Andy described where the
> necessary workaround is not something local to phylib, but
> needs cooperation of the ethernet code or the soc code or
> some other platform code.
> 
> Since the specific bug we're talking about here is not a
> problem with the PHY, but a miswiring on the board, I wouldn't
> put a flag for the workaround in the phy node in the device
> tree.  It certainly is an option though.

Uh.. something to bear in mind is that although it is a board
miswiring, it's of a type that it will plausibly occur in other
boards.  IIRC, if a LED is attached to this PHY the workaround is
necessary, or something similar.  So there is value in having a
particular flag for this rather than just looking at the board model.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
