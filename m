Date: Fri, 15 Dec 2000 11:18:14 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Dan Malek <dan@mvista.com>
Cc: Graham Stoney <greyham@research.canon.com.au>,
        Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
Message-ID: <20001215111814.A7599@brixi.research.canon.com.au>
References: <20001212182856.A8336@brixi.research.canon.com.au> <Pine.GSO.4.21.0012120933330.24199-100000@eos> <20001213121554.B17129@brixi.research.canon.com.au> <3A37A048.46E692A0@mvista.com> <20001214182126.E8430@brixi.research.canon.com.au> <3A38FC27.CE7F7F24@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A38FC27.CE7F7F24@mvista.com>; from dan@mvista.com on Thu, Dec 14, 2000 at 11:58:15AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Comparing DMA direct to skbufs with packet copy in the FEC driver, I said:
> But we get burst transfers into cache in either case,

Dan writes:
> No, because I originally allocated the receive buffers uncached.

That's comparing apples with oranges though.  I wasn't talking about what the
current driver does, I was comparing your suggestion of cached receive buffers
(which I also implemented in the FEC and benchmarked) with DMA direct to the
cached skbufs.  In both cases the CPU bursts the data into the cache when it
first goes to access it, so that doesn't explain why I found that DMA direct
to the skbuf was faster overall than just making the Rx buffer cached and
retaining the copy.  Both gave a measurable speed improvement over the
original driver.

Note that even when doing DMA direct to the skbuf, it's normal to have a size
threshold below which packets are copied into a newly allocated skbuf of the
exact size.  This avoids wasting skbuf space on tiny packets, and gives the
opportunity to nicely align the IP header.  As a result, small packets (where
IP stack processing dominates and header alignment is most important) are
processed exactly the way you describe, while large ones (where avoiding
copying the payload is most important) avoid being copied.  Hence you end up
with the best of both worlds.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
