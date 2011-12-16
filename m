Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E66A41007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2011 14:13:07 +1100 (EST)
Message-ID: <1324005174.4875.0.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded
 boot_cpuid{, _phys}
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew McClintock <msm@freescale.com>
Date: Fri, 16 Dec 2011 14:12:54 +1100
In-Reply-To: <1322540669-6834-1-git-send-email-msm@freescale.com>
References: <1322192477.32635.15.camel@pasglop>
 <1322540669-6834-1-git-send-email-msm@freescale.com>
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

On Mon, 2011-11-28 at 22:24 -0600, Matthew McClintock wrote:
> boot_cpuid and init_thread_info.cpu are redundant, just use the
> var that stays around longer and add a define to make boot_cpuid
> point at the correct value
> 
> boot_cpudid_phys is not needed and can completly go away from the
> SMP case, we leave it there for the non-SMP case since the paca
> struct is not around to store this info
> 
> This patch also has the effect of having the logical cpu number
> of the boot cpu be updated correctly independently of the ordering
> of the cpu nodes in the device tree.

So what about head_fsl_booke.S comparing boot_cpuid to -1 ? That seems
to be broken now in at least 2 ways, boot_cpuid doesn't exist anymore
and you don't initialize it to -1 either...

Cheers,
Ben.

> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
> v2: Fix compile issue for peries
>     Remove '-1' initial value
> 
>  arch/powerpc/include/asm/smp.h         |    2 +-
>  arch/powerpc/kernel/setup_32.c         |    5 +++--
>  arch/powerpc/kernel/setup_64.c         |    1 -
>  arch/powerpc/sysdev/xics/xics-common.c |    1 +
>  4 files changed, 5 insertions(+), 4 deletions(-)
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
> index ac76108..8d4df4c 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -46,10 +46,11 @@
>  
>  extern void bootx_init(unsigned long r4, unsigned long phys);
>  
> -int boot_cpuid = -1;
> -EXPORT_SYMBOL_GPL(boot_cpuid);
> +/* we need a place to store phys cpu for non-SMP case */
> +#ifndef CONFIG_SMP
>  int boot_cpuid_phys;
>  EXPORT_SYMBOL_GPL(boot_cpuid_phys);
> +#endif
>  
>  int smp_hw_index[NR_CPUS];
>  
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index fb9bb46..6d0f00f 100644
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
> diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
> index d72eda6..8998b7a 100644
> --- a/arch/powerpc/sysdev/xics/xics-common.c
> +++ b/arch/powerpc/sysdev/xics/xics-common.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/sched.h>
>  
>  #include <asm/prom.h>
>  #include <asm/io.h>
