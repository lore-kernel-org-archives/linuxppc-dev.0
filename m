Message-ID: <3A6DCBBE.60AB54CE@mvista.com>
Date: Tue, 23 Jan 2001 13:21:50 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: tom_gall@vnet.ibm.com, Tom Gall <tgall@rochcivictheatre.org>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> Finally, somebody had to say it. But saying mostly incorrect is the
> understatement of the week.

It's been mumbled about for a while, and now that I am merging the
latest 4xx code and updating 8xx (and getting some performance
results on the 82xx and 74xx) I want to create more PowerPC generic
functions for all of the variants.  Since I am doing the work here,
I can also try some alternatives better suited to PowerPC.


> Yes they do care, but let us noi add unnecessary baggage to processors who
> do not need it.

I could make them all not care (I think), but I just found it interesting
the generic Linux memory management now has the concept of context
management, and we seem to be the only ones using it (and not very
effectively).

> ..... All these games with current_mm and active_mm were
> introduced for x86 because of their stupid MMU.

I guess I am not familiar enough with that stupid MMU to see why
it had to be done that way.  To me, it looked like a neat solution
to sharing mm contexts when it was useful.  I would like to use
the lazy TLB management, but it's implementation doesn't seem quite
right (or more likely I don't fully understand it :-).

> ..... 8xx/4xx are unfortunately
> almost as braindead while 6xx/7xx do get it right.

I'll take issue with that.  The 8xx/4xx is actually quite nice for
32-bit only embedded processors.  It is quite flexible and with some
large page size enhancements I am considering, it should be efficient
as well.  The 6xx/7xx have to solve the very large virtual address
space challenge, and unfortunately require lots of software management
because the Linux page tables don't map into their hardware assist
very well.  The 74xx (or at least 7450) allows some additional
flexibility that we may want to consider as well.  Anyway, there
are other solutions that should work better and I want to work
toward a more generic VM interface for all of PowerPC.

> The MMU code is so different for 4xx/8xx and 6xx/7xx that adding a few
> conditionals for this mm management won't hurt. No kernel will ever run
> without a recompile on both kind of MMUs anyawy.

Right, the MMUs are different, and they share common exception
vectors (a good thing....hint to IBM).  Except for the TLB miss
handler and the hash table management, all of the PowerPC code
should be identical (except for the IBM 4xx, which seems to think
it is necessary to invent new registers to do the same thing...).


> For 6xx/7xx active_mm has not even any reason to exist....

Perhaps, but it does and we should make sure it is used correctly
(hence, my complaining about not updating it correctly during a
context overflow).  I'll be using it to properly manage contexts/VSIDs
in the future.

> A proper implementation on 6xx/7xx would not even know what an expired
> context is. It would not even be possible to happen in the first place.

Heh :-)....Right, but it will require a context, and active_mm is
the proper place to store/retrieve it.  Doesn't the HIGHMEM option
require we properly use a kernel context?  Or, do we just get lucky
there, too :-).

What you see today won't be there much longer......


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
