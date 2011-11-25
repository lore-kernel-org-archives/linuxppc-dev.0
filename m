Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 848FC1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 14:41:29 +1100 (EST)
Message-ID: <1322192477.32635.15.camel@pasglop>
Subject: Re: [PATCH 5/5] powerpc/setup_{32, 64}.c: remove unneeded
 boot_cpuid{, _phys}
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew McClintock <msm@freescale.com>
Date: Fri, 25 Nov 2011 14:41:17 +1100
In-Reply-To: <1319583246-6120-5-git-send-email-msm@freescale.com>
References: <1319583246-6120-1-git-send-email-msm@freescale.com>
 <1319583246-6120-5-git-send-email-msm@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-10-25 at 17:54 -0500, Matthew McClintock wrote:
> boot_cpuid and init_thread_info.cpu are redundant, just use the
> var that stays around longer and add a define to make boot_cpuid
> point at the correct value

Breaks pseries build. Looks trivial but I haven't had a chance to fix
it (obvious one liner didn't do it and no time today).

Please re-submit fixed.

Cheers,
Ben.

> boot_cpudid_phys is not needed and can completely go away from the
> SMP case, we leave it there for the non-SMP case since the paca
> struct is not around to store this info
> 
> This patch also has the effect of having the logical cpu number
> of the boot cpu be updated correctly independently of the ordering
> of the cpu nodes in the device tree.
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> Could also just change boot_cpuid every to init_thread_info.cpu instead
> of using this define
> 
> This is only tested on 32-bit parts, only compiled on 64-bit
> 
>  arch/powerpc/include/asm/smp.h |    2 +-
>  arch/powerpc/kernel/setup_32.c |    7 ++++---
>  arch/powerpc/kernel/setup_64.c |    1 -
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index adba970..f26c554 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -29,7 +29,7 @@
>  #endif
>  #include <asm/percpu.h>
>  
> -extern int boot_cpuid;
> +#define boot_cpuid 	(init_thread_info.cpu)
>  extern int spinning_secondaries;
>  
>  extern void cpu_die(void);
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index c1ce863..f396847 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -46,10 +46,11 @@
>  
>  extern void bootx_init(unsigned long r4, unsigned long phys);
>  
> -int boot_cpuid = -1;
> -EXPORT_SYMBOL_GPL(boot_cpuid);
> -int boot_cpuid_phys;
> +/* we need a place to store phys cpu for non-SMP case */
> +#ifndef CONFIG_SMP
> +int boot_cpuid_phys = -1;
>  EXPORT_SYMBOL_GPL(boot_cpuid_phys);
> +#endif
>  
>  int smp_hw_index[NR_CPUS];
>  
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index d4168c9..eacefba 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -73,7 +73,6 @@
>  #define DBG(fmt...)
>  #endif
>  
> -int boot_cpuid = 0;
>  int __initdata spinning_secondaries;
>  u64 ppc64_pft_size;
>  
