Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHWqZ1plPzDqmw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 20:41:14 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 123so6429208pgj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 03:41:14 -0700 (PDT)
Date: Wed, 26 Jul 2017 20:40:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND] [v3 PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR
 via stop-api only on Hotplug
Message-ID: <20170726204056.36233b13@roar.ozlabs.ibm.com>
In-Reply-To: <1500634894-18352-1-git-send-email-ego@linux.vnet.ibm.com>
References: <cover.1500631040.git.ego@linux.vnet.ibm.com>
 <1500634894-18352-1-git-send-email-ego@linux.vnet.ibm.com>
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

On Fri, 21 Jul 2017 16:31:34 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently we use the stop-api provided by the firmware to program the
> SLW engine to restore the values of hypervisor resources that get lost
> on deeper idle states (such as winkle). Since the deep states were
> only used for CPU-Hotplug on POWER8 systems, we would program the LPCR
> to have the PECE1 bit since Hotplugged CPUs shouldn't be spuriously
> woken up by decrementer.
> 
> On POWER9, some of the deep platform idle states such as stop4 can be
> used in cpuidle as well. In this case, we want the CPU in stop4 to be
> woken up by the decrementer when some timer on the CPU expires.
> 
> In this patch, we program the stop-api for LPCR with PECE1
> bit cleared only when we are offlining the CPU and set it
> back once the CPU is online.

Looks pretty good to me, thanks!

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> v2 --> v3:
> - Program the LPCR during platform idle entry/exit on both POWER8 and
>   POWER9
> 
> v1 --> v2:
> - Move the LPCR manipulations for CPU-Hotplug into idle.c
> 
>  arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/smp.c  |  8 --------
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 2abee07..a1296e7 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -68,7 +68,7 @@ static int pnv_save_sprs_for_deep_states(void)
>  	 * all cpus at boot. Get these reg values of current cpu and use the
>  	 * same across all cpus.
>  	 */
> -	uint64_t lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
> +	uint64_t lpcr_val = mfspr(SPRN_LPCR);
>  	uint64_t hid0_val = mfspr(SPRN_HID0);
>  	uint64_t hid1_val = mfspr(SPRN_HID1);
>  	uint64_t hid4_val = mfspr(SPRN_HID4);
> @@ -355,6 +355,14 @@ void power9_idle(void)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> +static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
> +{
> +	u64 pir = get_hard_smp_processor_id(cpu);
> +
> +	mtspr(SPRN_LPCR, lpcr_val);
> +	opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
> +}
> +
>  /*
>   * pnv_cpu_offline: A function that puts the CPU into the deepest
>   * available platform idle state on a CPU-Offline.
> @@ -364,6 +372,20 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  {
>  	unsigned long srr1;
>  	u32 idle_states = pnv_get_supported_cpuidle_states();
> +	u64 lpcr_val;
> +
> +	/*
> +	 * We don't want to take decrementer interrupts while we are
> +	 * offline, so clear LPCR:PECE1. We keep PECE2 (and
> +	 * LPCR_PECE_HVEE on P9) enabled as to let IPIs in.
> +	 *
> +	 * If the CPU gets woken up by a special wakeup, ensure that
> +	 * the SLW engine sets LPCR with decrementer bit cleared, else
> +	 * the CPU will come back to the kernel due to a spurious
> +	 * wakeup.
> +	 */
> +	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
> +	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
>  
>  	__ppc64_runlatch_off();
>  
> @@ -394,6 +416,16 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  
>  	__ppc64_runlatch_on();
>  
> +	/*
> +	 * Re-enable decrementer interrupts in LPCR.
> +	 *
> +	 * Further, we want stop states to be woken up by decrementer
> +	 * for non-hotplug cases. So program the LPCR via stop api as
> +	 * well.
> +	 */
> +	lpcr_val = mfspr(SPRN_LPCR) | (u64)LPCR_PECE1;
> +	pnv_program_cpu_hotplug_lpcr(cpu, lpcr_val);
> +
>  	return srr1;
>  }
>  #endif
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 40dae96..536b07b 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -164,12 +164,6 @@ static void pnv_smp_cpu_kill_self(void)
>  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>  		wmask = SRR1_WAKEMASK_P8;
>  
> -	/* We don't want to take decrementer interrupts while we are offline,
> -	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
> -	 * enabled as to let IPIs in.
> -	 */
> -	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
> -
>  	while (!generic_check_cpu_restart(cpu)) {
>  		/*
>  		 * Clear IPI flag, since we don't handle IPIs while
> @@ -219,8 +213,6 @@ static void pnv_smp_cpu_kill_self(void)
>  
>  	}
>  
> -	/* Re-enable decrementer interrupts */
> -	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_PECE1);
>  	DBG("CPU%d coming online...\n", cpu);
>  }
>  
