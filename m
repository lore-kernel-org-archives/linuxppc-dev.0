Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdJXW0BHrzDqY8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 19:14:51 +1000 (AEST)
Date: Thu, 24 Aug 2017 19:14:47 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: nixiaoming <nixiaoming@huawei.com>, David Hildenbrand <david@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH really v2] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
Message-ID: <20170824091447.GG27401@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nixiaoming pointed out that there is a memory leak in
kvm_vm_ioctl_create_spapr_tce() if the call to anon_inode_getfd()
fails; the memory allocated for the kvmppc_spapr_tce_table struct
is not freed, and nor are the pages allocated for the iommu
tables.  In addition, we have already incremented the process's
count of locked memory pages, and this doesn't get restored on
error.

David Hildenbrand pointed out that there is a race in that the
function checks early on that there is not already an entry in the
stt->iommu_tables list with the same LIOBN, but an entry with the
same LIOBN could get added between then and when the new entry is
added to the list.

This fixes all three problems.  To simplify things, we now call
anon_inode_getfd() before placing the new entry in the list.  The
check for an existing entry is done while holding the kvm->lock
mutex, immediately before adding the new entry to the list.
Finally, on failure we now call kvmppc_account_memlimit to
decrement the process's count of locked memory pages.

Reported-by: Nixiaoming <nixiaoming@huawei.com>
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
v2: Don't overwrite stt in loop over spapr_tce_tables

 arch/powerpc/kvm/book3s_64_vio.c | 56 ++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index a160c14..53766e2 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -294,32 +294,26 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				   struct kvm_create_spapr_tce_64 *args)
 {
 	struct kvmppc_spapr_tce_table *stt = NULL;
+	struct kvmppc_spapr_tce_table *siter;
 	unsigned long npages, size;
 	int ret = -ENOMEM;
 	int i;
+	int fd = -1;
 
 	if (!args->size)
 		return -EINVAL;
 
-	/* Check this LIOBN hasn't been previously allocated */
-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
-		if (stt->liobn == args->liobn)
-			return -EBUSY;
-	}
-
 	size = _ALIGN_UP(args->size, PAGE_SIZE >> 3);
 	npages = kvmppc_tce_pages(size);
 	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
-	if (ret) {
-		stt = NULL;
-		goto fail;
-	}
+	if (ret)
+		return ret;
 
 	ret = -ENOMEM;
 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
 		      GFP_KERNEL);
 	if (!stt)
-		goto fail;
+		goto fail_acct;
 
 	stt->liobn = args->liobn;
 	stt->page_shift = args->page_shift;
@@ -334,24 +328,42 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 			goto fail;
 	}
 
-	kvm_get_kvm(kvm);
+	ret = fd = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
+				    stt, O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto fail;
 
 	mutex_lock(&kvm->lock);
-	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
+
+	/* Check this LIOBN hasn't been previously allocated */
+	ret = 0;
+	list_for_each_entry(siter, &kvm->arch.spapr_tce_tables, list) {
+		if (siter->liobn == args->liobn) {
+			ret = -EBUSY;
+			break;
+		}
+	}
+
+	if (!ret) {
+		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
+		kvm_get_kvm(kvm);
+	}
 
 	mutex_unlock(&kvm->lock);
 
-	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
-				stt, O_RDWR | O_CLOEXEC);
+	if (!ret)
+		return fd;
 
-fail:
-	if (stt) {
-		for (i = 0; i < npages; i++)
-			if (stt->pages[i])
-				__free_page(stt->pages[i]);
+	put_unused_fd(fd);
 
-		kfree(stt);
-	}
+ fail:
+	for (i = 0; i < npages; i++)
+		if (stt->pages[i])
+			__free_page(stt->pages[i]);
+
+	kfree(stt);
+ fail_acct:
+	kvmppc_account_memlimit(kvmppc_stt_pages(npages), false);
 	return ret;
 }
 
-- 
2.7.4
