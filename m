Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 6EFBD1A0211
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 20:07:56 +1000 (AEST)
Message-Id: <bcab8e1bde2b7b82c60be00ea5f4bb14afcce764.1432012060.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1432012060.git.christophe.leroy@c-s.fr>
References: <cover.1432012060.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/6] powerpc32: memset(0): use cacheable_memzero
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 12:07:50 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cacheable_memzero uses dcbz instruction and is more efficient than
memset(0) when the destination is in RAM

This patch renames memset as generic_memset, and defines memset
as a prolog to cacheable_memzero. This prolog checks if the byte
to set is 0. If not, it falls back to generic_memcpy()

cacheable_memzero disappears as it is not referenced anywhere anymore

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 55f19f9..0b4f954 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -74,9 +74,9 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
  * to set them to zero.  This requires that the destination
  * area is cacheable.  -- paulus
  */
-_GLOBAL(cacheable_memzero)
-	mr	r5,r4
-	li	r4,0
+_GLOBAL(memset)
+	cmplwi	r4,0
+	bne-	generic_memset
 	addi	r6,r3,-4
 	cmplwi	0,r5,4
 	blt	7f
@@ -117,7 +117,7 @@ _GLOBAL(cacheable_memzero)
 	bdnz	8b
 	blr
 
-_GLOBAL(memset)
+_GLOBAL(generic_memset)
 	rlwimi	r4,r4,8,16,23
 	rlwimi	r4,r4,16,0,15
 	addi	r6,r3,-4
-- 
2.1.0
