Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0B7102C007A
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jan 2014 15:54:23 +1100 (EST)
Received: by mail-pd0-f171.google.com with SMTP id x10so2233569pdj.30
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 20:54:21 -0800 (PST)
Message-ID: <52D37173.7030907@ozlabs.ru>
Date: Mon, 13 Jan 2014 15:54:11 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <shangw@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/iommu: Don't detach device without IOMMU group
References: <1389584182-6349-1-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1389584182-6349-1-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=KOI8-R
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2014 02:36 PM, Gavin Shan wrote:
> Some devices, for example PCI root port, don't have IOMMU table and
> group. We needn't detach them from their IOMMU group. Otherwise, it
> potentially incurs kernel crash because of referring NULL IOMMU group
> as following backtrace indicates:
> 
>   .iommu_group_remove_device+0x74/0x1b0
>   .iommu_bus_notifier+0x94/0xb4
>   .notifier_call_chain+0x78/0xe8
>   .__blocking_notifier_call_chain+0x7c/0xbc
>   .blocking_notifier_call_chain+0x38/0x48
>   .device_del+0x50/0x234
>   .pci_remove_bus_device+0x88/0x138
>   .pci_stop_and_remove_bus_device+0x2c/0x40
>   .pcibios_remove_pci_devices+0xcc/0xfc
>   .pcibios_remove_pci_devices+0x3c/0xfc
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>

Thanks! I never tested the unplug case...

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>  arch/powerpc/kernel/iommu.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 572bb5b..8a49424 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1137,6 +1137,17 @@ static int iommu_add_device(struct device *dev)
>  
>  static void iommu_del_device(struct device *dev)
>  {
> +	/*
> +	 * Some devices might not have IOMMU table and group
> +	 * and we needn't detach them from the associated
> +	 * IOMMU groups
> +	 */
> +	if (!dev->iommu_group) {
> +		pr_debug("iommu_tce: skipping device %s with no tbl\n",
> +			 dev_name(dev));
> +		return;
> +	}
> +
>  	iommu_group_remove_device(dev);
>  }
>  
> 


-- 
Alexey
