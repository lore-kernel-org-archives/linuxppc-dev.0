Message-ID: <3AC8BA81.3BC77AC4@mvista.com>
Date: Mon, 02 Apr 2001 13:44:33 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Jim Chapman <jim.chapman@bigwig.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MII PHY support?
References: <3AC76542.A4D27697@bigwig.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Chapman wrote:
>
> Is anyone working on adding MII PHY support?

I try.  I have recently received two more boards with completely
different PHYs and MII implementations (through an FPGA), so I don't
know what the hell to do now.  I understand the great flexibility
by not providing a standard MDIO interface (like the 8xx), but it
really makes implementing standard software difficult.

> I've implemented support for my custom 8260 board which has a quad enet
> phy. Now I'm about to add code into fcc_enet.c to handle things like
> link autonegotiation and state changes.

Go for it.  The plan was to take the code from the 8xx FEC driver that
does a similar thing and move that to the 8260 FCC driver.  The challenge
on the 8260 is we don't get interrupts from MDIO transfers, so we can't
really just port it.  Send me small bits and pieces, I'll test it on
boards I have and we can work with anyone else here that is interested.

> I'm not ready to publish anything yet; I already have generic MII
> support (not ppc specific) with hooks to phy device specific drivers and
> architecture dependent h/w interface (i.e. board dependent 8260 MDIO).

Maybe we should just move this into a separate source file instead of
making a big configuration mess of the FCC Ethernet driver.  I'm about
to do that for some 8xx FEC functions as well.

> Over time, new phy device drivers could be added and support for other
> boards too. I envisage new ioctls to control/view the phy, and patching
> ifconfig to use them.

Is it necessary for ifconfig (or anything else) to access the control
registers in the PHY?  I haven't seen that in any of the other drivers
for other PHYs.  Don't forget to look into drivers/net for example
or other ideas :-).

Thanks.  Have fun!


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
