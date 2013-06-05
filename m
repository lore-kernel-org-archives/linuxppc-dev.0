Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/cputable: fix oprofile_cpu_type on power8
In-reply-to: <20130528203950.GA30172@linux.vnet.ibm.com>
References: <20130528203950.GA30172@linux.vnet.ibm.com>
Date: Wed, 05 Jun 2013 14:34:40 +1000
Message-ID: <26267.1370406880@ale.ozlabs.ibm.com>
Cc: Maynard Johnson <mpjohn@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benh and Nish,

This breaks all perf HW events on POWER8.

Please revert this.  It's
2ac6f427ad837a69561160b282eff80d9f0c2466 upstream.

Noticed by mpe.

Mikey

Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:
> Maynard informed me that neither the oprofile kernel module nor oprofile
> userspace has been updated to support that "legacy" oprofile module
> interface for power8, which is indicated by "ppc64/power8." This results
> in no samples. The solution is to default to the "timer" type, instead.
> The raw entry also should be updated, as "ppc64/ibm-compat-v1" indicates
> to oprofile userspace to use "compatibility events" which are obsolete
> in ISA 2.07.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> ---
> Ben, if this seems reasonable to you, it would be great to get this into
> 3.10.
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index c60bbec..b8808bc 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -453,7 +453,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
>  		.oprofile_type		= PPC_OPROFILE_POWER4,
> -		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
> +		.oprofile_cpu_type	= 0,
>  		.cpu_setup		= __setup_cpu_power8,
>  		.cpu_restore		= __restore_cpu_power8,
>  		.platform		= "power8",
> @@ -506,7 +506,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.dcache_bsize		= 128,
>  		.num_pmcs		= 6,
>  		.pmc_type		= PPC_PMC_IBM,
> -		.oprofile_cpu_type	= "ppc64/power8",
> +		.oprofile_cpu_type	= 0,
>  		.oprofile_type		= PPC_OPROFILE_POWER4,
>  		.cpu_setup		= __setup_cpu_power8,
>  		.cpu_restore		= __restore_cpu_power8,
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
