Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64EEADDEF5
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 15:07:47 +1100 (EST)
Subject: Re: [PATCH] powerpc: use common cpu_die
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <1231160724_126472@mercury.realtime.net>
References: <1231160724_126472@mercury.realtime.net>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 15:07:13 +1100
Message-Id: <1233720433.16867.185.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


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

 .../...

> --- work.git.orig/arch/powerpc/platforms/powermac/smp.c	2009-01-05 02:09:08.000000000 -0600
> +++ work.git/arch/powerpc/platforms/powermac/smp.c	2009-01-05 02:27:23.000000000 -0600
 .../...

>  
> -void cpu_die(void)
> +void pmac32_cpu_die(void)
>  {
>  	local_irq_disable();
>  	cpu_dead[smp_processor_id()] = 1;

Hi Milton ! Any chance you can move both pmac32 and pmac64 variants into
the same file ? 

Cheers,
Ben.
