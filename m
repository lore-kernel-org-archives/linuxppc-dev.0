To: ppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ethernet on 8260 
In-Reply-To: Message from Brad Bonkoski <bradb59@home.com>
   of "17 Jul 2001 12:07:19 MST." <20010718005352.VZZY3814.femail19.sdc1.sfba.home.com@cx263713-b.mesa1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Jul 2001 16:26:00 +1000
Message-ID: <6825.995437560@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 17 Jul 2001 12:07:19 -0700, Brad Bonkoski <bradb59@home.com> writes:
>One further question, is it possible for a detection of a loss of the
>actual Ethernet cable at the kernel level?

Depends on your board design - only the PHY knows this info and you
communicate with the PHY via the MII. But the 8260 has no specific
support for the management communication as defined by the MII spec
(MDC/MDIO - very similar to an i2c interface) - you implement this
using I/O port pins, twiddling bits to send clocked serial data to
the PHY.

The first board design dependent thing is which port pins you choose
to connect to the PHY MDC/MDIO pins. The second is which interrupt
input(s) (port C pins?) you connect the PHY interrupt output(s) to.
There will be others - probably dependent on the PHY you choose, or
even the RJ45 connector itself! e.g. on our board, there is a bi-colour
LED on the RJ45 socket which we connect to our FPGA so that with the
appropriate FPGA code loaded we can interpret the PHY state outputs and
display the appropriate colours - rather than dedicate I/O port pins
on the 8260 to this function i.e. input the PHY state, output the LED
state - wastes a lot of pins. Other board designs might use I/O port
pins. LEDs aren't so critical, but you get the idea.

Based on previous postings, I believe Dan Malek will (eventually) be
patching the FCC driver to provide interrupt driven MII/PHY support,
but you will have to hack it for your PHY etc. although most PHYs are
pretty similar so that all you might need to do is recognise your vendor
ID number.

>Are there any pointers to
>docs I could read on this?

Your PHY manual, your board design manual, and section 30.3 of the 8260 UM.
Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
