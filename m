Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08E73DDF6C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 19:00:18 +1000 (EST)
Message-ID: <4631BBB1.9010705@genesi-usa.com>
Date: Fri, 27 Apr 2007 10:00:33 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Show current speed in /proc/cpuinfo
References: <20070427084118.GA8842@lixom.net>
In-Reply-To: <20070427084118.GA8842@lixom.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Olof Johansson wrote:
> On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
> changes. It makes sense to do the same on powerpc to keep users from
> getting confused. Fall back to old ppc_proc_freq for non-cpufreq systems.
> 
> Also change the format to three decimals, having full Hz granularity is
> silly these days.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> Index: powerpc/arch/powerpc/kernel/setup-common.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/setup-common.c
> +++ powerpc/arch/powerpc/kernel/setup-common.c
> @@ -29,6 +29,7 @@
>  #include <linux/root_dev.h>
>  #include <linux/notifier.h>
>  #include <linux/cpu.h>
> +#include <linux/cpufreq.h>
>  #include <linux/unistd.h>
>  #include <linux/serial.h>
>  #include <linux/serial_8250.h>
> @@ -160,6 +161,7 @@ static int show_cpuinfo(struct seq_file 
>  	unsigned int pvr;
>  	unsigned short maj;
>  	unsigned short min;
> +	unsigned int freq;
>  
>  	if (cpu_id == NR_CPUS) {
>  #if defined(CONFIG_SMP) && defined(CONFIG_PPC32)
> @@ -226,13 +228,15 @@ static int show_cpuinfo(struct seq_file 
>  	}
>  #endif /* CONFIG_TAU */
>  
> -	/*
> -	 * Assume here that all clock rates are the same in a
> -	 * smp system.  -- Cort
> -	 */
> -	if (ppc_proc_freq)
> -		seq_printf(m, "clock\t\t: %lu.%06luMHz\n",
> -			   ppc_proc_freq / 1000000, ppc_proc_freq % 1000000);

Would it not be relevant to keep listing the maximum CPU speed as well
as the real, current CPU speed?

Intel encode this into their CPUID string and when I bring up Windows' System
Properties dialog I get this;

Intel(R) Pentium(R) M processor 1.70GHz
593MHz, 512MB of RAM

So you can always, always find out very easily what spec your processor
is, and not just what cpufreq has done with it?

> +	/* cpufreq_speed_get() is in kHz */
> +	freq = cpufreq_quick_get(cpu_id);

Is it speed or quick? This and the comment below confused me, KHz or Hz? :D

> +
> +	if (!freq)
> +		/* ppc_proc_freq is in Hz */
> +		freq = ppc_proc_freq / 1000;
> +
> +	if (freq)
> +		seq_printf(m, "clock\t\t: %u.%03uMHz\n", freq / 1000, freq % 1000);

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
