Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdWQZ6H70zDrJN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 03:25:26 +1000 (AEST)
Subject: Re: [PATCH really v2] KVM: PPC: Book3S: Fix race and leak in
 kvm_vm_ioctl_create_spapr_tce()
To: Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: nixiaoming <nixiaoming@huawei.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170824091447.GG27401@fergus.ozlabs.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <88b11c61-08e7-f1a3-6930-578f539ce546@redhat.com>
Date: Thu, 24 Aug 2017 19:25:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170824091447.GG27401@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
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
> kvm_vm_ioctl_create_spapr_tce() if the call to anon_inode_getfd()
> fails; the memory allocated for the kvmppc_spapr_tce_table struct
> is not freed, and nor are the pages allocated for the iommu
> tables.  In addition, we have already incremented the process's
> count of locked memory pages, and this doesn't get restored on
> error.
> 
> David Hildenbrand pointed out that there is a race in that the
> function checks early on that there is not already an entry in the
> stt->iommu_tables list with the same LIOBN, but an entry with the
> same LIOBN could get added between then and when the new entry is
> added to the list.
> 
> This fixes all three problems.  To simplify things, we now call
> anon_inode_getfd() before placing the new entry in the list.  The
> check for an existing entry is done while holding the kvm->lock
> mutex, immediately before adding the new entry to the list.
> Finally, on failure we now call kvmppc_account_memlimit to
> decrement the process's count of locked memory pages.
> 
> Reported-by: Nixiaoming <nixiaoming@huawei.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
> v2: Don't overwrite stt in loop over spapr_tce_tables
> 

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David
