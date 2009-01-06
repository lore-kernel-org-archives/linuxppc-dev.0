Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by ozlabs.org (Postfix) with ESMTP id 697C7DE059
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 11:47:50 +1100 (EST)
Received: by gxk9 with SMTP id 9so1964466gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Jan 2009 16:47:48 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <4962AA31.6020408@genesi-usa.com>
Date: Mon, 05 Jan 2009 18:47:45 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: use common cpu_die
References: <1231160724_126472@mercury.realtime.net>
In-Reply-To: <1231160724_126472@mercury.realtime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton you're amazing <3

This is going to take a while to test. I have to build a new source rpm 
and push it to Peter, who is doing some work and I need him to have 
working config the same as mine. I am build testing the patch in 
parallel here.. maybe I will have a kernel tonight or maybe tomorrow.

We have to do a run test on Pegasos and Efika and MPC8610 as well as the 
dual core, and I will be busy at University tomorrow anyway poking 
around with an analyzer..

What's your preferred, easiest way to test a system being put into a 
sleep mode? I was planning on echo mem >/sys/power/state.

My fear is basically, that even if the system successfully goes in, 
whether I will be able to get it back out again.

I've never bothered to even check it works because my last experience 
with it on my EPIA and Pegasos has been, it never unsleeps, or it oopses 
the kernel like crazy rather than sleeping (or comes out and locks 
up..). I gather this is what we don't want to see.. but how do I tell if 
it's broken as usual, or broken from this? :D

-- Matt

Milton Miller wrote:
> Configuring a powerpc 32 bit kernel for both SMP and SUSPEND turns on
> CPU_HOTPLUG to enable disable_nonboot_cpus to be called by the common
> suspend code.  Previously the definition of cpu_die for ppc32 was in
> the powermac platform code, causing it to be undefined if that platform
> as not selected.
> 
> Move the code from setup_64 to smp.c and rename the power mac
> versions to their specific names.
> 
> Note that this does not setup the cpu_die pointers in either
> smp_ops (request a given cpu die) or ppc_md (make this cpu die),
> for other platforms but there are generic versions in smp.c.
> 
> Reported-By: Matt Sealey
> Signed-off-by: Milton Miller <miltonm@bga.com>
> ---
> compile tested on Matt's 2.6.27.7 config, both as given and with POWERMAC
> rediffed to linus git, applies with offset to 2.6.27.7
> 
> Matt please test ... especially sleep on a smp machine
> 
> 
> Index: work.git/arch/powerpc/kernel/setup_64.c
> ===================================================================
> --- work.git.orig/arch/powerpc/kernel/setup_64.c	2009-01-05 02:09:08.000000000 -0600
> +++ work.git/arch/powerpc/kernel/setup_64.c	2009-01-05 02:27:23.000000000 -0600
> @@ -585,12 +585,6 @@ void ppc64_terminate_msg(unsigned int sr
>  	printk("[terminate]%04x %s\n", src, msg);
>  }
>  
> -void cpu_die(void)
> -{
> -	if (ppc_md.cpu_die)
> -		ppc_md.cpu_die();
> -}
> -
>  #ifdef CONFIG_SMP
>  void __init setup_per_cpu_areas(void)
>  {
> Index: work.git/arch/powerpc/kernel/smp.c
> ===================================================================
> --- work.git.orig/arch/powerpc/kernel/smp.c	2009-01-05 02:09:08.000000000 -0600
> +++ work.git/arch/powerpc/kernel/smp.c	2009-01-05 02:27:23.000000000 -0600
> @@ -612,4 +612,10 @@ void __cpu_die(unsigned int cpu)
>  	if (smp_ops->cpu_die)
>  		smp_ops->cpu_die(cpu);
>  }
> +
> +void cpu_die(void)
> +{
> +	if (ppc_md.cpu_die)
> +		ppc_md.cpu_die();
> +}
>  #endif
> Index: work.git/arch/powerpc/platforms/powermac/pmac.h
> ===================================================================
> --- work.git.orig/arch/powerpc/platforms/powermac/pmac.h	2009-01-05 02:09:08.000000000 -0600
> +++ work.git/arch/powerpc/platforms/powermac/pmac.h	2009-01-05 02:27:23.000000000 -0600
> @@ -33,6 +33,9 @@ extern void pmac_setup_pci_dma(void);
>  extern void pmac_check_ht_link(void);
>  
>  extern void pmac_setup_smp(void);
> +extern void pmac32_cpu_die(void);
> +extern void low_cpu_die(void) __attribute__((noreturn));
> +
>  
>  extern int pmac_nvram_init(void);
>  extern void pmac_pic_init(void);
> Index: work.git/arch/powerpc/platforms/powermac/setup.c
> ===================================================================
> --- work.git.orig/arch/powerpc/platforms/powermac/setup.c	2009-01-05 02:09:08.000000000 -0600
> +++ work.git/arch/powerpc/platforms/powermac/setup.c	2009-01-05 02:27:23.000000000 -0600
> @@ -672,7 +672,7 @@ static int pmac_pci_probe_mode(struct pc
>  /* access per cpu vars from generic smp.c */
>  DECLARE_PER_CPU(int, cpu_state);
>  
> -static void pmac_cpu_die(void)
> +static void pmac64_cpu_die(void)
>  {
>  	/*
>  	 * turn off as much as possible, we'll be
> @@ -743,7 +743,12 @@ define_machine(powermac) {
>  	.pcibios_after_init	= pmac_pcibios_after_init,
>  	.phys_mem_access_prot	= pci_phys_mem_access_prot,
>  #endif
> -#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
> -	.cpu_die		= pmac_cpu_die,
> +#ifdef CONFIG_HOTPLUG_CPU
> +#ifdef CONFIG_PPC64
> +	.cpu_die		= pmac64_cpu_die,
> +#endif
> +#ifdef CONFIG_PPC32
> +	.cpu_die		= pmac32_cpu_die,
> +#endif
>  #endif
>  };
> Index: work.git/arch/powerpc/platforms/powermac/smp.c
> ===================================================================
> --- work.git.orig/arch/powerpc/platforms/powermac/smp.c	2009-01-05 02:09:08.000000000 -0600
> +++ work.git/arch/powerpc/platforms/powermac/smp.c	2009-01-05 02:27:23.000000000 -0600
> @@ -53,6 +53,8 @@
>  #include <asm/pmac_low_i2c.h>
>  #include <asm/pmac_pfunc.h>
>  
> +#include "pmac.h"
> +
>  #define DEBUG
>  
>  #ifdef DEBUG
> @@ -872,10 +874,9 @@ int smp_core99_cpu_disable(void)
>  	return 0;
>  }
>  
> -extern void low_cpu_die(void) __attribute__((noreturn)); /* in sleep.S */
>  static int cpu_dead[NR_CPUS];
>  
> -void cpu_die(void)
> +void pmac32_cpu_die(void)
>  {
>  	local_irq_disable();
>  	cpu_dead[smp_processor_id()] = 1;
