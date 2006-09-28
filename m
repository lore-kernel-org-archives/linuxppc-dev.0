Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56F6867B69
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 02:05:14 +1000 (EST)
In-Reply-To: <451B858E.5030008@freescale.com>
References: <451B858E.5030008@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D7F6C931-4576-41D9-8A5A-7B7EEDB30A8F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/12] Add MPC8360EMDS board support
Date: Thu, 28 Sep 2006 11:05:26 -0500
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


On Sep 28, 2006, at 3:19 AM, Li Yang wrote:

> The patch adds MPC8360EMDS board support.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Yin Olivia <hong-hua.yin@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> arch/powerpc/configs/mpc8360emds_defconfig | 1018 ++++++++++++++++++ 
> ++++++++++
> arch/powerpc/platforms/83xx/Kconfig        |   17 arch/powerpc/ 
> platforms/83xx/Makefile       |    1 arch/powerpc/platforms/83xx/ 
> mpc8360e_pb.c  |  222 ++++++
> arch/powerpc/platforms/83xx/mpc8360e_pb.h  |   31 +
> 5 files changed, 1289 insertions(+), 0 deletions(-)
>
[snip]

> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/ 
> platforms/83xx/Kconfig
> index 5fe7b7f..a5d349b 100644
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
> @@ -25,6 +25,13 @@ config MPC834x_ITX
> 	  Be aware that PCI initialization is the bootloader's
> 	  responsiblilty.
> +config MPC8360E_PB
> +	bool "Freescale MPC8360E PB"
> +	select DEFAULT_UIMAGE
> +	select QUICC_ENGINE
> +	help
> +	  This option enables support for the MPC836x EMDS Processor Board.
> +
> endchoice
> config MPC834x
> @@ -33,4 +40,14 @@ config MPC834x
> 	select PPC_INDIRECT_PCI
> 	default y if MPC834x_SYS || MPC834x_ITX
> +config MPC836x
> +	bool
> +	select PPC_UDBG_16550
> +	select PPC_INDIRECT_PCI
> +	default y if MPC8360E_PB
> +

Make this PPC_MPC836x (we need to change 834x, but haven't done it  
since it impacts arch/ppc as well)

> +config 834x_USB_SUPPORT
> +	bool
> +	default y if MPC834x_SYS && (USB || USB_GADGET)
> +	

What's this doing in here :)

> endmenu
> diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/ 
> platforms/83xx/Makefile
> index 9387a11..0da2d0d 100644
> --- a/arch/powerpc/platforms/83xx/Makefile
> +++ b/arch/powerpc/platforms/83xx/Makefile
> @@ -5,3 +5,4 @@ obj-y				:= misc.o
> obj-$(CONFIG_PCI)		+= pci.o
> obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
> obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
> +obj-$(CONFIG_MPC8360E_PB)	+= mpc8360e_pb.o
> diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/ 
> powerpc/platforms/83xx/mpc8360e_pb.c
> new file mode 100644
> index 0000000..a142521
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
> @@ -0,0 +1,222 @@
> +/*
> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights  
> reserved.
> + *
> + * Author: Li Yang <LeoLi@freescale.com>
> + *	   Yin Olivia <Hong-hua.Yin@freescale.com>
> + *
> + * Description:
> + * MPC8360E MDS PB board specific routines. + *
> + * Changelog: + * Jun 21, 2006	Initial version
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
> +#include <linux/config.h>

remove, no longer need to include <linux/config.h>

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
> +#ifdef CONFIG_QUICC_ENGINE
> +#include <asm/immap_qe.h>
> +#include <asm/qe_ic.h>
> +#endif				/* CONFIG_QUICC_ENGINE */

Its probably better to move the ifdef protection into the header for  
these.

> +#include "mpc83xx.h"
> +#include "mpc8360e_pb.h"
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
> +static u8 *bcsr_regs = NULL;
> +
> +u8 *get_bcsr(void)
> +{
> +	return bcsr_regs;
> +}
> +
> +/*  
> ********************************************************************** 
> **
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init mpc8360_sys_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc8360_sys_setup_arch()", 0);
> +
> +	np = of_find_node_by_type(NULL, "cpu");
> +	if (np != 0) {
> +		unsigned int *fp =
> +		    (int *)get_property(np, "clock-frequency", NULL);
> +		if (fp != 0)
> +			loops_per_jiffy = *fp / HZ;
> +		else
> +			loops_per_jiffy = 50000000 / HZ;
> +		of_node_put(np);
> +	}
> +
> +	/* Map BCSR area */
> +	np = of_find_node_by_name(NULL, "bcsr");
> +	if (np != 0) {
> +		struct resource res;
> +
> +		of_address_to_resource(np, 0, &res);
> +		bcsr_regs = (u8 *)ioremap(res.start, res.end - res.start +1);

you don't need to cast the result of ioremap

> +		of_node_put(np);
> +	}
> +
> +#ifdef CONFIG_PCI
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);
> +
> +	ppc_md.pci_swizzle = common_swizzle;
> +	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> +#endif
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +	qe_reset();
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
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	if (initrd_start)
> +		ROOT_DEV = Root_RAM0;
> +	else
> +#endif
> +#ifdef  CONFIG_ROOT_NFS
> +		ROOT_DEV = Root_NFS;
> +#else
> +		ROOT_DEV = Root_HDA1;
> +#endif
> +}
> +
> +void __init mpc8360_sys_init_IRQ(void)
> +{
> +
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
> +	qe_ic_init(np, 0); +	of_node_put(np);
> +#endif				/* CONFIG_QUICC_ENGINE */
> +}
> +
> +#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
> +extern ulong ds1374_get_rtc_time(void);
> +extern int ds1374_set_rtc_time(ulong);
> +
> +static int __init mpc8360_rtc_hookup(void)
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
> +late_initcall(mpc8360_rtc_hookup);
> +#endif
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init mpc8360_sys_probe(void)
> +{
> +	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
> +					  "model", NULL);
> +	if (model == NULL)
> +		return 0;
> +	if (strcmp(model, "MPC8360EPB"))
> +		return 0;
> +
> +	DBG("MPC8360EMDS-PB found\n");
> +
> +	return 1;
> +}
> +
> +define_machine(mpc8360_sys) {
> +	.name 		= "MPC8360E PB",
> +	.probe 		= mpc8360_sys_probe,
> +	.setup_arch 	= mpc8360_sys_setup_arch,
> +	.init_IRQ 	= mpc8360_sys_init_IRQ,
> +	.get_irq 	= ipic_get_irq,
> +	.restart 	= mpc83xx_restart,
> +	.time_init 	= mpc83xx_time_init,
> +	.calibrate_decr	= generic_calibrate_decr,
> +	.progress 	= udbg_progress,
> +};
> diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.h b/arch/ 
> powerpc/platforms/83xx/mpc8360e_pb.h
> new file mode 100644
> index 0000000..1427e0f
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights  
> reserved.
> + *
> + * Author: Li Yang <LeoLi@freescale.com>
> + *	   Yin Olivia <Hong-hua.Yin@freescale.com>
> + *
> + * Description:
> + * MPC8360E MDS PB board specific header. + *
> + * Changelog: + * Jun 21, 2006	Initial version
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifndef __MACH_MPC83XX_SYS_H__
> +#define __MACH_MPC83XX_SYS_H__
> +
> +extern u8 *get_bcsr(void);
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +extern void qe_reset(void);
> +extern int par_io_init(struct device_node *np);
> +extern int par_io_of_config(struct device_node *np);

seems like these should live in some qe header.

> +#endif  /* CONFIG_QUICC_ENGINE */
> +
> +#endif				/* __MACH_MPC83XX_SYS_H__ */
