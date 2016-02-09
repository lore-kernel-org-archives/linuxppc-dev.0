Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 2048F1A0311
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 21:23:51 +1100 (AEDT)
Message-Id: <63c805e79d641a10cca24bf6805bb6420c6597b4.1454932181.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454932181.git.christophe.leroy@c-s.fr>
References: <cover.1454932181.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 21/23] powerpc: Simplify test in __dma_sync()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  9 Feb 2016 11:23:47 +0100 (CET)
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
v6: no change
v7: no change

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
