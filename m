Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB71C1A0881
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 13:12:06 +1000 (EST)
Message-ID: <1407726718.4508.60.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/powernv: Remove duplicate check in
 tce_iommu_bus_notifier()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Mon, 11 Aug 2014 13:11:58 +1000
In-Reply-To: <1407309017-13870-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407309017-13870-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1407309017-13870-2-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-08-06 at 17:10 +1000, Gavin Shan wrote:
> The called function iommu_del_device() checks if the device has
> attached IOMMU group, we needn't check it again in the parent
> function call tce_iommu_bus_notifier().

The patch does more than that... it also refactors the function, which
it should either not do or document.

> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index f91a4e5..b562b0d 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -820,17 +820,18 @@ static int tce_iommu_bus_notifier(struct notifier_block *nb,
>  		unsigned long action, void *data)
>  {
>  	struct device *dev = data;
> +	int ret = 0;
>  
>  	switch (action) {
>  	case BUS_NOTIFY_ADD_DEVICE:
> -		return iommu_add_device(dev);
> +		ret = iommu_add_device(dev);
> +		break;
>  	case BUS_NOTIFY_DEL_DEVICE:
> -		if (dev->iommu_group)
> -			iommu_del_device(dev);
> -		return 0;
> -	default:
> -		return 0;
> +		iommu_del_device(dev);
> +		break;
>  	}
> +
> +	return ret;
>  }
>  
>  static struct notifier_block tce_iommu_bus_nb = {
