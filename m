Return-Path: <nixiaoming@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdFB61npzzDrK9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 16:43:41 +1000 (AEST)
From: Nixiaoming <nixiaoming@huawei.com>
To: Paul Mackerras <paulus@ozlabs.org>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: David Hildenbrand <david@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [PATCH] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
Date: Thu, 24 Aug 2017 06:43:22 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF1299B4BB2@DGGEMA505-MBX.china.huawei.com>
References: <20170824034008.GB27401@fergus.ozlabs.ibm.com>
In-Reply-To: <20170824034008.GB27401@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From: Paul Mackerras [mailto:paulus@ozlabs.org]  Thursday, August 24, 2017=
 11:40 AM
>
>Nixiaoming pointed out that there is a memory leak in
>kvm_vm_ioctl_create_spapr_tce() if the call to anon_inode_getfd() fails; t=
he memory allocated for the kvmppc_spapr_tce_table struct is not freed, and=
 nor are the pages allocated for the iommu tables.  In addition, we have al=
ready incremented the process's count of locked memory pages, and this does=
n't get restored on error.
>
>David Hildenbrand pointed out that there is a race in that the function ch=
ecks early on that there is not already an entry in the
>stt->iommu_tables list with the same LIOBN, but an entry with the
>same LIOBN could get added between then and when the new entry is added to=
 the list.
>
>This fixes all three problems.  To simplify things, we now call
>anon_inode_getfd() before placing the new entry in the list.  The check fo=
r an existing entry is done while holding the kvm->lock mutex, immediately =
before adding the new entry to the list.
>Finally, on failure we now call kvmppc_account_memlimit to decrement the p=
rocess's count of locked memory pages.
>
>Reported-by: Nixiaoming <nixiaoming@huawei.com>
>Reported-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
>---
> arch/powerpc/kvm/book3s_64_vio.c | 55 ++++++++++++++++++++++++-----------=
-----
> 1 file changed, 33 insertions(+), 22 deletions(-)
>
>diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64=
_vio.c
>index a160c14304eb..d463c1cd0d8d 100644
>--- a/arch/powerpc/kvm/book3s_64_vio.c
>+++ b/arch/powerpc/kvm/book3s_64_vio.c
>@@ -297,29 +297,22 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> 	unsigned long npages, size;
> 	int ret =3D -ENOMEM;
> 	int i;
>+	int fd =3D -1;
>=20
> 	if (!args->size)
> 		return -EINVAL;
>=20
>-	/* Check this LIOBN hasn't been previously allocated */
>-	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
>-		if (stt->liobn =3D=3D args->liobn)
>-			return -EBUSY;
>-	}
>-
> 	size =3D _ALIGN_UP(args->size, PAGE_SIZE >> 3);
> 	npages =3D kvmppc_tce_pages(size);
> 	ret =3D kvmppc_account_memlimit(kvmppc_stt_pages(npages), true);
>-	if (ret) {
>-		stt =3D NULL;
>-		goto fail;
>-	}
>+	if (ret)
>+		return ret;
>=20
> 	ret =3D -ENOMEM;
> 	stt =3D kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
> 		      GFP_KERNEL);
> 	if (!stt)
>-		goto fail;
>+		goto fail_acct;
>=20
> 	stt->liobn =3D args->liobn;
> 	stt->page_shift =3D args->page_shift;
>@@ -334,24 +327,42 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> 			goto fail;
> 	}
>=20
>-	kvm_get_kvm(kvm);
>+	ret =3D fd =3D anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>+				    stt, O_RDWR | O_CLOEXEC);
>+	if (ret < 0)
>+		goto fail;
>=20
> 	mutex_lock(&kvm->lock);
>-	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
>+
>+	/* Check this LIOBN hasn't been previously allocated */
>+	ret =3D 0;
>+	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {

I think stt can not be used here
need a new value for list_for_each_entry


>+		if (stt->liobn =3D=3D args->liobn) {
>+			ret =3D -EBUSY;
>+			break;
>+		}
>+	}
>+
>+	if (!ret) {
>+		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
>+		kvm_get_kvm(kvm);
>+	}
>=20
> 	mutex_unlock(&kvm->lock);
>=20
>-	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>-				stt, O_RDWR | O_CLOEXEC);
>+	if (!ret)
>+		return fd;
>=20
>-fail:
>-	if (stt) {
>-		for (i =3D 0; i < npages; i++)
>-			if (stt->pages[i])
>-				__free_page(stt->pages[i]);
>+	put_unused_fd(fd);
>=20
>-		kfree(stt);
>-	}
>+ fail:
>+	for (i =3D 0; i < npages; i++)
>+		if (stt->pages[i])
>+			__free_page(stt->pages[i]);
>+
>+	kfree(stt);
>+ fail_acct:
>+	kvmppc_account_memlimit(kvmppc_stt_pages(npages), false);
> 	return ret;
> }
>=20
>--
>2.11.0


Thanks
