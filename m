Subject: Re: porting oprofile to ppc
From: Albert Cahalan <albert@users.sourceforge.net>
To: Segher Boessenkool <segher@koffie.nl>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
	oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3E62B4C4.6030306@koffie.nl>
References: <1046474835.1090.303.camel@cube>  <3E62B4C4.6030306@koffie.nl>
Content-Type: text/plain
Date: 03 Mar 2003 03:14:56 -0500
Message-Id: <1046679297.1090.405.camel@cube>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-03-02 at 20:49, Segher Boessenkool wrote:
> Albert Cahalan wrote:

>> I'm considering a port to the MPC7400 ("G4") PowerPC.
>> This is out of desperation, since there isn't anything
>> beyond gprof available for Linux/ppc users.
>
> Great to hear someone's willing to work on this!

Sort of. "feeling dragged into" is more like it.
Porting oprofile looks easier than porting valgrind
and kcachegrind, and nobody else seems to care
about PowerPC.

> I currently use the following hack to use the pmc's:
> I have a trivial kernel module that accepts as parameters
> the events to count on each pmc (like, insmod pmc.o 1 2 3 4),
> sets the PMCn and MMCRn regs, and fails to load.  This sets
> the counters running, and then I instrument the program
> to be profiled to read the PMC's at interesting program
> locations.  I wrote this years ago and never got around
> to finish any better tools.

Oooh... you shouldn't have said that. I might be
mostly satisfied. Right now I'm using a nasty hack
involving "gcc -finstrument-functions" and "nm".

I guess I most want instruction pointer (NIP) sampling
at irregular intervals, or at least not tied to the
clock tick. I could see using some random pre-initialized
profiling counter ("42 foo from now") to get this. I could
hook into the regular external interrupt and rely on USB
traffic to do my sampling. >:-)

> You are talking about the time base?  It runs at 1/4th
> the cpu clock.  It can be disabled by means of a hardware
> pin (GPIO9 on most Mac's); default is running and that's
> just what you want, I think ;)

Yes. I wonder where I got the 1/16 idea.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
