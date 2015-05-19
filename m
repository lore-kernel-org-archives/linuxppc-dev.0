Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id EE5491A0670
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:08:04 +1000 (AEST)
Message-Id: <416155cfefbbf11fc204ea804a7fad64086e0f17.1432012060.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1432012060.git.christophe.leroy@c-s.fr>
References: <cover.1432012060.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 5/6] powerpc32: cacheable_memcpy becomes memcpy
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 12:07:55 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cacheable_memcpy uses dcbz instruction and is more efficient than
memcpy when the destination is in RAM. If the destination is in an
io area, memcpy_toio() is normally used, not memcpy

This patch renames memcpy as generic_memcpy, and renames
cacheable_memcpy as memcpy

On MPC885, we get approximatly 7% increase of the transfer rate
on an FTP reception

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 9262071..1d49c74 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -129,13 +129,18 @@ _GLOBAL(memset)
  * We only use this version if the source and dest don't overlap.
  * -- paulus.
  */
-_GLOBAL(cacheable_memcpy)
+_GLOBAL(memmove)
+	cmplw	0,r3,r4
+	bgt	backwards_memcpy
+	/* fall through */
+
+_GLOBAL(memcpy)
 	add	r7,r3,r5		/* test if the src & dst overlap */
 	add	r8,r4,r5
 	cmplw	0,r4,r7
 	cmplw	1,r3,r8
 	crand	0,0,4			/* cr0.lt &= cr1.lt */
-	blt	memcpy			/* if regions overlap */
+	blt	generic_memcpy		/* if regions overlap */
 
 	addi	r4,r4,-4
 	addi	r6,r3,-4
@@ -201,12 +206,7 @@ _GLOBAL(cacheable_memcpy)
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
