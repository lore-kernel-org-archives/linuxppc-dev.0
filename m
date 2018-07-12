Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R3x20gxXzDr10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 15:13:08 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id c21-v6so15247759pfn.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 22:13:08 -0700 (PDT)
Date: Thu, 12 Jul 2018 15:12:59 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Russell Currey <ruscur@russell.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add 256M IOMMU page size
 to the default POWER8 case
Message-ID: <20180712151259.44f2f6ee@aik.ozlabs.ibm.com>
In-Reply-To: <20180702074205.12837-1-aik@ozlabs.ru>
References: <20180702074205.12837-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  2 Jul 2018 17:42:05 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> The sketchy bypass uses 256M pages so add this page size as well.
> 
> This should cause no behavioral change but will be used later.
> 
> Fixes: 477afd6ea6 "powerpc/ioda: Use ibm,supported-tce-sizes for IOMMU page size mask"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 5bd0eb6..557c11d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2925,7 +2925,7 @@ static unsigned long pnv_ioda_parse_tce_sizes(struct pnv_phb *phb)
>  		/* Add 16M for POWER8 by default */
>  		if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
>  				!cpu_has_feature(CPU_FTR_ARCH_300))
> -			mask |= SZ_16M;
> +			mask |= SZ_16M | SZ_256M;


Ping?

>  		return mask;
>  	}
>  
> -- 
> 2.11.0
> 



--
Alexey
