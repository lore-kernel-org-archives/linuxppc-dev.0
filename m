Date: Fri, 15 Nov 2002 18:39:46 -0800
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v548)
Cc: <linuxppc-dev@lists.linuxppc.org>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
From: Tim Seufert <tas@mindspring.com>
In-Reply-To: <000701c28cfa$e14e1a60$0200a8c0@telia.com>
Message-Id: <AB9FFDC2-F90C-11D6-A55F-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, November 15, 2002, at 03:01  PM, Joakim Tjernlund wrote:

> This comment in csum_partial:
> /* the bdnz has zero overhead, so it should */
> /* be unnecessary to unroll this loop */
>
> got me wondering(code included last). A instruction can not have zero
> cost/overhead.
> This instruction must be eating cycles. I think this function needs
> unrolling, but  I am pretty
> useless on assembler so I need help.
>
> Can any PPC/assembler guy comment on this and, if needed, do the
> unrolling? I think  6 or 8 as unroll step will be enough.

The comment is probably correct.  The reason the instruction has
(effectively) zero overhead is that most PowerPCs have a feature which
"folds" predicted-taken branches out of the instruction stream before
they are dispatched.  This effectively makes the branch cost 0 cycles,
as it does not occupy integer execution resources as it would on other
possible microarchitectures.

With current hardware trends loop unrolling can often be an
anti-optimization.  Even without loop overhead reduction features like
branch folding, it may be a net penalty just because you are chewing up
more I-cache and causing more memory traffic to fill it.  Consider the
costs:

Reading a cache line (8 instructions, 4-beat burst assuming 4-1-1-1
cycle timing, which is optimistic) from 133 MHz SDRAM:  52.5 ns

1 processor core cycle at 1 GHz: 1 ns

So every time you do something that causes a cache line miss, you could
have executed 50+ instructions instead.  This only gets worse when you
consider more realistic memory timing (I don't know offhand whether you
can really get 4-1-1-1 burst timing with PC133 under any circumstances,
and besides it's going to be much worse than 4 cycles for the initial
beat if you don't get a page hit).

That's not to say that unrolling is useless these days, just that the
disparity between memory and processor core speed means that you have
to be careful in deciding when to apply it and to what extent.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
