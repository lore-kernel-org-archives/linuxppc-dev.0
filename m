Date: Wed, 13 Dec 2000 16:08:14 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Dan Malek <dan@mvista.com>
cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
In-Reply-To: <3A37A048.46E692A0@mvista.com>
Message-ID: <Pine.GSO.4.21.0012131547530.24199-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 13 Dec 2000, Dan Malek wrote:

> Graham Stoney wrote:
>
> > This does indeed sound better; the only sticky part I can think of is setting
> > the FCC/FEC to keep giving you Rx interrupts even when there are no buffer
> > descriptors to put the incoming packets in,
>
Won't we get a "Busy error" Rx interrupt in this case?

> Although I have not yet proven this, I am leaning toward the following.
> Allocate a small fixed set of receive buffers (like we used to do)
> in the driver and mark them copy-back cached.  The received BDs will
> always point to thesed buffers.  Then, copy-and-sum these into IP
> aligned skbuffs.  The advantage of Graham's DMA into skbufs isn't that
> the driver doesn't copy/sum, it is that later when the IP stack does it
> we get burst transfers into cache.  So, we get this advantage plus
> the IP packet aligned properly for the remainder of the stack.
>
I speak only for the 8260, but...

With it, you can DMA directly into IP aligned skbuffs, eliminating the
copy.  I've done it and it seems to work.  I'll have to benchmark it, but
the copy overhead should be significant.  This just makes IP do the
checksum later.

Also, to avoid bus contention, shouldn't the Rx buffers be on the local
bus?  Probably the BD's too.  Unless we can figure out how to
put these in DPRAM, but it doesn't look possible for the FCC's.  I don't
know if it is possible to allocate skbuffs in other than 60x bus SDRAM,
though.

> Of course, the downside of this is the receive buffers are one-time
> cached.  We blow the cache away to make the TCP benchmark look good,
> and the remaining applications suffer.  I still have a problem with
> this.....making single focused benchmarks look good isn't necessarily
> the best for the overall system application.
>
I see your point.  Cacheing may not be the way to go.  Incidentally, this
is for all practicle purposes, my application.

The ideas I put forth above may still improve performance if they are
feasable.  Eliminating one copy can only help since we can still have the
alignment.  Unless the local bus proves to be a larger gain and we can't
do that there.

Opinions welcome.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
