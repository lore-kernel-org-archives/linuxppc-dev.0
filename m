Date: Fri, 13 Aug 1999 22:18:18 +1000
Message-Id: <199908131218.WAA32706@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: rth@cygnus.com, Jes.Sorensen@cern.ch, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
In-reply-to: 
	<Pine.LNX.4.10.9908121428020.14133-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Thu, 12 Aug 1999 14:31:25 +0200
	(CEST))
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908121428020.14133-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

> I'm seeing different things (results don't tend to vary a lot):
> 
> | [14:27:01]/tmp# ./a.out 0xc2800000
> | 35 29 30 31 28 
> | 261 251 247 248 248 
> | 429 332 358 374 348 
> | 541 532 529 531 529 
> | [14:27:05]/tmp# 
> 
> Hence eieio() is quite expensive on memory.
> 
> This in on an IBM LongTrail (CHRP), with 604e at 200 MHz, 512 KB L2 cache,
> 66 MHz SDRAM bus, and 33 MHz PCI to an ATI RAGE II+.

I tried it on my longtrail, with a 300MHz 604 machV.  I changed the
loop count to 18 since that is the ratio of cpu clock to timebase
clock on this machine.  (You should probably use 12 on your machine.)

I got results much like yours:

23 23 20 20 21  av=21.4
180 175 175 175 175  av=176.0
288 358 275 359 309  av=317.8
375 400 351 423 351  av=380.0

So yes, in this case adding the eieios costs about 22 cycles each when
going to main memory, or 9 cycles each when going to the framebuffer.
I guess that when going to the framebuffer, much of the latency of the
eieio gets hidden.

It would be interesting to try a mix of loads and stores to the
framebuffer, perhaps 4 loads followed by 4 stores to get the effect of
a bitblt routine.  I tried my framebuffer-copy test on my 7600, which
has 200MHz 604e cpus, and I didn't see any difference in overall time
for the test, whether there were eieio's in or not.

This morning I read something in the PPC750 manual which implied that
the G3 doesn't reorder stores, and doesn't reorder non-cacheable
accesses.  That would mean eieio could be a no-op, which could help
explain why it only takes 1 cycle on a G3. :-)

(Not reordering non-cacheable accesses actually makes a lot of sense
to me.)

I think that probably the best thing is to have safe and fast variants
of readl/writel etc.  For the sake of not having to change a whole
heap of drivers (whose maintainers use x86 cpus :-() I would urge that
readl/writel include the eieio, and that we have readl_fast,
writel_fast etc. which don't include the eieio.

I would still be interested to see overall timings for frame-buffer
operations with and without the eieios.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
