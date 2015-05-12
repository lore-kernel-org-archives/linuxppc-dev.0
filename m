Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 3AAB71A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 23:32:54 +1000 (AEST)
Message-Id: <7db3a8b1c7f9471b651345e5c391398166ca2a06.1431436210.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1431436210.git.christophe.leroy@c-s.fr>
References: <cover.1431436210.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/4] powerpc32: swap r4 and r5 in cacheable_memzero
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 12 May 2015 15:32:52 +0200 (CEST)
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

We swap r4 and r5, this avoids having to move the len contained in r4
into r5

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 55f19f9..cbca76c 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -75,18 +75,17 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
  * area is cacheable.  -- paulus
  */
 _GLOBAL(cacheable_memzero)
-	mr	r5,r4
-	li	r4,0
+	li	r5,0
 	addi	r6,r3,-4
-	cmplwi	0,r5,4
+	cmplwi	0,r4,4
 	blt	7f
-	stwu	r4,4(r6)
+	stwu	r5,4(r6)
 	beqlr
 	andi.	r0,r6,3
-	add	r5,r0,r5
+	add	r4,r0,r4
 	subf	r6,r0,r6
 	clrlwi	r7,r6,32-LG_CACHELINE_BYTES
-	add	r8,r7,r5
+	add	r8,r7,r4
 	srwi	r9,r8,LG_CACHELINE_BYTES
 	addic.	r9,r9,-1	/* total number of complete cachelines */
 	ble	2f
@@ -94,26 +93,26 @@ _GLOBAL(cacheable_memzero)
 	srwi.	r0,r0,2
 	beq	3f
 	mtctr	r0
-4:	stwu	r4,4(r6)
+4:	stwu	r5,4(r6)
 	bdnz	4b
 3:	mtctr	r9
 	li	r7,4
 10:	dcbz	r7,r6
 	addi	r6,r6,CACHELINE_BYTES
 	bdnz	10b
-	clrlwi	r5,r8,32-LG_CACHELINE_BYTES
-	addi	r5,r5,4
-2:	srwi	r0,r5,2
+	clrlwi	r4,r8,32-LG_CACHELINE_BYTES
+	addi	r4,r4,4
+2:	srwi	r0,r4,2
 	mtctr	r0
 	bdz	6f
-1:	stwu	r4,4(r6)
+1:	stwu	r5,4(r6)
 	bdnz	1b
-6:	andi.	r5,r5,3
-7:	cmpwi	0,r5,0
+6:	andi.	r4,r4,3
+7:	cmpwi	0,r4,0
 	beqlr
-	mtctr	r5
+	mtctr	r4
 	addi	r6,r6,3
-8:	stbu	r4,1(r6)
+8:	stbu	r5,1(r6)
 	bdnz	8b
 	blr
 
-- 
2.1.0
