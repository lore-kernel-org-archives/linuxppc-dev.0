Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 3/9] add Freescale SerDes PHY support
Date: Fri, 12 Oct 2007 16:33:48 +0200
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-3-git-send-email-leoli@freescale.com>
	<1192195728-24189-4-git-send-email-leoli@freescale.com>
In-Reply-To: <1192195728-24189-4-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710121633.49263.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 12 October 2007, Li Yang wrote:
> The SerDes(serializer/deserializer) PHY block is a new SoC block used
> in Freescale chips to support multiple serial interfaces, such as PCI
> Express, SGMII, SATA.

Some of my comments here are similar to those for the ata driver,
so I won't be as verbose here

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

of_iomap?

Also, shouldn't there be a matching iounmap?

> +static int __init fsl_serdes_init(void) {
> +	struct device_node *np;
> +
> +	for (np = NULL; (np = of_find_compatible_node(np, NULL, "fsl,serdes")) != NULL;)
> +		setup_serdes(np);
> +
> +	return 0;
> +}
> +
> +arch_initcall(fsl_serdes_init);

I suppose the reason why you can't use an of_platform_device here is that
the serdes node is a child of the actual device that is using the serdes
interface, right?

Could you perhaps call fsl_serdes_init from all the drivers that can have
a serdes attachment, and pass the parent device into the setup function? 

> diff --git a/arch/powerpc/sysdev/fsl_serdes.h b/arch/powerpc/sysdev/fsl_serdes.h
> new file mode 100644
> index 0000000..d4e5570
> --- /dev/null
> +++ b/arch/powerpc/sysdev/fsl_serdes.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +/* SerDes registers */
> +#define FSL_SRDSCR0_OFFS		0x0
> +#define FSL_SRDSCR0_DPP_1V2		0x00008800
> +#define FSL_SRDSCR1_OFFS		0x4
> +#define FSL_SRDSCR1_PLLBW		0x00000040
> +#define FSL_SRDSCR2_OFFS		0x8
> +#define FSL_SRDSCR2_VDD_1V2		0x00800000
> +#define FSL_SRDSCR2_SEIC_MASK		0x00001c1c
> +#define FSL_SRDSCR2_SEIC_SATA		0x00001414
> +#define FSL_SRDSCR2_SEIC_PEX		0x00001010
> +#define FSL_SRDSCR2_SEIC_SGMII		0x00000101
> +#define FSL_SRDSCR3_OFFS		0xc
> +#define FSL_SRDSCR3_KFR_SATA		0x10100000
> +#define FSL_SRDSCR3_KPH_SATA		0x04040000
> +#define FSL_SRDSCR3_SDFM_SATA_PEX	0x01010000
> +#define FSL_SRDSCR3_SDTXL_SATA		0x00000505
> +#define FSL_SRDSCR4_OFFS		0x10
> +#define FSL_SRDSCR4_PROT_SATA		0x00000808
> +#define FSL_SRDSCR4_PROT_PEX		0x00000101
> +#define FSL_SRDSCR4_PROT_SGMII		0x00000505
> +#define FSL_SRDSCR4_PLANE_X2		0x01000000
> +#define FSL_SRDSCR4_RFCKS_100		0x00000000
> +#define FSL_SRDSCR4_RFCKS_125		0x10000000
> +#define FSL_SRDSCR4_RFCKS_150		0x30000000
> +#define FSL_SRDSRSTCTL_OFFS		0x20
> +#define FSL_SRDSRSTCTL_RST		0x80000000
> +#define FSL_SRDSRSTCTL_SATA_RESET	0xf

These can all be moved to the source file so you can kill the
entire header.

	Arnd <><
