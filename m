Message-ID: <39359499.7B652D91@lucent.com>
Date: Wed, 31 May 2000 17:39:21 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: allocating non-cacheable regions
References: <39104A07.D997B6C5@ccrl.mot.com> <3910838C.986942D6@embeddededge.com> <39357BC5.A0B3E713@ccrl.mot.com> <39358E65.145F7EA3@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
> You need to invalidate the data cache for this address and the TLB
> entry for this address when you set the flag.

That is probably his problem.


> You also need to ensure you are not
> multiple mapping the same physical address....

No, that is not necessary, as long as your program is aware of the
multiple mapping. In certain cases (com buffers shared by two non-
snooping CPUs) this is quite useful -- use the uncached addrs for the
queue pointers and the cached addrs for the data (being careful to
manually flush the cache before reading and after writing).

You do need to ensure you are not mapping the same _virtual_ address
(i.e. the effective address, in the language of Motorola's manuals),
but the kernel routines will probably take care of that for you....


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
