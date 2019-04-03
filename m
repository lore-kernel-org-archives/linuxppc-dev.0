Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302D6C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:17:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD4E2084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD4E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yt8j5TlVzDqGt
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:17:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44Yt3V3rZfzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 15:13:10 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 0A074AE80054;
 Wed,  3 Apr 2019 00:12:37 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2 1/2] powerpc/mm_iommu: Fix potential deadlock
Date: Wed,  3 Apr 2019 15:12:32 +1100
Message-Id: <20190403041233.57619-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403041233.57619-1-aik@ozlabs.ru>
References: <20190403041233.57619-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently mm_iommu_do_alloc() is called in 2 cases:
- VFIO_IOMMU_SPAPR_REGISTER_MEMORY ioctl() for normal memory:
	this locks &mem_list_mutex and then locks mm::mmap_sem
	several times when adjusting locked_vm or pinning pages;
- vfio_pci_nvgpu_regops::mmap() for GPU memory:
	this is called with mm::mmap_sem held already and it locks
	&mem_list_mutex.

So one can craft a userspace program to do special ioctl and mmap in
2 threads concurrently and cause a deadlock which lockdep warns about
(below).

We did not hit this yet because QEMU constructs the machine in a single
thread.

This moves the overlap check next to where the new entry is added and
reduces the amount of time spent with &mem_list_mutex held.

This moves locked_vm adjustment from under &mem_list_mutex.

This relies on mm_iommu_adjust_locked_vm() doing nothing when entries==0.

This is one of the lockdep warnings:
======================================================
WARNING: possible circular locking dependency detected
5.1.0-rc2-le_nv2_aikATfstn1-p1 #363 Not tainted
------------------------------------------------------
qemu-system-ppc/8038 is trying to acquire lock:
000000002ec6c453 (mem_list_mutex){+.+.}, at: mm_iommu_do_alloc+0x70/0x490

but task is already holding lock:
00000000fd7da97f (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xf0/0x160

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_sem){++++}:
       lock_acquire+0xf8/0x260
       down_write+0x44/0xa0
       mm_iommu_adjust_locked_vm.part.1+0x4c/0x190
       mm_iommu_do_alloc+0x310/0x490
       tce_iommu_ioctl.part.9+0xb84/0x1150 [vfio_iommu_spapr_tce]
       vfio_fops_unl_ioctl+0x94/0x430 [vfio]
       do_vfs_ioctl+0xe4/0x930
       ksys_ioctl+0xc4/0x110
       sys_ioctl+0x28/0x80
       system_call+0x5c/0x70

-> #0 (mem_list_mutex){+.+.}:
       __lock_acquire+0x1484/0x1900
       lock_acquire+0xf8/0x260
       __mutex_lock+0x88/0xa70
       mm_iommu_do_alloc+0x70/0x490
       vfio_pci_nvgpu_mmap+0xc0/0x130 [vfio_pci]
       vfio_pci_mmap+0x198/0x2a0 [vfio_pci]
       vfio_device_fops_mmap+0x44/0x70 [vfio]
       mmap_region+0x5d4/0x770
       do_mmap+0x42c/0x650
       vm_mmap_pgoff+0x124/0x160
       ksys_mmap_pgoff+0xdc/0x2f0
       sys_mmap+0x40/0x80
       system_call+0x5c/0x70

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_sem);
                               lock(mem_list_mutex);
                               lock(&mm->mmap_sem);
  lock(mem_list_mutex);

 *** DEADLOCK ***

1 lock held by qemu-system-ppc/8038:
 #0: 00000000fd7da97f (&mm->mmap_sem){++++}, at: vm_mmap_pgoff+0xf0/0x160

Fixes: c10c21efa4bc ("powerpc/vfio/iommu/kvm: Do not pin device memory", 2018-12-19)
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/mm/mmu_context_iommu.c | 75 +++++++++++++++--------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index e7a9c4f6bfca..9d9be850f8c2 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -95,28 +95,14 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 			      unsigned long entries, unsigned long dev_hpa,
 			      struct mm_iommu_table_group_mem_t **pmem)
 {
-	struct mm_iommu_table_group_mem_t *mem;
-	long i, ret, locked_entries = 0;
+	struct mm_iommu_table_group_mem_t *mem, *mem2;
+	long i, ret, locked_entries = 0, pinned = 0;
 	unsigned int pageshift;
 
-	mutex_lock(&mem_list_mutex);
-
-	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
-			next) {
-		/* Overlap? */
-		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
-				(ua < (mem->ua +
-				       (mem->entries << PAGE_SHIFT)))) {
-			ret = -EINVAL;
-			goto unlock_exit;
-		}
-
-	}
-
 	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
 		ret = mm_iommu_adjust_locked_vm(mm, entries, true);
 		if (ret)
-			goto unlock_exit;
+			return ret;
 
 		locked_entries = entries;
 	}
@@ -150,15 +136,10 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	down_read(&mm->mmap_sem);
 	ret = get_user_pages_longterm(ua, entries, FOLL_WRITE, mem->hpages, NULL);
 	up_read(&mm->mmap_sem);
+	pinned = ret > 0 ? ret : 0;
 	if (ret != entries) {
-		/* free the reference taken */
-		for (i = 0; i < ret; i++)
-			put_page(mem->hpages[i]);
-
-		vfree(mem->hpas);
-		kfree(mem);
 		ret = -EFAULT;
-		goto unlock_exit;
+		goto free_exit;
 	}
 
 	pageshift = PAGE_SHIFT;
@@ -183,21 +164,43 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	}
 
 good_exit:
-	ret = 0;
 	atomic64_set(&mem->mapped, 1);
 	mem->used = 1;
 	mem->ua = ua;
 	mem->entries = entries;
-	*pmem = mem;
+
+	mutex_lock(&mem_list_mutex);
+
+	list_for_each_entry_rcu(mem2, &mm->context.iommu_group_mem_list, next) {
+		/* Overlap? */
+		if ((mem2->ua < (ua + (entries << PAGE_SHIFT))) &&
+				(ua < (mem2->ua +
+				       (mem2->entries << PAGE_SHIFT)))) {
+			ret = -EINVAL;
+			mutex_unlock(&mem_list_mutex);
+			goto free_exit;
+		}
+	}
 
 	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
 
-unlock_exit:
-	if (locked_entries && ret)
-		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
-
 	mutex_unlock(&mem_list_mutex);
 
+	*pmem = mem;
+
+	return 0;
+
+free_exit:
+	/* free the reference taken */
+	for (i = 0; i < pinned; i++)
+		put_page(mem->hpages[i]);
+
+	vfree(mem->hpas);
+	kfree(mem);
+
+unlock_exit:
+	mm_iommu_adjust_locked_vm(mm, locked_entries, false);
+
 	return ret;
 }
 
@@ -266,7 +269,7 @@ static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
 long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 {
 	long ret = 0;
-	unsigned long entries, dev_hpa;
+	unsigned long unlock_entries = 0;
 
 	mutex_lock(&mem_list_mutex);
 
@@ -287,17 +290,17 @@ long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 		goto unlock_exit;
 	}
 
+	if (mem->dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
+		unlock_entries = mem->entries;
+
 	/* @mapped became 0 so now mappings are disabled, release the region */
-	entries = mem->entries;
-	dev_hpa = mem->dev_hpa;
 	mm_iommu_release(mem);
 
-	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
-		mm_iommu_adjust_locked_vm(mm, entries, false);
-
 unlock_exit:
 	mutex_unlock(&mem_list_mutex);
 
+	mm_iommu_adjust_locked_vm(mm, unlock_entries, false);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_put);
-- 
2.17.1

