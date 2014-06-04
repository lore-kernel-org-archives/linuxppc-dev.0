Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 35A241A0835
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 18:03:19 +1000 (EST)
Message-ID: <1401868995.9903.4.camel@concordia>
Subject: Re: [PATCH 2/2] powerpc/powernv: Enable POWER8 doorbell IPIs
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Date: Wed, 04 Jun 2014 18:03:15 +1000
In-Reply-To: <1401692223-28337-2-git-send-email-mikey@neuling.org>
References: <1401692223-28337-1-git-send-email-mikey@neuling.org>
 <1401692223-28337-2-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-02 at 16:57 +1000, Michael Neuling wrote:
> This patch enables POWER8 doorbell IPIs on powernv.
> 
> Since doorbells can only IPI within a core, we test to see when we can use
> doorbells and if not we fall back to XICS.  This also enables hypervisor
> doorbells to wakeup us up from nap/sleep via the LPCR PECEDH bit.
> 
> Based on tests by Anton, the best case IPI latency between two threads dropped
> from 894ns to 512ns.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/kernel/cpu_setup_power.S | 2 ++
>  arch/powerpc/platforms/powernv/smp.c  | 6 ++++++
>  arch/powerpc/sysdev/xics/icp-native.c | 9 ++++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 1557e7c..4673353 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -56,6 +56,7 @@ _GLOBAL(__setup_cpu_power8)
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
>  	mfspr	r3,SPRN_LPCR
> +	ori	r3, r3, LPCR_PECEDH
>  	bl	__init_LPCR
>  	bl	__init_HFSCR
>  	bl	__init_tlb_power8
> @@ -74,6 +75,7 @@ _GLOBAL(__restore_cpu_power8)
>  	li	r0,0
>  	mtspr	SPRN_LPID,r0
>  	mfspr   r3,SPRN_LPCR
> +	ori	r3, r3, LPCR_PECEDH
>  	bl	__init_LPCR
>  	bl	__init_HFSCR
>  	bl	__init_tlb_power8
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 0062a43..5fcfcf4 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -32,6 +32,7 @@
>  #include <asm/opal.h>
>  #include <asm/runlatch.h>
>  #include <asm/code-patching.h>
> +#include <asm/dbell.h>
>  
>  #include "powernv.h"
>  
> @@ -46,6 +47,11 @@ static void pnv_smp_setup_cpu(int cpu)
>  {
>  	if (cpu != boot_cpuid)
>  		xics_setup_cpu();
> +
> +#ifdef CONFIG_PPC_DOORBELL
> +	if (cpu_has_feature(CPU_FTR_DBELL))
> +		doorbell_setup_this_cpu();
> +#endif
>  }

Where does CONFIG_PPC_DOORBELL get set?

It looks like the only place you can be getting it is from CONFIG_PPC_PSERIES.
If you build a POWERNV only kernel it will get disabled, which I don't think is
what we want.

I think we should select it for POWERNV as well as PSERIES. That would mean
it's always enabled for any build of the files you touch, so you shouldn't need
the #ifdefs.

cheers
