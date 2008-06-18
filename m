Return-Path: <jschopp@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E50EDDFB3
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 02:28:26 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5IGUgGR008036
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 12:30:42 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5IGSNYl193410
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 12:28:23 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5IGSMmF032461
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 12:28:23 -0400
Message-ID: <485937A6.1000205@austin.ibm.com>
Date: Wed, 18 Jun 2008 11:28:22 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 6/9] powerpc: Add VSX CPU feature
References: <20080618004734.1A41370297@localhost.localdomain>
In-Reply-To: <20080618004734.1A41370297@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A couple of these lines originated with me.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>

Michael Neuling wrote:
> Add a VSX CPU feature.  Also add code to detect if VSX is available
> from the device tree.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>
>  arch/powerpc/kernel/prom.c     |    3 +++
>  include/asm-powerpc/cputable.h |   13 +++++++++++++
>  2 files changed, 16 insertions(+)
>
> Index: linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/prom.c
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
> @@ -609,6 +609,9 @@ static struct feature_property {
>  	{"altivec", 0, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
>  	{"ibm,vmx", 1, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
>  #endif /* CONFIG_ALTIVEC */
> +#ifdef CONFIG_VSX
> +	{"ibm,vmx", 2, CPU_FTR_VSX, PPC_FEATURE_HAS_VSX},
> +#endif /* CONFIG_VSX */
>  #ifdef CONFIG_PPC64
>  	{"ibm,dfp", 1, 0, PPC_FEATURE_HAS_DFP},
>  	{"ibm,purr", 1, CPU_FTR_PURR, 0},
> Index: linux-2.6-ozlabs/include/asm-powerpc/cputable.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/cputable.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/cputable.h
> @@ -27,6 +27,7 @@
>  #define PPC_FEATURE_HAS_DFP		0x00000400
>  #define PPC_FEATURE_POWER6_EXT		0x00000200
>  #define PPC_FEATURE_ARCH_2_06		0x00000100
> +#define PPC_FEATURE_HAS_VSX		0x00000080
>  
>  #define PPC_FEATURE_TRUE_LE		0x00000002
>  #define PPC_FEATURE_PPC_LE		0x00000001
> @@ -181,6 +182,7 @@ extern void do_feature_fixups(unsigned l
>  #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
>  #define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
>  #define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
> +#define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -199,6 +201,17 @@ extern void do_feature_fixups(unsigned l
>  #define PPC_FEATURE_HAS_ALTIVEC_COMP    0
>  #endif
>  
> +/* We only set the VSX features if the kernel was compiled with VSX
> + * support
> + */
> +#ifdef CONFIG_VSX
> +#define CPU_FTR_VSX_COMP	CPU_FTR_VSX
> +#define PPC_FEATURE_HAS_VSX_COMP PPC_FEATURE_HAS_VSX
> +#else
> +#define CPU_FTR_VSX_COMP	0
> +#define PPC_FEATURE_HAS_VSX_COMP    0
> +#endif
> +
>  /* We only set the spe features if the kernel was compiled with spe
>   * support
>   */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
