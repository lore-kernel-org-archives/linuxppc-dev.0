Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC22E2C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 18:26:44 +1000 (EST)
Message-ID: <1374827190.6142.124.camel@pasglop>
Subject: Re: [PATCH 4/4] kvm: powerpc: set cache coherency only for RAM pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bharat Bhushan <r65777@freescale.com>
Date: Fri, 26 Jul 2013 18:26:30 +1000
In-Reply-To: <1374817613-20169-4-git-send-email-Bharat.Bhushan@freescale.com>
References: <1374817613-20169-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1374817613-20169-4-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-26 at 11:16 +0530, Bharat Bhushan wrote:
> If the page is RAM then map this as cacheable and coherent (set "M" bit)
> otherwise this page is treated as I/O and map this as cache inhibited
> and guarded (set  "I + G")
> 
> This helps setting proper MMU mapping for direct assigned device.
> 
> NOTE: There can be devices that require cacheable mapping, which is not yet supported.

Why don't you do like server instead and enforce the use of the same I
and M bits as the corresponding qemu PTE ?

Cheers,
Ben.

> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
>  arch/powerpc/kvm/e500_mmu_host.c |   24 +++++++++++++++++++-----
>  1 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index 1c6a9d7..5cbdc8f 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -64,13 +64,27 @@ static inline u32 e500_shadow_mas3_attrib(u32 mas3, int usermode)
>  	return mas3;
>  }
>  
> -static inline u32 e500_shadow_mas2_attrib(u32 mas2, int usermode)
> +static inline u32 e500_shadow_mas2_attrib(u32 mas2, pfn_t pfn)
>  {
> +	u32 mas2_attr;
> +
> +	mas2_attr = mas2 & MAS2_ATTRIB_MASK;
> +
> +	if (kvm_is_mmio_pfn(pfn)) {
> +		/*
> +		 * If page is not RAM then it is treated as I/O page.
> +		 * Map it with cache inhibited and guarded (set "I" + "G").
> +		 */
> +		mas2_attr |= MAS2_I | MAS2_G;
> +		return mas2_attr;
> +	}
> +
> +	/* Map RAM pages as cacheable (Not setting "I" in MAS2) */
>  #ifdef CONFIG_SMP
> -	return (mas2 & MAS2_ATTRIB_MASK) | MAS2_M;
> -#else
> -	return mas2 & MAS2_ATTRIB_MASK;
> +	/* Also map as coherent (set "M") in SMP */
> +	mas2_attr |= MAS2_M;
>  #endif
> +	return mas2_attr;
>  }
>  
>  /*
> @@ -313,7 +327,7 @@ static void kvmppc_e500_setup_stlbe(
>  	/* Force IPROT=0 for all guest mappings. */
>  	stlbe->mas1 = MAS1_TSIZE(tsize) | get_tlb_sts(gtlbe) | MAS1_VALID;
>  	stlbe->mas2 = (gvaddr & MAS2_EPN) |
> -		      e500_shadow_mas2_attrib(gtlbe->mas2, pr);
> +		      e500_shadow_mas2_attrib(gtlbe->mas2, pfn);
>  	stlbe->mas7_3 = ((u64)pfn << PAGE_SHIFT) |
>  			e500_shadow_mas3_attrib(gtlbe->mas7_3, pr);
>  
