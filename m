Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 65E201A0228
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 09:54:41 +1100 (AEDT)
Message-Id: <42d5343703a9e67b5a2d94c8877bc0098448f71b.1454538980.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454538974.git.christophe.leroy@c-s.fr>
References: <cover.1454538974.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 21/23] powerpc: Simplify test in __dma_sync()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  3 Feb 2016 23:54:38 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This simplification helps the compiler. We now have only one test
instead of two, so it reduces the number of branches.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: new
v3: no change
v4: no change
v5: no change

 arch/powerpc/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 169aba4..2dc74e5 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -327,7 +327,7 @@ void __dma_sync(void *vaddr, size_t size, int direction)
 		 * invalidate only when cache-line aligned otherwise there is
 		 * the potential for discarding uncommitted data from the cache
 		 */
-		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
+		if ((start | end) & (L1_CACHE_BYTES - 1))
 			flush_dcache_range(start, end);
 		else
 			invalidate_dcache_range(start, end);
-- 
2.1.0
