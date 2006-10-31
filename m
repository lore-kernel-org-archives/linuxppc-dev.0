Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt
	controller	support	for	ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4547AC30.3090208@bplan-gmbh.de>
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<4546F7DE.6070104@bplan-gmbh.de>
	<1162280335.25682.302.camel@localhost.localdomain>
	<4547086D.2050808@bplan-gmbh.de>
	<1162284176.25682.320.camel@localhost.localdomain>
	<454712A4.3000501@bplan-gmbh.de>  <4547AC30.3090208@bplan-gmbh.de>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 08:59:03 +1100
Message-Id: <1162331943.25682.358.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-31 at 21:04 +0100, Nicolas DET wrote:

> Here is is ;-).
> As my mailer can insert a file, I copy paste. I hope it's still ok...

No, your patch got wrapped. Its damaged. I see you used Thunderbird. I
have no experience with sending patches with it, so I don't know what
the trick is to have them undamaged. With evolution, the trick is to use
the pre-defined style "preformat".

Also, next, send it with proper form, that is just the commit message,
signed-off line, and patch. If you want to add personal comments on the
mail, add --- after the signed off and insert them between that and the
patch.

Anyway, minor comments, we're getting there...

> +void rtas_indicator_progress(char *, unsigned short);

That should be in a header.

> +extern unsigned long loops_per_jiffy;

That too. In fact, the default value for that which is all you need is
set in common code. Just drop that.

> +static void efika_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node *root;
> +	const char *revision = NULL;
> +	const char *codegendescription = NULL;
> +	const char *codegenvendor = NULL;
> +
> +	root = find_path_device("/");

Use of_find_device_by_path() and of_node_put() when done (see comments
in prom.h about old form of these being deprecated).

> +	if (root) {
> +		revision = get_property(root, "revision", NULL);
> +		codegendescription =
> +		    get_property(root, "CODEGEN,description", NULL);
> +		codegenvendor = get_property(root, "CODEGEN,vendor", NULL);
> +	}
> +
> +	if (codegendescription)
> +		seq_printf(m, "machine\t\t: %s\n", codegendescription);
> +	else
> +		seq_printf(m, "machine\t\t: Efika\n");
> +
> +	if (revision)
> +		seq_printf(m, "revision\t: %s\n", revision);
> +
> +	if (codegenvendor)
> +		seq_printf(m, "vendor\t\t: %s\n", codegenvendor);
> +}
> +
> +static void __init efika_setup_arch(void)
> +{
> +	/* init to some ~sane value until calibrate_delay() runs */
> +	loops_per_jiffy = 50000000 / HZ;

Above is already done in setup_32.c, just drop it.

> +	rtas_initialize();
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	initrd_below_start_ok = 1;
> +
> +	if (initrd_start)
> +		ROOT_DEV = Root_RAM0;
> +	else
> +#endif
> +		ROOT_DEV = Root_SDA2;	/* sda2 (sda1 is for the kernel) */
> +
> +	pci_create_OF_bus_map();

I think the OF_bus_map() thing can safely be depracated. Don't bother
with it, you won't need it anyway.

> +	efika_pcisetup();
> +
> +	if (ppc_md.progress)
> +		ppc_md.progress("Linux/PPC " UTS_RELEASE " runnung on Efika ;-)\n", 0x0);
> +}
> +
> +static void __init efika_init_IRQ(void)
> +{
> +	of_irq_map_init(0);

The above is only useful if you have special flags to pass. You don't so
just skip it.

> +	mpc52xx_init_irq();
> +}
> +
> +static void __init efika_init(void)
> +{
> +	if (ppc_md.progress)
> +		ppc_md.progress("  Have fun with your Efika!    ", 0x7777);
> +}
> +
> +static int __init efika_probe(void)
> +{
> +	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
> +					  "model", NULL);
> +
> +	if (model == NULL)
> +		return 0;
> +	if (strcmp(model, "EFIKA5K2"))
> +		return 0;
> +
> +	ISA_DMA_THRESHOLD = ~0L;
> +	DMA_MODE_READ = 0x44;
> +	DMA_MODE_WRITE = 0x48;
> +
> +	/*
> +	 * Others values (isa_mem_base, pci_dram_base) are 0
> +	 * in CHRP for us. Only isa_io_base is changed.
> +	*/
> +	isa_io_base = CHRP_ISA_IO_BASE;

Leave it to zero for now. pci_process_bridge_OF_ranges() will set it for
you to the right address. Pre-initializing is only useful if you have
very early IO ports access -and- have an early mapping on that range.
You have neither so don't bother.

> +	return 1;
> +}
> +
> +define_machine(efika)
> +{
> +	.name = EFIKA_PLATFORM_NAME,
> +	.probe = efika_probe,
> +	.setup_arch = efika_setup_arch,
> +	.init = efika_init,
> +	.show_cpuinfo = efika_show_cpuinfo,
> +	.init_IRQ = efika_init_IRQ,
> +	.get_irq = mpc52xx_get_irq,
> +	.restart = rtas_restart,
> +	.power_off = rtas_power_off,
> +	.halt = rtas_halt,
> +	.set_rtc_time = rtas_set_rtc_time,
> +	.get_rtc_time = rtas_get_rtc_time,
> +	.progress = rtas_progress,
> +	.get_boot_time = rtas_get_boot_time,
> +	.calibrate_decr = generic_calibrate_decr,
> +	.phys_mem_access_prot = pci_phys_mem_access_prot,
> +	.pcibios_fixup = efika_pciirq_map,
> +};

The later can go away if you apply the patch I posted last week 
[PATCH] Powerpc:  Make pci_read_irq_line the default: on mpc7448hpc2
board. First.

> --- a/arch/powerpc/platforms/efika/pci.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/arch/powerpc/platforms/efika/pci.c	2006-10-31 12:31:55.000000000 +0100
> @@ -0,0 +1,150 @@
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +#include <linux/ide.h>
> +
> +#include <asm/io.h>
> +#include <asm/pgtable.h>
> +#include <asm/irq.h>
> +#include <asm/hydra.h>
> +#include <asm/prom.h>
> +#include <asm/gg2.h>
> +#include <asm/machdep.h>
> +#include <asm/sections.h>
> +#include <asm/pci-bridge.h>
> +#include <asm/grackle.h>
> +#include <asm/rtas.h>

You can trim a lot of the above #includes :)

> +#include "efika.h"
> +
> +static struct device_node *efika_pcictrl;

Not needed (the above).

> +/*
> + * Access functions for PCI config space using RTAS calls.
> + */
> +static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, 
> int offset,
> +			    int len, u32 * val)
> +{
> +	struct pci_controller *hose = bus->sysdata;
> +	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
> +	    | (((bus->number - hose->first_busno) & 0xff) << 16)
> +	    | (hose->index << 24);
> +	int ret = -1;
> +	int rval;
> +
> +	rval = rtas_call(rtas_token("read-pci-config"), 2, 2, &ret, addr, len);
> +	*val = ret;
> +	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
> +			     int offset, int len, u32 val)
> +{
> +	struct pci_controller *hose = bus->sysdata;
> +	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
> +	    | (((bus->number - hose->first_busno) & 0xff) << 16)
> +	    | (hose->index << 24);
> +	int rval;
> +
> +	rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
> +			 addr, len, val);
> +	return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops rtas_pci_ops = {
> +	rtas_read_config,
> +	rtas_write_config
> +};
> +
> +void __init efika_pcisetup(void)
> +{
> +	const int *bus_range;
> +	int len;
> +	struct pci_controller *hose;
> +	struct device_node *root;
> +	struct device_node *pcictrl;
> +
> +	root = of_find_node_by_path("/");
> +	if (root == NULL) {
> +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> +		       ": Unable to find the root node\n");
> +		return;
> +	}
> +
> +	for (pcictrl = NULL;;) {
> +		pcictrl = of_get_next_child(root, pcictrl);
> +		if ((pcictrl == NULL) || (strcmp(pcictrl->name, "pci") == 0))
> +			break;
> +	}
> +
> +	if (pcictrl == NULL) {
> +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> +		       ": Unable to find the PCI bridge node\n");
> +		return;
> +	}

of_node_put() when you are done with the result of
of_find_node_by_path() and of_get_next_child(). Note that the later does
it implicitely on its arguyment so you only need to do it if you exit
the loop early

> +	efika_pcictrl = pcictrl;

Remove that.

> +	bus_range = get_property(pcictrl, "bus-range", &len);
> +	if (bus_range == NULL || len < 2 * sizeof(int)) {
> +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> +		       ": Can't get bus-range for %s\n", pcictrl->full_name);
> +		return;
> +	}
> +	if (bus_range[1] == bus_range[0])
> +		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI bus %d",
> +		       bus_range[0]);
> +	else
> +		printk(KERN_INFO EFIKA_PLATFORM_NAME ": PCI buses %d..%d",
> +		       bus_range[0], bus_range[1]);
> +	printk(" controlled by %s", pcictrl->full_name);
> +	printk("\n");
> +
> +	hose = pcibios_alloc_controller();
> +	if (!hose) {
> +		printk(KERN_WARNING EFIKA_PLATFORM_NAME
> +		       ": Can't allocate PCI controller structure for %s\n",
> +		       pcictrl->full_name);
> +		return;
> +	}
> +
> +	hose->arch_data = pcictrl;
> +	hose->first_busno = bus_range[0];
> +	hose->last_busno = bus_range[1];
> +	hose->ops = &rtas_pci_ops;
> +
> +	pci_process_bridge_OF_ranges(hose, pcictrl, 0);
> +}
> +
> +void __init efika_pciirq_map(void)
> +{
> +	struct device_node *pcictrl = efika_pcictrl;
> +	struct pci_dev *pdev = NULL;
> +	struct device_node *ofwdev;
> +
> +	if (pcictrl == NULL)
> +		return;
> +
> +	/*
> +	 * We need to find PCI irq, create a virtual mapping, and set
> +	 * the irq number into the PCI structure (software/Linux side)
> +	 * I could to this by walking into the /pci node, do
> +	 * of_irq_map_pci(), irq_create_of_mapping(), then find
> +	 * the good 'struct pci_dev *' and update pci_dev->irq.
> +	 * However, pci_read_irq_line() should do everything correctly!
> +	*/
> +
> +	for_each_pci_dev(pdev)
> +	{
> +		if (pci_read_irq_line(pdev) < 0)
> +			continue;
> +
> +		ofwdev = pci_device_to_OF_node(pdev);
> +		if (ofwdev)
> +			printk(KERN_INFO EFIKA_PLATFORM_NAME ": got IRQ 0x%x for '%s'\n", 
> pdev->irq, ofwdev->full_name);
> +	}
> +
> +}

The whole function is not needed. Just apply my other patch first.

> --- a/arch/powerpc/platforms/efika/efika.h	1970-01-01 01:00:00.000000000 
> +0100
> +++ b/arch/powerpc/platforms/efika/efika.h	2006-10-31 12:31:55.000000000 
> +0100
> @@ -0,0 +1,20 @@
> +/*
> + * Efika 5K2 platform setup - Header file
> + *
> + * Copyright (C) 2006 bplan GmbH
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + *
> + */
> +
> +#ifndef __ARCH_POWERPC_EFIKA__
> +#define __ARCH_POWERPC_EFIKA__
> +
> +#define EFIKA_PLATFORM_NAME "Efika"
> +
> +void __init efika_pcisetup(void);
> +void __init efika_pciirq_map(void);

Use "extern" for prototypes in a .h

> +#endif
> --- a/arch/powerpc/platforms/efika/Makefile	1970-01-01 
> 01:00:00.000000000 +0100
> +++ b/arch/powerpc/platforms/efika/Makefile	2006-10-31 
> 20:03:05.000000000 +0100
> @@ -0,0 +1 @@
> +obj-y += setup.o pci.o
> --- a/arch/powerpc/platforms/Makefile	2006-10-31 20:28:06.000000000 +0100
> +++ b/arch/powerpc/platforms/Makefile	2006-10-31 12:31:55.000000000 +0100
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
>   endif
>   endif
>   obj-$(CONFIG_PPC_CHRP)		+= chrp/
> +obj-$(CONFIG_PPC_EFIKA)		+= efika/
>   obj-$(CONFIG_4xx)		+= 4xx/
>   obj-$(CONFIG_PPC_83xx)		+= 83xx/
>   obj-$(CONFIG_PPC_85xx)		+= 85xx/
> --- a/arch/powerpc/boot/Makefile	2006-10-25 19:07:23.000000000 +0200
> +++ b/arch/powerpc/boot/Makefile	2006-10-31 12:31:55.000000000 +0100
> @@ -155,6 +155,7 @@ image-$(CONFIG_PPC_PSERIES)		+= zImage.p
>   image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
>   image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
>   image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
> +image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
>   image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
>   image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
> 
> --- a/arch/powerpc/Kconfig	2006-10-31 20:28:06.000000000 +0100
> +++ b/arch/powerpc/Kconfig	2006-10-31 19:57:57.000000000 +0100
> @@ -386,6 +386,19 @@ config PPC_CHRP
>   	select PPC_UDBG_16550
>   	default y
> 
> +config PPC_MPC52xx_PIC
> +        bool
> +	default y
> +
> +config PPC_EFIKA
> +	bool "bPlan Efika 5k2. MPC5200B based computer"
> +	depends on PPC_MULTIPLATFORM && PPC32
> +	select PPC_RTAS
> +	select RTAS_PROC
> +	select PPC_MPC52xx
> +	select PPC_MPC52xx_PIC
> +	default y
> +
>   config PPC_PMAC
>   	bool "Apple PowerMac based machines"
>   	depends on PPC_MULTIPLATFORM
> 

PIC patch separate please.

> +/*
> + * Critial interrupt irq_chip
> +*/
> +static void mpc52xx_crit_mask(unsigned int virq)
> +{
> +	int irq;
> +	int l2irq;
> +
> +	irq = irq_map[virq].hwirq;
> +	l2irq = (irq & MPC52xx_IRQ_L2_MASK) >> MPC52xx_IRQ_L2_OFFSET;
> +
> +	pr_debug("%s: irq=%x, l2=%d\n", __func__, irq, l2irq);
> +
> +	BUG_ON(l2irq != 0);
> +
> +	io_be_clrbit(&intr->ctrl, 11);
> +}

I'm not sure you understood my previous comment... any reason why crit
and mainirq are two different sets of functions and a different level 1
since crit is just basically mainirq 0 ? And main & mainirq, on the
contrary, should be different L1s since they are ... different :)

> +	switch (l1irq) {
> +	case MPC52xx_IRQ_L1_CRIT:
> +		pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
> +
> +		BUG_ON(l2irq != 0);
> +
> +		type = mpc52xx_irqx_gettype(l2irq);
> +		good_irqchip = &mpc52xx_crit_irqchip;
> +		break;
> +
> +	case MPC52xx_IRQ_L1_MAIN:
> +		pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
> +
> +		if ((l2irq >= 0) && (l2irq <= 3)) {
> +			type = mpc52xx_irqx_gettype(l2irq);
> +			good_irqchip = &mpc52xx_mainirq_irqchip;
> +		} else {
> +			good_irqchip = &mpc52xx_main_irqchip;
> +		}
> +		break;

And doing so would have you simplify the above 2 cases

> +	mpc52xx_irqhost =
> +	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, 0xd0,
> +			   &mpc52xx_irqhost_ops, -1);

I would prefer that 0xd0 to be a symbolic constant in the .h

> +	if (mpc52xx_irqhost)
> +		mpc52xx_irqhost->host_data = (void *)find_mpc52xx_picnode();

Casting to void * is fairly useless :)

> +#ifdef CONFIG_PCI
> +#define _IO_BASE        isa_io_base
> +#define _ISA_MEM_BASE   isa_mem_base
> +#define PCI_DRAM_OFFSET pci_dram_offset
> +#else
> +#define _IO_BASE        0
> +#define _ISA_MEM_BASE   0
> +#define PCI_DRAM_OFFSET 0
> +#endif

I told you several times to remove the above. The whole thing is
duplicate of io.h.

The fact that the former has a special case for CONFIG_PPC_MPC52xx is
bogus in the first place... you might want to turn -that- into a

if defined(CONFIG_PPC_MPC52xx) && !defined(CONFIG_PPC_MERGE)

> +/* 
> ======================================================================== */
> +/* Main registers/struct addresses 
>       */
> +/* 
> ======================================================================== */
> +
> +/* MBAR position */
> +#define MPC52xx_MBAR		0xf0000000	/* Phys address */
> +#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
> +#define MPC52xx_MBAR_SIZE	0x00010000
> +
> +#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
> +#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))

The above definitions are all bogus for arch/powerpc, just remove them.

> +/*
> + * 24 peripherals ints
> + * + 16 mains ints
> + * + 4 crit
> + * + 16 bestcomm task
> + * = 64
> +*/
> +#define MPC52xx_IRQ_MAXCOUNT     (64)

The above is both not correct anymore and not used. Please fix it and
use it instead of hard coding.

> +static inline struct device_node *find_mpc52xx_picnode(void)
> +{
> +	return of_find_compatible_node(NULL, "interrupt-controller",
> +				       "mpc5200-pic");
> +}

Any reason why you need that inline since it's not used anywhere else
but the PIC code ? Just put that of_find_compatible_node() statement in
the .c and be done with it.

> +	/* Matching of PSC function */
> +struct mpc52xx_psc_func {
> +	int id;
> +	char *func;
> +};
>
> +extern int mpc52xx_match_psc_function(int psc_idx, const char *func);
> +extern struct mpc52xx_psc_func mpc52xx_psc_functions[];
> +	/* This array is to be defined in platform file */

The above doesn't look like it should migrate to arch/powerpc... what is
it supposed to be ?

Ben.
