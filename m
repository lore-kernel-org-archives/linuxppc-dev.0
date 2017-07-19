Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC0w14h0pzDrKK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 12:14:25 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y129so4968785pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 19:14:25 -0700 (PDT)
Date: Wed, 19 Jul 2017 12:14:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR via stop-api
 only on Hotplug
Message-ID: <20170719121412.1d89857c@roar.ozlabs.ibm.com>
In-Reply-To: <a3ba2f2ddfbe0145ca28963b487c14473a396269.1500361607.git.ego@linux.vnet.ibm.com>
References: <cover.1500361607.git.ego@linux.vnet.ibm.com>
 <a3ba2f2ddfbe0145ca28963b487c14473a396269.1500361607.git.ego@linux.vnet.ibm.com>
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

Thanks for working on these patches. We really need to get this stuff
merged and tested asap :)

On Tue, 18 Jul 2017 19:58:49 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
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
> In this patch, for POWER9, we program the stop-api for LPCR with PECE1
> bit cleared only when we are offlining the CPU.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 12 +++++++++++-
>  arch/powerpc/platforms/powernv/smp.c  | 28 ++++++++++++++++++++++++----
>  2 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 2abee07..f4a29d4 100644
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
> @@ -85,6 +85,16 @@ static int pnv_save_sprs_for_deep_states(void)
>  		if (rc != 0)
>  			return rc;
>  
> +		/*
> +		 * On POWER8, the only state that uses SLW engine is
> +		 * winkle.  This is only used for CPU-Hotplug. So we
> +		 * clear the decrementer bit from LPCR since we
> +		 * don't want to be woken up on decrementer when in
> +		 * winkle.
> +		 */
> +		if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +			lpcr_val = lpcr_val & ~(u64)LPCR_PECE1;
> +
>  		rc = opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);
>  		if (rc != 0)
>  			return rc;
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 40dae96..5f2a712 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -143,7 +143,8 @@ static void pnv_smp_cpu_kill_self(void)
>  {
>  	unsigned int cpu;
>  	unsigned long srr1, wmask;
> -
> +	uint64_t lpcr_val;
> +	uint64_t pir;
>  	/* Standard hot unplug procedure */
>  	/*
>  	 * This hard disables local interurpts, ensuring we have no lazy
> @@ -164,13 +165,17 @@ static void pnv_smp_cpu_kill_self(void)
>  	if (cpu_has_feature(CPU_FTR_ARCH_207S))
>  		wmask = SRR1_WAKEMASK_P8;
>  
> +	pir = get_hard_smp_processor_id(cpu);
>  	/* We don't want to take decrementer interrupts while we are offline,
>  	 * so clear LPCR:PECE1. We keep PECE2 (and LPCR_PECE_HVEE on P9)
>  	 * enabled as to let IPIs in.
>  	 */
> -	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
> +	lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
> +	mtspr(SPRN_LPCR, lpcr_val);
>  
>  	while (!generic_check_cpu_restart(cpu)) {
> +
> +
>  		/*
>  		 * Clear IPI flag, since we don't handle IPIs while
>  		 * offline, except for those when changing micro-threading
> @@ -180,8 +185,15 @@ static void pnv_smp_cpu_kill_self(void)
>  		 */
>  		kvmppc_set_host_ipi(cpu, 0);
>  
> +		/*
> +		 * If the CPU gets woken up by a special wakeup,
> +		 * ensure that the SLW engine sets LPCR with
> +		 * decrementer bit cleared, else we will get spurious
> +		 * wakeups.
> +		 */
> +		if (cpu_has_feature(CPU_FTR_ARCH_300))
> +			opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);

Can you put these details into pnv_cpu_offline? Possibly even from there
into another special SPR save function? E.g.,

  pnv_save_sprs_for_deep_state_decrementer_wakeup(bool decrementer_wakeup)

I'd like to put the LPCR manipulation for idle wake settings into idle.c
as well (pnv_cpu_offline), I think it fits better in there.

Thanks,
Nick
