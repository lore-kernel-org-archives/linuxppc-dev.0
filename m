Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qz47D5sm4zDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 22:56:24 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 2 May 2016 18:26:22 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1141E394006B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 18:26:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u42CuIFo23789792
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 18:26:18 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u42CuF3G007792
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 18:26:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/slice: Remove slice_mm_new_context
Date: Mon,  2 May 2016 18:26:07 +0530
Message-Id: <1462193767-6429-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing usage is bogus, because we set the context.id value
in the same function. The book3s 64 got removed in the old patch.
Hence remove the redundant definition.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/page_64.h   | 3 ---
 arch/powerpc/mm/mmu_context_nohash.c | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 77488857c26d..dd5f0712afa2 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -128,8 +128,6 @@ extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
 extern void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long len, unsigned int psize);
 
-#define slice_mm_new_context(mm)	((mm)->context.id == MMU_NO_CONTEXT)
-
 #endif /* __ASSEMBLY__ */
 #else
 #define slice_init()
@@ -151,7 +149,6 @@ do {						\
 
 #define slice_set_range_psize(mm, start, len, psize)	\
 	slice_set_user_psize((mm), (psize))
-#define slice_mm_new_context(mm)	1
 #endif /* CONFIG_PPC_MM_SLICES */
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index a36c43a27893..7d95bc402dba 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -335,8 +335,7 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
 	mm->context.active = 0;
 
 #ifdef CONFIG_PPC_MM_SLICES
-	if (slice_mm_new_context(mm))
-		slice_set_user_psize(mm, mmu_virtual_psize);
+	slice_set_user_psize(mm, mmu_virtual_psize);
 #endif
 
 	return 0;
-- 
2.7.4
