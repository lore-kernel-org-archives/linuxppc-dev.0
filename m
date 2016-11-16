Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJh0741B0zDvmJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 21:51:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: benh@kernel.crashing.org, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH v2] powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9
 DD1
In-Reply-To: <20161116052319.15507-1-mikey@neuling.org>
References: <20161116052319.15507-1-mikey@neuling.org>
Date: Wed, 16 Nov 2016 21:51:50 +1100
Message-ID: <87lgwjy9x5.fsf@concordia.ellerman.id.au>
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

Michael Neuling <mikey@neuling.org> writes:
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index bda8c43be7..4a19cdd8a0 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -50,6 +50,9 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>  	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
>  		__tlbiel_pid(pid, set, ric);
>  	}
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		asm volatile(PPC_SLBIA(0x7)
> +			     : : :"memory");

Ah of course I'll use slbia to invalidate the ERAT.

How about we do:

#define PPC_INVALIDATE_ERAT	PPC_SLBIA(0x7)


Or bike-shed me a name for it.

cheers
