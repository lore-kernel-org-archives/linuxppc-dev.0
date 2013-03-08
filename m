Return-Path: <B11780@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9515B2C03C0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 06:22:17 +1100 (EST)
Received: from mail40-co9 (localhost [127.0.0.1])	by mail40-co9-R.bigfish.com
 (Postfix) with ESMTP id 335F21001DC	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2013 19:22:13 +0000 (UTC)
Received: from CO9EHSMHS009.bigfish.com (unknown [10.236.132.241])	by
 mail40-co9.bigfish.com (Postfix) with ESMTP id CB5A27C0056	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 19:22:10 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Lan Chunhe-B25806 <B25806@freescale.com>
Subject: Re: [PATCH] edac/85xx: Add PCIe error interrupt edac support
Date: Fri, 8 Mar 2013 19:22:06 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D7485E6@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1362731547-25165-1-git-send-email-Chunhe.Lan@freescale.com>
In-Reply-To: <1362731547-25165-1-git-send-email-Chunhe.Lan@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 8, 2013, at 2:32 AM, Chunhe Lan wrote:

> Adding pcie error interrupt edac support for mpc85xx, p3041, p4080,
> and p5020. The mpc85xx uses the legacy interrupt report mechanism -
> the error interrupts are reported directly to mpic. While, the p3041/
> p4080/p5020 attaches the most of error interrupts to interrupt zero.
> And report error interrupts to mpic via interrupt 0.
>=20
> This patch can handle both of them.
>=20
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> drivers/edac/mpc85xx_edac.c |  169 ++++++++++++++++++++++++++++++++++++++=
++---
> drivers/edac/mpc85xx_edac.h |    7 ++
> 2 files changed, 165 insertions(+), 11 deletions(-)

Does this also work on T4 / PCIe controller rev3.0?

>=20
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index 42a840d..085b6b3 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -1,5 +1,6 @@
> /*
>  * Freescale MPC85xx Memory Controller kenel module
> + * Copyright (c) 2013 Freescale Semiconductor, Inc.
>  *
>  * Author: Dave Jiang <djiang@mvista.com>
>  *
> @@ -196,6 +197,120 @@ static void mpc85xx_pci_check(struct edac_pci_ctl_i=
nfo *pci)
> 		edac_pci_handle_npe(pci, pci->ctl_name);
> }
>=20
> +static void mpc85xx_pcie_check(struct edac_pci_ctl_info *pci)
> +{
> +	struct mpc85xx_pci_pdata *pdata =3D pci->pvt_info;
> +	u32 err_detect;
> +
> +	err_detect =3D in_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR);
> +
> +	pr_err("PCIE error(s) detected\n");
> +	pr_err("PCIE ERR_DR register: 0x%08x\n", err_detect);
> +	pr_err("PCIE ERR_CAP_STAT register: 0x%08x\n",
> +			in_be32(pdata->pci_vbase + MPC85XX_PCI_GAS_TIMR));
> +	pr_err("PCIE ERR_CAP_R0 register: 0x%08x\n",
> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R0));
> +	pr_err("PCIE ERR_CAP_R1 register: 0x%08x\n",
> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R1));
> +	pr_err("PCIE ERR_CAP_R2 register: 0x%08x\n",
> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R2));
> +	pr_err("PCIE ERR_CAP_R3 register: 0x%08x\n",
> +			in_be32(pdata->pci_vbase + MPC85XX_PCIE_ERR_CAP_R3));
> +
> +	/* clear error bits */
> +	out_be32(pdata->pci_vbase + MPC85XX_PCI_ERR_DR, err_detect);
> +}
> +
> +/*
> + * This function is for error interrupt ORed mechanism.
> + * This mechanism attaches most functions' error interrupts to interrupt=
 0.
> + * And report error interrupt to mpic via interrupt 0.
> + * EIMR0 - Error Interrupt Mask Register 0.
> + *
> + * This function check whether the device support error interrupt ORed
> + * mechanism via device tree. If supported, umask pcie error interrupt
> + * bit in EIMR0.
> + */
> +static int mpc85xx_err_int_en(struct platform_device *op)
> +{
> +	u32 *int_cell;
> +	struct device_node *np;
> +	void __iomem *mpic_base;
> +	u32 reg_tmp;
> +	u32 int_len;
> +	struct resource r;
> +	int res;
> +
> +	if (!op->dev.of_node)
> +		return -EINVAL;
> +
> +	/*
> +	 * Unmask pcie error interrupt bit in EIMR0.
> +	 * Extend interrupt specifier has 4 cells.
> +	 * For the 3rd cell:
> +	 *	0 -- normal interrupt;
> +	 *	1 -- error interrupt.
> +	 */
> +	int_cell =3D (u32 *)of_get_property(op->dev.of_node, "interrupts",
> +						&int_len);


> +	if ((int_len/sizeof(u32)) =3D=3D 4) {
> +		/* soc has error interrupt integration handling mechanism */
> +		if (*(int_cell + 2) =3D=3D 1) {
> +			np =3D of_find_node_by_type(NULL, "open-pic");
> +
> +			if (of_address_to_resource(np, 0, &r)) {
> +				pr_err("%s: Failed to map mpic regs\n",
> +					__func__);
> +				of_node_put(np);
> +				res =3D -ENOMEM;
> +				goto err;
> +			}
> +
> +			if (!request_mem_region(r.start, r.end - r.start + 1,
> +						"mpic")) {
> +				pr_err("%s: Error when requesting mem region\n",
> +					__func__);
> +				res =3D -EBUSY;
> +				goto err;
> +			}
> +
> +			mpic_base =3D ioremap(r.start, r.end - r.start + 1);
> +			if (!mpic_base) {
> +				pr_err("%s: Unable to map mpic regs\n",
> +					__func__);
> +				res =3D -ENOMEM;
> +				goto err_ioremap;
> +			}
> +
> +			reg_tmp =3D in_be32(mpic_base + MPC85XX_MPIC_EIMR0);
> +			out_be32(mpic_base + MPC85XX_MPIC_EIMR0, reg_tmp &
> +					~(1 << (31 - *(int_cell + 3))));
> +			iounmap(mpic_base);
> +			release_mem_region(r.start, r.end - r.start + 1);
> +			of_node_put(np);
> +		}
> +	}
> +

Why is this all needed, we have handling of error interrupts in the kernel =
already?

- k
