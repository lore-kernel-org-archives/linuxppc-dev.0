Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR2RZ0xWDzDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 21:04:25 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1JA3h0L015520
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:04:24 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28q729uejn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 05:04:23 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 19 Feb 2017 03:04:23 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 2/3] mm/ksm: Handle protnone saved writes when making page
 write protect
Date: Sun, 19 Feb 2017 15:33:44 +0530
In-Reply-To: <1487498625-10891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487498625-10891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1487498625-10891-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Without this KSM will consider the page write protected, but a numa fault can
later mark the page writable. This can result in memory corruption.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/asm-generic/pgtable.h | 8 ++++++++
 mm/ksm.c                      | 9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index b6f3a8a4b738..8c8ba48bef0b 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -200,6 +200,10 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 #define pte_mk_savedwrite pte_mkwrite
 #endif
 
+#ifndef pte_clear_savedwrite
+#define pte_clear_savedwrite pte_wrprotect
+#endif
+
 #ifndef pmd_savedwrite
 #define pmd_savedwrite pmd_write
 #endif
@@ -208,6 +212,10 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
 #define pmd_mk_savedwrite pmd_mkwrite
 #endif
 
+#ifndef pmd_clear_savedwrite
+#define pmd_clear_savedwrite pmd_wrprotect
+#endif
+
 #ifndef __HAVE_ARCH_PMDP_SET_WRPROTECT
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
diff --git a/mm/ksm.c b/mm/ksm.c
index 9ae6011a41f8..768202831578 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -872,7 +872,8 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 	if (!ptep)
 		goto out_mn;
 
-	if (pte_write(*ptep) || pte_dirty(*ptep)) {
+	if (pte_write(*ptep) || pte_dirty(*ptep) ||
+	    (pte_protnone(*ptep) && pte_savedwrite(*ptep))) {
 		pte_t entry;
 
 		swapped = PageSwapCache(page);
@@ -897,7 +898,11 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 		}
 		if (pte_dirty(entry))
 			set_page_dirty(page);
-		entry = pte_mkclean(pte_wrprotect(entry));
+
+		if (pte_protnone(entry))
+			entry = pte_mkclean(pte_clear_savedwrite(entry));
+		else
+			entry = pte_mkclean(pte_wrprotect(entry));
 		set_pte_at_notify(mm, addr, ptep, entry);
 	}
 	*orig_pte = *ptep;
-- 
2.7.4
