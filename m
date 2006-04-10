Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C7E0767A06
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 09:59:28 +1000 (EST)
Date: Mon, 10 Apr 2006 15:58:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Wilder <dwilder@us.ibm.com>
Subject: Re: [PATCH] 2 of 3   kdump-ppc64-soft-reset-fixes
Message-Id: <20060410155838.0df63b97.akpm@osdl.org>
In-Reply-To: <443ADCCE.1070504@us.ibm.com>
References: <443ADCCE.1070504@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mchintage@in.ibm.com, linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Wilder <dwilder@us.ibm.com> wrote:
>
>

Please don't use a filename as a patch title.  See section 2 of
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.


> --- 2617-rc1.orig/arch/powerpc/kernel/crash.c	2006-04-05 13:20:38.000000000 -0700
> +++ 2617-rc1/arch/powerpc/kernel/crash.c	2006-04-05 13:24:19.000000000 -0700
> @@ -23,6 +23,7 @@
>  #include <linux/elfcore.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> +#include <linux/irq.h>
>  
>  #include <asm/processor.h>
>  #include <asm/machdep.h>
> @@ -40,6 +41,9 @@
>  
>  /* This keeps a track of which one is crashing cpu. */
>  int crashing_cpu = -1;
> +static cpumask_t cpus_in_crash = CPU_MASK_NONE;
> +extern struct kimage *kexec_crash_image;
> +extern cpumask_t cpus_in_sr;

extern declarations should be placed in .h, not in .c.

> +	while (!cpu_isset(crashing_cpu, cpus_in_crash)) 
> +		barrier();

The patch contains lots of busy-loops which all do barrier().

barrier() is purely a compiler thing.  I suspect you meant cpu_relax(). 
Either way, there should be a cpu_relax() in these loops.


> +
> +/*
> + * This function will be called by secondary cpus or by kexec cpu 
> + * if soft-reset is activated to stop some CPUs.
> + */
> +void crash_kexec_secondary(struct pt_regs *regs)
> +{
> +	int cpu = smp_processor_id();
> +	unsigned long flags;
> +	int msecs = 5;
> +
> +	local_irq_save(flags);
> +	/* Wait 5ms if the kexec CPU is not entered yet. */
> +	while (crashing_cpu < 0) {
> +		if (--msecs < 0) {
> +			/*
> +			 * Either kdump image is not loaded or
> +			 * kdump process is not started - Probably xmon
> +			 * exited using 'x'(exit and recover) or 
> +			 * kexec_should_crash() failed for all running tasks.
> +			 */
> +			cpu_clear(cpu, cpus_in_sr);
> +			local_irq_restore(flags);
> +			return;
> +		}
> +		mdelay(1);
> +		barrier();
> +	}
> +        if (cpu == crashing_cpu) {

Whitespace broke here.

> +		/*
> +		 * Panic CPU will enter this func only via soft-reset.
> +		 * Wait until all secondary CPUs entered and
> +		 * then start kexec boot.
> +		 */
> +		crash_soft_reset_check(cpu);
> +		cpu_set(crashing_cpu, cpus_in_crash);
> +		if (ppc_md.kexec_cpu_down)
> +			ppc_md.kexec_cpu_down(1, 0);
> +		machine_kexec(kexec_crash_image);
> +		/* NOTREACHED */
> +	}
> +	crash_ipi_callback(regs);
> +}
