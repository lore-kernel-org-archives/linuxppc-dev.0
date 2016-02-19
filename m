Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E59141A06C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 17:07:59 +1100 (AEDT)
Received: by mail-pa0-x232.google.com with SMTP id fy10so44624477pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 22:07:59 -0800 (PST)
Subject: Re: [PATCH V2] powerpc/Kconfig: Update config option based on page
 size.
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1455860327-22913-1-git-send-email-rashmicy@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56C6B139.8000605@gmail.com>
Date: Fri, 19 Feb 2016 17:07:53 +1100
MIME-Version: 1.0
In-Reply-To: <1455860327-22913-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 19/02/16 16:38, Rashmica Gupta wrote:
> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>
> The error occurs because of the following constraint (from
> include/linux/mmzone.h) being violated:
>
> 	MAX_ORDER -1 + PAGESHIFT <= SECTION_SIZE_BITS.
>
> Expanding this out, we get:
>
> 	FORCE_MAX_ZONEBITS <= 25 - PAGESHIFT,
>
> which requires, for a 64K page, FORCE_MAX_ZONEBITS <= 9. Thus set max
> value of FORCE_MAX_ZONEORDER for 64K pages to 9, and 4K pages to 13.
>
> Also, check the minimum value:
> In include/linux/huge_mm.h, we have the constraint HPAGE_PMD_ORDER <
> MAX_ORDER which expands out to:
>
> 	PTE_INDEX_SIZE < FORCE_MAX_ZONEORDER.
>
> PTE_INDEX_SIZE is:
> 	9 (4k hash or no hash 4K pgtable) or
> 	8 (64K hash or no hash 64K pgtable).
> Thus a min value of 8 for 64K pages and 9 for 4K pages is reasonable.
>
> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
> and from 13-64 to 9-13 for 4K pages.
>
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
> ---
>
> v2: Changed the range for 4K pages and minimum for 64K pages as suggested
> by Balbir Singh. 
>
>
>  arch/powerpc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e4824fd04bb7..b933530821fb 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -585,9 +585,9 @@ endchoice
>  
>  config FORCE_MAX_ZONEORDER
>  	int "Maximum zone order"
> -	range 9 64 if PPC64 && PPC_64K_PAGES
> +	range 8 9 if PPC64 && PPC_64K_PAGES
>  	default "9" if PPC64 && PPC_64K_PAGES
> -	range 13 64 if PPC64 && !PPC_64K_PAGES
> +	range 9 13 if PPC64 && !PPC_64K_PAGES
>  	default "13" if PPC64 && !PPC_64K_PAGES
>  	range 9 64 if PPC32 && PPC_16K_PAGES
>  	default "9" if PPC32 && PPC_16K_PAGES
Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
