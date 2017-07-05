Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2S9S1W94zDr1p
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 14:11:23 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v6549OQA073833
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 00:11:21 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bg6gebu99-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 00:11:21 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 14:11:18 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v654BFFO8913198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 14:11:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v654BDpH024722
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 14:11:13 +1000
Subject: Re: [PATCH v2 1/3] powerpc: do not call ppc_md.panic in fadump panic
 notifier
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170705035627.19563-1-npiggin@gmail.com>
 <20170705035627.19563-2-npiggin@gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 5 Jul 2017 09:41:12 +0530
MIME-Version: 1.0
In-Reply-To: <20170705035627.19563-2-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5f5af496-ba37-6a24-7aeb-0c3947820fa7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2017 09:26 AM, Nicholas Piggin wrote:
> If fadump is not registered, and no other crash or debug handlers are
> registered, the powerpc panic handler stops the guest before the generic
> panic code can push out debug information to the console.
> 
> Currently, system reset injection causes the guest to silently
> stop.
> 
> Stop calling ppc_md.panic in the panic notifier. crash_fadump already
> does rtas_os_term() to terminate the guest if fadump is registered.
> 
> Remove ppc_md.panic. Move fadump panic notifier into fadump code.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.

> ---
>  arch/powerpc/include/asm/machdep.h     |  1 -
>  arch/powerpc/include/asm/setup.h       |  1 -
>  arch/powerpc/kernel/fadump.c           | 22 ++++++++++++++++++++++
>  arch/powerpc/kernel/setup-common.c     | 27 ---------------------------
>  arch/powerpc/platforms/ps3/setup.c     | 15 ---------------
>  arch/powerpc/platforms/pseries/setup.c |  1 -
>  6 files changed, 22 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
> index cd2fc1cc1cc7..73b92017b6d7 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -76,7 +76,6 @@ struct machdep_calls {
> 
>  	void __noreturn	(*restart)(char *cmd);
>  	void __noreturn (*halt)(void);
> -	void		(*panic)(char *str);
>  	void		(*cpu_die)(void);
> 
>  	long		(*time_init)(void); /* Optional, may be NULL */
> diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
> index 654d64c9f3ac..3a3fb0ca68f5 100644
> --- a/arch/powerpc/include/asm/setup.h
> +++ b/arch/powerpc/include/asm/setup.h
> @@ -23,7 +23,6 @@ extern void reloc_got2(unsigned long);
> 
>  void check_for_initrd(void);
>  void initmem_init(void);
> -void setup_panic(void);
>  #define ARCH_PANIC_TIMEOUT 180
> 
>  #ifdef CONFIG_PPC_PSERIES
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 3079518f2245..8f1a8bd8433c 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1447,6 +1447,25 @@ static void fadump_init_files(void)
>  	return;
>  }
> 
> +static int fadump_panic_event(struct notifier_block *this,
> +                             unsigned long event, void *ptr)
> +{
> +	/*
> +	 * If firmware-assisted dump has been registered then trigger
> +	 * firmware-assisted dump and let firmware handle everything
> +	 * else. If this returns, then fadump was not registered, so
> +	 * go through the rest of the panic path.
> +	 */
> +	crash_fadump(NULL, ptr);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block fadump_panic_block = {
> +	.notifier_call = fadump_panic_event,
> +	.priority = INT_MIN /* may not return; must be done last */
> +};
> +
>  /*
>   * Prepare for firmware-assisted dump.
>   */
> @@ -1479,6 +1498,9 @@ int __init setup_fadump(void)
>  		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
>  	fadump_init_files();
> 
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +					&fadump_panic_block);
> +
>  	return 1;
>  }
>  subsys_initcall(setup_fadump);
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 94a948207cd2..b697530d9bdc 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -704,30 +704,6 @@ int check_legacy_ioport(unsigned long base_port)
>  }
>  EXPORT_SYMBOL(check_legacy_ioport);
> 
> -static int ppc_panic_event(struct notifier_block *this,
> -                             unsigned long event, void *ptr)
> -{
> -	/*
> -	 * If firmware-assisted dump has been registered then trigger
> -	 * firmware-assisted dump and let firmware handle everything else.
> -	 */
> -	crash_fadump(NULL, ptr);
> -	ppc_md.panic(ptr);  /* May not return */
> -	return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block ppc_panic_block = {
> -	.notifier_call = ppc_panic_event,
> -	.priority = INT_MIN /* may not return; must be done last */
> -};
> -
> -void __init setup_panic(void)
> -{
> -	if (!ppc_md.panic)
> -		return;
> -	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
> -}
> -
>  #ifdef CONFIG_CHECK_CACHE_COHERENCY
>  /*
>   * For platforms that have configurable cache-coherency.  This function
> @@ -872,9 +848,6 @@ void __init setup_arch(char **cmdline_p)
>  	/* Probe the machine type, establish ppc_md. */
>  	probe_machine();
> 
> -	/* Setup panic notifier if requested by the platform. */
> -	setup_panic();
> -
>  	/*
>  	 * Configure ppc_md.power_save (ppc32 only, 64-bit machines do
>  	 * it from their respective probe() function.
> diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
> index 6244bc849469..9dabea6e1443 100644
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -104,20 +104,6 @@ static void __noreturn ps3_halt(void)
>  	ps3_sys_manager_halt(); /* never returns */
>  }
> 
> -static void ps3_panic(char *str)
> -{
> -	DBG("%s:%d %s\n", __func__, __LINE__, str);
> -
> -	smp_send_stop();
> -	printk("\n");
> -	printk("   System does not reboot automatically.\n");
> -	printk("   Please press POWER button.\n");
> -	printk("\n");
> -
> -	while(1)
> -		lv1_pause(1);
> -}
> -
>  #if defined(CONFIG_FB_PS3) || defined(CONFIG_FB_PS3_MODULE) || \
>      defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
>  static void __init prealloc(struct ps3_prealloc *p)
> @@ -269,7 +255,6 @@ define_machine(ps3) {
>  	.probe				= ps3_probe,
>  	.setup_arch			= ps3_setup_arch,
>  	.init_IRQ			= ps3_init_IRQ,
> -	.panic				= ps3_panic,
>  	.get_boot_time			= ps3_get_boot_time,
>  	.set_dabr			= ps3_set_dabr,
>  	.calibrate_decr			= ps3_calibrate_decr,
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index b5d86426e97b..b5b650910cf5 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -722,7 +722,6 @@ define_machine(pseries) {
>  	.pcibios_fixup		= pSeries_final_fixup,
>  	.restart		= rtas_restart,
>  	.halt			= rtas_halt,
> -	.panic			= rtas_os_term,
>  	.get_boot_time		= rtas_get_boot_time,
>  	.get_rtc_time		= rtas_get_rtc_time,
>  	.set_rtc_time		= rtas_set_rtc_time,
> 
