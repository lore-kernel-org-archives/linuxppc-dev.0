Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 9932C1A013E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 23:32:57 +1000 (AEST)
Message-Id: <e8710d3c4df90cf59ed790406b74b57ed9dde68b.1431436210.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1431436210.git.christophe.leroy@c-s.fr>
References: <cover.1431436210.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/4] powerpc32: memcpy: use cacheable_memcpy
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 12 May 2015 15:32:56 +0200 (CEST)
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

cacheable_memcpy uses dcbz instruction and is more efficient than
memcpy when the destination is in RAM

This patch renames memcpy as generic_memcpy, and defines memcpy as a
prolog to cacheable_memcpy. This prolog checks if the buffer is
in RAM. If not, it falls back to generic_memcpy()

On MPC885, we get approximatly 7% increase of the transfer rate
on an FTP reception

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index d8a9a86..8f76d49 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -161,13 +161,27 @@ _GLOBAL(generic_memset)
  * We only use this version if the source and dest don't overlap.
  * -- paulus.
  */
+_GLOBAL(memmove)
+	cmplw	0,r3,r4
+	bgt	backwards_memcpy
+	/* fall through */
+
+_GLOBAL(memcpy)
+	cmplwi	r5,L1_CACHE_BYTES
+	blt-	generic_memcpy
+	lis	r8,max_pfn@ha
+	lwz	r8,max_pfn@l(r8)
+	tophys	(r9,r3)
+	srwi	r9,r9,PAGE_SHIFT
+	cmplw	r9,r8
+	bge-	generic_memcpy
 _GLOBAL(cacheable_memcpy)
 	add	r7,r3,r5		/* test if the src & dst overlap */
 	add	r8,r4,r5
 	cmplw	0,r4,r7
 	cmplw	1,r3,r8
 	crand	0,0,4			/* cr0.lt &= cr1.lt */
-	blt	memcpy			/* if regions overlap */
+	blt	generic_memcpy		/* if regions overlap */
 
 	addi	r4,r4,-4
 	addi	r6,r3,-4
@@ -233,12 +247,7 @@ _GLOBAL(cacheable_memcpy)
 	bdnz	40b
 65:	blr
 
-_GLOBAL(memmove)
-	cmplw	0,r3,r4
-	bgt	backwards_memcpy
-	/* fall through */
-
-_GLOBAL(memcpy)
+_GLOBAL(generic_memcpy)
 	srwi.	r7,r5,3
 	addi	r6,r3,-4
 	addi	r4,r4,-4
-- 
2.1.0
