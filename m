Return-Path: <B25806@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 102722C02BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 13:30:18 +1100 (EST)
Received: from mail122-co1 (localhost [127.0.0.1])	by
 mail122-co1-R.bigfish.com (Postfix) with ESMTP id 914C05400B5	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 02:30:13 +0000 (UTC)
Received: from CO1EHSMHS013.bigfish.com (unknown [10.243.78.238])	by
 mail122-co1.bigfish.com (Postfix) with ESMTP id DE243BC0048	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 02:30:11 +0000 (UTC)
Message-ID: <513E93C3.6050803@freescale.com>
Date: Tue, 12 Mar 2013 10:32:35 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] edac/85xx: Add PCIe error interrupt edac support
References: <1362731547-25165-1-git-send-email-Chunhe.Lan@freescale.com>
 <CF1EE7AED478CD48A05574C8E2DA142D7485E6@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <CF1EE7AED478CD48A05574C8E2DA142D7485E6@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2013 03:22 AM, Gala Kumar-B11780 wrote:
> On Mar 8, 2013, at 2:32 AM, Chunhe Lan wrote:
>
>> Adding pcie error interrupt edac support for mpc85xx, p3041, p4080,
>> and p5020. The mpc85xx uses the legacy interrupt report mechanism -
>> the error interrupts are reported directly to mpic. While, the p3041/
>> p4080/p5020 attaches the most of error interrupts to interrupt zero.
>> And report error interrupts to mpic via interrupt 0.
>>
>> This patch can handle both of them.
>>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> ---
>> drivers/edac/mpc85xx_edac.c |  169 ++++++++++++++++++++++++++++++++++++++++---
>> drivers/edac/mpc85xx_edac.h |    7 ++
>> 2 files changed, 165 insertions(+), 11 deletions(-)
> Does this also work on T4 / PCIe controller rev3.0?
      No, it does not work on T4.
>> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
>> index 42a840d..085b6b3 100644
>> --- a/drivers/edac/mpc85xx_edac.c
>> +++ b/drivers/edac/mpc85xx_edac.c
>> @@ -1,5 +1,6 @@
>> /*
>>   * Freescale MPC85xx Memory Controller kenel module
>> + * Copyright (c) 2013 Freescale Semiconductor, Inc.
>>   *
>>   * Author: Dave Jiang <djiang@mvista.com>
>>   *
>> @@ -196,6 +197,120 @@ static void mpc85xx_pci_check(struct edac_pci_ctl_info *pci)
>> 		edac_pci_handle_npe(pci, pci->ctl_name);
>> }
>>
>> +static void mpc85xx_pcie_check(struct edac_pci_ctl_info *pci)
>> +{
>> +	struct mpc85xx_pci_pdata *pdata = pci->pvt_info;
>> +	u32 err_detect;
>> +
>> +	err_detect = in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR);
>> +
>> +	pr_err("PCIE error(s) detected\n");
>> +	pr_err("PCIE ERR_DR register: 0x%08x\n", err_detect);
>> +	pr_err("PCIE ERR_CAP_STAT register: 0x%08x\n",
>> +			in_be32(pdata->pci_vbase + MPC85XX_PCI_GAS_TIMR));
>> +	pr_err("PCIE ERR_CAP_R0 register: 0x%08x\n",
>> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R0));
>> +	pr_err("PCIE ERR_CAP_R1 register: 0x%08x\n",
>> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R1));
>> +	pr_err("PCIE ERR_CAP_R2 register: 0x%08x\n",
>> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R2));
>> +	pr_err("PCIE ERR_CAP_R3 register: 0x%08x\n",
>> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R3));
>> +
>> +	/* clear error bits */
>> +	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, err_detect);
>> +}
>> +
>> +/*
>> + * This function is for error interrupt ORed mechanism.
>> + * This mechanism attaches most functions' error interrupts to interrupt 0.
>> + * And report error interrupt to mpic via interrupt 0.
>> + * EIMR0 - Error Interrupt Mask Register 0.
>> + *
>> + * This function check whether the device support error interrupt ORed
>> + * mechanism via device tree. If supported, umask pcie error interrupt
>> + * bit in EIMR0.
>> + */
>> +static int mpc85xx_err_int_en(struct platform_device *op)
>> +{
>> +	u32 *int_cell;
>> +	struct device_node *np;
>> +	void __iomem *mpic_base;
>> +	u32 reg_tmp;
>> +	u32 int_len;
>> +	struct resource r;
>> +	int res;
>> +
>> +	if (!op->dev.of_node)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Unmask pcie error interrupt bit in EIMR0.
>> +	 * Extend interrupt specifier has 4 cells.
>> +	 * For the 3rd cell:
>> +	 *	0 -- normal interrupt;
>> +	 *	1 -- error interrupt.
>> +	 */
>> +	int_cell = (u32 *)of_get_property(op->dev.of_node, "interrupts",
>> +						&int_len);
>
>> +	if ((int_len/sizeof(u32)) == 4) {
>> +		/* soc has error interrupt integration handling mechanism */
>> +		if (*(int_cell + 2) == 1) {
>> +			np = of_find_node_by_type(NULL, "open-pic");
>> +
>> +			if (of_address_to_resource(np, 0, &r)) {
>> +				pr_err("%s: Failed to map mpic regs\n",
>> +					__func__);
>> +				of_node_put(np);
>> +				res = -ENOMEM;
>> +				goto err;
>> +			}
>> +
>> +			if (!request_mem_region(r.start, r.end - r.start + 1,
>> +						"mpic")) {
>> +				pr_err("%s: Error when requesting mem region\n",
>> +					__func__);
>> +				res = -EBUSY;
>> +				goto err;
>> +			}
>> +
>> +			mpic_base = ioremap(r.start, r.end - r.start + 1);
>> +			if (!mpic_base) {
>> +				pr_err("%s: Unable to map mpic regs\n",
>> +					__func__);
>> +				res = -ENOMEM;
>> +				goto err_ioremap;
>> +			}
>> +
>> +			reg_tmp = in_be32(mpic_base + MPC85XX_MPIC_EIMR0);
>> +			out_be32(mpic_base + MPC85XX_MPIC_EIMR0, reg_tmp &
>> +					~(1 << (31 - *(int_cell + 3))));
>> +			iounmap(mpic_base);
>> +			release_mem_region(r.start, r.end - r.start + 1);
>> +			of_node_put(np);
>> +		}
>> +	}
>> +
> Why is this all needed, we have handling of error interrupts in the kernel already?
     Yes, you are right. This is not needed, and I will remove it.

    Thanks,
    -Chunhe
>
> - k
>
