Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B4122C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 00:13:49 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id xb4so6844816pbc.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 07:13:47 -0700 (PDT)
Message-ID: <5208ED95.4090204@ozlabs.ru>
Date: Tue, 13 Aug 2013 00:13:41 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: Powerpc: Kernel warn_on when enabling IOMMU_API
References: <6A3DF150A5B70D4F9B66A25E3F7C888D0710DCBF@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0710DCBF@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset=KOI8-R
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2013 08:20 PM, Bhushan Bharat-R65777 wrote:
> And this simple fix work for me 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index b20ff17..8869b0d 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -48,6 +48,8 @@
>  #include <asm/vio.h>
>  #include <asm/tce.h>
>  
> +#define DEBUG
> +
>  #define DBG(...)
>  
>  static int novmerge;
> @@ -871,7 +873,7 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
>         }
>  }
>  
> -#ifdef CONFIG_IOMMU_API
> +#ifdef SPAPR_TCE_IOMMU
>  /*
>   * SPAPR TCE API
>   */
> ----------------------


And with this fix, what does "ls -laR /sys/kernel/iommu_groups/" print?



-- 
Alexey
