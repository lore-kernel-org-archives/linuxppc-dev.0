Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy9gt324JzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 00:04:10 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v34E3ifk029172
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Apr 2017 10:04:00 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29m24aqwb2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Apr 2017 10:04:00 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Apr 2017 10:03:59 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH] powerpc/mm/hugetlb: Add support for 1G huge pages
Date: Tue,  4 Apr 2017 19:33:45 +0530
Message-Id: <1491314625-15307-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for gigantic pages in ppc64. We also updates
gigantic_page_supported helper such that arch can override it.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 9 +++++++++
 arch/powerpc/mm/hugetlbpage.c                | 7 +++++--
 arch/powerpc/platforms/Kconfig.cputype       | 1 +
 mm/hugetlb.c                                 | 4 ++++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 6666cd366596..a994d069fdaf 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -50,4 +50,13 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 	else
 		return entry;
 }
+
+#define gigantic_page_supported gigantic_page_supported
+static inline bool gigantic_page_supported(void)
+{
+	if (radix_enabled())
+		return true;
+	return false;
+}
+
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a4f33de4008e..80f6d2ed551a 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -763,8 +763,11 @@ static int __init add_huge_page_size(unsigned long long size)
 	 * Hash: 16M and 16G
 	 */
 	if (radix_enabled()) {
-		if (mmu_psize != MMU_PAGE_2M)
-			return -EINVAL;
+		if (mmu_psize != MMU_PAGE_2M) {
+			if (cpu_has_feature(CPU_FTR_POWER9_DD1) ||
+			    (mmu_psize != MMU_PAGE_1G))
+				return -EINVAL;
+		}
 	} else {
 		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
 			return -EINVAL;
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a7c0c1fafe68..382c3dd86d6d 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -343,6 +343,7 @@ config PPC_STD_MMU_64
 config PPC_RADIX_MMU
 	bool "Radix MMU Support"
 	depends on PPC_BOOK3S_64
+	select ARCH_HAS_GIGANTIC_PAGE
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3d0aab9ee80d..2c090189f314 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1158,7 +1158,11 @@ static int alloc_fresh_gigantic_page(struct hstate *h,
 	return 0;
 }
 
+#ifndef gigantic_page_supported
 static inline bool gigantic_page_supported(void) { return true; }
+#define gigantic_page_supported gigantic_page_supported
+#endif
+
 #else
 static inline bool gigantic_page_supported(void) { return false; }
 static inline void free_gigantic_page(struct page *page, unsigned int order) { }
-- 
2.7.4
