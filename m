Date: Wed, 19 Dec 2001 19:44:26 -0700
From: Matt Porter <mporter@mvista.com>
To: Bryan Rittmeyer <bryan@ixiacom.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc750 eval boards?
Message-ID: <20011219194426.A6553@cx258813-a.chnd1.az.home.com>
References: <3C2173E3.6070001@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C2173E3.6070001@ixiacom.com>; from bryan@ixiacom.com on Wed, Dec 19, 2001 at 09:15:15PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 19, 2001 at 09:15:15PM -0800, Bryan Rittmeyer wrote:
>
> Hi,
>
> I'm working on some custom PPC750 hardware and would like a reference
> platform to aid in debugging/initial bringup... does anybody have
> comments on the following IBM PPC750 evbs:
>
> * IBM Spruce
> * SBS K2
> * Force CPCI6750
> * [anything else]

Ooh ooh.  I know I know.  Of the set (and including Sandpoint into
the mix), I would use the Spruce for a 750 custom design reference.

I would always drop cPCI boards unless you really are trying to
be in that form factor.  ATX boards with PCI slots are preferable
because when you want to simulate your end custom board's I/O, you
can run out to Fry's and purchase whatever PCI chip you want (within
reason) on some commodity-priced PCI card.  Hardware guy's building
a CMD646 IDE controller and i82559ER onto your custom board?  Run
out and grab an SIIG PCI IDE card (CMD649) and Intel EtherExpress
Pro/100 (i82599ER) card for <100USD and build your apps on the
simulated system without all your hardware designer's bugs.  The
selection is limited on chipsets you find integrated on PMCs,
purchasing PMCs is more of a hassle, and the price is higher.

The only reason to choose Sandpoint (IMHO) over a Spruce platform
is if it is the only platform that has your target processor
available (745/755, 74xx, 824x).  It only has two working slots
whereas Spruce has four.  There are also some yet-to-be determined
Sandpoint-specific problems with running certain PCI cards (probably
power sourcing problems).  There is one other reason to choose
Sandpoint/Spruce.  If you are using MPC10x for a bridge then
Sandpoint will cover that route, if you are using CPC700 then
spruce will cover you...if you aren't using either or don't
care to simulate that portion of the system (you should if
possible) then spruce should be favored.

> Which work well with the Abatron BDI2000?

All but 6750 since it has no JTAG/COP connector...it doesn't
even have unpopulated pads to drop a Berg header onto...boo.

This is my personal opinion based on spending (too) much time
with these platforms.  My employer certainly does not endorse my
personal opinion in these matters.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
