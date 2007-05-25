Return-Path: <benh@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <adf40b0a9d45728359da78fa45efab8a@kernel.crashing.org>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
	<1180047084.32247.1070.camel@localhost.localdomain>
	<2994f78d2591e45517247003d613bb98@kernel.crashing.org>
	<1180051272.32247.1087.camel@localhost.localdomain>
	<adf40b0a9d45728359da78fa45efab8a@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 25 May 2007 11:53:50 +1000
Message-Id: <1180058031.32247.1091.camel@localhost.localdomain>
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

On Fri, 2007-05-25 at 02:57 +0200, Segher Boessenkool wrote:
> 
> However in this case you could put a property in the
> PHY node, similar things have been done before.  It's
> ugly and doesn't solve any problem (it is just as much
> work to parse the board model as to find this magic
> property), and you *still* should pass in the flag
> from the platform layer, and not have the phylib try
> to handle it by itself.

I disagree, it's not ugly and nicely solves the problem.

For example, imagine you have 2 PHYs on a board and only one needs the
workaround ? Really, the PHY node is the best place for it.

> The ethernet driver is a powerpc-specific driver, that's
> one thing.  Also, the workaround should be initiated by
> the platform code, so has to go through the ethernet driver
> (since it instantiates the phylib driver).

Still... it can be done via generic calls in powerpc ethernet drivers
that set flags in phylib based on things in the device-tree.

> For many similar workarounds, the ethernet driver _does_ have
> to cooperate in the workaround.  For some other such workarounds,
> the soc code has to be involved.  Etc. etc.

> You can do a quick "fix" now by doing this magic property
> thing, and it sure is a *quick* fix; but later on you'll
> have to do some other workarounds the proper way.  And
> you'll be stuck with the property forever.  Not such a
> big deal, sure; hey, I already _did_ say I'm okay with it,
> right?  It's just the "wrong" thing to do ;-)

I have no bloody idea what you consider "the proper way"

I think it's the right thing to do.

Ben.
