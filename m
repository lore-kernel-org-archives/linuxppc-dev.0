Date: Sat, 4 Jan 2003 02:01:11 +0100 (MET)
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC 7455 bogomips calculation
In-Reply-To: <20030103162647.A25677@phx.mcd.mot.com>
Message-ID: <Pine.GSO.4.44.0301040145340.4223-100000@s50.informatik.uni-bremen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 3 Jan 2003, Rob Baxter wrote:

[...]
> I'm seeing a bogomips calculation that is equivalent to the processor
> core frequency.  With systems based on pre 745x PPCs, normally one
> would see a bogomips calculation of twice the processor core frequency.
>
Yep. Technically one decrement and one branch are performed per loop
iteration, albeit merged in a single PPC instruction.

> I understand that it's just a calculation and not a benchmark and/or
> performance measurement.  I'm trying to understand why it's half of
> what we have been seeing.
>
> The delay loop that is utilized is this:
>
>         .align  5
> _GLOBAL(__delay)
>         cmpwi   0,r3,0
>         mtctr   r3
>         beqlr
> 1:      bdnz    1b
>         blr
>
> After some review of the PPC 7455 user's manual, it looks like the
> branch prediction logic has changed a bit from earlier versions
> (e.g., PPC 750, PPC 7400, PPC 7410).  This may account for the difference
> in the bogomips calculation.
>
It's not the branch prediction itself (this specific branch in question
will be predicted perfectly, because the contents of the Count Register
are always known to the Branch Processing Unit.)

What you are seeing is the "branch taken bubble": on the 7455, taken
branches need an extra clock cycle until the target instruction arrives
from the Branch Target Instruction Cache. This means one iteration every
two clock cycles.

The other PPCs you mention can access the Branch Target Instruction Cache
with single-cycle-latency and therefor achieve one iteration per clock
cycle. It's one of the trade-offs in the 7455 that allows it to reach
higher clock speeds.

(In more realistic code, the 7455 can often cover such Branch Taken
Bubbles when later pipeline stages stall for other reasons. This gives the
Branch Processing Unit more time to handle branches further ahead in the
instruction stream. The above loop body is just too tiny and so the
Branch Taken Bubble is exposed.)

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
