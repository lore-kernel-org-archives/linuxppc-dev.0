Date: Mon, 18 Nov 2002 14:49:07 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: csum_partial() and csum_partial_copy_generic() in badly optimized?
In-reply-to: <3DD868BC.7090402@iram.es>
To: Gabriel Paubert <paubert@iram.es>
Cc: Tim Seufert <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEBFFIAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > OK, so how about if I modify the crc32 loop:
> >
> > unsigned char * end = data +len;
> > while(data < end) {
> >         result = (result << 8 | *data++) ^ crctab[result >> 24];
> > }
> >
> > will that be possible to optimze in with something similar as bdnz also?
[SNIP]
> 	Gabriel.

Ok, thanks for the lesson. I decided to have a closer look at arch/ppc/kernel/misc.S to
see how it uses the bdnz instruction. I think i may have found a bug:

/*
 * Like above, but invalidate the D-cache.  This is used by the 8xx
 * to invalidate the cache so the PPC core doesn't get stale data
 * from the CPM (no cache snooping here :-).
 *
 * invalidate_dcache_range(unsigned long start, unsigned long stop)
 */
_GLOBAL(invalidate_dcache_range)
	li	r5,L1_CACHE_LINE_SIZE-1
	andc	r3,r3,r5
	subf	r4,r3,r4
	add	r4,r4,r5
	srwi.	r4,r4,LG_L1_CACHE_LINE_SIZE
	beqlr
	mtctr	r4

1:	dcbi	0,r3
	addi	r3,r3,L1_CACHE_LINE_SIZE
	bdnz	1b
	sync				/* wait for dcbi's to get to ram */
	blr

Supposed you you do a invalidate_dcache_range(0,16) then 2 cachelines should be
invalidated on a mpc8xx, since range 0 to 16 is 17 bytes and a cache line is 16 bytes.

If I understand this assembly, mtctr r4 will load the CTR with 1 and that
will only execute the the dcbi 0,r3 once. Am I making sense here?

I think the function should look something like this:
_GLOBAL(invalidate_dcache_range)
	subf	r4,r3,r4
	beqlr
	srwi.	r4,r4,LG_L1_CACHE_LINE_SIZE
	addi	r4,r4,1
	mtctr	r4

1:	dcbi	0,r3
	addi	r3,r3,L1_CACHE_LINE_SIZE
	bdnz	1b
	sync				/* wait for dcbi's to get to ram */
	blr


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
