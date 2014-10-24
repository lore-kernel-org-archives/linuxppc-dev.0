Return-Path: <lorenzo.pieralisi@arm.com>
Received: from foss-mx-na.foss.arm.com (foss-mx-na.foss.arm.com
 [217.140.108.86])
 by lists.ozlabs.org (Postfix) with ESMTP id 971CA1A0027
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Oct 2014 01:30:43 +1100 (AEDT)
Date: Fri, 24 Oct 2014 15:30:30 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/powernv: Populate cpuidle state details by
 querying the device-tree
Message-ID: <20141024143030.GA25966@red-moon>
References: <20141014075259.11810.50996.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141014075259.11810.50996.stgit@preeti.in.ibm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "shreyas@linux.vnet.ibm.com" <shreyas@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2014 at 08:53:00AM +0100, Preeti U Murthy wrote:
> We hard code the metrics relevant for cpuidle states in the kernel today.
> Instead pick them up from the device tree so that they remain relevant
> and updated for the system that the kernel is running on.
> 
> Cc: linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: devicetree@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> 
>  drivers/cpuidle/cpuidle-powernv.c |   27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Device tree properties should be documented, and these bindings are
getting very similar to the ones I have just completed for ARM,
I wonder whether we should take the generic bits out of ARM bindings (ie
exit_latency) and make those available to other architectures.

Thanks,
Lorenzo

> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index fa79392..b57681d 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -165,7 +165,8 @@ static int powernv_add_idle_states(void)
>  	int nr_idle_states = 1; /* Snooze */
>  	int dt_idle_states;
>  	const __be32 *idle_state_flags;
> -	u32 len_flags, flags;
> +	const __be32 *idle_state_latency;
> +	u32 len_flags, flags, latency_ns;
>  	int i;
>  
>  	/* Currently we have snooze statically defined */
> @@ -182,18 +183,32 @@ static int powernv_add_idle_states(void)
>  		return nr_idle_states;
>  	}
>  
> +	idle_state_latency = of_get_property(power_mgt,
> +			"ibm,cpu-idle-state-latencies-ns", NULL);
> +	if (!idle_state_latency) {
> +		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-latencies-ns\n");
> +		return nr_idle_states;
> +	}
> +
>  	dt_idle_states = len_flags / sizeof(u32);
>  
>  	for (i = 0; i < dt_idle_states; i++) {
>  
>  		flags = be32_to_cpu(idle_state_flags[i]);
> +
> +		/* Cpuidle accepts exit_latency in us and we estimate
> +		 * target residency to be 10x exit_latency
> +		 */
> +		latency_ns = be32_to_cpu(idle_state_latency[i]);
>  		if (flags & IDLE_USE_INST_NAP) {
>  			/* Add NAP state */
>  			strcpy(powernv_states[nr_idle_states].name, "Nap");
>  			strcpy(powernv_states[nr_idle_states].desc, "Nap");
>  			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIME_VALID;
> -			powernv_states[nr_idle_states].exit_latency = 10;
> -			powernv_states[nr_idle_states].target_residency = 100;
> +			powernv_states[nr_idle_states].exit_latency =
> +					((unsigned int)latency_ns) / 1000;
> +			powernv_states[nr_idle_states].target_residency =
> +					((unsigned int)latency_ns / 100);
>  			powernv_states[nr_idle_states].enter = &nap_loop;
>  			nr_idle_states++;
>  		}
> @@ -204,8 +219,10 @@ static int powernv_add_idle_states(void)
>  			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
>  			powernv_states[nr_idle_states].flags =
>  				CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP;
> -			powernv_states[nr_idle_states].exit_latency = 300;
> -			powernv_states[nr_idle_states].target_residency = 1000000;
> +			powernv_states[nr_idle_states].exit_latency =
> +					((unsigned int)latency_ns) / 1000;
> +			powernv_states[nr_idle_states].target_residency =
> +					((unsigned int)latency_ns / 100);
>  			powernv_states[nr_idle_states].enter = &fastsleep_loop;
>  			nr_idle_states++;
>  		}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
