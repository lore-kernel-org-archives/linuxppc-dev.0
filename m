To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [OT] 7450
References: <XFMail.010309095914.pochini@shiny.it>
	<3AA92A2C.1BC447B4@mvista.com>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 10 Mar 2001 16:15:00 +0100
In-Reply-To: Dan Malek's message of Fri, 09 Mar 2001 14:08:28 -0500
Message-ID: <8x4rx1bqq3.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek <dan@mvista.com> writes:

>
> Giuliano Pochini wrote:
> >
> > I read many msg about 7450 performance problems.
>
> From who?  People that are actually running hardware or
> speculating from rumors based on documentation that doesn't exist?
>
There are some Mac benchmarks flying around, which don't make the 7450
look all too good.

Some of the benchmarks are obviously bogus: some memory bandwidth measurements
are consistently off by exactly a factor of two. Other benchmarks have later
been shown to be heavily dependant on gfx drivers.

But at least one issue remains, and that is surprisingly low FP performance.
This was measured with one ray tracing application and with an MP3 coder.
I currently believe that thus far, no PPC compiler has made much effort
to schedule FP operations. With just three cycles of latency for a
multiply-add, you can get away with rather sloppy code (in fact, I know
of no shorter FPU pipeline in any other CPUs that reach comparable clock
speeds).

But with five cycles of FP latency, scheduling becomes really important.

Branch efficiency has also somewhat decreased compared to the 7400. The
most notable slowdown is that taken branches are no longer 'free', because
the L1 instruction cache now has a latency of 3 instead of two cycles,
and the branch target instruction cache can only supply enough instructions
for one clock cycle.

I was quite surprised by this, because usually branch efficiency becomes
more important the more instructions can be issued per cycle. There _are_
quite a few things a compiler can do to lessen the impact of slower
branches, but I'm not yet sure if this will fully balance the disadvantages.
Furthermore, such kind of 'speculative code motion' is very specific to
CPU microarchitecture; i.e. code optimized this way for a 7450 might not
run optimally on a 7400.

[...]
> > .... Will GCC have optiminazions
> > (workarounds?) for the 7450's longer pipeline ?
>
> People are working on it.
>
These aren't really "workarounds". Nowadays CPU architecture and compiler
capabilities have to be regarded together. It may well be the case that
the chip designers made a sound decision to move certain complexities to
the software side rather than to the hardware side.

Any such compiler improvements will also be of use for older PPCs. But
Amdahl's Law strikes again: as G3 and ('old') G4 don't spend much of
their time processing branches, further improvements won't have a big
impact on overall performance. That's why putting such optimizations into
the compiler would have been mostly wasted effort - up to now.

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
