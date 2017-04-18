Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6VkZ2SnzzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:20:22 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3I3JY6k130219
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 23:20:17 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29w4j9kwva-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 23:20:17 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 18 Apr 2017 13:20:14 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3I3K4Os55181510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:20:12 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3I3JcGs003773
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 13:19:39 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, akpm@linux-foundation.org, mpe@ellerman.id.au,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/7] mm/follow_page_mask: Add support for hugepage
 directory entry
In-Reply-To: <201704180224.jNqHZuTL%fengguang.wu@intel.com>
References: <201704180224.jNqHZuTL%fengguang.wu@intel.com>
Date: Tue, 18 Apr 2017 08:49:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a87eh07h.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kbuild test robot <lkp@intel.com> writes:

> Hi Aneesh,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.11-rc7 next-20170413]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/HugeTLB-migration-support-for-PPC64/20170418-011540
> config: x86_64-randconfig-a0-04180109 (attached as .config)
> compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
>
> All errors (new ones prefixed by >>):
>
>    In file included from mm//swap.c:35:
>>> include/linux/hugetlb.h:121: error: expected declaration specifiers or '...' before 'hugepd_t'
>
> vim +121 include/linux/hugetlb.h
>
>    115				unsigned long addr, unsigned long sz);
>    116	pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr);
>    117	int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep);
>    118	struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
>    119				      int write);
>    120	struct page *follow_huge_pd(struct vm_area_struct *vma,
>  > 121				    unsigned long address, hugepd_t hpd,
>    122				    int flags, int pdshift);
>    123	struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>    124					pmd_t *pmd, int flags);
>

Thanks for the report. How about

>From 64033ea38962f69271169129277bbb0482299c31 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 18 Apr 2017 08:39:09 +0530
Subject: [PATCH] mm/hugetlb: Move default definition of hugepd_t earlier in
 the header

This enable to use the hugepd_t type early. No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/hugetlb.h | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index edab98f0a7b8..f66c1d4e0d1f 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -14,6 +14,30 @@ struct ctl_table;
 struct user_struct;
 struct mmu_gather;
 
+#ifndef is_hugepd
+/*
+ * Some architectures requires a hugepage directory format that is
+ * required to support multiple hugepage sizes. For example
+ * a4fe3ce76 "powerpc/mm: Allow more flexible layouts for hugepage pagetables"
+ * introduced the same on powerpc. This allows for a more flexible hugepage
+ * pagetable layout.
+ */
+typedef struct { unsigned long pd; } hugepd_t;
+#define is_hugepd(hugepd) (0)
+#define __hugepd(x) ((hugepd_t) { (x) })
+static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+			      unsigned pdshift, unsigned long end,
+			      int write, struct page **pages, int *nr)
+{
+	return 0;
+}
+#else
+extern int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
+		       unsigned pdshift, unsigned long end,
+		       int write, struct page **pages, int *nr);
+#endif
+
+
 #ifdef CONFIG_HUGETLB_PAGE
 
 #include <linux/mempolicy.h>
@@ -222,29 +246,6 @@ static inline int pud_write(pud_t pud)
 }
 #endif
 
-#ifndef is_hugepd
-/*
- * Some architectures requires a hugepage directory format that is
- * required to support multiple hugepage sizes. For example
- * a4fe3ce76 "powerpc/mm: Allow more flexible layouts for hugepage pagetables"
- * introduced the same on powerpc. This allows for a more flexible hugepage
- * pagetable layout.
- */
-typedef struct { unsigned long pd; } hugepd_t;
-#define is_hugepd(hugepd) (0)
-#define __hugepd(x) ((hugepd_t) { (x) })
-static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-			      unsigned pdshift, unsigned long end,
-			      int write, struct page **pages, int *nr)
-{
-	return 0;
-}
-#else
-extern int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
-		       unsigned pdshift, unsigned long end,
-		       int write, struct page **pages, int *nr);
-#endif
-
 #define HUGETLB_ANON_FILE "anon_hugepage"
 
 enum {
-- 
2.7.4

 
