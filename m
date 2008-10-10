Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18670.62070.659790.67023@drongo.ozlabs.ibm.com>
Date: Fri, 10 Oct 2008 17:13:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: jschopp@austin.ibm.com
Subject: Re: [PATCH/RFC] 64 bit csum_partial_copy_generic
In-Reply-To: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
References: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, fulkgl@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

jschopp@austin.ibm.com writes:

> The current 64 bit csum_partial_copy_generic function is based on the 32 
> bit version and never was optimized for 64 bit.  This patch takes the 64 bit 
> memcpy and adapts it to also do the sum.  It has been tested on a variety 
> of input sizes and alignments on Power5 and Power6 processors.  It gives 
> correct output for all cases tested.  It also runs 20-55% faster 
> than the implemention it replaces depending on size, alignment, and processor.

Thanks for doing this.  A few comments below, but first, can you
clarify what your and George Fulk's roles were in producing this?  I had
the impression George had written the code, and if that's the case,
you need to put a "From: George Fulk <...>" line as the first line of
your mail when you re-send the patch.

Also, the patch was whitespace-damaged.  All lines with an initial
space character had that space turned into two spaces.

> @@ -22,8 +22,7 @@
>    * len is in words and is always >= 5.
>    *
>    * In practice len == 5, but this is not guaranteed.  So this code does not
> - * attempt to use doubleword instructions.
> - */
> + * attempt to use doubleword instructions. */

This looked better the way it was IMHO, and in any case it's unrelated
to the main point of the patch.

> + * This returns a 32 bit 1s complement sum that can be folded to 16 bits and
> + * notted to produce a 16bit tcp/ip checksum.
      ^^^^^^
"complemented"

>   _GLOBAL(csum_partial_copy_generic)
> +	std	r7,48(r1)	/* we need to save the error pointers ...*/
> +	std	r8,56(r1)	/* we need to save the error pointers ...*/
> +	PPC_MTOCRF	0x01,r5
> +	cmpldi	cr1,r5,16
> +	neg	r11,r4		# LS 3 bits = # bytes to 8-byte dest bdry
> +	andi.	r11,r11,7
> +	dcbt	0,r3
> +	blt	cr1,.Lshort_copy
> +	bne	.Ldst_unaligned
> +.Ldst_aligned:
> +	andi.	r0,r3,7
> +	addi	r4,r4,-16
> +	bne	.Lsrc_unaligned
> +	srdi	r10,r5,4		/* src and dst aligned */
> +80:	ld	r9,0(r3)
> +	addi	r3,r3,-8
> +	mtctr	r10
> +	andi.	r5,r5,7
> +	bf	cr7*4+0,2f
> +	addi	r4,r4,8
> +	addi	r3,r3,8
> +	mr	r12,r9
> +	blt	cr1,3f
> +1:
> +81:	ld	r9,8(r3)
> +82:	std	r12,8(r4)
> +	adde	r6,r6,r12 	/* add to checksum */

(I took out the "-" lines to make the new code clearer.)

At this point you're doing an adde, which will add in the current
setting of the carry bit.  However, you haven't done anything to make
sure the carry will be 0 coming into the first iteration of the loop.
That was why the old version started with an "addic r0,r6,0"
instruction - addic affects the carry bit, and adding 0 to something
is guaranteed to have a carry out of 0, so that clears the carry bit.
The caller isn't obligated to make sure the carry bit is clear when
calling this.

> +2:
> +83:	ldu	r12,16(r3)
> +84:	stdu	r9,16(r4)
> +	adde	r6,r6,r9 	/* add to checksum */
> +	bdnz	1b
> +3:
> +85:	std	r12,8(r4)
> +	adde	r6,r6,r12 	/* add to checksum */
>   	beq	3f
> +	addi	r4,r4,16
> +	ld	r9,8(r3)

Why doesn't this ld have a label?  It needs a label so it can be in
the exception table, since it is potentially a load from user memory.

> +.Ldo_tail:
> +	bf	cr7*4+1,1f
> +	rotldi	r9,r9,32
> +86:	stw	r9,0(r4)
> +	adde	r6,r6,r9 	/* add to checksum */

This is wrong; we only want to add in the bottom 32 bits of r9.

> +	addi	r4,r4,4
> +1:	bf	cr7*4+2,2f
> +	rotldi	r9,r9,16
> +87:	sth	r9,0(r4)
> +	adde	r6,r6,r9 	/* add to checksum */

And here we only want to add in the bottom 16 bits of r9.

> +	addi	r4,r4,2
> +2:	bf	cr7*4+3,3f
> +	rotldi	r9,r9,8
> +88:	stb	r9,0(r4)
> +	adde	r6,r6,r9 	/* add to checksum */

And here the bottom 8 bits, but shifted left 8 bits.

> +3:	addze	r6,r6		/* add in final carry (unlikely with 64-bit regs) */

The "unlikely" comment is no longer true, since we're now doing 64-bit
loads and stores.

> +        rldicl  r9,r6,32,0    /* fold 64 bit value */

I realize the rldicl was in the old code, but this would be clearer as
rotldi	r9,r6,32 (which is the same instruction).

> +        add     r3,r9,r6
> +        srdi    r3,r3,32
> +	blr			/* return sum */
> +
> +.Lsrc_unaligned:
> +	srdi	r11,r5,3
> +	addi	r5,r5,-16
> +	subf	r3,r0,r3
> +	srdi	r7,r5,4
> +	sldi	r10,r0,3
> +	cmpdi	cr6,r11,3
> +	andi.	r5,r5,7
> +	mtctr	r7
> +	subfic	r12,r10,64

This will set the carry bit, since r10 is less than 64 here.  Probably
not what we want since we're about to do some addes.

[snip]

> +	# d0=(s0<<|s1>>) in r12, s1<< in r11, s2>> in r7, s2<< in r8, s3 in r9
> +1:	or	r7,r7,r11
> +89:	ld	r0,8(r3)
> +90:	std	r12,8(r4)
> +	adde	r6,r6,r12 	/* add to checksum */
> +2:	subfic	r12,r10,64	/* recreate value from r10 */

Oops, we just trashed the carry bit...

> +	srd	r12,r9,r12
> +	sld	r11,r9,r10
> +91:	ldu	r9,16(r3)
> +	or	r12,r8,r12
> +92:	stdu	r7,16(r4)
> +	adde	r6,r6,r7 	/* add to checksum */
> +	subfic	r7,r10,64	/* recreate value from r10 */

and again...

> +	srd	r7,r0,r7
> +	sld	r8,r0,r10
> +	bdnz	1b
> +
> +3:
> +93:	std	r12,8(r4)
> +	adde	r6,r6,r12 	/* add to checksum */
> +	or	r7,r7,r11
> +4:
> +94:	std	r7,16(r4)
> +	adde	r6,r6,r7 	/* add to checksum */
> +5:	subfic	r12,r10,64	/* recreate value from r10 */

ditto

[snip]

> +.Ldst_unaligned:
> +	PPC_MTOCRF	0x01,r11		# put #bytes to 8B bdry into cr7
> +	subf	r5,r11,r5
> +	li	r10,0
> +	cmpldi	r1,r5,16
> +	bf	cr7*4+3,1f
> +97:	lbz	r0,0(r3)
> +98:	stb	r0,0(r4)
> +	adde	r6,r6,r0 	/* add to checksum */
> +	addi	r10,r10,1

Here we've added in the byte in the wrong position, plus having done
one byte, all the following halfwords/words/doublewords are going to
update the wrong bytes in the checksum.

> +.Lshort_copy:
> +	bf	cr7*4+0,1f
> +103:	lwz	r0,0(r3)
> +104:	lwz	r9,4(r3)
> +  	addi	r3,r3,8
> +105:	stw	r0,0(r4)
> +106:	stw	r9,4(r4)
> +	adde	r6,r6,r0
> +	adde	r6,r6,r9
> +	addi	r4,r4,8
> +1:	bf	cr7*4+1,2f
> +107:	lwz	r0,0(r3)
> +	addi	r3,r3,4
> +108:	stw	r0,0(r4)
> +	adde	r6,r6,r0
> +	addi	r4,r4,4
> +2:	bf	cr7*4+2,3f
> +109:	lhz	r0,0(r3)
>   	addi	r3,r3,2
> +110:	sth	r0,0(r4)
> +	adde	r6,r6,r0
>   	addi	r4,r4,2
> +3:	bf	cr7*4+3,4f
> +111:	lbz	r0,0(r3)
> +112:	stb	r0,0(r4)
> +	adde	r6,r6,r0

Here, again, you need to add in r0 << 8.

> +/* Load store exception handlers */
>   	.globl src_error
>   src_error:
> +	ld	r7,48(r1)	/* restore src_error */
> +
> +	li	r11,0
> +	mtctr	r5		/* Non-optimized zero out we will hopefully...*/
> +113:	stbu	r11,1(r4)		/* never hit. */
> +	bdnz	113b

I'm worried that r4 and r5 won't accurately reflect the tail of the
destination buffer at this point, since you have all the load
exceptions going to the same point (src_error).  If you look at
__copy_tofrom_user, it has different code depending on which load hit
the exception, which works out exactly what needs to be zeroed.

> +	cmpdi	0,r7,0		/* if it isn't NULL write EFAULT into it */
>   	beq	1f
> +	li	r11,-EFAULT
> +	stw	r11,0(r7)
> +1:	addze	r3,r6		/* add any carry */
>   	blr

I'm not sure we need to return a valid checksum at this point, but if
we are going to try to return the checksum that we have computed up to
this point, we should fold it to 32 bits.  Similarly for dst_error.

Paul.
