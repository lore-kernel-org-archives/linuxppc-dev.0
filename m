Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E186C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 08:16:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962742084B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 08:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962742084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XlY614QVzDqLt
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 19:16:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XlW93M4XzDqLn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 19:14:45 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 48BE9ACB1;
 Mon,  1 Apr 2019 08:14:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id DD5AC1E42C7; Mon,  1 Apr 2019 10:14:41 +0200 (CEST)
Date: Mon, 1 Apr 2019 10:14:41 +0200
From: Jan Kara <jack@suse.cz>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] mm: Fix modifying of page protection by insert_pfn_pmd()
Message-ID: <20190401081441.GD4826@quack2.suse.cz>
References: <20190330054121.27831-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330054121.27831-1-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org, stable@vger.kernel.org,
 linux-mm@kvack.org, dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat 30-03-19 11:11:21, Aneesh Kumar K.V wrote:
> With some architectures like ppc64, set_pmd_at() cannot cope with
> a situation where there is already some (different) valid entry present.
> 
> Use pmdp_set_access_flags() instead to modify the pfn which is built to
> deal with modifying existing PMD entries.
> 
> This is similar to
> commit cae85cb8add3 ("mm/memory.c: fix modifying of page protection by insert_pfn()")
> 
> We also do similar update w.r.t insert_pfn_pud eventhough ppc64 don't support
> pud pfn entries now.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Thanks for fixing this! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/huge_memory.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 404acdcd0455..f7dca413c4b2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -755,6 +755,20 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	spinlock_t *ptl;
>  
>  	ptl = pmd_lock(mm, pmd);
> +	if (!pmd_none(*pmd)) {
> +		if (write) {
> +			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
> +				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
> +				goto out_unlock;
> +			}
> +			entry = pmd_mkyoung(*pmd);
> +			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> +			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
> +				update_mmu_cache_pmd(vma, addr, pmd);
> +		}
> +		goto out_unlock;
> +	}
> +
>  	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
>  	if (pfn_t_devmap(pfn))
>  		entry = pmd_mkdevmap(entry);
> @@ -770,6 +784,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  
>  	set_pmd_at(mm, addr, pmd, entry);
>  	update_mmu_cache_pmd(vma, addr, pmd);
> +out_unlock:
>  	spin_unlock(ptl);
>  }
>  
> @@ -821,6 +836,20 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>  	spinlock_t *ptl;
>  
>  	ptl = pud_lock(mm, pud);
> +	if (!pud_none(*pud)) {
> +		if (write) {
> +			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
> +				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
> +				goto out_unlock;
> +			}
> +			entry = pud_mkyoung(*pud);
> +			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
> +			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
> +				update_mmu_cache_pud(vma, addr, pud);
> +		}
> +		goto out_unlock;
> +	}
> +
>  	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
>  	if (pfn_t_devmap(pfn))
>  		entry = pud_mkdevmap(entry);
> @@ -830,6 +859,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>  	}
>  	set_pud_at(mm, addr, pud, entry);
>  	update_mmu_cache_pud(vma, addr, pud);
> +
> +out_unlock:
>  	spin_unlock(ptl);
>  }
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
