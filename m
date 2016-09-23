Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgM2r1RHszDsly
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 15:13:40 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id oz2so4519069pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 22:13:40 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc: Bump minimum zone order for 4K system
 page size
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <1474606263-19298-1-git-send-email-aik@ozlabs.ru>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <d1f255f6-6fb0-0f1f-4de8-eb0320042c33@gmail.com>
Date: Fri, 23 Sep 2016 15:13:34 +1000
MIME-Version: 1.0
In-Reply-To: <1474606263-19298-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/09/16 14:51, Alexey Kardashevskiy wrote:
> The moderm kernel on powernv platform cannot possibly boot with values
> less than 12 as the default DMA window of 2GB requires
> (2<<30)/4096 TCEs which is 4MB of contiguous memory, log2(4M) == 22
> so anything less than 12 won't work.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> I am hitting this when switching the system page size from 64K to 4K and
> back. When I switch to 64K, zone order is set to 9 by default and
> it does not change when I switch to 4K as 9 is still within the limits.
> And there are other folks complaining about this too.
> ---
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 927d2ab..3516f16 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -637,7 +637,7 @@ config FORCE_MAX_ZONEORDER
>  	int "Maximum zone order"
>  	range 8 9 if PPC64 && PPC_64K_PAGES
>  	default "9" if PPC64 && PPC_64K_PAGES
> -	range 9 13 if PPC64 && !PPC_64K_PAGES
> +	range 12 13 if PPC64 && !PPC_64K_PAGES
>  	default "13" if PPC64 && !PPC_64K_PAGES
>  	range 9 64 if PPC32 && PPC_16K_PAGES
>  	default "9" if PPC32 && PPC_16K_PAGES
> 

Aneesh already submitted a patch for this

Balbir Singh.
