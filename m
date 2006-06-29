Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D073B67B56
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 15:11:01 +1000 (EST)
In-Reply-To: <20060628211317.7b21d085.kim.phillips@freescale.com>
References: <20060628211317.7b21d085.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <99F42AA0-3028-4C80-86C1-14A210C41229@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Add support for the Freescale MPC8349E-mITX eval board
Date: Thu, 29 Jun 2006 00:10:56 -0500
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


On Jun 28, 2006, at 9:13 PM, Kim Phillips wrote:

> Add support for the Freescale MPC8349E-mITX eval board
>
> This is largely based on 8349 SYS code except that it uses the new  
> rtc_class code in drivers/rtc instead of explicitly specifying the  
> rtc chip.  SATA is untested, as this is work in progress.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
>  arch/powerpc/platforms/83xx/Kconfig       |   11 ++
>  arch/powerpc/platforms/83xx/Makefile      |    1
>  arch/powerpc/platforms/83xx/misc.c        |   52 +++++++++
>  arch/powerpc/platforms/83xx/mpc834x_itx.c |  166 ++++++++++++++++++ 
> +++++++++++
>  arch/powerpc/platforms/83xx/mpc834x_itx.h |   23 ++++
>  arch/powerpc/platforms/83xx/mpc83xx.h     |    5 +
>  include/asm-ppc/mpc83xx.h                 |    4 +
>  7 files changed, 261 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/platforms/83xx/mpc834x_itx.c
>  create mode 100644 arch/powerpc/platforms/83xx/mpc834x_itx.h
>
> 3182b4a50027d17badab0c7b8dc2fd4d8fc307b0
> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/ 
> platforms/83xx/Kconfig
> index 7675e67..5fe7b7f 100644
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
> @@ -16,12 +16,21 @@ config MPC834x_SYS
>  	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
>  	  responsiblilty.
>
> +config MPC834x_ITX
> +	bool "Freescale MPC834x ITX"
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for the MPC 834x ITX evaluation board.
> +
> +	  Be aware that PCI initialization is the bootloader's
> +	  responsiblilty.
> +
>  endchoice
>
>  config MPC834x
>  	bool
>  	select PPC_UDBG_16550
>  	select PPC_INDIRECT_PCI
> -	default y if MPC834x_SYS
> +	default y if MPC834x_SYS || MPC834x_ITX
>
>  endmenu
> diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/ 
> platforms/83xx/Makefile
> index 5c72367..9387a11 100644
> --- a/arch/powerpc/platforms/83xx/Makefile
> +++ b/arch/powerpc/platforms/83xx/Makefile
> @@ -4,3 +4,4 @@
>  obj-y				:= misc.o
>  obj-$(CONFIG_PCI)		+= pci.o
>  obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
> +obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
> diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/ 
> platforms/83xx/misc.c
> index 1455bce..568a8f7 100644
> --- a/arch/powerpc/platforms/83xx/misc.c
> +++ b/arch/powerpc/platforms/83xx/misc.c
> @@ -53,3 +53,55 @@ long __init mpc83xx_time_init(void)
>
>  	return 0;
>  }
> +
> +#ifdef CONFIG_RTC_CLASS
> +int mpc83xx_set_rtc_time(struct rtc_time *tm)
> +{
> +	int err;
> +	struct class_device *class_dev =
> +		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
> +
> +	if (class_dev == NULL) {
> +		printk("%s: unable to open rtc device (%s)\n",
> +			__FUNCTION__, CONFIG_RTC_HCTOSYS_DEVICE);
> +		return -ENODEV;
> +	}
> +
> +	err = rtc_set_time(class_dev, tm);
> +	if (err != 0)
> +		dev_err(class_dev->dev,
> +			"%s: unable to set the hardware clock\n",__FUNCTION__);
> +
> +	rtc_class_close(class_dev);
> +
> +	return 0;
> +}
> +
> +void mpc83xx_get_rtc_time(struct rtc_time *tm)
> +{
> +	int err;
> +	struct class_device *class_dev =
> +		rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
> +
> +	if (class_dev == NULL) {
> +		printk("%s: unable to open rtc device (%s)\n",
> +			__FUNCTION__, CONFIG_RTC_HCTOSYS_DEVICE);
> +		return;
> +	}
> +
> +	err = rtc_read_time(class_dev, tm);
> +	if (err == 0) {
> +		err = rtc_valid_tm(tm);
> +		if (err != 0)
> +			dev_err(class_dev->dev,
> +				"%s: invalid date/time\n",__FUNCTION__);
> +	}
> +	else
> +		dev_err(class_dev->dev,
> +			"%s: unable to read the hardware clock\n",__FUNCTION__);
> +
> +	rtc_class_close(class_dev);
> +
> +	return;
> +}
> +#endif /* CONFIG_RTC_CLASS */

What is this trying to accomplish?  What RTC chip is on 834x ITC and  
how's it connected?

> diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/ 
> powerpc/platforms/83xx/mpc834x_itx.c
> new file mode 100644
> index 0000000..0a3f58a
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> @@ -0,0 +1,166 @@
> +/*
> + * arch/powerpc/platforms/83xx/mpc834x_itx.c
> + *
> + * MPC834x ITX board specific routines
> + *
> + * Maintainer: Kumar Gala <galak@kernel.crashing.org>
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
> +
> +#include "mpc83xx.h"
> +
> +#ifndef CONFIG_PCI
> +unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +#endif
> +
> +#ifdef CONFIG_PCI
> +static int
> +mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned  
> char pin)
> +{
> +	static char pci_irq_table[][4] =
> +	    /*
> +	     *      PCI IDSEL/INTPIN->INTLINE
> +	     *       A      B      C      D
> +	     */
> +	{
> +		{PIRQB, PIRQC, PIRQD, PIRQA},	/* idsel 0x0e */
> +		{PIRQA, PIRQB, PIRQC, PIRQD},	/* idsel 0x0f */
> +		{PIRQC, PIRQD, PIRQA, PIRQB},	/* idsel 0x10 */
> +	};
> +
> +	const long min_idsel = 0x0e, max_idsel = 0x10, irqs_per_slot = 4;
> +	return PCI_IRQ_TABLE_LOOKUP;
> +}
> +#endif				/* CONFIG_PCI */
> +
> +/*  
> ********************************************************************** 
> **
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init mpc834x_itx_setup_arch(void)
> +{
> +	struct device_node *np;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc834x_itx_setup_arch()", 0);
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
> +#ifdef CONFIG_PCI
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);
> +
> +	ppc_md.pci_swizzle = common_swizzle;
> +	ppc_md.pci_map_irq = mpc83xx_map_irq;
> +	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> +#endif
> +
> +#ifdef  CONFIG_ROOT_NFS
> +	ROOT_DEV = Root_NFS;
> +#else
> +	ROOT_DEV = Root_HDA1;
> +#endif
> +}
> +
> +void __init mpc834x_itx_init_IRQ(void)
> +{
> +	u8 senses[8] = {
> +		0,			/* EXT 0 */
> +		IRQ_SENSE_LEVEL,	/* EXT 1 */
> +		IRQ_SENSE_LEVEL,	/* EXT 2 */
> +		0,			/* EXT 3 */
> +#ifdef CONFIG_PCI
> +		IRQ_SENSE_LEVEL,	/* EXT 4 */
> +		IRQ_SENSE_LEVEL,	/* EXT 5 */
> +		IRQ_SENSE_LEVEL,	/* EXT 6 */
> +		IRQ_SENSE_LEVEL,	/* EXT 7 */
> +#else
> +		0,			/* EXT 4 */
> +		0,			/* EXT 5 */
> +		0,			/* EXT 6 */
> +		0,			/* EXT 7 */
> +#endif
> +	};
> +
> +	ipic_init(get_immrbase() + 0x00700, 0, 0, senses, 8);
> +
> +	/* Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	ipic_set_default_priority();
> +}
> +
> +#ifdef CONFIG_RTC_CLASS
> +static int __init mpc834x_rtc_hookup(void)
> +{
> +	ppc_md.get_rtc_time = mpc83xx_get_rtc_time;
> +	ppc_md.set_rtc_time = mpc83xx_set_rtc_time;
> +
> +	return 0;
> +}
> +
> +late_initcall(mpc834x_rtc_hookup);
> +#endif
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init mpc834x_itx_probe(void)
> +{
> +	/* We always match for now, eventually we should look at the flat
> +	   dev tree to ensure this is the board we are suppose to run on
> +	*/
> +	return 1;
> +}
> +
> +define_machine(mpc834x_itx) {
> +	.name			= "MPC834x ITX",
> +	.probe			= mpc834x_itx_probe,
> +	.setup_arch		= mpc834x_itx_setup_arch,
> +	.init_IRQ		= mpc834x_itx_init_IRQ,
> +	.get_irq		= ipic_get_irq,
> +	.restart		= mpc83xx_restart,
> +	.time_init		= mpc83xx_time_init,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +};
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.h b/arch/ 
> powerpc/platforms/83xx/mpc834x_itx.h
> new file mode 100644
> index 0000000..174ca4e
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.h
> @@ -0,0 +1,23 @@
> +/*
> + * arch/powerpc/platforms/83xx/mpc834x_itx.h
> + *
> + * MPC834X ITX common board definitions
> + *
> + * Maintainer: Kumar Gala <galak@kernel.crashing.org>
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
> +#ifndef __MACH_MPC83XX_ITX_H__
> +#define __MACH_MPC83XX_ITX_H__
> +
> +#define PIRQA	MPC83xx_IRQ_EXT4
> +#define PIRQB	MPC83xx_IRQ_EXT5
> +#define PIRQC	MPC83xx_IRQ_EXT6
> +#define PIRQD	MPC83xx_IRQ_EXT7
> +
> +#endif				/* __MACH_MPC83XX_ITX_H__ */
> diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/ 
> platforms/83xx/mpc83xx.h
> index 01cae10..532a084 100644
> --- a/arch/powerpc/platforms/83xx/mpc83xx.h
> +++ b/arch/powerpc/platforms/83xx/mpc83xx.h
> @@ -3,6 +3,7 @@
>
>  #include <linux/init.h>
>  #include <linux/device.h>
> +#include <linux/rtc.h>
>
>  /*
>   * Declaration for the various functions exported by the
> @@ -13,5 +14,9 @@ extern int add_bridge(struct device_node
>  extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
>  extern void mpc83xx_restart(char *cmd);
>  extern long mpc83xx_time_init(void);
> +#ifdef CONFIG_RTC_CLASS
> +extern int mpc83xx_set_rtc_time(struct rtc_time *tm);
> +extern void mpc83xx_get_rtc_time(struct rtc_time *tm);
> +#endif
>
>  #endif				/* __MPC83XX_H__ */
> diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
> index 02ed2c3..80076be 100644
> --- a/include/asm-ppc/mpc83xx.h
> +++ b/include/asm-ppc/mpc83xx.h
> @@ -25,6 +25,10 @@
>  #include <platforms/83xx/mpc834x_sys.h>
>  #endif
>
> +#ifdef CONFIG_MPC834x_ITX
> +#include <platforms/83xx/mpc834x_itx.h>
> +#endif
> +

This shouldn't be needed, its a hold over from arch/ppc

>  #define _IO_BASE        isa_io_base
>  #define _ISA_MEM_BASE   isa_mem_base
>  #ifdef CONFIG_PCI
> -- 
> 1.2.4
