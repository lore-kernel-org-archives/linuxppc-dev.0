Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBB911A0075
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 16:19:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 3/5] powerpc/mm: Drop the 64K on 4K version of
 pte_pagesize_index()
Date: Fri,  7 Aug 2015 16:19:45 +1000
Message-Id: <1438928387-6454-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
References: <1438928387-6454-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that support for 64k pages with a 4K kernel is removed, this code is
unreachable.

CONFIG_PPC_HAS_HASH_64K can only be true when CONFIG_PPC_64K_PAGES is
also true.

But when CONFIG_PPC_64K_PAGES is true we include pte-hash64.h which
includes pte-hash64-64k.h, which defines both pte_pagesize_index() and
crucially __real_pte, which means this defintion can never be used.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 7ee2300ee392..fa1dfb7f7b48 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -134,23 +134,11 @@
 
 #define pte_iterate_hashed_end() } while(0)
 
-#ifdef CONFIG_PPC_HAS_HASH_64K
 /*
  * We expect this to be called only for user addresses or kernel virtual
  * addresses other than the linear mapping.
  */
-#define pte_pagesize_index(mm, addr, pte)			\
-	({							\
-		unsigned int psize;				\
-		if (is_kernel_addr(addr))			\
-			psize = MMU_PAGE_4K;			\
-		else						\
-			psize = get_slice_psize(mm, addr);	\
-		psize;						\
-	})
-#else
 #define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
-#endif
 
 #endif /* __real_pte */
 
-- 
2.1.4
