Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB76C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:40:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B76E2085A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B76E2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449XDY2FyBzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 12:40:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 449XBv1Pp0zDq9C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 12:39:02 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 7609AAE8000A;
 Thu, 28 Feb 2019 20:38:29 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2] KVM: PPC: Allocate guest TCEs on demand too
Date: Fri,  1 Mar 2019 12:38:27 +1100
Message-Id: <20190301013827.30504-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We already allocate hardware TCE tables in multiple levels and skip
intermediate levels when we can, now it is a turn of the KVM TCE tables.
Thankfully these are allocated already in 2 levels.

This moves the table's last level allocation from the creating helper to
kvmppc_tce_put() and kvm_spapr_tce_fault().

This adds kvmppc_rm_ioba_validate() to do an additional test if
the consequent kvmppc_tce_put() needs a page which has not been allocated;
if this is the case, we bail out to virtual mode handlers.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* added kvm mutex around alloc_page to prevent races; in both place we
test the pointer, if NULL, then take a lock and check again so on a fast
path we do not take a lock at all


---
For NVLink2 passthrough guests with 128TiB DMA windows and very fragmented
system RAM the difference is gigabytes of RAM.
---
 arch/powerpc/kvm/book3s_64_vio.c    | 29 ++++++------
 arch/powerpc/kvm/book3s_64_vio_hv.c | 69 ++++++++++++++++++++++++++---
 2 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index f02b049..7eed8c9 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -228,7 +228,8 @@ static void release_spapr_tce_table(struct rcu_head *head)
 	unsigned long i, npages = kvmppc_tce_pages(stt->size);
 
 	for (i = 0; i < npages; i++)
-		__free_page(stt->pages[i]);
+		if (stt->pages[i])
+			__free_page(stt->pages[i]);
 
 	kfree(stt);
 }
@@ -242,6 +243,20 @@ static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 
 	page = stt->pages[vmf->pgoff];
+	if (!page) {
+		mutex_lock(&stt->kvm->lock);
+		page = stt->pages[vmf->pgoff];
+		if (!page) {
+			page  = alloc_page(GFP_KERNEL | __GFP_ZERO);
+			if (!page) {
+				mutex_unlock(&stt->kvm->lock);
+				return VM_FAULT_OOM;
+			}
+			stt->pages[vmf->pgoff] = page;
+		}
+		mutex_unlock(&stt->kvm->lock);
+	}
+
 	get_page(page);
 	vmf->page = page;
 	return 0;
@@ -296,7 +311,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	struct kvmppc_spapr_tce_table *siter;
 	unsigned long npages, size = args->size;
 	int ret = -ENOMEM;
-	int i;
 
 	if (!args->size || args->page_shift < 12 || args->page_shift > 34 ||
 		(args->offset + args->size > (ULLONG_MAX >> args->page_shift)))
@@ -320,12 +334,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	stt->kvm = kvm;
 	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
 
-	for (i = 0; i < npages; i++) {
-		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
-		if (!stt->pages[i])
-			goto fail;
-	}
-
 	mutex_lock(&kvm->lock);
 
 	/* Check this LIOBN hasn't been previously allocated */
@@ -352,11 +360,6 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	if (ret >= 0)
 		return ret;
 
- fail:
-	for (i = 0; i < npages; i++)
-		if (stt->pages[i])
-			__free_page(stt->pages[i]);
-
 	kfree(stt);
  fail_acct:
 	kvmppc_account_memlimit(kvmppc_stt_pages(npages), false);
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 2206bc7..a0912d5 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -158,23 +158,76 @@ static u64 *kvmppc_page_address(struct page *page)
 	return (u64 *) page_address(page);
 }
 
+/*
+ * TCEs pages are allocated in kvmppc_tce_put() which won't be able to do so
+ * in real mode.
+ * Check if kvmppc_tce_put() can succeed in real mode, i.e. a TCEs page is
+ * allocated or not required (when clearing a tce entry).
+ */
+static long kvmppc_rm_ioba_validate(struct kvmppc_spapr_tce_table *stt,
+		unsigned long ioba, unsigned long npages, bool clearing)
+{
+	unsigned long i, sttpage, sttpages;
+	unsigned long ret = kvmppc_ioba_validate(stt, ioba, npages);
+
+	if (ret)
+		return ret;
+	/*
+	 * clearing==true says kvmppc_tce_put won't be allocating pages
+	 * for empty tces.
+	 */
+	if (clearing)
+		return H_SUCCESS;
+
+	sttpage = ((ioba >> stt->page_shift) - stt->offset) / TCES_PER_PAGE;
+	sttpages = (npages + TCES_PER_PAGE - 1) / TCES_PER_PAGE;
+	for (i = sttpage; i < sttpage + sttpages; ++i)
+		if (!stt->pages[i])
+			return H_TOO_HARD;
+
+	return H_SUCCESS;
+}
+
 /*
  * Handles TCE requests for emulated devices.
  * Puts guest TCE values to the table and expects user space to convert them.
  * Called in both real and virtual modes.
  * Cannot fail so kvmppc_tce_validate must be called before it.
  *
- * WARNING: This will be called in real-mode on HV KVM and virtual
- *          mode on PR KVM
+ * WARNING: This will be called in real-mode on HV HPT KVM and virtual
+ *          mode on PR KVM or HV radix KVM
  */
 void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 		unsigned long idx, unsigned long tce)
 {
 	struct page *page;
 	u64 *tbl;
+	unsigned long sttpage;
 
 	idx -= stt->offset;
-	page = stt->pages[idx / TCES_PER_PAGE];
+	sttpage = idx / TCES_PER_PAGE;
+	page = stt->pages[sttpage];
+
+	if (!page) {
+		/* We allow any TCE, not just with read|write permissions */
+		if (!tce)
+			return;
+		/*
+		 * We must not end up here in real mode,
+		 * kvmppc_rm_ioba_validate() takes care of this.
+		 */
+		mutex_lock(&stt->kvm->lock);
+		page = stt->pages[sttpage];
+		if (!page) {
+			page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+			if (WARN_ON_ONCE(!page)) {
+				mutex_unlock(&stt->kvm->lock);
+				return;
+			}
+			stt->pages[sttpage] = page;
+		}
+		mutex_unlock(&stt->kvm->lock);
+	}
 	tbl = kvmppc_page_address(page);
 
 	tbl[idx % TCES_PER_PAGE] = tce;
@@ -381,7 +434,7 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (!stt)
 		return H_TOO_HARD;
 
-	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	ret = kvmppc_rm_ioba_validate(stt, ioba, 1, tce == 0);
 	if (ret != H_SUCCESS)
 		return ret;
 
@@ -480,7 +533,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	if (tce_list & (SZ_4K - 1))
 		return H_PARAMETER;
 
-	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	ret = kvmppc_rm_ioba_validate(stt, ioba, npages, false);
 	if (ret != H_SUCCESS)
 		return ret;
 
@@ -583,7 +636,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (!stt)
 		return H_TOO_HARD;
 
-	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	ret = kvmppc_rm_ioba_validate(stt, ioba, npages, tce_value == 0);
 	if (ret != H_SUCCESS)
 		return ret;
 
@@ -635,6 +688,10 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	idx = (ioba >> stt->page_shift) - stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
+	if (!page) {
+		vcpu->arch.regs.gpr[4] = 0;
+		return H_SUCCESS;
+	}
 	tbl = (u64 *)page_address(page);
 
 	vcpu->arch.regs.gpr[4] = tbl[idx % TCES_PER_PAGE];
-- 
2.17.1

