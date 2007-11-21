Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98655DDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 05:19:57 +1100 (EST)
Date: Wed, 21 Nov 2007 19:30:21 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Andrei Dolnikov <adolnikov@ru.mvista.com>
Subject: Re: [PATCH 4/5] PowerPC 74xx: Katana Qp base support
Message-ID: <20071121193021.6bffeaa9@kernel.crashing.org>
In-Reply-To: <20071116163116.GE25062@ru.mvista.com>
References: <20071116154344.GA25062@ru.mvista.com>
	<20071116163116.GE25062@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrei,

Looks okay in general, some notes below...

On Fri, 16 Nov 2007 19:31:16 +0300
Andrei Dolnikov wrote:

> Emerson Katana Qp platform specific code
> 
> Signed-off-by: Andrei Dolnikov <adolnikov@ru.mvista.com>
> 
> ---
>  arch/powerpc/platforms/embedded6xx/Kconfig    |    9 +
>  arch/powerpc/platforms/embedded6xx/Makefile   |    1
>  arch/powerpc/platforms/embedded6xx/katanaqp.c |  180
> ++++++++++++++++++++++++++ 3 files changed, 190 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig
> b/arch/powerpc/platforms/embedded6xx/Kconfig index 8924095..33190bd
> 100644 --- a/arch/powerpc/platforms/embedded6xx/Kconfig
> +++ b/arch/powerpc/platforms/embedded6xx/Kconfig
> @@ -46,6 +46,15 @@ config PPC_PRPMC2800
>  	help
>  	  This option enables support for the Motorola PrPMC2800
> board 
> +config PPC_KATANAQP
> +	bool "Emerson-Katana Qp"
> +	depends on EMBEDDED6xx
> +	select MV64X60
> +	select NOT_COHERENT_CACHE
> +	select WANT_DEVICE_TREE
> +	help
> +	  This option enables support for the Emerson Katana Qp board
> +
>  config TSI108_BRIDGE
>  	bool
>  	depends on MPC7448HPC2 || PPC_HOLLY
> diff --git a/arch/powerpc/platforms/embedded6xx/Makefile
> b/arch/powerpc/platforms/embedded6xx/Makefile index 844947c..c83558f
> 100644 --- a/arch/powerpc/platforms/embedded6xx/Makefile
> +++ b/arch/powerpc/platforms/embedded6xx/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
>  obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
>  obj-$(CONFIG_PPC_HOLLY)		+= holly.o
>  obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
> +obj-$(CONFIG_PPC_KATANAQP)	+= katanaqp.o
> diff --git a/arch/powerpc/platforms/embedded6xx/katanaqp.c
> b/arch/powerpc/platforms/embedded6xx/katanaqp.c new file mode 100644
> index 0000000..c0a8469
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/katanaqp.c
> @@ -0,0 +1,180 @@
> +/*
> + * Board setup routines for the Emerson Katana Qp
> + *
> + * Authors: Vladislav Buzov <vbuzov@ru.mvista.com>
> + *	    Andrei Dolnikov <adolnikov@ru.mvista.com>
> + *
> + * Based on prpmc2800.c by Dale Farnsworth <dale@farnsworth.org>
> + *
> + * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
> + * the terms of the GNU General Public License version 2.  This
> program
> + * is licensed "as is" without any warranty of any kind, whether
> express
> + * or implied.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/seq_file.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/system.h>
> +#include <asm/time.h>
> +#include <asm/kexec.h>
> +
> +#include <mm/mmu_decl.h>
> +
> +#include <sysdev/mv64x60.h>
> +
> +#define PLATFORM_NAME_MAX	64
> +
> +/* CPLD registers definitions */
> +#define KATANAQP_CPLD_RCR	0x0004	/* Reset command */
> +#define KATANAQP_CPLD_RCR_CPUHR	(1 << 7)
> +
> +#define KATANAQP_CPLD_HVR	0x0020
> +
> +#define KATANAQP_CPLD_PSR	0x0030	/* PCI status */
> +#define KATANAQP_CPLD_PSR_PMCM	(1 << 1)
> +
> +#define KATANAQP_CPLD_HCR	0x0044
> +
> +static char katanaqp_platform_name[PLATFORM_NAME_MAX];
> +
> +static void __iomem *cpld_base;
> +
> +int katanaqp_exclude_device(struct pci_controller *hose, u_char bus,
> +			    u_char devfn)
> +{
> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	else
> +		return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int __init katanaqp_is_monarch(void)
> +{
> +	return !(in_8((volatile char *)(cpld_base +
> KATANAQP_CPLD_PSR)) &
> +		 KATANAQP_CPLD_PSR_PMCM);
> +}
> +
> +static void __init katanaqp_setup_arch(void)
> +{
> +	struct device_node *cpld;
> +	const unsigned int *reg;
> +
> +	/*
> +	 * ioremap cpld registers in case they are later
> +	 * needed by katanaqp_reset_board().
> +	 */
> +	cpld =
> of_find_node_by_path("/mv64x60@f8100000/cpld@f8200000");
> +	reg = of_get_property(cpld, "reg", NULL);
> +	of_node_put(cpld);
> +	cpld_base = ioremap(reg[0], reg[1]);
> +
use of_iomap here?

> +#ifdef CONFIG_PCI
> +	if (katanaqp_is_monarch()) {
> +		mv64x60_pci_init();
> +		ppc_md.pci_exclude_device = katanaqp_exclude_device;
> +	}
> +#endif
> +
> +	printk("Emerson Network Power %s\n", katanaqp_platform_name);
> +}
> +
> +static void katanaqp_reset_board(void)
> +{
> +	local_irq_disable();
> +
> +	/* issue hard reset to the reset command register */
> +	out_8((volatile char *)(cpld_base + KATANAQP_CPLD_RCR),
> +	      KATANAQP_CPLD_RCR_CPUHR);
> +	for (;;) ;
> +}
> +
> +static void katanaqp_restart(char *cmd)
> +{
> +	katanaqp_reset_board();
> +}
> +
> +#ifdef CONFIG_NOT_COHERENT_CACHE
> +#define KATANAQP_COHERENCY_SETTING "off"
> +#else
> +#define KATANAQP_COHERENCY_SETTING "on"
> +#endif
> +
Does it mean this HW supports both coherent and non-coherent case?
I don't think we need to add this just "for the future" if QP doesn't have it.

If it does, I dont' see how it's being handled  - defconfig just enables noncoherent upper.

> +void katanaqp_show_cpuinfo(struct seq_file *m)
> +{
> +	uint memsize = total_memory;
> +
> +	seq_printf(m, "vendor\t\t: Emerson Network Power\n");
> +
> +	seq_printf(m, "hardware rev\t: %d\n",
> +		   in_8((volatile char *)(cpld_base +
> KATANAQP_CPLD_HVR))); +
> +	seq_printf(m, "hardware config\t: %d\n",
> +		   in_8((volatile char *)(cpld_base +
> KATANAQP_CPLD_HCR))); +
> +	seq_printf(m, "memory size\t: %d MB\n", memsize / (1024 *
> 1024)); +
> +	seq_printf(m, "voherency\t: %s\n",
> KATANAQP_COHERENCY_SETTING); +
> +	seq_printf(m, "PCI\t\t: %sMonarch\n",
> +		   katanaqp_is_monarch() ? "" : "Non-");
> +}
> +
> +static int __init katanaqp_of_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "cfi-flash");
> +	if (np)
> +		of_platform_device_create(np, "of-flash", NULL);
> +
Why not using of_device for physmap?
> +	return 0;
> +}
> +
> +device_initcall(katanaqp_of_init);
> +
> +/*
> + * Called very early, device-tree isn't unflattened
> + */
> +static int __init katanaqp_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +	unsigned long len = PLATFORM_NAME_MAX;
not needed - get-prop will rewrite it anyway.

> +	void *m;
> +
> +	if (!of_flat_dt_is_compatible(root, "emerson,Katana-Qp"))
> +		return 0;
> +
> +	/* Update ppc_md.name with name from dt */
> +	m = of_get_flat_dt_prop(root, "model", &len);
> +	if (m)
> +		strncpy(katanaqp_platform_name, m,
> +			min((int)len, PLATFORM_NAME_MAX - 1));
> +

> +	return 1;
> +}
> +
> +define_machine(katanaqp)
> +{
> +	.name			= katanaqp_platform_name,
> +	.probe			= katanaqp_probe,
> +	.setup_arch		= katanaqp_setup_arch,
> +	.init_early		= mv64x60_init_early,
> +	.show_cpuinfo		= katanaqp_show_cpuinfo,
> +	.init_IRQ		= mv64x60_init_irq,
> +	.get_irq		= mv64x60_get_irq,
> +	.restart		= katanaqp_restart,
> +	.calibrate_decr		= generic_calibrate_decr,
> +#ifdef CONFIG_KEXEC
> +	.machine_kexec		= default_machine_kexec,
> +	.machine_kexec_prepare	=
> default_machine_kexec_prepare,
> +	.machine_crash_shutdown	=
> default_machine_crash_shutdown, +#endif
> +};
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
