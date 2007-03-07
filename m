Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 0CBFEDDF7F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 10:29:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 2/7] xenon: add platform support
Date: Thu, 8 Mar 2007 00:06:25 +0100
References: <20070307180144.812594000@elitedvb.net>
	<20070307180144.812594000@elitedvb.net>>
	<20070307180525.774243000@elitedvb.net>>
In-Reply-To: <20070307180525.774243000@elitedvb.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703080006.25246.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#define PRIO_IPI_4       0x08
> +#define PRIO_IPI_3       0x10
> +#define PRIO_SMM         0x14
> +#define PRIO_SFCX        0x18
> +#define PRIO_SATA_HDD    0x20
> +#define PRIO_SATA_CDROM  0x24
> +#define PRIO_OHCI_0      0x2c
> +#define PRIO_EHCI_0      0x30
> +#define PRIO_OHCI_1      0x34
> +#define PRIO_EHCI_1      0x38
> +#define PRIO_XMA         0x40
> +#define PRIO_AUDIO       0x44
> +#define PRIO_ENET        0x4C
> +#define PRIO_XPS         0x54
> +#define PRIO_GRAPHICS    0x58
> +#define PRIO_PROFILER    0x60
> +#define PRIO_BIU         0x64
> +#define PRIO_IOC         0x68
> +#define PRIO_FSB         0x6c
> +#define PRIO_IPI_2       0x70
> +#define PRIO_CLOCK       0x74
> +#define PRIO_IPI_1       0x78

These should probably all come from the device tree
instead of compile-time constants.

> +void __init xenon_iic_init_IRQ(void)
> +{
> +	int i;
> +	struct device_node *dn;
> +
> +	printk("XENON init IRQ\n");

needs a printk level, KERN_DEBUG or KERN_INFO.

> +			/* search for our interrupt controller inside the device tree */
> +	for (dn = NULL;
> +	     (dn = of_find_node_by_name(dn,"interrupt-controller")) != NULL;) {
> +		if (!device_is_compatible(dn,
> +				     "xenon"))
> +			continue;
> +
> +		irq_set_virq_count(0x80);
> +		iic_base = ioremap_nocache(0x20000050000, 0x10000);

This should come from the 'reg' property of the above node.


> +void xenon_cause_IPI(int target, int msg)
> +{
> +	int ipi_prio;
> +
> +	ipi_prio = ipi_to_prio(msg);
> +
> +	__raw_writeq( (0x10000<<target) | ipi_prio, iic_base + 0x10 +
> hard_smp_processor_id() * 0x1000); +}
> +

You seem to have a line wrapping problem and might need to fix your
mail client.
Also, don't use __raw_writeq here. In order to access on-chip data,
use out_be64().

> +	hose->ops = &xenon_pci_ops;
> +	hose->cfg_addr = ioremap(0xd0000000, 0x1000000);
> +
The addresses should come from the device tree, don't hardcode
them in the source.

> +#define DEBUG
> +

really?


> +void __init xenon_pci_init(void);
> +#ifdef CONFIG_SMP
> +extern void smp_init_xenon(void);
> +#endif

move these declarations to a header

> +static void xenon_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node *root;
> +	const char *model = "";
> +
> +	root = of_find_node_by_path("/");
> +	if (root)
> +		model = get_property(root, "model", NULL);
> +	seq_printf(m, "machine\t\t: CHRP %s\n", model);
> +	of_node_put(root);
> +}

CHRP???

> +static void __init xenon_pcibios_fixup(void)
> +{
> +	struct pci_dev *dev = NULL;
> +
> +	for_each_pci_dev(dev)
> +		pci_read_irq_line(dev);
> +}

I guess you copied that from cell? You should not need it.

> +	if (ROOT_DEV == 0) {
> +		printk("No ramdisk, default root is /dev/hda2\n");
> +		ROOT_DEV = Root_HDA2;
> +	}

kill this, it's unnecessary (and probably wrong in your case)

> +static int __init xenon_probe(void)
> +{
> +       hpte_init_native();
> +
> +       return 1;
> +}

This definitely needs to check the device tree whether it's running
on the right platform, otherwise you can not build a multiplatform
kernel.

> +void __init xenon_hpte_init(unsigned long htab_size);
> +
move this to a header file


> +#include <asm/rtas.h>

rtas???

> +#ifdef DEBUG
> +#define DBG(fmt...) printk(fmt)
> +#else
> +#define DBG(fmt...)
> +#endif
> +

Don't define your own macros like this, use the pr_debug()
one from kernel.h.

> +void smp_init_xenon(void);
> +
> +extern void xenon_request_IPIs(void);
> +extern void xenon_init_irq_on_cpu(int cpu);
> +
> +extern void xenon_cause_IPI(int target, int msg);

extern declarations should go to header files, not into
the implementation.


> +	/* Mark threads which are still spinning in hold loops. */
> +	if (cpu_has_feature(CPU_FTR_SMT)) {
> +		for_each_present_cpu(i) {
> +			if (i % 2 == 0)
> +				/*
> +				 * Even-numbered logical cpus correspond to
> +				 * primary threads.
> +				 */
> +				cpu_set(i, of_spin_map);
> +		}
> +	} else {
> +		of_spin_map = cpu_present_map;
> +	}

Yes, we wrote code like that for CBE, but that doesn't mean it's good
enough to copy it ;-)

Relying on the cpu number to mean something specific is bad, and
we're trying to get rid of that in other places, so you should
not introduce it again here.

> +#define CPU_FTRS_XENON ((CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
> +	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
> +	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> +	    CPU_FTR_CTRL )&~CPU_FTR_16M_PAGE)
> +// | CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE  /* we need to setup large

If the CPU doesn't do 16M pages, you need to make sure that CPU_FTRS_ALWAYS
is adapted properly.
