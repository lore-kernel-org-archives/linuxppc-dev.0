Return-Path: <B31939@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE35A2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 21:38:31 +1000 (EST)
Received: from mail33-am1 (localhost [127.0.0.1])	by mail33-am1-R.bigfish.com
 (Postfix) with ESMTP id BD8F61E00F5	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 27 Aug 2013 11:38:23 +0000 (UTC)
Received: from AM1EHSMHS015.bigfish.com (unknown [10.3.201.232])	by
 mail33-am1.bigfish.com (Postfix) with ESMTP id 4045C3C0170	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 11:37:28 +0000 (UTC)
Message-ID: <521C8FB5.1010405@freescale.com>
Date: Tue, 27 Aug 2013 19:38:29 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][RFC] pci: fsl: rework PCIe driver compatible with
 Layerscape
References: <1376915011-31467-1-git-send-email-Minghuan.Lian@freescale.com>
 <1377294311.20722.71.camel@snotra.buserror.net>
In-Reply-To: <1377294311.20722.71.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Thanks for your comments, please see my replies inline.

On 08/24/2013 05:45 AM, Scott Wood wrote:
> On Mon, 2013-08-19 at 20:23 +0800, Minghuan Lian wrote:
>> The Freescale's Layerscape series processors will use ARM cores.
>> The LS1's PCIe controllers is the same as T4240's. So it's better
>> the PCIe controller driver can support PowerPC and ARM
>> simultaneously. This patch is for this purpose. It derives
>> the common functions from arch/powerpc/sysdev/fsl_pci.c to
>> drivers/pci/host/pcie-fsl.c and leaves several platform-dependent
>> functions which should be implemented in platform files.
>>
>> Signed-off-by: Minghuan Lian<Minghuan.Lian@freescale.com>
>> ---
>> Based on upstream master 3.11-rc6
>> The function has been tested  on P5020DS and P3041DS and T4240QDS boards
>> For mpc83xx and mpc86xx, I only did compile test.
> I assume you'll test on these (and older mpc85xx) before this becomes
> non-RFC?
[Minghuan] I will try to test on the relevant boards and list them.
>>   arch/powerpc/Kconfig          |   1 +
>>   arch/powerpc/sysdev/fsl_pci.c | 591 ++++++----------------------------
>>   arch/powerpc/sysdev/fsl_pci.h |  91 ------
>>   drivers/edac/mpc85xx_edac.c   |  10 -
>>   drivers/pci/host/Kconfig      |   4 +
>>   drivers/pci/host/Makefile     |   1 +
>>   drivers/pci/host/pcie-fsl.c   | 734 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/fsl/fsl-pcie.h  | 176 ++++++++++
>>   8 files changed, 1008 insertions(+), 600 deletions(-)
>>   create mode 100644 drivers/pci/host/pcie-fsl.c
>>   create mode 100644 include/linux/fsl/fsl-pcie.h
> Please use -M -C with git format-patch.
>
> Why "pcie" rather than "pci"?  Is non-express not supported by these new
> files?
[Minghuan] Using "pci" is more accurate. I selected 'pcie' because the 
new file is
mainly for PCI Express controller, but it does contain two pci 
boards(mpc8610,
mpc8540) support. I will change to 'pci'.
>> @@ -259,15 +258,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
>>   
>>   	/* we only need the error registers */
>>   	r.start += 0xe00;
>> -
>> -	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
>> -					pdata->name)) {
>> -		printk(KERN_ERR "%s: Error while requesting mem region\n",
>> -		       __func__);
>> -		res = -EBUSY;
>> -		goto err;
>> -	}
>> -
>>   	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
>>   	if (!pdata->pci_vbase) {
>>   		printk(KERN_ERR "%s: Unable to setup PCI err regs\n", __func__);
> Could you explain this part?
[Minghuan] The new pci driver used devm_ioremap_resource() to map reg space.
So PCI EDAC driver would encounter an error when calling 
devm_request_mem_region()
because pci device reg space has been assigned to pci driver. And EDAC 
is only to
handler the error, has no reason to request exclusive PCI device reg space.
>> diff --git a/drivers/pci/host/pcie-fsl.c b/drivers/pci/host/pcie-fsl.c
>> new file mode 100644
>> index 0000000..6e767d4
>> --- /dev/null
>> +++ b/drivers/pci/host/pcie-fsl.c
>> @@ -0,0 +1,734 @@
>> +/*
>> + * 85xx/86xx/LS PCI/PCIE common driver support
>> + *
>> + * Copyright 2013 Freescale Semiconductor, Inc.
>> + *
>> + * Moved from arch/power/fsl_pci.c
> That's not the right pathname.
[Minghuan] Sorry, I will fix it.
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +#include <linux/string.h>
>> +#include <linux/init.h>
>> +#include <linux/log2.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/pci_regs.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/resource.h>
>> +#include <linux/types.h>
>> +#include <linux/memblock.h>
>> +#include <linux/fsl/fsl-pcie.h>
> You don't need an "fsl-" prefix if it's in the "fsl/" directory.
[Minghuan] No, I will remove 'fsl-' prefix.
>> +static int fsl_pcie_write_config(struct fsl_pcie *pcie, int bus, int devfn,
>> +				 int offset, int len, u32 val)
>> +{
>> +	void __iomem *cfg_data;
>> +	u32 bus_no, reg;
>> +
>> +	if (pcie->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
>> +		if (bus != pcie->first_busno)
>> +			return PCIBIOS_DEVICE_NOT_FOUND;
>> +		if (devfn != 0)
>> +			return PCIBIOS_DEVICE_NOT_FOUND;
>> +	}
>> +
>> +	if (fsl_pci_exclude_device(pcie, bus, devfn))
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +	bus_no = (bus == pcie->first_busno) ?
>> +			pcie->self_busno : bus;
>> +
>> +	if (pcie->indirect_type & INDIRECT_TYPE_EXT_REG)
>> +		reg = ((offset & 0xf00) << 16) | (offset & 0xfc);
>> +	else
>> +		reg = offset & 0xfc;
>> +
>> +	if (pcie->indirect_type & INDIRECT_TYPE_BIG_ENDIAN)
>> +		out_be32(&pcie->regs->config_addr,
>> +			 (0x80000000 | (bus_no << 16) | (devfn << 8) | reg));
>> +	else
>> +		out_le32(&pcie->regs->config_addr,
>> +			 (0x80000000 | (bus_no << 16) | (devfn << 8) | reg));
> Did you try building this on ARM?  out_be32/le32() is PPC-specific.  Use iowrite32be()/iowrite32().
[Minghuan] Yes. I will change them.
>> +ep_mode:
>> +	dev_info(&pdev->dev, "It works as EP mode\n");
> This is a bit casually phrased...  and where did this come from?  This
> patch should just be about moving code around and removing PPC
> dependencies (ideally even those two would be separate).  If there's
> new functionality or other changes it should be a separate patch.
[Minghuan] Sorry, I will continue using "no_bridge"
>> +static int __init fsl_pcie_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct fsl_pcie *pcie;
>> +
>> +	if (!of_device_is_available(pdev->dev.of_node)) {
>> +		dev_err(&pdev->dev, "disabled\n");
>> +		return -ENODEV;
>> +	}
> That's not an error.
[Minghuan] Ok, I will fix it.
> -Scott
>
>
