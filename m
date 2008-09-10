Return-Path: <jschopp@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0027DDF5D
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 06:15:45 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8AKIAwq023117
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 16:18:10 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8AKFO0h198042
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 16:15:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8AKFORX024566
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 16:15:24 -0400
Date: Wed, 10 Sep 2008 15:15:23 -0500 (CDT)
From: jschopp@austin.ibm.com
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC] 64 bit csum_partial_copy_generic
Message-ID: <alpine.LFD.1.10.0809101502580.14991@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current 64 bit csum_partial_copy_generic function is based on the 32 
bit version and never was optimized for 64 bit.  This patch takes the 64 bit 
memcpy and adapts it to also do the sum.  It has been tested on a variety 
of input sizes and alignments on Power5 and Power6 processors.  It gives 
correct output for all cases tested.  It also runs 20-55% faster 
than the implemention it replaces depending on size, alignment, and processor.

I think there is still some room for improvement in the unaligned case, 
but given that it is much faster than what we have now I figured I'd send 
it out.

Signed-off-by: Joel Schopp<jschopp@austin.ibm.com>

Index: 2.6.26/arch/powerpc/lib/checksum_64.S
===================================================================
--- 2.6.26.orig/arch/powerpc/lib/checksum_64.S
+++ 2.6.26/arch/powerpc/lib/checksum_64.S
@@ -22,8 +22,7 @@
   * len is in words and is always >= 5.
   *
   * In practice len == 5, but this is not guaranteed.  So this code does not
- * attempt to use doubleword instructions.
- */
+ * attempt to use doubleword instructions. */
  _GLOBAL(ip_fast_csum)
  	lwz	r0,0(r3)
  	lwzu	r5,4(r3)
@@ -122,108 +121,286 @@ _GLOBAL(csum_partial)
   * to *src_err or *dst_err respectively, and (for an error on
   * src) zeroes the rest of dst.
   *
- * This code needs to be reworked to take advantage of 64 bit sum+copy.
- * However, due to tokenring halfword alignment problems this will be very
- * tricky.  For now we'll leave it until we instrument it somehow.
+ * This returns a 32 bit 1s complement sum that can be folded to 16 bits and
+ * notted to produce a 16bit tcp/ip checksum.
   *
   * csum_partial_copy_generic(r3=src, r4=dst, r5=len, r6=sum, r7=src_err, r8=dst_err)
   */
  _GLOBAL(csum_partial_copy_generic)
-	addic	r0,r6,0
-	subi	r3,r3,4
-	subi	r4,r4,4
-	srwi.	r6,r5,2
-	beq	3f		/* if we're doing < 4 bytes */
-	andi.	r9,r4,2		/* Align dst to longword boundary */
-	beq+	1f
-81:	lhz	r6,4(r3)	/* do 2 bytes to get aligned */
-	addi	r3,r3,2
-	subi	r5,r5,2
-91:	sth	r6,4(r4)
-	addi	r4,r4,2
-	addc	r0,r0,r6
-	srwi.	r6,r5,2		/* # words to do */
+	std	r7,48(r1)	/* we need to save the error pointers ...*/
+	std	r8,56(r1)	/* we need to save the error pointers ...*/
+	PPC_MTOCRF	0x01,r5
+	cmpldi	cr1,r5,16
+	neg	r11,r4		# LS 3 bits = # bytes to 8-byte dest bdry
+	andi.	r11,r11,7
+	dcbt	0,r3
+	blt	cr1,.Lshort_copy
+	bne	.Ldst_unaligned
+.Ldst_aligned:
+	andi.	r0,r3,7
+	addi	r4,r4,-16
+	bne	.Lsrc_unaligned
+	srdi	r10,r5,4		/* src and dst aligned */
+80:	ld	r9,0(r3)
+	addi	r3,r3,-8
+	mtctr	r10
+	andi.	r5,r5,7
+	bf	cr7*4+0,2f
+	addi	r4,r4,8
+	addi	r3,r3,8
+	mr	r12,r9
+	blt	cr1,3f
+1:
+81:	ld	r9,8(r3)
+82:	std	r12,8(r4)
+	adde	r6,r6,r12 	/* add to checksum */
+2:
+83:	ldu	r12,16(r3)
+84:	stdu	r9,16(r4)
+	adde	r6,r6,r9 	/* add to checksum */
+	bdnz	1b
+3:
+85:	std	r12,8(r4)
+	adde	r6,r6,r12 	/* add to checksum */
  	beq	3f
-1:	mtctr	r6
-82:	lwzu	r6,4(r3)	/* the bdnz has zero overhead, so it should */
-92:	stwu	r6,4(r4)	/* be unnecessary to unroll this loop */
-	adde	r0,r0,r6
-	bdnz	82b
-	andi.	r5,r5,3
-3:	cmpwi	0,r5,2
-	blt+	4f
-83:	lhz	r6,4(r3)
+	addi	r4,r4,16
+	ld	r9,8(r3)
+.Ldo_tail:
+	bf	cr7*4+1,1f
+	rotldi	r9,r9,32
+86:	stw	r9,0(r4)
+	adde	r6,r6,r9 	/* add to checksum */
+	addi	r4,r4,4
+1:	bf	cr7*4+2,2f
+	rotldi	r9,r9,16
+87:	sth	r9,0(r4)
+	adde	r6,r6,r9 	/* add to checksum */
+	addi	r4,r4,2
+2:	bf	cr7*4+3,3f
+	rotldi	r9,r9,8
+88:	stb	r9,0(r4)
+	adde	r6,r6,r9 	/* add to checksum */
+3:	addze	r6,r6		/* add in final carry (unlikely with 64-bit regs) */
+        rldicl  r9,r6,32,0    /* fold 64 bit value */
+        add     r3,r9,r6
+        srdi    r3,r3,32
+	blr			/* return sum */
+
+.Lsrc_unaligned:
+	srdi	r11,r5,3
+	addi	r5,r5,-16
+	subf	r3,r0,r3
+	srdi	r7,r5,4
+	sldi	r10,r0,3
+	cmpdi	cr6,r11,3
+	andi.	r5,r5,7
+	mtctr	r7
+	subfic	r12,r10,64
+	add	r5,r5,r0
+
+	bt	cr7*4+0,0f
+
+115:	ld	r9,0(r3)	# 3+2n loads, 2+2n stores
+116:	ld	r0,8(r3)
+	sld	r11,r9,r10
+117:	ldu	r9,16(r3)
+	srd	r7,r0,r12
+	sld	r8,r0,r10
+	or	r7,r7,r11
+	blt	cr6,4f
+118:	ld	r0,8(r3)
+	# s1<< in r8, d0=(s0<<|s1>>) in r7, s3 in r0, s2 in r9, nix in r11 & r12
+	b	2f
+
+0:
+113:	ld	r0,0(r3)	# 4+2n loads, 3+2n stores
+114:	ldu	r9,8(r3)
+	sld	r8,r0,r10
+	addi	r4,r4,-8
+	blt	cr6,5f
+119:	ld	r0,8(r3)
+	mr	r7,r12		/* need more registers */
+	srd	r12,r9,r12
+	sld	r11,r9,r10
+120:	ldu	r9,16(r3)
+	or	r12,r8,r12
+	srd	r7,r0,r7	/* lost value but can recreate from r10 */
+	sld	r8,r0,r10
+	addi	r4,r4,16
+	beq	cr6,3f
+
+	# d0=(s0<<|s1>>) in r12, s1<< in r11, s2>> in r7, s2<< in r8, s3 in r9
+1:	or	r7,r7,r11
+89:	ld	r0,8(r3)
+90:	std	r12,8(r4)
+	adde	r6,r6,r12 	/* add to checksum */
+2:	subfic	r12,r10,64	/* recreate value from r10 */
+	srd	r12,r9,r12
+	sld	r11,r9,r10
+91:	ldu	r9,16(r3)
+	or	r12,r8,r12
+92:	stdu	r7,16(r4)
+	adde	r6,r6,r7 	/* add to checksum */
+	subfic	r7,r10,64	/* recreate value from r10 */
+	srd	r7,r0,r7
+	sld	r8,r0,r10
+	bdnz	1b
+
+3:
+93:	std	r12,8(r4)
+	adde	r6,r6,r12 	/* add to checksum */
+	or	r7,r7,r11
+4:
+94:	std	r7,16(r4)
+	adde	r6,r6,r7 	/* add to checksum */
+5:	subfic	r12,r10,64	/* recreate value from r10 */
+	srd	r12,r9,r12
+	or	r12,r8,r12
+95:	std	r12,24(r4)
+	adde	r6,r6,r12 	/* add to checksum */
+	beq	4f
+	cmpwi	cr1,r5,8
+	addi	r4,r4,32
+	sld	r9,r9,r10
+	ble	cr1,.Ldo_tail
+96:	ld	r0,8(r3)
+	srd	r7,r0,r12
+	or	r9,r7,r9
+	b	.Ldo_tail
+
+.Ldst_unaligned:
+	PPC_MTOCRF	0x01,r11		# put #bytes to 8B bdry into cr7
+	subf	r5,r11,r5
+	li	r10,0
+	cmpldi	r1,r5,16
+	bf	cr7*4+3,1f
+97:	lbz	r0,0(r3)
+98:	stb	r0,0(r4)
+	adde	r6,r6,r0 	/* add to checksum */
+	addi	r10,r10,1
+1:	bf	cr7*4+2,2f
+99:	lhzx	r0,r10,r3
+100:	sthx	r0,r10,r4
+	adde	r6,r6,r0 	/* add to checksum */
+	addi	r10,r10,2
+2:	bf	cr7*4+1,3f
+101:	lwzx	r0,r10,r3
+102:	stwx	r0,r10,r4
+	adde	r6,r6,r0 	/* add to checksum */
+3:	PPC_MTOCRF	0x01,r5
+	add	r3,r11,r3
+	add	r4,r11,r4
+	b	.Ldst_aligned
+
+.Lshort_copy:
+	bf	cr7*4+0,1f
+103:	lwz	r0,0(r3)
+104:	lwz	r9,4(r3)
+  	addi	r3,r3,8
+105:	stw	r0,0(r4)
+106:	stw	r9,4(r4)
+	adde	r6,r6,r0
+	adde	r6,r6,r9
+	addi	r4,r4,8
+1:	bf	cr7*4+1,2f
+107:	lwz	r0,0(r3)
+	addi	r3,r3,4
+108:	stw	r0,0(r4)
+	adde	r6,r6,r0
+	addi	r4,r4,4
+2:	bf	cr7*4+2,3f
+109:	lhz	r0,0(r3)
  	addi	r3,r3,2
-	subi	r5,r5,2
-93:	sth	r6,4(r4)
+110:	sth	r0,0(r4)
+	adde	r6,r6,r0
  	addi	r4,r4,2
-	adde	r0,r0,r6
-4:	cmpwi	0,r5,1
-	bne+	5f
-84:	lbz	r6,4(r3)
-94:	stb	r6,4(r4)
-	slwi	r6,r6,8		/* Upper byte of word */
-	adde	r0,r0,r6
-5:	addze	r3,r0		/* add in final carry (unlikely with 64-bit regs) */
-        rldicl  r4,r3,32,0      /* fold 64 bit value */
-        add     r3,r4,r3
+3:	bf	cr7*4+3,4f
+111:	lbz	r0,0(r3)
+112:	stb	r0,0(r4)
+	adde	r6,r6,r0
+4:	addze	r6,r6		/* add in final carry (unlikely with 64-bit regs) */
+        rldicl  r9,r6,32,0    /* fold 64 bit value */
+        add     r3,r9,r6
          srdi    r3,r3,32
-	blr
+	blr			/* return dest pointer */

  /* These shouldn't go in the fixup section, since that would
     cause the ex_table addresses to get out of order. */

-	.globl src_error_1
-src_error_1:
-	li	r6,0
-	subi	r5,r5,2
-95:	sth	r6,4(r4)
-	addi	r4,r4,2
-	srwi.	r6,r5,2
-	beq	3f
-	mtctr	r6
-	.globl src_error_2
-src_error_2:
-	li	r6,0
-96:	stwu	r6,4(r4)
-	bdnz	96b
-3:	andi.	r5,r5,3
-	beq	src_error
-	.globl src_error_3
-src_error_3:
-	li	r6,0
-	mtctr	r5
-	addi	r4,r4,3
-97:	stbu	r6,1(r4)
-	bdnz	97b
+/* Load store exception handlers */
  	.globl src_error
  src_error:
-	cmpdi	0,r7,0
+	ld	r7,48(r1)	/* restore src_error */
+
+	li	r11,0
+	mtctr	r5		/* Non-optimized zero out we will hopefully...*/
+113:	stbu	r11,1(r4)		/* never hit. */
+	bdnz	113b
+	cmpdi	0,r7,0		/* if it isn't NULL write EFAULT into it */
  	beq	1f
-	li	r6,-EFAULT
-	stw	r6,0(r7)
-1:	addze	r3,r0
+	li	r11,-EFAULT
+	stw	r11,0(r7)
+1:	addze	r3,r6		/* add any carry */
  	blr

  	.globl dst_error
  dst_error:
+	ld	r8,56(r1)	/* restore dst_error */
  	cmpdi	0,r8,0
  	beq	1f
-	li	r6,-EFAULT
-	stw	r6,0(r8)
-1:	addze	r3,r0
+	li	r11,-EFAULT
+	stw	r11,0(r8)
+1:	addze	r3,r6		/* add any carry */
  	blr

+	.globl dst_error
+
  .section __ex_table,"a"
  	.align  3
-	.llong	81b,src_error_1
-	.llong	91b,dst_error
-	.llong	82b,src_error_2
-	.llong	92b,dst_error
-	.llong	83b,src_error_3
-	.llong	93b,dst_error
-	.llong	84b,src_error_3
-	.llong	94b,dst_error
-	.llong	95b,dst_error
-	.llong	96b,dst_error
-	.llong	97b,dst_error
+	/* labels 80-120 are for load/stores that we have
+	 * to catch exceptions and handle them
+	 */
+	/*
+
+	*/
+	.llong	80b,src_error
+	.llong	81b,src_error
+	.llong  82b,dst_error
+	.llong	83b,src_error
+	.llong  84b,dst_error
+	.llong  85b,dst_error
+	.llong  86b,dst_error
+	.llong  87b,dst_error
+	.llong  88b,dst_error
+	.llong	115b,src_error
+	.llong	116b,src_error
+	.llong	117b,src_error
+	.llong	118b,src_error
+	.llong	113b,src_error
+	.llong	114b,src_error
+	.llong	119b,src_error
+	.llong	120b,src_error
+	.llong  90b,dst_error
+	.llong	91b,src_error
+	.llong  92b,dst_error
+	.llong  93b,dst_error
+	.llong  94b,dst_error
+	.llong  95b,dst_error
+	.llong	96b,src_error
+	.llong	97b,src_error
+	.llong  98b,dst_error
+	.llong	99b,src_error
+	.llong  100b,dst_error
+	.llong	101b,src_error
+	.llong  102b,dst_error
+	.llong	103b,src_error
+	.llong	104b,src_error
+	.llong  105b,dst_error
+	.llong  106b,dst_error
+	.llong	107b,src_error
+	.llong  108b,dst_error
+	.llong	109b,src_error
+	.llong  110b,dst_error
+	.llong	111b,src_error
+	.llong  112b,dst_error
+	.llong  113b,dst_error
