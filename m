Message-ID: <3B5F8CD5.7D80B995@mvista.com>
Date: Wed, 25 Jul 2001 23:21:57 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Jeff Studer <jstuder@aquilagroup.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI bridge support with MontaVista
References: <Pine.LNX.4.10.10107251625340.31481-100000@jeffs.aquilagroup.com> <3B5F6857.19E14CE2@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:

> Just off the top of my head there are several bridges that are supported, the
> Motorola SPS MPC105, MPC106, MPC107 (and MPC824x), the Motorola MCG Raven,
> Hawk, Harrier, IBM CPC700 and CPC710, several proprietary bridges, and others
> that are in the works.

None of these work on the MPC8xx bus, so they aren't options.

The first thing I have to ask is do you _really_ need a PCI bridge.
If yes, because you have PCI slots and expect any PCI card to work,
I would then strongly suggest looking at something with a real PCI
bridge solution, like the 824x with an integrated, standard PCI
bridge.

If you are building a "closed" embedded solution, the most successful
8xx designs don't use a PCI bridge.  Due to the flexibility of the 8xx
bus, it is much more efficient (lower cost, less software, lower power,
higher performance), to simply configure the 8xx bus or add some trivial
external logic.  This has been done with sound chips, graphics,
additional
uarts, IDE, USB, and so on.  You don't need PCI to attach these devices.

If you really insist on using a PCI bridge with the 8xx, keep in mind
the bridge is only a (small) part of the entire system solution.  The
PCI bridge simply provides the bus translation between the 8xx and the
PCI.
You have to solve the problem of interrupts as well.  The best way is
probably to just connect the PCI INTAs to the MPC8xx external IRQs, then
you need to somehow adapt the software to work.  This has been the
source
of much hacking in the past, without any general solution.  Ensure the
bridge and your system configuration can actually perform PCI bus
mastering
of the 8xx bus, if you need this.  The QSpanII claims to finally be able
to do this, so check it out.  The PCI bridges also claim a large part of
the physical address (usually the upper 2G) and do their own decoding.
I've seen one design that tried to fake a smaller 8xx space with some
external logic, but this never worked due to bus timing problems. I
guess the moral of the story is don't be cute with the design :-).

So, make sure you _really_ need that PCI bridge.  Due to the work of
a few people, the PCI subsystem is very modular and easy to update.
All you may need to add are a few configuration space access functions
and an initialization function (which is always unique to the board
design).  Choose a bridge that has the features you want, connect it
in a very straightforward design, and the software will fall into place
rather easily (maybe :-). I still prefer the no PCI design with
MPC8xx....

Good Luck.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
