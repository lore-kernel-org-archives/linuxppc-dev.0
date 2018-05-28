Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vYXV2sBwzDrRS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 20:50:02 +1000 (AEST)
Message-Id: <88c8cc033b4ea364d62d1d8ba811a8f8d56c297d.1527503958.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527503958.git.christophe.leroy@c-s.fr>
References: <cover.1527503958.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 3/3] powerpc/lib: optimise PPC32 memcmp
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 28 May 2018 10:49:58 +0000 (UTC)
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
 arch/powerpc/lib/string_32.S | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
index 40a576d56ac7..4fbaa046aa84 100644
--- a/arch/powerpc/lib/string_32.S
+++ b/arch/powerpc/lib/string_32.S
@@ -16,17 +16,34 @@
 	.text
 
 _GLOBAL(memcmp)
-	cmpwi	cr0, r5, 0
-	beq-	2f
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
+1:	lwzx	r3, r6, r7
+	lwzx	r0, r4, r7
+	addi	r7, r7, 4
+	cmplw	cr0, r3, r0
+	bdnzt	eq, 1b
+	bne	5f
+3:	andi.	r3, r5, 3
+	beqlr
+	cmplwi	cr1, r3, 2
+	blt-	cr1, 4f
+	lhzx	r3, r6, r7
+	lhzx	r0, r4, r7
+	addi	r7, r7, 2
+	subf.	r3, r0, r3
+	beqlr	cr1
+	bnelr
+4:	lbzx	r3, r6, r7
+	lbzx	r0, r4, r7
+	subf.	r3, r0, r3
 	blr
-2:	li	r3,0
+5:	li	r3, 1
+	bgtlr
+	li	r3, -1
 	blr
 EXPORT_SYMBOL(memcmp)
 
-- 
2.13.3
