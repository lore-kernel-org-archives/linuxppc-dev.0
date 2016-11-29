Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSb1m2RZtzDvrn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 18:35:40 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAT7XYGv105542
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 02:35:38 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2713680nhx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 02:35:37 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 29 Nov 2016 00:35:37 -0700
Date: Mon, 28 Nov 2016 23:35:23 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: ego@linux.vnet.ibm.com
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 linux-pm@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 15/20] cpuidle/powernv: Add support for POWER ISA v3 idle
 states
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1480403344-25751-1-git-send-email-linuxram@us.ibm.com>
 <1480403344-25751-15-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480403344-25751-15-git-send-email-linuxram@us.ibm.com>
Message-Id: <20161129073523.GD5710@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry. please ignore this email.
RP

On Mon, Nov 28, 2016 at 11:08:59PM -0800, linuxram@us.ibm.com wrote:
> From: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> 
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>  a) new instruction named stop is added.
>  b) new per thread SPR named PSSCR is added which controls the behavior
> 	of stop instruction.
> 
> Supported idle states and value to be written to PSSCR register to enter
> any idle state is exposed via ibm,cpu-idle-state-names and
> ibm,cpu-idle-state-psscr respectively. To enter an idle state,
> platform provided power_stop() needs to be invoked with the appropriate
> PSSCR value.
> 
> This patch adds support for this new mechanism in cpuidle powernv driver.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> (cherry-picked from 3005c597ba46480b42e1fea3512c408f1830b816)
> ---
>  drivers/cpuidle/cpuidle-powernv.c |   61 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 61 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index bdf8dae..cab1b4b 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -20,6 +20,8 @@
>  #include <asm/opal.h>
>  #include <asm/runlatch.h>
> 
> +#define POWERNV_THRESHOLD_LATENCY_NS 200000
> +
>  struct cpuidle_driver powernv_idle_driver = {
>  	.name             = "powernv_idle",
>  	.owner            = THIS_MODULE,
> @@ -27,6 +29,9 @@ struct cpuidle_driver powernv_idle_driver = {
> 
>  static int max_idle_state;
>  static struct cpuidle_state *cpuidle_state_table;
> +
> +static u64 stop_psscr_table[CPUIDLE_STATE_MAX];
> +
>  static u64 snooze_timeout;
>  static bool snooze_timeout_en;
> 
> @@ -91,6 +96,17 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>  	return index;
>  }
>  #endif
> +
> +static int stop_loop(struct cpuidle_device *dev,
> +		     struct cpuidle_driver *drv,
> +		     int index)
> +{
> +	ppc64_runlatch_off();
> +	power9_idle_stop(stop_psscr_table[index]);
> +	ppc64_runlatch_on();
> +	return index;
> +}
> +
>  /*
>   * States for dedicated partition case.
>   */
> @@ -170,6 +186,8 @@ static int powernv_add_idle_states(void)
>  	u32 latency_ns[CPUIDLE_STATE_MAX];
>  	u32 residency_ns[CPUIDLE_STATE_MAX];
>  	u32 flags[CPUIDLE_STATE_MAX];
> +	u64 psscr_val[CPUIDLE_STATE_MAX];
> +	const char *names[CPUIDLE_STATE_MAX];
>  	int i, rc;
> 
>  	/* Currently we have snooze statically defined */
> @@ -208,12 +226,35 @@ static int powernv_add_idle_states(void)
>  		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
>  		goto out;
>  	}
> +	if (of_property_read_string_array(power_mgt,
> +		"ibm,cpu-idle-state-names", names, dt_idle_states) < 0) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * If the idle states use stop instruction, probe for psscr values
> +	 * which are necessary to specify required stop level.
> +	 */
> +	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP))
> +		if (of_property_read_u64_array(power_mgt,
> +		    "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states)) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
> +			goto out;
> +		}
> 
>  	rc = of_property_read_u32_array(power_mgt,
>  		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
> 
> 
>  	for (i = 0; i < dt_idle_states; i++) {
> +		/*
> +		 * If an idle state has exit latency beyond
> +		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> +		 * in cpu-idle.
> +		 */
> +		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
> +			continue;
> 
>  		/*
>  		 * Cpuidle accepts exit_latency and target_residency in us.
> @@ -226,6 +267,16 @@ static int powernv_add_idle_states(void)
>  			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIME_VALID;
>  			powernv_states[nr_idle_states].target_residency = 100;
>  			powernv_states[nr_idle_states].enter = nap_loop;
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
>  		}
> 
>  		/*
> @@ -242,6 +293,16 @@ static int powernv_add_idle_states(void)
>  				CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP;
>  			powernv_states[nr_idle_states].target_residency = 300000;
>  			powernv_states[nr_idle_states].enter = fastsleep_loop;
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
>  		}
>  #endif
>  		powernv_states[nr_idle_states].exit_latency =
> -- 
> 1.7.1

-- 
Ram Pai
