Message-ID: <3BAA6C43.455873D@mvista.com>
Date: Thu, 20 Sep 2001 18:22:59 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Mark Salisbury <mbs@mc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <3BAA0E6F.5050503@mc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark Salisbury wrote:

> assume I have a valid reason for wanting to run ppc's in LE mode

This is where it starts to fall apart.  I didn't know there were
any valid reasons to support LE mode, except to run some software
from a certain company that never materialized.  I was fortunate to
be part of the PowerPC design discussions from the beginning.  The LE
mode was never popular.

A technical reason is the PowerPC never supported a true little
endian mode.  It basically does byte swapping between the cache
and core processing units, and I believe always (or at least usually)
supported a big endian bus.  You can't properly attach the processor
to true little endian busses or devices when this is done, so you don't
gain any hardware design advantage.  As you know, properly byte
swapping depends upon the size of the object, so if you happen
to access something in smaller units than it's natural size you
aren't going to get the results you expect.  For someone that is
comfortable programming in an LE environment (is there anyone? :-),
this will eventually bite you.

Another technical reason is as the processor family moves forward,
less and less little endian support is provided.  In the case of
the 7450, there are instructions that trap to the kernel to be
emulated in LE mode, that are executed in the core in BE mode.

> question 2.  if 1, what is the primary reason for rejection.

It was LE (sorry, couldn't resist :-)?

> question 3.  is there a general issue of endian safety in linux (I would
> think not) or just in the ppc-specific code?

Linux is very aware of endian issues.  For all but I guess two of
you now, everyone assumes PowerPC is big endian and we make adjustments
when working on little endian I/O.  Without hardware for testing,
the rest of us are just likely to break any LE software, and you
are just going to end up chasing fixes behind lots of the rest of us.

> ..........what would be the primary
> obstacle to inclusion in the main line.

Like I always say, the kernel is the easy part.  None of us have
the hardware, tools, libraries, or applications to utilize a LE kernel.
It more than doubles the work we need to do trying to keep the
software up to date, if we had all of that for testing.  It may
be easier to just keep your patch up to date, than to try and keep
up with the rest of us making changes to software we can't test.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
