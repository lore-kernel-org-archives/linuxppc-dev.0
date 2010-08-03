Return-Path: <anton@ozlabs.org>
Date: Tue, 3 Aug 2010 16:08:34 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/3] powerpc: Optimise 64bit csum_partial
Message-ID: <20100803060834.GK29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The main loop of csum_partial runs very slowly on recent POWER CPUs. After some
analysis on both POWER6 and POWER7 I came up with routine below. First we get
the source aligned to a double word, ignoring any odd alignment to keep things
simple. Then we do 64 bytes at a time, with an entry and exit limb of a further
64 bytes. On both POWER6 and POWER7 this should be as fast as we can go since
we are limited by the latency of the adde instructions.

To test this I forced checksumming on over loopback and ran socklib (a
simple TCP benchmark). On a POWER6 575 throughput improved by 11% with
this patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
--

Index: powerpc.git/arch/powerpc/lib/checksum_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/checksum_64.S	2010-08-03 13:32:45.291991557 +1000
+++ powerpc.git/arch/powerpc/lib/checksum_64.S	2010-08-03 15:16:59.600753385 +1000
@@ -65,55 +65,168 @@ _GLOBAL(csum_tcpudp_magic)
 	srwi	r3,r3,16
 	blr
 
+#define STACKFRAMESIZE 256
+#define STK_REG(i)	(112 + ((i)-14)*8)
+
 /*
  * Computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit).
  *
- * This code assumes at least halfword alignment, though the length
- * can be any number of bytes.  The sum is accumulated in r5.
- *
  * csum_partial(r3=buff, r4=len, r5=sum)
  */
 _GLOBAL(csum_partial)
-        subi	r3,r3,8		/* we'll offset by 8 for the loads */
-        srdi.	r6,r4,3         /* divide by 8 for doubleword count */
-        addic   r5,r5,0         /* clear carry */
-        beq	3f              /* if we're doing < 8 bytes */
-        andi.	r0,r3,2         /* aligned on a word boundary already? */
-        beq+	1f
-        lhz     r6,8(r3)        /* do 2 bytes to get aligned */
-        addi    r3,r3,2
-        subi    r4,r4,2
-        addc    r5,r5,r6
-        srdi.   r6,r4,3         /* recompute number of doublewords */
-        beq     3f              /* any left? */
-1:      mtctr   r6
-2:      ldu     r6,8(r3)        /* main sum loop */
-        adde    r5,r5,r6
-        bdnz    2b
-        andi.	r4,r4,7         /* compute bytes left to sum after doublewords */
-3:	cmpwi	0,r4,4		/* is at least a full word left? */
-	blt	4f
-	lwz	r6,8(r3)	/* sum this word */
+	addic	r0,r5,0			/* clear carry */
+
+	srdi.	r6,r4,3			/* less than 8 bytes? */
+	beq	.Lcsum_tail_word
+
+	/*
+	 * If only halfword aligned, align to a double word. Since odd
+	 * aligned addresses should be rare and they would require more
+	 * work to calculate the correct checksum, we ignore that case
+	 * and take the potential slowdown of unaligned loads.
+	 */
+	rldicl. r6,r3,64-1,64-2		/* r6 = (r3 & 0x3) >> 1 */
+	beq	.Lcsum_aligned
+
+	li	r7,4
+	sub	r6,r7,r6
+	mtctr	r6
+
+1:
+	lhz	r6,0(r3)		/* align to doubleword */
+	subi	r4,r4,2
+	addi	r3,r3,2
+	adde	r0,r0,r6
+	bdnz	1b
+
+.Lcsum_aligned:
+	/*
+	 * We unroll the loop such that each iteration is 64 bytes with an
+	 * entry and exit limb of 64 bytes, meaning a minimum size of
+	 * 128 bytes.
+	 */
+	srdi.	r6,r4,7
+	beq	.Lcsum_tail_doublewords		/* len < 128 */
+
+	srdi	r6,r4,6
+	subi	r6,r6,1
+	mtctr	r6
+
+	stdu	r1,-STACKFRAMESIZE(r1)
+	std	r14,STK_REG(r14)(r1)
+	std	r15,STK_REG(r15)(r1)
+	std	r16,STK_REG(r16)(r1)
+
+	ld	r6,0(r3)
+	ld	r9,8(r3)
+
+	ld	r10,16(r3)
+	ld	r11,24(r3)
+
+	/*
+	 * On POWER6 and POWER7 back to back addes take 2 cycles because of
+	 * the XER dependency. This means the fastest this loop can go is
+	 * 16 cycles per iteration. The scheduling of the loop below has
+	 * been shown to hit this on both POWER6 and POWER7.
+	 */
+	.align 5
+2:
+	adde	r0,r0,r6
+	ld	r12,32(r3)
+	ld	r14,40(r3)
+
+	adde	r0,r0,r9
+	ld	r15,48(r3)
+	ld	r16,56(r3)
+	addi	r3,r3,64
+
+	adde	r0,r0,r10
+
+	adde	r0,r0,r11
+
+	adde	r0,r0,r12
+
+	adde	r0,r0,r14
+
+	adde	r0,r0,r15
+	ld	r6,0(r3)
+	ld	r9,8(r3)
+
+	adde	r0,r0,r16
+	ld	r10,16(r3)
+	ld	r11,24(r3)
+	bdnz	2b
+
+
+	adde	r0,r0,r6
+	ld	r12,32(r3)
+	ld	r14,40(r3)
+
+	adde	r0,r0,r9
+	ld	r15,48(r3)
+	ld	r16,56(r3)
+	addi	r3,r3,64
+
+	adde	r0,r0,r10
+	adde	r0,r0,r11
+	adde	r0,r0,r12
+	adde	r0,r0,r14
+	adde	r0,r0,r15
+	adde	r0,r0,r16
+
+	ld	r14,STK_REG(r14)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r16,STK_REG(r16)(r1)
+	addi	r1,r1,STACKFRAMESIZE
+
+	andi.	r4,r4,63
+
+.Lcsum_tail_doublewords:		/* Up to 127 bytes to go */
+	srdi.	r6,r4,3
+	beq	.Lcsum_tail_word
+
+	mtctr	r6
+3:
+	ld	r6,0(r3)
+	addi	r3,r3,8
+	adde	r0,r0,r6
+	bdnz	3b
+
+	andi.	r4,r4,7
+
+.Lcsum_tail_word:			/* Up to 7 bytes to go */
+	srdi.	r6,r4,2
+	beq	.Lcsum_tail_halfword
+
+	lwz	r6,0(r3)
 	addi	r3,r3,4
+	adde	r0,r0,r6
 	subi	r4,r4,4
-	adde	r5,r5,r6
-4:	cmpwi	0,r4,2		/* is at least a halfword left? */
-        blt+	5f
-        lhz     r6,8(r3)        /* sum this halfword */
-        addi    r3,r3,2
-        subi    r4,r4,2
-        adde    r5,r5,r6
-5:	cmpwi	0,r4,1		/* is at least a byte left? */
-        bne+    6f
-        lbz     r6,8(r3)        /* sum this byte */
-        slwi    r6,r6,8         /* this byte is assumed to be the upper byte of a halfword */
-        adde    r5,r5,r6
-6:      addze	r5,r5		/* add in final carry */
-	rldicl  r4,r5,32,0      /* fold two 32-bit halves together */
-        add     r3,r4,r5
-        srdi    r3,r3,32
-        blr
+
+.Lcsum_tail_halfword:			/* Up to 3 bytes to go */
+	srdi.	r6,r4,1
+	beq	.Lcsum_tail_byte
+
+	lhz	r6,0(r3)
+	addi	r3,r3,2
+	adde	r0,r0,r6
+	subi	r4,r4,2
+
+.Lcsum_tail_byte:			/* Up to 1 byte to go */
+	andi.	r6,r4,1
+	beq	.Lcsum_finish
+
+	lbz	r6,0(r3)
+	sldi	r9,r6,8			/* Pad the byte out to 16 bits */
+	adde	r0,r0,r9
+
+.Lcsum_finish:
+	addze	r0,r0			/* add in final carry */
+	rldicl	r4,r0,32,0		/* fold two 32 bit halves together */
+	add	r3,r4,r0
+	srdi	r3,r3,32
+	blr
 
 /*
  * Computes the checksum of a memory block at src, length len,
