Return-Path: <matt@ozlabs.org>
Message-ID: <4C58A26E.7030109@ozlabs.org>
Date: Wed, 04 Aug 2010 09:12:46 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/kdump: Stop all other CPUs before running crash
	handlers
References: <20100803063941.GM29316@kryten>
In-Reply-To: <20100803063941.GM29316@kryten>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> During kdump we run the crash handlers first then stop all other CPUs.
> We really want to stop all CPUs as close to the fail as possible and also
> have a very controlled environment for running the crash handlers, so it
> makes sense to reverse the order.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Looks like a sensible idea!

Acked-by: Matt Evans <matt@ozlabs.org>

> ---
> 
> Index: powerpc.git/arch/powerpc/kernel/crash.c
> ===================================================================
> --- powerpc.git.orig/arch/powerpc/kernel/crash.c	2010-07-15 20:49:39.941991306 +1000
> +++ powerpc.git/arch/powerpc/kernel/crash.c	2010-08-03 16:36:08.451991018 +1000
> @@ -402,6 +402,18 @@ void default_machine_crash_shutdown(stru
>  	 */
>  	hard_irq_disable();
>  
> +	/*
> +	 * Make a note of crashing cpu. Will be used in machine_kexec
> +	 * such that another IPI will not be sent.
> +	 */
> +	crashing_cpu = smp_processor_id();
> +	crash_save_cpu(regs, crashing_cpu);
> +	crash_kexec_prepare_cpus(crashing_cpu);
> +	cpu_set(crashing_cpu, cpus_in_crash);
> +#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
> +	crash_kexec_wait_realmode(crashing_cpu);
> +#endif
> +
>  	for_each_irq(i) {
>  		struct irq_desc *desc = irq_to_desc(i);
>  
> @@ -438,18 +450,8 @@ void default_machine_crash_shutdown(stru
>  	crash_shutdown_cpu = -1;
>  	__debugger_fault_handler = old_handler;
>  
> -	/*
> -	 * Make a note of crashing cpu. Will be used in machine_kexec
> -	 * such that another IPI will not be sent.
> -	 */
> -	crashing_cpu = smp_processor_id();
> -	crash_save_cpu(regs, crashing_cpu);
> -	crash_kexec_prepare_cpus(crashing_cpu);
> -	cpu_set(crashing_cpu, cpus_in_crash);
>  	crash_kexec_stop_spus();
> -#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
> -	crash_kexec_wait_realmode(crashing_cpu);
> -#endif
> +
>  	if (ppc_md.kexec_cpu_down)
>  		ppc_md.kexec_cpu_down(1, 0);
>  }
