Message-ID: <3E62B4C4.6030306@koffie.nl>
Date: Mon, 03 Mar 2003 02:49:56 +0100
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: oprofile-list@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: porting oprofile to ppc
References: <1046474835.1090.303.camel@cube>
In-Reply-To: <1046474835.1090.303.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Albert Cahalan wrote:
> I'm considering a port to the MPC7400 ("G4") PowerPC.
> This is out of desperation, since there isn't anything
> beyond gprof available for Linux/ppc users.

Great to hear someone's willing to work on this!

I currently use the following hack to use the pmc's:
I have a trivial kernel module that accepts as parameters
the events to count on each pmc (like, insmod pmc.o 1 2 3 4),
sets the PMCn and MMCRn regs, and fails to load.  This sets
the counters running, and then I instrument the program
to be profiled to read the PMC's at interesting program
locations.  I wrote this years ago and never got around
to finish any better tools.

> I could use some advice. Where do I even start?
> Anybody else doing this or interested in helping?

I'll answer any questions you have -- feel free to email
me in private about this.

> On the 7xx and 74xx chips, I get a user-readable 64-bit
> counter that ticks at 1/16 of the memory bus clock. So on

You are talking about the time base?  It runs at 1/4th
the cpu clock.  It can be disabled by means of a hardware
pin (GPIO9 on most Mac's); default is running and that's
just what you want, I think ;)

> my 450 MHz Mac with a 100 MHz bus, it ticks at 6.25 MHz.

25MHz.

> There's also a privileged 32-bit count-down register that
> gives an interrupt.

The decrementer; same frequency as the time base on all
G3 and G4 cpu's.

 > There isn't a CPU core cycle counter,
> unless you have a 7400 (or above?) and are willing to
> devote a performance counter to that purpose.

Actually, all G3 and G4 cpu's have event 1 on all pmc's
as such a counter.

> The 7400 chip additionally gives me a set of performance
> monitoring registers, with read-only access from user code.
> There are four counters, PMC1 to PMC4, and control registers.

750 has four pmc's as well, 7450 has six of-em.

> I can freeze the counters in kernel mode, in user mode,
> and according to a flag that may be used to mark a process.

There's no mark flag on the 750.

> There's a threshold value for some of the performance
> counters, taking on values from 0..63 times 2 or 32.
> (0,2,4,...,124,126,128,160,192,...,1952,1984,2016)
> So for example, I could count loads that stall for more
> than 1952 ticks.
>
> I can enable counters PMC2..PMC4 when PMC1 goes negative.
> I can freeze all the counters (or cause an interrupt)
> when one of PMC2...PMC4 goes negative.

Or both; the most useful mode, imho.

> There are ways for external hardware to mask counting or
> interrupt generation. I'm not about to solder a button
> onto my CPU for this, but I guess it should be supported.

Luckily, GPIO8 is just what you need.  It isn't all that
useful,  though.  [Beware: always check the device tree
for the exact gpio number on your box -- this can vary].

> All four counters can count:
>
> core cycles
> completed instructions, excluding folded branches
> memory cycles divided by 32, 8k, 128k, or 2M

This one should read "time base ticks".

> instructions dispatched (0, 1, or 2 per core cycle)
>
> Then of course each register has a selection of other
> choices. Of interest:
>
> instruction breakpoint matches, with a bit mask
> (could be abused to count system calls or interrupts)
> various cache things, loads, stores, etc.
>
> There must be 60 to 240 choices, depending on how one
> counts duplicates.

Lots and lots more combo's, although not all combinations
are all that useful ;)

Also, all cpu's have different even assignments (and
different MMCRn registers, too).


Good luck and have fun,

Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
