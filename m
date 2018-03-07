Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxCJL71M9zF1cj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 23:14:58 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27CArjS070870
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 07:14:56 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gjec93tpk-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 07:14:56 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 07:14:55 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 3/3] powerpc/mm/hash: Don't memset pgd table if not needed
Date: Wed,  7 Mar 2018 17:44:40 +0530
In-Reply-To: <20180307121440.20188-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180307121440.20188-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180307121440.20188-4-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to zero-out pgd table only if we share the slab cache with pud/pmd
level caches. With the support of 4PB, we don't share the slab cache anymore.
Instead of removing the code completely hide it within an #ifdef. We don't need
to do this with any other page table level, because they all allocate table
of double the size and we take of initializing the first half corrrectly during
page table zap.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 4746bc68d446..07f0dbac479f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -80,8 +80,19 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	/*
+	 * With hugetlb, we don't clear the second half of the page table.
+	 * If we share the same slab cache with the pmd or pud level table,
+	 * we need to make sure we zero out the full table on alloc.
+	 * With 4K we don't store slot in the second half. Hence we don't
+	 * need to do this for 4k.
+	 */
+#if (H_PGD_INDEX_SIZE == H_PUD_CACHE_INDEX) || \
+		(H_PGD_INDEX_SIZE == H_PMD_CACHE_INDEX)
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PPC_64K_PAGES)
 	memset(pgd, 0, PGD_TABLE_SIZE);
-
+#endif
+#endif
 	return pgd;
 }
 
-- 
2.14.3
