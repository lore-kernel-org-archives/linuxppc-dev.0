Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2252E2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:27 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 22 May 2013 22:22:31 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DEC871258051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:30:17 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4MGwEJJ63242380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:28:14 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4MGwImd020499
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:19 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V9 05/20] mm/THP: Don't use HPAGE_SHIFT in transparent
 hugepage code
Date: Wed, 22 May 2013 22:27:37 +0530
Message-Id: <1369241872-15700-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

For architectures like powerpc that support multiple explicit hugepage
sizes, HPAGE_SHIFT indicate the default explicit hugepage shift. For
THP to work the hugepage size should be same as PMD_SIZE. So use
PMD_SHIFT directly. So move the define outside CONFIG_TRANSPARENT_HUGEPAGE
#ifdef because we want to use these defines in generic code with
if (pmd_trans_huge()) conditional.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/huge_mm.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 528454c..cc276d2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -58,12 +58,11 @@ extern pmd_t *page_check_address_pmd(struct page *page,
 
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
+#define HPAGE_PMD_SHIFT PMD_SHIFT
+#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
+#define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define HPAGE_PMD_SHIFT HPAGE_SHIFT
-#define HPAGE_PMD_MASK HPAGE_MASK
-#define HPAGE_PMD_SIZE HPAGE_SIZE
-
 extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
 
 #define transparent_hugepage_enabled(__vma)				\
@@ -181,9 +180,6 @@ extern int do_huge_pmd_numa_page(struct mm_struct *mm, struct vm_area_struct *vm
 				unsigned long addr, pmd_t pmd, pmd_t *pmdp);
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
-#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
 
 #define hpage_nr_pages(x) 1
 
-- 
1.8.1.2
