Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74FD22C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 09:11:57 +1000 (EST)
Date: Mon, 22 Jul 2013 18:11:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo <X.Xie@freescale.com>
Subject: Re: powerpc/85xx: Add TWR-P1025 board support
Message-ID: <20130722231135.GA26665@home.buserror.net>
References: <1366874028-18870-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1366874028-18870-1-git-send-email-X.Xie@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Michael Johnston <michael.johnston@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 25, 2013 at 03:13:48PM +0800, Xie Xiaobo wrote:
> +		partition@400000 {
> +			/* 58.75MB for JFFS2 based Root file System */
> +			reg = <0x00400000 0x03ac0000>;
> +			label = "NOR JFFS2 Root File System";
> +		};

Don't specify JFFS2.

> diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
> new file mode 100644
> index 0000000..a5de4e0
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/twr_p102x.c
> @@ -0,0 +1,176 @@
> +/*
> + * Copyright 2010-2011, 2013 Freescale Semiconductor, Inc.
> + *
> + * Author: Michael Johnston <michael.johnston@freescale.com>
> + *
> + * Description:
> + * TWR-P102x Board Setup
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/memblock.h>
> +
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +#include <asm/qe.h>
> +#include <asm/qe_ic.h>
> +#include <asm/fsl_guts.h>
> +
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +#include "smp.h"
> +
> +#include "mpc85xx.h"

Are you sure you need all of these?  I don't see any delays, for example.

> +static void __init twr_p1025_pic_init(void)
> +{
> +	struct mpic *mpic;
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	struct device_node *np;
> +#endif
> +
> +	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
> +			MPIC_SINGLE_DEST_CPU,
> +			0, 256, " OpenPIC  ");
> +
> +	BUG_ON(mpic == NULL);
> +	mpic_init(mpic);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> +	if (np) {
> +		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> +				qe_ic_cascade_high_mpic);
> +		of_node_put(np);
> +	} else
> +		printk(KERN_ERR "Could not find qe-ic node\n");

WARNING: Prefer netdev_err(netdev, ... then dev_err(dev, ... then
pr_err(...  to printk(KERN_ERR ...
#529: FILE: arch/powerpc/platforms/85xx/twr_p102x.c:65:
+		printk(KERN_ERR "Could not find qe-ic node\n");

Likewise elsewhere.

Also, it'd be nice if this code (as well as the QE code later in this
file) were factored out to a QE file rather than being duplicated in
board files.

> +static int __init twr_p1025_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "fsl,TWR-P1025");
> +
> +}

Remove the newline at the end of the function.

-Scott
 
