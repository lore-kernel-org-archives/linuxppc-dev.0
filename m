Message-ID: <3BEB5297.C7D13987@mvista.com>
Date: Thu, 08 Nov 2001 20:50:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Marvell/Galileo EV-64260-BP/GT-64260
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just pushed out code for the EV-64260-BP eval board from
Marvell/Galileo.
It includes support for the GT-64260(A) bridge but I haven't pushed out
the MPSC or Enet drivers yet.  I'll try to get the enet driver out
tomorrow.

The work has been done by people from Marvell, Mission Critical Linus,
Xyterra, and MontaVista.

It still needs work.

arch/ppc/kernel/gt64260_common.c has the bridge related code which is in
pretty good shape
arch/ppc/kernel/gt64260_pic.c has the interrupt code which needs work
and it too ev64260-specific

arch/ppc/platforms/ev664260* have the EV-64260 specific code.

This code comes up fine on a GT-64260 but has problems with errata with
the intr ctlr and PCI interrupts.  The GT-64260A comes up fine too, if
you use the integrated enet ctlr (which, of course I didn't push the
driver for), but there is still something wrong with PCI devices
(probably a PCI abitration problem).

Feel free to check it out, constructively comment, and improve it.

BTW, I punted on the issue of sharing with MIPS (64240(A)).  I justed
wanted to get what I have out there for people to start using/improving.

That's all I can think of right now.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
