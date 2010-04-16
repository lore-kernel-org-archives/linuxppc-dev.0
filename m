Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B18BB7D0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Apr 2010 08:01:42 +1000 (EST)
Subject: Re: Possible bug with mutex adaptative spinning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1271453184.1674.483.camel@laptop>
References: <1271212509.13059.135.camel@pasglop>
	<1271453184.1674.483.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 17 Apr 2010 08:00:32 +1000
Message-ID: <1271455232.13059.197.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> 
> I've queued the below patch

Thanks. Should it make -stable as well ?

Cheers,
Ben.

> ---
> Subject: mutex: Don't spin when the owner CPU is offline or other weird cases
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri Apr 16 23:20:00 CEST 2010
> 
> Due to recent load-balancer changes that delay the task migration to
> the next wakeup, the adaptive mutex spinning ends up in a live lock
> when the owner's CPU gets offlined because the cpu_online() check
> lives before the owner running check.
> 
> This patch changes mutex_spin_on_owner() to return 0 (don't spin) in
> any case where we aren't sure about the owner struct validity or CPU
> number, and if the said CPU is offline. There is no point going back &
> re-evaluate spinning in corner cases like that, let's just go to
> sleep.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> LKML-Reference: <1271212509.13059.135.camel@pasglop>
> ---
>  kernel/sched.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6/kernel/sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched.c
> +++ linux-2.6/kernel/sched.c
> @@ -3647,7 +3647,7 @@ int mutex_spin_on_owner(struct mutex *lo
>  	 * the mutex owner just released it and exited.
>  	 */
>  	if (probe_kernel_address(&owner->cpu, cpu))
> -		goto out;
> +		return 0;
>  #else
>  	cpu = owner->cpu;
>  #endif
> @@ -3657,14 +3657,14 @@ int mutex_spin_on_owner(struct mutex *lo
>  	 * the cpu field may no longer be valid.
>  	 */
>  	if (cpu >= nr_cpumask_bits)
> -		goto out;
> +		return 0;
>  
>  	/*
>  	 * We need to validate that we can do a
>  	 * get_cpu() and that we have the percpu area.
>  	 */
>  	if (!cpu_online(cpu))
> -		goto out;
> +		return 0;
>  
>  	rq = cpu_rq(cpu);
>  
> @@ -3683,7 +3683,7 @@ int mutex_spin_on_owner(struct mutex *lo
>  
>  		cpu_relax();
>  	}
> -out:
> +
>  	return 1;
>  }
>  #endif
> 
