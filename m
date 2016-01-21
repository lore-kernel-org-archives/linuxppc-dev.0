Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 475F71A182D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:57 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 21 Jan 2016 18:16:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C2DB22BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:54 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L8GOhr36896790
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:32 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L8GMJA008720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:22 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 2/4] KVM: PPC: Add @page_shift to kvmppc_spapr_tce_table
Date: Thu, 21 Jan 2016 19:15:24 +1100
Message-Id: <1453364126-22527-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the kvmppc_spapr_tce_table struct can only describe
4GB windows and handle fixed size (4K) pages. Dynamic DMA windows
support more so these limits need to be extended.

This replaces window_size (in bytes, 4GB max) with page_shift (32bit)
and size (64bit, in pages).

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s_64_vio.c    | 29 +++++++++++++++--------------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 20 ++++++++++----------
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index c7ee696..a4ed9f5 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -183,8 +183,9 @@ struct kvmppc_spapr_tce_table {
 	struct list_head list;
 	struct kvm *kvm;
 	u64 liobn;
-	u32 window_size;
 	struct rcu_head rcu;
+	u32 page_shift;
+	u64 size;		/* in pages */
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 987f406..85ee572 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -40,10 +40,9 @@
 #include <asm/iommu.h>
 #include <asm/tce.h>
 
-static unsigned long kvmppc_stt_npages(unsigned long window_size)
+static unsigned long kvmppc_stt_npages(unsigned long size)
 {
-	return ALIGN((window_size >> IOMMU_PAGE_SHIFT_4K)
-		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
+	return ALIGN(size * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
 static long kvmppc_account_memlimit(unsigned long npages, bool inc)
@@ -92,8 +91,8 @@ static void release_spapr_tce_table(struct rcu_head *head)
 {
 	struct kvmppc_spapr_tce_table *stt = container_of(head,
 			struct kvmppc_spapr_tce_table, rcu);
-	int i;
-	unsigned long npages = kvmppc_stt_npages(stt->window_size);
+	unsigned long i;
+	unsigned long npages = kvmppc_stt_npages(stt->size);
 
 	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
@@ -106,7 +105,7 @@ static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	struct kvmppc_spapr_tce_table *stt = vma->vm_file->private_data;
 	struct page *page;
 
-	if (vmf->pgoff >= kvmppc_stt_npages(stt->window_size))
+	if (vmf->pgoff >= kvmppc_stt_npages(stt->size))
 		return VM_FAULT_SIGBUS;
 
 	page = stt->pages[vmf->pgoff];
@@ -133,7 +132,7 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 
 	kvm_put_kvm(stt->kvm);
 
-	kvmppc_account_memlimit(kvmppc_stt_npages(stt->window_size), false);
+	kvmppc_account_memlimit(kvmppc_stt_npages(stt->size), false);
 	call_rcu(&stt->rcu, release_spapr_tce_table);
 
 	return 0;
@@ -148,7 +147,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
-	unsigned long npages;
+	unsigned long npages, size;
 	int ret = -ENOMEM;
 	int i;
 
@@ -158,7 +157,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 			return -EBUSY;
 	}
 
-	npages = kvmppc_stt_npages(args->window_size);
+	size = args->window_size >> IOMMU_PAGE_SHIFT_4K;
+	npages = kvmppc_stt_npages(size);
 	ret = kvmppc_account_memlimit(npages, true);
 	if (ret) {
 		stt = NULL;
@@ -171,7 +171,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		goto fail;
 
 	stt->liobn = args->liobn;
-	stt->window_size = args->window_size;
+	stt->page_shift = IOMMU_PAGE_SHIFT_4K;
+	stt->size = size;
 	stt->kvm = kvm;
 
 	for (i = 0; i < npages; i++) {
@@ -220,7 +221,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
+	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
 }
@@ -239,7 +240,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (!stt)
 		return H_TOO_HARD;
 
-	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
+	entry = ioba >> stt->page_shift;
 	/*
 	 * SPAPR spec says that the maximum size of the list is 512 TCEs
 	 * so the whole table fits in 4K page
@@ -300,8 +301,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
-	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
-		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
+		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
 	return H_SUCCESS;
 }
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 58c63ed..01ef9f9 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -72,11 +72,10 @@ EXPORT_SYMBOL_GPL(kvmppc_find_table);
 long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages)
 {
-	unsigned long mask = IOMMU_PAGE_MASK_4K;
-	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
-	unsigned long size = stt->window_size >> IOMMU_PAGE_SHIFT_4K;
+	unsigned long mask = ~((1ULL << stt->page_shift) - 1);
+	unsigned long idx = ioba >> stt->page_shift;
 
-	if ((ioba & ~mask) || (idx + npages > size))
+	if ((ioba & ~mask) || (idx + npages > stt->size))
 		return H_PARAMETER;
 
 	return H_SUCCESS;
@@ -96,7 +95,8 @@ EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
  */
 long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
 {
-	unsigned long mask = IOMMU_PAGE_MASK_4K | TCE_PCI_WRITE | TCE_PCI_READ;
+	unsigned long mask = ~((1ULL << stt->page_shift) - 1) |
+			TCE_PCI_WRITE | TCE_PCI_READ;
 
 	if (tce & ~mask)
 		return H_PARAMETER;
@@ -197,7 +197,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
+	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
 }
@@ -242,7 +242,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (!stt)
 		return H_TOO_HARD;
 
-	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
+	entry = ioba >> stt->page_shift;
 	/*
 	 * The spec says that the maximum size of the list is 512 TCEs
 	 * so the whole table addressed resides in 4K page
@@ -302,8 +302,8 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
-	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
-		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
+		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
 	return H_SUCCESS;
 }
@@ -324,7 +324,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	idx = ioba >> stt->page_shift;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
-- 
2.5.0.rc3
