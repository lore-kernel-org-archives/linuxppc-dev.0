Message-ID: <3C4EEFAA.1108DF1B@midrivers.com>
Date: Wed, 23 Jan 2002 10:15:22 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb / gdbserver part 2
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've made some progress but have hit a strange snag and would
appreciate any context / suggestions you might have.

I'm able to run gdbserver on the target,
connect to it w/ target remote ...
list a small test program being debugged,
set multiple breakpoints,
and (c)ontinue -- the first breakpoint is hit.

but when I step or next or continue, subsequent breakpoints aren't
hit.

I've set debug remote 1 to see the packets being sent to gdbserver
and find that trap instructions are being written to both breakpoint
locations ('M' packets).

when that first breakpoint is hit then both locations are rewritten
w/ their original contents, not just the first breakpoint (as I would
expect)

when I continue, expecting to hit the next breakpoint, the 2'nd trap
instruction isn't there and the program executes to completion.
< nothing re-writes TRAP to the 2'nd breakpoint location when I
  (c)ontinue>

if I manually rewrite a trap to the second break location I get:

Child terminated with signal = 4

Child terminated with signal = 0x4
GDBserver exiting
/tmp #

-- as though the kernel is left in the wrong state and not handling
the trap as a debug exception.

As I said, I am not wise in the ways of gdb so all high-level
explanations appreciated.  I'm using a snapshot of the development
kernel (2.4.14 ...) which is a bit old but this is the first I've
tried debugging applications.  debugging the kernel w/ the abatron
works fine.

I'm running on a ppc405pm and have left trap.c alone.  I think.

thanks,

Mark

--
Mark Pilon

Minolta-QMS
P.O. Box 37
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
