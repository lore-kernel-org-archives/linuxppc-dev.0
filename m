Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wH8gF2dWmzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 15:17:29 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g23so30581173pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 22:17:29 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: vdavydov.dev@gmail.com,
	mpe@ellerman.id.au,
	oss@buserror.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 2/3] powerpc/mm/book(e)(3s)/32: Add page table accounting
Date: Tue,  2 May 2017 15:17:05 +1000
Message-Id: <20170502051706.19043-3-bsingharora@gmail.com>
In-Reply-To: <20170502051706.19043-1-bsingharora@gmail.com>
References: <20170502051706.19043-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support in pte_alloc_one() and pgd_alloc() by
passing __GFP_ACCOUNT in the flags

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 3 ++-
 arch/powerpc/mm/pgtable_32.c                 | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 6331392..cc369a7 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -31,7 +31,8 @@ extern struct kmem_cache *pgtable_cache[];
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE), GFP_KERNEL);
+	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a65c0b4..dc1e0c2 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -60,7 +60,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *ptepage;
 
-	gfp_t flags = GFP_KERNEL | __GFP_ZERO;
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
 
 	ptepage = alloc_pages(flags, 0);
 	if (!ptepage)
-- 
2.9.3
