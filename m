Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0A66688E0
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Dec 2005 11:26:32 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1134259249.4387.3.camel@localhost>
References: <1134256279.3810.8.camel@localhost>
	<1134258468.6989.36.camel@gaston> <1134259249.4387.3.camel@localhost>
Content-Type: text/plain
Date: Sun, 11 Dec 2005 11:25:07 +1100
Message-Id: <1134260707.6989.43.camel@gaston>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: [patch] ppc32: set smp_tb_synchronized on UP with SMP kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-12-11 at 01:00 +0100, Johannes Berg wrote:
> ppc32 kernel, when built with CONFIG_SMP and booted on a single CPU
> machine, will not properly set smp_tb_synchronized, thus causing
> gettimeofday() to not use the HW timebase and to be limited to jiffy
> resolution. This, among others, causes unacceptable pauses when
> launching X.org.
> 
> Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- 
> 
> With this patch, X.org startup time goes down from ~30 seconds to normal
> (just a second or so). The know-how really comes from BenH who I
> discussed with on IRC.
> 
> --- linux-2.6.15-rc5.orig/arch/ppc/kernel/smp.c	2005-12-10 23:56:23.026328000 +0100
> +++ linux-2.6.15-rc5/arch/ppc/kernel/smp.c	2005-12-11 00:56:53.756328000 +0100
> @@ -301,6 +301,10 @@
>  
>  	/* Probe platform for CPUs: always linear. */
>  	num_cpus = smp_ops->probe();
> +	
> +	if (num_cpus < 2)
> +		smp_tb_synchronized = 1;
> +	
>  	for (i = 0; i < num_cpus; ++i)
>  		cpu_set(i, cpu_possible_map);
>  
> 
