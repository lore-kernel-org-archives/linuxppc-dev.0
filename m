Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BEE1DE059
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 10:38:29 +1000 (EST)
Subject: Re: [PATCH] prevent powerpc from invoking irq handlers on offline CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: paulmck@linux.vnet.ibm.com
In-Reply-To: <20080831173127.GA15296@linux.vnet.ibm.com>
References: <20080831173127.GA15296@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 01 Sep 2008 10:34:44 +1000
Message-Id: <1220229284.13162.411.camel@pasglop>
Mime-Version: 1.0
Cc: tnt@246tNt.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, akpm@linux-foundation.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-08-31 at 10:31 -0700, Paul E. McKenney wrote:
> Make powerpc refrain from clearing a given to-be-offlined CPU's bit in the
> cpu_online_mask until it has processed pending irqs.  This change
> prevents other CPUs from being blindsided by an apparently offline CPU
> nevertheless changing globally visible state.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---

Sounds reasonable... the only possible worry here is if somebody tries
an IPI ... The IPI code will and the target CPU mask with the online
map, so it may try to send to the to-be-offlined CPU and timeout, no ?

Cheers,
Ben.

>  smp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 5337ca7..1fedd7d 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -250,11 +250,11 @@ int generic_cpu_disable(void)
>  	if (cpu == boot_cpuid)
>  		return -EBUSY;
>  
> -	cpu_clear(cpu, cpu_online_map);
>  #ifdef CONFIG_PPC64
>  	vdso_data->processorCount--;
>  	fixup_irqs(cpu_online_map);
>  #endif
> +	cpu_clear(cpu, cpu_online_map);
>  	return 0;
>  }
>  
