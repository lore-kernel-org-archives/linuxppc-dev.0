Return-Path: <clg@kaod.org>
Received: from 17.mo5.mail-out.ovh.net (17.mo5.mail-out.ovh.net
 [46.105.56.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xd522Lz8zDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 20:37:08 +1000 (AEST)
Received: from player792.ha.ovh.net (unknown [10.109.146.20])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id A86DD1DB436
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 08:58:22 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/xive: Avoid unitialized variable
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <3b8841ac-ebbb-523e-0d65-ebe27a702d3c@kaod.org>
 <1535066799-8493-1-git-send-email-leitao@debian.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f4d40649-e9c8-b5cf-6f9d-3c90a5994bfc@kaod.org>
Date: Fri, 24 Aug 2018 08:58:17 +0200
MIME-Version: 1.0
In-Reply-To: <1535066799-8493-1-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/24/2018 01:26 AM, Breno Leitao wrote:
> From: Breno Leitao <breno.leitao@gmail.com>
> 
> Function xive_native_get_ipi() might uses chip_id without it being
> initialized.
> 
> This gives the following error on 'smatch' tool:
> 
> 	error: uninitialized symbol 'chip_id'
> 
> The suggestion is using xc->chip_id instead of consulting the OF for chip id,
> which is safe since xive_prepare_cpu() should have initialized ->chip_id by
> the time xive_native_get_ipi() is called.
> 
> CC: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>



Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  arch/powerpc/sysdev/xive/native.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index 311185b9960a..bd90fd464a3a 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -238,20 +238,11 @@ static bool xive_native_match(struct device_node *node)
>  #ifdef CONFIG_SMP
>  static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>  {
> -	struct device_node *np;
> -	unsigned int chip_id;
>  	s64 irq;
>  
> -	/* Find the chip ID */
> -	np = of_get_cpu_node(cpu, NULL);
> -	if (np) {
> -		if (of_property_read_u32(np, "ibm,chip-id", &chip_id) < 0)
> -			chip_id = 0;
> -	}
> -
>  	/* Allocate an IPI and populate info about it */
>  	for (;;) {
> -		irq = opal_xive_allocate_irq(chip_id);
> +		irq = opal_xive_allocate_irq(xc->chip_id);
>  		if (irq == OPAL_BUSY) {
>  			msleep(1);
>  			continue;
> 
