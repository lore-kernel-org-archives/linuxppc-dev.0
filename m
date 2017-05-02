Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wH8gK2rsZzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 15:17:33 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id b23so14658005pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 22:17:33 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: vdavydov.dev@gmail.com,
	mpe@ellerman.id.au,
	oss@buserror.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 3/3] powerpc/mm/hugetlb: Add support for page accounting
Date: Tue,  2 May 2017 15:17:06 +1000
Message-Id: <20170502051706.19043-4-bsingharora@gmail.com>
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

Add __GFP_ACCOUNT to __hugepte_alloc()

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a4f33de..94e56b1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -77,7 +77,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		num_hugepd = 1;
 	}
 
-	new = kmem_cache_zalloc(cachep, GFP_KERNEL);
+	new = kmem_cache_zalloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
 
 	BUG_ON(pshift > HUGEPD_SHIFT_MASK);
 	BUG_ON((unsigned long)new & HUGEPD_SHIFT_MASK);
-- 
2.9.3
