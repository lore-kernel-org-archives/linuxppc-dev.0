Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 77C81B6FA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 17:12:27 +1000 (EST)
Date: Fri, 17 Jun 2011 09:12:22 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/3] powerpc: POWER7 optimised memcpy using VMX
Message-ID: <20110617071222.GA6878@iram.es>
References: <20110617045358.544896830@samba.org>
	<20110617045421.615463021@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110617045421.615463021@samba.org>
Cc: mikey@neuling.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2011 at 02:54:00PM +1000, Anton Blanchard wrote:
> Implement a POWER7 optimised memcpy using VMX. For large aligned
> copies this new loop is over 10% faster and for large unaligned
> copies it is over 200% faster.
> 
> On POWER7 unaligned stores rarely slow down - they only flush when
> a store crosses a 4KB page boundary. Furthermore this flush is
> handled completely in hardware and should be 20-30 cycles.
> 
> Unaligned loads on the other hand flush much more often - whenever
> crossing a 128 byte cache line, or a 32 byte sector if either sector
> is an L1 miss.
> 
> Considering this information we really want to get the loads aligned
> and not worry about the alignment of the stores. Microbenchmarks
> confirm that this approach is much faster than the current unaligned
> copy loop that uses shifts and rotates to ensure both loads and
> stores are aligned.
> 
> We also want to try and do the stores in cacheline aligned, cacheline
> sized chunks. If the store queue is unable to merge an entire
> cacheline of stores then the L2 cache will have to do a
> read/modify/write. Even worse, we will serialise this with the stores
> in the next iteration of the copy loop since both iterations hit
> the same cacheline.
> 
> Based on this, the new loop does the following things:
> 
> 
> 1 - 127 bytes
> Get the source 8 byte aligned and use 8 byte loads and stores. Pretty
> boring and similar to how the current loop works.
> 
> 128 - 4095 bytes
> Get the source 8 byte aligned and use 8 byte loads and stores,
> 1 cacheline at a time. We aren't doing the stores in cacheline
> aligned chunks so we will potentially serialise once per cacheline.
> Even so it is much better than the loop we have today.
> 
> 4096 - bytes
> If both source and destination have the same alignment get them both
> 16 byte aligned, then get the destination cacheline aligned. Do
> cacheline sized loads and stores using VMX.
> 
> If source and destination do not have the same alignment, we get the
> destination cacheline aligned, and use permute to do aligned loads.
> 
> In both cases the VMX loop should be optimal - we always do aligned
> loads and stores and are always doing stores in cacheline aligned,
> cacheline sized chunks.
> 
> 
> The VMX breakpoint of 4096 bytes was chosen using this microbenchmark:
> 
> http://ozlabs.org/~anton/junkcode/copy_to_user.c
> 
> (Note that the breakpoint analysis was done with the copy_tofrom_user
> version of the loop and using varying sizes and alignments to read(). 
> It's much easier to create a benchmark using read() that can control
> the size and alignment of a kernel copy loop and synchronise it with
> userspace doing optional VMX instructions).
> 
> Since we are using VMX and there is a cost to saving and restoring
> the user VMX state there are two broad cases we need to benchmark:
> 
> - Best case - userspace never uses VMX
> 
> - Worst case - userspace always uses VMX
> 
> In reality a userspace process will sit somewhere between these two
> extremes. Since we need to test both aligned and unaligned copies we
> end up with 4 combinations. The point at which the VMX loop begins to
> win is:
> 
> 0% VMX
> aligned		2048 bytes
> unaligned	2048 bytes
> 
> 100% VMX
> aligned		16384 bytes
> unaligned	8192 bytes
> 
> Considering this is a microbenchmark, the data is hot in cache and
> the VMX loop has better store queue merging properties we set the
> breakpoint to 4096 bytes, a little below the unaligned breakpoints.
> 
> Some future optimisations we can look at:
> 
> - Looking at the perf data, a significant part of the cost when a task
>   is always using VMX is the extra exception we take to restore the
>   VMX state. As such we should do something similar to the x86
>   optimisation that restores FPU state for heavy users. ie:
> 
>         /*
>          * If the task has used fpu the last 5 timeslices, just do a full
>          * restore of the math state immediately to avoid the trap; the
>          * chances of needing FPU soon are obviously high now
>          */
>         preload_fpu = tsk_used_math(next_p) && next_p->fpu_counter > 5;
> 
>   and 
> 
>         /*
>          * fpu_counter contains the number of consecutive context switches
>          * that the FPU is used. If this is over a threshold, the lazy fpu
>          * saving becomes unlazy to save the trap. This is an unsigned char
>          * so that after 256 times the counter wraps and the behavior turns
>          * lazy again; this to deal with bursty apps that only use FPU for
>          * a short time
>          */
> 
> - We could create a paca bit to mirror the VMX enabled MSR bit and check
>   that first, avoiding multiple calls to calling enable_kernel_altivec.
> 
> - We could have two VMX breakpoints, one for when we know the user VMX
>   state is loaded into the registers and one when it isn't. This could
>   be a second bit in the paca so we can calculate the break points quickly.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-powerpc/arch/powerpc/lib/Makefile
> ===================================================================
> --- linux-powerpc.orig/arch/powerpc/lib/Makefile	2011-06-17 08:38:25.786110167 +1000
> +++ linux-powerpc/arch/powerpc/lib/Makefile	2011-06-17 14:05:30.023020417 +1000
> @@ -17,7 +17,7 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
>  obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
>  			   memcpy_64.o usercopy_64.o mem_64.o string.o \
>  			   checksum_wrappers_64.o hweight_64.o \
> -			   copypage_power7.o
> +			   copypage_power7.o memcpy_power7.o
>  obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
>  obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
> Index: linux-powerpc/arch/powerpc/lib/memcpy_64.S
> ===================================================================
> --- linux-powerpc.orig/arch/powerpc/lib/memcpy_64.S	2011-06-17 08:32:33.670110896 +1000
> +++ linux-powerpc/arch/powerpc/lib/memcpy_64.S	2011-06-17 08:38:25.806110507 +1000
> @@ -11,7 +11,11 @@
>  
>  	.align	7
>  _GLOBAL(memcpy)
> +BEGIN_FTR_SECTION
>  	std	r3,48(r1)	/* save destination pointer for return value */
> +FTR_SECTION_ELSE
> +	b	memcpy_power7
> +ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POWER7)
>  	PPC_MTOCRF	0x01,r5
>  	cmpldi	cr1,r5,16
>  	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
> Index: linux-powerpc/arch/powerpc/lib/memcpy_power7.S
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-powerpc/arch/powerpc/lib/memcpy_power7.S	2011-06-17 08:38:25.806110507 +1000
> @@ -0,0 +1,596 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Copyright (C) IBM Corporation, 2011
> + *
> + * Author: Anton Blanchard <anton@au.ibm.com>
> + */
> +#include <asm/ppc_asm.h>
> +
> +#define STACKFRAMESIZE	256
> +#define STK_REG(i)	(112 + ((i)-14)*8)
> +
> +_GLOBAL(memcpy_power7)
> +	cmpldi	r5,16
> +	cmpldi	cr1,r5,4096
> +
> +	std	r3,48(r1)
> +
> +	blt	.Lshort_copy
> +	bgt	cr1,.Lvmx_copy
> +
> +	/* Get the source 8B aligned */
> +	neg	r6,r4
> +	mtocrf	0x01,r6
> +	clrldi	r6,r6,(64-3)
> +
> +	bf	cr7*4+3,1f
> +	lbz	r0,0(r4)
> +	addi	r4,r4,1
> +	stb	r0,0(r3)
> +	addi	r3,r3,1
> +
> +1:	bf	cr7*4+2,2f
> +	lhz	r0,0(r4)
> +	addi	r4,r4,2
> +	sth	r0,0(r3)
> +	addi	r3,r3,2
> +
> +2:	bf	cr7*4+1,3f
> +	lwz	r0,0(r4)
> +	addi	r4,r4,4
> +	stw	r0,0(r3)
> +	addi	r3,r3,4
> +
> +3:	sub	r5,r5,r6
> +	cmpldi	r5,128
> +	blt	5f
> +
> +	stdu	r1,-STACKFRAMESIZE(r1)
> +	std	r14,STK_REG(r14)(r1)
> +	std	r15,STK_REG(r15)(r1)
> +	std	r16,STK_REG(r16)(r1)
> +	std	r17,STK_REG(r17)(r1)
> +	std	r18,STK_REG(r18)(r1)
> +	std	r19,STK_REG(r19)(r1)
> +	std	r20,STK_REG(r20)(r1)
> +	std	r21,STK_REG(r21)(r1)
> +	std	r22,STK_REG(r22)(r1)
> +
> +	srdi	r6,r5,7
> +	mtctr	r6
> +
> +	/* Now do cacheline (128B) sized loads and stores. */
> +	.align	5
> +4:	ld	r0,0(r4)
> +	ld	r6,8(r4)
> +	ld	r7,16(r4)
> +	ld	r8,24(r4)
> +	ld	r9,32(r4)
> +	ld	r10,40(r4)
> +	ld	r11,48(r4)
> +	ld	r12,56(r4)
> +	ld	r14,64(r4)
> +	ld	r15,72(r4)
> +	ld	r16,80(r4)
> +	ld	r17,88(r4)
> +	ld	r18,96(r4)
> +	ld	r19,104(r4)
> +	ld	r20,112(r4)
> +	ld	r21,120(r4)
> +	addi	r4,r4,128
> +	std	r0,0(r3)
> +	std	r6,8(r3)
> +	std	r7,16(r3)
> +	std	r8,24(r3)
> +	std	r9,32(r3)
> +	std	r10,40(r3)
> +	std	r11,48(r3)
> +	std	r12,56(r3)
> +	std	r14,64(r3)
> +	std	r15,72(r3)
> +	std	r16,80(r3)
> +	std	r17,88(r3)
> +	std	r18,96(r3)
> +	std	r19,104(r3)
> +	std	r20,112(r3)
> +	std	r21,120(r3)
> +	addi	r3,r3,128
> +	bdnz	4b
> +
> +	clrldi	r5,r5,(64-7)
> +
> +	ld	r14,STK_REG(r14)(r1)
> +	ld	r15,STK_REG(r15)(r1)
> +	ld	r16,STK_REG(r16)(r1)
> +	ld	r17,STK_REG(r17)(r1)
> +	ld	r18,STK_REG(r18)(r1)
> +	ld	r19,STK_REG(r19)(r1)
> +	ld	r20,STK_REG(r20)(r1)
> +	ld	r21,STK_REG(r21)(r1)
> +	ld	r22,STK_REG(r22)(r1)
> +	addi	r1,r1,STACKFRAMESIZE
> +
> +	/* Up to 127B to go */
> +5:	srdi	r6,r5,4
> +	mtocrf	0x01,r6
> +
> +6:	bf	cr7*4+1,7f
> +	ld	r0,0(r4)
> +	ld	r6,8(r4)
> +	ld	r7,16(r4)
> +	ld	r8,24(r4)
> +	ld	r9,32(r4)
> +	ld	r10,40(r4)
> +	ld	r11,48(r4)
> +	ld	r12,56(r4)
> +	addi	r4,r4,64
> +	std	r0,0(r3)
> +	std	r6,8(r3)
> +	std	r7,16(r3)
> +	std	r8,24(r3)
> +	std	r9,32(r3)
> +	std	r10,40(r3)
> +	std	r11,48(r3)
> +	std	r12,56(r3)
> +	addi	r3,r3,64
> +
> +	/* Up to 63B to go */
> +7:	bf	cr7*4+2,8f
> +	ld	r0,0(r4)
> +	ld	r6,8(r4)
> +	ld	r7,16(r4)
> +	ld	r8,24(r4)
> +	addi	r4,r4,32
> +	std	r0,0(r3)
> +	std	r6,8(r3)
> +	std	r7,16(r3)
> +	std	r8,24(r3)
> +	addi	r3,r3,32
> +
> +	/* Up to 31B to go */
> +8:	bf	cr7*4+3,9f
> +	ld	r0,0(r4)
> +	ld	r6,8(r4)
> +	addi	r4,r4,16
> +	std	r0,0(r3)
> +	std	r6,8(r3)
> +	addi	r3,r3,16
> +
> +9:	clrldi	r5,r5,(64-4)

I fail to see the point of that instruction: after that
you move r5 to cr7 and only test the 4 LSB, so clearing
the higher order bits looks superfluous.

There are other places where I think that you can save
a few instructions, but that one stands out as being
completely useless, unless I miss something really subtle.

And no, I don't have a Power7. I wish I had one, or 3...

BTW: do you have any statistics on the size distribution
of memcpy memcpy_to_from_usr?

My gut feeling is that the intermediate case is the most
important, and the short case the less critical (drowned
in overhead's noise) but that's the kind of things on which
I've often been wrong.

Do you really need to save and restore all the 32 VMX registers 
(1/2 kB) or would it be possible (in a later step) to ony save 
and restore the actually used ones (and no CSR either) ? 

> +
> +	/* Up to 15B to go */
> +.Lshort_copy:
> +	mtocrf	0x01,r5
> +	bf	cr7*4+0,12f
> +	lwz	r0,0(r4)	/* Less chance of a reject with word ops */
> +	lwz	r6,4(r4)
> +	addi	r4,r4,8
> +	stw	r0,0(r3)
> +	stw	r6,4(r3)
> +	addi	r3,r3,8
> +
> +12:	bf	cr7*4+1,13f
> +	lwz	r0,0(r4)
> +	addi	r4,r4,4
> +	stw	r0,0(r3)
> +	addi	r3,r3,4
> +
> +13:	bf	cr7*4+2,14f
> +	lhz	r0,0(r4)
> +	addi	r4,r4,2
> +	sth	r0,0(r3)
> +	addi	r3,r3,2
> +
> +14:	bf	cr7*4+3,15f
> +	lbz	r0,0(r4)
> +	stb	r0,0(r3)
> +
> +15:	ld	r3,48(r1)
> +	blr
> +

	Regards,
	Gabriel
