From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp cwith r128
Date: Wed, 8 Mar 2000 21:41:22 -0500
Content-Type: text/plain
Cc: Michel Danzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0003052134430.12030-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0003052134430.12030-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00030821502900.00501@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

There are three interesing tidbits about cache flushing.  One I picked up
recently on the  glibc apha and/or hacker mailing lists.

1. It seems some (many?) embedded ppc systems running linux do not have a cache
line size of 32! It is 8 or 16 or something funny.

2. AFAIK, cache flushing should never cause seg-faults since the associative
array used by the cache will ignore any address ranges not already in the cache.
If that page was never loaded it will not be in the cache.

3. 601 processors may barf(?) on some of these instructions.

So here is a piece of code I always steal when needing to do similar cache
flushing for the jdk and the metrowerks jit.  It is taken from the kernel
arch/ppc/kernel/head.S

I don't think we can access the machine type register in user space (but I am
very unsure about that).

/*
 * Write any modified data cache blocks out to memory
 * and invalidate the corresponding instruction cache blocks.
 * This is a no-op on the 601.
 *
 * flush_icache_range(unsigned long start, unsigned long stop)
 */
_GLOBAL(flush_icache_range)

	mfspr	r5,PVR
	rlwinm	r5,r5,16,16,31
	cmpi	0,r5,1
	beqlr				/* for 601, do nothing */

	li	r5,CACHE_LINE_SIZE-1
	andc	r3,r3,r5
	subf	r4,r3,r4
	add	r4,r4,r5
	srwi.	r4,r4,LG_CACHE_LINE_SIZE
	beqlr
	mtctr	r4
	mr	r6,r3
1:	dcbst	0,r3
	addi	r3,r3,CACHE_LINE_SIZE
	bdnz	1b
	sync				/* wait for dcbst's to get to ram */
	mtctr	r4
2:	icbi	0,r6
	addi	r6,r6,CACHE_LINE_SIZE
	bdnz	2b
	sync
	isync
	blr



I have no idea if the cacheline size and processor values are made available by
the kernel during runtime so that we could use those values.

I will try your changes and let you know.

Thanks,

Kevin


--
Kevin B. Hendricks Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario London, Ontario
N6A-3K7  CANADA    khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
