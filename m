Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 757B11A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 23:32:56 +1000 (AEST)
Message-Id: <9010ef9da0b2730af564a138b8d316d48eaf6d43.1431436210.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1431436210.git.christophe.leroy@c-s.fr>
References: <cover.1431436210.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/4] powerpc32: memset(0): use cacheable_memzero
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 12 May 2015 15:32:54 +0200 (CEST)
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

cacheable_memzero uses dcbz instruction and is more efficient than
memset(0) when the destination is in RAM

This patch renames memset as generic_memset, and defines memset
as a prolog to cacheable_memzero. This prolog checks if the byte
to set is 0 and if the buffer is in RAM. If not, it falls back to
generic_memcpy()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/copy_32.S | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index cbca76c..d8a9a86 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -12,6 +12,7 @@
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
+#include <asm/page.h>
 
 #define COPY_16_BYTES		\
 	lwz	r7,4(r4);	\
@@ -74,6 +75,18 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
  * to set them to zero.  This requires that the destination
  * area is cacheable.  -- paulus
  */
+_GLOBAL(memset)
+	cmplwi	r4,0
+	bne-	generic_memset
+	cmplwi	r5,L1_CACHE_BYTES
+	blt-	generic_memset
+	lis	r8,max_pfn@ha
+	lwz	r8,max_pfn@l(r8)
+	tophys	(r9,r3)
+	srwi	r9,r9,PAGE_SHIFT
+	cmplw	r9,r8
+	bge-	generic_memset
+	mr	r4,r5
 _GLOBAL(cacheable_memzero)
 	li	r5,0
 	addi	r6,r3,-4
@@ -116,7 +129,7 @@ _GLOBAL(cacheable_memzero)
 	bdnz	8b
 	blr
 
-_GLOBAL(memset)
+_GLOBAL(generic_memset)
 	rlwimi	r4,r4,8,16,23
 	rlwimi	r4,r4,16,0,15
 	addi	r6,r3,-4
-- 
2.1.0
