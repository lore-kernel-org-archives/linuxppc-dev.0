In-Reply-To: <1087563278.19489.3156.camel@hades.cambridge.redhat.com>
References: <1087563278.19489.3156.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <205EB944-C12D-11D8-ACD7-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	Kumar Gala <kumar.gala@motorola.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: WindRiver PowerQUICC III SBC8560 support.
Date: Fri, 18 Jun 2004 08:40:56 -0500
To: David Woodhouse <dwmw2@infradead.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

A few comments (they are inline with the patch):
On Jun 18, 2004, at 7:54 AM, David Woodhouse wrote:

> Not a great deal of use yet till we have Ethernet support for either
> TSEC or FCC, or at least till I get u-boot to boot the poxy thing when
> it boots at 33MHz bus speed due to having a PCI Ethernet card
> present...
> but here's the core cpu/board support:
>
> diff -Nru a/arch/ppc/platforms/85xx/Kconfig
> b/arch/ppc/platforms/85xx/Kconfig
> --- a/arch/ppc/platforms/85xx/Kconfig	2004-06-18 13:49:42 +01:00
> +++ b/arch/ppc/platforms/85xx/Kconfig	2004-06-18 13:49:42 +01:00
> @@ -21,6 +21,12 @@
>  	help
>  	  This option enables support for the MPC 8540 ADS evaluation board.
>
> +config SBC8560
> +	bool "WindRiver PowerQUICC III SBC8560"
> +	help
> +	  This option enables support for the WindRiver PowerQUICC III
> +	  SBC8560 board.
> +
>  endchoice
>
>  # It's often necessary to know the specific 85xx processor type.
> @@ -31,6 +37,11 @@
>  	depends on MPC8540_ADS
>  	default y
>
> +config MPC8560
> +	bool
> +	depends on SBC8560
> +	default y
> +
>  config FSL_OCP
>  	bool
>  	depends on 85xx
> @@ -38,7 +49,7 @@
>
>  config PPC_GEN550
>  	bool
> -	depends on MPC8540
> +	depends on MPC8540 || SBC8560
>  	default y
>
>  endmenu
> diff -Nru a/arch/ppc/platforms/85xx/Makefile
> b/arch/ppc/platforms/85xx/Makefile
> --- a/arch/ppc/platforms/85xx/Makefile	2004-06-18 13:49:42 +01:00
> +++ b/arch/ppc/platforms/85xx/Makefile	2004-06-18 13:49:42 +01:00
> @@ -3,5 +3,7 @@
>  #
>
>  obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
> +obj-$(CONFIG_SBC8560)		+= sbc85xx.o sbc8560.o
>
>  obj-$(CONFIG_MPC8540)		+= mpc8540.o
> +obj-$(CONFIG_MPC8560)		+= mpc8560.o
> diff -Nru a/arch/ppc/platforms/85xx/mpc8560.c
> b/arch/ppc/platforms/85xx/mpc8560.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/arch/ppc/platforms/85xx/mpc8560.c	2004-06-18 13:49:42 +01:00
> @@ -0,0 +1,83 @@
> +/*
> + * arch/ppc/platforms/85xx/mpc8560.c
> + *
> + * MPC8560 I/O descriptions
> + *
> + * Maintainer: Kumar Gala <kumar.gala@freescale.com>
> + *
> + * Copyright 2004 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
> by the
> + * Free Software Foundation;  either version 2 of the  License, or
> (at your
> + * option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <asm/mpc85xx.h>
> +#include <asm/ocp.h>
> +
> +/* These should be defined in platform code */
> +extern struct ocp_gfar_data mpc85xx_tsec1_def;
> +extern struct ocp_gfar_data mpc85xx_tsec2_def;

Remove FEC, does not exist on 8560

> +extern struct ocp_gfar_data mpc85xx_fec_def;
> +extern struct ocp_mpc_i2c_data mpc85xx_i2c1_def;
> +
> +/* We use offsets for paddr since we do not know at compile time
> + * what CCSRBAR is, platform code should fix this up in
> + * setup_arch
> + *
> + * Only the first IRQ is given even if a device has
> + * multiple lines associated with ita
> + */
> +struct ocp_def core_ocp[] = {
> +        { .vendor       = OCP_VENDOR_FREESCALE,
> +          .function     = OCP_FUNC_IIC,
> +          .index        = 0,
> +          .paddr        = MPC85xx_IIC0_OFFSET,
> +          .irq          = MPC85xx_IRQ_IIC1,
> +          .pm           = OCP_CPM_NA,
> +          .additions    = &mpc85xx_i2c1_def,
> +        },
> +        { .vendor       = OCP_VENDOR_FREESCALE,
> +          .function     = OCP_FUNC_GFAR,
> +          .index        = 0,
> +          .paddr        = MPC85xx_ENET1_OFFSET,
> +          .irq          = MPC85xx_IRQ_TSEC1_TX,
> +          .pm           = OCP_CPM_NA,
> +          .additions    = &mpc85xx_tsec1_def,
> +        },
> +        { .vendor       = OCP_VENDOR_FREESCALE,
> +          .function     = OCP_FUNC_GFAR,
> +          .index        = 1,
> +          .paddr        = MPC85xx_ENET2_OFFSET,
> +          .irq          = MPC85xx_IRQ_TSEC2_TX,
> +          .pm           = OCP_CPM_NA,
> +          .additions    = &mpc85xx_tsec2_def,
> +        },

Remove ref for ENET3/FEC does not exist on 8560

> +        { .vendor       = OCP_VENDOR_FREESCALE,
> +          .function     = OCP_FUNC_GFAR,
> +          .index        = 2,
> +          .paddr        = MPC85xx_ENET3_OFFSET,
> +          .irq          = MPC85xx_IRQ_FEC,
> +          .pm           = OCP_CPM_NA,
> +          .additions    = &mpc85xx_fec_def,
> +        },
> +        { .vendor       = OCP_VENDOR_FREESCALE,
> +          .function     = OCP_FUNC_DMA,
> +          .index        = 0,
> +          .paddr        = MPC85xx_DMA_OFFSET,
> +          .irq          = MPC85xx_IRQ_DMA0,
> +          .pm           = OCP_CPM_NA,
> +        },
> +        { .vendor       = OCP_VENDOR_FREESCALE,
> +          .function     = OCP_FUNC_PERFMON,
> +          .index        = 0,
> +          .paddr        = MPC85xx_PERFMON_OFFSET,
> +          .irq          = MPC85xx_IRQ_PERFMON,
> +          .pm           = OCP_CPM_NA,
> +        },
> +        { .vendor       = OCP_VENDOR_INVALID
> +        }
> +};
> diff -Nru a/arch/ppc/platforms/85xx/sbc8560.c
> b/arch/ppc/platforms/85xx/sbc8560.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/arch/ppc/platforms/85xx/sbc8560.c	2004-06-18 13:49:42 +01:00
> @@ -0,0 +1,269 @@
> +/*
> + * arch/ppc/platforms/85xx/sbc8560.c
> + *
> + * Wind River SBC8560 board specific routines
> + *
> + * Maintainer: Kumar Gala <kumar.gala@freescale.com>
> + *
> + * Copyright 2004 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
> by the
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
> +#include <linux/irq.h>
> +#include <linux/seq_file.h>
> +#include <linux/root_dev.h>
> +#include <linux/serial.h>
> +#include <linux/tty.h>	/* for linux/serial_core.h */
> +#include <linux/serial_core.h>
> +#include <linux/module.h>
> +
> +#include <asm/system.h>
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/open_pic.h>
> +#include <asm/bootinfo.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc85xx.h>
> +#include <asm/irq.h>
> +#include <asm/immap_85xx.h>
> +#include <asm/kgdb.h>
> +#include <asm/ocp.h>
> +#include <mm/mmu_decl.h>
> +
> +#include <syslib/ppc85xx_common.h>
> +#include <syslib/ppc85xx_setup.h>
> +
> +struct ocp_gfar_data mpc85xx_tsec1_def = {
> +	.interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
> +	.interruptError = MPC85xx_IRQ_TSEC1_ERROR,
> +	.interruptReceive = MPC85xx_IRQ_TSEC1_RX,
> +	.interruptPHY = MPC85xx_IRQ_EXT6,
> +	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR |
> GFAR_HAS_PHY_INTR),
> +	.phyid = 25,
> +	.phyregidx = 0,
> +};
> +
> +struct ocp_gfar_data mpc85xx_tsec2_def = {
> +	.interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
> +	.interruptError = MPC85xx_IRQ_TSEC2_ERROR,
> +	.interruptReceive = MPC85xx_IRQ_TSEC2_RX,
> +	.interruptPHY = MPC85xx_IRQ_EXT7,
> +	.flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR |
> GFAR_HAS_PHY_INTR),
> +	.phyid = 26,
> +	.phyregidx = 0,
> +};
> +
> +struct ocp_gfar_data mpc85xx_fec_def = {
> +	.interruptTransmit = MPC85xx_IRQ_FEC,
> +	.interruptError = MPC85xx_IRQ_FEC,
> +	.interruptReceive = MPC85xx_IRQ_FEC,
> +	.interruptPHY = MPC85xx_IRQ_EXT5,
> +	.flags = 0,
> +	.phyid = 1,
> +	.phyregidx = 0,
> +};
> +
> +struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
> +	.flags = FS_I2C_SEPARATE_DFSRR,
> +};
> +
> +
> +#ifdef CONFIG_SERIAL_8250
> +static void __init
> +sbc8560_early_serial_map(void)
> +{
> +        struct uart_port uart_req;
> +
> +        /* Setup serial port access */
> +        memset(&uart_req, 0, sizeof (uart_req));
> +	uart_req.irq = MPC85xx_IRQ_EXT9;
> +	uart_req.flags = STD_COM_FLAGS;
> +	uart_req.uartclk = BASE_BAUD * 16;
> +        uart_req.iotype = SERIAL_IO_MEM;
> +        uart_req.mapbase = UARTA_ADDR;
> +        uart_req.membase = ioremap(uart_req.mapbase,
> MPC85xx_UART0_SIZE);
> +
> +#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
> +        gen550_init(0, &uart_req);
> +#endif
> +
> +        if (early_serial_setup(&uart_req) != 0)
> +                printk("Early serial init of port 0 failed\n");
> +
> +        /* Assume early_serial_setup() doesn't modify uart_req */
> +	uart_req.line = 1;
> +        uart_req.mapbase = UARTB_ADDR;
> +        uart_req.membase = ioremap(uart_req.mapbase,
> MPC85xx_UART1_SIZE);
> +	uart_req.irq = MPC85xx_IRQ_EXT10;
> +
> +#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
> +        gen550_init(1, &uart_req);
> +#endif
> +
> +        if (early_serial_setup(&uart_req) != 0)
> +                printk("Early serial init of port 1 failed\n");
> +}
> +#endif
> +
> +/*
> ***********************************************************************
> *
> + *
> + * Setup the architecture
> + *
> + */
> +static void __init
> +sbc8560_setup_arch(void)
> +{
> +	struct ocp_def *def;
> +	struct ocp_gfar_data *einfo;
> +	bd_t *binfo = (bd_t *) __res;
> +	unsigned int freq;
> +
> +	/* get the core frequency */
> +	freq = binfo->bi_intfreq;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("sbc8560_setup_arch()", 0);
> +
> +	/* Set loops_per_jiffy to a half-way reasonable value,
> +	   for use until calibrate_delay gets called. */
> +	loops_per_jiffy = freq / HZ;
> +
> +#ifdef CONFIG_PCI
> +	/* setup PCI host bridges */
> +	mpc85xx_setup_hose();
> +#endif
> +
> +#ifdef CONFIG_DUMMY_CONSOLE
> +	conswitchp = &dummy_con;
> +#endif
> +
> +#ifdef CONFIG_SERIAL_8250
> +	sbc8560_early_serial_map();
> +#endif
> +#ifdef CONFIG_SERIAL_TEXT_DEBUG
> +	/* Invalidate the entry we stole earlier the serial ports
> +	 * should be properly mapped */
> +	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
> +#endif
> +
> +	/* Set up MAC addresses for the Ethernet devices */
> +	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
> +	if (def) {
> +		einfo = (struct ocp_gfar_data *) def->additions;
> +		memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
> +	}
> +
> +	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
> +	if (def) {
> +		einfo = (struct ocp_gfar_data *) def->additions;
> +		memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
> +	}
> +
> +	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 2);
> +	if (def) {
> +		einfo = (struct ocp_gfar_data *) def->additions;
> +		memcpy(einfo->mac_addr, binfo->bi_enet2addr, 6);
> +	}
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
> +
> +	ocp_for_each_device(mpc85xx_update_paddr_ocp,
> &(binfo->bi_immr_base));
> +}
> +
> +/*
> ***********************************************************************
> * */
> +void __init
> +platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +	      unsigned long r6, unsigned long r7)
> +{
> +	/* parse_bootinfo must always be called first */
> +	parse_bootinfo(find_bootinfo());
> +
> +	/*
> +	 * If we were passed in a board information, copy it into the
> +	 * residual data area.
> +	 */
> +	if (r3) {
> +		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
> +		       sizeof (bd_t));
> +	}
> +
> +#ifdef CONFIG_SERIAL_TEXT_DEBUG
> +	/* Use the last TLB entry to map CCSRBAR to allow access to DUART
> regs */
> +	settlbcam(NUM_TLBCAMS - 1, UARTA_ADDR,
> +		  UARTA_ADDR, 0x1000, _PAGE_IO, 0);
> +#endif
> +
> +#if defined(CONFIG_BLK_DEV_INITRD)
> +	/*
> +	 * If the init RAM disk has been configured in, and there's a valid
> +	 * starting address for it, set it up.
> +	 */
> +	if (r4) {
> +		initrd_start = r4 + KERNELBASE;
> +		initrd_end = r5 + KERNELBASE;
> +	}
> +#endif				/* CONFIG_BLK_DEV_INITRD */
> +
> +	/* Copy the kernel command line arguments to a safe place. */
> +
> +	if (r6) {
> +		*(char *) (r7 + KERNELBASE) = 0;
> +		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
> +	}
> +
> +	/* setup the PowerPC module struct */
> +	ppc_md.setup_arch = sbc8560_setup_arch;
> +	ppc_md.show_cpuinfo = sbc8560_show_cpuinfo;
> +
> +	ppc_md.init_IRQ = sbc8560_init_IRQ;
> +	ppc_md.get_irq = openpic_get_irq;
> +
> +	ppc_md.restart = sbc8560_restart;
> +	ppc_md.power_off = sbc8560_power_off;
> +	ppc_md.halt = sbc8560_halt;
> +
> +	ppc_md.find_end_of_memory = sbc8560_find_end_of_memory;
> +
> +	ppc_md.time_init = NULL;
> +	ppc_md.set_rtc_time = NULL;
> +	ppc_md.get_rtc_time = NULL;
> +	ppc_md.calibrate_decr = mpc85xx_calibrate_decr;
> +
> +#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
> +	ppc_md.progress = gen550_progress;
> +#endif	/* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("sbc8560_init(): exit", 0);
> +
> +	return;
> +}
> diff -Nru a/arch/ppc/platforms/85xx/sbc8560.h
> b/arch/ppc/platforms/85xx/sbc8560.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/arch/ppc/platforms/85xx/sbc8560.h	2004-06-18 13:49:42 +01:00
> @@ -0,0 +1,48 @@
> +/*
> + * arch/ppc/platforms/85xx/sbc8560.h
> + *
> + * Wind River SBC8560 board definitions
> + *
> + * Copyright 2003 Motorola Inc.
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
> by the
> + * Free Software Foundation;  either version 2 of the  License, or
> (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifndef __MACH_SBC8560_H__
> +#define __MACH_SBC8560_H__
> +
> +#include <linux/config.h>
> +#include <linux/serial.h>
> +#include <platforms/85xx/sbc85xx.h>
> +
> +#ifdef CONFIG_SERIAL_MANY_PORTS
> +#define RS_TABLE_SIZE  64
> +#else
> +#define RS_TABLE_SIZE  2
> +#endif
> +
> +/* Rate for the 1.8432 Mhz clock for the onboard serial chip */
> +#define BASE_BAUD ( 1843200 / 16 )
> +
> +#ifdef CONFIG_SERIAL_DETECT_IRQ
> +#define STD_COM_FLAGS
> (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)
> +#else
> +#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST)
> +#endif
> +
> +#define STD_SERIAL_PORT_DFNS \
> +        { 0, BASE_BAUD, UARTA_ADDR, MPC85xx_IRQ_EXT9, STD_COM_FLAGS,
> /* ttyS0 */ \
> +                iomem_base: (u8 *)UARTA_ADDR,                       \
> +                io_type: SERIAL_IO_MEM },
>     \
> +        { 0, BASE_BAUD, UARTB_ADDR, MPC85xx_IRQ_EXT10, STD_COM_FLAGS,
> /* ttyS1 */ \
> +                iomem_base: (u8 *)UARTB_ADDR,                       \
> +                io_type: SERIAL_IO_MEM },
> +
> +#define SERIAL_PORT_DFNS \
> +        STD_SERIAL_PORT_DFNS
> +
> +#endif /* __MACH_SBC8560_H__ */
> diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.c
> b/arch/ppc/platforms/85xx/sbc85xx.c
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/arch/ppc/platforms/85xx/sbc85xx.c	2004-06-18 13:49:42 +01:00
> @@ -0,0 +1,337 @@
> +/*

Fix file name comments

> + * arch/ppc/platform/mpc85xx_common_ads.c
> + *
> + * MPC85XXADS board common routines
> + *
> + * Copyright 2002, 2003 Motorola Inc.
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
> by the
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
> +#include <linux/irq.h>
> +#include <linux/seq_file.h>
> +#include <linux/serial.h>
> +#include <linux/module.h>
> +
> +#include <asm/system.h>
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/open_pic.h>
> +#include <asm/bootinfo.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc85xx.h>
> +#include <asm/irq.h>
> +#include <asm/immap_85xx.h>
> +#include <asm/ocp.h>
> +
> +#include <mm/mmu_decl.h>
> +
> +#include <platforms/85xx/sbc85xx.h>
> +
> +unsigned char __res[sizeof (bd_t)];
> +
> +#ifdef CONFIG_PCI
> +void sbc8560_setup_hose(void);
> +#else
> +unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +unsigned long pci_dram_offset = 0;
> +#endif
> +

Do you use the pci_config_addr define?

> +#define pci_config_addr(bus,dev,offset) \
> +        (0x80000000 | (bus<<16) | (dev<<8) | (offset & 0xFC))
> +
> +extern unsigned long total_memory;	/* in mm/init */
> +
> +/* Internal interrupts are all Level Sensitive, and Positive Polarity
> */
> +
> +static u_char sbc8560_openpic_initsenses[] __initdata = {
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  1: ECM */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  8: PCI/PCI-X */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal  9: RIO Inbound Port Write
> Error */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 10: RIO Doorbell Inbound */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 11: RIO Outbound Message */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 12: RIO Inbound Message */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 0 Transmit */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 0 Receive */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 15: Unused */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 16: Unused */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 17: Unused */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 0 Receive/Transmit
> Error */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 1 Transmit */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 1 Receive */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 21: Unused */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 22: Unused */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 23: Unused */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 1 Receive/Transmit
> Error */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 25: Fast Ethernet */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 30: CPM */
> +	(IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
> +	0x0,				/* External  0: */
> +	0x0,				/* External  1: */
> +#if defined(CONFIG_PCI)
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 2: PCI slot 0
> */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 3: PCI slot 1
> */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 4: PCI slot 2
> */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PCI slot 3
> */
> +#else
> +	0x0,				/* External  2: */
> +	0x0,				/* External  3: */
> +	0x0,				/* External  4: */
> +	0x0,				/* External  5: */
> +#endif
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 6: PHY */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 7: PHY */
> +	0x0,				/* External  8: */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* External 9: PHY */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* External 10: PHY */
> +	0x0,				/* External 11: */
> +};
> +

Can you use mpc85xx_calibrate_decr instead of creating your own?

> +/*
> ***********************************************************************
> + *  The decrementer counts at the system (internal) clock frequency
> divided by 8
> + */
> +void __init
> +sbc8560_calibrate_decr(void)
> +{
> +	bd_t *binfo = (bd_t *) __res;
> +	unsigned int freq, divisor;
> +
> +	/* get the core frequency */
> +	freq = binfo->bi_busfreq;
> +	/* The timebase is updated every 8 bus clocks, HID0[SEL_TBCLK] = 0 */
> +	divisor = 8;
> +	printk("time_init: decrementer frequency = %u.%.6u MHz\n",
> +	       freq / divisor / 1000000, (freq / divisor) % 1000000);
> +	tb_ticks_per_jiffy = freq / divisor / HZ;
> +	tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
> +}
> +

Can you use the mpc85xx_find_end_of_memory

> +/*
> ***********************************************************************
>  */
> +unsigned long __init
> +sbc8560_find_end_of_memory(void)
> +{
> +	bd_t *binfo;
> +
> +	binfo = (bd_t *) __res;
> +
> +	return binfo->bi_memsize;
> +}
> +

I've moved to not using _map_io at all.  This has to due with eating up
large parts of virtual addr space, you may want to think about it.

> +/*
> ***********************************************************************
> * */
> +/* f400_0000-f7ff_ffff: RIO
> + * f800_0000-fbff_ffff: Localbus SDRAM
> + * fc00_0000-ffff_ffff: BCSR,RTC,CCSR,32M Flash,etc
> + */
> +void __init
> +sbc8560_map_io(void)
> +{
> +#ifdef CONFIG_SERIAL_TEXT_DEBUG
> +	/* Invalidate the entry we stole earlier and then use a proper
> +	 * mechanism to map things */
> +	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
> +#endif
> +	io_block_mapping(0xfc000000, 0xfc000000, 0x04000000, _PAGE_IO);
> +}
> +

Can you use mpc85xx_restart, mpc85xx_halt, mpc85xx_power_off?

> +/*
> ***********************************************************************
> *
> + * mpc85xx_ads doesn't have a mechanism to restart the system, It can
> + * however reset itself
> + */
> +void
> +sbc8560_restart(char *cmd)
> +{
> +	local_irq_disable();
> +	abort();
> +}
> +
> +/*
> ***********************************************************************
> *
> + * mpc85xx_ads has no support for this feature
> + */
> +void
> +sbc8560_power_off(void)
> +{
> +	local_irq_disable();
> +	for (;;) ;
> +}
> +
> +/*
> ***********************************************************************
> *
> + *  mpc85xx_ads has support for this feature, but it hasn't been
> implemented
> + */
> +void
> +sbc8560_halt(void)
> +{
> +	local_irq_disable();
> +	for (;;) ;
> +}
> +
> +/*
> ***********************************************************************
> * */
> +int
> +sbc8560_show_cpuinfo(struct seq_file *m)
> +{
> +	uint pvid, svid, phid1;
> +	uint memsize = total_memory;
> +	bd_t *binfo = (bd_t *) __res;
> +	unsigned int freq;
> +
> +	/* get the core frequency */
> +	freq = binfo->bi_intfreq;
> +
> +	pvid = mfspr(PVR);
> +	svid = mfspr(SVR);
> +
> +	seq_printf(m, "Vendor\t\t: Wind River\n");
> +
> +	switch (svid & 0xffff0000) {
> +	case SVR_8540:
> +		seq_printf(m, "Machine\t\t: hhmmm, this board isn't made yet!\n");
> +		break;
> +	case SVR_8560:
> +		seq_printf(m, "Machine\t\t: SBC8560\n");
> +		break;
> +	default:
> +		seq_printf(m, "Machine\t\t: unknown\n");
> +		break;
> +	}
> +	seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
> +		   freq % 1000000);
> +	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> +
> +	/* Display cpu Pll setting */
> +	phid1 = mfspr(HID1);
> +	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
> +
> +	/* Display the amount of memory */
> +	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
> +
> +	return 0;
> +}
> +
> +void __init
> +sbc8560_init_IRQ(void)
> +{
> +	bd_t *binfo = (bd_t *) __res;
> +	/* Determine the Physical Address of the OpenPIC regs */
> +	phys_addr_t OpenPIC_PAddr =
> +	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
> +	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
> +	OpenPIC_InitSenses = sbc8560_openpic_initsenses;
> +	OpenPIC_NumInitSenses = sizeof (sbc8560_openpic_initsenses);
> +
> +	/* Skip reserved space and internal sources */
> +	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
> +	/* Map PIC IRQs 0-11 */
> +	openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
> +
> +	/* we let openpic interrupts starting from an offset, to
> +	 * leave space for cascading interrupts underneath.
> +	 */
> +	openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
> +
> +	return;
> +}
> +
> +/*
> + * interrupt routing
> + */
> +
> +static inline int
> +sbc8560_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned
> char pin)
> +{
> +	static char pci_irq_table[][4] =
> +	    /*
> +	     *      PCI IDSEL/INTPIN->INTLINE
> +	     *        A      B      C      D
> +	     */
> +	{
> +		{PIRQA, PIRQB, PIRQC, PIRQD},
> +		{PIRQD, PIRQA, PIRQB, PIRQC},
> +		{PIRQC, PIRQD, PIRQA, PIRQB},
> +		{PIRQB, PIRQC, PIRQD, PIRQA},
> +	};
> +
> +	const long min_idsel = 12, max_idsel = 15, irqs_per_slot = 4;
> +	return PCI_IRQ_TABLE_LOOKUP;
> +}
> +
> +#ifdef CONFIG_PCI
> +int
> +mpc85xx_exclude_device(u_char bus, u_char devfn)
> +{
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}

Is map_irq correct for your board?

> +
> +int
> +mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned
> char pin)
> +{
> +	static char pci_irq_table[][4] =
> +	    /*
> +	     * This is little evil, but works around the fact
> +	     * that revA boards have IDSEL starting at 18
> +	     * and others boards (older) start at 12
> +	     *
> +	     *      PCI IDSEL/INTPIN->INTLINE
> +	     *       A      B      C      D
> +	     */
> +	{
> +		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 2 */
> +		{PIRQD, PIRQA, PIRQB, PIRQC},
> +		{PIRQC, PIRQD, PIRQA, PIRQB},
> +		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 5 */
> +		{0, 0, 0, 0},	/* -- */
> +		{0, 0, 0, 0},	/* -- */
> +		{0, 0, 0, 0},	/* -- */
> +		{0, 0, 0, 0},	/* -- */
> +		{0, 0, 0, 0},	/* -- */
> +		{0, 0, 0, 0},	/* -- */
> +		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 12 */
> +		{PIRQD, PIRQA, PIRQB, PIRQC},
> +		{PIRQC, PIRQD, PIRQA, PIRQB},
> +		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 15 */
> +		{0, 0, 0, 0},	/* -- */
> +		{0, 0, 0, 0},	/* -- */
> +		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 18 */
> +		{PIRQD, PIRQA, PIRQB, PIRQC},
> +		{PIRQC, PIRQD, PIRQA, PIRQB},
> +		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 21 */
> +	};
> +
> +	const long min_idsel = 2, max_idsel = 21, irqs_per_slot = 4;
> +	return PCI_IRQ_TABLE_LOOKUP;
> +}
> +
> +#endif
> diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.h
> b/arch/ppc/platforms/85xx/sbc85xx.h
> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/arch/ppc/platforms/85xx/sbc85xx.h	2004-06-18 13:49:42 +01:00
> @@ -0,0 +1,69 @@
> +/*

Fixup file comments

> + * arch/ppc/platforms/mpc85xx_ads_common.h
> + *
> + * MPC85XX ADS common board definitions
> + *
> + *
> + * Copyright 2003 Motorola Inc.
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
> by the
> + * Free Software Foundation;  either version 2 of the  License, or
> (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifndef __MACH_SBC85XX_H__
> +#define __MACH_SBC85XX_H__
> +
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/seq_file.h>
> +#include <asm/ppcboot.h>
> +
> +
> +
> +#define BOARD_CCSRBAR		((uint)0xff700000)
> +#define CCSRBAR_SIZE		((uint)1024*1024)

IMAP_ADDR?  should this be CPM_MAP_ADDR? or is this just old?

> +#define IMAP_ADDR 0xff700000
> +#define BCSR_ADDR		((uint)0xfc000000)
> +#define BCSR_SIZE		((uint)(16 * 1024 * 1024))
> +
> +#define UARTA_ADDR		(BCSR_ADDR + 0x00700000)
> +#define UARTB_ADDR		(BCSR_ADDR + 0x00800000)
> +#define RTC_DEVICE_ADDR		(BCSR_ADDR + 0x00900000)
> +#define EEPROM_ADDR		(BCSR_ADDR + 0x00b00000)
> +

Remove if you use mpc85xx_ versions

> +extern void sbc8560_setup_hose(void) __init;
> +extern void sbc8560_restart(char *cmd);
> +extern void sbc8560_power_off(void);
> +extern void sbc8560_halt(void);
> +extern int  sbc8560_show_cpuinfo(struct seq_file *m);
> +extern void sbc8560_init_IRQ(void) __init;
> +extern unsigned long sbc8560_find_end_of_memory(void) __init;
> +extern void sbc8560_map_io(void) __init;
> +extern void sbc8560_calibrate_decr(void) __init;
> +

PCI1... should be in syslib/ppc85xx_setup.h

> +#define PCI1_CFG_ADDR_OFFSET	(0x8000)
> +#define PCI1_CFG_DATA_OFFSET	(0x8004)
> +#define PCI1_CFG_ADDR            (CCSRBAR+0x8000)
> +#define PCI1_CFG_DATA            (CCSRBAR+0x8004)
> +
> +/* PCI interrupt controller */
> +#define PIRQA		MPC85xx_IRQ_EXT1
> +#define PIRQB		MPC85xx_IRQ_EXT2
> +#define PIRQC		MPC85xx_IRQ_EXT3
> +#define PIRQD		MPC85xx_IRQ_EXT4
> +
> +#define MPC85XX_PCI1_LOWER_IO	0x00000000
> +#define MPC85XX_PCI1_UPPER_IO	0x00ffffff
> +
> +#define MPC85XX_PCI1_LOWER_MEM	0x80000000
> +#define MPC85XX_PCI1_UPPER_MEM	0x9fffffff
> +
> +#define MPC85XX_PCI1_IO_BASE	0xe2000000
> +#define MPC85XX_PCI1_MEM_OFFSET	0x00000000
> +
> +#define MPC85XX_PCI1_IO_SIZE	0x01000000
> +
> +#endif /* __MACH_SBC85XX_H__ */
> diff -Nru a/arch/ppc/syslib/ppc85xx_setup.c
> b/arch/ppc/syslib/ppc85xx_setup.c
> --- a/arch/ppc/syslib/ppc85xx_setup.c	2004-06-18 13:49:42 +01:00
> +++ b/arch/ppc/syslib/ppc85xx_setup.c	2004-06-18 13:49:42 +01:00
> @@ -30,6 +30,8 @@
>  #include <asm/ocp.h>
>  #include <asm/kgdb.h>

Was this needed?

>
> +#include <syslib/ppc85xx_setup.h>
> +
>  /* Return the amount of memory */
>  unsigned long __init
>  mpc85xx_find_end_of_memory(void)
> diff -Nru a/arch/ppc/syslib/ppc85xx_setup.h
> b/arch/ppc/syslib/ppc85xx_setup.h
> --- a/arch/ppc/syslib/ppc85xx_setup.h	2004-06-18 13:49:42 +01:00
> +++ b/arch/ppc/syslib/ppc85xx_setup.h	2004-06-18 13:49:42 +01:00
> @@ -53,7 +53,9 @@
>  #define RS_TABLE_SIZE  2
>  #endif
>

Was this necessary?  I havent looked into it, but this seems to work ok
on ADS boards?

> -#define BASE_BAUD 0
> +#ifndef BASE_BAUD
> +#define BASE_BAUD 115200
> +#endif
>
>  #define STD_UART_OP(num)					\
>  	{ 0, BASE_BAUD, num, MPC85xx_IRQ_DUART,			\
> diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
> --- a/include/asm-ppc/mpc85xx.h	2004-06-18 13:49:42 +01:00
> +++ b/include/asm-ppc/mpc85xx.h	2004-06-18 13:49:42 +01:00
> @@ -25,6 +25,9 @@
>  #ifdef CONFIG_MPC8540_ADS
>  #include <platforms/85xx/mpc8540_ads.h>
>  #endif
> +#ifdef CONFIG_SBC8560
> +#include <platforms/85xx/sbc8560.h>
> +#endif
>
>  #define _IO_BASE        isa_io_base
>  #define _ISA_MEM_BASE   isa_mem_base
> @@ -97,6 +100,8 @@
>  #define MPC85xx_ENET3_SIZE	(0x01000)
>  #define MPC85xx_GUTS_OFFSET	(0xe0000)
>  #define MPC85xx_GUTS_SIZE	(0x01000)

No, we are moving the block # to be start on 1, fixup any code that
needs MPC85xx_IIC0_OFFSET to use MPC85xx_IIC1_OFFSET

> +#define MPC85xx_IIC0_OFFSET	(0x05000)
> +#define MPC85xx_IIC0_SIZE	(0x01000)
>  #define MPC85xx_IIC1_OFFSET	(0x03000)
>  #define MPC85xx_IIC1_SIZE	(0x01000)
>  #define MPC85xx_OPENPIC_OFFSET	(0x40000)

Make these changes and resend, I'll take a look and then push up to
akpm.

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
