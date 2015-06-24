Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 0F58B1A0601
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 23:24:35 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, daniel.lezcano@linaro.org, mark.rutland@arm.com,
 lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, mpe@ellerman.id.au,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
Date: Wed, 24 Jun 2015 15:50:40 +0200
Message-ID: <1700583.a34yOllUuC@vostro.rjw.lan>
In-Reply-To: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, June 24, 2015 01:48:01 AM Preeti U Murthy wrote:
> On some archs, the local clockevent device stops in deep cpuidle states.
> The broadcast framework is used to wakeup cpus in these idle states, in
> which either an external clockevent device is used to send wakeup ipis
> or the hrtimer broadcast framework kicks in in the absence of such a
> device. One cpu is nominated as the broadcast cpu and this cpu sends
> wakeup ipis to sleeping cpus at the appropriate time. This is the
> implementation in the oneshot mode of broadcast.
> 
> In periodic mode of broadcast however, the presence of such cpuidle
> states results in the cpuidle driver calling tick_broadcast_enable()
> which shuts down the local clockevent devices of all the cpus and
> appoints the tick broadcast device as the clockevent device for each of
> them. This works on those archs where the tick broadcast device is a
> real clockevent device.  But on archs which depend on the hrtimer mode
> of broadcast, the tick broadcast device hapens to be a pseudo device.
> The consequence is that the local clockevent devices of all cpus are
> shutdown and the kernel hangs at boot time in periodic mode.
> 
> Let us thus not register the cpuidle states which have
> CPUIDLE_FLAG_TIMER_STOP flag set, on archs which depend on the hrtimer
> mode of broadcast in periodic mode. This patch takes care of doing this
> on powerpc. The cpus would not have entered into such deep cpuidle
> states in periodic mode on powerpc anyway. So there is no loss here.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

4.2 material I suppose?

> ---
>  drivers/cpuidle/cpuidle-powernv.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 5937207..3442764 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -60,6 +60,8 @@ static int nap_loop(struct cpuidle_device *dev,
>  	return index;
>  }
>  
> +/* Register for fastsleep only in oneshot mode of broadcast */
> +#ifdef CONFIG_TICK_ONESHOT
>  static int fastsleep_loop(struct cpuidle_device *dev,
>  				struct cpuidle_driver *drv,
>  				int index)
> @@ -83,7 +85,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>  
>  	return index;
>  }
> -
> +#endif
>  /*
>   * States for dedicated partition case.
>   */
> @@ -209,7 +211,14 @@ static int powernv_add_idle_states(void)
>  			powernv_states[nr_idle_states].flags = 0;
>  			powernv_states[nr_idle_states].target_residency = 100;
>  			powernv_states[nr_idle_states].enter = &nap_loop;
> -		} else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
> +		}
> +
> +		/*
> +		 * All cpuidle states with CPUIDLE_FLAG_TIMER_STOP set must come
> +		 * within this config dependency check.
> +		 */
> +#ifdef CONFIG_TICK_ONESHOT
> +		if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
>  			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
>  			/* Add FASTSLEEP state */
>  			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
> @@ -218,7 +227,7 @@ static int powernv_add_idle_states(void)
>  			powernv_states[nr_idle_states].target_residency = 300000;
>  			powernv_states[nr_idle_states].enter = &fastsleep_loop;
>  		}
> -
> +#endif
>  		powernv_states[nr_idle_states].exit_latency =
>  				((unsigned int)latency_ns[i]) / 1000;
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
