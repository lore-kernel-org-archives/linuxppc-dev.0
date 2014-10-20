Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5DD91A0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:20:07 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Oct 2014 19:20:07 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2D7D72BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:20:03 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9K9Jtsf40304706
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:19:55 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9K9K2Z2013511
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:20:02 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] arch/powerpc: Fix build error with hugetlfs disabled
Date: Mon, 20 Oct 2014 14:49:46 +0530
Message-Id: <1413796786-16451-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/mm/slice.c:704:5: error: expected identifier or ‘(’ before numeric constant
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
     ^
make[1]: *** [arch/powerpc/mm/slice.o] Error 1
make: *** [arch/powerpc/mm/slice.o] Error 2

This got introduced via 1217d34b531c76362217057ca70a8ce8950574e0
"powerpc: Ensure global functions include their prototype". We
started including linux/hugetlb.h with that patch and now we have

 #define is_hugepage_only_range(mm, addr, len)	0

with hugetlbfs disabled

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hugetlb.h | 2 +-
 arch/powerpc/mm/slice.c            | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 623f2971ce0e..766b77d527ac 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -71,7 +71,7 @@ pte_t *huge_pte_offset_and_shift(struct mm_struct *mm,
 
 void flush_dcache_icache_hugepage(struct page *page);
 
-#if defined(CONFIG_PPC_MM_SLICES) || defined(CONFIG_PPC_SUBPAGE_PROT)
+#if defined(CONFIG_PPC_MM_SLICES)
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 			   unsigned long len);
 #else
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 8d7bda94d196..ded0ea1afde4 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -682,6 +682,7 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 	slice_convert(mm, mask, psize);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
 /*
  * is_hugepage_only_range() is used by generic code to verify whether
  * a normal mmap mapping (non hugetlbfs) is valid on a given area.
@@ -726,4 +727,4 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 #endif
 	return !slice_check_fit(mask, available);
 }
-
+#endif
-- 
1.9.1
