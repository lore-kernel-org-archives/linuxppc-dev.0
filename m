Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6EC91A02D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 15:19:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: cyrilbur@gmail.com, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, aneesh.kumar@in.ibm.com
Subject: [PATCH] powerpc/mm: Fix pte_pagesize_index() crash on 4K w/64K hash
Date: Fri, 24 Jul 2015 15:18:55 +1000
Message-Id: <1437715135-5131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc kernel can be built to have either a 4K PAGE_SIZE or a 64K
PAGE_SIZE.

However when built with a 4K PAGE_SIZE there is an additional config
option which can be enabled, PPC_HAS_HASH_64K, which means the kernel
also knows how to hash a 64K page even though the base PAGE_SIZE is 4K.

This is used in one obscure configuration, to support 64K pages for SPU
local store on the Cell processor when the rest of the kernel is using
4K pages.

In this configuration, pte_pagesize_index() is defined to just pass
through its arguments to get_slice_psize(). However pte_pagesize_index()
is called for both user and kernel addresses, whereas get_slice_psize()
only knows how to handle user addresses.

This has been broken forever, however until recently it happened to
work. That was because in get_slice_psize() the large kernel address
would cause the right shift of the slize mask to return zero.

However in commit 7aa0727f3302 "powerpc/mm: Increase the slice range to
64TB", the get_slice_psize() code was changed so that instead of a right
shift we do an array lookup based on the address. When passed a kernel
address this means we index way off the end of the slice array and
return random junk.

That is only fatal if we happen to hit something non-zero, but when we
do return a non-zero value we confuse the MMU code and eventually cause
a check stop.

This fix is ugly, but simple. When we're called for a kernel address we
return 4K, which is always correct in this configuration, otherwise we
use the slice mask.

Fixes: 7aa0727f3302 ("powerpc/mm: Increase the slice range to 64TB")
Reported-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 3bb7488bd24b..330ae1d81662 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -135,7 +135,15 @@
 #define pte_iterate_hashed_end() } while(0)
 
 #ifdef CONFIG_PPC_HAS_HASH_64K
-#define pte_pagesize_index(mm, addr, pte)	get_slice_psize(mm, addr)
+#define pte_pagesize_index(mm, addr, pte)			\
+	({							\
+		unsigned int psize;				\
+		if (is_kernel_addr(addr))			\
+			psize = MMU_PAGE_4K;			\
+		else						\
+			psize = get_slice_psize(mm, addr);	\
+		psize;						\
+	})
 #else
 #define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
 #endif
-- 
2.1.0
