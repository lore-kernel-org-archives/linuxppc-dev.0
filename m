Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2F7F1A0F38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 15:59:06 +1100 (AEDT)
In-Reply-To: <54BE3B79.9070004@linux.vnet.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, rafael.j.wysocki@intel.com
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: cpuidle/powernv: Read target_residency value of idle states from
 DT if available
Message-Id: <20150123045906.D0086140297@ozlabs.org>
Date: Fri, 23 Jan 2015 15:59:06 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-20-01 at 11:26:49 UTC, Preeti U Murthy wrote:
> @@ -177,34 +178,39 @@ static int powernv_add_idle_states(void)
>  		return nr_idle_states;
>  	}
>  
> -	idle_state_latency = of_get_property(power_mgt,
> -			"ibm,cpu-idle-state-latencies-ns", NULL);
> -	if (!idle_state_latency) {
> +	dt_idle_states = len_flags / sizeof(u32);
> +
> +	latency_ns = kzalloc(sizeof(*latency_ns) * dt_idle_states, GFP_KERNEL);
> +	rc = of_property_read_u32(power_mgt,
> +			"ibm,cpu-idle-state-latencies-ns", latency_ns);

That's only reading the first value.

If you want to read the full property you need the _array version.

> +	if (rc) {
>  		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-latencies-ns\n");

You missed my hint that "DT-PowerMgmt" is a weird and ugly prefix. Can you use
"cpuidle-powernv:" instead?

>  
> -	dt_idle_states = len_flags / sizeof(u32);
> +	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
> +	rc = of_property_read_u32(power_mgt,
> +			"ibm,cpu-idle-state-residency-ns", residency_ns);
> +	if (rc) {
> +		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-residency-ns\n");
> +		pr_warn("Falling back to default values\n");

I don't think this is worth a warning seeing as we know there are firmwares out
there which do not have the property.

>  	for (i = 0; i < dt_idle_states; i++) {
>  
>  		flags = be32_to_cpu(idle_state_flags[i]);
> -
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

That looks wrong? Or do you mean to do that?

cheers
