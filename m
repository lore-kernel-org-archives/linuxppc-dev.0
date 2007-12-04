Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/7] powerpc: Replace ppc_md.power_off with pm_power_off
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20071204054821.GF27862@mag.az.mvista.com>
References: <20071204053736.GA27862@mag.az.mvista.com>
	<20071204054821.GF27862@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 18:23:09 +1100
Message-Id: <1196752989.13230.265.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-03 at 22:48 -0700, Mark A. Greer wrote:
> From: Mark A. Greer <mgreer@mvista.com>
> 
> The ppc_md.power_off hook performs the same function that the
> pm_power_off hook is supposed to.  However, it is powerpc-specific
> and prevents kernel drivers (e.g., IPMI) from changing how a platform
> is powered off.  So, get rid of ppc_md.power_off and replace it with
> pm_power_off.

I'm less happy with that one... probably aesthetics :-)

Can't we just have the generic code call pm_power_off and ppc_md and
which ever powers the machine off wins ?

> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> ---
>  arch/powerpc/kernel/setup-common.c               |   14 +--
>  arch/powerpc/platforms/52xx/efika.c              |    2 
>  arch/powerpc/platforms/cell/setup.c              |    2 
>  arch/powerpc/platforms/celleb/setup.c            |    2 
>  arch/powerpc/platforms/chrp/setup.c              |    2 
>  arch/powerpc/platforms/embedded6xx/linkstation.c |    3 
>  arch/powerpc/platforms/iseries/setup.c           |    2 
>  arch/powerpc/platforms/maple/setup.c             |    4 
>  arch/powerpc/platforms/powermac/setup.c          |    2 
>  arch/powerpc/platforms/ps3/setup.c               |    2 
>  arch/powerpc/platforms/pseries/setup.c           |   59 ++++++-------
>  include/asm-powerpc/machdep.h                    |    1 
>  12 files changed, 48 insertions(+), 47 deletions(-)
> 
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 1f8f9aa..d9f2e07 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -76,6 +76,9 @@ EXPORT_SYMBOL(ppc_md);
>  struct machdep_calls *machine_id;
>  EXPORT_SYMBOL(machine_id);
>  
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL_GPL(pm_power_off);
> +
>  unsigned long klimit = (unsigned long) _end;
>  
>  char cmd_line[COMMAND_LINE_SIZE];
> @@ -127,8 +130,8 @@ void machine_restart(char *cmd)
>  void machine_power_off(void)
>  {
>  	machine_shutdown();
> -	if (ppc_md.power_off)
> -		ppc_md.power_off();
> +	if (pm_power_off)
> +		pm_power_off();
>  	printk(KERN_EMERG "System not powered off; halting instead.\n");
>  	if (ppc_md.halt)
>  		ppc_md.halt();
> @@ -137,17 +140,14 @@ void machine_power_off(void)
>  /* Used by the G5 thermal driver */
>  EXPORT_SYMBOL_GPL(machine_power_off);
>  
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL_GPL(pm_power_off);
> -
>  void machine_halt(void)
>  {
>  	machine_shutdown();
>  	if (ppc_md.halt)
>  		ppc_md.halt();
> -	if (ppc_md.power_off) {
> +	if (pm_power_off) {
>  		printk(KERN_EMERG "System not halted; powering off instead.\n");
> -		ppc_md.power_off();
> +		pm_power_off();
>  		printk(KERN_EMERG "Poweroff failed.\n");
>  	}
>  	default_halt("OK to turn off power\n");
> diff --git a/arch/powerpc/platforms/52xx/efika.c b/arch/powerpc/platforms/52xx/efika.c
> index a0da70c..c2d5f06 100644
> --- a/arch/powerpc/platforms/52xx/efika.c
> +++ b/arch/powerpc/platforms/52xx/efika.c
> @@ -205,6 +205,7 @@ static int __init efika_probe(void)
>  	DMA_MODE_READ = 0x44;
>  	DMA_MODE_WRITE = 0x48;
>  
> +	pm_power_off = rtas_power_off;
>  	return 1;
>  }
>  
> @@ -218,7 +219,6 @@ define_machine(efika)
>  	.init_IRQ		= mpc52xx_init_irq,
>  	.get_irq		= mpc52xx_get_irq,
>  	.restart		= rtas_restart,
> -	.power_off		= rtas_power_off,
>  	.halt			= rtas_halt,
>  	.set_rtc_time		= rtas_set_rtc_time,
>  	.get_rtc_time		= rtas_get_rtc_time,
> diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
> index 98e7ef8..06f44f5 100644
> --- a/arch/powerpc/platforms/cell/setup.c
> +++ b/arch/powerpc/platforms/cell/setup.c
> @@ -191,6 +191,7 @@ static int __init cell_probe(void)
>  		return 0;
>  
>  	hpte_init_native();
> +	pm_power_off = rtas_power_off;
>  
>  	return 1;
>  }
> @@ -201,7 +202,6 @@ define_machine(cell) {
>  	.setup_arch		= cell_setup_arch,
>  	.show_cpuinfo		= cell_show_cpuinfo,
>  	.restart		= rtas_restart,
> -	.power_off		= rtas_power_off,
>  	.halt			= rtas_halt,
>  	.get_boot_time		= rtas_get_boot_time,
>  	.get_rtc_time		= rtas_get_rtc_time,
> diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
> index ddfb35a..450841a 100644
> --- a/arch/powerpc/platforms/celleb/setup.c
> +++ b/arch/powerpc/platforms/celleb/setup.c
> @@ -116,6 +116,7 @@ static int __init celleb_probe(void)
>  
>  	powerpc_firmware_features |= FW_FEATURE_CELLEB_POSSIBLE;
>  	hpte_init_beat_v3();
> +	pm_power_off = beat_power_off;
>  	return 1;
>  }
>  
> @@ -145,7 +146,6 @@ define_machine(celleb) {
>  	.setup_arch		= celleb_setup_arch,
>  	.show_cpuinfo		= celleb_show_cpuinfo,
>  	.restart		= beat_restart,
> -	.power_off		= beat_power_off,
>  	.halt			= beat_halt,
>  	.get_rtc_time		= beat_get_rtc_time,
>  	.set_rtc_time		= beat_set_rtc_time,
> diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
> index 5930626..99edb04 100644
> --- a/arch/powerpc/platforms/chrp/setup.c
> +++ b/arch/powerpc/platforms/chrp/setup.c
> @@ -586,6 +586,7 @@ static int __init chrp_probe(void)
>  	DMA_MODE_READ = 0x44;
>  	DMA_MODE_WRITE = 0x48;
>  
> +	pm_power_off = rtas_power_off;
>  	return 1;
>  }
>  
> @@ -597,7 +598,6 @@ define_machine(chrp) {
>  	.show_cpuinfo		= chrp_show_cpuinfo,
>  	.init_IRQ		= chrp_init_IRQ,
>  	.restart		= rtas_restart,
> -	.power_off		= rtas_power_off,
>  	.halt			= rtas_halt,
>  	.time_init		= chrp_time_init,
>  	.set_rtc_time		= chrp_set_rtc_time,
> diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
> index eb5d74e..8792840 100644
> --- a/arch/powerpc/platforms/embedded6xx/linkstation.c
> +++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
> @@ -182,6 +182,8 @@ static int __init linkstation_probe(void)
>  
>  	if (!of_flat_dt_is_compatible(root, "linkstation"))
>  		return 0;
> +
> +	pm_power_off = linkstation_power_off;
>  	return 1;
>  }
>  
> @@ -193,7 +195,6 @@ define_machine(linkstation){
>  	.show_cpuinfo 		= linkstation_show_cpuinfo,
>  	.get_irq 		= mpic_get_irq,
>  	.restart 		= linkstation_restart,
> -	.power_off 		= linkstation_power_off,
>  	.halt	 		= linkstation_halt,
>  	.calibrate_decr 	= generic_calibrate_decr,
>  };
> diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
> index 2175a71..6051204 100644
> --- a/arch/powerpc/platforms/iseries/setup.c
> +++ b/arch/powerpc/platforms/iseries/setup.c
> @@ -633,6 +633,7 @@ static int __init iseries_probe(void)
>  	/* iSeries does not support 16M pages */
>  	cur_cpu_spec->cpu_features &= ~CPU_FTR_16M_PAGE;
>  
> +	pm_power_off = mf_power_off;
>  	return 1;
>  }
>  
> @@ -645,7 +646,6 @@ define_machine(iseries) {
>  	.init_early	= iSeries_init_early,
>  	.pcibios_fixup	= iSeries_pci_final_fixup,
>  	.restart	= mf_reboot,
> -	.power_off	= mf_power_off,
>  	.halt		= mf_power_off,
>  	.get_boot_time	= iSeries_get_boot_time,
>  	.set_rtc_time	= iSeries_set_rtc_time,
> diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
> index 144177d..d0eb901 100644
> --- a/arch/powerpc/platforms/maple/setup.c
> +++ b/arch/powerpc/platforms/maple/setup.c
> @@ -172,7 +172,7 @@ static void __init maple_use_rtas_reboot_and_halt_if_present(void)
>  	if (rtas_service_present("system-reboot") &&
>  	    rtas_service_present("power-off")) {
>  		ppc_md.restart = rtas_restart;
> -		ppc_md.power_off = rtas_power_off;
> +		pm_power_off = rtas_power_off;
>  		ppc_md.halt = rtas_halt;
>  	}
>  }
> @@ -315,6 +315,7 @@ static int __init maple_probe(void)
>  	alloc_dart_table();
>  
>  	hpte_init_native();
> +	pm_power_off = maple_power_off;
>  
>  	return 1;
>  }
> @@ -328,7 +329,6 @@ define_machine(maple_md) {
>  	.pci_irq_fixup		= maple_pci_irq_fixup,
>  	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
>  	.restart		= maple_restart,
> -	.power_off		= maple_power_off,
>  	.halt			= maple_halt,
>         	.get_boot_time		= maple_get_boot_time,
>         	.set_rtc_time		= maple_set_rtc_time,
> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
> index 02c5330..8429002 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -577,6 +577,7 @@ static int __init pmac_probe(void)
>  
>  	hpte_init_native();
>  #endif
> +	pm_power_off = pmac_power_off;
>  
>  #ifdef CONFIG_PPC32
>  	/* isa_io_base gets set in pmac_pci_init */
> @@ -676,7 +677,6 @@ define_machine(powermac) {
>  	.get_irq		= NULL,	/* changed later */
>  	.pci_irq_fixup		= pmac_pci_irq_fixup,
>  	.restart		= pmac_restart,
> -	.power_off		= pmac_power_off,
>  	.halt			= pmac_halt,
>  	.time_init		= pmac_time_init,
>  	.get_boot_time		= pmac_get_boot_time,
> diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
> index 5c2cbb0..74942d8 100644
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -233,6 +233,7 @@ static int __init ps3_probe(void)
>  	ps3_mm_init();
>  	ps3_mm_vas_create(&htab_size);
>  	ps3_hpte_init(htab_size);
> +	pm_power_off = ps3_power_off;
>  
>  	DBG(" <- %s:%d\n", __func__, __LINE__);
>  	return 1;
> @@ -265,7 +266,6 @@ define_machine(ps3) {
>  	.calibrate_decr			= ps3_calibrate_decr,
>  	.progress			= ps3_progress,
>  	.restart			= ps3_restart,
> -	.power_off			= ps3_power_off,
>  #if defined(CONFIG_KEXEC)
>  	.kexec_cpu_down			= ps3_kexec_cpu_down,
>  	.machine_kexec			= default_machine_kexec,
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index fdb9b1c..51ef84c 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -353,6 +353,34 @@ static int __init pSeries_probe_hypertas(unsigned long node,
>  	return 1;
>  }
>  
> +/**
> + * pSeries_power_off - tell firmware about how to power off the system.
> + *
> + * This function calls either the power-off rtas token in normal cases
> + * or the ibm,power-off-ups token (if present & requested) in case of
> + * a power failure. If power-off token is used, power on will only be
> + * possible with power button press. If ibm,power-off-ups token is used
> + * it will allow auto poweron after power is restored.
> + */
> +void pSeries_power_off(void)
> +{
> +	int rc;
> +	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
> +
> +	if (rtas_flash_term_hook)
> +		rtas_flash_term_hook(SYS_POWER_OFF);
> +
> +	if (rtas_poweron_auto == 0 ||
> +		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
> +		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
> +		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
> +	} else {
> +		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
> +		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
> +	}
> +	for (;;);
> +}
> +
>  static int __init pSeries_probe(void)
>  {
>  	unsigned long root = of_get_flat_dt_root();
> @@ -380,6 +408,8 @@ static int __init pSeries_probe(void)
>  	else
>  		hpte_init_native();
>  
> +	pm_power_off = pSeries_power_off;
> +
>  	DBG("Machine is%s LPAR !\n",
>  	    (powerpc_firmware_features & FW_FEATURE_LPAR) ? "" : " not");
>  
> @@ -463,34 +493,6 @@ static int pSeries_pci_probe_mode(struct pci_bus *bus)
>  	return PCI_PROBE_NORMAL;
>  }
>  
> -/**
> - * pSeries_power_off - tell firmware about how to power off the system.
> - *
> - * This function calls either the power-off rtas token in normal cases
> - * or the ibm,power-off-ups token (if present & requested) in case of
> - * a power failure. If power-off token is used, power on will only be
> - * possible with power button press. If ibm,power-off-ups token is used
> - * it will allow auto poweron after power is restored.
> - */
> -void pSeries_power_off(void)
> -{
> -	int rc;
> -	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
> -
> -	if (rtas_flash_term_hook)
> -		rtas_flash_term_hook(SYS_POWER_OFF);
> -
> -	if (rtas_poweron_auto == 0 ||
> -		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
> -		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
> -		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
> -	} else {
> -		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
> -		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
> -	}
> -	for (;;);
> -}
> -
>  #ifndef CONFIG_PCI
>  void pSeries_final_fixup(void) { }
>  #endif
> @@ -505,7 +507,6 @@ define_machine(pseries) {
>  	.pcibios_fixup		= pSeries_final_fixup,
>  	.pci_probe_mode		= pSeries_pci_probe_mode,
>  	.restart		= rtas_restart,
> -	.power_off		= pSeries_power_off,
>  	.halt			= rtas_halt,
>  	.panic			= rtas_os_term,
>  	.get_boot_time		= rtas_get_boot_time,
> diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
> index 6968f43..bca57bc 100644
> --- a/include/asm-powerpc/machdep.h
> +++ b/include/asm-powerpc/machdep.h
> @@ -129,7 +129,6 @@ struct machdep_calls {
>  #endif
>  
>  	void		(*restart)(char *cmd);
> -	void		(*power_off)(void);
>  	void		(*halt)(void);
>  	void		(*panic)(char *str);
>  	void		(*cpu_die)(void);
