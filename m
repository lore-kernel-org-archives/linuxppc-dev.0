Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68B011A0B75
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 22:09:45 +1100 (AEDT)
In-Reply-To: <1457090804-9719-21-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v6,20/20] cxl: Remove cxl_get_phys_dev() kernel API
Message-Id: <20160309110945.44E2E140328@ozlabs.org>
Date: Wed,  9 Mar 2016 22:09:45 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-03 at 11:26:44 UTC, Frederic Barrat wrote:
> The cxl_get_phys_dev() API returns a struct device pointer which could
> belong to either a struct pci_dev (bare-metal) or platform_device
> (powerVM). To avoid potential problems in drivers, remove that API. It
> was introduced to allow drivers to read the VPD of the adapter, but
> the cxl driver now provides the cxl_pci_read_adapter_vpd() API for
> that purpose.
> 
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 75ec2f9..2107c94 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -76,7 +76,6 @@ struct device *cxl_get_phys_dev(struct pci_dev *dev)
>  
>  	return afu->adapter->dev.parent;
>  }
> -EXPORT_SYMBOL_GPL(cxl_get_phys_dev);

This appears to make cxl_get_phys_dev() completely unused, doesn't it?

If so, please send me a follow-up patch to remove it entirely.

cheers
