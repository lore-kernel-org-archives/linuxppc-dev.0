Date: Tue, 12 Dec 2000 18:28:56 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Dan Malek <dan@mvista.com>
Cc: Graham Stoney <greyham@research.canon.com.au>,
        Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
Message-ID: <20001212182856.A8336@brixi.research.canon.com.au>
References: <20001211114533.A2691@brixi.research.canon.com.au> <Pine.GSO.4.21.0012110920300.24199-100000@eos> <20001212133658.C1773@brixi.research.canon.com.au> <3A359AF6.229DEA77@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A359AF6.229DEA77@mvista.com>; from dan@mvista.com on Mon, Dec 11, 2000 at 10:26:46PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Graham Stoney wrote:
> > Absolutely; the bus is the bottleneck.  You'll find the network throughput
> > scales almost linearly with bus speed,

On Mon, Dec 11, 2000 at 10:26:46PM -0500, Dan Malek replied:
> I've never seen that.  My 860P with 80/40 MHz is faster than the
> same processor at 50/50 MHz.  I also haven't seen the big speed
> improvement using the DMA changes either.  I am experimenting with
> a couple of other things, such as aligning the IP data on the
> incoming side (i.e. misaligning the Ethernet frame).  Just using
> bigger TCP window sizes will help more than anything else.

OK, my comment was a bit simplistic; I should have said "bus and core speed".
It won't scale linearly if you reduce one but increase the other :-).
I found that our 855T at 80/40 MHz was just slightly slower than 50/50 when
measuring raw TCP throughput, my reasoning being that TCP performance over
the FEC is bus limited, so the reduction in bus speed more than offset the
gain in CPU core speed.  Once I added in a bit of application processing and
IDMA, it tipped the balance back towards 80/40 being marginally faster.  Our
slightly better optimised SDRAM UPM settings made a difference too (I ran the
same test on a CLLF with slightly different results), so other people's
kilometreage may vary.

I did see measurable gains by leaving the receive buffers cached (and adding
explicit calls to invalidate_dcache_range), and some more by DMA'ing large
packets directly to the skbuff to avoid the extra copy; this is what all the
other high performance Ethernet drivers do nowadays -- it would be nice to get
this improvement into the standard FEC/FCC drivers, even if it only gives an
extra 15-20%.  It should never be slower, and I found it actually simplified
some things like the ring buffer allocation slightly.  The only tricky bit
was what to do if I couldn't allocate a new rx skbuf to replace the one just
filled: the easiest solution was to just drop the current incoming packet and
reuse its skbuf next time.  I never saw this actually happen of course.

I looked at aligning the IP data too, but the FEC requires all Rx buffer
pointers in the descriptor to be 16 byte aligned, and since the Ethernet
header is 14 bytes, I couldn't see any way to do it.  Using a bigger TCP
window helps at the start; once the window is full though it makes no
difference from then on and it burns RAM, so it doesn't help average
throughput much in cases like ours where the total volume of data we're
trying to transfer to the 855T is significantly larger than its available RAM.

> What tests were you using?  I have a variety of little things I
> have written, but mostly use a source/sink TCP application.

Yes, I wrote a simple source/sink TCP app.  I discovered ttcp shortly after
writing my own.

> Yes, among other things.  The 8260 runs very well and I am currently
> doing lots of performance testing on some custom boards.  I haven't
> seen anything really bad in the driver yet, but there will likely be
> some performance enhancements coming.

Sounds good; I suspect Brian's throughput problems are mainly bus limited and
will go away when he gets the bus speed up.  Provided the CPU core speed
doesn't drop in the process of course :-).

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
