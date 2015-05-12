Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id E0B621A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 23:32:52 +1000 (AEST)
Message-Id: <b87a9787efc35a8bd6cd7f73185e9959b84ff84a.1431436210.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1431436210.git.christophe.leroy@c-s.fr>
References: <cover.1431436210.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/4] Partially revert "powerpc: Remove duplicate
 cacheable_memcpy/memzero functions"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 12 May 2015 15:32:49 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This partially reverts
commit 'powerpc: Remove duplicate cacheable_memcpy/memzero functions
("f909a35bdfb7cb350d078a2cf888162eeb20381c")'

Functions cacheable_memcpy/memzero are more efficient than
memcpy/memset as they use the dcbz instruction which avoids refill
of the cacheline with the data that we will overwrite.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 127 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 6813f80..55f19f9 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -69,6 +69,54 @@ CACHELINE_BYTES = L1_CACHE_BYTES
 LG_CACHELINE_BYTES = L1_CACHE_SHIFT
 CACHELINE_MASK = (L1_CACHE_BYTES-1)
 
+/*
+ * Use dcbz on the complete cache lines in the destination
+ * to set them to zero.  This requires that the destination
+ * area is cacheable.  -- paulus
+ */
+_GLOBAL(cacheable_memzero)
+	mr	r5,r4
+	li	r4,0
+	addi	r6,r3,-4
+	cmplwi	0,r5,4
+	blt	7f
+	stwu	r4,4(r6)
+	beqlr
+	andi.	r0,r6,3
+	add	r5,r0,r5
+	subf	r6,r0,r6
+	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
+	add	r8,r7,r5
+	srwi	r9,r8,LG_CACHELINE_BYTES
+	addic.	r9,r9,-1	/* total number of complete cachelines */
+	ble	2f
+	xori	r0,r7,CACHELINE_MASK & ~3
+	srwi.	r0,r0,2
+	beq	3f
+	mtctr	r0
+4:	stwu	r4,4(r6)
+	bdnz	4b
+3:	mtctr	r9
+	li	r7,4
+10:	dcbz	r7,r6
+	addi	r6,r6,CACHELINE_BYTES
+	bdnz	10b
+	clrlwi	r5,r8,32-LG_CACHELINE_BYTES
+	addi	r5,r5,4
+2:	srwi	r0,r5,2
+	mtctr	r0
+	bdz	6f
+1:	stwu	r4,4(r6)
+	bdnz	1b
+6:	andi.	r5,r5,3
+7:	cmpwi	0,r5,0
+	beqlr
+	mtctr	r5
+	addi	r6,r6,3
+8:	stbu	r4,1(r6)
+	bdnz	8b
+	blr
+
 _GLOBAL(memset)
 	rlwimi	r4,r4,8,16,23
 	rlwimi	r4,r4,16,0,15
@@ -94,6 +142,85 @@ _GLOBAL(memset)
 	bdnz	8b
 	blr
 
+/*
+ * This version uses dcbz on the complete cache lines in the
+ * destination area to reduce memory traffic.  This requires that
+ * the destination area is cacheable.
+ * We only use this version if the source and dest don't overlap.
+ * -- paulus.
+ */
+_GLOBAL(cacheable_memcpy)
+	add	r7,r3,r5		/* test if the src & dst overlap */
+	add	r8,r4,r5
+	cmplw	0,r4,r7
+	cmplw	1,r3,r8
+	crand	0,0,4			/* cr0.lt &= cr1.lt */
+	blt	memcpy			/* if regions overlap */
+
+	addi	r4,r4,-4
+	addi	r6,r3,-4
+	neg	r0,r3
+	andi.	r0,r0,CACHELINE_MASK	/* # bytes to start of cache line */
+	beq	58f
+
+	cmplw	0,r5,r0			/* is this more than total to do? */
+	blt	63f			/* if not much to do */
+	andi.	r8,r0,3			/* get it word-aligned first */
+	subf	r5,r0,r5
+	mtctr	r8
+	beq+	61f
+70:	lbz	r9,4(r4)		/* do some bytes */
+	stb	r9,4(r6)
+	addi	r4,r4,1
+	addi	r6,r6,1
+	bdnz	70b
+61:	srwi.	r0,r0,2
+	mtctr	r0
+	beq	58f
+72:	lwzu	r9,4(r4)		/* do some words */
+	stwu	r9,4(r6)
+	bdnz	72b
+
+58:	srwi.	r0,r5,LG_CACHELINE_BYTES /* # complete cachelines */
+	clrlwi	r5,r5,32-LG_CACHELINE_BYTES
+	li	r11,4
+	mtctr	r0
+	beq	63f
+53:
+	dcbz	r11,r6
+	COPY_16_BYTES
+#if L1_CACHE_BYTES >= 32
+	COPY_16_BYTES
+#if L1_CACHE_BYTES >= 64
+	COPY_16_BYTES
+	COPY_16_BYTES
+#if L1_CACHE_BYTES >= 128
+	COPY_16_BYTES
+	COPY_16_BYTES
+	COPY_16_BYTES
+	COPY_16_BYTES
+#endif
+#endif
+#endif
+	bdnz	53b
+
+63:	srwi.	r0,r5,2
+	mtctr	r0
+	beq	64f
+30:	lwzu	r0,4(r4)
+	stwu	r0,4(r6)
+	bdnz	30b
+
+64:	andi.	r0,r5,3
+	mtctr	r0
+	beq+	65f
+40:	lbz	r0,4(r4)
+	stb	r0,4(r6)
+	addi	r4,r4,1
+	addi	r6,r6,1
+	bdnz	40b
+65:	blr
+
 _GLOBAL(memmove)
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
-- 
2.1.0
