Date: Thu, 14 Dec 2000 18:21:26 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: Dan Malek <dan@mvista.com>
Cc: Graham Stoney <greyham@research.canon.com.au>,
        Brian Ford <ford@vss.fsi.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
Message-ID: <20001214182126.E8430@brixi.research.canon.com.au>
References: <20001212182856.A8336@brixi.research.canon.com.au> <Pine.GSO.4.21.0012120933330.24199-100000@eos> <20001213121554.B17129@brixi.research.canon.com.au> <3A37A048.46E692A0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A37A048.46E692A0@mvista.com>; from dan@mvista.com on Wed, Dec 13, 2000 at 11:14:00AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 13, 2000 at 11:14:00AM -0500, Dan Malek wrote:
> Although I have not yet proven this, I am leaning toward the following.
> Allocate a small fixed set of receive buffers (like we used to do)
> in the driver and mark them copy-back cached.  The received BDs will
> always point to thesed buffers.

I dunno; now that I've heard about the "buffer deficit scheme", I think it
gives better memory utilisation, since the receive buffers aren't permanently
tied up in the network driver.  It's the way the other drivers now do it.

> Then, copy-and-sum these into IP aligned skbuffs.

I think it depends whether the gain of having IP headers aligned outweighs the
cost of the extra copy in place of just a checksum.  The copy will tend to
throw more stuff out of the cache since it's dealing with the data twice.
Conventional logic when optimising network stacks is to eliminate copies, and
the only thing I see here that contradicts that is that we end up with not-
nicely-aligned IP headers.  In my application, eliminating the copy more than
offset the loss due to unaligned headers.

> The advantage of Graham's DMA into skbufs isn't that the driver doesn't
> copy/sum, it is that later when the IP stack does it we get burst transfers
> into cache.

But we get burst transfers into cache in either case, whether it's during
the checksum in csum_partial or the copy/sum in csum_partial_copy_generic.
The difference is that in the copy case, the data that gets loaded is only
used once, to write to another address in another cache line.  This extra
write will carry both a caching and bus penalty, and the impact is likely to
be worse in real applications than in simplistic throuhput tests.  Hence I
believe the conventional wisdom about eliminating the copy applies.

I know everything has second order effects and profiling is a perilous
minefield, but just occasionally things really do end up the way first order
thinking suggests :-).

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
