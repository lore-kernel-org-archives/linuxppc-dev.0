Return-Path: <nixiaoming@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdkTt0fhQzDrFM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 11:44:01 +1000 (AEST)
From: Nixiaoming <nixiaoming@huawei.com>
To: Paul Mackerras <paulus@ozlabs.org>
CC: David Hildenbrand <david@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH really v2] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
Date: Fri, 25 Aug 2017 01:43:39 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF1299B5025@DGGEMA505-MBX.china.huawei.com>
References: <20170824091447.GG27401@fergus.ozlabs.ibm.com>
In-Reply-To: <20170824091447.GG27401@fergus.ozlabs.ibm.com>
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

On 24.08.2017 11:14, Paul Mackerras wrote:
> Nixiaoming pointed out that there is a memory leak in
> kvm_vm_ioctl_create_spapr_tce() if the call to anon_inode_getfd()=20
> fails; the memory allocated for the kvmppc_spapr_tce_table struct is=20
> not freed, and nor are the pages allocated for the iommu tables.  In=20
> addition, we have already incremented the process's count of locked=20
> memory pages, and this doesn't get restored on error.
>=20
> David Hildenbrand pointed out that there is a race in that the=20
> function checks early on that there is not already an entry in the
> stt->iommu_tables list with the same LIOBN, but an entry with the
> same LIOBN could get added between then and when the new entry is=20
> added to the list.
>=20
> This fixes all three problems.  To simplify things, we now call
> anon_inode_getfd() before placing the new entry in the list.  The=20
> check for an existing entry is done while holding the kvm->lock mutex,=20
> immediately before adding the new entry to the list.
> Finally, on failure we now call kvmppc_account_memlimit to decrement=20
> the process's count of locked memory pages.
>=20
> Reported-by: Nixiaoming <nixiaoming@huawei.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
> v2: Don't overwrite stt in loop over spapr_tce_tables
>=20

Reviewed-by: nixiaoming  <nixiaoming@huawei.com>
