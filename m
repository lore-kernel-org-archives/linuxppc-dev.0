Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mx7t68LkzF1d7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 17:09:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm/tlbflush: update the mmu_gather page size
 while iterating address range
In-Reply-To: <20180809133659.16230-1-aneesh.kumar@linux.ibm.com>
References: <20180809133659.16230-1-aneesh.kumar@linux.ibm.com>
Date: Fri, 10 Aug 2018 17:09:29 +1000
Message-ID: <87mutu8zpy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This patch makes sure we update the mmu_gather page size even if we are
> requesting for a fullmm flush. This avoids triggering VM_WARN_ON in code
> paths like __tlb_remove_page_size that explicitly check for removing range page
> size to be same as mmu gather page size.

I take it this is a fix for 5a6099346c41 ("powerpc/64s/radix: tlb do not flush on page size when fullmm") ?

cheers

> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index 97ecef697e1b..f0e571b2dc7c 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -49,13 +49,11 @@ static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
>  static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
>  						     unsigned int page_size)
>  {
> -	if (tlb->fullmm)
> -		return;
> -
>  	if (!tlb->page_size)
>  		tlb->page_size = page_size;
>  	else if (tlb->page_size != page_size) {
> -		tlb_flush_mmu(tlb);
> +		if (!tlb->fullmm)
> +			tlb_flush_mmu(tlb);
>  		/*
>  		 * update the page size after flush for the new
>  		 * mmu_gather.
> -- 
> 2.17.1
