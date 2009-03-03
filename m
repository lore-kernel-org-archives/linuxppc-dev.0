Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: add defintion for MSR[GS] to list of MSR bits 
In-reply-to: <1236018001-3206-1-git-send-email-timur@freescale.com> 
References: <1236018001-3206-1-git-send-email-timur@freescale.com>
Date: Tue, 03 Mar 2009 12:02:01 +1100
Message-ID: <3431.1236042121@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Add macros for the GS (guest state) bit to the list of MSR bit definitions.
> On PowerPC cores that support embedded hypervisor mode, GS is cleared if
> the system is running in hypervisor state (and MSR[PR] is cleared), and set
> if it's running in guest state.  See the Power ISA 2.06 specification for
> more information.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/include/asm/reg.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h

Shouldn't this be in reg_booke.h?

Mikey

> index c6d1ab6..ca5c7f8 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -29,6 +29,7 @@
>  #define MSR_SF_LG	63              /* Enable 64 bit mode */
>  #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
>  #define MSR_HV_LG 	60              /* Hypervisor state */
> +#define MSR_GS_LG	28		/* Guest state */
>  #define MSR_VEC_LG	25	        /* Enable AltiVec */
>  #define MSR_VSX_LG	23		/* Enable VSX */
>  #define MSR_POW_LG	18		/* Enable Power Management */
> @@ -71,6 +72,7 @@
>  #define MSR_HV		0
>  #endif
>  
> +#define MSR_GS		__MASK(MSR_GS_LG)	/* Guest state */
>  #define MSR_VEC		__MASK(MSR_VEC_LG)	/* Enable AltiVec */
>  #define MSR_VSX		__MASK(MSR_VSX_LG)	/* Enable VSX */
>  #define MSR_POW		__MASK(MSR_POW_LG)	/* Enable Power Managem
ent */
> -- 
> 1.5.5
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
