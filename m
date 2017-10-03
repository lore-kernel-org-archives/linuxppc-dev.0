Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5zdX07XFzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 23:59:44 +1100 (AEDT)
Date: Tue, 3 Oct 2017 14:59:40 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
Subject: Re: [PATCH v9 04/12] sparc64: simplify vmemmap_populate
Message-ID: <20171003125940.6d5fyhwx2lkzxn67@dhcp22.suse.cz>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-5-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920201714.19817-5-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed 20-09-17 16:17:06, Pavel Tatashin wrote:
> Remove duplicating code by using common functions
> vmemmap_pud_populate and vmemmap_pgd_populate.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>
> Acked-by: David S. Miller <davem@davemloft.net>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/sparc/mm/init_64.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 310c6754bcaa..99aea4d15a5f 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2651,30 +2651,19 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>  	vstart = vstart & PMD_MASK;
>  	vend = ALIGN(vend, PMD_SIZE);
>  	for (; vstart < vend; vstart += PMD_SIZE) {
> -		pgd_t *pgd = pgd_offset_k(vstart);
> +		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
>  		unsigned long pte;
>  		pud_t *pud;
>  		pmd_t *pmd;
>  
> -		if (pgd_none(*pgd)) {
> -			pud_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
> +		if (!pgd)
> +			return -ENOMEM;
>  
> -			if (!new)
> -				return -ENOMEM;
> -			pgd_populate(&init_mm, pgd, new);
> -		}
> -
> -		pud = pud_offset(pgd, vstart);
> -		if (pud_none(*pud)) {
> -			pmd_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
> -
> -			if (!new)
> -				return -ENOMEM;
> -			pud_populate(&init_mm, pud, new);
> -		}
> +		pud = vmemmap_pud_populate(pgd, vstart, node);
> +		if (!pud)
> +			return -ENOMEM;
>  
>  		pmd = pmd_offset(pud, vstart);
> -
>  		pte = pmd_val(*pmd);
>  		if (!(pte & _PAGE_VALID)) {
>  			void *block = vmemmap_alloc_block(PMD_SIZE, node);
> -- 
> 2.14.1

-- 
Michal Hocko
SUSE Labs
