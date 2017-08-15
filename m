Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWdhC0RxxzDqh1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 13:46:51 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u185so13678128pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 20:46:50 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc/mm/nohash: add definition of PGALLOC_GFP
Date: Tue, 15 Aug 2017 13:46:36 +1000
Message-Id: <20170815034636.29898-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fixes
(de3b876 powerpc/mm/book(e)(3s)/64: Add page table accounting)

I missed adding PGALLOC_GFP for nohash/64

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index 9721c78..ce1d34e 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -41,6 +41,8 @@ extern struct kmem_cache *pgtable_cache[];
 			pgtable_cache[(shift) - 1];	\
 		})
 
+#define PGALLOC_GFP (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO)
+
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-- 
2.9.4
