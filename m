Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B3F2DDE9C
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:12:37 +1000 (EST)
In-Reply-To: <1192195728-24189-4-git-send-email-leoli@freescale.com>
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-2-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7B7F41BB-05FB-4BFD-B4C6-ADDE1E2D76E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 3/9] add Freescale SerDes PHY support
Date: Wed, 17 Oct 2007 09:13:09 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> diff --git a/arch/powerpc/sysdev/fsl_serdes.c b/arch/powerpc/sysdev/ 
> fsl_serdes.c
> new file mode 100644
> index 0000000..5e91eb7
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_serdes.c
> @@ -0,0 +1,152 @@
> +/*
> + * arch/powerpc/sysdev/fsl_serdes.c
> + *
> + * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights  
> reserved.
> + *
> + * Author: Li Yang <leoli@freescale.com>
> + *
> + * Freescale SerDes initialization routines
> + *
> + * This program is free software; you can redistribute it and/or  
> modify it
> + * under the terms of the GNU General Public License as published  
> by the
> + * Free Software Foundation;  either version 2 of the License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +
> +#include <asm/system.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +
> +#include "fsl_serdes.h"

just move the #defines into the .c file and kill the header.

> +
> +static int __init setup_serdes(struct device_node *np)
> +{
> +	void __iomem *regs;
> +	const void *prot;
> +	const unsigned int *freq;
> +	struct resource res;
> +	u32 rfcks;
> +
> +	of_address_to_resource(np, 0, &res);
> +	regs = ioremap(res.start, res.end - res.start + 1);

you don't unmap this ever (on error or exit of the function).
> +
> +	prot = of_get_property(np, "protocol", NULL);
> +	if (!prot)
> +		return -EINVAL;
> +	freq = of_get_property(np, "clock", NULL);
> +	switch (*freq) {
> +	case 100:
> +		rfcks = FSL_SRDSCR4_RFCKS_100;
> +		break;
> +	case 125:
> +		rfcks = FSL_SRDSCR4_RFCKS_125;
> +		break;
> +	case 150:
> +		rfcks = FSL_SRDSCR4_RFCKS_150;
> +		break;
> +	default:
> +		printk(KERN_ERR "SerDes: Wrong frequency\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Use default prescale and counter */
> +
> +	/* 1.0V corevdd */
> +	if (of_get_property(np, "vdd-1v", NULL)) {
> +		/* DPPE/DPPA = 0 */
> +		clrbits32(regs + FSL_SRDSCR0_OFFS, FSL_SRDSCR0_DPP_1V2);
> +
> +		/* VDD = 0 */
> +		clrbits32(regs + FSL_SRDSCR2_OFFS, FSL_SRDSCR2_VDD_1V2);
> +	}
> +
> +	/* protocol specific configuration */
> +	if (!strcmp(prot, "sata")) {
> +		/* Set and clear reset bits */
> +		setbits32(regs + FSL_SRDSRSTCTL_OFFS,
> +				FSL_SRDSRSTCTL_SATA_RESET);
> +		mdelay(1);
> +		clrbits32(regs + FSL_SRDSRSTCTL_OFFS,
> +				FSL_SRDSRSTCTL_SATA_RESET);
> +
> +		/* Configure SRDSCR1 */
> +		clrbits32(regs + FSL_SRDSCR1_OFFS, FSL_SRDSCR1_PLLBW);
> +
> +		/* Configure SRDSCR2 */
> +		clrsetbits_be32(regs + FSL_SRDSCR2_OFFS,
> +				FSL_SRDSCR2_SEIC_MASK, FSL_SRDSCR2_SEIC_SATA);
> +
> +		/* Configure SRDSCR3 */
> +		out_be32(regs + FSL_SRDSCR3_OFFS, FSL_SRDSCR3_KFR_SATA |
> +				FSL_SRDSCR3_KPH_SATA |
> +				FSL_SRDSCR3_SDFM_SATA_PEX |
> +				FSL_SRDSCR3_SDTXL_SATA);
> +
> +		/* Configure SRDSCR4 */
> +		out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
> +				FSL_SRDSCR4_PROT_SATA);
> +
> +	} else if (!strcmp(prot, "pcie")) {
> +		/* Configure SRDSCR1 */
> +		setbits32(regs + FSL_SRDSCR1_OFFS, FSL_SRDSCR1_PLLBW);
> +
> +		/* Configure SRDSCR2 */
> +		clrsetbits_be32(regs + FSL_SRDSCR2_OFFS, FSL_SRDSCR2_SEIC_MASK,
> +				FSL_SRDSCR2_SEIC_PEX);
> +
> +		/* Configure SRDSCR3 */
> +		out_be32(regs + FSL_SRDSCR3_OFFS, FSL_SRDSCR3_SDFM_SATA_PEX);
> +
> +		/* Configure SRDSCR4 */
> +		if (of_get_property(np, "pcie-x2", NULL))
> +			out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
> +				FSL_SRDSCR4_PROT_PEX | FSL_SRDSCR4_PLANE_X2);
> +		else
> +			out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
> +				FSL_SRDSCR4_PROT_PEX);
> +
> +	} else if (!strcmp(prot, "sgmii")) {
> +		/* Configure SRDSCR1 */
> +		clrbits32(regs + FSL_SRDSCR1_OFFS, FSL_SRDSCR1_PLLBW);
> +
> +		/* Configure SRDSCR2 */
> +		clrsetbits_be32(regs + FSL_SRDSCR2_OFFS, FSL_SRDSCR2_SEIC_MASK,
> +				FSL_SRDSCR2_SEIC_SGMII);
> +
> +		/* Configure SRDSCR3 */
> +		out_be32(regs + FSL_SRDSCR3_OFFS, 0);
> +
> +		/* Configure SRDSCR4 */
> +		out_be32(regs + FSL_SRDSCR4_OFFS, rfcks |
> +				FSL_SRDSCR4_PROT_SGMII);
> +
> +	} else {
> +		printk(KERN_ERR "SerDes: Wrong protocol\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Do a software reset */
> +	setbits32(regs + FSL_SRDSRSTCTL_OFFS, FSL_SRDSRSTCTL_RST);
> +
> +	printk(KERN_INFO "Freescale SerDes at %8x initialized\n",  
> res.start);
> +
> +	return 0;
> +}
> +
> +static int __init fsl_serdes_init(void) {
> +	struct device_node *np;
> +
> +	for (np = NULL; (np = of_find_compatible_node(np, NULL,  
> "fsl,serdes")) != NULL;)

use for_each_compatible_node

> +		setup_serdes(np);
> +
> +	return 0;
> +}
> +
> +arch_initcall(fsl_serdes_init);
>

- k
