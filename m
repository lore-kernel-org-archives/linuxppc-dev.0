Message-Id: <5.1.0.14.2.20030225185928.00ac3198@mail.zultys.com>
Date: Tue, 25 Feb 2003 20:08:14 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Possible bug in flush_dcache_all on 440GP
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!

I believe there is a bug in flush_dcache_all implementation for not cache
coherent processors.

This function uses simple algorithm to force dcache flush by reading
"enough" data to completely reload the cache:

/*
  * 40x cores have 8K or 16K dcache and 32 byte line size.
  * 440 has a 32K dcache and 32 byte line size.
  * 8xx has 1, 2, 4, 8K variants.
  * For now, cover the worst case of the 440.
  * When we get a cputable cache size entry we can do the right thing.
  */

#define CACHE_NWAYS	64
#define CACHE_NLINES	16

_GLOBAL(flush_dcache_all)
	li	r4, (CACHE_NWAYS * CACHE_NLINES)
	mtctr	r4
	lis     r5, KERNELBASE@h
1:	lwz	r3, 0(r5)		/* Load one word from every line */
	addi	r5, r5, L1_CACHE_LINE_SIZE
	bdnz    1b
	blr

This function uses the assumption that __every__ load operation will
cause cache miss therefore it executes CACHE_NWAYS * CACHE_NLINES
loads to force all cache reload. It uses memory from the beginning
of the kernel for this purpose.

Problem may arise if some of the addresses from this range (starting
at KERNELBASE) are already in the dcache (for example from the _previous_
call to flush_dcache_all).

Here is more technical details:

Cache on 440GP is 64-was associative. There is a register for each cache set
(called data cache victim index register) which holds "way" number for
next cache-miss-triggered load operation. It's incremented in round-robin
manner after each cache load.

flush_dcache_all _may_ cause up to 64 loads for each cache set, and all
ways will be reloaded. But, if there is less than 64 loads (because some loads
are not misses) not all ways will be reloaded, causing possible dirty data
not reaching phys memory.

It's interesting that current flush_dcache_all implementation seems to be
OK for
all CPU with _smaller_ than 32K dcache size. This is due to the fact that
using
_twice_ as much memory than the cache size will _always_ completely reload
the cache.

I think of two possible way to fix this function:

1) Use twice as much memory than the cache size. This solution is not very
efficient,
    but it doesn't add _any_ special requirements to the memory we use to
reload the
    cache with.

2) Add "dccci 0, 0" just before "blr". This still assumes that we use
memory which
    normally is _not_ loaded into dcache (e.g. code at KERNELBASE).

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
