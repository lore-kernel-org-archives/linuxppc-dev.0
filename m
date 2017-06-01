Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdqXD3n7lzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 00:31:08 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51EU4pQ097459
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 10:31:02 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atm3qaen1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 10:31:02 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 08:31:01 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] mm/hugetlb: Allow arch to override and call the weak
 function
Date: Thu,  1 Jun 2017 20:00:40 +0530
Message-Id: <1496327441-7368-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index caee7c4664c8..964401ff0af0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -357,6 +357,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 			pgoff_t idx);
 
 /* arch callback */
+int __init __alloc_bootmem_huge_page(struct hstate *h);
 int __init alloc_bootmem_huge_page(struct hstate *h);
 
 void __init hugetlb_bad_size(void);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 28217a147fe3..160282b13722 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2103,7 +2103,9 @@ struct page *alloc_huge_page_noerr(struct vm_area_struct *vma,
 	return page;
 }
 
-int __weak alloc_bootmem_huge_page(struct hstate *h)
+int alloc_bootmem_huge_page(struct hstate *h)
+	__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
+int __alloc_bootmem_huge_page(struct hstate *h)
 {
 	struct huge_bootmem_page *m;
 	int nr_nodes, node;
@@ -2124,6 +2126,7 @@ int __weak alloc_bootmem_huge_page(struct hstate *h)
 			goto found;
 		}
 	}
+	pr_info("Failed to allocate hugepage of size %ld\n", huge_page_size(h));
 	return 0;
 
 found:
-- 
2.7.4
