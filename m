Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/21] powerpc: Add skeleton PowerNV platform
In-reply-to: <1315664408-16797-6-git-send-email-benh@kernel.crashing.org>
References: <1315664408-16797-1-git-send-email-benh@kernel.crashing.org>
	<1315664408-16797-6-git-send-email-benh@kernel.crashing.org>
Date: Mon, 12 Sep 2011 11:17:31 +1000
Message-ID: <9312.1315790251@neuling.org>
From: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <1315664408-16797-6-git-send-email-benh@kernel.crashing.org> you wro
te:
> This adds a skeletton for the new Power "Non Virtualized"
> platform which will be used by machines supporting running
> without an hypervisor, for example in order to run KVM.
> 
> These machines will be using a new firmware called OPAL
> for which the support will be provided by later patches.
> 
> The PowerNV platform is intended to be also usable under
> the BML environment used internally for early CPU bringup
> which is why the code also supports using RTAS instead of
> OPAL in various places.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Giggity-Giggity-by: Michael Neuling <mikey@neuling.org>

> ---
>  arch/powerpc/boot/Makefile               |    1 +
>  arch/powerpc/platforms/Kconfig           |    1 +
>  arch/powerpc/platforms/Makefile          |    1 +
>  arch/powerpc/platforms/powernv/Kconfig   |   12 +++
>  arch/powerpc/platforms/powernv/Makefile  |    2 +
>  arch/powerpc/platforms/powernv/powernv.h |   10 ++
>  arch/powerpc/platforms/powernv/setup.c   |  153 ++++++++++++++++++++++++++++
++
>  arch/powerpc/platforms/powernv/smp.c     |   83 ++++++++++++++++
>  8 files changed, 263 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/platforms/powernv/Kconfig
>  create mode 100644 arch/powerpc/platforms/powernv/Makefile
>  create mode 100644 arch/powerpc/platforms/powernv/powernv.h
>  create mode 100644 arch/powerpc/platforms/powernv/setup.c
>  create mode 100644 arch/powerpc/platforms/powernv/smp.c
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index c26200b..52cde90 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -171,6 +171,7 @@ quiet_cmd_wrap	= WRAP    $@
>  		$(if $3, -s $3)$(if $4, -d $4)$(if $5, -i $5) vmlinux
>  
>  image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
> +image-$(CONFIG_PPC_POWERNV)		+= zImage.pseries
>  image-$(CONFIG_PPC_MAPLE)		+= zImage.maple
>  image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
>  image-$(CONFIG_PPC_PS3)			+= dtbImage.ps3
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index b9ba861..6de27d2 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -1,5 +1,6 @@
>  menu "Platform support"
>  
> +source "arch/powerpc/platforms/powernv/Kconfig"
>  source "arch/powerpc/platforms/pseries/Kconfig"
>  source "arch/powerpc/platforms/iseries/Kconfig"
>  source "arch/powerpc/platforms/chrp/Kconfig"
> diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefil
e
> index 73e2116..2635a22 100644
> --- a/arch/powerpc/platforms/Makefile
> +++ b/arch/powerpc/platforms/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PPC_82xx)		+= 82xx/
>  obj-$(CONFIG_PPC_83xx)		+= 83xx/
>  obj-$(CONFIG_FSL_SOC_BOOKE)	+= 85xx/
>  obj-$(CONFIG_PPC_86xx)		+= 86xx/
> +obj-$(CONFIG_PPC_POWERNV)	+= powernv/
>  obj-$(CONFIG_PPC_PSERIES)	+= pseries/
>  obj-$(CONFIG_PPC_ISERIES)	+= iseries/
>  obj-$(CONFIG_PPC_MAPLE)		+= maple/
> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/
powernv/Kconfig
> new file mode 100644
> index 0000000..5cd04f5
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -0,0 +1,12 @@
> +config PPC_POWERNV
> +	depends on PPC64 && PPC_BOOK3S
> +	bool "IBM PowerNV (Non-Virtualized) platform support"	
> +	select PPC_RTAS
> +	select PPC_NATIVE
> +	select PPC_XICS
> +	select PPC_ICP_NATIVE
> +	select PPC_ICS_RTAS
> +	select PPC_P7_NAP
> +	select PPC_PCI_CHOICE if EMBEDDED
> +	default y
> +
> diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms
/powernv/Makefile
> new file mode 100644
> index 0000000..1c43250
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -0,0 +1,2 @@
> +obj-y			+= setup.o
> +obj-$(CONFIG_SMP)	+= smp.o
> diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platform
s/powernv/powernv.h
> new file mode 100644
> index 0000000..35b7160
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/powernv.h
> @@ -0,0 +1,10 @@
> +#ifndef _POWERNV_H
> +#define _POWERNV_H
> +
> +#ifdef CONFIG_SMP
> +extern void pnv_smp_init(void);
> +#else
> +static inline void pnv_smp_init(void) { }
> +#endif
> +
> +#endif /* _POWERNV_H */
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/
powernv/setup.c
> new file mode 100644
> index 0000000..569f9cc
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -0,0 +1,153 @@
> +/*
> + * PowerNV setup code.
> + *
> + * Copyright 2011 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/cpu.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/tty.h>
> +#include <linux/reboot.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +#include <linux/seq_file.h>
> +#include <linux/of.h>
> +#include <linux/interrupt.h>
> +#include <linux/bug.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/firmware.h>
> +#include <asm/xics.h>
> +
> +#include "powernv.h"
> +
> +static void __init pnv_setup_arch(void)
> +{
> +	/* Force console to hvc for now until we have sorted out the
> +	 * real console situation for the platform. This will make
> +	 * hvc_udbg work at least.
> +	 */
> +	add_preferred_console("hvc", 0, NULL);
> +
> +	/* Initialize SMP */
> +	pnv_smp_init();
> +
> +	/* XXX PCI */
> +
> +	/* XXX NVRAM */
> +
> +	/* Enable NAP mode */
> +	powersave_nap = 1;
> +
> +	/* XXX PMCS */
> +}
> +
> +static void __init pnv_init_early(void)
> +{
> +	/* XXX IOMMU */
> +}
> +
> +static void __init pnv_init_IRQ(void)
> +{
> +	xics_init();
> +
> +	WARN_ON(!ppc_md.get_irq);
> +}
> +
> +static void pnv_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node *root;
> +	const char *model = "";
> +
> +	root = of_find_node_by_path("/");
> +	if (root)
> +		model = of_get_property(root, "model", NULL);
> +	seq_printf(m, "machine\t\t: PowerNV %s\n", model);
> +	of_node_put(root);
> +}
> +
> +static void pnv_restart(char *cmd)
> +{
> +	for (;;);
> +}
> +
> +static void pnv_power_off(void)
> +{
> +	for (;;);
> +}
> +
> +static void pnv_halt(void)
> +{
> +	for (;;);
> +}
> +
> +static unsigned long __init pnv_get_boot_time(void)
> +{
> +	return 0;
> +}
> +
> +static void pnv_get_rtc_time(struct rtc_time *rtc_tm)
> +{
> +}
> +
> +static int pnv_set_rtc_time(struct rtc_time *tm)
> +{
> +	return 0;
> +}
> +
> +static void pnv_progress(char *s, unsigned short hex)
> +{
> +}
> +
> +#ifdef CONFIG_KEXEC
> +static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
> +{
> +	xics_kexec_teardown_cpu(secondary);
> +}
> +#endif /* CONFIG_KEXEC */
> +
> +static int __init pnv_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "ibm,powernv"))
> +		return 0;
> +
> +	hpte_init_native();
> +
> +	pr_debug("PowerNV detected !\n");
> +
> +	return 1;
> +}
> +
> +define_machine(powernv) {
> +	.name			= "PowerNV",
> +	.probe			= pnv_probe,
> +	.setup_arch		= pnv_setup_arch,
> +	.init_early		= pnv_init_early,
> +	.init_IRQ		= pnv_init_IRQ,
> +	.show_cpuinfo		= pnv_show_cpuinfo,
> +	.restart		= pnv_restart,
> +	.power_off		= pnv_power_off,
> +	.halt			= pnv_halt,
> +	.get_boot_time		= pnv_get_boot_time,
> +	.get_rtc_time		= pnv_get_rtc_time,
> +	.set_rtc_time		= pnv_set_rtc_time,
> +	.progress		= pnv_progress,
> +	.power_save             = power7_idle,
> +	.calibrate_decr		= generic_calibrate_decr,
> +#ifdef CONFIG_KEXEC
> +	.kexec_cpu_down		= pnv_kexec_cpu_down,
> +#endif
> +};
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/po
wernv/smp.c
> new file mode 100644
> index 0000000..36c7151
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -0,0 +1,83 @@
> +/*
> + * SMP support for PowerNV machines.
> + *
> + * Copyright 2011 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/smp.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/cpu.h>
> +
> +#include <asm/irq.h>
> +#include <asm/smp.h>
> +#include <asm/paca.h>
> +#include <asm/machdep.h>
> +#include <asm/cputable.h>
> +#include <asm/firmware.h>
> +#include <asm/system.h>
> +#include <asm/rtas.h>
> +#include <asm/vdso_datapage.h>
> +#include <asm/cputhreads.h>
> +#include <asm/xics.h>
> +
> +#include "powernv.h"
> +
> +static void __devinit pnv_smp_setup_cpu(int cpu)
> +{
> +	if (cpu != boot_cpuid)
> +		xics_setup_cpu();
> +}
> +
> +static int pnv_smp_cpu_bootable(unsigned int nr)
> +{
> +	/* Special case - we inhibit secondary thread startup
> +	 * during boot if the user requests it.
> +	 */
> +	if (system_state < SYSTEM_RUNNING && cpu_has_feature(CPU_FTR_SMT)) {
> +		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
> +			return 0;
> +		if (smt_enabled_at_boot
> +		    && cpu_thread_in_core(nr) >= smt_enabled_at_boot)
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static struct smp_ops_t pnv_smp_ops = {
> +	.message_pass	= smp_muxed_ipi_message_pass,
> +	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
> +	.probe		= xics_smp_probe,
> +	.kick_cpu	= smp_generic_kick_cpu,
> +	.setup_cpu	= pnv_smp_setup_cpu,
> +	.cpu_bootable	= pnv_smp_cpu_bootable,
> +};
> +
> +/* This is called very early during platform setup_arch */
> +void __init pnv_smp_init(void)
> +{
> +	smp_ops = &pnv_smp_ops;
> +
> +	/* XXX We don't yet have a proper entry point from HAL, for
> +	 * now we rely on kexec-style entry from BML
> +	 */
> +
> +#ifdef CONFIG_PPC_RTAS
> +	/* Non-lpar has additional take/give timebase */
> +	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
> +		smp_ops->give_timebase = rtas_give_timebase;
> +		smp_ops->take_timebase = rtas_take_timebase;
> +	}
> +#endif /* CONFIG_PPC_RTAS */
> +}
> -- 
> 1.7.4.1
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
