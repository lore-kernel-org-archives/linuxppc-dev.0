Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45B7A1A1A3B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 19:19:51 +1000 (AEST)
Message-ID: <1437556790.27712.5.camel@ellerman.id.au>
Subject: Re: [RFC 4/8] powerpc/slb: Add some helper functions to improve
 modularization
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
Date: Wed, 22 Jul 2015 19:19:50 +1000
In-Reply-To: <1437461926-8908-4-git-send-email-khandual@linux.vnet.ibm.com>
References: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1437461926-8908-4-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-21 at 12:28 +0530, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> 
> This patch adds the following helper functions to improve modularization
> and readability of the code.
> 
> (1) slb_invalid_all: 		Invalidates entire SLB

This reads badly. Although invalid can be a verb, the meaning of invalid as a
verb is not correct here. You want "invalidate".

> (2) slb_invalid_paca_slots: 	Invalidate SLB entries present in PACA

Ditto.

But, I think that's the wrong abstraction.

We should just have one routine, slb_invalidate(), which deals with all the
mess. ie. checking the MMU_FTR and the offset etc. So basically the whole
if/else.

> (3) kernel_linear_vsid_flags:	VSID flags for kernel linear mapping
> (4) kernel_virtual_vsid_flags:	VSID flags for kernel virtual mapping

I don't like these names either.

> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index cbeaaa2..dcba4c2 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -94,18 +94,37 @@ static inline void new_shadowed_slbe(unsigned long ea, int ssize,
>  		     : "memory" );
>  }
>  
> +static inline unsigned long kernel_linear_vsid_flags(void)
> +{
> +	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_linear_psize].sllp;
> +}

mmu_linear_vsid_flags() ?

> +
> +static inline unsigned long kernel_virtual_vsid_flags(void)
> +{
> +	return SLB_VSID_KERNEL | mmu_psize_defs[mmu_vmalloc_psize].sllp;
> +}

mmu_vmalloc_vsid_flags() ?

etc.

ie. have the function names match the mmu psize names. I don't think we need
"kernel" in the name, I think that's implied.

cheers
