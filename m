Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 524F52C06F5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:11:11 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 16:07:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4470B2CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:11:06 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r265wK3U9372050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 16:58:21 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r266B4FB015116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 17:11:05 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 16/26] mm/THP: HPAGE_SHIFT is not a #define on some arch
Date: Wed,  6 Mar 2013 11:40:17 +0530
Message-Id: <1362550227-575-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linuxppc-dev@lists.ozlabs.org,
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

On archs like powerpc that support different huge page sizes, HPAGE_SHIFT
and other derived values like HPAGE_PMD_ORDER are not constants. So move
that to hugepage_init

Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/huge_mm.h |    3 ---
 mm/huge_memory.c        |    9 ++++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 1d76f8c..0022b70 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -119,9 +119,6 @@ extern void __split_huge_page_pmd(struct vm_area_struct *vma,
 	} while (0)
 extern void split_huge_page_pmd_mm(struct mm_struct *mm, unsigned long address,
 		pmd_t *pmd);
-#if HPAGE_PMD_ORDER > MAX_ORDER
-#error "hugepages can't be allocated by the buddy allocator"
-#endif
 extern int hugepage_madvise(struct vm_area_struct *vma,
 			    unsigned long *vm_flags, int advice);
 extern void __vma_adjust_trans_huge(struct vm_area_struct *vma,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5783d8..1940ee0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -44,7 +44,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
 
 /* default scan 8*512 pte (or vmas) every 30 second */
-static unsigned int khugepaged_pages_to_scan __read_mostly = HPAGE_PMD_NR*8;
+static unsigned int khugepaged_pages_to_scan __read_mostly;
 static unsigned int khugepaged_pages_collapsed;
 static unsigned int khugepaged_full_scans;
 static unsigned int khugepaged_scan_sleep_millisecs __read_mostly = 10000;
@@ -59,7 +59,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
  * it would have happened if the vma was large enough during page
  * fault.
  */
-static unsigned int khugepaged_max_ptes_none __read_mostly = HPAGE_PMD_NR-1;
+static unsigned int khugepaged_max_ptes_none __read_mostly;
 
 static int khugepaged(void *none);
 static int mm_slots_hash_init(void);
@@ -621,11 +621,14 @@ static int __init hugepage_init(void)
 	int err;
 	struct kobject *hugepage_kobj;
 
-	if (!has_transparent_hugepage()) {
+	if (!has_transparent_hugepage() || (HPAGE_PMD_ORDER > MAX_ORDER)) {
 		transparent_hugepage_flags = 0;
 		return -EINVAL;
 	}
 
+	khugepaged_pages_to_scan = HPAGE_PMD_NR*8;
+	khugepaged_max_ptes_none = HPAGE_PMD_NR-1;
+
 	err = hugepage_init_sysfs(&hugepage_kobj);
 	if (err)
 		return err;
-- 
1.7.10
