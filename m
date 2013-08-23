Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76D3A2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 07:45:30 +1000 (EST)
Received: from mail147-va3 (localhost [127.0.0.1])	by
 mail147-va3-R.bigfish.com (Postfix) with ESMTP id 24DC1C0232	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 21:45:25 +0000 (UTC)
Received: from VA3EHSMHS039.bigfish.com (unknown [10.7.14.236])	by
 mail147-va3.bigfish.com (Postfix) with ESMTP id 2865540053	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 21:45:23 +0000 (UTC)
Message-ID: <1377294311.20722.71.camel@snotra.buserror.net>
Subject: Re: [PATCH][RFC] pci: fsl: rework PCIe driver compatible with
 Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Date: Fri, 23 Aug 2013 16:45:11 -0500
In-Reply-To: <1376915011-31467-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1376915011-31467-1-git-send-email-Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 20:23 +0800, Minghuan Lian wrote:
> The Freescale's Layerscape series processors will use ARM cores.
> The LS1's PCIe controllers is the same as T4240's. So it's better
> the PCIe controller driver can support PowerPC and ARM
> simultaneously. This patch is for this purpose. It derives
> the common functions from arch/powerpc/sysdev/fsl_pci.c to
> drivers/pci/host/pcie-fsl.c and leaves several platform-dependent
> functions which should be implemented in platform files.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> Based on upstream master 3.11-rc6
> The function has been tested  on P5020DS and P3041DS and T4240QDS boards 
> For mpc83xx and mpc86xx, I only did compile test.

I assume you'll test on these (and older mpc85xx) before this becomes
non-RFC?

>  arch/powerpc/Kconfig          |   1 +
>  arch/powerpc/sysdev/fsl_pci.c | 591 ++++++----------------------------
>  arch/powerpc/sysdev/fsl_pci.h |  91 ------
>  drivers/edac/mpc85xx_edac.c   |  10 -
>  drivers/pci/host/Kconfig      |   4 +
>  drivers/pci/host/Makefile     |   1 +
>  drivers/pci/host/pcie-fsl.c   | 734 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsl/fsl-pcie.h  | 176 ++++++++++
>  8 files changed, 1008 insertions(+), 600 deletions(-)
>  create mode 100644 drivers/pci/host/pcie-fsl.c
>  create mode 100644 include/linux/fsl/fsl-pcie.h

Please use -M -C with git format-patch.

Why "pcie" rather than "pci"?  Is non-express not supported by these new
files?

> @@ -259,15 +258,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
>  
>  	/* we only need the error registers */
>  	r.start += 0xe00;
> -
> -	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
> -					pdata->name)) {
> -		printk(KERN_ERR "%s: Error while requesting mem region\n",
> -		       __func__);
> -		res = -EBUSY;
> -		goto err;
> -	}
> -
>  	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
>  	if (!pdata->pci_vbase) {
>  		printk(KERN_ERR "%s: Unable to setup PCI err regs\n", __func__);

Could you explain this part?

> diff --git a/drivers/pci/host/pcie-fsl.c b/drivers/pci/host/pcie-fsl.c
> new file mode 100644
> index 0000000..6e767d4
> --- /dev/null
> +++ b/drivers/pci/host/pcie-fsl.c
> @@ -0,0 +1,734 @@
> +/*
> + * 85xx/86xx/LS PCI/PCIE common driver support
> + *
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * Moved from arch/power/fsl_pci.c

That's not the right pathname.

> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +#include <linux/log2.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci_regs.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/memblock.h>
> +#include <linux/fsl/fsl-pcie.h>

You don't need an "fsl-" prefix if it's in the "fsl/" directory.

> +static int fsl_pcie_write_config(struct fsl_pcie *pcie, int bus, int devfn,
> +				 int offset, int len, u32 val)
> +{
> +	void __iomem *cfg_data;
> +	u32 bus_no, reg;
> +
> +	if (pcie->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
> +		if (bus != pcie->first_busno)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +		if (devfn != 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	if (fsl_pci_exclude_device(pcie, bus, devfn))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	bus_no = (bus == pcie->first_busno) ?
> +			pcie->self_busno : bus;
> +
> +	if (pcie->indirect_type & INDIRECT_TYPE_EXT_REG)
> +		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
> +	else
> +		reg = offset & 0xfc;
> +
> +	if (pcie->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
> +		out_be32(&pcie->regs->config_addr,
> +			 (0x80000000 | (bus_no << 16) | (devfn << 8) | reg));
> +	else
> +		out_le32(&pcie->regs->config_addr,
> +			 (0x80000000 | (bus_no << 16) | (devfn << 8) | reg));

Did you try building this on ARM?  out_be32/le32() is PPC-specific.  Use iowrite32be()/iowrite32().

> +ep_mode:
> +	dev_info(&pdev->dev, "It works as EP mode\n");

This is a bit casually phrased...  and where did this come from?  This
patch should just be about moving code around and removing PPC
dependencies (ideally even those two would be separate).  If there's
new functionality or other changes it should be a separate patch.

> +static int __init fsl_pcie_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct fsl_pcie *pcie;
> +
> +	if (!of_device_is_available(pdev->dev.of_node)) {
> +		dev_err(&pdev->dev, "disabled\n");
> +		return -ENODEV;
> +	}

That's not an error.

-Scott
