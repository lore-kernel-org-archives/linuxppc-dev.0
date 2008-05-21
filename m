Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B20CDF9DE
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:02:03 +1000 (EST)
Subject: Re: [PATCH v2] [POWERPC] mpic: deal with bogus NIRQ in Feature
	Reporting Register
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0805211559110.31758@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805211559110.31758@blarg.am.freescale.net>
Content-Type: text/plain
Date: Wed, 21 May 2008 17:01:48 -0400
Message-Id: <1211403708.8297.251.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 15:59 -0500, Kumar Gala wrote:
> Some chips (like the SoCs from Freescale) report the wrong value in NIRQ
> and this causes issues if its doesn't match or exceed the value of
> irq_count.
> 
> Add a flag that board code can set to just use irq_count instead of
> FRR[NIRQ].  Eventually we'll add a device tree property with the number
> of sources.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> Screw up with git on the first version.
> 
> - k
> 
>  arch/powerpc/sysdev/mpic.c |    9 ++++++---
>  include/asm-powerpc/mpic.h |    2 ++
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8619f2a..12e285d 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1144,9 +1144,12 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
>  			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
>  	if (isu_size == 0)
> -		mpic->num_sources =
> -			((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
> -			 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
> +		if (flags & MPIC_BROKEN_FRR_NIRQS)
> +			mpic->num_sources = mpic->irq_count;
> +		else
> +			mpic->num_sources =
> +				((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
> +				 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
> 
>  	/* Map the per-CPU registers */
>  	for (i = 0; i < mpic->num_cpus; i++) {
> diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
> index 943c5a3..6802570 100644
> --- a/include/asm-powerpc/mpic.h
> +++ b/include/asm-powerpc/mpic.h
> @@ -353,6 +353,8 @@ struct mpic
>  #define MPIC_ENABLE_MCK			0x00000200
>  /* Disable bias among target selection, spread interrupts evenly */
>  #define MPIC_NO_BIAS			0x00000400
> +/* Ignore NIRQS as reported by FRR */
> +#define MPIC_BROKEN_FRR_NIRQS		0x00000800
> 
>  /* MPIC HW modification ID */
>  #define MPIC_REGSET_MASK		0xf0000000
