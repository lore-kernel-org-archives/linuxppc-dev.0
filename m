Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 595841A0B56
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:52 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 1 Mar 2016 16:55:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5CA9A2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u216tVSm4718950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u216t6u5015759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:07 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: kvm-ppc@vger.kernel.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH kernel v2 2/4] KVM: PPC: Add @page_shift to
 kvmppc_spapr_tce_table
Date: Tue,  1 Mar 2016 17:54:38 +1100
Message-Id: <1456815280-38546-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1456815280-38546-1-git-send-email-aik@ozlabs.ru>
References: <1456815280-38546-1-git-send-email-aik@ozlabs.ru>
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

This should cause no behavioural change as this is changing
the internal structures only - the user interface still only
allows one to create a 32-bit table with 4KiB pages at this stage.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v3:
* added a note that this only changes the internal structure
---
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s_64_vio.c    | 22 +++++++++++-----------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 21 ++++++++++-----------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ffdbc2d..edf66f7 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -182,8 +182,9 @@ struct kvmppc_spapr_tce_table {
 	struct list_head list;
 	struct kvm *kvm;
 	u64 liobn;
-	u32 window_size;
 	struct rcu_head rcu;
+	u32 page_shift;
+	u64 size;		/* window size in pages */
 	struct page *pages[0];
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 94c8e7e..61cbc44 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -40,10 +40,9 @@
 #include <asm/iommu.h>
 #include <asm/tce.h>
 
-static unsigned long kvmppc_tce_pages(unsigned long window_size)
+static unsigned long kvmppc_tce_pages(unsigned long iommu_pages)
 {
-	return ALIGN((window_size >> IOMMU_PAGE_SHIFT_4K)
-		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
+	return ALIGN(iommu_pages * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
 }
 
 static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
@@ -95,8 +94,7 @@ static void release_spapr_tce_table(struct rcu_head *head)
 {
 	struct kvmppc_spapr_tce_table *stt = container_of(head,
 			struct kvmppc_spapr_tce_table, rcu);
-	int i;
-	unsigned long npages = kvmppc_tce_pages(stt->window_size);
+	unsigned long i, npages = kvmppc_tce_pages(stt->size);
 
 	for (i = 0; i < npages; i++)
 		__free_page(stt->pages[i]);
@@ -109,7 +107,7 @@ static int kvm_spapr_tce_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 	struct kvmppc_spapr_tce_table *stt = vma->vm_file->private_data;
 	struct page *page;
 
-	if (vmf->pgoff >= kvmppc_tce_pages(stt->window_size))
+	if (vmf->pgoff >= kvmppc_tce_pages(stt->size))
 		return VM_FAULT_SIGBUS;
 
 	page = stt->pages[vmf->pgoff];
@@ -137,7 +135,7 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 	kvm_put_kvm(stt->kvm);
 
 	kvmppc_account_memlimit(
-		kvmppc_stt_pages(kvmppc_tce_pages(stt->window_size)), false);
+		kvmppc_stt_pages(kvmppc_tce_pages(stt->size)), false);
 	call_rcu(&stt->rcu, release_spapr_tce_table);
 
 	return 0;
@@ -152,7 +150,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
-	unsigned long npages;
+	unsigned long npages, size;
 	int ret = -ENOMEM;
 	int i;
 
@@ -162,7 +160,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 			return -EBUSY;
 	}
 
-	npages = kvmppc_tce_pages(args->window_size);
+	size = args->window_size >> IOMMU_PAGE_SHIFT_4K;
+	npages = kvmppc_tce_pages(size);
 	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
 	if (ret) {
 		stt = NULL;
@@ -175,7 +174,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		goto fail;
 
 	stt->liobn = args->liobn;
-	stt->window_size = args->window_size;
+	stt->page_shift = IOMMU_PAGE_SHIFT_4K;
+	stt->size = size;
 	stt->kvm = kvm;
 
 	for (i = 0; i < npages; i++) {
@@ -218,7 +218,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (!stt)
 		return H_TOO_HARD;
 
-	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
+	entry = ioba >> stt->page_shift;
 	/*
 	 * SPAPR spec says that the maximum size of the list is 512 TCEs
 	 * so the whole table fits in 4K page
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 0486aa2..c786a58 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -72,11 +72,10 @@ EXPORT_SYMBOL_GPL(kvmppc_find_table);
 long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages)
 {
-	unsigned long mask = (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
-	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
-	unsigned long size = stt->window_size >> IOMMU_PAGE_SHIFT_4K;
+	unsigned long mask = (1ULL << stt->page_shift) - 1;
+	unsigned long idx = ioba >> stt->page_shift;
 
-	if ((ioba & mask) || (idx + npages > size) || (idx + npages < idx))
+	if ((ioba & mask) || (idx + npages > stt->size) || (idx + npages < idx))
 		return H_PARAMETER;
 
 	return H_SUCCESS;
@@ -96,8 +95,8 @@ EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
  */
 long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
 {
-	unsigned long mask =
-			~(IOMMU_PAGE_MASK_4K | TCE_PCI_WRITE | TCE_PCI_READ);
+	unsigned long page_mask = ~((1ULL << stt->page_shift) - 1);
+	unsigned long mask = ~(page_mask | TCE_PCI_WRITE | TCE_PCI_READ);
 
 	if (tce & mask)
 		return H_PARAMETER;
@@ -198,7 +197,7 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
+	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
 
 	return H_SUCCESS;
 }
@@ -244,7 +243,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (!stt)
 		return H_TOO_HARD;
 
-	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
+	entry = ioba >> stt->page_shift;
 	/*
 	 * The spec says that the maximum size of the list is 512 TCEs
 	 * so the whole table addressed resides in 4K page
@@ -313,8 +312,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
-	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
-		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
+	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
+		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
 	return H_SUCCESS;
 }
@@ -336,7 +335,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	idx = ioba >> stt->page_shift;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
-- 
2.5.0.rc3
