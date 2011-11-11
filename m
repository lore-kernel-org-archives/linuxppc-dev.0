Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C7E761007D1
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 15:18:29 +1100 (EST)
Message-ID: <1320985094.21206.35.camel@pasglop>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ananth@in.ibm.com
Date: Fri, 11 Nov 2011 15:18:14 +1100
In-Reply-To: <20111110084807.GA16323@in.ibm.com>
References: <20111107044750.GB4361@in.ibm.com>
 <4EB812E8.9090107@freescale.com> <20111108065811.GA9109@in.ibm.com>
 <4EB96002.5030605@freescale.com> <20111109044124.GA10961@in.ibm.com>
 <20111109154825.GB7839@schlenkerla.am.freescale.net>
 <20111110084807.GA16323@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-10 at 14:18 +0530, Ananth N Mavinakayanahalli wrote:

> 
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> The Processor Identification Register (PIR) on some powerpc platforms
> provides information to decode the processor identification tag.
> Decoding this information is platform specific.
> 
> We currently need this information for POWERx processors and hence
> follows a similar model as adopted for the other POWERx specific
> features.

At this rate we're going to end up with no bits left for CPU features
way too quickly... Especially for something we only care about once at
boot time.

Wouldn't CPU_FTR_PPCAS_ARCH_V2 be a good enough test ?

Can you tell us a bit more about the real use for that feature ? I still
don't see what's the point of getting the underlying HW ID.

Cheers,
Ben.

> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> ---
>  arch/powerpc/include/asm/cputable.h |    9 +++++----
>  arch/powerpc/kernel/sysfs.c         |    8 ++++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> Index: linux-3.2-rc1/arch/powerpc/include/asm/cputable.h
> ===================================================================
> --- linux-3.2-rc1.orig/arch/powerpc/include/asm/cputable.h
> +++ linux-3.2-rc1/arch/powerpc/include/asm/cputable.h
> @@ -201,6 +201,7 @@ extern const char *powerpc_base_platform
>  #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
>  #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
>  #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
> +#define CPU_FTR_PIR			LONG_ASM_CONST(0x2000000000000000)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -400,7 +401,7 @@ extern const char *powerpc_base_platform
>  #define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ | \
> -	    CPU_FTR_STCX_CHECKS_ADDRESS)
> +	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_PIR)
>  #define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_201 | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
> @@ -408,19 +409,19 @@ extern const char *powerpc_base_platform
>  	    CPU_FTR_HVMODE)
>  #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> -	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
> +	    CPU_FTR_MMCRA | CPU_FTR_SMT | CPU_FTR_PIR | \
>  	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_PURR | \
>  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
>  #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> -	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
> +	    CPU_FTR_MMCRA | CPU_FTR_SMT | CPU_FTR_PIR | \
>  	    CPU_FTR_COHERENT_ICACHE | \
>  	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
>  	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
>  	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_CFAR)
>  #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
> -	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
> +	    CPU_FTR_MMCRA | CPU_FTR_SMT | CPU_FTR_PIR | \
>  	    CPU_FTR_COHERENT_ICACHE | \
>  	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
>  	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
> Index: linux-3.2-rc1/arch/powerpc/kernel/sysfs.c
> ===================================================================
> --- linux-3.2-rc1.orig/arch/powerpc/kernel/sysfs.c
> +++ linux-3.2-rc1/arch/powerpc/kernel/sysfs.c
> @@ -177,11 +177,13 @@ SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
>  SYSFS_PMCSETUP(purr, SPRN_PURR);
>  SYSFS_PMCSETUP(spurr, SPRN_SPURR);
>  SYSFS_PMCSETUP(dscr, SPRN_DSCR);
> +SYSFS_PMCSETUP(pir, SPRN_PIR);
>  
>  static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
>  static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
>  static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
>  static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
> +static SYSDEV_ATTR(pir, 0400, show_pir, NULL);
>  
>  unsigned long dscr_default = 0;
>  EXPORT_SYMBOL(dscr_default);
> @@ -392,6 +394,9 @@ static void __cpuinit register_cpu_onlin
>  
>  	if (cpu_has_feature(CPU_FTR_DSCR))
>  		sysdev_create_file(s, &attr_dscr);
> +
> +	if (cpu_has_feature(CPU_FTR_PIR))
> +		sysdev_create_file(s, &attr_pir);
>  #endif /* CONFIG_PPC64 */
>  
>  	cacheinfo_cpu_online(cpu);
> @@ -462,6 +467,9 @@ static void unregister_cpu_online(unsign
>  
>  	if (cpu_has_feature(CPU_FTR_DSCR))
>  		sysdev_remove_file(s, &attr_dscr);
> +
> +	if (cpu_has_feature(CPU_FTR_PIR))
> +		sysdev_remove_file(s, &attr_pir);
>  #endif /* CONFIG_PPC64 */
>  
>  	cacheinfo_cpu_offline(cpu);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
