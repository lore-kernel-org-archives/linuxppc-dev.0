Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqBxC3THTzDsFM
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Dec 2017 13:37:19 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id f12so6118735pgo.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Dec 2017 18:37:18 -0800 (PST)
Date: Sun, 3 Dec 2017 12:36:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [rfc] powernv/kdump: Fix cases where the kdump kernel can get
 HMI's
Message-ID: <20171203123658.056226c1@roar.ozlabs.ibm.com>
In-Reply-To: <20171202134808.27480-1-bsingharora@gmail.com>
References: <20171202134808.27480-1-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Seems like a reasonable approach. Why do we only do this for
powernv? It seems like a good idea in general to pull all
offlined CPUs out and into the same state for all platforms
and for all shutdown/restart/crash paths.

Also I wonder if there is anything we should do on the other
side of the equation for the kdump kernel to pull CPUs into a
known state rather than rely on the crash kernel to do it for
us. We might have a better ability to do that with system
reset IPIs now.

We still need to support platforms without NMI IPIs, so we
still need this patch as well.

Thanks,
Nick

On Sun,  3 Dec 2017 00:48:08 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> Certain HMI's such as malfunction error propagate through
> all threads/core on the system. If a thread was offline
> prior to us crashing the system and jumping to the kdump
> kernel, bad things happen when it wakes up due to an HMI
> in the kdump kernel.
> 
> There are several possible ways to solve this problem
> 
> 1. Put the offline cores in a state such that they are
> not woken up for machine check and HMI errors. This
> does not work, since we might need to wake up offline
> threads occasionally to handle TB errors
> 2. Ignore HMI errors, setup HMEER to mask HMI errors,
> but this still leads the window open for any MCEs
> and masking them for the duration of the dump might
> be a concern
> 3. Wake up offline CPUs, as in send them to crash_ipi_callback
> (not wake them up as in mark them online as seen by
> the scheduler). kexec does a wake_online_cpus() call,
> this patch does something similar, but instead sends
> an IPI and forces them to crash_ipi_callback
> 
> Care is taken to enable this only for powenv platforms
> via crash_wake_offline (a global value set at setup
> time). The crash code sends out IPI's to all CPU's
> which then move to crash_ipi_callback and kexec_smp_wait().
> We don't grab the pt_regs for offline CPU's.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/include/asm/kexec.h     |  2 ++
>  arch/powerpc/kernel/crash.c          | 18 +++++++++++++-----
>  arch/powerpc/kernel/smp.c            | 11 ++++++++---
>  arch/powerpc/platforms/powernv/smp.c | 23 +++++++++++++++++++----
>  4 files changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 4419d435639a..9dcbfa6bbb91 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -73,6 +73,8 @@ extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
>  					  master to copy new code to 0 */
>  extern int crashing_cpu;
>  extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
> +extern void crash_ipi_callback(struct pt_regs *);
> +extern int crash_wake_offline;
>  
>  struct kimage;
>  struct pt_regs;
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index cbabb5adccd9..7e2ddfa9213e 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -44,6 +44,14 @@
>  #define REAL_MODE_TIMEOUT	10000
>  
>  static int time_to_dump;
> +/*
> + * crash_wake_offline should be set to 1 by platforms that intend to wake
> + * up offline cpus prior to jumping to a kdump kernel. Currently powernv
> + * sets it to 1, since we want to avoid things from happening when an
> + * offline CPU wakes up due to something like an HMI (malfunction error),
> + * which propagates to all threads.
> + */
> +int crash_wake_offline;
>  
>  #define CRASH_HANDLER_MAX 3
>  /* List of shutdown handles */
> @@ -63,17 +71,14 @@ static int handle_fault(struct pt_regs *regs)
>  #ifdef CONFIG_SMP
>  
>  static atomic_t cpus_in_crash;
> -static void crash_ipi_callback(struct pt_regs *regs)
> +void crash_ipi_callback(struct pt_regs *regs)
>  {
>  	static cpumask_t cpus_state_saved = CPU_MASK_NONE;
>  
>  	int cpu = smp_processor_id();
>  
> -	if (!cpu_online(cpu))
> -		return;
> -
>  	hard_irq_disable();
> -	if (!cpumask_test_cpu(cpu, &cpus_state_saved)) {
> +	if (cpu_online(cpu) && !cpumask_test_cpu(cpu, &cpus_state_saved)) {
>  		crash_save_cpu(regs, cpu);
>  		cpumask_set_cpu(cpu, &cpus_state_saved);
>  	}
> @@ -109,6 +114,9 @@ static void crash_kexec_prepare_cpus(int cpu)
>  
>  	printk(KERN_EMERG "Sending IPI to other CPUs\n");
>  
> +	if (crash_wake_offline)
> +		ncpus = num_present_cpus() - 1;
> +
>  	crash_send_ipi(crash_ipi_callback);
>  	smp_wmb();
>  
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index e0a4c1f82e25..f485db54c2f9 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -429,10 +429,12 @@ static void do_smp_send_nmi_ipi(int cpu)
>  	} else {
>  		int c;
>  
> -		for_each_online_cpu(c) {
> +		for_each_present_cpu(c) {
>  			if (c == raw_smp_processor_id())
>  				continue;
> -			do_message_pass(c, PPC_MSG_NMI_IPI);
> +			if (cpu_online(c) ||
> +				(kdump_in_progress() && crash_wake_offline))
> +				do_message_pass(c, PPC_MSG_NMI_IPI);
>  		}
>  	}
>  }
> @@ -485,7 +487,10 @@ int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
>  
>  	if (cpu < 0) {
>  		/* ALL_OTHERS */
> -		cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
> +		if (kdump_in_progress() && crash_wake_offline)
> +			cpumask_copy(&nmi_ipi_pending_mask, cpu_present_mask);
> +		else
> +			cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
>  		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
>  	} else {
>  		/* cpumask starts clear */
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index ba030669eca1..a8d8f6aaeb11 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -37,6 +37,7 @@
>  #include <asm/kvm_ppc.h>
>  #include <asm/ppc-opcode.h>
>  #include <asm/cpuidle.h>
> +#include <asm/kexec.h>
>  
>  #include "powernv.h"
>  
> @@ -187,6 +188,14 @@ static void pnv_smp_cpu_kill_self(void)
>  		WARN_ON(lazy_irq_pending());
>  
>  		/*
> +		 * For kdump kernels, we process the ipi and jump to
> +		 * crash_ipi_callback. For more details see the description
> +		 * at crash_wake_offline
> +		 */
> +		if (kdump_in_progress())
> +			crash_ipi_callback(NULL);
> +
> +		/*
>  		 * If the SRR1 value indicates that we woke up due to
>  		 * an external interrupt, then clear the interrupt.
>  		 * We clear the interrupt before checking for the
> @@ -324,14 +333,17 @@ static int pnv_cause_nmi_ipi(int cpu)
>  		 * exactly what semantics Linux wants or the firmware should
>  		 * provide.
>  		 */
> -		for_each_online_cpu(c) {
> +		for_each_present_cpu(c) {
>  			if (c == smp_processor_id())
>  				continue;
>  
> -			rc = opal_signal_system_reset(
> +			if (cpu_online(c) ||
> +				(kdump_in_progress() && crash_wake_offline)) {
> +				rc = opal_signal_system_reset(
>  						get_hard_smp_processor_id(c));
> -			if (rc != OPAL_SUCCESS)
> -				success = false;
> +				if (rc != OPAL_SUCCESS)
> +					success = false;
> +			}
>  		}
>  		if (success)
>  			return 1;
> @@ -371,5 +383,8 @@ void __init pnv_smp_init(void)
>  
>  #ifdef CONFIG_HOTPLUG_CPU
>  	ppc_md.cpu_die	= pnv_smp_cpu_kill_self;
> +#ifdef CONFIG_KEXEC_CORE
> +	crash_wake_offline = 1;
> +#endif
>  #endif
>  }
