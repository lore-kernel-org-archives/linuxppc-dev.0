Return-Path: <benh@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <2994f78d2591e45517247003d613bb98@kernel.crashing.org>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 25 May 2007 10:01:11 +1000
Message-Id: <1180051272.32247.1087.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-25 at 01:54 +0200, Segher Boessenkool wrote:

> This is equivalent to the ethernet driver passing this information
> to phylib via the init arguments.
> 
> You still have the same problems as Andy described where the
> necessary workaround is not something local to phylib, but
> needs cooperation of the ethernet code or the soc code or
> some other platform code.

If it's in the PHY device node, the ethernet driver doesn't need to be
involved more than calling some generic helper that finds the right
node, parses it and generates known flags.

> Since the specific bug we're talking about here is not a
> problem with the PHY, but a miswiring on the board, I wouldn't
> put a flag for the workaround in the phy node in the device
> tree.  It certainly is an option though.

Why ? That's the perfect place to put it in !

> > The problem is that of course the PHY driver will need some powerpc
> > specific code to go fetch that.
> 
> The ethernet driver can handle it, instead.

I don't understand why you want to involve the ethernet driver in
something that doesn't have much to do with it. A pin of the PHY is
miswired causing something to be enabled that shouldn't be. Ok, there is
indeed the fact that the problem is partially related to the TSI
ethernet not supporting when that PHY feature is "enabled" but still...
it's a PHY setting, totally specific to a given PHY revision, I'm not
sure there's much point in having it in the eth driver.

Ben.
