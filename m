Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk7GP3lz8zDrMt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 15:34:21 +1000 (AEST)
Message-ID: <1504244040.4974.72.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 5/8] powerpc/xive: add the HW IRQ number under
 xive_irq_data
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 01 Sep 2017 15:34:00 +1000
In-Reply-To: <20170830194617.26621-6-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
 <20170830194617.26621-6-clg@kaod.org>
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

On Wed, 2017-08-30 at 21:46 +0200, Cédric Le Goater wrote:
> It will be required later by the H_INT_ESB hcall.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

A little but unfortunate as the number is available in the
irq_data but that would mean changing more of our internal
interfaces to get to it ... so ack for now.

> ---
>  arch/powerpc/include/asm/xive.h   | 1 +
>  arch/powerpc/sysdev/xive/native.c | 2 ++
>  arch/powerpc/sysdev/xive/spapr.c  | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> index 473f133a8555..64ec9bbcf03e 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -45,6 +45,7 @@ struct xive_irq_data {
>  	void __iomem *trig_mmio;
>  	u32 esb_shift;
>  	int src_chip;
> +	u32 hw_irq;
>  
>  	/* Setup/used by frontend */
>  	int target;
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index ef92a83090e1..f8bcff15b0f9 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -82,6 +82,8 @@ int xive_native_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
>  		return -ENOMEM;
>  	}
>  
> +	data->hw_irq = hw_irq;
> +
>  	if (!data->trig_page)
>  		return 0;
>  	if (data->trig_page == data->eoi_page) {
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index 797bb0636ab7..0fcae7504353 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -264,6 +264,8 @@ static int xive_spapr_populate_irq_data(u32 hw_irq, struct xive_irq_data *data)
>  		return -ENOMEM;
>  	}
>  
> +	data->hw_irq = hw_irq;
> +
>  	/* Full function page supports trigger */
>  	if (flags & XIVE_SRC_TRIGGER) {
>  		data->trig_mmio = data->eoi_mmio;
