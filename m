Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdcZR3GCwzDvwx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 11:16:47 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id p66so349385pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 16:16:47 -0800 (PST)
Subject: Re: [PATCH v4 3/4] powernv: Pass PSSCR value and mask to
 power9_idle_stop
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
 <31b1024af69726cdf3cfb25413fc3dff28fa3547.1481288905.git.ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <b2b6c3c6-f564-6970-0281-dfddc739dda4@gmail.com>
Date: Wed, 14 Dec 2016 11:16:26 +1100
MIME-Version: 1.0
In-Reply-To: <31b1024af69726cdf3cfb25413fc3dff28fa3547.1481288905.git.ego@linux.vnet.ibm.com>
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
> The power9_idle_stop method currently takes only the requested stop
> level as a parameter and picks up the rest of the PSSCR bits from a
> hand-coded macro. This is not a very flexible design, especially when
> the firmware has the capability to communicate the psscr value and the
> mask associated with a particular stop state via device tree.
> 
> This patch modifies the power9_idle_stop API to take as parameters the
> PSSCR value and the PSSCR mask corresponding to the stop state that
> needs to be set. These PSSCR value and mask are respectively obtained
> by parsing the "ibm,cpu-idle-state-psscr" and
> "ibm,cpu-idle-state-psscr-mask" fields from the device tree.
> 
> In addition to this, the patch adds support for handling stop states
> for which ESL and EC bits in the PSSCR are zero. As per the
> architecture, a wakeup from these stop states resumes execution from
> the subsequent instruction as opposed to waking up at the System
> Vector.
> 
> The older firmware sets only the Requested Level (RL) field in the
> psscr and psscr-mask exposed in the device tree. For older firmware
> where psscr-mask=0xf, this patch will set the default sane values that
> the set for for remaining PSSCR fields (i.e PSLL, MTL, ESL, EC, and
> TR).
> 
> This skiboot patch that exports fully populated PSSCR values and the
> mask for all the stop states can be found here:
> https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h       | 41 ++++++++++++++++
>  arch/powerpc/include/asm/processor.h     |  3 +-
>  arch/powerpc/kernel/idle_book3s.S        | 31 +++++++-----
>  arch/powerpc/platforms/powernv/idle.c    | 81 ++++++++++++++++++++++++++------
>  arch/powerpc/platforms/powernv/powernv.h |  3 +-
>  arch/powerpc/platforms/powernv/smp.c     | 14 +++---
>  drivers/cpuidle/cpuidle-powernv.c        | 40 +++++++++++-----
>  7 files changed, 169 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index 0a3255b..fa0b6c0 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -10,11 +10,52 @@
>  #define PNV_CORE_IDLE_LOCK_BIT          0x100
>  #define PNV_CORE_IDLE_THREAD_BITS       0x0FF
>  
> +/*
> + * ============================ NOTE =================================
> + * The older firmware populates only the RL field in the psscr_val and
> + * sets the psscr_mask to 0xf. On such a firmware, the kernel sets the
> + * remaining PSSCR fields to default values as follows:
> + *
> + * - ESL and EC bits are to 1. So wakeup from any stop state will be
> + *   at vector 0x100.
> + *
> + * - MTL and PSLL are set to the maximum allowed value as per the ISA,
> + *    i.e. 15.
> + *
> + * - The Transition Rate, TR is set to the Maximum value 3.
> + */
> +#define PSSCR_HV_DEFAULT_VAL    (PSSCR_ESL | PSSCR_EC |		    \
> +				PSSCR_PSLL_MASK | PSSCR_TR_MASK |   \
> +				PSSCR_MTL_MASK)
> +
> +#define PSSCR_HV_DEFAULT_MASK   (PSSCR_ESL | PSSCR_EC |		    \
> +				PSSCR_PSLL_MASK | PSSCR_TR_MASK |   \
> +				PSSCR_MTL_MASK | PSSCR_RL_MASK)
> +
>  #ifndef __ASSEMBLY__
>  extern u32 pnv_fastsleep_workaround_at_entry[];
>  extern u32 pnv_fastsleep_workaround_at_exit[];
>  
>  extern u64 pnv_first_deep_stop_state;
> +
> +static inline u64 compute_psscr_val(u64 psscr_val, u64 psscr_mask)
> +{
> +	/*
> +	 * psscr_mask == 0xf indicates an older firmware.
> +	 * Set remaining fields of psscr to the default values.
> +	 * See NOTE above definition of PSSCR_HV_DEFAULT_VAL
> +	 */
> +	if (psscr_mask == 0xf)
> +		return psscr_val | PSSCR_HV_DEFAULT_VAL;
> +	return psscr_val;
> +}
> +
> +static inline u64 compute_psscr_mask(u64 psscr_mask)
> +{
> +	if (psscr_mask == 0xf)
> +		return PSSCR_HV_DEFAULT_MASK;
> +	return psscr_mask;
> +}
>  #endif
>  
>  #endif
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index c07c31b..422becd 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -458,7 +458,8 @@ static inline unsigned long get_clean_sp(unsigned long sp, int is_32)
>  extern unsigned long power7_nap(int check_irq);
>  extern unsigned long power7_sleep(void);
>  extern unsigned long power7_winkle(void);
> -extern unsigned long power9_idle_stop(unsigned long stop_level);
> +extern unsigned long power9_idle_stop(unsigned long stop_psscr_val,
> +				      unsigned long stop_psscr_mask);
>  
>  extern void flush_instruction_cache(void);
>  extern void hard_reset_now(void);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index be90e2f..37ee533 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -40,9 +40,7 @@
>  #define _WORC	GPR11
>  #define _PTCR	GPR12
>  
> -#define PSSCR_HV_TEMPLATE	PSSCR_ESL | PSSCR_EC | \
> -				PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
> -				PSSCR_MTL_MASK
> +#define PSSCR_EC_ESL_MASK_SHIFTED          (PSSCR_EC | PSSCR_ESL) >> 16
>  
>  	.text
>  
> @@ -264,7 +262,7 @@ enter_winkle:
>  	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
>  
>  /*
> - * r3 - requested stop state
> + * r3 - PSSCR value corresponding to the requested stop state.
>   */
>  power_enter_stop:
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> @@ -274,9 +272,19 @@ power_enter_stop:
>  	stb	r4,HSTATE_HWTHREAD_STATE(r13)
>  #endif
>  /*
> + * Check if we are executing the lite variant with ESL=EC=0
> + */
> +	andis.   r4, r3, PSSCR_EC_ESL_MASK_SHIFTED

r4 = psscr & (PSSCR_EC | PSSCR_ESL)

> +	andi.    r3, r3, PSSCR_RL_MASK   /* r3 = requested stop state */

r3 = psscr & RL_MASK (requested mask). 

Why do we do and andis. followed by andi. and a compdi below?

> +	cmpdi	 r4, 0

r4 == 0 implies we either both PSSCR_EC|ESL are cleared.
I am not sure if our checks for EC are well defined/implemented.
Should we worry about EC at all at this point?

> +	bne	 1f
> +	IDLE_STATE_ENTER_SEQ(PPC_STOP)
> +	li	r3,0  /* Since we didn't lose state, return 0 */
> +	b 	pnv_wakeup_noloss
> +/*
>   * Check if the requested state is a deep idle state.
>   */
> -	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
> +1:	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
>  	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
>  	cmpd	r3,r4
>  	bge	2f
> @@ -353,16 +361,17 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>  	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
>  20:	nop;
>  
> -

Spurious change?

>  /*
> - * r3 - requested stop state
> + * r3 - The PSSCR value corresponding to the stop state.
> + * r4 - The PSSCR mask corrresonding to the stop state.
>   */
>  _GLOBAL(power9_idle_stop)
> -	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
> -	or	r4,r4,r3
> -	mtspr	SPRN_PSSCR, r4
> -	li	r4, 1
> +	mfspr   r5, SPRN_PSSCR
> +	andc    r5, r5, r4
> +	or      r3, r3, r5
> +	mtspr 	SPRN_PSSCR, r3
>  	LOAD_REG_ADDR(r5,power_enter_stop)
> +	li	r4, 1
>  	b	pnv_powersave_common
>  	/* No return */
>  /*
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 479c256..663c6ef 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -237,15 +237,21 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
>  			show_fastsleep_workaround_applyonce,
>  			store_fastsleep_workaround_applyonce);
>  
> +/*
> + * The default stop state that will be used by ppc_md.power_save
> + * function on platforms that support stop instruction.
> + */
> +u64 pnv_default_stop_val;
> +u64 pnv_default_stop_mask;
>  
>  /*
>   * Used for ppc_md.power_save which needs a function with no parameters
>   */
>  static void power9_idle(void)
>  {
> -	/* Requesting stop state 0 */
> -	power9_idle_stop(0);
> +	power9_idle_stop(pnv_default_stop_val, pnv_default_stop_mask);
>  }
> +
>  /*
>   * First deep stop state. Used to figure out when to save/restore
>   * hypervisor context.
> @@ -253,9 +259,11 @@ static void power9_idle(void)
>  u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
>  
>  /*
> - * Deepest stop idle state. Used when a cpu is offlined
> + * psscr value and mask of the deepest stop idle state.
> + * Used when a cpu is offlined.
>   */
> -u64 pnv_deepest_stop_state;
> +u64 pnv_deepest_stop_psscr_val;
> +u64 pnv_deepest_stop_psscr_mask;
>  
>  /*
>   * Power ISA 3.0 idle initialization.
> @@ -302,28 +310,58 @@ static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
>  					int dt_idle_states)

In some cases we say power9 and arch300 in others, not related to this patchset, but just a generic comment

>  {
>  	u64 *psscr_val = NULL;
> +	u64 *psscr_mask = NULL;
> +	u32 *residency_ns = NULL;
> +	u64 max_residency_ns = 0;
>  	int rc = 0, i;
> +	bool default_stop_found = false;
>  
> -	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> -				GFP_KERNEL);
> -	if (!psscr_val) {
> +	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
> +	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
> +	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
> +			       GFP_KERNEL);
> +
> +	if (!psscr_val || !psscr_mask || !residency_ns) {
>  		rc = -1;
>  		goto out;
>  	}
> +
>  	if (of_property_read_u64_array(np,
>  		"ibm,cpu-idle-state-psscr",
>  		psscr_val, dt_idle_states)) {
> -		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	if (of_property_read_u64_array(np,
> +				       "ibm,cpu-idle-state-psscr-mask",
> +				       psscr_mask, dt_idle_states)) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
> +		rc = -1;
> +		goto out;
> +	}
> +
> +	if (of_property_read_u32_array(np,
> +				       "ibm,cpu-idle-state-residency-ns",
> +					residency_ns, dt_idle_states)) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
>  		rc = -1;
>  		goto out;
>  	}
>  
>  	/*
> -	 * Set pnv_first_deep_stop_state and pnv_deepest_stop_state.
> +	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
> +	 * and the pnv_default_stop_{val,mask}.
> +	 *
>  	 * pnv_first_deep_stop_state should be set to the first stop
>  	 * level to cause hypervisor state loss.
> -	 * pnv_deepest_stop_state should be set to the deepest stop
> -	 * stop state.
> +	 *
> +	 * pnv_deepest_stop_{val,mask} should be set to values corresponding to
> +	 * the deepest stop state.
> +	 *
> +	 * pnv_default_stop_{val,mask} should be set to values corresponding to
> +	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
>  	 */
>  	pnv_first_deep_stop_state = MAX_STOP_STATE;
>  	for (i = 0; i < dt_idle_states; i++) {
> @@ -333,12 +371,27 @@ static int __init pnv_arch300_idle_init(struct device_node *np, u32 *flags,
>  		     (pnv_first_deep_stop_state > psscr_rl))
>  			pnv_first_deep_stop_state = psscr_rl;
>  
> -		if (pnv_deepest_stop_state < psscr_rl)
> -			pnv_deepest_stop_state = psscr_rl;
> -	}
> +		if (max_residency_ns < residency_ns[i]) {
> +			max_residency_ns = residency_ns[i];
> +			pnv_deepest_stop_psscr_val =
> +				compute_psscr_val(psscr_val[i], psscr_mask[i]);
> +			pnv_deepest_stop_psscr_mask =
> +				compute_psscr_mask(psscr_mask[i]);
> +		}
>  

Does it make sense to have them sorted and then use the last value from the array?


Balbir Singh
