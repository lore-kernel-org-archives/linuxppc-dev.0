Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR,
 EBB and ISEL bits in HWCAP2
In-reply-to: <20130503231933.GA29436@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
Date: Sat, 04 May 2013 10:04:54 +1000
Message-ID: <2889.1367625894@ale.ozlabs.ibm.com>
Cc: Michael R Meissner <mrmeissn@us.ibm.com>,
 Steve Munroe <sjmunroe@us.ibm.com>, Peter Bergner <bergner@us.ibm.com>,
 Ryan Arnold <ryanarn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:

> Now that we have AT_HWCAP2 support, start exposing some of the new
> POWER8 features via it.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

A few points:

We need a TAR bit as well, although this could be covered in 207?

For TM we need to turn it off if CONFIG_PPC_TRANSACTIONAL_MEM is not
set.  Look at PPC_FEATURE_HAS_ALTIVEC_COMP for how we do that and follow
the bouncing ball.  

Please add ISEL on other processors.

Please add DSCR on other processors.

EBB can be reserved, but there is no enablement at this point so don't
turn it on yet.  We'll turn it on when we send the perf API.

Mikey

> ---
> Note: there are, I think, some Freescale processors that also should be
> updated to indicate they support ISEL, but I don't know which ones.
> Since this is a new feature bit (and vector), it seems like we can fix
> that up in a follow-on patch. Also, this is my first patch trying to
> manipulate these bits, so please let me know if I'm doing something
> wrong (for instance, I don't see any particular order to the bits in
> PPC_FEATURE_*)
> 
> diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
> index ed9dd81..78db4e2 100644
> --- a/arch/powerpc/include/uapi/asm/cputable.h
> +++ b/arch/powerpc/include/uapi/asm/cputable.h
> @@ -1,6 +1,7 @@
>  #ifndef _UAPI__ASM_POWERPC_CPUTABLE_H
>  #define _UAPI__ASM_POWERPC_CPUTABLE_H
>  
> +/* in AT_HWCAP */
>  #define PPC_FEATURE_32			0x80000000
>  #define PPC_FEATURE_64			0x40000000
>  #define PPC_FEATURE_601_INSTR		0x20000000
> @@ -33,4 +34,11 @@
>  #define PPC_FEATURE_TRUE_LE		0x00000002
>  #define PPC_FEATURE_PPC_LE		0x00000001
>  
> +/* in AT_HWCAP2 */
> +#define PPC_FEATURE2_ARCH_2_07		0x80000000
> +#define PPC_FEATURE2_HTM		0x40000000
> +#define PPC_FEATURE2_DSCR		0x20000000
> +#define PPC_FEATURE2_EBB		0x10000000
> +#define PPC_FEATURE2_ISEL		0x08000000
> +
>  #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index ae9f433..871c741 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -102,6 +102,9 @@ extern void __restore_cpu_e6500(void);
>  				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
>  				 PPC_FEATURE_TRUE_LE | \
>  				 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
> +#define COMMON_USER2_POWER8	(PPC_FEATURE2_ARCH_2_07 | PPC_FEATURE2_HTM | \
> +				 PPC_FEATURE2_DSCR | PPC_FEATURE2_EBB | \
> +				 PPC_FEATURE2_ISEL)
>  #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
>  				 PPC_FEATURE_TRUE_LE | \
>  				 PPC_FEATURE_HAS_ALTIVEC_COMP)
> @@ -443,6 +446,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_name		= "POWER8 (architected)",
>  		.cpu_features		= CPU_FTRS_POWER8,
>  		.cpu_user_features	= COMMON_USER_POWER8,
> +		.cpu_user_features2	= COMMON_USER2_POWER8,
>  		.mmu_features		= MMU_FTRS_POWER8,
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
> @@ -492,6 +496,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_name		= "POWER8 (raw)",
>  		.cpu_features		= CPU_FTRS_POWER8,
>  		.cpu_user_features	= COMMON_USER_POWER8,
> +		.cpu_user_features2	= COMMON_USER2_POWER8,
>  		.mmu_features		= MMU_FTRS_POWER8,
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
> 
