Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62A1D2C0524
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:03:44 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 19:56:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 785E6357804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:03:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MA2tZ850921586
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:55 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MA2xT8012535
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:03:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, David Gibson <dwg@au1.ibm.com>
Subject: [PATCH -V6 16/27] mm/THP: HPAGE_SHIFT is not a #define on some arch
Date: Mon, 22 Apr 2013 15:30:50 +0530
Message-Id: <1366624861-24948-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On archs like powerpc that support different hugepage sizes, HPAGE_SHIFT
and other derived values like HPAGE_PMD_ORDER are not constants. So move
that to hugepage_init

Cc: Andrea Arcangeli <aarcange@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/huge_mm.h |    3 ---
 mm/huge_memory.c        |    9 ++++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index ee1c244..bdc5aef 100644
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
index e2f7f5aa..78bd84f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -45,7 +45,7 @@ unsigned long transparent_hugepage_flags __read_mostly =
 	(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
 
 /* default scan 8*512 pte (or vmas) every 30 second */
-static unsigned int khugepaged_pages_to_scan __read_mostly = HPAGE_PMD_NR*8;
+static unsigned int khugepaged_pages_to_scan __read_mostly;
 static unsigned int khugepaged_pages_collapsed;
 static unsigned int khugepaged_full_scans;
 static unsigned int khugepaged_scan_sleep_millisecs __read_mostly = 10000;
@@ -60,7 +60,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
  * it would have happened if the vma was large enough during page
  * fault.
  */
-static unsigned int khugepaged_max_ptes_none __read_mostly = HPAGE_PMD_NR-1;
+static unsigned int khugepaged_max_ptes_none __read_mostly;
 
 static int khugepaged(void *none);
 static int khugepaged_slab_init(void);
@@ -620,11 +620,14 @@ static int __init hugepage_init(void)
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
