Message-ID: <3910838C.986942D6@embeddededge.com>
Date: Wed, 03 May 2000 15:52:44 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: allocating non-cacheable regions
References: <39104A07.D997B6C5@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:
>
> How do I allocate a region of memory that is flagged as being
> non-cacheable?

I am assuming you intend to do this on the 8xx processor as it
doesn't make sense on others.  It may also not make sense on the 8xx
as it appears from testing that caching memory and push/invalidate
during I/O is better......

For an example, look at the commproc.c or enet.c driver in the
arch/ppc/8xx_io directory.  When pages are allocated, the PTEs are
tracked down and marked non-cache.

> Does it have to be done at allocation or is it possible to mark a region
> non-cacheable
> after its been allocated?

I haven't found a way to get the kernel to allocate non-cache regions
of real memory.  It would be nice if there was something along the
lines of DMA attribute, or perhaps I am just not looking in the right
place (and I am sure someone will point this out :-).

All I/O space is uncached and guarded.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
