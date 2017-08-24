Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdHpd0wjqzDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 18:42:01 +1000 (AEST)
Date: Thu, 24 Aug 2017 18:14:21 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nixiaoming <nixiaoming@huawei.com>
Cc: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Hildenbrand <david@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
Message-ID: <20170824081421.GD27401@fergus.ozlabs.ibm.com>
References: <20170824034008.GB27401@fergus.ozlabs.ibm.com>
 <E490CD805F7529488761C40FD9D26EF1299B4BB2@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E490CD805F7529488761C40FD9D26EF1299B4BB2@DGGEMA505-MBX.china.huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2017 at 06:43:22AM +0000, Nixiaoming wrote:
> >From: Paul Mackerras [mailto:paulus@ozlabs.org]  Thursday, August 24, 2017 11:40 AM
> >
> >Nixiaoming pointed out that there is a memory leak in
> >kvm_vm_ioctl_create_spapr_tce() if the call to anon_inode_getfd() fails; the memory allocated for the kvmppc_spapr_tce_table struct is not freed, and nor are the pages allocated for the iommu tables.  In addition, we have already incremented the process's count of locked memory pages, and this doesn't get restored on error.
> >
> >David Hildenbrand pointed out that there is a race in that the function checks early on that there is not already an entry in the
> >stt->iommu_tables list with the same LIOBN, but an entry with the
> >same LIOBN could get added between then and when the new entry is added to the list.
> >
> >This fixes all three problems.  To simplify things, we now call
> >anon_inode_getfd() before placing the new entry in the list.  The check for an existing entry is done while holding the kvm->lock mutex, immediately before adding the new entry to the list.
> >Finally, on failure we now call kvmppc_account_memlimit to decrement the process's count of locked memory pages.
> >
> >Reported-by: Nixiaoming <nixiaoming@huawei.com>
> >Reported-by: David Hildenbrand <david@redhat.com>
> >Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> >---
> > arch/powerpc/kvm/book3s_64_vio.c | 55 ++++++++++++++++++++++++----------------
> > 1 file changed, 33 insertions(+), 22 deletions(-)
> >
> >diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> >index a160c14304eb..d463c1cd0d8d 100644
> >--- a/arch/powerpc/kvm/book3s_64_vio.c
> >+++ b/arch/powerpc/kvm/book3s_64_vio.c
> >@@ -297,29 +297,22 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> > 	unsigned long npages, size;
> > 	int ret = -ENOMEM;
> > 	int i;
> >+	int fd = -1;
> > 
> > 	if (!args->size)
> > 		return -EINVAL;
> > 
> >-	/* Check this LIOBN hasn't been previously allocated */
> >-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> >-		if (stt->liobn == args->liobn)
> >-			return -EBUSY;
> >-	}
> >-
> > 	size = _ALIGN_UP(args->size, PAGE_SIZE >> 3);
> > 	npages = kvmppc_tce_pages(size);
> > 	ret = kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
> >-	if (ret) {
> >-		stt = NULL;
> >-		goto fail;
> >-	}
> >+	if (ret)
> >+		return ret;
> > 
> > 	ret = -ENOMEM;
> > 	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
> > 		      GFP_KERNEL);
> > 	if (!stt)
> >-		goto fail;
> >+		goto fail_acct;
> > 
> > 	stt->liobn = args->liobn;
> > 	stt->page_shift = args->page_shift;
> >@@ -334,24 +327,42 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> > 			goto fail;
> > 	}
> > 
> >-	kvm_get_kvm(kvm);
> >+	ret = fd = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> >+				    stt, O_RDWR | O_CLOEXEC);
> >+	if (ret < 0)
> >+		goto fail;
> > 
> > 	mutex_lock(&kvm->lock);
> >-	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> >+
> >+	/* Check this LIOBN hasn't been previously allocated */
> >+	ret = 0;
> >+	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> 
> I think stt can not be used here
> need a new value for list_for_each_entry

Yes.  Good point.  New version coming.

Paul.
