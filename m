Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0147.outbound.protection.outlook.com [157.56.110.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30DB51A0869
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 09:49:59 +1100 (AEDT)
Date: Tue, 24 Mar 2015 17:44:34 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <scottwood@freescale.com>, Joel Stanley <joel@jms.id.au>, Anton Blanchard
 <anton@samba.org>, Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina
 <jkosina@suse.cz>, Ulrich Weigand <ulrich.weigand@de.ibm.com>, "Alexander
 Graf" <agraf@suse.de>, Stewart Smith <stewart@linux.vnet.ibm.com>, "Kyle
 Moffett" <Kyle.D.Moffett@boeing.com>
Subject: [PATCH 3/3] powerpc/e6500: disable POWER7 data cache prefetch and
 implement our own
Message-ID: <20150324174434.248a2f8488c9460e013aa7b4@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER7 has a dedicated stream prefetcher that is pre-programmed via
dcbt rX,rY,0b010?0 instructions in the beginning of vmx_copy.

e6500 has no such prefetcher, so we revert to using regular dcbt
instructions in-loop:

1. at __copy_tofrom_user_power7 entry, we prefetch the first
src and dest lines with dcbt and dcbtst, respectively.

2. if a short (16 bytes or less) copy, don't prefetch any further.

3. else (nonvmx_copy, vmx_copy, unaligned_vmx_copy), we prefetch
LINES_AHEAD number of lines, then, in the inner cacheline-wide
loops, prefetch a line LINES_AHEAD of the current address being
copied, and, finally drop into a tail-end cacheline-wide loop
that doesn't prefetch for the last LINES_AHEAD number of iterations.

LINES_AHEAD has been chosen emperically to be 10 based on generally
best results on an important target benchmark: 1MB netperf TCP_CRR
runs*, relative to a stock 3.19 kernel with FTR_VMX_COPY turned off
for e6500 (i.e., without this patchseries):

                throughput      mean latency
single-thread   27%             21.2%
8-thread        6.08%           5.8%

POWER7/BOOK3S_64 code is left completely immune from these e6500
changes: we don't have a POWER7 to benchmark with.

Lastly, this patch includes some post make copyuser_power7.S 64-byte
cacheline friendly enhancements by removing any register stack saves
for non-128-byte case, and a renumbering of the branch labels.

* specifically: netperf -v 0 -B "-b 8 -D" -H $dest_ip -l 20 -t TCP_CRR -P 0 -- -b 8 -D -r 64,1000000

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/lib/copyuser_power7.S | 254 ++++++++++++++++++++++++++++++++-----
 1 file changed, 221 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 2d22e58..54b70fe 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -14,6 +14,7 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
  * Copyright (C) IBM Corporation, 2011
+ * Copyright Freescale Semiconductor, 2015
  *
  * Author: Anton Blanchard <anton@au.ibm.com>
  */
@@ -63,9 +64,11 @@
 
 
 .Ldo_err4:
+#if L1_CACHE_BYTES >= 128
 	ld	r16,STK_REG(R16)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r14,STK_REG(R14)(r1)
+#endif
 .Ldo_err3:
 	bl	exit_vmx_usercopy
 	ld	r0,STACKFRAMESIZE+16(r1)
@@ -74,6 +77,7 @@
 #endif /* CONFIG_ALTIVEC */
 
 .Ldo_err2:
+#if L1_CACHE_BYTES >= 128
 	ld	r22,STK_REG(R22)(r1)
 	ld	r21,STK_REG(R21)(r1)
 	ld	r20,STK_REG(R20)(r1)
@@ -81,6 +85,7 @@
 	ld	r18,STK_REG(R18)(r1)
 	ld	r17,STK_REG(R17)(r1)
 	ld	r16,STK_REG(R16)(r1)
+#endif
 	ld	r15,STK_REG(R15)(r1)
 	ld	r14,STK_REG(R14)(r1)
 .Lexit:
@@ -93,6 +98,10 @@
 
 
 _GLOBAL(__copy_tofrom_user_power7)
+#ifdef CONFIG_PPC_BOOK3E_64
+	dcbt	0,r4
+	dcbt	0,r3
+#endif
 #ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
@@ -139,12 +148,13 @@ err1;	stw	r0,0(r3)
 
 3:	sub	r5,r5,r6
 	cmpldi	r5,L1_CACHE_BYTES
-	blt	5f
+	blt	9f
 
 	mflr	r0
 	stdu	r1,-STACKFRAMESIZE(r1)
 	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
+#if L1_CACHE_BYTES >= 128
 	std	r16,STK_REG(R16)(r1)
 	std	r17,STK_REG(R17)(r1)
 	std	r18,STK_REG(R18)(r1)
@@ -152,14 +162,43 @@ err1;	stw	r0,0(r3)
 	std	r20,STK_REG(R20)(r1)
 	std	r21,STK_REG(R21)(r1)
 	std	r22,STK_REG(R22)(r1)
+#endif
 	std	r0,STACKFRAMESIZE+16(r1)
 
-	srdi	r6,r5,L1_CACHE_SHIFT
-	mtctr	r6
+#ifdef CONFIG_PPC_BOOK3E_64
+#define LINES_AHEAD 10
+	clrrdi	r6,r4,L1_CACHE_SHIFT
+	clrrdi	r9,r3,L1_CACHE_SHIFT
+	srdi	r7,r5,L1_CACHE_SHIFT	/* length in cachelines,
+					 * capped at LINES_AHEAD
+					 */
+	cmpldi	r7,LINES_AHEAD
+	ble	4f
+	li	r7,LINES_AHEAD
+4:	mtctr	r7
+
+5:	addi	r6,r6,L1_CACHE_BYTES
+	dcbt	0,r6
+	addi	r9,r9,L1_CACHE_BYTES
+	dcbtst	0,r9
+
+	bdnz	5b
+
+	li	r14,LINES_AHEAD*L1_CACHE_BYTES
+#endif
+
+	srdi	r15,r5,L1_CACHE_SHIFT
+#ifdef CONFIG_PPC_BOOK3E_64
+	cmpldi  r15,LINES_AHEAD
+	ble	7f	/* don't prefetch if cachelines <= LINES_AHEAD*/
+	subi    r15,r15,LINES_AHEAD     /* otherwise, r6 <- r6 - LINES_AHEAD*/
+#endif
+
+	mtctr	r15
 
 	/* Now do cacheline sized loads and stores. */
 	.align	5
-4:
+6:
 err2;	ld	r0,0(r4)
 err2;	ld	r6,8(r4)
 err2;	ld	r7,16(r4)
@@ -179,6 +218,9 @@ err2;	ld	r20,112(r4)
 err2;	ld	r21,120(r4)
 #endif
 	addi	r4,r4,L1_CACHE_BYTES
+#ifdef CONFIG_PPC_BOOK3E_64
+	dcbt	r14,r4
+#endif
 err2;	std	r0,0(r3)
 err2;	std	r6,8(r3)
 err2;	std	r7,16(r3)
@@ -198,12 +240,47 @@ err2;	std	r20,112(r3)
 err2;	std	r21,120(r3)
 #endif
 	addi	r3,r3,L1_CACHE_BYTES
-	bdnz	4b
+#ifdef CONFIG_PPC_BOOK3E_64
+	dcbtst	r14,r3
+#endif
+	bdnz	6b
+
+#ifdef CONFIG_PPC_BOOK3E_64
+	srdi	r7,r5,L1_CACHE_SHIFT	/* length in cachelines */
+	subf	r15,r15,r7		/* r6 = r7 - r15 */
+
+7:
+	mtctr	r15
+
+	/* remaining cacheline sized loads and stores, without prefetches. */
+	.align	5
+8:
+err2;	ld	r0,0(r4)
+err2;	ld	r6,8(r4)
+err2;	ld	r7,16(r4)
+err2;	ld	r8,24(r4)
+err2;	ld	r9,32(r4)
+err2;	ld	r10,40(r4)
+err2;	ld	r11,48(r4)
+err2;	ld	r12,56(r4)
+	addi	r4,r4,L1_CACHE_BYTES
+err2;	std	r0,0(r3)
+err2;	std	r6,8(r3)
+err2;	std	r7,16(r3)
+err2;	std	r8,24(r3)
+err2;	std	r9,32(r3)
+err2;	std	r10,40(r3)
+err2;	std	r11,48(r3)
+err2;	std	r12,56(r3)
+	addi	r3,r3,L1_CACHE_BYTES
+	bdnz	8b
+#endif
 
 	clrldi	r5,r5,(64-L1_CACHE_SHIFT)
 
 	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
+#if L1_CACHE_BYTES >= 128
 	ld	r16,STK_REG(R16)(r1)
 	ld	r17,STK_REG(R17)(r1)
 	ld	r18,STK_REG(R18)(r1)
@@ -211,14 +288,15 @@ err2;	std	r21,120(r3)
 	ld	r20,STK_REG(R20)(r1)
 	ld	r21,STK_REG(R21)(r1)
 	ld	r22,STK_REG(R22)(r1)
+#endif
 	addi	r1,r1,STACKFRAMESIZE
 
 	/* Up to L1_CACHE_BYTES - 1 to go */
-5:	srdi	r6,r5,4
+9:	srdi	r6,r5,4
 	mtocrf	0x01,r6
 
 #if L1_CACHE_BYTES >= 128
-6:	bf	cr7*4+1,7f
+10:	bf	cr7*4+1,11f
 err1;	ld	r0,0(r4)
 err1;	ld	r6,8(r4)
 err1;	ld	r7,16(r4)
@@ -240,7 +318,7 @@ err1;	std	r12,56(r3)
 #endif
 
 	/* Up to 63B to go */
-7:	bf	cr7*4+2,8f
+11:	bf	cr7*4+2,12f
 err1;	ld	r0,0(r4)
 err1;	ld	r6,8(r4)
 err1;	ld	r7,16(r4)
@@ -253,7 +331,7 @@ err1;	std	r8,24(r3)
 	addi	r3,r3,32
 
 	/* Up to 31B to go */
-8:	bf	cr7*4+3,9f
+12:	bf	cr7*4+3,13f
 err1;	ld	r0,0(r4)
 err1;	ld	r6,8(r4)
 	addi	r4,r4,16
@@ -261,12 +339,12 @@ err1;	std	r0,0(r3)
 err1;	std	r6,8(r3)
 	addi	r3,r3,16
 
-9:	clrldi	r5,r5,(64-4)
+13:	clrldi	r5,r5,(64-4)
 
 	/* Up to 15B to go */
 .Lshort_copy:
 	mtocrf	0x01,r5
-	bf	cr7*4+0,12f
+	bf	cr7*4+0,14f
 err1;	lwz	r0,0(r4)	/* Less chance of a reject with word ops */
 err1;	lwz	r6,4(r4)
 	addi	r4,r4,8
@@ -274,23 +352,23 @@ err1;	stw	r0,0(r3)
 err1;	stw	r6,4(r3)
 	addi	r3,r3,8
 
-12:	bf	cr7*4+1,13f
+14:	bf	cr7*4+1,15f
 err1;	lwz	r0,0(r4)
 	addi	r4,r4,4
 err1;	stw	r0,0(r3)
 	addi	r3,r3,4
 
-13:	bf	cr7*4+2,14f
+15:	bf	cr7*4+2,16f
 err1;	lhz	r0,0(r4)
 	addi	r4,r4,2
 err1;	sth	r0,0(r3)
 	addi	r3,r3,2
 
-14:	bf	cr7*4+3,15f
+16:	bf	cr7*4+3,17f
 err1;	lbz	r0,0(r4)
 err1;	stb	r0,0(r3)
 
-15:	li	r3,0
+17:	li	r3,0
 	blr
 
 .Lunwind_stack_nonvmx_copy:
@@ -310,6 +388,7 @@ err1;	stb	r0,0(r3)
 	ld	r5,STK_REG(R29)(r1)
 	mtlr	r0
 
+#ifdef CONFIG_PPC_BOOK3S_64
 	/*
 	 * We prefetch both the source and destination using enhanced touch
 	 * instructions. We use a stream ID of 0 for the load side and
@@ -342,6 +421,30 @@ err1;	stb	r0,0(r3)
 	eieio
 	dcbt	r0,r8,0b01010	/* all streams GO */
 .machine pop
+#else
+	/*
+	 * We prefetch both the source and destination using regular touch
+	 * instructions.
+	 */
+	clrrdi	r6,r4,L1_CACHE_SHIFT
+	clrrdi	r9,r3,L1_CACHE_SHIFT
+	srdi	r7,r5,L1_CACHE_SHIFT	/* length in cachelines,
+					 * capped at LINES_AHEAD
+					 */
+	cmpldi	r7,LINES_AHEAD
+	ble	2f
+	li	r7,LINES_AHEAD
+2:	mtctr	r7
+
+3:	addi	r6,r6,L1_CACHE_BYTES
+	dcbt	0,r6
+	addi	r9,r9,L1_CACHE_BYTES
+	dcbtst	0,r9
+
+	bdnz	3b
+
+	li	r8,LINES_AHEAD*L1_CACHE_BYTES
+#endif
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
 
@@ -426,6 +529,14 @@ err3;	stvx	vr0,r3,r11
 7:	sub	r5,r5,r6
 	srdi	r6,r5,L1_CACHE_SHIFT
 
+#ifdef CONFIG_PPC_BOOK3E_64
+	cmpldi	r6,LINES_AHEAD
+	ble	12f	/* don't prefetch if cachelines <= LINES_AHEAD*/
+	subi	r6,r6,LINES_AHEAD	/* otherwise, r6 <- r6 - LINES_AHEAD*/
+	li	r8,LINES_AHEAD*L1_CACHE_BYTES
+#endif
+
+#if L1_CACHE_BYTES >= 128
 	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
@@ -434,6 +545,7 @@ err3;	stvx	vr0,r3,r11
 	li	r14,80
 	li	r15,96
 	li	r16,112
+#endif
 
 	mtctr	r6
 
@@ -454,6 +566,9 @@ err4;	lvx	vr1,r4,r15
 err4;	lvx	vr0,r4,r16
 #endif
 	addi	r4,r4,L1_CACHE_BYTES
+#ifdef CONFIG_PPC_BOOK3E_64
+	dcbt	r8,r4
+#endif
 err4;	stvx	vr7,r0,r3
 err4;	stvx	vr6,r3,r9
 err4;	stvx	vr5,r3,r10
@@ -465,11 +580,39 @@ err4;	stvx	vr1,r3,r15
 err4;	stvx	vr0,r3,r16
 #endif
 	addi	r3,r3,L1_CACHE_BYTES
+#ifdef CONFIG_PPC_BOOK3E_64
+	dcbtst	r8,r3
+#endif
 	bdnz	8b
 
+#ifdef CONFIG_PPC_BOOK3E_64
+	srdi	r7,r5,L1_CACHE_SHIFT	/* length in cachelines */
+	subf	r6,r6,r7		/* r6 = r7 - r6 */
+
+12:
+	mtctr	r6
+
+	/* remaining cacheline sized loads and stores, without prefetches.  */
+	.align	5
+13:
+err4;	lvx	vr7,r0,r4
+err4;	lvx	vr6,r4,r9
+err4;	lvx	vr5,r4,r10
+err4;	lvx	vr4,r4,r11
+	addi	r4,r4,L1_CACHE_BYTES
+err4;	stvx	vr7,r0,r3
+err4;	stvx	vr6,r3,r9
+err4;	stvx	vr5,r3,r10
+err4;	stvx	vr4,r3,r11
+	addi	r3,r3,L1_CACHE_BYTES
+	bdnz	13b
+#endif
+
+#if L1_CACHE_BYTES >= 128
 	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+#endif
 
 	/* Up to L1_CACHE_BYTES - 1 to go */
 	clrldi	r5,r5,(64-L1_CACHE_SHIFT)
@@ -477,7 +620,7 @@ err4;	stvx	vr0,r3,r16
 	mtocrf	0x01,r6
 
 #if L1_CACHE_BYTES >= 128
-	bf	cr7*4+1,9f
+	bf	cr7*4+1,14f
 err3;	lvx	vr3,r0,r4
 err3;	lvx	vr2,r4,r9
 err3;	lvx	vr1,r4,r10
@@ -490,7 +633,7 @@ err3;	stvx	vr0,r3,r11
 	addi	r3,r3,64
 #endif
 
-9:	bf	cr7*4+2,10f
+14:	bf	cr7*4+2,15f
 err3;	lvx	vr1,r0,r4
 err3;	lvx	vr0,r4,r9
 	addi	r4,r4,32
@@ -498,38 +641,38 @@ err3;	stvx	vr1,r0,r3
 err3;	stvx	vr0,r3,r9
 	addi	r3,r3,32
 
-10:	bf	cr7*4+3,11f
+15:	bf	cr7*4+3,16f
 err3;	lvx	vr1,r0,r4
 	addi	r4,r4,16
 err3;	stvx	vr1,r0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
-11:	clrldi	r5,r5,(64-4)
+16:	clrldi	r5,r5,(64-4)
 	mtocrf	0x01,r5
-	bf	cr7*4+0,12f
+	bf	cr7*4+0,17f
 err3;	ld	r0,0(r4)
 	addi	r4,r4,8
 err3;	std	r0,0(r3)
 	addi	r3,r3,8
 
-12:	bf	cr7*4+1,13f
+17:	bf	cr7*4+1,18f
 err3;	lwz	r0,0(r4)
 	addi	r4,r4,4
 err3;	stw	r0,0(r3)
 	addi	r3,r3,4
 
-13:	bf	cr7*4+2,14f
+18:	bf	cr7*4+2,19f
 err3;	lhz	r0,0(r4)
 	addi	r4,r4,2
 err3;	sth	r0,0(r3)
 	addi	r3,r3,2
 
-14:	bf	cr7*4+3,15f
+19:	bf	cr7*4+3,20f
 err3;	lbz	r0,0(r4)
 err3;	stb	r0,0(r3)
 
-15:	addi	r1,r1,STACKFRAMESIZE
+20:	addi	r1,r1,STACKFRAMESIZE
 	b	exit_vmx_usercopy	/* tail call optimise */
 
 .Lvmx_unaligned_copy:
@@ -620,6 +763,14 @@ err3;	stvx	vr11,r3,r11
 7:	sub	r5,r5,r6
 	srdi	r6,r5,L1_CACHE_SHIFT
 
+#ifdef CONFIG_PPC_BOOK3E_64
+	cmpldi  r6,LINES_AHEAD
+	ble     9f            /* don't prefetch if cachelines <= LINES_AHEAD*/
+	subi    r6,r6,LINES_AHEAD     /* otherwise, r6 <- r6 - LINES_AHEAD*/
+	li	r8,LINES_AHEAD*L1_CACHE_BYTES
+#endif
+
+#if L1_CACHE_BYTES >= 128
 	std	r14,STK_REG(R14)(r1)
 	std	r15,STK_REG(R15)(r1)
 	std	r16,STK_REG(R16)(r1)
@@ -628,6 +779,7 @@ err3;	stvx	vr11,r3,r11
 	li	r14,80
 	li	r15,96
 	li	r16,112
+#endif
 
 	mtctr	r6
 
@@ -659,6 +811,9 @@ err4;	lvx	vr0,r4,r16
 	VPERM(vr15,vr1,vr0,vr16)
 #endif
 	addi	r4,r4,L1_CACHE_BYTES
+#ifdef CONFIG_PPC_BOOK3E_64
+	dcbt	r8,r4
+#endif
 err4;	stvx	vr8,r0,r3
 err4;	stvx	vr9,r3,r9
 err4;	stvx	vr10,r3,r10
@@ -670,11 +825,44 @@ err4;	stvx	vr14,r3,r15
 err4;	stvx	vr15,r3,r16
 #endif
 	addi	r3,r3,L1_CACHE_BYTES
+#ifdef CONFIG_PPC_BOOK3E_64
+	dcbtst	r8,r3
+#endif
 	bdnz	8b
 
+#ifdef CONFIG_PPC_BOOK3E_64
+	srdi	r7,r5,L1_CACHE_SHIFT	/* length in cachelines */
+	subf	r6,r6,r7		/* r6 = r7 - r6 */
+
+9:
+	mtctr	r6
+
+	/* remaining cacheline sized loads and stores, without prefetches.  */
+	.align	5
+10:
+err4;	lvx	vr7,r0,r4
+	VPERM(vr8,vr0,vr7,vr16)
+err4;	lvx	vr6,r4,r9
+	VPERM(vr9,vr7,vr6,vr16)
+err4;	lvx	vr5,r4,r10
+	VPERM(vr10,vr6,vr5,vr16)
+err4;	lvx	vr0,r4,r11
+	VPERM(vr11,vr5,vr0,vr16)
+	addi	r4,r4,L1_CACHE_BYTES
+err4;	stvx	vr8,r0,r3
+err4;	stvx	vr9,r3,r9
+err4;	stvx	vr10,r3,r10
+err4;	stvx	vr11,r3,r11
+	addi	r3,r3,L1_CACHE_BYTES
+
+	bdnz	10b
+#endif
+
+#if L1_CACHE_BYTES >= 128
 	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
+#endif
 
 	/* Up to L1_CACHE_BYTES - 1 to go */
 	clrldi	r5,r5,(64-L1_CACHE_SHIFT)
@@ -682,7 +870,7 @@ err4;	stvx	vr15,r3,r16
 	mtocrf	0x01,r6
 
 #if L1_CACHE_BYTES >= 128
-	bf	cr7*4+1,9f
+	bf	cr7*4+1,11f
 err3;	lvx	vr3,r0,r4
 	VPERM(vr8,vr0,vr3,vr16)
 err3;	lvx	vr2,r4,r9
@@ -699,7 +887,7 @@ err3;	stvx	vr11,r3,r11
 	addi	r3,r3,64
 #endif
 
-9:	bf	cr7*4+2,10f
+11:	bf	cr7*4+2,12f
 err3;	lvx	vr1,r0,r4
 	VPERM(vr8,vr0,vr1,vr16)
 err3;	lvx	vr0,r4,r9
@@ -709,7 +897,7 @@ err3;	stvx	vr8,r0,r3
 err3;	stvx	vr9,r3,r9
 	addi	r3,r3,32
 
-10:	bf	cr7*4+3,11f
+12:	bf	cr7*4+3,13f
 err3;	lvx	vr1,r0,r4
 	VPERM(vr8,vr0,vr1,vr16)
 	addi	r4,r4,16
@@ -717,10 +905,10 @@ err3;	stvx	vr8,r0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
-11:	clrldi	r5,r5,(64-4)
+13:	clrldi	r5,r5,(64-4)
 	addi	r4,r4,-16	/* Unwind the +16 load offset */
 	mtocrf	0x01,r5
-	bf	cr7*4+0,12f
+	bf	cr7*4+0,14f
 err3;	lwz	r0,0(r4)	/* Less chance of a reject with word ops */
 err3;	lwz	r6,4(r4)
 	addi	r4,r4,8
@@ -728,22 +916,22 @@ err3;	stw	r0,0(r3)
 err3;	stw	r6,4(r3)
 	addi	r3,r3,8
 
-12:	bf	cr7*4+1,13f
+14:	bf	cr7*4+1,15f
 err3;	lwz	r0,0(r4)
 	addi	r4,r4,4
 err3;	stw	r0,0(r3)
 	addi	r3,r3,4
 
-13:	bf	cr7*4+2,14f
+15:	bf	cr7*4+2,16f
 err3;	lhz	r0,0(r4)
 	addi	r4,r4,2
 err3;	sth	r0,0(r3)
 	addi	r3,r3,2
 
-14:	bf	cr7*4+3,15f
+16:	bf	cr7*4+3,17f
 err3;	lbz	r0,0(r4)
 err3;	stb	r0,0(r3)
 
-15:	addi	r1,r1,STACKFRAMESIZE
+17:	addi	r1,r1,STACKFRAMESIZE
 	b	exit_vmx_usercopy	/* tail call optimise */
 #endif /* CONFIG_ALTIVEC */
-- 
2.3.3
