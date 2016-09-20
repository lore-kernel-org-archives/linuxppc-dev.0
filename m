Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdX5l4YSYzDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 15:54:51 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 21so436085pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:54:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] powernv:idle:Implement lite variant of
 power_enter_stop
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
 <86d28da16d5bf66f111cc93eea3f000e41faff57.1474015799.git.ego@linux.vnet.ibm.com>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <a7ad3c83-b6cd-0a20-5775-b7f41c5a6d23@gmail.com>
Date: Tue, 20 Sep 2016 15:54:43 +1000
MIME-Version: 1.0
In-Reply-To: <86d28da16d5bf66f111cc93eea3f000e41faff57.1474015799.git.ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/09/16 19:47, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> This patch adds a function named power_enter_stop_lite() that can
> execute a stop instruction when ESL and EC bits are set to zero in the
> PSSCR.  The function handles the wake-up from idle at the instruction
> immediately after the stop instruction.
> 
> If the flag OPAL_PM_WAKEUP_AT_NEXT_INST[1] is set in the device tree
> for a stop state, then use the lite variant for that particular stop
> state.
> 
> [1] : The corresponding patch in skiboot that defines
>       OPAL_PM_WAKEUP_AT_NEXT_INST and enables it in the device tree
>       can be found here:
>       https://lists.ozlabs.org/pipermail/skiboot/2016-September/004805.html
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h   |  1 +
>  arch/powerpc/include/asm/processor.h  |  3 ++-
>  arch/powerpc/kernel/idle_book3s.S     | 28 +++++++++++++++++++++++++---
>  arch/powerpc/platforms/powernv/idle.c | 17 ++++++++++++++---
>  arch/powerpc/platforms/powernv/smp.c  |  2 +-
>  drivers/cpuidle/cpuidle-powernv.c     | 24 ++++++++++++++++++++++--
>  6 files changed, 65 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index 0e2e57b..6e5741e 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -179,6 +179,7 @@
>  #define OPAL_PM_TIMEBASE_STOP		0x00000002
>  #define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
>  #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
> +#define OPAL_PM_WAKEUP_AT_NEXT_INST	0x00008000
>  #define OPAL_PM_NAP_ENABLED		0x00010000
>  #define OPAL_PM_SLEEP_ENABLED		0x00020000
>  #define OPAL_PM_WINKLE_ENABLED		0x00040000
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 68e3bf5..e0549a0 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -460,7 +460,8 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
>  extern unsigned long power7_nap(int check_irq);
>  extern unsigned long power7_sleep(void);
>  extern unsigned long power7_winkle(void);
> -extern unsigned long power9_idle_stop(unsigned long stop_level);
> +extern unsigned long power9_idle_stop(unsigned long stop_level,
> +				unsigned long exec_lite);
>  
>  extern void flush_instruction_cache(void);
>  extern void hard_reset_now(void);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 32d666b..47ee106 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -43,6 +43,8 @@
>  #define PSSCR_HV_TEMPLATE	PSSCR_ESL | PSSCR_EC | \
>  				PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
>  				PSSCR_MTL_MASK
> +#define PSSCR_HV_TEMPLATE_LITE	PSSCR_PSLL_MASK | PSSCR_TR_MASK | \
> +				 PSSCR_MTL_MASK
>  
>  	.text
>  
> @@ -246,6 +248,20 @@ enter_winkle:
>  
>  	IDLE_STATE_ENTER_SEQ_NORET(PPC_WINKLE)
>  
> +
> +/*
> + * power_enter_stop_lite : This will resume the wake up from
> + * idle at the subsequent instruction.
> + *
> + * Caller should set ESL=EC=0 in PSSCR before calling
> + * this function.
> + *
> + */
> +power_enter_stop_lite:
> +	IDLE_STATE_ENTER_SEQ(PPC_STOP)
> +7:	li	r3,0  /* Since we didn't lose state, return 0 */
> +	b 	pnv_wakeup_noloss
> +
>  /*
>   * r3 - requested stop state
>   */
> @@ -333,13 +349,19 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>  
>  /*
>   * r3 - requested stop state
> + * r4 - Indicates if the lite variant with ESL=EC=0 should be executed.
>   */
>  _GLOBAL(power9_idle_stop)
> -	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
> -	or	r4,r4,r3
> +	cmpdi	r4, 1
> +	bne	4f
> +	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE_LITE)
> +	LOAD_REG_ADDR(r5,power_enter_stop_lite)
> +	b 	5f
> +4:	LOAD_REG_IMMEDIATE(r4, PSSCR_HV_TEMPLATE)
> +	LOAD_REG_ADDR(r5,power_enter_stop)
> +5:	or	r4,r4,r3
>  	mtspr	SPRN_PSSCR, r4
>  	li	r4, 1
> -	LOAD_REG_ADDR(r5,power_enter_stop)
>  	b	pnv_powersave_common
>  	/* No return */
>  /*
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 479c256..c3d3fed 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -244,8 +244,15 @@ static DEVICE_ATTR(fastsleep_workaround_applyonce, 0600,
>  static void power9_idle(void)
>  {
>  	/* Requesting stop state 0 */
> -	power9_idle_stop(0);
> +	power9_idle_stop(0, 0);
>  }
> +
> +static void power9_idle_lite(void)
> +{
> +	/* Requesting stop state 0 with ESL=EC=0 */
> +	power9_idle_stop(0, 1);
> +}
> +
>  /*
>   * First deep stop state. Used to figure out when to save/restore
>   * hypervisor context.
> @@ -414,8 +421,12 @@ static int __init pnv_init_idle_states(void)
>  
>  	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
>  		ppc_md.power_save = power7_idle;
> -	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
> -		ppc_md.power_save = power9_idle;
> +	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST) {
> +		if (supported_cpuidle_states & OPAL_PM_WAKEUP_AT_NEXT_INST)
> +			ppc_md.power_save = power9_idle_lite;
> +		else
> +			ppc_md.power_save = power9_idle;
> +	}

If I am reading this correctly we decide at boot time whether we support
wakeup at next instruction and make that the default sleep state. I am a little
surprised that these are exclusive. I was expecting power9_idle_lite to be
one of the states to go into before power9_idle

Balbir Singh.
