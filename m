Date: Tue, 12 Dec 2000 10:32:53 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Graham Stoney <greyham@research.canon.com.au>
cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
In-Reply-To: <20001212182856.A8336@brixi.research.canon.com.au>
Message-ID: <Pine.GSO.4.21.0012120933330.24199-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 12 Dec 2000, Graham Stoney wrote:

> On Mon, Dec 11, 2000 at 10:26:46PM -0500, Dan Malek replied:
> > I also haven't seen the big speed improvement using the DMA changes
> > either.  I am experimenting with a couple of other things, such as
> > aligning the IP data on the incoming side (i.e. misaligning the
> > Ethernet frame).  Just using bigger TCP window sizes will help more
> > than anything else.
>
> I did see measurable gains by leaving the receive buffers cached (and adding
> explicit calls to invalidate_dcache_range), and some more by DMA'ing large
> packets directly to the skbuff to avoid the extra copy; this is what all the
> other high performance Ethernet drivers do nowadays -- it would be nice to get
> this improvement into the standard FEC/FCC drivers, even if it only gives an
> extra 15-20%.  It should never be slower, and I found it actually simplified
> some things like the ring buffer allocation slightly.  The only tricky bit
> was what to do if I couldn't allocate a new rx skbuf to replace the one just
> filled: the easiest solution was to just drop the current incoming packet and
> reuse its skbuf next time.  I never saw this actually happen of course.
>
Are the explicit driver level calls to invalidate_dcache_range necessary
on the receive side, or does the stack do them after netif_rx?  If they
are necessary, would bus snooping be more or less efficient?  As far as I
can tell, Dan's FCC driver has the all buffers in cached memory, but I
don't see any invalidate calls.  He does have the snooping bit set in the
FCMR.  I assume this if for CPM snooping ie. on the transmit side?

I also see measurable performance gains with direct DMA into the skbuf.  I
didn't seem to see much difference with aligning the IP header.  I will
measure both again and post the results.

I agree that most all the high performance drivers do direct DMA to the
skbufs, and it would be nice for ours to follow suit.  Hopefully my
performance measurements will justify this.

The best solution to the "couldn't allocate an skbuf" seems to be the one
taken by Donald Becker in the tulip driver called the "buffer deficit
scheme."  I am studying this to see if I can replicate it.

I would also like to implement hardware flow control for full duplex
connections.  My ultimate goal is to use UDP communications on a private
network and get the 8260 to not drop any packets when a Solaris box bursts
to full rate.

> > What tests were you using?  I have a variety of little things I
> > have written, but mostly use a source/sink TCP application.
>
> Yes, I wrote a simple source/sink TCP app.  I discovered ttcp shortly after
> writing my own.
>
I use ttcp most of the time, too.

> > Yes, among other things.  The 8260 runs very well and I am currently
> > doing lots of performance testing on some custom boards.  I haven't
> > seen anything really bad in the driver yet, but there will likely be
> > some performance enhancements coming.
>
> Sounds good; I suspect Brian's throughput problems are mainly bus limited and
> will go away when he gets the bus speed up.  Provided the CPU core speed
> doesn't drop in the process of course :-).
>
I hope so.  Maybe some good performance enhancements will come out of this
discussion.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
