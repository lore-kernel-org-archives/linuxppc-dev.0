Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AE1C1A0E2D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 19:00:15 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 01:00:13 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A0C201FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 00:51:22 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1H803nY9895960
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 01:00:11 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1H7xbCp012759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 00:59:38 -0700
Message-ID: <54E2F4CE.2090205@linux.vnet.ibm.com>
Date: Tue, 17 Feb 2015 13:29:10 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: mpe@ellerman.id.au, rafael.j.wysocki@intel.com
Subject: Re: [PATCH V4] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
References: <20150203061709.13097.7035.stgit@preeti.in.ibm.com>
In-Reply-To: <20150203061709.13097.7035.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rafael,

Can you please pull this patch ?
Another patch based on top of this is waiting to be pulled:
[PATCH] driver/cpuidle-powernv: Avoid endianness conversions while parsing DT

Regards
Preeti U Murthy

On 02/03/2015 11:50 AM, Preeti U Murthy wrote:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, use better
> APIs to parse the powermgmt device tree node.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> Changes from the previous versions: https://lkml.org/lkml/2015/2/2/12
> 1. Used better APIs
> 2. Code Cleanups
> 3. Reverted back to the V2 of this patch as suggested in the above link,
> in addition to a few cleanups and carried forward the Acks from V2
> 
>  drivers/cpuidle/cpuidle-powernv.c |   71 ++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 2726663..3aa27a0 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -13,6 +13,7 @@
>  #include <linux/notifier.h>
>  #include <linux/clockchips.h>
>  #include <linux/of.h>
> +#include <linux/slab.h>
>  
>  #include <asm/machdep.h>
>  #include <asm/firmware.h>
> @@ -161,69 +162,81 @@ static int powernv_add_idle_states(void)
>  	int nr_idle_states = 1; /* Snooze */
>  	int dt_idle_states;
>  	const __be32 *idle_state_flags;
> -	const __be32 *idle_state_latency;
> -	u32 len_flags, flags, latency_ns;
> -	int i;
> +	u32 len_flags, flags;
> +	u32 *latency_ns, *residency_ns;
> +	int i, rc;
>  
>  	/* Currently we have snooze statically defined */
>  
>  	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
>  	if (!power_mgt) {
>  		pr_warn("opal: PowerMgmt Node not found\n");
> -		return nr_idle_states;
> +		goto out;
>  	}
>  
> -	idle_state_flags = of_get_property(power_mgt, "ibm,cpu-idle-state-flags", &len_flags);
> +	idle_state_flags = of_get_property(power_mgt,
> +				"ibm,cpu-idle-state-flags", &len_flags);
>  	if (!idle_state_flags) {
> -		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
> -		return nr_idle_states;
> +		pr_warn("cpuidle-powernv : missing
> +				ibm,cpu-idle-state-flags in DT\n");
> +		goto out;
>  	}
>  
> -	idle_state_latency = of_get_property(power_mgt,
> -			"ibm,cpu-idle-state-latencies-ns", NULL);
> -	if (!idle_state_latency) {
> -		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-latencies-ns\n");
> -		return nr_idle_states;
> +	dt_idle_states = len_flags / sizeof(u32);
> +
> +	latency_ns = kzalloc(sizeof(*latency_ns) * dt_idle_states, GFP_KERNEL);
> +	rc = of_property_read_u32_array(power_mgt,
> +		"ibm,cpu-idle-state-latencies-ns", latency_ns, dt_idle_states);
> +	if (rc) {
> +		pr_warn("cpuidle-powernv: missing
> +				ibm,cpu-idle-state-latencies-ns in DT\n");
> +		goto out_free_latency;
>  	}
>  
> -	dt_idle_states = len_flags / sizeof(u32);
> +	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
> +	rc = of_property_read_u32_array(power_mgt,
> +		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
>  
>  	for (i = 0; i < dt_idle_states; i++) {
>  
>  		flags = be32_to_cpu(idle_state_flags[i]);
>  
> -		/* Cpuidle accepts exit_latency in us and we estimate
> -		 * target residency to be 10x exit_latency
> +		/*
> +		 * Cpuidle accepts exit_latency and target_residency in us.
> +		 * Use default target_residency values if f/w does not expose it.
>  		 */
> -		latency_ns = be32_to_cpu(idle_state_latency[i]);
>  		if (flags & OPAL_PM_NAP_ENABLED) {
>  			/* Add NAP state */
>  			strcpy(powernv_states[nr_idle_states].name, "Nap");
>  			strcpy(powernv_states[nr_idle_states].desc, "Nap");
>  			powernv_states[nr_idle_states].flags = 0;
> -			powernv_states[nr_idle_states].exit_latency =
> -					((unsigned int)latency_ns) / 1000;
> -			powernv_states[nr_idle_states].target_residency =
> -					((unsigned int)latency_ns / 100);
> +			powernv_states[nr_idle_states].target_residency = 100;
>  			powernv_states[nr_idle_states].enter = &nap_loop;
> -			nr_idle_states++;
> -		}
> -
> -		if (flags & OPAL_PM_SLEEP_ENABLED ||
> +		} else if (flags & OPAL_PM_SLEEP_ENABLED ||
>  			flags & OPAL_PM_SLEEP_ENABLED_ER1) {
>  			/* Add FASTSLEEP state */
>  			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
>  			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
>  			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
> -			powernv_states[nr_idle_states].exit_latency =
> -					((unsigned int)latency_ns) / 1000;
> -			powernv_states[nr_idle_states].target_residency =
> -					((unsigned int)latency_ns / 100);
> +			powernv_states[nr_idle_states].target_residency = 300000;
>  			powernv_states[nr_idle_states].enter = &fastsleep_loop;
> -			nr_idle_states++;
>  		}
> +
> +		powernv_states[nr_idle_states].exit_latency =
> +				((unsigned int)latency_ns[i]) / 1000;
> +
> +		if (!rc) {
> +			powernv_states[nr_idle_states].target_residency =
> +				((unsigned int)residency_ns[i]) / 1000;
> +		}
> +
> +		nr_idle_states++;
>  	}
>  
> +	kfree(residency_ns);
> +out_free_latency:
> +	kfree(latency_ns);
> +out:
>  	return nr_idle_states;
>  }
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
