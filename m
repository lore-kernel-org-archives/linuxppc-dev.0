Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 960661007D5
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 11:56:53 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH RFC] ppc: fix default_machine_crash_shutdown #ifdef botch
In-reply-to: <20100616004839.GA18110@linux.vnet.ibm.com>
References: <20100616004839.GA18110@linux.vnet.ibm.com>
Date: Thu, 17 Jun 2010 11:56:53 +1000
Message-ID: <6286.1276739813@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <20100616004839.GA18110@linux.vnet.ibm.com> you wrote:
> crash_kexec_wait_realmode() is defined only if CONFIG_PPC_STD_MMU_64
> and CONFIG_SMP, but is called if CONFIG_PPC_STD_MMU_64 even if !CONFIG_SMP.
> Fix the conditional compilation around the invocation.
> 
> Untested, probably does not compile.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

This should be right since we don't need to wait for the other CPUs if
there are no others... 

Compiles for me and even fixes the SMP=N case.  Thanks!

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
> 
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index b46f2e0..29df48f 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -447,7 +447,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
>  	crash_kexec_prepare_cpus(crashing_cpu);
>  	cpu_set(crashing_cpu, cpus_in_crash);
>  	crash_kexec_stop_spus();
> -#ifdef CONFIG_PPC_STD_MMU_64
> +#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
>  	crash_kexec_wait_realmode(crashing_cpu);
>  #endif
>  	if (ppc_md.kexec_cpu_down)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
