Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCB710NJQzDrTf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 19:09:33 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y129so6214536pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 02:09:32 -0700 (PDT)
Date: Wed, 19 Jul 2017 19:09:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] powernv/powerpc: Clear PECE1 in LPCR via
 stop-api only on Hotplug
Message-ID: <20170719190913.18ca21e5@roar.ozlabs.ibm.com>
In-Reply-To: <4142c685fd33835db00eaecedf69186458c1c039.1500452107.git.ego@linux.vnet.ibm.com>
References: <cover.1500452107.git.ego@linux.vnet.ibm.com>
 <4142c685fd33835db00eaecedf69186458c1c039.1500452107.git.ego@linux.vnet.ibm.com>
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

On Wed, 19 Jul 2017 13:48:50 +0530
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
> In this patch, for POWER9, we program the stop-api for LPCR with PECE1
> bit cleared only when we are offlining the CPU.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 45 ++++++++++++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/smp.c  | 10 --------
>  2 files changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 2abee07..a6c69b7 100644
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
> @@ -355,6 +365,15 @@ void power9_idle(void)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> +static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
> +{
> +	u64 pir = get_hard_smp_processor_id(cpu);
> +
> +	mtspr(SPRN_LPCR, lpcr_val);
> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> +		opal_slw_set_reg(pir, SPRN_LPCR, lpcr_val);

Is opal_slw_set_reg very heavyweight? If not, I would just remove the
POWER9 special casing entirely from both these functions, which follows
the principle of least surprise. Otherwise I guess it's reasonable.

Thanks for making those other changes, it looks good.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
