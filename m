Return-Path: <scottwood@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B116B70DA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2011 10:58:23 +1100 (EST)
Date: Wed, 5 Jan 2011 17:42:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: michael <michael@evidence.eu.com>, Rex Feany <RFeany@mrv.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
Message-ID: <20110105174256.29fd378a@udp111988uds.am.freescale.net>
In-Reply-To: <4D24B725.2020300@evidence.eu.com>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
	<4D24B725.2020300@evidence.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Rafael Beims <rbeims@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Jan 2011 19:23:33 +0100
michael <michael@evidence.eu.com> wrote:

> diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
> index dd5ea95..cb67076 100644
> --- a/arch/powerpc/include/asm/pte-8xx.h
> +++ b/arch/powerpc/include/asm/pte-8xx.h
> @@ -32,7 +32,7 @@
>  #define _PAGE_FILE	0x0002	/* when !present: nonlinear file mapping */
>  #define _PAGE_NO_CACHE	0x0002	/* I: cache inhibit */
>  #define _PAGE_SHARED	0x0004	/* No ASID (context) compare */
> -#define _PAGE_SPECIAL	0x0008	/* SW entry, forced to 0 by the TLB miss */
> +#define _PAGE_SPECIAL	0x0000	/* SW entry, forced to 0 by the TLB miss */

What do you think is going wrong with the special bit on 8xx?

Or might the change to set_pte_filter() alone be what fixed the problem?

> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 5304093..1da03a8 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -173,21 +173,29 @@ static pte_t set_pte_filter(pte_t pte, unsigned long addr)
>  	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
>  	if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
>  				       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
> -		struct page *pg = maybe_pte_to_page(pte);
> -		if (!pg)
> +		unsigned long pfn = pte_pfn(pte);
> +		struct page *pg;
> +
> +		if (unlikely(!pfn_valid(pfn)))
>  			return pte;
> -		if (!test_bit(PG_arch_1, &pg->flags)) {
> +
> +		pg = pfn_to_page(pfn);
>  #ifdef CONFIG_8xx
> -			/* On 8xx, cache control instructions (particularly
> -			 * "dcbst" from flush_dcache_icache) fault as write
> -			 * operation if there is an unpopulated TLB entry
> -			 * for the address in question. To workaround that,
> -			 * we invalidate the TLB here, thus avoiding dcbst
> -			 * misbehaviour.
> -			 */
> -			/* 8xx doesn't care about PID, size or ind args */
> -			_tlbil_va(addr, 0, 0, 0);
> +		/* On 8xx, cache control instructions (particularly
> +		 * "dcbst" from flush_dcache_icache) fault as write
> +		 * operation if there is an unpopulated TLB entry
> +		 * for the address in question. To workaround that,
> +		 * we invalidate the TLB here, thus avoiding dcbst
> +		 * misbehaviour.
> +		 */
> +		/* 8xx doesn't care about PID, size or ind args */
> +		_tlbil_va(addr, 0, 0, 0);
>  #endif /* CONFIG_8xx */
> +
> +		if (!pg)
> +			return pte;
> +
> +		if (!PageReserved(pg) && !test_bit(PG_arch_1, &pg->flags)) {
>  			flush_dcache_icache_page(pg);
>  			set_bit(PG_arch_1, &pg->flags);
>  		}

Rex, do you recall under what specific circumstances the _tlbil_va is
needed?  Is it possible that it will be caused by a dcbst in other
contexts that are not dependent on the state of PG_arch_1?

-Scott
