Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl8jq1jSVzDr0Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 04:41:50 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66IdewY064066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 14:41:48 -0400
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkkqec-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 14:41:48 -0400
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 6 Jul 2016 19:41:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE5CE17D805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 19:43:07 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66IfiVM8913218
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 18:41:44 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66IfhW3028560
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:41:44 -0600
Subject: Re: [PATCH 10/14] cxl: Add support for interrupts on the Mellanox CX4
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-11-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 6 Jul 2016 20:41:42 +0200
MIME-Version: 1.0
In-Reply-To: <1467638532-9250-11-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <577D50E6.4080204@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/07/2016 15:22, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> The Mellanox CX4 in cxl mode uses a hybrid interrupt model, where
> interrupts are routed from the networking hardware to the XSL using the
> MSIX table, and from there will be transformed back into an MSIX
> interrupt using the cxl style interrupts (i.e. using IVTE entries and
> ranges to map a PE and AFU interrupt number to an MSIX address).
>
> We want to hide the implementation details of cxl interrupts as much as
> possible. To this end, we use a special version of the MSI setup &
> teardown routines in the PHB while in cxl mode to allocate the cxl
> interrupts and configure the IVTE entries in the process element.
>
> This function does not configure the MSIX table - the CX4 card uses a
> custom format in that table and it would not be appropriate to fill that
> out in generic code. The rest of the functionality is similar to the
> "Full MSI-X mode" described in the CAIA, and this could be easily
> extended to support other adapters that use that mode in the future.
>
> The interrupts will be associated with the default context. If the
> maximum number of interrupts per context has been limited (e.g. by the
> mlx5 driver), it will automatically allocate additional kernel contexts
> to associate extra interrupts as required. These contexts will be
> started using the same WED that was used to start the default context.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-cxl.c  | 84 +++++++++++++++++++++++++++++++
>   arch/powerpc/platforms/powernv/pci-ioda.c |  4 ++
>   arch/powerpc/platforms/powernv/pci.h      |  2 +
>   drivers/misc/cxl/api.c                    | 71 ++++++++++++++++++++++++++
>   drivers/misc/cxl/base.c                   | 31 ++++++++++++
>   drivers/misc/cxl/cxl.h                    |  4 ++
>   drivers/misc/cxl/main.c                   |  2 +
>   include/misc/cxl-base.h                   |  4 ++
>   8 files changed, 202 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
> index 2f386f5..1559ca2 100644
> --- a/arch/powerpc/platforms/powernv/pci-cxl.c
> +++ b/arch/powerpc/platforms/powernv/pci-cxl.c
> @@ -8,6 +8,7 @@
>    */
>
>   #include <linux/module.h>
> +#include <linux/msi.h>
>   #include <asm/pci-bridge.h>
>   #include <asm/pnv-pci.h>
>   #include <asm/opal.h>
> @@ -273,3 +274,86 @@ void pnv_cxl_disable_device(struct pci_dev *dev)
>   	cxl_pci_disable_device(dev);
>   	cxl_afu_put(afu);
>   }
> +
> +/*
> + * This is a special version of pnv_setup_msi_irqs for cards in cxl mode. This
> + * function handles setting up the IVTE entries for the XSL to use.
> + *
> + * We are currently not filling out the MSIX table, since the only currently
> + * supported adapter (CX4) uses a custom MSIX table format in cxl mode and it
> + * is up to their driver to fill that out. In the future we may fill out the
> + * MSIX table (and change the IVTE entries to be an index to the MSIX table)
> + * for adapters implementing the Full MSI-X mode described in the CAIA.
> + */
> +int pnv_cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +	struct msi_desc *entry;
> +	struct cxl_context *ctx = NULL;
> +	unsigned int virq;
> +	int hwirq;
> +	int afu_irq = 0;
> +	int rc;
> +
> +	if (WARN_ON(!phb) || !phb->msi_bmp.bitmap)
> +		return -ENODEV;
> +
> +	if (pdev->no_64bit_msi && !phb->msi32_support)
> +		return -ENODEV;
> +
> +	rc = cxl_cx4_setup_msi_irqs(pdev, nvec, type);
> +	if (rc)
> +		return rc;
> +
> +	for_each_pci_msi_entry(entry, pdev) {
> +		if (!entry->msi_attrib.is_64 && !phb->msi32_support) {
> +			pr_warn("%s: Supports only 64-bit MSIs\n",
> +				pci_name(pdev));
> +			return -ENXIO;
> +		}
> +
> +		hwirq = cxl_next_msi_hwirq(pdev, &ctx, &afu_irq);
> +		if (WARN_ON(hwirq < 0))
> +			return hwirq;

I think we want:
	if (WARN_ON(hwirq <= 0))
cxl_find_afu_irq() returns 0 if doesn't find the irq, which is not 
supposed to happen here.

   Fred
