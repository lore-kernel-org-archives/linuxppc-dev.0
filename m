Date: Tue, 18 Dec 2001 09:27:10 -0500
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Cc: marc.paquin@motorola.com, peter.barada@motorola.com
Subject: Re: Good GDB Version?
Message-ID: <20011218092710.A4505@borg.org>
References: <20011214135312.B12904@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011214135312.B12904@borg.org>; from kentborg@borg.org on Fri, Dec 14, 2001 at 01:53:12PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 14, 2001 at 01:53:12PM -0500, I wrote:
> We are having problems with gdb.

And, though we have not gotten to the bottom of it, we seem to have a
hardware problem.  But a bizarre one.

We download our code, watch the kernel boot, get an sh prompt.  Fire
up ethernet, do an NFS mount of a directory on the development
machine.  Launch gdbserver on a trivial helloworld program, attach
from gdb on the development machine (using ethernet).

All that works.  It would seem to suggest the hardware is working,
right?  Well, that's what we thought.

Tell gdb to continue.  Immediately get a SIGTRAP.  And further
attempts to use gdb act strange, such as after hitting a breakpoint
not being able to continue from there.

Re-downloading the boot ROM does not fix it.

Swap in a different logic card, do all the above, and everything is
the same except that initial SIGTRAP doesn't happen and breakpoints
can be continued from and everything seems completely happy.  That
board works.

Swap in the physical boot ROM from the good board to the bad board and
the problem stays with the bad board.  Both boards have the same rev
of the 405GP.

How could we have crafted a custom board that can recognize that gdb
is running an only malfunction then?  I didn't know hardware could be
so clever.

My only guess is something hanging around the JTAG (or is it BDM?)
debug port might be funny--for the debug port has privileged access to
some of the same internal hardware that gdb uses.  Maybe a hardware
fault there could cause spurious SIGTRAPs--or maybe something is
fritzed inside the 405's debug hardware.

Strange.

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
