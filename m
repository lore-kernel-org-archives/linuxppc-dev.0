Date: Thu, 14 Dec 2000 11:29:47 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: Dan Malek <dan@mvista.com>
cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: FEC/FCC driver issues
In-Reply-To: <3A37FDDA.BA68DDF1@mvista.com>
Message-ID: <Pine.GSO.4.21.0012140924160.24199-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I changed the Subject line to better reflect the current discussion.

On Wed, 13 Dec 2000, Dan Malek wrote:

> Brian Ford wrote:
>
> > I speak only for the 8260, but...
> >
> > With it, you can DMA directly into IP aligned skbuffs,
>
> No, you can't.  The receiver buffers must be 32-byte aligned.  The
> Ethernet header is 14 bytes, so the IP frame starts on this 16-bit
> aligned boundary.  Then the IP stack promptly does a 32-bit load from
> this misaligned address.
>
> > ... I've done it and it seems to work.
>
> I don't think so......It is typical of all of the CPM devices to
> require strict alignment of incoming buffers, and very relaxed alignment
> of outgoing buffers (which is precisely what you need for most
> protocol processing).
>
Not to my understanding and actual experience.  The Rx buffer size must be
a multiple of 32, but it need not be aligned that way.  The CPM
uses the DMA engine to move the data from the DPRAM to its destination.
And the DMA engine supports unaligned destinations by transferring the
unaligned part, bursting the aligned part, and then transferring the
remaining unaligned part.

> > .....  I'll have to benchmark it, but
> > the copy overhead should be significant.  This just makes IP do the
> > checksum later.
>
> Right, you have to read this data at some point, so the copy-sum does
> both in one operation.  It does the checksum while it is moving the
> buffer and aligning it on the IP frame boundary.  This also give the
> advantage of the IP frame in the cache, so when you push it upstream
> you are likely to get some cache hits.
>
But you don't have to copy it until you move it to user space.

Are dev_alloc_skb() created skbuffs cached?  If so, your previous argument
about destroying the application's use of the cache is moot.  If not,
nothing will be cached after the copy.

> > Also, to avoid bus contention, shouldn't the Rx buffers be on the local
> > bus?  Probably the BD's too.
>
> Yeah, that's why they designed the part this way.  Not many boards
> use it, though.
>
Sounds like a good place to put a config ifdef or something then.

> > .....  Unless we can figure out how to
> > put these in DPRAM, but it doesn't look possible for the FCC's.
>
> I have tried, and for some reason I couldn't make it work correctly.
> It should, I just haven't been back to debug it.
>
Yes, I saw.  I didn't have much luck with my weak attempt either.

I am having a real hard time determining from the conflicting diagrams
exactly where the two ports of the DPRAM reside, ie. on what busses.  We
need to know this to set the proper flag in the FCRx if we put the BDs or
buffers in DPRAM (although I don't think the buffers should ever go
there).

Jerry Van Baren's mail would make it appear that you have to use the 60x
bus to access DPRAM through the FCC configuration.  That is why the
question above is so interesting to me.

> > ....  I don't
> > know if it is possible to allocate skbuffs in other than 60x bus SDRAM,
> > though.
>
> Probably not worth it.  The 66 MHz buses with burst mode and fast
> SDRAM are pretty sweet.  The skbuffs pool can get very large, certainly
> more than would fit into DPRAM, but it is sufficiently modular that you
> could put it into the local DRAM.
>
I still wish I could get 66 MHz working.

I guess we would need a whole allocation/free engine for local bus
RAM.  Are there any hooks into the current allocation engines for this
type of purpose?

> > .....  Unless the local bus proves to be a larger gain and we can't
> > do that there.
>
> The local bus can be an advantage for some applications.  For data
> or information the CPM accesses frequently (BDs, hash tables, channel
> tables, scheduler tables, etc.) this is a great benefit.  If you are
> also just packet/frame routing, this is a useful place for the data.
> It seems for other applications, where the PowerPC core is going to
> use the data frequently, the best place is the 60x memory.  It is
> one of those features that you shouldn't try to use just because it
> is there.
>
If it wasn't for the checksum, the core doesn't access it frequently until
it is copied to user space.


Thank you for your valuable advice and knowledge.  I just wanted to make
sure you know that I appreciate your help and input.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
