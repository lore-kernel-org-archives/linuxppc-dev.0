Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mmw15ZFTzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 10:58:41 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id x6-v6so3272349plv.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Aug 2018 17:58:41 -0700 (PDT)
Date: Fri, 10 Aug 2018 10:58:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/tlbflush: update the mmu_gather page size
 while iterating address range
Message-ID: <20180810105832.5074a7fc@roar.ozlabs.ibm.com>
In-Reply-To: <20180809133659.16230-1-aneesh.kumar@linux.ibm.com>
References: <20180809133659.16230-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  9 Aug 2018 19:06:59 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> This patch makes sure we update the mmu_gather page size even if we are
> requesting for a fullmm flush. This avoids triggering VM_WARN_ON in code
> paths like __tlb_remove_page_size that explicitly check for removing range page
> size to be same as mmu gather page size.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

Thanks, sorry bout that.

> ---
>  arch/powerpc/include/asm/tlb.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
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
