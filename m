Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN01F6QvczDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:04:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/2] powerpc/mm/autonuma: Switch ppc64 to its own
 implementeation of saved write
In-Reply-To: <1487050314-3892-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487050314-3892-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 22:04:33 +1100
Message-ID: <87y3x9kp8e.fsf@concordia.ellerman.id.au>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index 0735d5a8049f..8720a406bbbe 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -16,6 +16,9 @@
>  #include <asm/page.h>
>  #include <asm/bug.h>
>  
> +#ifndef __ASSEMBLY__
> +#include <linux/mmdebug.h>
> +#endif

I assume that's for the VM_BUG_ON() you add below. But if so wouldn't
the #include be better placed in book3s/64/pgtable.h also?

> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index fef738229a68..c684ef6cbd10 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -512,6 +512,32 @@ static inline pte_t pte_mkhuge(pte_t pte)
>  	return pte;
>  }
>  
> +#define pte_mk_savedwrite pte_mk_savedwrite
> +static inline pte_t pte_mk_savedwrite(pte_t pte)
> +{
> +	/*
> +	 * Used by Autonuma subsystem to preserve the write bit
> +	 * while marking the pte PROT_NONE. Only allow this
> +	 * on PROT_NONE pte
> +	 */
> +	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX | _PAGE_PRIVILEGED)) !=
> +		  cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
> +	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
> +}
> +


cheers
