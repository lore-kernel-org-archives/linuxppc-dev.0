Return-Path: <aik@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43C711A0BEC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 12:18:54 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@au1.ibm.com>;
 Fri, 20 Feb 2015 11:18:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9057F2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 12:18:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1K1IeJd24313958
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 12:18:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1K1IE4G004417
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 12:18:14 +1100
Message-ID: <54E68B3E.5020707@au1.ibm.com>
Date: Fri, 20 Feb 2015 12:17:50 +1100
From: Alexey Kardashevskiy <aik@au1.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] pseries/iommu: remove iommu device references via bus
 notifier
References: <20150219184103.GB13745@linux.vnet.ibm.com>
In-Reply-To: <20150219184103.GB13745@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2015 05:41 AM, Nishanth Aravamudan wrote:
> After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
> refcnt on the kobject backing the IOMMU group for a PCI device is
> elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
> set_iommu_table_base_and_group). When we go to dlpar a multi-function
> PCI device out:
>
> 	iommu_reconfig_notifier ->
> 		iommu_free_table ->
> 			iommu_group_put
> 			BUG_ON(tbl->it_group)
>
> We trip this BUG_ON, because there are still references on the table, so
> it is not freed. Fix this by also adding a bus notifier identical to
> PowerNV for pSeries. Tested a remove -> add -> remove cycle without
> issue where it always hit the BUG_ON without the changes.
>
> Fixes: d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier")
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: stable@kernel.org (3.13+)

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 1d3d52dc3ff3..f77fb02f4710 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -1340,3 +1340,31 @@ static int __init disable_multitce(char *str)
>   }
>
>   __setup("multitce=", disable_multitce);
> +
> +static int tce_iommu_bus_notifier(struct notifier_block *nb,
> +                unsigned long action, void *data)
> +{
> +        struct device *dev = data;
> +
> +        switch (action) {
> +        case BUS_NOTIFY_ADD_DEVICE:
> +                return iommu_add_device(dev);
> +        case BUS_NOTIFY_DEL_DEVICE:
> +                if (dev->iommu_group)
> +                        iommu_del_device(dev);
> +                return 0;
> +        default:
> +                return 0;
> +        }
> +}
> +
> +static struct notifier_block tce_iommu_bus_nb = {
> +        .notifier_call = tce_iommu_bus_notifier,
> +};
> +
> +static int __init tce_iommu_bus_notifier_init(void)
> +{
> +        bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> +        return 0;
> +}
> +machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
>


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM
