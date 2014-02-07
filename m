Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by ozlabs.org (Postfix) with SMTP id 7BD8E2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 22:53:07 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 3/3] time/cpuidle:Handle failed call to BROADCAST_ENTER
 on archs with CPUIDLE_FLAG_TIMER_STOP set
Date: Fri, 07 Feb 2014 13:07:36 +0100
Message-ID: <4923497.uFDEGdljgG@vostro.rjw.lan>
In-Reply-To: <20140207080652.17187.66344.stgit@preeti.in.ibm.com>
References: <20140207075618.17187.20149.stgit@preeti.in.ibm.com>
 <20140207080652.17187.66344.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: deepthi@linux.vnet.ibm.com, linux-pm@vger.kernel.org, peterz@infradead.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, fweisbec@gmail.com, tglx@linutronix.de,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, February 07, 2014 01:36:52 PM Preeti U Murthy wrote:
> Some archs set the CPUIDLE_FLAG_TIMER_STOP flag for idle states in which the
> local timers stop. The cpuidle_idle_call() currently handles such idle states
> by calling into the broadcast framework so as to wakeup CPUs at their next
> wakeup event. With the hrtimer mode of broadcast, the BROADCAST_ENTER call
> into the broadcast frameowork can fail for archs that do not have an external
> clock device to handle wakeups and the CPU in question has to thus be made
> the stand by CPU. This patch handles such cases by failing the call into
> cpuidle so that the arch can take some default action. The arch will certainly
> not enter a similar idle state because a failed cpuidle call will also implicitly
> indicate that the broadcast framework has not registered this CPU to be woken up.
> Hence we are safe if we fail the cpuidle call.
> 
> In the process move the functions that trace idle statistics just before and
> after the entry and exit into idle states respectively. In other
> scenarios where the call to cpuidle fails, we end up not tracing idle
> entry and exit since a decision on an idle state could not be taken. Similarly
> when the call to broadcast framework fails, we skip tracing idle statistics
> because we are in no further position to take a decision on an alternative
> idle state to enter into.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> 
>  drivers/cpuidle/cpuidle.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index a55e68f..8beb0f02 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -140,12 +140,14 @@ int cpuidle_idle_call(void)
>  		return 0;
>  	}
>  
> -	trace_cpu_idle_rcuidle(next_state, dev->cpu);
> -
>  	broadcast = !!(drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP);
>  
> -	if (broadcast)
> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
> +	if (broadcast &&
> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu))
> +		return -EBUSY;
> +
> +
> +	trace_cpu_idle_rcuidle(next_state, dev->cpu);
>  
>  	if (cpuidle_state_is_coupled(dev, drv, next_state))
>  		entered_state = cpuidle_enter_state_coupled(dev, drv,
> @@ -153,11 +155,11 @@ int cpuidle_idle_call(void)
>  	else
>  		entered_state = cpuidle_enter_state(dev, drv, next_state);
>  
> +	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> +
>  	if (broadcast)
>  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
>  
> -	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> -
>  	/* give the governor an opportunity to reflect on the outcome */
>  	if (cpuidle_curr_governor->reflect)
>  		cpuidle_curr_governor->reflect(dev, entered_state);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
