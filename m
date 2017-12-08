Return-Path: <srs0=d8cx=de=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytbWk3j9xzDsTh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Dec 2017 02:15:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ytbWk1Ybrz8vj0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Dec 2017 02:15:30 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ytbWj2bzkz9t9n
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2017 02:15:28 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB8FB0lH144483
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2017 10:15:26 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eqvyd8ww3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 08 Dec 2017 10:15:26 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 8 Dec 2017 15:15:24 -0000
Subject: Re: [RFC PATCH 1/2] powerpc: Add a CPU feature bit for TM bug
 workarounds on POWER9 DD2.2
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Nick Piggin
 <npiggin@au1.ibm.com>
Date: Fri, 08 Dec 2017 09:15:14 -0600
In-Reply-To: <20171208060924.fthehkna7bsnjowx@rohan>
References: <20171208060803.relvzabipgl2lub6@rohan>
 <20171208060924.fthehkna7bsnjowx@rohan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512746114.9405.27.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-08 at 17:09 +1100, Paul Mackerras wrote:
> This adds a CPU feature bit which is set for POWER9 DD2.2 processors
> which will be used to enable software emulation for some transactional
> memory instructions, in order to work around hardware bugs.

The worry here is backward compatibility as we don't know yet which
processor will fix it (if ever).

Paul and Nick, can you also add it to the "new" CPU features mechanism
(which we should enable now) so that we at least have a way to control
this from firmware ?

> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/cputable.h |  5 ++++-
>  arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
> index 53b31c2bcdf4..70cee46c046c 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -215,6 +215,7 @@ enum {
>  #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
>  #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
>  #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
> +#define CPU_FTR_P9_TM_EMUL		LONG_ASM_CONST(0x2000000000000000)
>  #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
>  
>  #ifndef __ASSEMBLY__
> @@ -478,6 +479,7 @@ enum {
>  	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
>  #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
>  			     (~CPU_FTR_SAO))
> +#define CPU_FTRS_POWER9_DD2_2 (CPU_FTRS_POWER9 | CPU_FTR_P9_TM_EMUL)
>  #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
>  	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
>  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> @@ -496,7 +498,8 @@ enum {
>  	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
>  	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
>  	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
> -	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | CPU_FTRS_POWER9_DD1)
> +	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9 | \
> +	     CPU_FTRS_POWER9_DD1 | CPU_FTRS_POWER9_DD2_2)
>  #endif
>  #else
>  enum {
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 760872916013..bb94bb6d9e4d 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -547,6 +547,26 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.machine_check_early	= __machine_check_early_realmode_p9,
>  		.platform		= "power9",
>  	},
> +	{	/* Power9 DD2.2 */
> +		.pvr_mask		= 0xffffffff,
> +		.pvr_value		= 0x004e1202,
> +		.cpu_name		= "POWER9 (raw)",
> +		.cpu_features		= CPU_FTRS_POWER9_DD2_2,
> +		.cpu_user_features	= COMMON_USER_POWER9,
> +		.cpu_user_features2	= COMMON_USER2_POWER9,
> +		.mmu_features		= MMU_FTRS_POWER9,
> +		.icache_bsize		= 128,
> +		.dcache_bsize		= 128,
> +		.num_pmcs		= 6,
> +		.pmc_type		= PPC_PMC_IBM,
> +		.oprofile_cpu_type	= "ppc64/power9",
> +		.oprofile_type		= PPC_OPROFILE_INVALID,
> +		.cpu_setup		= __setup_cpu_power9,
> +		.cpu_restore		= __restore_cpu_power9,
> +		.flush_tlb		= __flush_tlb_power9,
> +		.machine_check_early	= __machine_check_early_realmode_p9,
> +		.platform		= "power9",
> +	},
>  	{	/* Power9 */
>  		.pvr_mask		= 0xffff0000,
>  		.pvr_value		= 0x004e0000,
