Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E5EA21A0981
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 20:26:59 +1100 (AEDT)
Message-ID: <1444728418.22686.3.camel@ellerman.id.au>
Subject: Re: [PATCH v3 10/31] powerpc/mm: Don't use pmd_val,pud_val and
 pgd_val as lvalue
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, Scott Wood
 <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 13 Oct 2015 20:26:58 +1100
In-Reply-To: <87612btk8y.fsf@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1444675215-19484-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1444713006.29347.2.camel@ellerman.id.au>
 <87612btk8y.fsf@linux.vnet.ibm.com>
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

On Tue, 2015-10-13 at 10:53 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > On Tue, 2015-10-13 at 00:09 +0530, Aneesh Kumar K.V wrote:
> >> We convert them static inline function here as we did with pte_val in
> >> the previous patch
> >
> > This breaks ppc40x_defconfig & 40x/ep405_defconfig with:
> 
> How about
> 
> diff --git a/arch/powerpc/mm/40x_mmu.c b/arch/powerpc/mm/40x_mmu.c
> index 5810967511d4..31a5d42df8c9 100644
> --- a/arch/powerpc/mm/40x_mmu.c
> +++ b/arch/powerpc/mm/40x_mmu.c
> @@ -110,10 +110,10 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
>  		unsigned long val = p | _PMD_SIZE_16M | _PAGE_EXEC | _PAGE_HWWRITE;
>  
>  		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
> -		pmd_val(*pmdp++) = val;
> -		pmd_val(*pmdp++) = val;
> -		pmd_val(*pmdp++) = val;
> -		pmd_val(*pmdp++) = val;
> +		*pmdp++ = __pmd(val);
> +		*pmdp++ = __pmd(val);
> +		*pmdp++ = __pmd(val);
> +		*pmdp++ = __pmd(val);
>  
>  		v += LARGE_PAGE_SIZE_16M;
>  		p += LARGE_PAGE_SIZE_16M;
> @@ -125,7 +125,7 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
>  		unsigned long val = p | _PMD_SIZE_4M | _PAGE_EXEC | _PAGE_HWWRITE;
>  
>  		pmdp = pmd_offset(pud_offset(pgd_offset_k(v), v), v);
> -		pmd_val(*pmdp) = val;
> +		*pmdp = __pmd(val);


Yep that fixes it, I've squashed that in for now to get it building.

cheers
