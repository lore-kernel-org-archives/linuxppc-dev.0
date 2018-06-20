Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419XGz18cNzF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 14:41:46 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5K4dRX2073519
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 00:41:44 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jqc7s7f8k-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 00:41:44 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 19 Jun 2018 22:41:43 -0600
Date: Wed, 20 Jun 2018 10:11:37 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] powernv/cpuidle: Parse dt idle properties into
 global structure
Reply-To: ego@linux.vnet.ibm.com
References: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1529384668-27548-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529384668-27548-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20180620044137.GA21984@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Akshay,

On Tue, Jun 19, 2018 at 10:34:26AM +0530, Akshay Adiga wrote:
> Device-tree parsing happens in twice, once while deciding idle state to
> be used for hotplug and once during cpuidle init. Hence, parsing the
> device tree and caching it will reduce code duplication. Parsing code
> has been moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states().
> 
> Setting up things so that number of available idle states can be
> accessible to cpuidle-powernv driver. Hence adding nr_pnv_idle_states to
> track number of idle states.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h    |  14 +++
>  arch/powerpc/platforms/powernv/idle.c | 197 ++++++++++++++++++++++++----------
>  2 files changed, 152 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index e210a83..55ee7e3 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -79,6 +79,20 @@ struct stop_sprs {
>  	u64 mmcra;
>  };
> 
> +#define PNV_IDLE_NAME_LEN    16
> +struct pnv_idle_states_t {
> +	char name[PNV_IDLE_NAME_LEN];
> +	u32 latency_ns;
> +	u32 residency_ns;
> +	/*
> +	 * Register value/mask used to select different idle states.
> +	 * PMICR in POWER8 and PSSCR in POWER9
> +	 */
> +	u64 pm_ctrl_reg_val;
> +	u64 pm_ctrl_reg_mask;

We don't use pmicr on POWER8. So I don't mind if you rename this to
psscr_val and psscr_mask.

Or atleast have
   	   union {
	   	 u64 psscr; /* P9 onwards */
		 u64 pmicr  /* P7 and P8 */
	    } val;

	   union {
	   	 u64 psscr; /* P9 onwards */
		 u64 pmicr; /* P7 and P8 */
	   } mask;


	


> +	u32 flags;
> +};
> +
>  extern u32 pnv_fastsleep_workaround_at_entry[];
>  extern u32 pnv_fastsleep_workaround_at_exit[];
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 1c5d067..07be984 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -36,6 +36,8 @@
>  #define P9_STOP_SPR_PSSCR      855
> 
>  static u32 supported_cpuidle_states;
> +struct pnv_idle_states_t *pnv_idle_states;
> +int nr_pnv_idle_states;
> 
>  /*
>   * The default stop state that will be used by ppc_md.power_save
> @@ -625,45 +627,8 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
>  static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  					int dt_idle_states)

We are not using np, flags in this function right? Also dt_idle_states
can be obtained from the global variable nr_pnv_idle_states.


>  {
> -	u64 *psscr_val = NULL;
> -	u64 *psscr_mask = NULL;
> -	u32 *residency_ns = NULL;
>  	u64 max_residency_ns = 0;
> -	int rc = 0, i;
> -
> -	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
> -	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
> -	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
> -			       GFP_KERNEL);
> -
> -	if (!psscr_val || !psscr_mask || !residency_ns) {
> -		rc = -1;
> -		goto out;
> -	}
> -
> -	if (of_property_read_u64_array(np,
> -		"ibm,cpu-idle-state-psscr",
> -		psscr_val, dt_idle_states)) {
> -		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
> -		rc = -1;
> -		goto out;
> -	}
> -
> -	if (of_property_read_u64_array(np,
> -				       "ibm,cpu-idle-state-psscr-mask",
> -				       psscr_mask, dt_idle_states)) {
> -		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
> -		rc = -1;
> -		goto out;
> -	}
> -
> -	if (of_property_read_u32_array(np,
> -				       "ibm,cpu-idle-state-residency-ns",
> -					residency_ns, dt_idle_states)) {
> -		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
> -		rc = -1;
> -		goto out;
> -	}
> +	int i;
> 
>  	/*
>  	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
> @@ -681,31 +646,33 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	pnv_first_deep_stop_state = MAX_STOP_STATE;
>  	for (i = 0; i < dt_idle_states; i++) {
>  		int err;
> -		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
> +		struct pnv_idle_states_t *state = &pnv_idle_states[i];
> +		u64 psscr_rl = state->pm_ctrl_reg_val & PSSCR_RL_MASK;
> 
> -		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
> -		     (pnv_first_deep_stop_state > psscr_rl))
> +		if ((state->flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
> +		    (pnv_first_deep_stop_state > psscr_rl))
>  			pnv_first_deep_stop_state = psscr_rl;
> 
> -		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
> -					      flags[i]);
> +		err = validate_psscr_val_mask(&state->pm_ctrl_reg_val,
> +					      &state->pm_ctrl_reg_mask,
> +					      state->flags);


  We could have a "bool valid" field in the pnv_idle_states_t struct
  for explicitly recording any invalid states in order to prevent any
  other subsystems from using it. We are doing the validation of the
  psscr_val and mask twice today - once in this code and once again in
  the cpuidle code.
  
  
>  		if (err) {
> -			report_invalid_psscr_val(psscr_val[i], err);
> +			report_invalid_psscr_val(state->pm_ctrl_reg_val, err);
>  			continue;
>  		}
> 
> -		if (max_residency_ns < residency_ns[i]) {
> -			max_residency_ns = residency_ns[i];
> -			pnv_deepest_stop_psscr_val = psscr_val[i];
> -			pnv_deepest_stop_psscr_mask = psscr_mask[i];
> -			pnv_deepest_stop_flag = flags[i];
> +		if (max_residency_ns < state->residency_ns) {
> +			max_residency_ns = state->residency_ns;
> +			pnv_deepest_stop_psscr_val = state->pm_ctrl_reg_val;
> +			pnv_deepest_stop_psscr_mask = state->pm_ctrl_reg_mask;
> +			pnv_deepest_stop_flag = state->flags;
>  			deepest_stop_found = true;
>  		}
> 
>  		if (!default_stop_found &&
> -		    (flags[i] & OPAL_PM_STOP_INST_FAST)) {
> -			pnv_default_stop_val = psscr_val[i];
> -			pnv_default_stop_mask = psscr_mask[i];
> +		    (state->flags & OPAL_PM_STOP_INST_FAST)) {
> +			pnv_default_stop_val = state->pm_ctrl_reg_val;
> +			pnv_default_stop_mask = state->pm_ctrl_reg_mask;
>  			default_stop_found = true;
>  		}
>  	}
> @@ -728,11 +695,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
> 
>  	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
>  		pnv_first_deep_stop_state);
> -out:
> -	kfree(psscr_val);
> -	kfree(psscr_mask);
> -	kfree(residency_ns);
> -	return rc;
> +
> +	return 0;
>  }
> 
>  /*
> @@ -776,14 +740,129 @@ static void __init pnv_probe_idle_states(void)
>  out:
>  	kfree(flags);
>  }
> -static int __init pnv_init_idle_states(void)
> +
> +/*
> + * This function is use to parse device-tree and populates all the information
> + * into pnv_idle_states structure. Also it sets up nr_pnv_idle_states and
> + * the number of cpuidle states discovered through device-tree.

  "Also it sets up nr_pnv_idle_states *which is* the number of cpuidle
  states discovered through the device-tree."
  
> + */
> +
> +static int pnv_parse_cpuidle_dt(void)
>  {
> +	struct device_node *np;
> +	int nr_idle_states, i;
> +	u32 *temp_u32;
> +	u64 *temp_u64;
> +	const char **temp_string;
> +
> +	np = of_find_node_by_path("/ibm,opal/power-mgt");
> +	if (!np) {
> +		pr_warn("opal: PowerMgmt Node not found\n");
> +		return -ENODEV;
> +	}
> +	nr_idle_states = of_property_count_u32_elems(np,
> +				"ibm,cpu-idle-state-flags");
> +
> +	pnv_idle_states = kcalloc(nr_idle_states, sizeof(*pnv_idle_states),
> +				  GFP_KERNEL);
> +	temp_u32 = kcalloc(nr_idle_states, sizeof(u32),  GFP_KERNEL);
> +	temp_u64 = kcalloc(nr_idle_states, sizeof(u64),  GFP_KERNEL);
> +	temp_string = kcalloc(nr_idle_states, sizeof(char *), GFP_KERNEL);

We should ensure that the allocations has succeeded here, else
bail out and disable the idle states.
	
> +
> +	/* Read flags */
> +	if (of_property_read_u32_array(np,
> +			"ibm,cpu-idle-state-flags", temp_u32, nr_idle_states)) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
> +		goto out;
> +	}

There was some device-tree hardening in the cpuidle code which I think
can be moved to this place.

> +	for (i = 0; i < nr_idle_states; i++)
> +		pnv_idle_states[i].flags = temp_u32[i];
> 
> +	/* Read latencies */
> +	if (of_property_read_u32_array(np,
> +			"ibm,cpu-idle-state-latencies-ns", temp_u32, nr_idle_states)) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
> +		goto out;
> +	}
> +	for (i = 0; i < nr_idle_states; i++)
> +		pnv_idle_states[i].latency_ns = temp_u32[i];
> +
> +	/* Read residencies */
> +	if (of_property_read_u32_array(np,
> +			"ibm,cpu-idle-state-residency-ns", temp_u32, nr_idle_states)) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
> +		goto out;
> +	}
> +	for (i = 0; i < nr_idle_states; i++)
> +		pnv_idle_states[i].residency_ns = temp_u32[i];
> +
> +	/* For power9 */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		/* Read pm_crtl_val */
> +		if (of_property_read_u64_array(np,
> +				"ibm,cpu-idle-state-psscr", temp_u64, nr_idle_states)) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
> +			goto out;
> +		}
> +		for (i = 0; i < nr_idle_states; i++)
> +			pnv_idle_states[i].pm_ctrl_reg_val = temp_u64[i];
> +
> +		/* Read pm_crtl_mask */
> +		if (of_property_read_u64_array(np,
> +				"ibm,cpu-idle-state-psscr-mask", temp_u64, nr_idle_states)) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
> +			goto out;
> +		}
> +		for (i = 0; i < nr_idle_states; i++)
> +			pnv_idle_states[i].pm_ctrl_reg_mask = temp_u64[i];
> +	} else { /* Power8 and Power7 */
> +		/* Read pm_crtl_val */
> +		if (of_property_read_u64_array(np,
> +				"ibm,cpu-idle-state-pmicr", temp_u64, nr_idle_states)) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
> +			goto out;
> +		}
> +		for (i = 0; i < nr_idle_states; i++)
> +			pnv_idle_states[i].pm_ctrl_reg_val = temp_u64[i];
> +
> +		/* Read pm_crtl_mask */
> +		if (of_property_read_u64_array(np,
> +				"ibm,cpu-idle-state-pmicr-mask", temp_u64, nr_idle_states)) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
> +			goto out;
> +		}
> +		for (i = 0; i < nr_idle_states; i++)
> +			pnv_idle_states[i].pm_ctrl_reg_mask = temp_u64[i];

We don't use the pmicr val and the mask in the kernel for either
POWER7 or POWER8. So, is this "else" block required ?

> +
> +	}
> +	if (of_property_read_string_array(np,
> +			"ibm,cpu-idle-state-names", temp_string, nr_idle_states) < 0) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
> +		goto out;
> +	}
> +	for (i = 0; i < nr_idle_states; i++)
> +		strncpy(pnv_idle_states[i].name, temp_string[i],
> +			       PNV_IDLE_NAME_LEN);
> +	nr_pnv_idle_states = nr_idle_states;
> +out:
> +	kfree(temp_u32);
> +	kfree(temp_u64);
> +	kfree(temp_string);
> +	return 0;

We shouldn't be returning 0 we have come to "out" due to any failure
in the device-tree parsing ?

> +}
> +
> +static int __init pnv_init_idle_states(void)
> +{
> +	int rc = 0;
>  	supported_cpuidle_states = 0;
> 
> +	/* In case we error out nr_pnv_idle_states will be zero */
> +	nr_pnv_idle_states = 0;
>  	if (cpuidle_disable != IDLE_NO_OVERRIDE)
>  		goto out;
> -
> +	rc = pnv_parse_cpuidle_dt();
> +	if (rc)
> +		return rc;
>  	pnv_probe_idle_states();
>
>  	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
> -- 
> 2.5.5
> 
