Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 72B811007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 14:58:38 +1100 (EST)
Message-ID: <1322539102.23348.57.camel@pasglop>
Subject: Re: [PATCH 02/13] powerpc: hugetlb: fix huge_ptep_set_access_flags
 return value
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Date: Tue, 29 Nov 2011 14:58:22 +1100
In-Reply-To: <13182798643553-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-10-10 at 15:50 -0500, Becky Bruce wrote:

> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 8600493..70f9885 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -124,7 +124,18 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
>  {
> +#if defined(CONFIG_PPC_MMU_NOHASH) && \
> +	!(defined(CONFIG_PPC_FSL_BOOK3E) && defined(CONFIG_PPC32))

The above conditional makes my brain hurt. Can you change that to
instead

#ifdef HUGETLB_NEED_PRELOAD

 ... or something like that, which you then #define in the right
mmu-xxxx.h header ?

Cheers,
Ben.


> +	/*
> +	 * The "return 1" forces a call of update_mmu_cache, which will write a
> +	 * TLB entry.  Without this, platforms that don't do a write of the TLB
> +	 * entry in the TLB miss handler asm will fault ad infinitum.
> +	 */
> +	ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> +	return 1;
> +#else
>  	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> +#endif
>  }
>  
>  static inline pte_t huge_ptep_get(pte_t *ptep)
