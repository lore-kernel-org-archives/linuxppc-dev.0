Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5WVg5SjVzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:51:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/mm/radix: Properly clear process table entry
In-Reply-To: <1499517932.3397.22.camel@kernel.crashing.org>
References: <1499517932.3397.22.camel@kernel.crashing.org>
Date: Mon, 10 Jul 2017 13:51:55 +1000
Message-ID: <87bmot9cf8.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On radix, the process table entry we want to clear when
> destroying a context is entry 0, not entry 1

.. but has no real world consequence? Or causes the system to instantly
catch fire?


I'll tag it:

Fixes: 7e381c0ff618 ("powerpc/mm/radix: Add mmu context handling callback for radix")

cheers

> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 79d8c8a..9404b5e 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -226,9 +226,15 @@ void destroy_context(struct mm_struct *mm)
>  	mm->context.cop_lockp = NULL;
>  #endif /* CONFIG_PPC_ICSWX */
>  
> -	if (radix_enabled())
> -		process_tb[mm->context.id].prtb1 = 0;
> -	else
> +	if (radix_enabled()) {
> +		/*
> +		 * Radix doesn't have a valid bit in the process table
> +		 * entries. However we know that at least P9 implementation
> +		 * will avoid caching an entry with an invalid RTS field,
> +		 * and 0 is invalid. So this will do.
> +		 */
> +		process_tb[mm->context.id].prtb0 = 0;
> +	} else
>  		subpage_prot_free(mm);
>  	destroy_pagetable_page(mm);
>  	__destroy_context(mm->context.id);
