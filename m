Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXmjH58s9zDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 22:05:39 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8CC2vK5060921
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 08:05:37 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ccg9xmpj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 08:05:36 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 12 Sep 2016 06:05:35 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] KVM: PPC: Book3S HV: Fall back to same size HPT in
 allocation ioctl
In-Reply-To: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
Date: Mon, 12 Sep 2016 17:35:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760q1pblj.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> When the HPT size is explicitly passed on from the userspace, currently
> the KVM_PPC_ALLOCATE_HTAB will try to allocate the requested size of HPT
> from reserved CMA area and if that is not possible, the allocation just
> fails. With the commit 572abd563befd56 ("KVM: PPC: Book3S HV: Don't fall
> back to smaller HPT size in allocation ioctl"), it does not even try to
> allocate the same order pages from the page allocator before failing for
> good. Same order allocation should be attempted from the page allocator
> as a fallback option when the CMA allocation attempt fails.

IMO we should fix the reason for these CMA allocation failure. We are just
doing work around here.

>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> - This change saves guests from failing to start after migration
>
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 05f09ae..0a30eb4 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -78,6 +78,14 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>  			--order;
>  	}
>
> +	/*
> +	 * Fallback in case the userspace has provided a size via ioctl.
> +	 * Try allocating the same order pages from the page allocator.
> +	 */
> +	if (!hpt && order > PPC_MIN_HPT_ORDER && htab_orderp)
> +		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
> +			__GFP_NOWARN, order - PAGE_SHIFT);
> +
>  	if (!hpt)
>  		return -ENOMEM;

A better way to do that would be (not even compile tested) ?

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 65b2b00d93d7..3f8995f27339 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -68,16 +68,18 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
 		memset((void *)hpt, 0, (1ul << order));
 		kvm->arch.hpt_cma_alloc = 1;
 	}
-
-	/* Lastly try successively smaller sizes from the page allocator */
-	/* Only do this if userspace didn't specify a size via ioctl */
-	while (!hpt && order > PPC_MIN_HPT_ORDER && !htab_orderp) {
+	/*
+	 * Try successively smaller sizes from the page allocator.
+	 * If a size was specified via an ioctl, we just try that
+	 * specific size
+	 */
+-	while (!hpt && order > PPC_MIN_HPT_ORDER) {
 		hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
 				       __GFP_NOWARN, order - PAGE_SHIFT);
-		if (!hpt)
-			--order;
+		if (htab_orderp)
+			break;
+		--order;
 	}
-
 	if (!hpt)
 		return -ENOMEM;
 
