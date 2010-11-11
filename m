Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED3B0B7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Nov 2010 23:06:54 +1100 (EST)
Subject: Re: [PATCH 1/3] edac: Use ccsr_pci structure instead of hardcoded
	define
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1288927383-1300-1-git-send-email-b25806@freescale.com>
Date: Thu, 11 Nov 2010 06:06:42 -0600
Message-Id: <BBAE5445-9DA1-4E6B-9632-4EA95CB9C77B@kernel.crashing.org>
References: <1288927383-1300-1-git-send-email-b25806@freescale.com>
To: Lan Chunhe <b25806@freescale.com>
Cc: "Kai.Jiang" <Kai.Jiang@freescale.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 4, 2010, at 10:23 PM, Lan Chunhe wrote:

> There are some differences of register offset and definition between
> pci and pcie error management registers. While, some other pci/pcie
> error management registers are nearly the same.
>=20
> To merge pci and pcie edac code into one, it is easier to use ccsr_pci
> structure than the hardcoded define. So remove the hardcoded define =
and
> add pci/pcie error management register in ccsr_pci structure.
>=20
> Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Lan Chunhe <b25806@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.h |   54 =
+++++++++++++++++++++++++++++++---------
> drivers/edac/mpc85xx_edac.h   |   13 +--------
> 2 files changed, 44 insertions(+), 23 deletions(-)

You need to bring in the changes from the next patch that address the =
use of the ccsr_pci struct instead of #defines into this patch.  =
Otherwise we break building of the code.  Also it makes the next patch =
easier to read as we are mixing the changes associated with 'struct =
ccsr_pci' with what its doing

>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.h =
b/arch/powerpc/sysdev/fsl_pci.h
> index 8ad72a1..796985b 100644
> --- a/arch/powerpc/sysdev/fsl_pci.h
> +++ b/arch/powerpc/sysdev/fsl_pci.h
> @@ -1,7 +1,7 @@
> /*
>  * MPC85xx/86xx PCI Express structure define
>  *
> - * Copyright 2007 Freescale Semiconductor, Inc
> + * Copyright 2007, 2010 Freescale Semiconductor, Inc
>  *
>  * This program is free software; you can redistribute  it and/or =
modify it
>  * under  the terms of  the GNU General  Public License as published =
by the
> @@ -14,6 +14,8 @@
> #ifndef __POWERPC_FSL_PCI_H
> #define __POWERPC_FSL_PCI_H
>=20
> +#include <asm/pci-bridge.h>
> +
> #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status =
*/
> #define PCIE_LTSSM_L0	0x16		/* L0 state */
> #define PIWAR_EN		0x80000000	/* Enable */
> @@ -71,18 +73,46 @@ struct ccsr_pci {
>  */
> 	struct pci_inbound_window_regs piw[3];
>=20
> -	__be32	pex_err_dr;		/* 0x.e00 - PCI/PCIE error =
detect register */
> -	u8	res21[4];
> -	__be32	pex_err_en;		/* 0x.e08 - PCI/PCIE error =
interrupt enable register */
> -	u8	res22[4];
> -	__be32	pex_err_disr;		/* 0x.e10 - PCI/PCIE error =
disable register */
> -	u8	res23[12];
> -	__be32	pex_err_cap_stat;	/* 0x.e20 - PCI/PCIE error =
capture status register */
> +/* Merge PCI/PCI Express error management registers */
> +	__be32	pex_err_dr;	  /* 0x.e00
> +				   * - PCI/PCIE error detect register
> +				   */
> +	__be32	pex_err_cap_dr;	  /* 0x.e04
> +				   * - PCI error capture disabled =
register
> +				   * - PCIE has no this register
> +				   */
> +	__be32	pex_err_en;	  /* 0x.e08
> +				   * - PCI/PCIE error interrupt enable =
register
> +				   */
> +	__be32	pex_err_attrib;	  /* 0x.e0c
> +				   * - PCI error attributes capture =
register
> +				   * - PCIE has no this register
> +				   */
> +	__be32	pex_err_disr;	  /* 0x.e10
> +				   * - PCI error address capture =
register
> +				   * - PCIE error disable register
> +				   */
> +	__be32	pex_err_ext_addr; /* 0x.e14
> +				   * - PCI error extended addr capture =
register
> +				   * - PCIE has no this register
> +				   */
> +	__be32	pex_err_dl;	  /* 0x.e18
> +				   * - PCI error data low capture =
register
> +				   * - PCIE has no this register
> +				   */
> +	__be32	pex_err_dh;	  /* 0x.e1c
> +				   * - PCI error data high capture =
register
> +				   * - PCIE has no this register
> +				   */
> +	__be32	pex_err_cap_stat; /* 0x.e20
> +				   * - PCI gasket timer register
> +				   * - PCIE error capture status =
register
> +				   */
> 	u8	res24[4];
> -	__be32	pex_err_cap_r0;		/* 0x.e28 - PCIE error capture =
register 0 */
> -	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture =
register 0 */
> -	__be32	pex_err_cap_r2;		/* 0x.e30 - PCIE error capture =
register 0 */
> -	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture =
register 0 */
> +	__be32	pex_err_cap_r0;	  /* 0x.e28 - PCIE error capture =
register 0 */
> +	__be32	pex_err_cap_r1;	  /* 0x.e2c - PCIE error capture =
register 1 */
> +	__be32	pex_err_cap_r2;	  /* 0x.e30 - PCIE error capture =
register 2 */
> +	__be32	pex_err_cap_r3;	  /* 0x.e34 - PCIE error capture =
register 3 */
> };
>=20
> extern int fsl_add_bridge(struct device_node *dev, int is_primary);
> diff --git a/drivers/edac/mpc85xx_edac.h b/drivers/edac/mpc85xx_edac.h
> index cb24df8..099581d 100644
> --- a/drivers/edac/mpc85xx_edac.h
> +++ b/drivers/edac/mpc85xx_edac.h
> @@ -1,5 +1,7 @@
> /*
>  * Freescale MPC85xx Memory Controller kenel module
> + * Copyright (c) 2010 Freescale Semiconductor, Inc.
> + *
>  * Author: Dave Jiang <djiang@mvista.com>
>  *
>  * 2006-2007 (c) MontaVista Software, Inc. This file is licensed under
> @@ -131,17 +133,6 @@
> #define PCI_EDE_PERR_MASK	(PCI_EDE_TGT_PERR | PCI_EDE_MST_PERR | \
> 				PCI_EDE_ADDR_PERR)
>=20
> -#define MPC85XX_PCI_ERR_DR		0x0000
> -#define MPC85XX_PCI_ERR_CAP_DR		0x0004
> -#define MPC85XX_PCI_ERR_EN		0x0008
> -#define MPC85XX_PCI_ERR_ATTRIB		0x000c
> -#define MPC85XX_PCI_ERR_ADDR		0x0010
> -#define MPC85XX_PCI_ERR_EXT_ADDR	0x0014
> -#define MPC85XX_PCI_ERR_DL		0x0018
> -#define MPC85XX_PCI_ERR_DH		0x001c
> -#define MPC85XX_PCI_GAS_TIMR		0x0020
> -#define MPC85XX_PCI_PCIX_TIMR		0x0024
> -
> struct mpc85xx_mc_pdata {
> 	char *name;
> 	int edac_idx;
> --=20
> 1.5.4.5
>=20
