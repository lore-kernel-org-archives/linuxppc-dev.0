Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408qWz2J6pzF1vr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 21:05:19 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QA0PMw082756
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 06:05:16 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gxwwmjgy2-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 06:05:15 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 06:05:14 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 4/4] powerpc/mm/hash: Don't memset pgd table if not needed
Date: Mon, 26 Mar 2018 15:34:50 +0530
In-Reply-To: <20180326100450.18614-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180326100450.18614-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180326100450.18614-5-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to zero-out pgd table only if we share the slab cache with
pud/pmd level caches. With the support of 4PB, we don't share the slab
cache anymore. Instead of removing the code completely hide it within
an #ifdef. We don't need to do this with any other page table level,
because they all allocate table of double the size and we take of
initializing the first half corrrectly during page table zap.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Consolidate multiple #if / #ifdef into one]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 4746bc68d446..558a159600ad 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -80,8 +80,18 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			       pgtable_gfp_flags(mm, GFP_KERNEL));
+	/*
+	 * With hugetlb, we don't clear the second half of the page table.
+	 * If we share the same slab cache with the pmd or pud level table,
+	 * we need to make sure we zero out the full table on alloc.
+	 * With 4K we don't store slot in the second half. Hence we don't
+	 * need to do this for 4k.
+	 */
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_PPC_64K_PAGES) && \
+	((H_PGD_INDEX_SIZE == H_PUD_CACHE_INDEX) ||		     \
+	 (H_PGD_INDEX_SIZE == H_PMD_CACHE_INDEX))
 	memset(pgd, 0, PGD_TABLE_SIZE);
-
+#endif
 	return pgd;
 }
 
-- 
2.14.3
