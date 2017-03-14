Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjGjj0rd8zDqYX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 01:06:00 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g2so20242812pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:06:00 -0700 (PDT)
Date: Wed, 15 Mar 2017 00:05:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] powernv:idle: Don't override default/deepest
 directly in kernel
Message-ID: <20170315000543.599ac505@roar.ozlabs.ibm.com>
In-Reply-To: <d8ca81ac95beaa82feae91a9028b98be3334c589.1489383815.git.ego@linux.vnet.ibm.com>
References: <cover.1489383815.git.ego@linux.vnet.ibm.com>
 <d8ca81ac95beaa82feae91a9028b98be3334c589.1489383815.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 13 Mar 2017 11:31:27 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently during idle-init on power9, if we don't find suitable stop
> states in the device tree that can be used as the
> default_stop/deepest_stop, we set stop0 (ESL=1,EC=1) as the default
> stop state psscr to be used by power9_idle and deepest stop state
> which is used by CPU-Hotplug.
> 
> However, if the platform firmware has not configured or enabled a stop
> state, the kernel should not make any assumptions and fallback to a
> default choice.
> 
> If the kernel uses a stop state that is not configured by the platform
> firmware, it may lead to further failures which should be avoided.
> 
> In this patch, we modify the init code to ensure that the kernel uses
> only the stop states exposed by the firmware through the device
> tree. When a suitable default stop state isn't found, we disable
> ppc_md.power_save for power9. Similarly, when a suitable
> deepest_stop_state is not found in the device tree exported by the
> firmware, fall back to the default busy-wait loop in the CPU-Hotplug
> code.

Seems reasonable. I have a few comments that you may consider. Nothing
too major.

Btw., it would be nice to move this hotplug idling selection code to
idle.c. Have the hotplug just ask to enter the best available idle mode
and that's it. I'm not asking you to do that for this series, but perhaps
consider it for the future.


> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 4ee837e..9fde6e4 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -147,7 +147,6 @@ u32 pnv_get_supported_cpuidle_states(void)
>  }
>  EXPORT_SYMBOL_GPL(pnv_get_supported_cpuidle_states);
>  
> -
>  static void pnv_fastsleep_workaround_apply(void *info)
>  
>  {
> @@ -243,6 +242,7 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
>   */
>  u64 pnv_default_stop_val;
>  u64 pnv_default_stop_mask;
> +bool default_stop_found;
>  
>  /*
>   * Used for ppc_md.power_save which needs a function with no parameters
> @@ -264,6 +264,7 @@ static void power9_idle(void)
>   */
>  u64 pnv_deepest_stop_psscr_val;
>  u64 pnv_deepest_stop_psscr_mask;
> +bool deepest_stop_found;
>  
>  /*
>   * Power ISA 3.0 idle initialization.

If the hotplug idle code was in idle.c, then all this deepest/default stop
logic and register settings would be static to idle.c, which would be nice.

If you have a function to check if deepest stop is found, then you don't need
a non-static variable here (or for default_stop_found AFAIKS).


> @@ -352,7 +353,6 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	u32 *residency_ns = NULL;
>  	u64 max_residency_ns = 0;
>  	int rc = 0, i;
> -	bool default_stop_found = false, deepest_stop_found = false;
>  
>  	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
>  	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
> @@ -433,20 +433,22 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	}
>  
>  	if (!default_stop_found) {
> -		pnv_default_stop_val = PSSCR_HV_DEFAULT_VAL;
> -		pnv_default_stop_mask = PSSCR_HV_DEFAULT_MASK;
> -		pr_warn("Setting default stop psscr val=0x%016llx,mask=0x%016llx\n",
> +		pr_warn("powernv:idle: Default stop not found. Disabling ppcmd.powersave\n");
> +	} else {
> +		pr_info("powernv:idle: Default stop: psscr = 0x%016llx,mask=0x%016llx\n",
>  			pnv_default_stop_val, pnv_default_stop_mask);
>  	}
>  
>  	if (!deepest_stop_found) {
> -		pnv_deepest_stop_psscr_val = PSSCR_HV_DEFAULT_VAL;
> -		pnv_deepest_stop_psscr_mask = PSSCR_HV_DEFAULT_MASK;
> -		pr_warn("Setting default stop psscr val=0x%016llx,mask=0x%016llx\n",
> +		pr_warn("powernv:idle: Deepest stop not found. CPU-Hotplug is affected\n");

I guess these warnings are meant for developers, but it might be nice
to make them slightly more meaningful? Prefix of choice seems to be
"cpuidle-powernv:"

Then you could have "no suitable stop state provided by firmware. Disabling
idle power saving" and "no suitable stop state provided by firmware. Offlined
CPUs will busy-wait", perhaps?

Just a suggestion.

> +	} else {
> +		pr_info("powernv:idle: Deepest stop: psscr = 0x%016llx,mask=0x%016llx\n",
>  			pnv_deepest_stop_psscr_val,
>  			pnv_deepest_stop_psscr_mask);
>  	}
>  
> +	pr_info("powernv:idle: RL value of first deep stop = 0x%llx\n",
> +		pnv_first_deep_stop_state);

cpuidle-powernv: prefix for these too?

>  out:
>  	kfree(psscr_val);
>  	kfree(psscr_mask);
> @@ -454,6 +456,12 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	return rc;
>  }
>  
> +bool pnv_check_deepest_stop(void)
> +{
> +	return deepest_stop_found;
> +}
> +EXPORT_SYMBOL_GPL(pnv_check_deepest_stop);

Does this need to be exported? AFAIKS it's not used in a module.

> +
>  /*
>   * Probe device tree for supported idle states
>   */
> @@ -526,7 +534,8 @@ static int __init pnv_init_idle_states(void)
>  
>  	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
>  		ppc_md.power_save = power7_idle;
> -	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
> +	else if ((supported_cpuidle_states & OPAL_PM_STOP_INST_FAST) &&
> +		 default_stop_found)
>  		ppc_md.power_save = power9_idle;
>  
>  out:

Is this the only use of default_stop_found? & OPAL_PM_STOP_INST_FAST
should always be the same as default_stop_found value, no? In that case
can you just remove the OPAL_PM_STOP_INST_FAST test here? (I like the
boolean and prefer the default idle state selection logic to stay in the
idle init above where you have it commented).


> diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
> index 6130522..9acd5eb 100644
> --- a/arch/powerpc/platforms/powernv/powernv.h
> +++ b/arch/powerpc/platforms/powernv/powernv.h
> @@ -18,6 +18,7 @@ static inline void pnv_pci_shutdown(void) { }
>  #endif
>  
>  extern u32 pnv_get_supported_cpuidle_states(void);
> +bool pnv_check_deepest_stop(void);
>  extern u64 pnv_deepest_stop_psscr_val;
>  extern u64 pnv_deepest_stop_psscr_mask;
>  
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 8d5b99e..3f66e6f 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -140,6 +140,7 @@ static void pnv_smp_cpu_kill_self(void)
>  	unsigned int cpu;
>  	unsigned long srr1, wmask;
>  	u32 idle_states;
> +	bool deepest_stop_found;
>  
>  	/* Standard hot unplug procedure */
>  	local_irq_disable();
> @@ -155,6 +156,7 @@ static void pnv_smp_cpu_kill_self(void)
>  		wmask = SRR1_WAKEMASK_P8;
>  
>  	idle_states = pnv_get_supported_cpuidle_states();
> +	deepest_stop_found = pnv_check_deepest_stop();
>  
>  	/* We don't want to take decrementer interrupts while we are offline,
>  	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
> @@ -184,7 +186,11 @@ static void pnv_smp_cpu_kill_self(void)
>  
>  		ppc64_runlatch_off();
>  
> -		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
> +			pr_info("CPU %u offlining with psscr = 0x%016llx\n",
> +				cpu, pnv_deepest_stop_psscr_val);
> +			pr_info("CPU%d down paca pir %016x pir %lx\n",
> +				cpu, hard_smp_processor_id(), mfspr(SPRN_PIR));

How much log info is appropriate here?

>  			srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
>  						pnv_deepest_stop_psscr_mask);
>  		} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
