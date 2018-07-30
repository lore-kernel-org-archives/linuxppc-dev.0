Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fMC674z0zF164
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:19:30 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6UEF0hZ033210
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 10:19:28 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kj340uy7u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 10:19:28 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 30 Jul 2018 15:19:26 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 npiggin@gmail.com
Subject: Re: [PATCH 2/3] powerpc/pseries/mm: factorize PTE slot computation
In-Reply-To: <1532699493-10883-3-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1532699493-10883-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1532699493-10883-3-git-send-email-ldufour@linux.vnet.ibm.com>
Date: Mon, 30 Jul 2018 19:49:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87in4wolga.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> This part of code will be called also when dealing with H_BLOCK_REMOVE.
>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> ---
>  arch/powerpc/platforms/pseries/lpar.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index 52eeff1297f4..96b8cd8a802d 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -547,6 +547,24 @@ static int pSeries_lpar_hpte_removebolted(unsigned long ea,
>  	return 0;
>  }
>  
> +
> +static inline unsigned long compute_slot(real_pte_t pte,
> +					 unsigned long vpn,
> +					 unsigned long index,
> +					 unsigned long shift,
> +					 int ssize)
> +{
> +	unsigned long slot, hash, hidx;
> +
> +	hash = hpt_hash(vpn, shift, ssize);
> +	hidx = __rpte_to_hidx(pte, index);
> +	if (hidx & _PTEIDX_SECONDARY)
> +		hash = ~hash;
> +	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> +	slot += hidx & _PTEIDX_GROUP_IX;
> +	return slot;
> +}
> +
>  /*
>   * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
>   * lock.
> @@ -559,7 +577,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
>  	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
>  	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
>  	unsigned long param[PLPAR_HCALL9_BUFSIZE];
> -	unsigned long hash, index, shift, hidx, slot;
> +	unsigned long index, shift, slot;
>  	real_pte_t pte;
>  	int psize, ssize;
>  
> @@ -573,12 +591,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
>  		vpn = batch->vpn[i];
>  		pte = batch->pte[i];
>  		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
> -			hash = hpt_hash(vpn, shift, ssize);
> -			hidx = __rpte_to_hidx(pte, index);
> -			if (hidx & _PTEIDX_SECONDARY)
> -				hash = ~hash;
> -			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
> -			slot += hidx & _PTEIDX_GROUP_IX;
> +			slot = compute_slot(pte, vpn, index, shift, ssize);
>  			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
>  				/*
>  				 * lpar doesn't use the passed actual page size
> -- 
> 2.7.4
