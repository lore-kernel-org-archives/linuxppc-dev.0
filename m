Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3E644140103
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 09:49:48 +1000 (EST)
Message-ID: <1396828173.3671.22.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: numa pte should be handled via slow path in
 get_user_pages_fast
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 07 Apr 2014 09:49:33 +1000
In-Reply-To: <1396454859-5274-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1396454859-5274-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-02 at 21:37 +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> We need to handle numa pte via the slow path

Is this -stable material ? If yes how far back ?

Cheers,
Ben.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/gup.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
> index c5f734e20b0f..d8746684f606 100644
> --- a/arch/powerpc/mm/gup.c
> +++ b/arch/powerpc/mm/gup.c
> @@ -36,6 +36,11 @@ static noinline int gup_pte_range(pmd_t pmd, unsigned long addr,
>  	do {
>  		pte_t pte = ACCESS_ONCE(*ptep);
>  		struct page *page;
> +		/*
> +		 * Similar to the PMD case, NUMA hinting must take slow path
> +		 */
> +		if (pte_numa(pte))
> +			return 0;
>  
>  		if ((pte_val(pte) & mask) != result)
>  			return 0;
> @@ -75,6 +80,14 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>  		if (pmd_none(pmd) || pmd_trans_splitting(pmd))
>  			return 0;
>  		if (pmd_huge(pmd) || pmd_large(pmd)) {
> +			/*
> +			 * NUMA hinting faults need to be handled in the GUP
> +			 * slowpath for accounting purposes and so that they
> +			 * can be serialised against THP migration.
> +			 */
> +			if (pmd_numa(pmd))
> +				return 0;
> +
>  			if (!gup_hugepte((pte_t *)pmdp, PMD_SIZE, addr, next,
>  					 write, pages, nr))
>  				return 0;
