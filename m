Date: Tue, 26 Jun 2001 06:22:29 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: (allocating non-cachable memory) (or More on the i82596)
Message-ID: <Pine.LNX.3.95.1010626060441.32475C-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been looking at the code for the i82596 ethernet controller a bit
more and think that (thank god) it provides a better base for my board's
driver than I initially though.

But...

Our board is 603e based, with non functional hardware snooping. This is
not too much a problem for this chip- it supports writing to a block of
shared memory marked as non-cachable in lieu of using snooping. In fact,
our vxworks port for the board uses a whopping half meg memory region for
this purpose (seems a bit large to me, but I wasn't involved with that
port). What's more, the driver in the kernel seems to work using a shared
memory region as well. This is architecturally good. Unfortunately, I am
unable to figure out how to mark an area of memory as non-cachable.

The existing driver was written for 68k hardware, and therefore uses calls
that are non-existant in the ppc port:

#ifdef __mc68000__
        cache_push(virt_to_phys((void *)(dev->mem_start)), 4096);
        cache_clear(virt_to_phys((void *)(dev->mem_start)), 4096);
        kernel_set_cachemode((void *)(dev->mem_start), 4096,  IOMAP_NOCACHE_SER);
#endif

Therefore, my concise question is most likely: what are the equivalent
functions for a 603e based board? (I assume that the two cache_ functions
are comprable to flush_instruction_cache, but am probably wrong about
that, so I blatantly make the error hear so that someone will correct my
ignorance :)

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
