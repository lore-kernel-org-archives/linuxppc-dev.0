Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT5xp0VLdzDqcp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:48:29 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DLhnro057513
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:48:28 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf66ngrm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:48:28 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 14 Jun 2016 07:48:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CEB922CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:48:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DLmNHk9044226
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:48:23 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DLmMaG015133
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:48:23 +1000
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: ego@linux.vnet.ibm.com, mikey@neuling.org, Daniel Lezcano
 <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, maddy@linux.vnet.ibm.com, Lorenzo Pieralisi
 <Lorenzo.Pieralisi@arm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Jun 2016 07:48:12 +1000
In-Reply-To: <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1465854492.3022.30.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-08 at 11:54 -0500, Shreyas B. Prabhu wrote:
> 
>  /*
>   * States for dedicated partition case.
>   */
> @@ -167,6 +183,8 @@ static int powernv_add_idle_states(void)
>  	int nr_idle_states = 1; /* Snooze */
>  	int dt_idle_states;
>  	u32 *latency_ns, *residency_ns, *flags;
> +	u64 *psscr_val = NULL;
> +	const char *names[CPUIDLE_STATE_MAX];
>  	int i, rc;
>  
>  	/* Currently we have snooze statically defined */
> @@ -199,12 +217,41 @@ static int powernv_add_idle_states(void)
>  		goto out_free_latency;
>  	}
>  
> +	rc = of_property_read_string_array(power_mgt,
> +					   "ibm,cpu-idle-state-names", names,
> +					   dt_idle_states);

Ok so from this I assume that dt_idle_states is the number of entries,
which has been checked properly to be < CPUIDLE_STATE_MAX correct ?

Beause ...

> +	if (rc < 0) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
> +		goto out_free_latency;
> +	}
> +
> +	/*
> +	 * If the idle states use stop instruction, probe for psscr values
> +	 * which are necessary to specify required stop level.
> +	 */
> +	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP)) {
> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> +				    GFP_KERNEL);
> +		rc = of_property_read_u64_array(power_mgt,
> +						"ibm,cpu-idle-state-psscr",
> +						psscr_val, dt_idle_states);

Here, psscr val is only one u64 ... shouldn't you kmalloc sizeof(..) *
dt_idle_states ?

> +		if (rc) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
> +			goto out_free_psscr;
> +		}
> +	}
>  	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);

Just like we do here

>  	rc = of_property_read_u32_array(power_mgt, 		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
>  	for (i = 0; i < dt_idle_states; i++) {
> -
> +		/*
> +		 * If an idle state has exit latency beyond
> +		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> +		 * in cpu-idle.
> +		 */
> +		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
> +			continue;
>  		/*
>  		 * Cpuidle accepts exit_latency and target_residency in us.
>  		 * Use default target_residency values if f/w does not expose it.
> @@ -216,6 +263,16 @@ static int powernv_add_idle_states(void)
>  			powernv_states[nr_idle_states].flags = 0;
>  			powernv_states[nr_idle_states].target_residency = 100;
>  			powernv_states[nr_idle_states].enter = &nap_loop;
> +		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
> +				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> +			strncpy(powernv_states[nr_idle_states].name,
> +				names[i], CPUIDLE_NAME_LEN);
> +			strncpy(powernv_states[nr_idle_states].desc,
> +				names[i], CPUIDLE_NAME_LEN);
> +			powernv_states[nr_idle_states].flags = 0;
> +
> +			powernv_states[nr_idle_states].enter = stop_loop;
> +			stop_psscr_table[nr_idle_states] = psscr_val[i];
>  		}
>  
>  		/*
> @@ -231,6 +288,16 @@ static int powernv_add_idle_states(void)
>  			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
>  			powernv_states[nr_idle_states].target_residency = 300000;
>  			powernv_states[nr_idle_states].enter = &fastsleep_loop;
> +		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
> +				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> +			strncpy(powernv_states[nr_idle_states].name,
> +				names[i], CPUIDLE_NAME_LEN);
> +			strncpy(powernv_states[nr_idle_states].desc,
> +				names[i], CPUIDLE_NAME_LEN);
> +
> +			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
> +			powernv_states[nr_idle_states].enter = stop_loop;
> +			stop_psscr_table[nr_idle_states] = psscr_val[i];
>  		}
>  #endif
>  		powernv_states[nr_idle_states].exit_latency =
> @@ -245,6 +312,8 @@ static int powernv_add_idle_states(void)
>  	}
>  
>  	kfree(residency_ns);
> +out_free_psscr:
> +	kfree(psscr_val);
>  out_free_latency:
>  	kfree(latency_ns);
>  out_free_flags:
