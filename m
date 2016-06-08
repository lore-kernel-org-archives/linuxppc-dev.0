Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPpwp3s8GzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 23:21:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] powerpc/nohash: Fix build break with 4K pages
Date: Wed,  8 Jun 2016 23:21:11 +1000
Message-Id: <1465392071-18715-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 74701d5947a6 "powerpc/mm: Rename function to indicate we are
allocating fragments" renamed page_table_free() to pte_fragment_free().
One occurrence was mistyped as pte_fragment_fre().

This only breaks the nohash 4K page build, which is not the default or
enabled in any defconfig.

Fixes: 74701d5947a6 ("powerpc/mm: Rename function to indicate we are allocating fragments")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 0c12a3bfe2ab..069369f6414b 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -172,7 +172,7 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
-	pte_fragment_fre((unsigned long *)pte, 1);
+	pte_fragment_free((unsigned long *)pte, 1);
 }
 
 static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-- 
2.5.0
