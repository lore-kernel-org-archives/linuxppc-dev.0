Message-ID: <3DD92C01.7080906@iram.es>
Date: Mon, 18 Nov 2002 19:05:53 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Tim Seufert <tas@mindspring.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
References: <IGEFJKJNHJDCBKALBJLLEEBFFIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Ok, thanks for the lesson. I decided to have a closer look at arch/ppc/kernel/misc.S to
> see how it uses the bdnz instruction. I think i may have found a bug:
>
> /*
>  * Like above, but invalidate the D-cache.  This is used by the 8xx
>  * to invalidate the cache so the PPC core doesn't get stale data
>  * from the CPM (no cache snooping here :-).
>  *
>  * invalidate_dcache_range(unsigned long start, unsigned long stop)
>  */
> _GLOBAL(invalidate_dcache_range)
> 	li	r5,L1_CACHE_LINE_SIZE-1
> 	andc	r3,r3,r5
> 	subf	r4,r3,r4
> 	add	r4,r4,r5
> 	srwi.	r4,r4,LG_L1_CACHE_LINE_SIZE
> 	beqlr
> 	mtctr	r4
>
> 1:	dcbi	0,r3
> 	addi	r3,r3,L1_CACHE_LINE_SIZE
> 	bdnz	1b
> 	sync				/* wait for dcbi's to get to ram */
> 	blr
>
> Supposed you you do a invalidate_dcache_range(0,16) then 2 cachelines should be
> invalidated on a mpc8xx, since range 0 to 16 is 17 bytes and a cache line is 16 bytes.

I don't know this code, whether it is correct or not depends on what you
pass in r4. If it is invalidate_dcache_range(start, start+len), the code
is correct since start+len is one byte beyond the buffer. If it is
invalidate_dcache_range(first, last), then it is buggy. The former
definition of parameters is more frequent in practice.

This said, the first instruction can be removed:
_GLOBAL(invalidate_dcache_range)
  	rlwinm	r3,r3,0,~(L1_CACHE_LINE_SIZE-1)
  	subf	r4,r3,r4
  	add	r4,r4,L1_CACHE_LINE_SIZE-1

should work.

> If I understand this assembly, mtctr r4 will load the CTR with 1 and that
> will only execute the the dcbi 0,r3 once. Am I making sense here?

Yes, but I believe that the parameters are defined that way. There is
a reason for which C wants pointers to element following the end
of an array to be valid.

[SNIP]

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
