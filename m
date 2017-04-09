Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w15Rh4T6HzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Apr 2017 18:03:44 +1000 (AEST)
Message-ID: <1491725015.4166.188.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: do not use msgsndp doorbells on
 POWER9 guests
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Sun, 09 Apr 2017 18:03:35 +1000
In-Reply-To: <20170407125602.31146-2-npiggin@gmail.com>
References: <20170407125602.31146-1-npiggin@gmail.com>
 <20170407125602.31146-2-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-04-07 at 22:55 +1000, Nicholas Piggin wrote:
> POWER9 hypervisors will not necessarily run guest threads together on
> the same core at the same time, so msgsndp should not be used.

Maybe we shouldn't advertise doorbells at all ?

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/platforms/pseries/smp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/smp.c
> b/arch/powerpc/platforms/pseries/smp.c
> index f6f83aeccaaa..1fa08155206b 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -200,7 +200,12 @@ static __init void pSeries_smp_probe(void)
>  {
>  	xics_smp_probe();
>  
> -	if (cpu_has_feature(CPU_FTR_DBELL)) {
> +	/*
> +	 * POWER9 can not use msgsndp doorbells for IPI because
> thread
> +	 * siblings do not necessarily run on physical cores at the
> same
> +	 * time. This could be enabled for pHyp.
> +	 */
> +	if (cpu_has_feature(CPU_FTR_DBELL) &&
> !cpu_has_feature(CPU_FTR_ARCH_300)) {
>  		xics_cause_ipi = smp_ops->cause_ipi;
>  		smp_ops->cause_ipi = pSeries_cause_ipi_mux;
>  	}
