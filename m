To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Apple Job Posting and Good News for LinuxPPC developers
References: <Pine.HPP.3.96.990326121245.1078X-100000@gra-ux1.iram.es>
From: Holger Bettag <hobold@informatik.uni-bremen.de>
Date: 02 Apr 1999 14:11:16 +0200
In-Reply-To: Gabriel Paubert's message of Fri, 26 Mar 1999 12:31:59 +0100 (MET)
Message-ID: <8x677fp6hn.fsf@s52.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es> writes:

[beefier PowerPCs]
> Not many people have seen a 620 AFAICT :-( and the G4 I've seen announced
> by Motorola is not what I expected: it's a super 750 with Altivec + 604
> FPU (single cycle double precision multiplier) + SMP capabilities. 
> 
> But at least I expected:
> 
> - a 64 bit version (means >32 address pins, perhaps ~40 or so, 64 is
>   obviously overkill right now and I don't ask for it)
> 
I have heard rumours that the "Max" core has provisions to physically address
more than 4GB of memory (via the MMU's segment registers). Processes would
still be limited to a 4GB logical address space, though.

> - more superscalar (not 2+branch, but at least 4 way)
> 
The 604e is four-way superscalar, but it has slightly lower integer performance
per clock cycle than the 750. Apparently you can't extract significantly more
parallelism than 2 instructions per clock from real-world code, so the 604e's
abilities are wasted, while the 750's exceptionally elegant branch handling
leads to measurable benefits over the 604e's more traditional (though very
sophisticated) branch prediction.

> - longer in flight instruction queue
> 
Compared to the 750, "Max" has additional reservation stations and a longer
completion queue. Motorola's first estimates were 10% more integer performance
per clock cycle than the 750, but this probably includes the effect of
the larger L2.

BTW, a larger number of unresolved "in flight" instructions would jeopardize
the processors unique (among superscalar CPUs) ability to directly execute
branches without predicting them, because the outcome of branch conditions
would more often be still "in flight", too.

> - 2 FPU: not sure, but divides seem to kill current PPC, one
>   unit which can do all instructions(including sqrt) + one mult/add only
>   would be great. OTOH, on FFT benchmarks which interest me also (not a
>   single div), PPC are excellent. 
> 
AFAIK, the divide algorithm used in PowerPC FPUs was selected specifically
to re-use as much of the multiplier as possible; i.e. saving transistors
was the foremost goal.

With nowadays silicon structure sizes, it would probably be a very good idea
to have a separate divider. Possibly even one that uses a faster algorithm
(like estimation plus refinement as is done explicitly in AltiVec).

> - 2 LSU to feed all these units: hey Pentium and PPro can do 2 memory
>   accesses por clock since they came out. They need it because they
>   require many load/store to compensate for the small number of registers 
>   but I'd expect it to be beneficial even on PPC with large and fast 
>   backside L2 caches. Power2 has had 2 LSU since the beginning AFAICT.   
>
AFAIK, Pentium and PPro/PII/PIII do not have the equivalent of two full-blown
LSUs. In best case, they can do either two loads or one load plus one store,
but not two store operations. Furthermore, their L1 cache is not really
dual-ported, only dual-banked, so that two accesses can only be carried out
in parallel if they hit different banks.

And finally, if you ever have an algorithm where loads or stores are the
bottleneck, the performance will be limited by main memory bandwidth anyway,
regardless of L1 bandwidth (unless you are register-starved, of course, but
that will almost never happen with 32 GPRs + 32 FPRs (+ 32VRs)).

  Holger


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
