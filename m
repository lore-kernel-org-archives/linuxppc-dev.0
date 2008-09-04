Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 982CADDEF7
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 22:05:46 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Thu, 4 Sep 2008 14:05:16 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<49c0ff980809031333g1b63694bkffbacb0ae8112120@mail.gmail.com>
	<18623.16970.61036.731524@cargo.ozlabs.ibm.com>
In-Reply-To: <18623.16970.61036.731524@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_878vIQknB0tHGzJ"
Message-Id: <200809041405.16489.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, prodyut hazarika <prodyuth@gmail.com>,
	John Rigby <jrigby@freescale.com>, munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_878vIQknB0tHGzJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 04 September 2008 04:04:58 Paul Mackerras wrote:
> prodyut hazarika writes:
> > glibc memxxx for powerpc are horribly inefficient. For optimal
> > performance, we should should dcbt instruction to establish the source
> > address in cache, and dcbz to establish the destination address in cache.
> > We should do dcbt and dcbz such that the touches happen a line ahead of
> > the actual copy.
> >
> > The problem which is see is that dcbt and dcbz instructions don't work on
> > non-cacheable memory (obviously!). But memxxx function are used for both
> > cached and non-cached memory. Thus this optimized memcpy should be smart
> > enough to figure out that both source and destination address fall in
> > cacheable space, and only then
> > used the optimized dcbt/dcbz instructions.
>
> I would be careful about adding overhead to memcpy.  I found that in
> the kernel, almost all calls to memcpy are for less than 128 bytes (1
> cache line on most 64-bit machines).  So, adding a lot of code to
> detect cacheability and do prefetching is just going to slow down the
> common case, which is short copies.  I don't have statistics for glibc
> but I wouldn't be surprised if most copies were short there also.

Then please explain the following. This is a memcpy() speed test for different 
sized blocks on a MPC5121e (DIU is turned on). The first case is glibc code 
without optimizations, and the second case is 16-register strides with 
dcbt/dcbz instructions, written in assembly language (see attachment)

$ ./memcpyspeed
Fully aligned:
100000 chunks of 5 bytes   :  3.48 Mbyte/s ( throughput:  6.96 Mbytes/s)
50000 chunks of 16 bytes   :  14.3 Mbyte/s ( throughput:  28.6 Mbytes/s)
10000 chunks of 100 bytes  :  14.4 Mbyte/s ( throughput:  28.8 Mbytes/s)
5000 chunks of 256 bytes   :  14.4 Mbyte/s ( throughput:  28.7 Mbytes/s)
1000 chunks of 1000 bytes  :  14.4 Mbyte/s ( throughput:  28.7 Mbytes/s)
50 chunks of 16384 bytes   :  14.2 Mbyte/s ( throughput:  28.4 Mbytes/s)
1 chunks of 1048576 bytes  :  14.4 Mbyte/s ( throughput:  28.8 Mbytes/s)

$ LD_PRELOAD=./libmemcpye300dj.so ./memcpyspeed
Fully aligned:
100000 chunks of 5 bytes   :  7.44 Mbyte/s ( throughput:  14.9 Mbytes/s)
50000 chunks of 16 bytes   :  13.1 Mbyte/s ( throughput:  26.2 Mbytes/s)
10000 chunks of 100 bytes  :  29.4 Mbyte/s ( throughput:  58.8 Mbytes/s)
5000 chunks of 256 bytes   :  90.2 Mbyte/s ( throughput:   180 Mbytes/s)
1000 chunks of 1000 bytes  :    77 Mbyte/s ( throughput:   154 Mbytes/s)
50 chunks of 16384 bytes   :  96.8 Mbyte/s ( throughput:   194 Mbytes/s)
1 chunks of 1048576 bytes  :  97.6 Mbyte/s ( throughput:   195 Mbytes/s)

(I have edited the output of this tool to fit into an e-mail without wrapping 
lines for readability).
Please tell me how on earth there can be such a big difference???
Note that on a MPC5200B this is TOTALLY different, and both processors have an 
e300 core (different versions of it though).

> The other thing that I have found is that code that is optimal for
> cache-cold copies is usually significantly slower than optimal for
> cache-hot copies, because the cache management instructions consume
> cycles and don't help in the cache-hot case.
>
> In other words, I don't think we should be tuning the glibc memcpy
> based on tests of how fast it copies multiple megabytes.

I don't just copy multiple megabytes! See above example. Also I do constant 
performance testing of different applications using LD_PRELOAD, to se the 
impact. Recentrly I even tried prboom (a free doom port), to remember the 
good old days of PC benchmarking ;-)
I have yet to come across a test that has lower performance with this 
optimization (on an MPC5121e that is).

> Still, for 6xx/e300 cores, we probably do want to use dcbt/dcbz for
> larger copies.  We don't want to use dcbt/dcbz on the larger 64-bit

At least for MPC5121e you really, really need it!!

> processors (POWER4/5/6) because the hardware prefetching and
> write-combining mean that dcbt/dcbz don't help and just slow things
> down.

That's explainable.
What's not explainable, are the results I am getting on the MPC5121e.
Please, could someone tell me what I am doing wrong? (I must be doing 
something wrong, I'm almost sure).
One thing that I realize is not quite "right" with memcpyspeed.c is the fact 
that it copies consecutive blocks of memory, that should have an impact on 
5-byte and 16-bytes copy results I guess (a cacheline for the following block 
may already be fetched), but not anymore for 100-byte blocks and bigger (with 
32-byte cache lines). In fact, 16-bytes seems to be the only size where the 
additional overhead has some impact (which is negligible).

Another thing is that performance probably matters most to the end-user when 
applications need to copy big amounts of data (e.g. video frames or bitmap 
data), which is most probably done using big blocks of memcpy(), so 
eventually hurting performance for small copies probably has less weight on 
overall experience.

Best regards,

-- 
David Jander

--Boundary-00=_878vIQknB0tHGzJ
Content-Type: text/x-objcsrc;
  charset="iso-8859-1";
  name="memcpy_e300_dj.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="memcpy_e300_dj.S"

/* Optimized memcpy() implementation for PowerPC e300c4 core (Freescale MPC5121)
 *
 * Written by Gunnar von Boehn
 * Tweaked by David Jander to improve performance on MPC5121e processor.
 */

#include "ppc_asm.h"

#define L1_CACHE_SHIFT          5 
#define MAX_COPY_PREFETCH       4 
#define L1_CACHE_BYTES          (1 << L1_CACHE_SHIFT) 
 
CACHELINE_BYTES = L1_CACHE_BYTES 
LG_DOUBLE_CACHELINE = (L1_CACHE_SHIFT+1)
CACHELINE_MASK = (L1_CACHE_BYTES-1) 

/* 
 * Memcpy optimized for PPC e300 
 * 
 * This relative simple memcpy does the following to optimize performance 
 * 
 * For sizes > 32 byte: 
 * DST is aligned to 32bit boundary - using 8bit copies 
 * DST is aligned to cache line boundary (32byte) - using aligned 32bit copies 
 * The main copy loop prossess one cache line (32byte) per iteration 
 * The DST cacheline is clear using DCBZ 
 * The clearing of the aligned DST cache line is very important for performance 
 * it prevents the CPU from fetching the DST line from memory - this saves 33% of memory accesses. 
 * To optimize SRC read performance the SRC is prefetched using DCBT 
 * 
 * The trick for getting good performance is to use a good match of prefetch distance 
 * for SRC reading and for DST clearing. 
 * Typically you DCBZ the DST 0 or 1 cache line ahead 
 * Typically you DCBT the SRC 2 - 4 cache lines ahaed 
 * on the e300 prefetching the SRC too far ahead will be slower than not prefetching at all. 
 * 
 * We use  DCBZ DST[0]  and DBCT SRC[0-1] depending on the SRC alignment 
 * 
 */ 
.align 2 

/* parameters r3=DST, r4=SRC, r5=size */ 
/* returns r3=DST */ 


.global memcpy
memcpy:
	mr      r7,r3                    /* Save DST in r7 for return */
	dcbt    0,r4                     /* Prefetch SRC cache line 32byte */ 
	neg     r0,r3                    /* DST alignment */ 
	addi    r4,r4,-4
	andi.   r0,r0,CACHELINE_MASK     /* # of bytes away from cache line boundary */ 
	addi    r6,r3,-4
	cmplw   cr1,r5,r0                /* is this more than total to do? */ 
	beq     .Lcachelinealigned 
	
	blt     cr1,.Lcopyrest                  /* if not much to do */ 
 
	andi.   r8,r0,3                         /* get it word-aligned first */ 
	mtctr   r8 
	beq+    .Ldstwordaligned 
.Laligntoword:  
	lbz     r9,4(r4)                        /* we copy bytes (8bit) 0-3  */ 
	stb     r9,4(r6)                        /* to get the DST 32bit aligned */ 
	addi    r4,r4,1 
	addi    r6,r6,1 
	bdnz    .Laligntoword 

.Ldstwordaligned: 
	subf    r5,r0,r5 
	srwi.   r0,r0,2 
	mtctr   r0 
	beq     .Lcachelinealigned 

.Laligntocacheline: 
	lwzu    r9,4(r4)                        /* do copy 32bit words (0-7) */ 
	stwu    r9,4(r6)                        /* to get DST cache line aligned (32byte) */ 
	bdnz    .Laligntocacheline 

.Lcachelinealigned:
	srwi.   r0,r5,LG_DOUBLE_CACHELINE        /* # complete cachelines */ 
	clrlwi  r5,r5,32-LG_DOUBLE_CACHELINE 
	li      r11,32
	beq     .Lcopyrest 

	addi    r3,r4,4                         /* Find out which SRC cacheline to prefetch */ 
	neg     r3,r3    
	andi.   r3,r3,31 
	addi    r3,r3,32 
	
	mtctr   r0 

	stwu    r1,-76(r1) /* Save some tmp registers */
	stw     r23,28(r1)
	stw     r30,56(r1)
	stw     r31,60(r1)
	stw     r24,32(r1)
	stw     r25,36(r1)
	stw     r26,40(r1)
	stw     r27,44(r1)
	stw     r28,48(r1)
	stw     r29,52(r1)
	stw     r13,64(r1)
	stw     r14,68(r1)
	stw     r15,72(r1)
	
.align 7 
.Lloop:                                         /* the main body of the cacheline loop */ 
	dcbt    r3,r4                           /* SRC cache line prefetch */ 
	dcbz    r11,r6                          /* clear DST cache line */ 
	lwz     r31, 0x04(r4)                   /* copy using a 8 register stride for best performance on e300 */ 
	lwz     r8,  0x08(r4)
	lwz     r9,  0x0c(r4)
	lwz     r10, 0x10(r4)
	lwz     r12, 0x14(r4)
	lwz     r13, 0x18(r4)
	lwz     r14, 0x1c(r4)
	lwzu    r23, 0x20(r4)
	dcbt    r3,r4                           /* SRC cache line prefetch */ 
	lwz     r24, 0x04(r4)
	lwz     r25, 0x08(r4)
	lwz     r26, 0x0c(r4)
	lwz     r27, 0x10(r4)
	lwz     r28, 0x14(r4)
	lwz     r29, 0x18(r4)
	lwz     r30, 0x1c(r4)
	lwzu    r15, 0x20(r4)
	stw     r31, 0x04(r6)
	stw     r8,  0x08(r6)
	stw     r9,  0x0c(r6)
	stw     r10, 0x10(r6)
	stw     r12, 0x14(r6)
	stw     r13, 0x18(r6)
	stw     r14, 0x1c(r6)
	stwu    r23, 0x20(r6)
	dcbz    r11,r6                          /* clear DST cache line */ 
	stw     r24, 0x04(r6)
	stw     r25, 0x08(r6)
	stw     r26, 0x0c(r6)
	stw     r27, 0x10(r6)
	stw     r28, 0x14(r6)
	stw     r29, 0x18(r6)
	stw     r30, 0x1c(r6)
	stwu    r15, 0x20(r6)
	bdnz    .Lloop 
		
	lwz     r24,32(r1) /* restore tmp registers */
	lwz     r23,28(r1)
	lwz     r25,36(r1)
	lwz     r26,40(r1)
	lwz     r27,44(r1)
	lwz     r28,48(r1)
	lwz     r29,52(r1)
	lwz     r30,56(r1)
	lwz     r31,60(r1)
	lwz     r13,64(r1)
	lwz     r14,68(r1)
	lwz     r15,72(r1)
	addi    r1,r1,76
 
.Lcopyrest:
	srwi.   r0,r5,2 
	mtctr   r0 
	beq     .Llastbytes

.Lcopywords:    
	lwzu    r0,4(r4)                        /* we copy remaining words (0-7) */ 
	stwu    r0,4(r6)    
	bdnz    .Lcopywords 

.Llastbytes: 
	andi.   r0,r5,3 
	mtctr   r0 
	beq+    .Lend

.Lcopybytes:    
	lbz     r0,4(r4)                        /* we copy remaining bytes (0-3)  */ 
	stb     r0,4(r6) 
	addi    r4,r4,1 
	addi    r6,r6,1 
	bdnz    .Lcopybytes 

.Lend:  /* done : return 0 for Linux / DST for glibc*/ 
	mr      r3, r7
	blr 

--Boundary-00=_878vIQknB0tHGzJ
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="memcpyspeed.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="memcpyspeed.c"

#include <stdio.h>
#include <sys/mman.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

// #define VIDEO_MMAP
// #define TEST_UNALIGNED

static void *srcpool;
static void *dstpool;

unsigned int sizes[] = {5,      16,    100,   256,  1000, 16384, 1048576};
unsigned int nums[] =  {100000, 50000, 10000, 5000, 1000, 50,    1};

#define TESTRUNS 10

unsigned int memtest(int size, int num, int srcaligned, int dstaligned)
{
	struct timeval tv0, tv1;
	unsigned char *src=(unsigned char *)srcpool, *dst=(unsigned char *)dstpool;
	unsigned char *sp, *dp;
	unsigned int t,i;
	long int usecs;
	unsigned long int secs;
	
	/* Get src and dst 32-byte aligned */
	src = (unsigned char *)((unsigned int)(src+31) & 0xffffffe0);
	dst = (unsigned char *)((unsigned int)(dst+31) & 0xffffffe0);
	
	/* Now unalign them if desired (some random offset) */
	if(!srcaligned)
		src += 11;
	if(!dstaligned)
		dst += 13;
	
	/* "Train" the system (caches, paging, etc...) */
	sp = src;
	dp = dst;
	for(i=0; i<num; i++) {
		memcpy(dp, sp, size);
		sp += size;
		dp += size;
	}
	
	/* Start measurement */
	gettimeofday(&tv0, NULL);
	for(t=0; t<TESTRUNS; t++) {
		sp = src;
		dp = dst;
		for(i=0; i<num; i++) {
			memcpy(dp, sp, size);
			sp += size;
			dp += size;
		}
	}
	gettimeofday(&tv1, NULL);
	secs = tv1.tv_sec-tv0.tv_sec;
	usecs = tv1.tv_usec-tv0.tv_usec;
	if(usecs<0) {
		usecs += 1000000;
		secs -= 1;
	}
	return usecs+1000000L*secs;
}

unsigned int memverify(int size, int num, int srcaligned, int dstaligned)
{
	unsigned char *src=(unsigned char *)srcpool, *dst=(unsigned char *)dstpool;
	
	/* Get src and dst 32-byte aligned */
	src = (unsigned char *)((unsigned int)(src+31) & 0xffffffe0);
	dst = (unsigned char *)((unsigned int)(dst+31) & 0xffffffe0);
	
	/* Now unalign them if desired (some random offset) */
	if(!srcaligned)
		src += 11;
	if(!dstaligned)
		dst += 13;
	
	return memcmp(dst, src, size*num);
}


void evaluate(char *name, unsigned int totalsize, unsigned int usecs)
{
	double rate;
	
	rate = (double)totalsize*(double)TESTRUNS/((double)usecs/1000000.0);
	rate /= (1024.0*1024.0);
	printf("Memcpy %-30s: %5.3g Mbyte/s (memory throughput: %5.3g Mbytes/s)\n",name, rate, rate*2.0);
}

int main(void)
{
	int t,i;
	unsigned int usecs;
	char buf[50];
	struct timeval tv;
#ifdef VIDEO_MMAP
	unsigned long int *mem;
	int f;
	
	printf("Opening fb0\n");
	f = open("/dev/fb0", O_RDWR);
	if(f<0) {
		perror("opening fb0");
		return 1;
	}
	printf("mmapping fb0\n");
	
	mem = mmap(NULL, 0x00300000, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED,f,0);
	
	printf("mmap returned: %08x\n",(unsigned int)mem);
	perror("mmap");
	if(mem==-1)
		return 1;
#else
	unsigned long int mem[786432];
#endif
	
	srcpool = (unsigned char *)mem;
	dstpool = (unsigned char *)mem;
	dstpool += 1572864; /* 1.5 Mbyte offset into 3 Mbyte framebuffer */
	
	gettimeofday(&tv, NULL);
	for(t=0; t<0x000c0000; t++)
		mem[t] = (tv.tv_usec ^ tv.tv_sec) ^ t;

	printf("Fully aligned:\n");	
	for(t=0; t<(sizeof(nums)/sizeof(nums[0])); t++) {
		snprintf(buf, 50, "%d chunks of %d bytes", nums[t], sizes[t]);
		usecs = memtest(sizes[t], nums[t], 1, 1);
		evaluate(buf, nums[t]*sizes[t], usecs);
		if(memverify(sizes[t], nums[t], 1, 1)) {
			printf("Verify faild!\n");
		}
	}
#ifdef TEST_UNALIGNED
	printf("source unaligned:\n");	
	for(t=0; t<(sizeof(nums)/sizeof(nums[0])); t++) {
		snprintf(buf, 50, "%d chunks of %d bytes", nums[t], sizes[t]);
		usecs = memtest(sizes[t], nums[t], 0, 1);
		evaluate(buf, nums[t]*sizes[t], usecs);
	}
	
	printf("destination unaligned:\n");	
	for(t=0; t<(sizeof(nums)/sizeof(nums[0])); t++) {
		snprintf(buf, 50, "%d chunks of %d bytes", nums[t], sizes[t]);
		usecs = memtest(sizes[t], nums[t], 1, 0);
		evaluate(buf, nums[t]*sizes[t], usecs);
	}
	
	printf("both unaligned:\n");	
	for(t=0; t<(sizeof(nums)/sizeof(nums[0])); t++) {
		snprintf(buf, 50, "%d chunks of %d bytes", nums[t], sizes[t]);
		usecs = memtest(sizes[t], nums[t], 0, 0);
		evaluate(buf, nums[t]*sizes[t], usecs);
	}
#endif	
	return 0;
}

--Boundary-00=_878vIQknB0tHGzJ--
