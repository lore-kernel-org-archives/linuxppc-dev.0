Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bHPL4jXlzF1Pw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 00:17:42 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PEEt8X024315
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 10:17:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kest6kkwv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 10:17:36 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 25 Jul 2018 15:17:35 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s/radix: tlb do not flush on page size when
 fullmm
In-Reply-To: <20180725135806.29648-1-npiggin@gmail.com>
References: <20180725135806.29648-1-npiggin@gmail.com>
Date: Wed, 25 Jul 2018 19:47:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87sh47o0w6.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> When the mm is being torn down there will be a full PID flush so
> there is no need to flush the TLB on page size changes.

and that tlb flush is PID flush since tlb->fulmm is set? So this avoids
multiple PID tlb flush.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/tlb.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index 5d3107f2b014..d1b3dc4a6a0a 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -84,6 +84,9 @@ static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
>  static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
>  						     unsigned int page_size)
>  {
> +	if (tlb->fullmm)
> +		return;
> +
>  	if (!tlb->page_size)
>  		tlb->page_size = page_size;
>  	else if (tlb->page_size != page_size) {
> -- 
> 2.17.0
