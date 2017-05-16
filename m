Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRsTM70sczDqd1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 19:24:07 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G9Ncrg149793
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:24:06 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2afr988rfh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:24:05 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 16 May 2017 03:24:04 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 7/9] powerpc/hugetlb: Add follow_huge_pd implementation for
 ppc64.
Date: Tue, 16 May 2017 14:53:30 +0530
In-Reply-To: <1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1494926612-23928-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1494926612-23928-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 80f6d2ed551a..5c829a83a4cc 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -17,6 +17,8 @@
 #include <linux/memblock.h>
 #include <linux/bootmem.h>
 #include <linux/moduleparam.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -618,6 +620,46 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 }
 
 /*
+ * 64 bit book3s use generic follow_page_mask
+ */
+#ifdef CONFIG_PPC_BOOK3S_64
+
+struct page *follow_huge_pd(struct vm_area_struct *vma,
+			    unsigned long address, hugepd_t hpd,
+			    int flags, int pdshift)
+{
+	pte_t *ptep;
+	spinlock_t *ptl;
+	struct page *page = NULL;
+	unsigned long mask;
+	int shift = hugepd_shift(hpd);
+	struct mm_struct *mm = vma->vm_mm;
+
+retry:
+	ptl = &mm->page_table_lock;
+	spin_lock(ptl);
+
+	ptep = hugepte_offset(hpd, address, pdshift);
+	if (pte_present(*ptep)) {
+		mask = (1UL << shift) - 1;
+		page = pte_page(*ptep);
+		page += ((address & mask) >> PAGE_SHIFT);
+		if (flags & FOLL_GET)
+			get_page(page);
+	} else {
+		if (is_hugetlb_entry_migration(*ptep)) {
+			spin_unlock(ptl);
+			__migration_entry_wait(mm, ptep, ptl);
+			goto retry;
+		}
+	}
+	spin_unlock(ptl);
+	return page;
+}
+
+#else /* !CONFIG_PPC_BOOK3S_64 */
+
+/*
  * We are holding mmap_sem, so a parallel huge page collapse cannot run.
  * To prevent hugepage split, disable irq.
  */
@@ -672,6 +714,7 @@ follow_huge_pud(struct mm_struct *mm, unsigned long address,
 	BUG();
 	return NULL;
 }
+#endif
 
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
-- 
2.7.4
