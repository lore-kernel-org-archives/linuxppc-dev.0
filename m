Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id C2DEE1A0611
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:08:04 +1000 (AEST)
Message-Id: <03c91aab870552988dffd331ac332c9e6c9aa343.1432012060.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1432012060.git.christophe.leroy@c-s.fr>
References: <cover.1432012060.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 4/6] powerpc32: Merge the new memset() with the old one
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 12:07:52 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cacheable_memzero() which has become the new memset() and the old
memset() are quite similar, so just merge them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 0b4f954..9262071 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -75,8 +75,9 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
  * area is cacheable.  -- paulus
  */
 _GLOBAL(memset)
-	cmplwi	r4,0
-	bne-	generic_memset
+	rlwimi	r4,r4,8,16,23
+	rlwimi	r4,r4,16,0,15
+
 	addi	r6,r3,-4
 	cmplwi	0,r5,4
 	blt	7f
@@ -85,6 +86,9 @@ _GLOBAL(memset)
 	andi.	r0,r6,3
 	add	r5,r0,r5
 	subf	r6,r0,r6
+	cmplwi	0,r4,0
+	bne	2f	/* Use normal procedure if r4 is not zero */
+
 	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
 	add	r8,r7,r5
 	srwi	r9,r8,LG_CACHELINE_BYTES
@@ -103,32 +107,8 @@ _GLOBAL(memset)
 	bdnz	10b
 	clrlwi	r5,r8,32-LG_CACHELINE_BYTES
 	addi	r5,r5,4
-2:	srwi	r0,r5,2
-	mtctr	r0
-	bdz	6f
-1:	stwu	r4,4(r6)
-	bdnz	1b
-6:	andi.	r5,r5,3
-7:	cmpwi	0,r5,0
-	beqlr
-	mtctr	r5
-	addi	r6,r6,3
-8:	stbu	r4,1(r6)
-	bdnz	8b
-	blr
 
-_GLOBAL(generic_memset)
-	rlwimi	r4,r4,8,16,23
-	rlwimi	r4,r4,16,0,15
-	addi	r6,r3,-4
-	cmplwi	0,r5,4
-	blt	7f
-	stwu	r4,4(r6)
-	beqlr
-	andi.	r0,r6,3
-	add	r5,r0,r5
-	subf	r6,r0,r6
-	srwi	r0,r5,2
+2:	srwi	r0,r5,2
 	mtctr	r0
 	bdz	6f
 1:	stwu	r4,4(r6)
-- 
2.1.0
