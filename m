Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FA181A1825
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 13:05:20 +1100 (AEDT)
Date: Thu, 21 Jan 2016 13:05:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] powerpc: remove newly added extra definition of pmd_dirty
Message-ID: <20160121130520.6dce1564@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d5d6a443b243 ("arch/powerpc/include/asm/pgtable-ppc64.h:
add pmd_[dirty|mkclean] for THP") added a new identical definition
of pdm_dirty.  Remove it again.

Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8204b0c393aa..8d1c41d28318 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -223,7 +223,6 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #define pmd_pfn(pmd)		pte_pfn(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
-#define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
 #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
-- 
2.7.0.rc3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
