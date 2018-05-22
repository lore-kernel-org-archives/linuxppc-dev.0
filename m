Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r0rz2HTDzDqlh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 02:06:59 +1000 (AEST)
Message-Id: <05bd657afedaf4a0de5abab0c5db2e88fa73bdfe.1527004752.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527004752.git.christophe.leroy@c-s.fr>
References: <cover.1527004752.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/lib: optimise PPC32 memcmp
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 May 2018 18:06:55 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the time being, memcmp() compares two chunks of memory
byte per byte.

This patch optimises the comparison by comparing word by word.

A small benchmark performed on an 8xx comparing two chuncks
of 512 bytes performed 100000 times gives:

Before : 5852274 TB ticks
After:   1488638 TB ticks

This is almost 4 times faster

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/string_32.S | 47 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index 40a576d56ac7..d83b7d996f61 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -18,16 +18,49 @@
 _GLOBAL(memcmp)
 	cmpwi	cr0, r5, 0
 	beq-	2f
-	mtctr	r5
-	addi	r6,r3,-1
-	addi	r4,r4,-1
-1:	lbzu	r3,1(r6)
-	lbzu	r0,1(r4)
-	subf.	r3,r0,r3
-	bdnzt	2,1b
+	srawi.	r7, r5, 2		/* Divide len by 4 */
+	mr	r6, r3
+	beq-	3f
+	mtctr	r7
+	li	r7, 0
+1:
+#ifdef __LITTLE_ENDIAN__
+	lwbrx	r3, r6, r7
+	lwbrx	r0, r4, r7
+#else
+	lwzx	r3, r6, r7
+	lwzx	r0, r4, r7
+#endif
+	addi	r7, r7, 4
+	cmpl	cr0, r3, r0
+	bdnzt	eq, 1b
+	bne	5f
+	andi.	r5, r5, 3
+	li	r3, 0
+	beqlr
+3:	cmplwi	cr1, r5, 2
+	blt-	cr1, 4f
+#ifdef __LITTLE_ENDIAN__
+	lhbrx	r3, r6, r7
+	lhbrx	r0, r4, r7
+#else
+	lhzx	r3, r6, r7
+	lhzx	r0, r4, r7
+#endif
+	addi	r7, r7, 2
+	subf.	r3, r0, r3
+	beqlr	cr1
+	bnelr
+4:	lbzx	r3, r6, r7
+	lbzx	r0, r4, r7
+	subf.	r3, r0, r3
 	blr
 2:	li	r3,0
 	blr
+5:	li	r3, 1
+	bgtlr
+	li	r3, -1
+	blr
 EXPORT_SYMBOL(memcmp)
 
 CACHELINE_BYTES = L1_CACHE_BYTES
-- 
2.13.3
