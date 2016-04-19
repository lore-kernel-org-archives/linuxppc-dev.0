Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzbc5FwfzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:04:28 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id 184so4959060pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 02:04:28 -0700 (PDT)
Subject: Re: [PATCH v8 35/45] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-36-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715F493.2030002@ozlabs.ru>
Date: Tue, 19 Apr 2016 19:04:19 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-36-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> In pnv_pci_reset_secondary_bus(), we should issue fundamental reset
> if any one subordinate device of the specified bus is requesting that.
> Otherwise, the device might not come up after the reset.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Out of curiosity - what does "fundamental" reset actually do?


> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 593b8dc..c7454ba 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -866,9 +866,28 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>   	return 0;
>   }
>
> +static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
> +{
> +	int *freset = data;
> +
> +	/*
> +	 * Stop the iteration immediately if there has any one
> +	 * PCI device requesting fundamental reset.
> +	 */
> +	*freset |= pdev->needs_freset;
> +	return *freset;
> +}
> +
>   void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>   {
> -	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> +	int option, freset = 0;
> +
> +	if (dev->subordinate)
> +		pci_walk_bus(dev->subordinate,
> +			     pnv_pci_dev_reset_type, &freset);
> +
> +	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
> +	pnv_eeh_bridge_reset(dev, option);
>   	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>   }
>
>


-- 
Alexey
