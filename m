Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqktH3DWKzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 15:35:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6E5XLGT021618
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 01:34:59 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 245hgbe6hm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 01:34:59 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 14 Jul 2016 15:34:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 88FF53578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 15:34:54 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6E5Ysef17039580
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 15:34:54 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6E5Yrk3015404
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 15:34:54 +1000
Subject: Re: [PATCH 11/15] cxl: Add support for interrupts on the Mellanox CX4
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
 <1468444634-1866-12-git-send-email-imunsie@au.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 14 Jul 2016 15:34:53 +1000
MIME-Version: 1.0
In-Reply-To: <1468444634-1866-12-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d39dd200-763e-533c-efca-94b932941a2d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/07/16 07:17, Ian Munsie wrote:
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

Some minor nitpicks below, which shouldn't block acceptance.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 104c040..530d4af 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3465,6 +3465,10 @@ static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
>  const struct pci_controller_ops pnv_cxl_cx4_ioda_controller_ops = {
>  	.dma_dev_setup		= pnv_pci_dma_dev_setup,
>  	.dma_bus_setup		= pnv_pci_dma_bus_setup,
> +#ifdef CONFIG_PCI_MSI

If you've got CXL_BASE you've already got PCI_MSI.

> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index f02a859..f3d34b9 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -14,6 +14,7 @@
>  #include <misc/cxl.h>
>  #include <linux/fs.h>
>  #include <asm/pnv-pci.h>
> +#include <linux/msi.h>
>
>  #include "cxl.h"
>
> @@ -489,3 +490,73 @@ int cxl_get_max_irqs_per_process(struct pci_dev *dev)
>  	return afu->irqs_max;
>  }
>  EXPORT_SYMBOL_GPL(cxl_get_max_irqs_per_process);
> +
> +/*
> + * This is a special interrupt allocation routine called from the PHB's MSI
> + * setup function. When capi interrupts are allocated in this manner they must
> + * still be associated with a running context, but since the MSI APIs have no
> + * way to specify this we use the default context associated with the device.
> + *
> + * The Mellanox CX4 has a hardware limitation that restricts the maximum AFU
> + * interrupt number, so in order to overcome this their driver informs us of
> + * the restriction by setting the maximum interrupts per context, and we
> + * allocate additional contexts as necessary so that we can keep the AFU
> + * interrupt number within the supported range.
> + */
> +int _cxl_cx4_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +{
> +	struct cxl_context *ctx, *new_ctx, *default_ctx;
> +	int remaining;
> +	int rc;
> +
> +	ctx = default_ctx = cxl_get_context(pdev);
> +	if (WARN_ON(!default_ctx))
> +		return -ENODEV;

I have a very slight preference for:

if (!default_ctx) {
	dev_WARN(&pdev->dev, "couldn't get default context");
	return -ENODEV;
}

(I see this in your arch/powerpc code too, but that's obviously copied 
from the regular powernv irq code. Also, why is there no dev_WARN_ON() 
function?)

> +
> +	remaining = nvec;
> +	while (remaining > 0) {
> +		rc = cxl_allocate_afu_irqs(ctx, min(remaining, ctx->afu->irqs_max));
> +		if (rc) {
> +			pr_warn("%s: Failed to find enough free MSIs\n", pci_name(pdev));

dev_warn(&pdev->dev, "failed to find enough free MSIs\n"); is more 
common in the cxl code.


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
