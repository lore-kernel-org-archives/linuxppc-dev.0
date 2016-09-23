Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sgVpp6Z48zDsn4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2016 21:03:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powernv:idle:Implement lite variant of
 power_enter_stop
In-Reply-To: <86d28da16d5bf66f111cc93eea3f000e41faff57.1474015799.git.ego@linux.vnet.ibm.com>
References: <cover.1474015799.git.ego@linux.vnet.ibm.com>
 <86d28da16d5bf66f111cc93eea3f000e41faff57.1474015799.git.ego@linux.vnet.ibm.com>
Date: Fri, 23 Sep 2016 21:03:45 +1000
Message-ID: <871t0a98tq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

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

Hi Gautham,

It seems to me that this would be cleaner if it was modelled as a new
stop state? Surely it must have different power saving characteristics
to the existing state?

> [1] : The corresponding patch in skiboot that defines
>       OPAL_PM_WAKEUP_AT_NEXT_INST and enables it in the device tree
>       can be found here:
>       https://lists.ozlabs.org/pipermail/skiboot/2016-September/004805.html

Which says "This will reduce the exit latency of the idle state", and
yet it doesn't change any of the latency/residency values?

If all it does is reduce the exit latency, then shouldn't we always use
it? Presumably it also saves less power?

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

Why do we have these at all? Firmware tells us the PSSCR values to use
in the "ibm,cpu-idle-state-psscr" property.

If we just used what firmware gave us then we wouldn't need the above,
or the juggling below.

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
>  }

That seems like the root of the problem, why aren't we passing a PSSCR
value here?

I also don't see us using the psscr-mask property anywhere. Why isn't
that a bug?

cheers
