Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdJ2P5P2LzDt3F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 22:51:25 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so4323672pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 03:51:25 -0800 (PST)
Subject: Re: [PATCH v4 2/4] cpuidle:powernv: Add helper function to populate
 powernv idle states.
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>
References: <cover.1481288905.git.ego@linux.vnet.ibm.com>
 <36f9cd2d944772d8e414a8240f9ec36eaec65ebd.1481288905.git.ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <d50fa1c4-9f48-c463-ddf8-293c23053b8f@gmail.com>
Date: Tue, 13 Dec 2016 22:51:04 +1100
MIME-Version: 1.0
In-Reply-To: <36f9cd2d944772d8e414a8240f9ec36eaec65ebd.1481288905.git.ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/12/16 00:32, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In the current code for powernv_add_idle_states, there is a lot of code
> duplication while initializing an idle state in powernv_states table.
> 
> Add an inline helper function to populate the powernv_states[] table for
> a given idle state. Invoke this for populating the "Nap", "Fastsleep"
> and the stop states in powernv_add_idle_states.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 85 ++++++++++++++++++++++-----------------
>  include/linux/cpuidle.h           |  1 +
>  2 files changed, 50 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 7fe442c..db18af1 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -167,6 +167,24 @@ static int powernv_cpuidle_driver_init(void)
>  	return 0;
>  }
>  
> +static inline void add_powernv_state(int index, const char *name,
> +				     unsigned int flags,
> +				     int (*idle_fn)(struct cpuidle_device *,
> +						    struct cpuidle_driver *,
> +						    int),
> +				     unsigned int target_residency,
> +				     unsigned int exit_latency,
> +				     u64 psscr_val)
> +{
> +	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
> +	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);

Do name and desc ever diverge?

> +	powernv_states[index].flags = flags;
> +	powernv_states[index].target_residency = target_residency;
> +	powernv_states[index].exit_latency = exit_latency;
> +	powernv_states[index].enter = idle_fn;

Why not call it idle_fn instead of enter?

> +	stop_psscr_table[index] = psscr_val;
> +}
> +
>  static int powernv_add_idle_states(void)
>  {
>  	struct device_node *power_mgt;
> @@ -236,6 +254,7 @@ static int powernv_add_idle_states(void)
>  		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
>  
>  	for (i = 0; i < dt_idle_states; i++) {
> +		unsigned int exit_latency, target_residency;
>  		/*
>  		 * If an idle state has exit latency beyond
>  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
> @@ -243,28 +262,33 @@ static int powernv_add_idle_states(void)
>  		 */
>  		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)

Ideally this should be called POWERNV_MAX_THRESHOLD_LATENCY_NS then

>  			continue;
> +		/*
> +		 * Firmware passes residency and latency values in ns.
> +		 * cpuidle expects it in us.
> +		 */
> +		exit_latency = ((unsigned int)latency_ns[i]) / 1000;
> +		if (!rc)
> +			target_residency = residency_ns[i] / 1000;
> +		else
> +			target_residency = 0;

Where do we get rc from? what does target_residency = 0 mean?
Balbir Singh
