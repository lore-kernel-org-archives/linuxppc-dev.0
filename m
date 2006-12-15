Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EF1E67B6C
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2006 03:09:10 +1100 (EST)
In-Reply-To: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
References: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Fri, 15 Dec 2006 10:09:09 -0600
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 13, 2006, at 7:04 PM, Kim Phillips wrote:

> Eliminate platforms/83xx code redundancy. Common mpc83xx code  
> cleaned up
> and merged into setup.c. Each board maintains its own machine  
> definition
> and corresponding probe fn in its own file. Kconfig modified to  
> allow for
> multiple board selection in a single kernel image.
>
> This patch also utilizes of_platform_bus_probe() in lieu of manually
> calling of_platform_device_create for each ucc_geth device
> (consequently, the QE is added to of_default_bus_ids).
>
> The loops_per_jiffy assignment is removed since udelay now uses the  
> timebase.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/kernel/of_platform.c         |    1 +
>  arch/powerpc/platforms/83xx/Kconfig       |    6 -
>  arch/powerpc/platforms/83xx/Makefile      |    2 +-
>  arch/powerpc/platforms/83xx/mpc832x_mds.c |  176  
> +----------------------------
>  arch/powerpc/platforms/83xx/mpc832x_mds.h |   19 ---
>  arch/powerpc/platforms/83xx/mpc834x_itx.c |   92 +++------------
>  arch/powerpc/platforms/83xx/mpc834x_itx.h |   23 ----
>  arch/powerpc/platforms/83xx/mpc834x_sys.c |  111 +++---------------
>  arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 ----
>  arch/powerpc/platforms/83xx/mpc8360e_pb.c |  175  
> +----------------------------
>  arch/powerpc/platforms/83xx/mpc83xx.h     |    2 +
>  arch/powerpc/platforms/83xx/setup.c       |  176 ++++++++++++++++++ 
> +++++++++++
>  12 files changed, 220 insertions(+), 586 deletions(-)

[snip]

> diff --git a/arch/powerpc/platforms/83xx/setup.c b/arch/powerpc/ 
> platforms/83xx/setup.c
> new file mode 100644
> index 0000000..4d59aa0
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/setup.c
> @@ -0,0 +1,176 @@
> +/*
> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights  
> reserved.
> + *
> + * Author: Li Yang <LeoLi@freescale.com>
> + *	   Yin Olivia <Hong-hua.Yin@freescale.com>
> + *
> + * Description:
> + * MPC83xx board routines.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/reboot.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/major.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/initrd.h>
> +
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>
> +#include <asm/system.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/bootinfo.h>
> +#include <asm/irq.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <sysdev/fsl_soc.h>
> +#include <asm/qe.h>
> +#include <asm/qe_ic.h>
> +
> +#include "mpc83xx.h"
> +
> +#undef DEBUG
> +#ifdef DEBUG
> +#define DBG(fmt...) udbg_printf(fmt)
> +#else
> +#define DBG(fmt...)
> +#endif
> +
> +#ifndef CONFIG_PCI
> +unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +#endif
> +
> +static u8 __iomem *bcsr_regs = NULL;
> +
> +u8 *get_bcsr(void)
> +{
> +	return bcsr_regs;
> +}

I don't think bcsr code should be setup.c as its not generic, but its  
not causing any harm.

> +
> +/*  
> ********************************************************************** 
> **
> + *
> + * Setup the architecture
> + *
> + */
> +void __init mpc83xx_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc83xx_setup_arch()", 0);
> +
> +	/* Map BCSR area */
> +	np = of_find_node_by_name(NULL, "bcsr");
> +	if (np != 0) {
> +		struct resource res;
> +
> +		of_address_to_resource(np, 0, &res);
> +		bcsr_regs = ioremap(res.start, res.end - res.start + 1);
> +		of_node_put(np);
> +	}
> +
> +#ifdef CONFIG_PCI
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);
> +	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> +#endif
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	if ((np = of_find_node_by_type(NULL, "qe")) != NULL) {
> +		qe_reset();
> +		of_node_put(np);
> +	}
> +
> +	if ((np = of_find_node_by_name(np, "par_io")) != NULL) {
> +		par_io_init(np);
> +		of_node_put(np);
> +
> +		for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
> +			par_io_of_config(np);
> +	}
> +
> +	if ((np = of_find_compatible_node(NULL, "network", "ucc_geth"))
> +			!= NULL){
> +		/* Reset the Ethernet PHY */
> +		bcsr_regs[9] &= ~0x20;
> +		udelay(1000);
> +		bcsr_regs[9] |= 0x20;
> +		iounmap(bcsr_regs);
> +		of_node_put(np);
> +	}
> +
> +#endif				/* CONFIG_QUICC_ENGINE */
> +}
> +
> +static int __init mpc83xx_publish_devices(void)
> +{
> +	if (machine_is(mpc83xx))
> +		of_platform_bus_probe(NULL, NULL, NULL);
> +

Does this every get called, meaning does anything match machine_is 
(mpc83xx)?

> +	return 0;
> +}
> +device_initcall(mpc83xx_publish_devices);
> +
> +void __init mpc83xx_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_node_by_type(NULL, "ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);
> +
> +	/* Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	ipic_set_default_priority();
> +	of_node_put(np);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	np = of_find_node_by_type(NULL, "qeic");
> +	if (!np)
> +		return;
> +
> +	qe_ic_init(np, 0);
> +	of_node_put(np);
> +#endif				/* CONFIG_QUICC_ENGINE */
> +}
> +
> +#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
> +extern ulong ds1374_get_rtc_time(void);
> +extern int ds1374_set_rtc_time(ulong);
> +
> +static int __init mpc83xx_rtc_hookup(void)
> +{
> +	struct timespec tv;
> +
> +	ppc_md.get_rtc_time = ds1374_get_rtc_time;
> +	ppc_md.set_rtc_time = ds1374_set_rtc_time;
> +
> +	tv.tv_nsec = 0;
> +	tv.tv_sec = (ppc_md.get_rtc_time) ();
> +	do_settimeofday(&tv);
> +
> +	return 0;
> +}
> +
> +late_initcall(mpc83xx_rtc_hookup);
> +#endif

This is sort of evil and we need to clean it up, but we have some  
time for 2.6.21.  Does the MPC832x MDS have the DS1374?

- k
