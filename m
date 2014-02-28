Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC PATCH] powerpc: allow allyesconfig to build more
In-reply-to: <20140227171719.01d7de4be01559dd02968f7c@canb.auug.org.au>
References: <20140227171719.01d7de4be01559dd02968f7c@canb.auug.org.au>
Date: Fri, 28 Feb 2014 15:06:09 +1100
Message-ID: <5087.1393560369@ale.ozlabs.ibm.com>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, paulus@samba.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Fixes this build error:
> 
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org backwards
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Builds and boots for me

Acked-off-by: Michael Neuling <mikey@neuling.org>


> ---
>  arch/powerpc/kernel/exceptions-64s.S | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> This builds allyesconfig better (we still have RELOC failures in the
> link) and hopefully fixes the allmodconfig build, but I don't know if
> it is semantically OK.
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 38d507306a11..b87859ffc8e7 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1294,16 +1294,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  	.globl	__end_handlers
>  __end_handlers:
>  
> -	/* Equivalents to the above handlers for relocation-on interrupt vectors */
> -	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
> -	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
> -
> -	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
> -	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
> -	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
> -	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
> -	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
> -
>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>  /*
>   * Data area reserved for FWNMI option.
> @@ -1325,6 +1315,16 @@ fwnmi_data_area:
>  initial_stab:
>  	.space	4096
>  
> +	/* Equivalents to the above handlers for relocation-on interrupt vectors */
> +	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
> +	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
> +
> +	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
> +	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
> +	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
> +	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
> +	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
> +
>  #ifdef CONFIG_PPC_POWERNV
>  _GLOBAL(opal_mc_secondary_handler)
>  	HMT_MEDIUM_PPR_DISCARD
> -- 
> 1.9.0
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
