Date: Wed, 9 Apr 2003 08:02:01 -0700
From: Matt Porter <porter@cox.net>
To: luca gambazzi <luca.gambazzi@epfl.ch>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Force Computers CPCI-3750 eth drivers
Message-ID: <20030409080200.A24217@home.com>
References: <1049880169.3724.16.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1049880169.3724.16.camel@shampoo.epfl.ch>; from luca.gambazzi@epfl.ch on Wed, Apr 09, 2003 at 11:22:49AM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 09, 2003 at 11:22:49AM +0200, luca gambazzi wrote:
> I'm booting with the pcore kernel.
>
> the pcore_find_bridges function in pcore_pci.c recognize my card as a
> 6750, but the 3750 uses a 21150 bridge and not a 21154.

That makes sense.  When I did the port I had a 6750 and 680.  They
are very similar but Force is too stupid to provide a method to
uniquely identify a board at runtime.  So, you see the kludge where
anything booting a pcore kernel that has an MPC106 is a 6750 and
if it has a MPC107 then it must be a 680.

> Do you know where can i find documentation to solve this problem?
> and where I have to modify?

Talk to Force.  You need the 3750 manual.  I suspect that it has
different interrupt routing than the 6750.  Right now, you are
picking up the pcore_6750_map_irq table which has irq 10 for the
on-board tulip.  More than likely it's routed to a different input
on the 3750.  You would create a pcore_3750_map_irq, and provide
some way to uniquely identify that you are on a 3750 and have the
kernel use that map_irq function.

> here you can find the bios log, maybe you can find an answer.
> http://lsa1pc32.epfl.ch/~gamba/robox/

Definitely looks like pci interrupt routing is incorrect.  tulip
driver isn't getting interrupts.  One warning, once you get
3750 docs...don't trust them, they are often incorrect. :)

When you get this working, please post a patch so it can be
incorporated.  Good luck.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
