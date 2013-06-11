Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 23C442C0085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 17:00:26 +1000 (EST)
Message-ID: <1370934016.8250.83.camel@pasglop>
Subject: Re: [RFC PATCH powerpc] Set cpu sibling mask before online cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Tue, 11 Jun 2013 17:00:16 +1000
In-Reply-To: <1368699626.2618.183.camel@ThinkPad-T5421>
References: <1368699626.2618.183.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-16 at 18:20 +0800, Li Zhong wrote:
> It seems following race is possible:
> 

 .../...

>  	vdso_getcpu_init();
>  #endif
> -	notify_cpu_starting(cpu);
> -	set_cpu_online(cpu, true);
>  	/* Update sibling maps */
>  	base = cpu_first_thread_sibling(cpu);
>  	for (i = 0; i < threads_per_core; i++) {
> -		if (cpu_is_offline(base + i))
> +		if (cpu_is_offline(base + i) && (cpu != base + i))
>  			continue;
>  		cpumask_set_cpu(cpu, cpu_sibling_mask(base + i));
>  		cpumask_set_cpu(base + i, cpu_sibling_mask(cpu));
> @@ -667,6 +665,10 @@ __cpuinit void start_secondary(void *unused)
>  	}
>  	of_node_put(l2_cache);
>  
> +	smp_wmb();
> +	notify_cpu_starting(cpu);
> +	set_cpu_online(cpu, true);
> +

So we could have an online CPU with an empty sibling mask. Now we can
have a sibling that isn't online ... Is that ok ?

Or should we do a two pass mechanism:

 - Pass 1, set the new cpu siblings
 - set_cpu_online
 - Pass 2, set other CPU sibling of this cpu

?

Cheers,
Ben.
