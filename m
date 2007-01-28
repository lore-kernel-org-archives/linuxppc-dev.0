Return-Path: <dgibson@ozlabs.org>
Date: Mon, 29 Jan 2007 10:56:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add restart function for mpc52xx
Message-ID: <20070128235629.GB14060@localhost.localdomain>
References: <20070111122855.GF11226@localhost.localdomain>
	<37B2A6BB-4F36-4765-A1C2-A4F8D30D4503@kernel.crashing.org>
	<20070111152137.GG11226@localhost.localdomain>
	<17831.627.162751.166002@cargo.ozlabs.ibm.com>
	<20070112084612.GJ11226@localhost.localdomain>
	<45A74E2F.2000901@246tNt.com>
	<20070112104211.GQ11226@localhost.localdomain>
	<64469e5c846c386f30ae618752697ed6@kernel.crashing.org>
	<20070128180900.GL28808@pengutronix.de>
	<1170020910.26655.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170020910.26655.45.camel@localhost.localdomain>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 29, 2007 at 08:48:30AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Look how rmk has solved it for ARM - Sascha has already described it.
> > The code that gets the information "this is an xyz board" knows
> > _everything_, starting from the CPU type, up to which peripherals are
> > there. So it simply can spawn the right platform devices, apply bugfixes
> > to everything a board vendor has never thought of and is even unwilling
> > to change in the future, because he simply doesn't care.
> > 
> > It's not that ARM is different than today's SoC PowerPC processors. It's
> > just that the arm-linux people solved the problems you are describing
> > here years ago.
> 
> Can we setup a filter on this mailing list rejecting anybody comparing
> ARM to PowerPC -again- ? I'm tired of those useless rants.
> 
> Of course, the device-tree isn't there to solve world hunger and we
> don't require people to constantly change their firmwares. Yes, a few
> people on this list are probably attempting to "abuse" it and do some
> kind of magic uber-board support that does everything and more and I
> don't agree with that approach.
> 
> However it's actually quite nice and useful to have a well defined
> firmware binding for common devices and things like interrupt routing. 
> 
> You might notice that the minimum device-tree as defined by the spec is
> actually fairly small... only a couple of nodes & properties. One of
> these is ... a board name. Which in a way is equivalent to your ARM
> board number (except that we prefer ASCII strings to magic numbers here
> is ppc land). From that is generally derived the board support data
> structure.
> 
> The board code is then in total control, just like ARM or whoever else
> you seem to like much better. Then, for various "services", like PCI,
> interrupt routing, etc... we provide a way to easily define the whole
> thing via the device-tree and the code "just works". Cool no ? Well, of
> course, you -STILL- have the possibility of not using that for most
> things, and to fix it up when it's wrong. You don't =have= to update the
> firmware (heh, like if I had any chance to get Apple to fix their
> firmwares when they have bugs).
> 
> So we are providing something that is a superset of the board number you
> seem to like that much, adding more flexibility...

And in any case the "magic board number" model can be supported within
the flat device tree model: there's no reason you can't have a
platform boot wrapper, built with the kernel, that reads the magic
board id and picks the appropriate flat device tree from its library
accordingly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
