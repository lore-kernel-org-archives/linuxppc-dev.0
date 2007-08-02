Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A5782DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 01:38:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add support for IDS8247 board
Date: Thu, 2 Aug 2007 17:38:28 +0200
References: <1186047403.11555.3.camel@p60635-ste.ids.de>
In-Reply-To: <1186047403.11555.3.camel@p60635-ste.ids.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708021738.28528.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 02 August 2007, Sergej Stepanov wrote:

> Add support for IDS8247 board from IDS GmbH, Germany

Hi Sergej,

Please split your patch into separate mails for the actual platform
support and for the device drivers.

One problem I see with the platform support is that the code is
not multiplatform capable, which is a problem you apparently copy 
over from mpc82xx_ads. Please make sure you don't hardcode any
assumptions in there which will cause problems in a combined kernel.
Details follow below.

> +       soc8247@f0000000 {
> +                 #address-cells = <1>;
> +                 #size-cells = <1>;
> +                 #interrupt-cells = <2>;
> +                 device_type = "soc";
> +		 reg = <f0000000 21000>;

You have some whitespace damage here, probably
also elsewhere. Please use tabs for indentation everywhere.

For the soc node, I'd expect to see a ranges property that
maps the local addresses into the global address space,
like

	ranges = <f0000000 0 10000000>;


> +                cpm2: cpm@f0000000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       device_type = "cpm";
> +                       model = "CPM2";
> +                       ranges = <00000000 00000000 20000>;

this doesn't have any children, so why do you have #address-cells,
#size-cells and ranges?

> +                       reg = <0 20000>;
> +                       command-proc = <119c0>;
> +                       brg-frequency = <5E69EC0>;
> +                       cpm_clk = <BCD3D80>;
> +                       compatible = "8272";
> +		};
> +                cpmpic: interrupt-controller@10c00 {
> +                         #address-cells = <0>;
> +			 #interrupt-cells = <2>;
> +                         interrupt-controller;
> +                         reg = <10c00 80>;
> +                         built-in;
> +                         device_type = "cpm-pic";
> +		         compatible = "CPM2";
> +                };

The reg property looks wrong here, unless you have a ranges
property like the one I mentioned above.

> +	};
> +
> +       	flash@ff800000 {
> +		       device_type = "rom";
> +		       compatible = "direct-mapped";
> +		       reg = <ff800000 800000>; /* Default (64MB) */
> +		       probe-type = "CFI";
> +		       bank-width = <1>;
> +		       partitions = <00000000 00200000 /* RO */
> +		       		    00200000 00700000 /* R0 */
> +		      		    00700000 00740000 /* RO */
> +		      		    00740000 00780000>; /* RO */
> +				    partition-names = "kernel", "cramfs", "u-boot", "env";
> +	};
> +       	flash@e1000000 {
> +		       device_type = "gen_nand";
> +		       compatible = "direct-mapped";
> +		       reg = <e1000000 1000>;
> +		       partitions = <00000000 01000000  /* RW */
> +		       		     01000000 01000000>;/* RO */
> +		       partition-names = "IDS8247-NANDBIN", "IDS8247-NANDDATA";
> +	};
> +        chosen {
> +               name = "chosen";
> +	       bootargs = "root=/dev/nfs rtc-pcf8563.probe=1,0x51 rw nfsroot=192.168.30.54:/home/opt/eldk-4.1/ppc_6xx ip=192.168.30.131:192.168.30.54:192.168.30.1:255.255.255.0:ids8247:eth0:off netconsole=@/,@192.168.30.54";
> +	       linux,platform = <0>;	 
> +	       linux,stdout-path = "/soc8247@f0000000/serial8250@e0008000";
> +	};

You probably shouldn't encode your home directory into the bootargs if you want
anyone else to be able to boot your kernel ;-)

> diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/ids8247.h linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/ids8247.h
> --- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/ids8247.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/ids8247.h	2007-08-02 10:15:22.000000000 +0200
> @@ -0,0 +1,52 @@
> +/*
> + * MPC8247 IDS8274 board platform setup
> + *
> + * Author: Sergej Stepanov <Sergej.Stepanov@ids.de>
> + *   Copyright (c) 2007, IDS GmbH, Germany 
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#ifdef __KERNEL__
> +#ifndef __IDS8247_PLATFORM
> +#define __IDS8247_PLATFORM
> +
> +
> +#include <linux/seq_file.h>
> +#include <asm/ppcboot.h>
> +#include <asm/irq.h>
> +
> +#define IO_PHYS_ADDR            ((uint)0xE0000000)
> +
> +#define CPM_MAP_ADDR		((uint)get_immrbase())
> +#define CPM_IRQ_OFFSET          0
> +
> +#define PHY_INTERRUPT		SIU_INT_IRQ2
> +
> +/* For our show_cpuinfo hooks. */
> +#define CPUINFO_VENDOR		"Freescale Semiconductor"
> +#define CPUINFO_MACHINE         "IDS8247 PowerPC Port by IDS GmbH"
> +
> +/* some info stuff */
> +#define BOOTROM_RESTART_ADDR	((uint)0xFFF00104)
> +
> +#define	I2C_ADDR_RTC		0x51
> +#define CFG_NAND_BASE		0xE1000000
> +#define IDS8247_UART_BASE       0xE0008000
> +#define RS_TABLE_SIZE           1
> +#define BASE_BAUD               115200
> +#define IDS8247UARTIRQ          SIU_INT_IRQ7
> +#define SERIAL_PORT_DFNS						\
> +  { 0, 14745600, 0, IDS8247UARTIRQ,					\
> +      ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST,				\
> +      iomem_base: (unsigned char *) 0xE0008000,				\
> +      io_type: SERIAL_IO_MEM},

All these definitions are put into the global name space, which you shouldn't
do for board specific stuff. First, remove all those that are not even used.
If you have any constants left, give them a IDS8247_ prefix and change the
users.

Addresses and interrupt numbers should be read from the device tree, not
hardcoded in the source.

> +void m82xx_calibrate_decr(void);

This should be in a generic header file

> +void mpc82xx_ads_show_cpuinfo(struct seq_file*);

and this one looks wrong as well. you probably should move that
function to a shared file and declare it in a generic header.

> +#endif	/* __IDS8274_PLATFORM */
> +#endif  /* __KERNEL__ */
> diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/Kconfig linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/Kconfig
> --- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/Kconfig	2007-07-10 20:56:30.000000000 +0200
> +++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/Kconfig	2007-08-02 10:15:22.000000000 +0200
> @@ -13,6 +13,19 @@
>  	help
>  	This option enables support for the MPC8272 ADS board
>  
> +config MPC82xx_IDS8247
> +	bool "IDS8247 based on MPC8247"
> +	select DEFAULT_UIMAGE
> +	select 8272
> +	select 8260
> +	select FSL_SOC
> +	select PPC_NATIVE
> +	select PPC_UDBG_16550 if SERIAL_8250
> +	select WANT_DEVICE_TREE
> +	select MTD_NAND
> +	help
> +	This option enables support for the IDS8247 board
> +
>  endchoice

Why select 8272 and 8260 here? they are obviously not the CPUs you are using.

MTD_NAND should also not be autoselected, afaics.
  
> +
> +#include <sysdev/fsl_soc.h>
> +#include <../sysdev/cpm2_pic.h>

the '..' in there is not needed.

> +#include "ids8247.h"
> +
> +/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
> +   Can only choose from CLK9-10 */
> +#define F1_RXCLK      10
> +#define F1_TXCLK      9

if they are board specific, they should probably be in the device tree.

> +/*
> +  Callback function from fs_enet driver.
> +*/
> +void init_fcc_ioports(struct fs_platform_info *fpi)
> +{
> +	int fcc_no = fs_get_fcc_index(fpi->fs_no);
> +	struct io_port *io;

should probably be __iomem.

> +/*
> +  General board setup
> +*/
> +int __init m82xx_board_setup( void)
> +{
> +	struct device_node *np;
> +	struct io_port *io;
> +	io = &((cpm2_map_t *) cpm2_immr)->im_ioport;

same here

> +	np = of_find_node_by_type(NULL, "memory");
> +	if (!np) {
> +		printk(KERN_INFO "No memory node in device tree\n");
> +		return 1;
> +	}
> +	of_node_put(np);

without a memory node, you probably don't even get here ;-)

> +
> +static int __init mpc8247_ids_probe(void)
> +{
> +	return 1;
> +}

needs to check the "compatible" property in the root device,
otherwise you misdetect the board in a multiplatform kernel.

> +/*  Copied from mpc82xx_ads.c */
> +#define RMR_CSRE 0x00000001
> +static void m82xx_restart(char *cmd)
> +{
> +	__volatile__ unsigned char dummy;
> +
> +	local_irq_disable();
> +	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
> +
> +	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
> +	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
> +	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
> +	printk("Restart failed\n");
> +	while (1) ;
> +}

please make this is global function that is shared between all platforms
that want it. It's broken in multiple ways, but we should better have to
fix it only once.

> +/*  Copied from mpc82xx_ads.c */
> +static void m82xx_halt(void)
> +{
> +	local_irq_disable();
> +	while (1) ;
> +}

better put a cpu_relax() or similar in the loop.

> +#ifdef 	CONFIG_MTD_PHYSMAP
> +/*
> +  TODO: the table has to be build in physmap_of
> +*/
> +static struct mtd_partition ids8247_cramfs_partitions[] = {
> +	{
> + 		.name = "kernel",
> +		.size = 0x200000,
> +		.offset = 0,
> +		.mask_flags = 0,
> +	},
> +	{
> +		.name = "cramfs",
> +		.offset = 0x200000,
> +		.size = 0x500000,
> +		.mask_flags = 0,
> +	},
> +	{
> +		.name = "u-boot",
> +		.offset = 0x700000,
> +		.size = 0x40000,
> +		.mask_flags = 0,
> +	},
> +	{
> +		.name = "env",
> +		.offset = 0x740000,
> +		.size = 0x40000,
> +		.mask_flags = 0,
> +	}
> +};

don't you have the same information in the device tree already?
Better read it from there so you only have to change it in one
place if the layout changes.

That will also help to consolidate the code with the other platforms
that have a physmap in the device tree.

> +static void mpc82xx_ids8247_nandhwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	if( ctrl & NAND_CTRL_CHANGE) {
> +		ctrl &= ~NAND_CTRL_CHANGE;
> +		switch( ctrl )
> +		{
> +		case NAND_CTRL_CLE:
> +			*(((volatile __u8 *) chip->IO_ADDR_W) + 0xa) = 0; 
> +			break;
> +		case NAND_CTRL_ALE:
> +			*(((volatile __u8 *) chip->IO_ADDR_W) + 0x9) = 0; 
> +			break;
> +		case NAND_NCE:
> +  			*(((volatile __u8 *) chip->IO_ADDR_W) + 0x8) = 0; 
> +			break;
> +		default:
> +  			*(((volatile __u8 *) chip->IO_ADDR_W) + 0xc) = 0;
> +		}
> +	}

Use out_8 here, instead of writing to a volatile pointer.

> +	if (cmd != NAND_CMD_NONE)
> +		out_8(chip->IO_ADDR_W, (char)cmd);
> +}
> +error:
> +	of_node_put(np);
> +        kfree(pdata);
> +        platform_device_unregister(nanddevice);
> +	return ret;
> +
> +}

whitespace damaged.


> +static int __init mpc82xx_ids8247_i2c_setup(void)
> +{
> +	int ret = 0;
> +	struct platform_device *i2c_dev;
> +	struct fsl_i2c_platform_data i2c_data;
> +
> +	i2c_data.device_flags = 0;
> +	i2c_dev = platform_device_register_simple("bb-i2c", 0, NULL, 0);
> +	if (IS_ERR(i2c_dev)) {
> +		ret = PTR_ERR(i2c_dev);
> +		return ret;
> +	}
> +	ret = platform_device_add_data(i2c_dev, 
> +				       &i2c_data,
> +				       sizeof(struct fsl_i2c_platform_data));
> +	if(ret)
> +	{
> +		platform_device_unregister(i2c_dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(mpc82xx_ids8247_i2c_setup);

Why not make this an of_platform_driver? That would avoid having
to split the driver to two files, and be cleaner in general.

> diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/mpc82xx.c linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/mpc82xx.c
> --- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/mpc82xx.c	2007-07-10 20:56:30.000000000 +0200
> +++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/mpc82xx.c	2007-08-02 10:15:22.000000000 +0200
> @@ -50,7 +50,13 @@
>  #include <sysdev/fsl_soc.h>
>  #include <sysdev/cpm2_pic.h>
>  
> +#ifdef CONFIG_MPC82xx_ADS
>  #include "pq2ads.h"
> +#endif
> +
> +#ifdef CONFIG_MPC82xx_IDS8247
> +#include "ids8247.h"
> +#endif
>  

This doesn't fly. You have to define the headers in a way that you can
include them concurrently in order to allow multiplatform builds.

> diff -ruN linux-2.6.22.1_orig/drivers/net/fs_enet/mii-bitbang.c linux-2.6.22.1_ids8247/drivers/net/fs_enet/mii-bitbang.c
> --- linux-2.6.22.1_orig/drivers/net/fs_enet/mii-bitbang.c	2007-07-10 20:56:30.000000000 +0200
> +++ linux-2.6.22.1_ids8247/drivers/net/fs_enet/mii-bitbang.c	2007-08-02 10:15:22.000000000 +0200
> @@ -336,7 +336,11 @@
>  	new_bus->reset = &fs_enet_mii_bb_reset,
>  	new_bus->id = pdev->id;
>  
> +#ifndef CONFIG_MPC82xx_IDS8247
>  	new_bus->phy_mask = ~0x9;
> +#else
> +	new_bus->phy_mask = ~0x2;
> +#endif
>  	pdata = (struct fs_mii_bb_platform_info *)pdev->dev.platform_data;
>  
>  	if (NULL == pdata) {

Same here, this should be read from the device tree so you don't need
to hardcode it based on CONFIG symbols.

> diff -ruN linux-2.6.22.1_orig/include/asm-powerpc/mpc8260.h linux-2.6.22.1_ids8247/include/asm-powerpc/mpc8260.h
> --- linux-2.6.22.1_orig/include/asm-powerpc/mpc8260.h	2007-07-10 20:56:30.000000000 +0200
> +++ linux-2.6.22.1_ids8247/include/asm-powerpc/mpc8260.h	2007-08-02 10:15:22.000000000 +0200
> @@ -19,6 +19,10 @@
>  #include <platforms/82xx/m82xx_pci.h>
>  #endif
>  
> +#ifdef CONFIG_MPC82xx_IDS8247
> +#include <platforms/82xx/ids8247.h>
> +#endif
> +
>  #endif /* CONFIG_8260 */
>  #endif /* !__ASM_POWERPC_MPC8260_H__ */
>  #endif /* __KERNEL__ */

And finally, same problem here.

	Arnd <><
