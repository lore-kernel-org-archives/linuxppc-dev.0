Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnYwN0zQZzDqLF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 14:45:22 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5E4i2ka059230
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 00:45:20 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2tc901mu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 00:45:19 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Wed, 14 Jun 2017 14:45:17 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5E4j6ev6029790
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 14:45:14 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5E4ifa0024406
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 14:44:42 +1000
From: Michael Ellerman <michaele@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/xive: Fix offset for store EOI MMIOs
In-Reply-To: <1497399565.2897.23.camel@kernel.crashing.org>
References: <1497399565.2897.23.camel@kernel.crashing.org>
Date: Wed, 14 Jun 2017 14:44:17 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1a741r2.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Architecturally we should apply a 0x400 offset for these. Not doing
> it will break future HW implementations.

Can you elaborate a bit?

You're changing a write to 0x0 to be a write to 0x400, which at face
value appears like it breaks something, or is already broken?

cheers

> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> index c8a822a..c23ff43 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -94,11 +94,13 @@ struct xive_q {
>   * store at 0 and some ESBs support doing a trigger via a
>   * separate trigger page.
>   */
> -#define XIVE_ESB_GET		0x800
> -#define XIVE_ESB_SET_PQ_00	0xc00
> -#define XIVE_ESB_SET_PQ_01	0xd00
> -#define XIVE_ESB_SET_PQ_10	0xe00
> -#define XIVE_ESB_SET_PQ_11	0xf00
> +#define XIVE_ESB_STORE_EOI	0x400 /* Store */
> +#define XIVE_ESB_LOAD_EOI	0x000 /* Load */
> +#define XIVE_ESB_GET		0x800 /* Load */
> +#define XIVE_ESB_SET_PQ_00	0xc00 /* Load */
> +#define XIVE_ESB_SET_PQ_01	0xd00 /* Load */
> +#define XIVE_ESB_SET_PQ_10	0xe00 /* Load */
> +#define XIVE_ESB_SET_PQ_11	0xf00 /* Load */
>  
>  #define XIVE_ESB_VAL_P		0x2
>  #define XIVE_ESB_VAL_Q		0x1
> diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
> index 023a311..4636ca6 100644
> --- a/arch/powerpc/kvm/book3s_xive_template.c
> +++ b/arch/powerpc/kvm/book3s_xive_template.c
> @@ -69,7 +69,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
>  {
>  	/* If the XIVE supports the new "store EOI facility, use it */
>  	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
> -		__x_writeq(0, __x_eoi_page(xd));
> +		__x_writeq(0, __x_eoi_page(xd) + XIVE_ESB_STORE_EOI);
>  	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
>  		opal_int_eoi(hw_irq);
>  	} else {
> @@ -89,7 +89,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
>  		 * properly.
>  		 */
>  		if (xd->flags & XIVE_IRQ_FLAG_LSI)
> -			__x_readq(__x_eoi_page(xd));
> +			__x_readq(__x_eoi_page(xd) + XIVE_ESB_LOAD_EOI);
>  		else {
>  			eoi_val = GLUE(X_PFX,esb_load)(xd, XIVE_ESB_SET_PQ_00);
>  
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 9138250..8f5e303 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -297,7 +297,7 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
>  {
>  	/* If the XIVE supports the new "store EOI facility, use it */
>  	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
> -		out_be64(xd->eoi_mmio, 0);
> +		out_be64(xd->eoi_mmio + XIVE_ESB_STORE_EOI, 0);
>  	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
>  		/*
>  		 * The FW told us to call it. This happens for some
