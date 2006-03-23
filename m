Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF74A67B65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 08:48:47 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0603231523410.17021@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0603231523410.17021@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2B791984-6593-4E89-B774-756B4BA3B3AC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for 85xx CDS systems in arch/powerpc
Date: Thu, 23 Mar 2006 15:49:40 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 23, 2006, at 3:26 PM, Andy Fleming wrote:

> * This patch adds code to work on 85xx CDS using the flat device  
> tree in
>   arch/powerpc
>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
>
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/ 
> platforms/85xx/Kconfig
> index d3d0ff7..6796164 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -10,13 +10,19 @@ config MPC8540_ADS
>  	help
>  	  This option enables support for the MPC 8540 ADS board
>
> +config MPC85xx_CDS
> +	bool "Freescale MPC85xx CDS"
> +	select PPC_I8259
> +	help
> +	  This option enables support for the MPC85xx CDS board
> +
>  endchoice
>
>  config MPC8540
>  	bool
>  	select PPC_UDBG_16550
>  	select PPC_INDIRECT_PCI
> -	default y if MPC8540_ADS
> +	default y if MPC8540_ADS || MPC85xx_CDS
>
>  config PPC_INDIRECT_PCI_BE
>  	bool
> @@ -27,4 +33,9 @@ config MPIC
>  	bool
>  	default y
>
> +config 85xx_PCI2
> +	bool "Support for 2nd PCI"
> +	depends on MPC85xx_CDS
> +	default y
> +

Remove this.  You shouldn't need a kernel config option for PCI2,  
look at what 83xx does for 2nd PCI controller.

>  endmenu
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/ 
> powerpc/platforms/85xx/mpc85xx_cds.c
> new file mode 100644
> index 0000000..b625e8c
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -0,0 +1,375 @@
> +/*
> + * MPC85xx setup and early boot code plus other random bits.
> + *
> + * Maintained by Kumar Gala (see MAINTAINERS for contact information)
> + *
> + * Copyright 2005 Freescale Semiconductor Inc.
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
> +#include <linux/initrd.h>
> +#include <linux/module.h>
> +#include <linux/fsl_devices.h>
> +
> +#include <asm/system.h>
> +#include <asm/pgtable.h>
> +#include <asm/page.h>
> +#include <asm/atomic.h>
> +#include <asm/time.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/bootinfo.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/mpc85xx.h>
> +#include <asm/irq.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +#include <asm/i8259.h>
> +
> +#include <sysdev/fsl_soc.h>
> +#include "mpc85xx.h"
> +
> +#ifndef CONFIG_PCI
> +unsigned long isa_io_base = 0;
> +unsigned long isa_mem_base = 0;
> +#endif
> +
> +static int cds_pci_slot = 2;
> +static volatile u8 *cadmus;
> +
> +/*
> + * Internal interrupts are all Level Sensitive, and Positive Polarity
> + *
> + * Note:  Likely, this table and the following function should be
> + *        obtained and derived from the OF Device Tree.
> + */
> +static u_char mpc85xx_cds_openpic_initsenses[] __initdata = {
> +	MPC85XX_INTERNAL_IRQ_SENSES,
> +#if defined(CONFIG_PCI)
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Ext 0: PCI slot 0 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 1 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 2 */
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 3 */
> +#else
> +	0x0,				/* External  0: */
> +	0x0,				/* External  1: */
> +	0x0,				/* External  2: */
> +	0x0,				/* External  3: */
> +#endif
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
> +	0x0,				/* External  6: */
> +	0x0,				/* External  7: */
> +	0x0,				/* External  8: */
> +	0x0,				/* External  9: */
> +	0x0,				/* External 10: */
> +#if defined(CONFIG_85xx_PCI2) && defined(CONFIG_PCI)
> +	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),    /* Ext 11: PCI2  
> slot 0 */
> +#else
> +	0x0,				/* External 11: */
> +#endif
> +};
> +
> +
> +#ifdef CONFIG_PCI
> +/*
> + * interrupt routing
> + */
> +int
> +mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned  
> char pin)
> +{
> +	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
> +
> +	if (!hose->index)
> +	{
> +		/* Handle PCI1 interrupts */
> +		char pci_irq_table[][4] =
> +			/*
> +			 *      PCI IDSEL/INTPIN->INTLINE
> +			 *        A      B      C      D
> +			 */
> +
> +			/* Note IRQ assignment for slots is based on which slot the  
> elysium is
> +			 * in -- in this setup elysium is in slot #2 (this PIRQA as first
> +			 * interrupt on slot */
> +		{
> +			{ 0, 1, 2, 3 }, /* 16 - PMC */
> +			{ 0, 1, 2, 3 }, /* 17 P2P (Tsi320) */
> +			{ 0, 1, 2, 3 }, /* 18 - Slot 1 */
> +			{ 1, 2, 3, 0 }, /* 19 - Slot 2 */
> +			{ 2, 3, 0, 1 }, /* 20 - Slot 3 */
> +			{ 3, 0, 1, 2 }, /* 21 - Slot 4 */
> +		};
> +
> +		const long min_idsel = 16, max_idsel = 21, irqs_per_slot = 4;
> +		int i, j;
> +
> +		for (i = 0; i < 6; i++)
> +			for (j = 0; j < 4; j++)
> +				pci_irq_table[i][j] =
> +					((pci_irq_table[i][j] + 5 -
> +					  cds_pci_slot) & 0x3) + PIRQ0A;
> +
> +		return PCI_IRQ_TABLE_LOOKUP;
> +	} else {
> +		/* Handle PCI2 interrupts (if we have one) */
> +		char pci_irq_table[][4] =
> +		{
> +			/*
> +			 * We only have one slot and one interrupt
> +			 * going to PIRQA - PIRQD */
> +			{ PIRQ1A, PIRQ1A, PIRQ1A, PIRQ1A }, /* 21 - slot 0 */
> +		};
> +
> +		const long min_idsel = 21, max_idsel = 21, irqs_per_slot = 4;
> +
> +		return PCI_IRQ_TABLE_LOOKUP;
> +	}
> +}
> +
> +#define ARCADIA_HOST_BRIDGE_IDSEL	17
> +#define ARCADIA_2ND_BRIDGE_IDSEL	3
> +
> +extern int mpc85xx_pci2_busno;
> +
> +int
> +mpc85xx_exclude_device(u_char bus, u_char devfn)
> +{
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +#ifdef CONFIG_85xx_PCI2
> +	if (mpc85xx_pci2_busno)
> +		if (bus == (mpc85xx_pci2_busno) && PCI_SLOT(devfn) == 0)
> +			return PCIBIOS_DEVICE_NOT_FOUND;
> +#endif
> +	/* We explicitly do not go past the Tundra 320 Bridge */
> +	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}
> +
> +void __init
> +mpc85xx_cds_pcibios_fixup(void)
> +{
> +        struct pci_dev *dev;
> +	u_char		c;
> +
> +	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
> +                                         
> PCI_DEVICE_ID_VIA_82C586_1, NULL))) {
> +                /*
> +                 * U-Boot does not set the enable bits
> +                 * for the IDE device. Force them on here.
> +                 */
> +                pci_read_config_byte(dev, 0x40, &c);
> +                c |= 0x03; /* IDE: Chip Enable Bits */
> +                pci_write_config_byte(dev, 0x40, c);
> +
> +		/*
> +		 * Since only primary interface works, force the
> +		 * IDE function to standard primary IDE interrupt
> +		 * w/ 8259 offset
> +		 */
> +                dev->irq = 14;
> +                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev- 
> >irq);
> +		pci_dev_put(dev);
> +        }
> +
> +	/*
> +	 * Force legacy USB interrupt routing
> +	 */
> +	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
> +                                         
> PCI_DEVICE_ID_VIA_82C586_2, NULL))) {
> +                dev->irq = 10;
> +                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 10);
> +		pci_dev_put(dev);
> +        }
> +
> +	if ((dev = pci_get_device(PCI_VENDOR_ID_VIA,
> +                                         
> PCI_DEVICE_ID_VIA_82C586_2, dev))) {
> +                dev->irq = 11;
> +                pci_write_config_byte(dev, PCI_INTERRUPT_LINE, 11);
> +		pci_dev_put(dev);
> +        }
> +}
> +#endif /* CONFIG_PCI */

Don't we do the fixup in u-boot now?

> +
> +void __init mpc85xx_cds_pic_init(void)
> +{
> +	struct mpic *mpic1;
> +	phys_addr_t OpenPIC_PAddr;
> +
> +	/* Determine the Physical Address of the OpenPIC regs */
> +	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
> +
> +	mpic1 = mpic_alloc(OpenPIC_PAddr,
> +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> +			4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
> +			mpc85xx_cds_openpic_initsenses,
> +			sizeof(mpc85xx_cds_openpic_initsenses), " OpenPIC  ");
> +	BUG_ON(mpic1 == NULL);
> +	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
> +	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
> +	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10300);
> +	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10380);
> +	mpic_assign_isu(mpic1, 4, OpenPIC_PAddr + 0x10400);
> +	mpic_assign_isu(mpic1, 5, OpenPIC_PAddr + 0x10480);
> +	mpic_assign_isu(mpic1, 6, OpenPIC_PAddr + 0x10500);
> +	mpic_assign_isu(mpic1, 7, OpenPIC_PAddr + 0x10580);
> +
> +	/* dummy mappings to get to 48 */
> +	mpic_assign_isu(mpic1, 8, OpenPIC_PAddr + 0x10600);
> +	mpic_assign_isu(mpic1, 9, OpenPIC_PAddr + 0x10680);
> +	mpic_assign_isu(mpic1, 10, OpenPIC_PAddr + 0x10700);
> +	mpic_assign_isu(mpic1, 11, OpenPIC_PAddr + 0x10780);
> +
> +	/* External ints */
> +	mpic_assign_isu(mpic1, 12, OpenPIC_PAddr + 0x10000);
> +	mpic_assign_isu(mpic1, 13, OpenPIC_PAddr + 0x10080);
> +	mpic_assign_isu(mpic1, 14, OpenPIC_PAddr + 0x10100);
> +
> +	mpic_init(mpic1);
> +
> +#ifdef CONFIG_PCI
> +	mpic_setup_cascade(PIRQ0A, i8259_irq_cascade, NULL);
> +
> +	i8259_init(0,0);
> +#endif
> +}
> +
> +
> +/*
> + * Setup the architecture
> + */
> +static void __init
> +mpc85xx_cds_setup_arch(void)
> +{
> +	struct device_node *cpu;
> +#ifdef CONFIG_PCI
> +	struct device_node *np;
> +#endif
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc85xx_cds_setup_arch()", 0);
> +
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	if (cpu != 0) {
> +		unsigned int *fp;
> +
> +		fp = (int *)get_property(cpu, "clock-frequency", NULL);
> +		if (fp != 0)
> +			loops_per_jiffy = *fp / HZ;
> +		else
> +			loops_per_jiffy = 50000000 / HZ;
> +		of_node_put(cpu);
> +	}
> +
> +	cadmus = ioremap(CADMUS_BASE, CADMUS_SIZE);
> +	cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
> +
> +	if (ppc_md.progress) {
> +		char buf[40];
> +		snprintf(buf, 40, "CDS Version = 0x%x in slot %d\n",
> +				cadmus[CM_VER], cds_pci_slot);
> +		ppc_md.progress(buf, 0);
> +	}
> +
> +#ifdef CONFIG_PCI
> +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> +		add_bridge(np);
> +
> +        ppc_md.pcibios_fixup = mpc85xx_cds_pcibios_fixup;

I feel like there is a white space issue

> +	ppc_md.pci_swizzle = common_swizzle;
> +	ppc_md.pci_map_irq = mpc85xx_map_irq;
> +	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
> +#endif
> +
> +#ifdef  CONFIG_ROOT_NFS
> +	ROOT_DEV = Root_NFS;
> +#else
> +	ROOT_DEV = Root_HDA1;
> +#endif
> +}
> +
> +
> +void
> +mpc85xx_cds_show_cpuinfo(struct seq_file *m)
> +{
> +	uint pvid, svid, phid1;
> +	struct device_node *cpu;
> +	unsigned int *freq = NULL;
> +	uint memsize = total_memory;
> +	struct device_node *root = find_path_device("/");
> +	char *machine = get_property(root, "model", NULL);
> +
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	if (cpu != 0) {
> +		freq = (int *)get_property(cpu, "clock-frequency", NULL);
> +		of_node_put(cpu);
> +	}
> +
> +	pvid = mfspr(SPRN_PVR);
> +	svid = mfspr(SPRN_SVR);
> +
> +	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
> +	seq_printf(m, "Machine\t\t: %s (%x)\n",
> +			machine, cadmus[CM_VER]);
> +	seq_printf(m, "clock\t\t: %dMHz\n", (freq ? *freq:5000000) /  
> 1000000);
> +	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> +	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
> +
> +	/* Display cpu Pll setting */
> +	phid1 = mfspr(SPRN_HID1);
> +	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
> +
> +	/* Display the amount of memory */
> +	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
> +}

What does cat /proc/cpuinfo show now?

> +
> +
> +void __init
> +platform_init(void)
> +{
> +	ppc_md.setup_arch = mpc85xx_cds_setup_arch;
> +	ppc_md.show_cpuinfo = mpc85xx_cds_show_cpuinfo;
> +
> +	ppc_md.init_IRQ = mpc85xx_cds_pic_init;
> +	ppc_md.get_irq = mpic_get_irq;
> +
> +	ppc_md.restart = mpc85xx_restart;
> +	ppc_md.power_off = NULL;
> +	ppc_md.halt = NULL;
> +
> +	ppc_md.time_init = NULL;
> +	ppc_md.set_rtc_time = NULL;
> +	ppc_md.get_rtc_time = NULL;
> +	ppc_md.calibrate_decr = generic_calibrate_decr;
> +
> +	ppc_md.progress = udbg_progress;
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("mpc85xx_cds platform_init(): exit", 0);
> +}
> +
> +
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.h b/arch/ 
> powerpc/platforms/85xx/mpc85xx_cds.h
> new file mode 100644
> index 0000000..68d8913
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.h
> @@ -0,0 +1,43 @@
> +/*
> + * arch/ppc/platforms/85xx/mpc85xx_cds_common.h
> + *
> + * MPC85xx CDS board definitions
> + *
> + * Maintainer: Kumar Gala <galak@kernel.crashing.org>
> + *
> + * Copyright 2004 Freescale Semiconductor, Inc
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
> +#ifndef __MACH_MPC85XX_CDS_H__
> +#define __MACH_MPC85XX_CDS_H__
> +
> +/* CADMUS info */
> +#define CADMUS_BASE (0xf8004000)
> +#define CADMUS_SIZE (256)
> +#define CM_VER	(0)
> +#define CM_CSR	(1)
> +#define CM_RST	(2)
> +
> +/* CDS NVRAM/RTC */
> +#define CDS_RTC_ADDR	(0xf8000000)
> +#define CDS_RTC_SIZE	(8 * 1024)
> +
> +/* PCI interrupt controller */
> +#define PIRQ0A			MPC85xx_IRQ_EXT0
> +#define PIRQ0B			MPC85xx_IRQ_EXT1
> +#define PIRQ0C			MPC85xx_IRQ_EXT2
> +#define PIRQ0D			MPC85xx_IRQ_EXT3
> +#define PIRQ1A			MPC85xx_IRQ_EXT11
> +
> +#define NR_8259_INTS		80	

Uugh, why is NR_8259_INTS set to 80?

> +#define CPM_IRQ_OFFSET		NR_8259_INTS
> +
> +#define MPC85xx_OPENPIC_IRQ_OFFSET	NR_8259_INTS
> +
> +#endif /* __MACH_MPC85XX_CDS_H__ */
> diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
> index c8a96aa..93c889a 100644
> --- a/include/asm-ppc/mpc85xx.h
> +++ b/include/asm-ppc/mpc85xx.h
> @@ -28,6 +28,9 @@
>  #if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
>  #include <platforms/85xx/mpc8555_cds.h>
>  #endif
> +#ifdef CONFIG_MPC85xx_CDS
> +#include <platforms/85xx/mpc85xx_cds.h>
> +#endif
>  #ifdef CONFIG_MPC8560_ADS
>  #include <platforms/85xx/mpc8560_ads.h>
>  #endif
