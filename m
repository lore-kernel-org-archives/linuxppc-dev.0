Return-Path: <agl@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C84E3DDE08
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 06:51:47 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA7JrLZY028479
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 14:53:21 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA7JpiHe110634
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 14:51:44 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA7JpipV000380
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2007 14:51:44 -0500
From: Adam Litke <agl@us.ibm.com>
Subject: [PATCH] hugetlb: follow_hugetlb_page for write access
Date: Wed, 07 Nov 2007 11:51:43 -0800
To: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20071107195142.13505.49398.stgit@kernel>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev@ozlabs.org, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Ken Chen <kenchen@google.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When calling get_user_pages(), a write flag is passed in by the caller to
indicate if write access is required on the faulted-in pages.  Currently,
follow_hugetlb_page() ignores this flag and always faults pages for
read-only access.  This can cause data corruption because a device driver
that calls get_user_pages() with write set will not expect COW faults to
occur on the returned pages.

This patch passes the write flag down to follow_hugetlb_page() and makes
sure hugetlb_fault() is called with the right write_access parameter.

Signed-off-by: Adam Litke <agl@us.ibm.com>
---

 include/linux/hugetlb.h |    2 +-
 mm/hugetlb.c            |    5 +++--
 mm/memory.c             |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3a19b03..31fa0a0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -19,7 +19,7 @@ static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
 int hugetlb_sysctl_handler(struct ctl_table *, int, struct file *, void __user *, size_t *, loff_t *);
 int hugetlb_treat_movable_handler(struct ctl_table *, int, struct file *, void __user *, size_t *, loff_t *);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
-int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
+int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int, int);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void __unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eab8c42..b645985 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -621,7 +621,8 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
+			unsigned long *position, int *length, int i,
+			int write)
 {
 	unsigned long pfn_offset;
 	unsigned long vaddr = *position;
@@ -643,7 +644,7 @@ int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			int ret;
 
 			spin_unlock(&mm->page_table_lock);
-			ret = hugetlb_fault(mm, vma, vaddr, 0);
+			ret = hugetlb_fault(mm, vma, vaddr, write);
 			spin_lock(&mm->page_table_lock);
 			if (!(ret & VM_FAULT_ERROR))
 				continue;
diff --git a/mm/memory.c b/mm/memory.c
index f82b359..1bcd444 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1039,7 +1039,7 @@ int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 
 		if (is_vm_hugetlb_page(vma)) {
 			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
+						&start, &len, i, write);
 			continue;
 		}
 
