Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 341912C0141
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:33 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Nov 2013 19:28:31 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8B8DA2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:27 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAI9AX0M7274754
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:10:33 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAI9SQsM019718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 20:28:27 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [PATCH -V2 3/5] mm: Move change_prot_numa outside
 CONFIG_ARCH_USES_NUMA_PROT_NONE
Date: Mon, 18 Nov 2013 14:58:11 +0530
Message-Id: <1384766893-10189-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1384766893-10189-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

change_prot_numa should work even if _PAGE_NUMA != _PAGE_PROTNONE.
On archs like ppc64 that don't use _PAGE_PROTNONE and also have
a separate page table outside linux pagetable, we just need to
make sure that when calling change_prot_numa we flush the
hardware page table entry so that next page access  result in a numa
fault.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 include/linux/mm.h | 3 ---
 mm/mempolicy.c     | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0548eb201e05..51794c1a1d7e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1851,11 +1851,8 @@ static inline pgprot_t vm_get_page_prot(unsigned long vm_flags)
 }
 #endif
 
-#ifdef CONFIG_ARCH_USES_NUMA_PROT_NONE
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end);
-#endif
-
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c4403cdf3433..cae10af4fdc4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -613,7 +613,6 @@ static inline int queue_pages_pgd_range(struct vm_area_struct *vma,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_USES_NUMA_PROT_NONE
 /*
  * This is used to mark a range of virtual addresses to be inaccessible.
  * These are later cleared by a NUMA hinting fault. Depending on these
@@ -627,7 +626,6 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long end)
 {
 	int nr_updated;
-	BUILD_BUG_ON(_PAGE_NUMA != _PAGE_PROTNONE);
 
 	nr_updated = change_protection(vma, addr, end, vma->vm_page_prot, 0, 1);
 	if (nr_updated)
@@ -635,13 +633,6 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 	return nr_updated;
 }
-#else
-static unsigned long change_prot_numa(struct vm_area_struct *vma,
-			unsigned long addr, unsigned long end)
-{
-	return 0;
-}
-#endif /* CONFIG_ARCH_USES_NUMA_PROT_NONE */
 
 /*
  * Walk through page tables and collect pages to be migrated.
-- 
1.8.3.2
