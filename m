Message-ID: <3A369297.93AFB1AC@mvista.com>
Date: Tue, 12 Dec 2000 16:03:19 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brian Ford <ford@vss.fsi.com>
CC: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.5 or 2.4 kernel profiling
References: <Pine.GSO.4.21.0012121106530.24199-100000@eos>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Ford wrote:

> Does your statement mean that 60x bus memory is mapped
> _PAGE_COHERENT?  What is the exact meaning of the GBL bit in the FCRx
> register?

The GBL flag in the FCRx is orthogonal to the PAGE_COHERENT (M in WIMG)
of the processor.  Since the CPM is a bus master, the GBL flag is used
to indicate whether it should announce memory updates in the cache
protocol.  The CPM shared memory is mapped uncached to the processor,
and I don't see any reason to do that differently.  For some reason,
I believe the GBL flag also ensures the CPM DMA will snoop the processor
cache, and setting PAGE_COHERENT isn't necessary.  I don't know why
I think this, except it appears to work that way :-).  Logically, we
should be required to set PAGE_COHERENT......It's a note on my board,
I'll keep looking at it.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
