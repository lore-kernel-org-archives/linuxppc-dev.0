Message-ID: <388C220F.F3669689@Ferrari.DE>
Date: Mon, 24 Jan 2000 10:57:35 +0100
From: Rolf Fiedler <Rolf.Fiedler@Ferrari.DE>
Reply-To: Rolf.Fiedler@Ferrari.DE
MIME-Version: 1.0
To: Jesper Skov <jskov@cygnus.co.uk>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging a PPC405GP target
References: <388C1704.5F4E270C@Ferrari.DE> <otemb7u83n.fsf@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jesper Skov wrote:
>
> >>>>> "Rolf" == Rolf Fiedler <Rolf.Fiedler@Ferrari.DE> writes:
>
> Rolf> Hi there,
>
> Rolf> currently we are looking for a solution to debug gcc generated
> Rolf> code on the PPC405GP target. All debuggers I have found so far
> Rolf> are hosted on Win9x/NT. This is sub-optimal, since our
> Rolf> tool-chain is hosted on linux.
>
> Rolf> I know that I can use gdb with a gdb-server running on the
> Rolf> target, however I prefer access to the JTAG debug port of the
> Rolf> PPC405GP.  The Macraigor Wiggler devices support JTAG debugging
>
> I don't think this would work (or at least not easily). When you
> access the target through a wiggler it's at a very low level (on the
> CPU, basically - you don't communicate with software in the
> target).
You are right here, very low level... I need so send a bitstream
containing
commands and register values etc. It has been done for a number of gdb
targets (CPU32, Coldfire, MPC8xx).

There a different types of gdb targets - remote targets that communicate
the gdb remote protocol with a gdbserver AND "native" remote targets
that have the ability to control the target (via hardware) directly.

I have done a gdb target for Motorolas coldfire processors using BDM
on the parallel port. gdb talks with a linux kernel driver that toggles
the bits in the parallel-port dongle that start/stop/control the CPU.

> For debugging an application you need to communicate with gdbserver -
> ethernet is the optimal solution, if your board has
> ethernet. Otherwise you have to use serial.
this is plain wrong. I do not have to use gdbserver, gdbserver is just
one possiblity. How can I use the hardware breakpoints in the
debug-hardware
on the target or have breakpoints in ROM when I use a low-tech debug
approach like gdbserver?

You are right about ethernet being optimal, but only in one domain. If
you have the hardware up and running an are a software type of guy that
has to develop firmware, then the improved download speeds of the
ethernet/
gdbserver solution make you forget about the reduced debugging
capabilities.

> You may be able to make the wiggler work as a regular serial
> connection, but I don't see what you gain by that over using a
> standard ethernet/serial connection (except if the only interface on
> the board is the wiggler one).
It would be not very smart to reduce the wiggler to a regular serial
connection, since I have more features then I can address with the
gdb remote protocol. The advantages are:
- no software on the target (bootstrapping)
- use of 4 hw address and 2 hw data breakpoints (try to use a watchpoint
with gdbserver and you'll learn what performance really means :-)

--
+-----------------+-------------------------------------------------+
|    _____        |  Rolf Fiedler    (Electronic Design Engineer)   |
|   / ___/        |  Ferrari electronic AG                          |
|  / _/           |  phone: +49 3328 4559 0   fax: +49 3328 4559 60 |
| /_/e/r/r/a/r/i/ |  <http://www.Ferrari.DE>                        |
|  electronic AG  |  <mailto:Rolf.Fiedler@Ferrari.DE>               |
+-----------------+-------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
