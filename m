Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C3DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 05:51:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C4B21773
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 05:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C4B21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VrT15zR9zDqNn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44VrMx26klzDqNk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 16:46:52 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 7BC3BAE80120;
 Fri, 29 Mar 2019 01:46:49 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 2/2] powerpc/mm_iommu: Fix potential deadlock
Date: Fri, 29 Mar 2019 16:46:41 +1100
Message-Id: <20190329054641.48597-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329054641.48597-1-aik@ozlabs.ru>
References: <20190329054641.48597-1-aik@ozlabs.ru>
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
- VFIO_IOMMU_SPAPR_REGISTER_MEMORY ioctl() for normal memory;
- vfio_pci_nvgpu_regops::mmap() for GPU memory.

One of the differences here is that the mmap() is called with mm::mmap_sem
help and mm_iommu_do_alloc() locks mm::mmap_sem itself (when adjusting
locked_vm and when pinning pages) which can potentially cause a deadlock.

We did not hit this yet because the mmap() path does not adjust
locked_vm and does not pin pages. However with CONFIG_DEBUG_LOCKDEP=y
there is an annoying warning (below, it is slightly confusing).

This makes a few changes to reduce the amount of time spent under a lock.

This holds mem_list_mutex only when looking or changing the mem list.
This means the list is checked twice now for the normal memory case -
before starting pinning and before adding the item to the list.

This changes mm_iommu_do_alloc() to only allocate and add an iommu memory
descriptor (used to deal with both normal and GPU memory in a rather
messy way).

This cleans the code in a way that mm_iommu_new() and mm_iommu_do_alloc()
do not need to test for (dev_hpa != MM_IOMMU_TABLE_INVALID_HPA) which
makes the code simpler.

This moves locked_vm decrementing from under mem_list_mutex for the same
reasons.

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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/mm/mmu_context_iommu.c | 128 ++++++++++++++--------------
 1 file changed, 65 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 6b351c79713b..36a826e23d45 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -96,50 +96,59 @@ static bool mm_iommu_find(struct mm_struct *mm, unsigned long ua,
 	return false;
 }
 
-static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
-			      unsigned long entries, unsigned long dev_hpa,
-			      struct mm_iommu_table_group_mem_t **pmem)
+/* Must be called with &mem_list_mutex held */
+static int mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries, unsigned long dev_hpa,
+		unsigned int mem_pageshift, phys_addr_t *hpas,
+		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
-	long i, ret, locked_entries = 0;
+
+	if (mm_iommu_find(mm, ua, entries))
+		return -EINVAL;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	atomic64_set(&mem->mapped, 1);
+	mem->dev_hpa = dev_hpa;
+	mem->used = 1;
+	mem->ua = ua;
+	mem->entries = entries;
+	mem->pageshift = mem_pageshift;
+	mem->hpas = hpas;
+	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
+	*pmem = mem;
+
+	return 0;
+}
+
+long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+		struct mm_iommu_table_group_mem_t **pmem)
+{
+	long i, ret = 0, locked_entries = 0;
 	unsigned int pageshift, mem_pageshift;
 	struct page **hpages;
 	phys_addr_t *hpas;
 
 	mutex_lock(&mem_list_mutex);
-
 	if (mm_iommu_find(mm, ua, entries)) {
-		ret = -EINVAL;
-		goto unlock_exit;
+		mutex_unlock(&mem_list_mutex);
+		return -EINVAL;
 	}
+	mutex_unlock(&mem_list_mutex);
 
-	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
-		ret = mm_iommu_adjust_locked_vm(mm, entries, true);
-		if (ret)
-			goto unlock_exit;
+	ret = mm_iommu_adjust_locked_vm(mm, entries, true);
+	if (ret)
+		return ret;
 
-		locked_entries = entries;
-	}
-
-	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
-	if (!mem) {
-		ret = -ENOMEM;
-		goto unlock_exit;
-	}
-
-	if (dev_hpa != MM_IOMMU_TABLE_INVALID_HPA) {
-		mem_pageshift = __ffs(dev_hpa | (entries << PAGE_SHIFT));
-		hpas = NULL;
-		mem->dev_hpa = dev_hpa;
-		goto good_exit;
-	}
-	mem->dev_hpa = MM_IOMMU_TABLE_INVALID_HPA;
+	locked_entries = entries;
 
 	hpages = vzalloc(array_size(entries, sizeof(hpages[0])));
 	if (!hpages) {
-		kfree(mem);
 		ret = -ENOMEM;
-		goto unlock_exit;
+		goto cleanup_exit;
 	}
 
 	down_read(&mm->mmap_sem);
@@ -149,11 +158,8 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		/* free the reference taken */
 		for (i = 0; i < ret; i++)
 			put_page(hpages[i]);
-
-		vfree(hpages);
-		kfree(mem);
 		ret = -EFAULT;
-		goto unlock_exit;
+		goto cleanup_exit;
 	}
 
 	/*
@@ -184,40 +190,35 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
 	}
 
-good_exit:
-	ret = 0;
-	atomic64_set(&mem->mapped, 1);
-	mem->used = 1;
-	mem->ua = ua;
-	mem->entries = entries;
-	mem->hpas = hpas;
-	mem->pageshift = mem_pageshift;
-	*pmem = mem;
-
-	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
-
-unlock_exit:
-	if (locked_entries && ret)
-		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
-
+	mutex_lock(&mem_list_mutex);
+	ret = mm_iommu_do_alloc(mm, ua, entries, MM_IOMMU_TABLE_INVALID_HPA,
+			mem_pageshift, hpas, pmem);
 	mutex_unlock(&mem_list_mutex);
 
+	if (ret)
+		goto cleanup_exit;
+	return 0;
+
+cleanup_exit:
+	mm_iommu_adjust_locked_vm(mm, locked_entries, false);
+	vfree(hpages);
+
 	return ret;
 }
-
-long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
-		struct mm_iommu_table_group_mem_t **pmem)
-{
-	return mm_iommu_do_alloc(mm, ua, entries, MM_IOMMU_TABLE_INVALID_HPA,
-			pmem);
-}
 EXPORT_SYMBOL_GPL(mm_iommu_new);
 
 long mm_iommu_newdev(struct mm_struct *mm, unsigned long ua,
 		unsigned long entries, unsigned long dev_hpa,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
-	return mm_iommu_do_alloc(mm, ua, entries, dev_hpa, pmem);
+	int ret;
+
+	mutex_lock(&mem_list_mutex);
+	ret = mm_iommu_do_alloc(mm, ua, entries, dev_hpa,
+			__ffs(dev_hpa | (entries << PAGE_SHIFT)), NULL, pmem);
+	mutex_unlock(&mem_list_mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_newdev);
 
@@ -270,10 +271,13 @@ static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
 long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 {
 	long ret = 0;
-	unsigned long entries, dev_hpa;
+	unsigned long unlock_entries = 0;
 
 	mutex_lock(&mem_list_mutex);
 
+	if (mem->dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
+		unlock_entries = mem->entries;
+
 	if (mem->used == 0) {
 		ret = -ENOENT;
 		goto unlock_exit;
@@ -292,16 +296,14 @@ long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 	}
 
 	/* @mapped became 0 so now mappings are disabled, release the region */
-	entries = mem->entries;
-	dev_hpa = mem->dev_hpa;
 	mm_iommu_release(mem);
 
-	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA)
-		mm_iommu_adjust_locked_vm(mm, entries, false);
-
 unlock_exit:
 	mutex_unlock(&mem_list_mutex);
 
+	if (!ret)
+		mm_iommu_adjust_locked_vm(mm, unlock_entries, false);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_put);
-- 
2.17.1

