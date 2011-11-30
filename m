Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C2F0B6F68
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 17:20:34 +1100 (EST)
Message-ID: <1322634022.21641.61.camel@pasglop>
Subject: Re: [PATCH 6/6] 44x/currituck: Add support for the new IBM
 currituck platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 30 Nov 2011 17:20:22 +1100
In-Reply-To: <1322630640-13708-7-git-send-email-tony@bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-7-git-send-email-tony@bakeyournoodle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-11-30 at 16:24 +1100, Tony Breeds wrote:

> +		cpu@1 {
> +			device_type = "cpu";
> +			model = "PowerPC,476";
> +			reg = <1>;
> +			clock-frequency = <1600000000>; // 1.6 GHz
> +			timebase-frequency = <100000000>; // 100Mhz
> +			i-cache-line-size = <32>;
> +			d-cache-line-size = <32>;
> +			i-cache-size = <32768>;
> +			d-cache-size = <32768>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +			status = "disabled";

disabled ? really ?

> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x01f00000>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x0>; // filled in by zImage
> +	};
> +
> +	MPIC: interrupt-controller {
> +		compatible = "chrp,open-pic";
> +		interrupt-controller;
> +		dcr-reg = <0xffc00000 0x00040000>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +
> +	};
> +
> +	plb {
> +		compatible = "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't matter */

Then make it plb6 and add it to the probe list. Might have to whack it's
configuration registers one day etc...

> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		clock-frequency = <200000000>; // 200Mhz
> +
> +		POB0: opb {
> +			compatible = "ibm,opb-4xx", "ibm,opb";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			/* Wish there was a nicer way of specifying a full
> +			 * 32-bit range
> +			 *
> +			 * XXX: 1 TB address space, do we really care past
> +			 * 4 GB and should we expand cell width?
> +			 */

For OPB probably not :-)

  .../...

> +#define DBG(fmt...)
> +
> +BSS_STACK(4096);
> +
> +#define MAX_RANKS	0x4
> +#define DDR3_MR0CF	0x80010011U
> +
> +static unsigned long long ibm_currituck_memsize;
> +static void ibm_currituck_detect_memsize(void)
> +{
> +	u32 reg;
> +	unsigned i;
> +
> +	ibm_currituck_memsize = 0;
> +	DBG("%s: initial memsize=0x%016llx\r\n", __func__,
> +	    ibm_currituck_memsize);

That doesn't seem like a very useful pair of statements or useful debug
message....

Any reason why you aren't returning what you detect rather than using a
global ?

> +	for(i = 0; i < MAX_RANKS; i++){
> +		reg = mfdcrx(DDR3_MR0CF + i);
> +		printf("%s: reg=0x%08x\r\n", __func__, reg);

All that debug is pretty gross, keep it if you wish but make it a bit
neater and/or wrap it in DBG

> +		if (reg & 0x01) {

	if (!(reg & 1))
		continue;

avoids too much indent

> +			reg &= 0x0000f000;
> +			reg >>= 12;
> +			DBG("%s: reg=0x%08x, mem=0x%016llx\r\n",
> +			    __func__, reg, (0x800000ULL << reg));

Similar comment about making the debug output neater

> +			ibm_currituck_memsize += (0x800000ULL << reg);
> +			DBG("%s: memsize=0x%016llx\r\n", __func__, ibm_currituck_memsize);
> +		}
> +	}
> +
> +	DBG("\r\n\r\n");
> +}
> +
> +static void ibm_currituck_fixups(void)
> +{
> +	int i;
> +	void *devp = finddevice("/");
> +	u32 dma_ranges[7];
> +
> +	dt_fixup_memory(0x0ULL,  ibm_currituck_memsize);

Ok, I see why the global... I'd still prefer if the detect function just
returned the value and the caller whacks the global.

> +	while ((devp = find_node_by_devtype(devp, "pci"))) {
> +		if (getprop(devp, "dma-ranges", &dma_ranges[0], sizeof(dma_ranges)) < 0) {

Can't you replace &dma_ranges[0] with just dma_ranges ?

> +			printf("%s: Failed to get dma-ranges\r\n", __func__);
> +			continue;
> +		}
> +
> +		dma_ranges[5] = ibm_currituck_memsize >> 32;
> +		dma_ranges[6] = ibm_currituck_memsize & 0xffffffffUL;
> +
> +		setprop(devp, "dma-ranges", &dma_ranges[0], sizeof(dma_ranges));

Ditto.

> +		DBG("%s: Setting DMA-ranges to <0x%x", __func__, dma_ranges[0]);
> +		for (i = 1; i < 7; i++)
> +			DBG(" 0x%x", dma_ranges[i]);
> +		DBG(">\n\r");

Do you really need that added debug ? Once you've displayed the memory
size and tested that code once it doesn't look like you really care much
anymore

> +	}
> +}
> +
> +#define SPRN_PIR	0x11E	/* Processor Indentification Register */

That should go elsewhere along with the other SPR definitions.

> +void platform_init(void)
> +{
> +	/* Cap the zImage to 512MB */

Any reason ? If yes, please document it a bit more.

> +	unsigned long end_of_ram = 0x20000000;
> +	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
> +	u32 pir_reg;
> +	int node, size;
> +	const u32 *timebase;
> +
> +	simple_alloc_init(_end, avail_ram, 128, 64);
> +	platform_ops.fixups = ibm_currituck_fixups;
> +	platform_ops.exit = ibm44x_dbcr_reset;
> +	pir_reg = mfspr(SPRN_PIR);
> +
> +	/* Make sure FDT blob is sane */
> +	if (fdt_check_header(_dtb_start) != 0)
> +		fatal("Invalid device tree blob\n");
> +
> +	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
> +	                                     "cpu", sizeof("cpu"));
> +	if (!node)
> +		fatal("Cannot find cpu node\n");

The above will return -a- CPU node... you have several and you don't
know which one. You should probably iterate accross all of them.

> +	/* FIXME: Check this works */
> +	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
> +	if (timebase && (size == 4))
> +		timebase_period_ns = 1000000000 / *timebase;
> +
> +	fdt_set_boot_cpuid_phys(_dtb_start, pir_reg);
> +	fdt_init(_dtb_start);
> +
> +	serial_console_init();
> +
> +	ibm_currituck_detect_memsize();
> +}

> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 559da19..aa38de6 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -951,6 +951,7 @@
>  #define PVR_403GCX	0x00201400
>  #define PVR_405GP	0x40110000
>  #define PVR_476		0x11a52000
> +#define PVR_476CURRITUCK	0x7ff50000

My understanding is that the currituck was the platform, not the chip,
and that the chip was called something like 476FPE, am I wrong ?

>  #define PVR_STB03XXX	0x40310000
>  #define PVR_NP405H	0x41410000
>  #define PVR_NP405L	0x41610000
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index edae5bb..02e0749 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -1830,6 +1830,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.machine_check		= machine_check_47x,
>  		.platform		= "ppc470",
>  	},
> +	{ /* 476 core Currituck */
> +		.pvr_mask		= 0xffff0000,
> +		.pvr_value		= 0x7ff50000,
> +		.cpu_name		= "476",
> +		.cpu_features		= CPU_FTRS_47X | CPU_FTR_476_DD2,
> +		.cpu_user_features	= COMMON_USER_BOOKE |
> +			PPC_FEATURE_HAS_FPU,
> +		.mmu_features		= MMU_FTR_TYPE_47x |
> +			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 128,
> +		.machine_check		= machine_check_47x,
> +		.platform		= "ppc470",
> +	},

Same comment.

>  	{ /* 476 iss */
>  		.pvr_mask		= 0xffff0000,
>  		.pvr_value		= 0x00050000,
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
> index b725dab..3aca1e2 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -732,6 +732,8 @@ _GLOBAL(init_cpu_state)
>  	/* We use the PVR to differenciate 44x cores from 476 */
>  	mfspr	r3,SPRN_PVR
>  	srwi	r3,r3,16
> +	cmplwi	cr0,r3,PVR_476CURRITUCK@h
> +	beq	head_start_47x

So at some point, they gave us the magic foo to do with the PVR to
identify any 476... I'll try to dig that out of my email archives.

>  	cmplwi	cr0,r3,PVR_476@h
>  	beq	head_start_47x
>  	cmplwi	cr0,r3,PVR_476_ISS@h
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 762322c..245d121 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -186,6 +186,16 @@ config ISS4xx
>  	help
>  	  This option enables support for the IBM ISS simulation environment
>  
> +config CURRITUCK
> +	bool "IBM Currituck (476fpe) Support"
> +	depends on PPC_47x
> +	default n
> +	select SWIOTLB
> +	select PPC_FPU
> +	select PPC4xx_PCI_EXPRESS
> +	help
> +	  This option enables support for the IBM Currituck (476fpe) evaluation board
> +
>
>  config ICON
>  	bool "Icon"
>  	depends on 44x
> diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
> index 553db60..5cd2725 100644
> --- a/arch/powerpc/platforms/44x/Makefile
> +++ b/arch/powerpc/platforms/44x/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
>  obj-$(CONFIG_XILINX_ML510) += virtex_ml510.o
>  obj-$(CONFIG_ISS4xx)	+= iss4xx.o
>  obj-$(CONFIG_CANYONLANDS)+= canyonlands.o
> +obj-$(CONFIG_PPC_47x)	+= ppc47x.o
> diff --git a/arch/powerpc/platforms/44x/ppc47x.c b/arch/powerpc/platforms/44x/ppc47x.c
> new file mode 100644
> index 0000000..a4989b1
> --- /dev/null
> +++ b/arch/powerpc/platforms/44x/ppc47x.c

Call the file currituck.c

> @@ -0,0 +1,198 @@
> +/*
> + * Currituck board specific routines
> + *
> + * Copyright © 2011 Tony Breeds IBM Corporation
> + *
> + * Based on earlier code:
> + *    Matt Porter <mporter@kernel.crashing.org>
> + *    Copyright 2002-2005 MontaVista Software Inc.
> + *
> + *    Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
> + *    Copyright (c) 2003-2005 Zultys Technologies
> + *
> + *    Rewritten and ported to the merged powerpc tree:
> + *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
> + *    Copyright © 2011 David Kliekamp IBM Corporation
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/memblock.h>
> +#include <linux/of_platform.h>
> +#include <linux/rtc.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +#include <asm/ppc4xx.h>
> +#include <asm/mpic.h>
> +#include <asm/mmu.h>
> +
> +#include <linux/pci.h>
> +
> +static __initdata struct of_device_id ppc47x_of_bus[] = {
> +	{ .compatible = "ibm,plb4", },
> +	{ .compatible = "ibm,plb6", },
> +	{ .compatible = "ibm,opb", },
> +	{ .compatible = "ibm,ebc", },
> +	{},
> +};
> +
> +static void __devinit quirk_ppc_currituck_usb_fixup(struct pci_dev *dev)
> +{
> +	pci_write_config_dword(dev, 0xe0, 0x0114231f);
> +	pci_write_config_dword(dev, 0xe4, 0x00006c40);
> +}

Pleae document better what you are doing here and also test
that you are indeed on the right platform so you don't end up
whacking bits on USB controllers on other platforms that happen
to be compiled in the same binary.

> +DECLARE_PCI_FIXUP_HEADER(0x1033, 0x0035, quirk_ppc_currituck_usb_fixup);
> +
> +static int __init ppc47x_device_probe(void)
> +{
> +	of_platform_bus_probe(NULL, ppc47x_of_bus, NULL);
> +
> +	return 0;
> +}
> +machine_device_initcall(ppc47x, ppc47x_device_probe);
> +
> +/* We can have either UICs or MPICs */
> +static void __init ppc47x_init_irq(void)
> +{
> +	struct device_node *np;
> +
> +	/* Find top level interrupt controller */
> +	for_each_node_with_property(np, "interrupt-controller") {
> +		if (of_get_property(np, "interrupts", NULL) == NULL)
> +			break;
> +	}
> +	if (np == NULL)
> +		panic("Can't find top level interrupt controller");
> +
> +	/* Check type and do appropriate initialization */
> +	if (of_device_is_compatible(np, "chrp,open-pic")) {
> +		/* The MPIC driver will get everything it needs from the
> +		 * device-tree, just pass 0 to all arguments
> +		 */
> +		struct mpic *mpic =
> +			mpic_alloc(np, 0, MPIC_PRIMARY, 0, 0, " MPIC     ");
> +		BUG_ON(mpic == NULL);
> +		mpic_init(mpic);
> +		ppc_md.get_irq = mpic_get_irq;
> +	} else
> +		panic("Unrecognized top level interrupt controller");
> +}

Ok, I'll have to fixup that vs. Kyle patches but the good thing is that
it will make things even simpler.

> +#ifdef CONFIG_SMP
> +static void __cpuinit smp_ppc47x_setup_cpu(int cpu)
> +{
> +	mpic_setup_this_cpu();
> +}
> +
> +static int __cpuinit smp_ppc47x_kick_cpu(int cpu)
> +{
> +	struct device_node *cpunode = of_get_cpu_node(cpu, NULL);
> +	const u64 *spin_table_addr_prop;
> +	u32 *spin_table;
> +	extern void start_secondary_47x(void);
> +
> +	BUG_ON(cpunode == NULL);
> +
> +	/* Assume spin table. We could test for the enable-method in
> +	 * the device-tree but currently there's little point as it's
> +	 * our only supported method
> +	 */
> +	spin_table_addr_prop =
> +		of_get_property(cpunode, "cpu-release-addr", NULL);
> +
> +	if (spin_table_addr_prop == NULL) {
> +		pr_err("CPU%d: Can't start, missing cpu-release-addr !\n",
> +		       cpu);
> +		return 1;
> +	}
> +
> +	/* Assume it's mapped as part of the linear mapping. This is a bit
> +	 * fishy but will work fine for now
> +	 *
> +	 * XXX: Is there any reason to assume differently?
> +	 */
> +	spin_table = (u32 *)__va(*spin_table_addr_prop);
> +	pr_debug("CPU%d: Spin table mapped at %p\n", cpu, spin_table);
> +
> +	spin_table[3] = cpu;
> +	smp_wmb();
> +	spin_table[1] = __pa(start_secondary_47x);
> +	mb();
> +
> +	return 0;
> +}

Now pretty much everything in this platform file is generic I believe.
We could move it all to ppc44x_simple.c. The only things that are not
are the USB quirk and the interrupt fixup.

The USB quirk which should have a compatible test for the platform to
make sure we don't run it on something else. For such a simple quirk, I
think it's fine ot have it in ppc44x_simple.c or in drivers/pci/quirk.c

For the interrupt fixup, we can probably address it entirely in the
device-tree, though that means exposing a bunch of on-board bridges
which is only midly annoying.

Anyways, we can discuss that (or maybe an even better option)
tomorrow :-) 

> +static struct smp_ops_t ppc47x_smp_ops = {
> +	.probe		= smp_mpic_probe,
> +	.message_pass	= smp_mpic_message_pass,
> +	.setup_cpu	= smp_ppc47x_setup_cpu,
> +	.kick_cpu	= smp_ppc47x_kick_cpu,
> +	.give_timebase	= smp_generic_give_timebase,
> +	.take_timebase	= smp_generic_take_timebase,
> +};
> +
> +static void __init ppc47x_smp_init(void)
> +{
> +	if (mmu_has_feature(MMU_FTR_TYPE_47x))
> +		smp_ops = &ppc47x_smp_ops;
> +}
> +
> +#else /* CONFIG_SMP */
> +static void __init ppc47x_smp_init(void) { }
> +#endif /* CONFIG_SMP */
> +
> +static void __init ppc47x_setup_arch(void)
> +{
> +
> +	/* No need to check the DMA config as we /know/ our windows are all of
> + 	 * RAM.  Lets hope that doesn't change */
> +#ifdef CONFIG_SWIOTLB
> +	if (memblock_end_of_DRAM() > 0xffffffff) {
> +		ppc_swiotlb_enable = 1;
> +		set_pci_dma_ops(&swiotlb_dma_ops);
> +		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
> +	}
> +#endif
> +	ppc47x_smp_init();
> +}
> +
> +/*
> + * Called very early, MMU is off, device-tree isn't unflattened
> + */
> +static int __init ppc47x_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "ibm,476"))
> +		return 0;

> +	return 1;
> +}
> +
> +static void ppc47x_pci_irq_fixup(struct pci_dev *dev)
> +{
> +	if (dev->vendor == 0x1033 && (dev->device == 0x0035 ||
> +	                              dev->device == 0x00e0)) {
> +		dev->irq = irq_create_mapping(NULL, 47);
> +		pr_info("%s: Mapping irq 47 %d\n", __func__, dev->irq);
> +	}
> +}
> +
> +define_machine(ppc47x) {
> +	.name			= "PowerPC 47x",
> +	.probe			= ppc47x_probe,
> +	.progress		= udbg_progress,
> +	.init_IRQ		= ppc47x_init_irq,
> +	.setup_arch		= ppc47x_setup_arch,
> +	.pci_irq_fixup		= ppc47x_pci_irq_fixup,
> +	.restart		= ppc4xx_reset_system,
> +	.calibrate_decr		= generic_calibrate_decr,
> +};
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index d766068..49b711b 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -1290,6 +1290,52 @@ static struct ppc4xx_pciex_hwops ppc405ex_pcie_hwops __initdata =
>  
>  #endif /* CONFIG_40x */
>  
> +#ifdef CONFIG_CURRITUCK

Again, you are mixing the SoC with the board here. afaik, currituck is
the board, not the SoC.

> +static int __init ppc_currituck_pciex_core_init(struct device_node *np)
> +{
> +	return 4;
> +}
> +
> +static void __init ppc_currituck_pciex_check_link(struct ppc4xx_pciex_port *port)
> +{
> +	u32 timeout_ms = 20;
> +	u32 val = 0, mask = (PECFG_TLDLP_LNKUP|PECFG_TLDLP_PRESENT);
> +	void __iomem *mbase = ioremap(port->cfg_space.start + 0x10000000,
> +	                              0x1000);
> +
> +	printk(KERN_INFO "PCIE%d: Checking link...\n", port->index);
> +
> +	if (mbase == NULL) {
> +		printk(KERN_WARNING "PCIE%d: failed to get cfg space\n",
> +		                    port->index);
> +		return;
> +	}
> +		
> +	while (timeout_ms--) {
> +		val = in_le32(mbase + PECFG_TLDLP);
> +
> +		if ((val & mask) == mask)
> +			break;
> +		msleep(10);
> +	}
> +
> +	if (val & PECFG_TLDLP_PRESENT) {
> +		printk(KERN_INFO "PCIE%d: link is up !\n", port->index);
> +		port->link = 1;
> +	} else
> +		printk(KERN_WARNING "PCIE%d: Link up failed\n", port->index);
> +
> +	iounmap(mbase);
> +	return;
> +}
> +
> +static struct ppc4xx_pciex_hwops ppc_currituck_pcie_hwops __initdata =
> +{
> +	.core_init	= ppc_currituck_pciex_core_init,
> +	.check_link	= ppc_currituck_pciex_check_link,
> +};
> +#endif /* CONFIG_CURRITUCK */
> +
>  /* Check that the core has been initied and if not, do it */
>  static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
>  {
> @@ -1315,6 +1361,10 @@ static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
>  	if (of_device_is_compatible(np, "ibm,plb-pciex-405ex"))
>  		ppc4xx_pciex_hwops = &ppc405ex_pcie_hwops;
>  #endif
> +#ifdef CONFIG_CURRITUCK
> +	if (of_device_is_compatible(np, "ibm,plb-pciex-currituck"))
> +		ppc4xx_pciex_hwops = &ppc_currituck_pcie_hwops;
> +#endif
>  	if (ppc4xx_pciex_hwops == NULL) {
>  		printk(KERN_WARNING "PCIE: unknown host type %s\n",
>  		       np->full_name);
> @@ -1623,6 +1673,10 @@ static int __init ppc4xx_setup_one_pciex_POM(struct ppc4xx_pciex_port	*port,
>  			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL,
>  				sa | DCRO_PEGPL_460SX_OMR1MSKL_UOT
>  					| DCRO_PEGPL_OMRxMSKL_VAL);
> +		else if (of_device_is_compatible(port->node, "ibm,plb-pciex-currituck"))
> +			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL,
> +				sa | DCRO_PEGPL_CURRITUCK_OMR1MSKL_UOT
> +					| DCRO_PEGPL_OMRxMSKL_VAL);
>  		else
>  			dcr_write(port->dcrs, DCRO_PEGPL_OMR1MSKL,
>  				sa | DCRO_PEGPL_OMR1MSKL_UOT
> @@ -1747,7 +1801,8 @@ static void __init ppc4xx_configure_pciex_PIMs(struct ppc4xx_pciex_port *port,
>  		if (res->flags & IORESOURCE_PREFETCH)
>  			sa |= PCI_BASE_ADDRESS_MEM_PREFETCH;
>  
> -		if (of_device_is_compatible(port->node, "ibm,plb-pciex-460sx"))
> +		if (of_device_is_compatible(port->node, "ibm,plb-pciex-460sx") ||
> +		    of_device_is_compatible(port->node, "ibm,plb-pciex-currituck"))
>  			sa |= PCI_BASE_ADDRESS_MEM_TYPE_64;
>  
>  		out_le32(mbase + PECFG_BAR0HMPA, RES_TO_U32_HIGH(sa));
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h b/arch/powerpc/sysdev/ppc4xx_pci.h
> index 32ce763..81f60d9 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.h
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.h
> @@ -476,6 +476,13 @@
>  #define DCRO_PEGPL_OMR1MSKL_UOT	 0x00000002
>  #define DCRO_PEGPL_OMR3MSKL_IO	 0x00000002
>  
> +/* Currituck - 476 FPE */
> +#define PCCFG_LCPA			0x270
> +#define PECFG_TLDLP			0x3F8
> +#define PECFG_TLDLP_LNKUP		0x00000008
> +#define PECFG_TLDLP_PRESENT		0x00000010
> +#define DCRO_PEGPL_CURRITUCK_OMR1MSKL_UOT	 0x00000004
> +
>  /* SDR Bit Mappings */
>  #define PESDRx_RCSSET_HLDPLB	0x10000000
>  #define PESDRx_RCSSET_RSTGU	0x01000000

Cheers,
Ben.
