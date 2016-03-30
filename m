Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZT2T350JzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 11:25:53 +1100 (AEDT)
In-Reply-To: <20160329183333.15267.29181.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [v2] ppc64/book3s: fix branching to out of line handlers in
 relocation kernel
Message-Id: <3qZT2T1R7fz9sDC@ozlabs.org>
Date: Wed, 30 Mar 2016 11:25:53 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-29-03 at 18:34:37 UTC, Hari Bathini wrote:
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 7716ceb..e598580 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -764,8 +764,8 @@ kvmppc_skip_Hinterrupt:
>  #endif
>  
>  /*
> - * Code from here down to __end_handlers is invoked from the
> - * exception prologs above.  Because the prologs assemble the
> + * Code from here down to end of out of line handlers is invoked from
> + * the exception prologs above.  Because the prologs assemble the

I think it would be better to just replace __end_handlers with __end_interrupts,
that way it's entirely clear what location you're talking about.

> @@ -953,11 +953,6 @@ hv_facility_unavailable_relon_trampoline:
>  #endif
>  	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
>  
> -	/* Other future vectors */
> -	.align	7
> -	.globl	__end_interrupts
> -__end_interrupts:
> -
>  	.align	7
>  system_call_entry:
>  	b	system_call_common
> @@ -1230,10 +1225,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  	STD_EXCEPTION_COMMON(0xf60, facility_unavailable, facility_unavailable_exception)
>  	STD_EXCEPTION_COMMON(0xf80, hv_facility_unavailable, facility_unavailable_exception)
>  
> -	.align	7
> -	.globl	__end_handlers
> -__end_handlers:
> -

Sorry I wasn't clear in my last mail, please do this as a separate cleanup patch
after this patch.

> @@ -1244,6 +1235,16 @@ __end_handlers:
>  	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
>  	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
>  
> +	/* FIXME: For now, let us move the __end_interrupts marker down past

Why is it FIXME?

In general I don't want to merge code that adds a FIXME unless there is some
very good reason.

AFAICS this is a permanent solution isn't it?

> +	 * the out-of-line handlers, to make sure we also copy OOL handlers
> +	 * to real adress 0x100 when running a relocatable kernel. This helps

It doesn't "help" it's 100% required.

> +	 * in cases where interrupt vectors are not long enough (like 0x4f00,
> +	 * 0x4f20, etc.) to branch out to OOL handlers with LOAD_HANDLER().
> +	 */
> +	.align	7
> +	.globl	__end_interrupts
> +__end_interrupts:
> +
>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>  /*
>   * Data area reserved for FWNMI option.


cheers
