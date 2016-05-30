Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJJpd3qCGzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 00:26:49 +1000 (AEST)
Received: by mail-wm0-x22e.google.com with SMTP id a136so89348728wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 07:26:49 -0700 (PDT)
Subject: Re: [PATCH v4 09/10] cpuidle/powernv: Add support for POWER ISA v3
 idle states
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1464095714-48772-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464095714-48772-10-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <574C4DA4.4050100@linaro.org>
Date: Mon, 30 May 2016 16:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <1464095714-48772-10-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2016 03:15 PM, Shreyas B. Prabhu wrote:
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>   a) new instruction named stop is added.
>   b) new per thread SPR named PSSCR is added which controls the behavior
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
> Cc: linux-pm@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
>   - No changes since v1
>
>   drivers/cpuidle/cpuidle-powernv.c | 57 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index e12dc30..efe5221 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -21,6 +21,7 @@
>   #include <asm/runlatch.h>
>
>   #define MAX_POWERNV_IDLE_STATES	8
> +#define MAX_IDLE_STATE_NAME_LEN	10

Why not reuse cpuidle constants even if they are slightly different ?

#define CPUIDLE_STATE_MAX       10
#define CPUIDLE_NAME_LEN        16

>   struct cpuidle_driver powernv_idle_driver = {
>   	.name             = "powernv_idle",
> @@ -29,9 +30,11 @@ struct cpuidle_driver powernv_idle_driver = {
>
>   static int max_idle_state;
>   static struct cpuidle_state *cpuidle_state_table;
> +
> +static u64 stop_psscr_table[MAX_POWERNV_IDLE_STATES];
> +
>   static u64 snooze_timeout;
>   static bool snooze_timeout_en;
> -
>   static int snooze_loop(struct cpuidle_device *dev,
>   			struct cpuidle_driver *drv,
>   			int index)
> @@ -139,6 +142,15 @@ static struct notifier_block setup_hotplug_notifier = {
>   	.notifier_call = powernv_cpuidle_add_cpu_notifier,
>   };
>
> +static int stop_loop(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv,
> +			int index)
> +{
> +	ppc64_runlatch_off();
> +	power_stop(stop_psscr_table[index]);
> +	ppc64_runlatch_on();
> +	return index;
> +}
>   /*
>    * powernv_cpuidle_driver_init()
>    */
> @@ -169,6 +181,8 @@ static int powernv_add_idle_states(void)
>   	int nr_idle_states = 1; /* Snooze */
>   	int dt_idle_states;
>   	u32 *latency_ns, *residency_ns, *flags;
> +	u64 *psscr_val = NULL;
> +	const char *names[MAX_POWERNV_IDLE_STATES];
>   	int i, rc;
>
>   	/* Currently we have snooze statically defined */
> @@ -201,6 +215,23 @@ static int powernv_add_idle_states(void)
>   		goto out_free_latency;
>   	}
>
> +	rc = of_property_read_string_array(power_mgt,
> +		"ibm,cpu-idle-state-names", names, dt_idle_states);
> +	if (rc < -1) {

Why < -1 ?

> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-names in DT\n");
> +		goto out_free_latency;
> +	}
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {

Isn't weird to mix cpu feature and DT bindings check ?

> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> +					GFP_KERNEL);
> +		rc = of_property_read_u64_array(power_mgt,
> +			"ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states);

[cc'ed Lorenzo and Rob ]

I don't see the documentation for the binding. Wouldn't make sense to 
add the value per idle state instead of an index based array ?

> +		if (rc < -1) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
> +			goto out_free_psscr;
> +		}
> +	}
>   	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
>   	rc = of_property_read_u32_array(power_mgt,
>   		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
> @@ -218,6 +249,16 @@ static int powernv_add_idle_states(void)
>   			powernv_states[nr_idle_states].flags = 0;
>   			powernv_states[nr_idle_states].target_residency = 100;
>   			powernv_states[nr_idle_states].enter = &nap_loop;
> +		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
> +				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> +			strncpy(powernv_states[nr_idle_states].name,
> +				(char *)names[i], MAX_IDLE_STATE_NAME_LEN);

Why cast names[] to (char *) while strncpy is waiting for const char *, 
the initial type of names[] ?

> +			strncpy(powernv_states[nr_idle_states].desc,
> +				(char *)names[i], MAX_IDLE_STATE_NAME_LEN);
> +			powernv_states[nr_idle_states].flags = 0;

No target_residency specified ?

> +
> +			powernv_states[nr_idle_states].enter = &stop_loop;

s/&stop_loop/stop_loop/

> +			stop_psscr_table[nr_idle_states] = psscr_val[i];
>   		}
>
>   		/*
> @@ -233,6 +274,18 @@ static int powernv_add_idle_states(void)
>   			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
>   			powernv_states[nr_idle_states].target_residency = 300000;
>   			powernv_states[nr_idle_states].enter = &fastsleep_loop;
> +		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
> +				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
> +
> +			strncpy(powernv_states[nr_idle_states].name,
> +				(char *)names[i], MAX_IDLE_STATE_NAME_LEN);
> +			strncpy(powernv_states[nr_idle_states].desc,
> +				(char *)names[i], MAX_IDLE_STATE_NAME_LEN);
> +
> +			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
> +
> +			powernv_states[nr_idle_states].enter = &stop_loop;
> +			stop_psscr_table[nr_idle_states] = psscr_val[i];
>   		}
>   #endif
>   		powernv_states[nr_idle_states].exit_latency =
> @@ -247,6 +300,8 @@ static int powernv_add_idle_states(void)
>   	}
>
>   	kfree(residency_ns);
> +out_free_psscr:
> +	kfree(psscr_val);
>   out_free_latency:
>   	kfree(latency_ns);
>   out_free_flags:
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
