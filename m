Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF0631A028F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 12:56:28 +1000 (EST)
Received: by mail-pd0-f173.google.com with SMTP id w10so2274626pde.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 19:56:26 -0700 (PDT)
Message-ID: <53C73B54.5020601@ozlabs.ru>
Date: Thu, 17 Jul 2014 12:56:20 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 13/16] powerpc/iommu: Implement put_page() if TCE had
 non-zero value
References: <1405416280-12318-1-git-send-email-aik@ozlabs.ru>
 <1405416280-12318-14-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416280-12318-14-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: Paul Mackerras <paulus@samba.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2014 07:24 PM, Alexey Kardashevskiy wrote:
> Guests might put new TCEs without clearing them first and the PAPR spec
> allows that.
> 
> This adds put_page() for TCEs which we just replaced.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kernel/iommu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index ae57910..25fda58 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1054,11 +1054,11 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
>  
>  	spin_lock(&(pool->lock));
>  
> -	oldtce = ppc_md.tce_get(tbl, entry);
> -	/* Add new entry if it is not busy */
> -	if (!(oldtce & (TCE_PCI_WRITE | TCE_PCI_READ)))
> -		ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, NULL,
> -				direction, NULL);
> +	ret = ppc_md.tce_build(tbl, entry, 1, hwaddr, &oldtce,
> +			direction, NULL);
> +
> +	if (oldtce & (TCE_PCI_WRITE | TCE_PCI_READ))
> +		put_page(pfn_to_page(__pa(oldtce)));


rshift for PAGE_SHIFT is missing here.


>  
>  	spin_unlock(&(pool->lock));
>  
> 


-- 
Alexey
