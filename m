Message-ID: <3A2EBFBF.9628F0CC@mvista.com>
Date: Wed, 06 Dec 2000 17:37:51 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: bgat@open-widgets.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX860 serial on J19?
References: <20001205163100.A7845@sr1.open-widgets.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bgat@open-widgets.com wrote:

> I have a stock Motorola MBX860 board, and I'm trying to use the serial
> ports connected to the Utility #2 connector, J19.  These ports are
> connected to the SMSC 37c672.
>
> In short, nothing is working.

That's because there isn't any software for them.  The short answer
is the MPC8xx parts have an internal interrupt controller and the CPM
which provides serial ports.  The rest of the kernel assumes PC-style
interrupt controllers and serial ports are the only things that exist.
Making these co-exist required changes in the generic parts of the
kernel that were never acceptable, so I simply ignore that hardware
on these boards.  There are probably some hacks floating around that
will enable more or less of these features (like the IDE, flopply,
parallel port, and the serial ports), but nothing that anyone
has ever sent me as a contribution that was acceptable.

> I'm in the process of trying out the MontaVista HHL 2.2.14 kernel as I
> write this.

Same thing, only better.

> I think I must be missing something obvious, because the SMSC chip is
> used in a lot of PCs and is therefore probably well supported...

Well supported in a PC.  This isn't a PC.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
