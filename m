Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ1yL2VgyzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 16:18:49 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6R6DfPq094449
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 02:18:46 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2by6pthyp1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 02:18:45 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 02:18:45 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 1/3] mm/hugetlb: Allow arch to override and call the weak
 function
Date: Thu, 27 Jul 2017 11:48:26 +0530
Message-Id: <20170727061828.11406-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For ppc64, we want to call this function when we are not running as guest.
Also, if we failed to allocate hugepages, let the user know.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/hugetlb.h | 1 +
 mm/hugetlb.c            | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0ed8e41aaf11..8bbbd37ab105 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -358,6 +358,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
 /* arch callback */
+int __init __alloc_bootmem_huge_page(struct hstate *h);
 int __init alloc_bootmem_huge_page(struct hstate *h);
 
 void __init hugetlb_bad_size(void);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bc48ee783dd9..a3a7a7e6339e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2083,7 +2083,9 @@ struct page *alloc_huge_page_noerr(struct vm_area_struct *vma,
 	return page;
 }
 
-int __weak alloc_bootmem_huge_page(struct hstate *h)
+int alloc_bootmem_huge_page(struct hstate *h)
+	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
+int __alloc_bootmem_huge_page(struct hstate *h)
 {
 	struct huge_bootmem_page *m;
 	int nr_nodes, node;
@@ -2104,6 +2106,7 @@ int __weak alloc_bootmem_huge_page(struct hstate *h)
 			goto found;
 		}
 	}
+	pr_info("Failed to allocate hugepage of size %ld\n", huge_page_size(h));
 	return 0;
 
 found:
-- 
2.13.3
