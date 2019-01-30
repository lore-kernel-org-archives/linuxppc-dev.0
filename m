Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534AEC282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 10:56:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21D520857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 10:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21D520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qKzl1XHSzDqVT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 21:56:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qKy02svtzDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 21:54:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qKy00FvPz9s3q;
 Wed, 30 Jan 2019 21:54:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 x86@kernel.org
Subject: Re: [PATCH V5 4/5] mm/hugetlb: Add prot_modify_start/commit sequence
 for hugetlb update
In-Reply-To: <20190116085035.29729-5-aneesh.kumar@linux.ibm.com>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
 <20190116085035.29729-5-aneesh.kumar@linux.ibm.com>
Date: Wed, 30 Jan 2019 21:54:47 +1100
Message-ID: <87d0oequtk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Architectures like ppc64 require to do a conditional tlb flush based on the old
> and new value of pte. Follow the regular pte change protection sequence for
> hugetlb too. This allows the architectures to override the update sequence.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/hugetlb.h | 20 ++++++++++++++++++++
>  mm/hugetlb.c            |  8 +++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 087fd5f48c91..39e78b80375c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -543,6 +543,26 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>  	set_huge_pte_at(mm, addr, ptep, pte);
>  }
>  #endif
> +
> +#ifndef huge_ptep_modify_prot_start
> +#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
> +static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
> +						unsigned long addr, pte_t *ptep)
> +{
> +	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +}
> +#endif
> +
> +#ifndef huge_ptep_modify_prot_commit
> +#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
> +static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
> +						unsigned long addr, pte_t *ptep,
> +						pte_t old_pte, pte_t pte)
> +{
> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
> +}
> +#endif
> +
>  #else	/* CONFIG_HUGETLB_PAGE */
>  struct hstate {};
>  #define alloc_huge_page(v, a, r) NULL
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index df2e7dd5ff17..f824d2200ca9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4387,10 +4387,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  			continue;
>  		}
>  		if (!huge_pte_none(pte)) {
> -			pte = huge_ptep_get_and_clear(mm, address, ptep);
> -			pte = pte_mkhuge(huge_pte_modify(pte, newprot));
> +			pte_t old_pte;
> +
> +			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
> +			pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
>  			pte = arch_make_huge_pte(pte, vma, NULL, 0);
> -			set_huge_pte_at(mm, address, ptep, pte);
> +			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
>  			pages++;
>  		}
>  		spin_unlock(ptl);

Looks like a faithful conversion.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
