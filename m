Message-ID: <3A37FDDA.BA68DDF1@mvista.com>
Date: Wed, 13 Dec 2000 17:53:14 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <Pine.GSO.4.21.0012131547530.24199-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> I speak only for the 8260, but...
>
> With it, you can DMA directly into IP aligned skbuffs,

No, you can't.  The receiver buffers must be 32-byte aligned.  The
Ethernet header is 14 bytes, so the IP frame starts on this 16-bit
aligned boundary.  Then the IP stack promptly does a 32-bit load from
this misaligned address.

> ... I've done it and it seems to work.

I don't think so......It is typical of all of the CPM devices to
require strict alignment of incoming buffers, and very relaxed alignment
of outgoing buffers (which is precisely what you need for most
protocol processing).

> .....  I'll have to benchmark it, but
> the copy overhead should be significant.  This just makes IP do the
> checksum later.

Right, you have to read this data at some point, so the copy-sum does
both in one operation.  It does the checksum while it is moving the
buffer and aligning it on the IP frame boundary.  This also give the
advantage of the IP frame in the cache, so when you push it upstream
you are likely to get some cache hits.

> Also, to avoid bus contention, shouldn't the Rx buffers be on the local
> bus?  Probably the BD's too.

Yeah, that's why they designed the part this way.  Not many boards
use it, though.

> .....  Unless we can figure out how to
> put these in DPRAM, but it doesn't look possible for the FCC's.

I have tried, and for some reason I couldn't make it work correctly.
It should, I just haven't been back to debug it.

> ....  I don't
> know if it is possible to allocate skbuffs in other than 60x bus SDRAM,
> though.

Probably not worth it.  The 66 MHz buses with burst mode and fast
SDRAM are pretty sweet.  The skbuffs pool can get very large, certainly
more than would fit into DPRAM, but it is sufficiently modular that you
could put it into the local DRAM.


> .....  Unless the local bus proves to be a larger gain and we can't
> do that there.

The local bus can be an advantage for some applications.  For data
or information the CPM accesses frequently (BDs, hash tables, channel
tables, scheduler tables, etc.) this is a great benefit.  If you are
also just packet/frame routing, this is a useful place for the data.
It seems for other applications, where the PowerPC core is going to
use the data frequently, the best place is the 60x memory.  It is
one of those features that you shouldn't try to use just because it
is there.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
