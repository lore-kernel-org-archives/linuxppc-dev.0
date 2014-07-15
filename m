Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 716551A0232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:41 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:41 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 45EDB2BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F98pVA60293142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:08:51 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PbBN006317
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:37 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 02/13] KVM: PPC: Rework kvmppc_spapr_tce_table to support
 variable page size
Date: Tue, 15 Jul 2014 19:25:22 +1000
Message-Id: <1405416333-12477-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the kvmppc_spapr_tce_table struct can only describe
4GB windows which is not enough for big DMA windows.

This replaces window_size (in bytes, 4GB max) with page_shift (32bit)
and size (64bit, in pages).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s_64_vio.c    | 17 +++++++++--------
 arch/powerpc/kvm/book3s_64_vio_hv.c |  3 +--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index c37fee2..d3a154c 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -180,7 +180,8 @@ struct kvmppc_spapr_tce_table {
 	struct list_head list;
 	struct kvm *kvm;
 	u64 liobn;
-	u32 window_size;
+	u32 page_shift;
+	u64 size;		/* in pages */
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 4ca33f1..f2c8e4d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -67,10 +67,9 @@ void kvmppc_spapr_tce_free(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvmppc_spapr_tce_free);
 
-static long kvmppc_stt_npages(unsigned long window_size)
+static long kvmppc_stt_npages(unsigned long size)
 {
-	return ALIGN((window_size >> IOMMU_PAGE_SHIFT_4K)
-		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
+	return ALIGN(size * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
 /*
@@ -103,7 +102,7 @@ static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
 {
 	struct kvm *kvm = stt->kvm;
 	int i;
-	long npages = kvmppc_stt_npages(stt->window_size);
+	long npages = kvmppc_stt_npages(stt->size);
 
 	mutex_lock(&kvm->lock);
 	list_del(&stt->list);
@@ -123,7 +122,7 @@ static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	struct kvmppc_spapr_tce_table *stt = vma->vm_file->private_data;
 	struct page *page;
 
-	if (vmf->pgoff >= kvmppc_stt_npages(stt->window_size))
+	if (vmf->pgoff >= kvmppc_stt_npages(stt->size))
 		return VM_FAULT_SIGBUS;
 
 	page = stt->pages[vmf->pgoff];
@@ -159,7 +158,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
-	long npages;
+	long npages, size;
 	int ret = -ENOMEM;
 	int i;
 
@@ -169,7 +168,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 			return -EBUSY;
 	}
 
-	npages = kvmppc_stt_npages(args->window_size);
+	size = args->window_size >> IOMMU_PAGE_SHIFT_4K;
+	npages = kvmppc_stt_npages(size);
 	ret = kvmppc_account_memlimit(npages + 1);
 	if (ret)
 		goto fail;
@@ -180,7 +180,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		goto fail;
 
 	stt->liobn = args->liobn;
-	stt->window_size = args->window_size;
+	stt->page_shift = IOMMU_PAGE_SHIFT_4K;
+	stt->size = size;
 	stt->kvm = kvm;
 
 	for (i = 0; i < npages; i++) {
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 79a39bb..fadfacb 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -73,9 +73,8 @@ long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 {
 	unsigned long mask = (1 << IOMMU_PAGE_SHIFT_4K) - 1;
 	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
-	unsigned long size = stt->window_size >> IOMMU_PAGE_SHIFT_4K;
 
-	if ((ioba & mask) || (size + npages <= idx))
+	if ((ioba & mask) || (stt->size + npages <= idx))
 		return H_PARAMETER;
 
 	return H_SUCCESS;
-- 
2.0.0
