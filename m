Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D45832C0184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 20:15:44 +1000 (EST)
Received: by mail-pb0-f44.google.com with SMTP id xa7so1839271pbc.17
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 03:15:42 -0700 (PDT)
Message-ID: <520DFBC8.4040509@ozlabs.ru>
Date: Fri, 16 Aug 2013 20:15:36 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/iommu: check dev->iommu_group before remove
 a device from iommu_group
References: <1376647687-20550-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1376647687-20550-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1376647687-20550-3-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=KOI8-R
Cc: paulus@au1.ibm.com, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/16/2013 08:08 PM, Wei Yang wrote:
> ---
>  arch/powerpc/kernel/iommu.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index b20ff17..5abf7c3 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1149,7 +1149,8 @@ static int iommu_bus_notifier(struct notifier_block *nb,
>  	case BUS_NOTIFY_ADD_DEVICE:
>  		return iommu_add_device(dev);
>  	case BUS_NOTIFY_DEL_DEVICE:
> -		iommu_del_device(dev);
> +		if (dev->iommu_group)
> +			iommu_del_device(dev);
>  		return 0;
>  	default:
>  		return 0;
> 

This one seems redundant, no?


-- 
Alexey
