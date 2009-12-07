Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 2D6BCB7093
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Dec 2009 08:57:43 +1100 (EST)
Message-ID: <4B1D7A68.5000309@ru.mvista.com>
Date: Tue, 08 Dec 2009 00:58:00 +0300
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: stop_this_cpu: remove the cpu from the online
	map.
References: <20091125214852.GA7912@ru.mvista.com>
In-Reply-To: <20091125214852.GA7912@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, is this OK?
Other architectures do the same thing.

Thanks,
Val.

Valentine Barshak wrote:
> Remove the CPU from the online map to prevent smp_call_function
> from sending messages to a stopped CPU.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  arch/powerpc/kernel/smp.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff -pruN linux-2.6.orig/arch/powerpc/kernel/smp.c linux-2.6/arch/powerpc/kernel/smp.c
> --- linux-2.6.orig/arch/powerpc/kernel/smp.c	2009-11-26 00:22:15.000000000 +0300
> +++ linux-2.6/arch/powerpc/kernel/smp.c	2009-11-26 00:26:48.000000000 +0300
> @@ -218,6 +218,9 @@ void crash_send_ipi(void (*crash_ipi_cal
>  
>  static void stop_this_cpu(void *dummy)
>  {
> +	/* Remove this CPU */
> +	set_cpu_online(smp_processor_id(), false);
> +
>  	local_irq_disable();
>  	while (1)
>  		;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
