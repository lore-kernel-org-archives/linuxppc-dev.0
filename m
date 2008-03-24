Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AD23DDF82
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 00:42:24 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2ODewmV029486
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 09:40:58 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2ODg6pg021838
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 07:42:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2ODg64d028840
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 07:42:06 -0600
Date: Mon, 24 Mar 2008 08:39:57 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/2 v2] [POWERPC] Add PPC4xx L2-cache support (440GX)
Message-ID: <20080324083957.2945077c@zod.rchland.ibm.com>
In-Reply-To: <1206181736-21796-1-git-send-email-sr@denx.de>
References: <1206181736-21796-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 22 Mar 2008 11:28:56 +0100
Stefan Roese <sr@denx.de> wrote:

> This patch adds support for the 256k L2 cache found on some IBM/AMCC
> 4xx PPC's. It introduces a common 4xx SoC file (sysdev/ppc4xx_soc.c)
> which currently "only" adds the L2 cache init code. Other common 4xx
> stuff can be added later here.
> 
> The L2 cache handling code is a copy of Eugene's code in arch/ppc
> with small modifications.
> 
> Tested on AMCC Taishan 440GX.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

Hi Stefan.  Small, very minor issues below.

> diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
> new file mode 100644
> index 0000000..4847555
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_soc.c
> @@ -0,0 +1,178 @@
> +/*
> + * IBM/AMCC PPC4xx SoC setup code
> + *
> + * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
> + *
> + * L2 cache routines cloned from arch/ppc/syslib/ibm440gx_common.c which is:
> + *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
> + *   Copyright (c) 2003 - 2006 Zultys Technologies
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/dcr.h>
> +#include <asm/dcr-regs.h>
> +
> +static u32 dcrbase;

If this file is really intended to have other miscellaneous stuff added
to it, perhaps this variable should be renamed l2_dcrbase.  I know it's
minor, so perhaps we can wait until something else gets added.

> +
> +/*
> + * L2-cache
> + */
> +
> +/* Issue L2C diagnostic command */
> +static inline u32 l2c_diag(u32 addr)
> +{
> +	mtdcr(dcrbase + DCRN_L2C0_ADDR, addr);
> +	mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_DIAG);
> +	while (!(mfdcr(dcrbase + DCRN_L2C0_SR) & L2C_SR_CC))
> +		;
> +
> +	return mfdcr(dcrbase + DCRN_L2C0_DATA);
> +}
> +
> +static irqreturn_t l2c_error_handler(int irq, void *dev)
> +{
> +	u32 sr = mfdcr(dcrbase + DCRN_L2C0_SR);
> +
> +	if (sr & L2C_SR_CPE) {
> +		/* Read cache trapped address */
> +		u32 addr = l2c_diag(0x42000000);

What is this magical hex number?

> +		printk(KERN_EMERG "L2C: Cache Parity Error, addr[16:26] = 0x%08x\n",
> +		       addr);
> +	}
> +	if (sr & L2C_SR_TPE) {
> +		/* Read tag trapped address */
> +		u32 addr = l2c_diag(0x82000000) >> 16;

And here?

> +		printk(KERN_EMERG "L2C: Tag Parity Error, addr[16:26] = 0x%08x\n",
> +		       addr);
> +	}
> +
> +	/* Clear parity errors */
> +	if (sr & (L2C_SR_CPE | L2C_SR_TPE)){
> +		mtdcr(dcrbase + DCRN_L2C0_ADDR, 0);
> +		mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_CCP | L2C_CMD_CTE);
> +	} else {
> +		printk(KERN_EMERG "L2C: LRU error\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init ppc4xx_l2c_probe(void)
> +{
> +	struct device_node *np;
> +	u32 r;
> +	unsigned long flags;
> +	int irq;
> +	const u32 *dcrreg;
> +	u32 dcrbase_isram;
> +	int len;
> +
> +	np = of_find_compatible_node(np, NULL, "ibm,l2-cache");
> +	if (!np)
> +		return 0;
> +
> +	/* Map DCRs */
> +	dcrreg = of_get_property(np, "dcr-reg", &len);
> +	if (!dcrreg || (len != 4 * sizeof(u32))) {
> +		printk(KERN_ERR "%s: Can't get DCR register base !",
> +		       np->full_name);
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +	dcrbase_isram = dcrreg[0];
> +	dcrbase = dcrreg[2];
> +
> +	/* Get and map irq number from device tree */
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq == NO_IRQ) {
> +		printk(KERN_ERR "irq_of_parse_and_map failed\n");
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	/* Install error handler */
> +	if (request_irq(irq, l2c_error_handler, IRQF_DISABLED, "L2C", 0) < 0) {
> +		printk(KERN_ERR "Cannot install L2C error handler"
> +		       ", cache is not enabled\n");
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	local_irq_save(flags);
> +	asm volatile ("sync" ::: "memory");

Perhaps just call iosync() for these instead of the open coded asm
volatile stuff?

> +
> +	/* Disable SRAM */
> +	mtdcr(dcrbase_isram + DCRN_SRAM0_DPC,
> +	      mfdcr(dcrbase_isram + DCRN_SRAM0_DPC) & ~SRAM_DPC_ENABLE);
> +	mtdcr(dcrbase_isram + DCRN_SRAM0_SB0CR,
> +	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB0CR) & ~SRAM_SBCR_BU_MASK);
> +	mtdcr(dcrbase_isram + DCRN_SRAM0_SB1CR,
> +	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB1CR) & ~SRAM_SBCR_BU_MASK);
> +	mtdcr(dcrbase_isram + DCRN_SRAM0_SB2CR,
> +	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB2CR) & ~SRAM_SBCR_BU_MASK);
> +	mtdcr(dcrbase_isram + DCRN_SRAM0_SB3CR,
> +	      mfdcr(dcrbase_isram + DCRN_SRAM0_SB3CR) & ~SRAM_SBCR_BU_MASK);
> +
> +	/* Enable L2_MODE without ICU/DCU */
> +	r = mfdcr(dcrbase + DCRN_L2C0_CFG) &
> +		~(L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_SS_MASK);
> +	r |= L2C_CFG_L2M | L2C_CFG_SS_256;
> +	mtdcr(dcrbase + DCRN_L2C0_CFG, r);
> +
> +	mtdcr(dcrbase + DCRN_L2C0_ADDR, 0);
> +
> +	/* Hardware Clear Command */
> +	mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_HCC);
> +	while (!(mfdcr(dcrbase + DCRN_L2C0_SR) & L2C_SR_CC))
> +		;
> +
> +	/* Clear Cache Parity and Tag Errors */
> +	mtdcr(dcrbase + DCRN_L2C0_CMD, L2C_CMD_CCP | L2C_CMD_CTE);
> +
> +	/* Enable 64G snoop region starting at 0 */
> +	r = mfdcr(dcrbase + DCRN_L2C0_SNP0) &
> +		~(L2C_SNP_BA_MASK | L2C_SNP_SSR_MASK);
> +	r |= L2C_SNP_SSR_32G | L2C_SNP_ESR;
> +	mtdcr(dcrbase + DCRN_L2C0_SNP0, r);
> +
> +	r = mfdcr(dcrbase + DCRN_L2C0_SNP1) &
> +		~(L2C_SNP_BA_MASK | L2C_SNP_SSR_MASK);
> +	r |= 0x80000000 | L2C_SNP_SSR_32G | L2C_SNP_ESR;
> +	mtdcr(dcrbase + DCRN_L2C0_SNP1, r);
> +
> +	asm volatile ("sync" ::: "memory");
> +
> +	/* Enable ICU/DCU ports */
> +	r = mfdcr(dcrbase + DCRN_L2C0_CFG);
> +	r &= ~(L2C_CFG_DCW_MASK | L2C_CFG_PMUX_MASK | L2C_CFG_PMIM
> +	       | L2C_CFG_TPEI | L2C_CFG_CPEI | L2C_CFG_NAM | L2C_CFG_NBRM);
> +	r |= L2C_CFG_ICU | L2C_CFG_DCU | L2C_CFG_TPC | L2C_CFG_CPC | L2C_CFG_FRAN
> +		| L2C_CFG_CPIM | L2C_CFG_TPIM | L2C_CFG_LIM | L2C_CFG_SMCM;
> +
> +	/* Check for 460EX/GT special handling */
> +	if (of_device_is_compatible(np, "ibm,l2-cache-460ex"))
> +		r |= L2C_CFG_RDBW;
> +
> +	mtdcr(dcrbase + DCRN_L2C0_CFG, r);
> +
> +	asm volatile ("sync; isync" ::: "memory");
> +	local_irq_restore(flags);
> +
> +	printk(KERN_INFO "256k L2-cache enabled\n");

Should the cache size be derived from the device tree?

josh
