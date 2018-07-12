Return-Path: <ruscur@russell.cc>
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R70F4h1CzF35c
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 17:31:09 +1000 (AEST)
Message-ID: <9640a2ff6ce0c20d603c16ba7e8b5238d206bf26.camel@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size
 to the default POWER8 case
From: Russell Currey <ruscur@russell.cc>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Date: Thu, 12 Jul 2018 17:21:49 +1000
In-Reply-To: <20180702074205.12837-1-aik@ozlabs.ru>
References: <20180702074205.12837-1-aik@ozlabs.ru>
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

On Mon, 2018-07-02 at 17:42 +1000, Alexey Kardashevskiy wrote:
> The sketchy bypass uses 256M pages so add this page size as well.
> 
> This should cause no behavioral change but will be used later.
> 
> Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for
> IOMMU page size mask"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Russell Currey <ruscur@russell.cc>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5bd0eb6..557c11d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2925,7 +2925,7 @@ static unsigned long
> pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
>  		/* Add 16M for POWER8 by default */
>  		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
>  				!cpu_has_feature(CPU_FTR_ARCH_300))
> -			mask |= SZ_16M;
> +			mask |= SZ_16M | SZ_256M;
>  		return mask;
>  	}
>  
