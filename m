Return-Path: <mita@fixstars.com>
Received: from gw.fixstars.com (122x208x5x10.ap122.ftth.ucom.ne.jp
	[122.208.5.10]) by ozlabs.org (Postfix) with ESMTP id 2E5F2DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 20:41:13 +1000 (EST)
Date: Tue, 29 May 2007 19:46:51 +0900
From: Akinobu Mita <mita@fixstars.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix virt_to_page() with NULL
Message-ID: <20070529104651.GA11932@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pte_alloc_one() is expected to return NULL if out of memory.
But it returns virt_to_page(NULL) and it is not NULL.

Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Akinobu Mita <mita@fixstars.com>

---
 include/asm-powerpc/pgalloc-64.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6-rc-ps3/include/asm-powerpc/pgalloc-64.h
===================================================================
--- 2.6-rc-ps3.orig/include/asm-powerpc/pgalloc-64.h
+++ 2.6-rc-ps3/include/asm-powerpc/pgalloc-64.h
@@ -90,7 +90,8 @@ static inline pte_t *pte_alloc_one_kerne
 static inline struct page *pte_alloc_one(struct mm_struct *mm,
 					 unsigned long address)
 {
-	return virt_to_page(pte_alloc_one_kernel(mm, address));
+	pte_t *pte = pte_alloc_one_kernel(mm, address);
+	return pte ? virt_to_page(pte) : NULL;
 }
 
 static inline void pte_free_kernel(pte_t *pte)
