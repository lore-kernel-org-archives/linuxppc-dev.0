Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ylcFw1h3SzDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 17:24:20 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/4] 44x/fsp2: l2 setup with error clear
Date: Mon, 27 Nov 2017 16:08:10 +1100
Message-ID: <2409397.V1Gq0kr6Gu@new-mexico>
In-Reply-To: <20171102130706.76056-3-ivan@de.ibm.com>
References: <20171102130706.76056-3-ivan@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm not familiar with the hardware setup going on here so I can't comment on
it's correctness but the code looks ok. A commit message describing why this
particular setup is needed would be nice though.

Reviewed-by: Alistair Popple <alistair@popple.id.au>

On Thursday, 2 November 2017 4:07:04 PM AEDT Ivan Mikhaylov wrote:
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
> ---
>  arch/powerpc/platforms/44x/fsp2.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 37 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
> index 92e9804..9585725 100644
> --- a/arch/powerpc/platforms/44x/fsp2.c
> +++ b/arch/powerpc/platforms/44x/fsp2.c
> @@ -27,6 +27,8 @@
>  #include <asm/time.h>
>  #include <asm/uic.h>
>  #include <asm/ppc4xx.h>
> +#include <asm/fsp2_reg.h>
> +#include <asm/dcr.h>
>  
>  static __initdata struct of_device_id fsp2_of_bus[] = {
>  	{ .compatible = "ibm,plb4", },
> @@ -44,10 +46,45 @@ static int __init fsp2_device_probe(void)
>  
>  static int __init fsp2_probe(void)
>  {
> +	u32 val;
>  	unsigned long root = of_get_flat_dt_root();
>  
>  	if (!of_flat_dt_is_compatible(root, "ibm,fsp2"))
>  		return 0;
> +
> +	/* Clear BC_ERR and mask snoopable request plb errors. */
> +	val = mfdcr(DCRN_PLB6_CR0);
> +	val |= 0x20000000;
> +	mtdcr(DCRN_PLB6_BASE, val);
> +	mtdcr(DCRN_PLB6_HD, 0xffff0000);
> +	mtdcr(DCRN_PLB6_SHD, 0xffff0000);
> +
> +	/* L2 machine checks */
> +	mtl2(L2PLBMCKEN0, 0xffffffff);
> +	mtl2(L2PLBMCKEN1, 0x0000ffff);
> +	mtl2(L2ARRMCKEN0, 0xffffffff);
> +	mtl2(L2ARRMCKEN1, 0xffffffff);
> +	mtl2(L2ARRMCKEN2, 0xfffff000);
> +	mtl2(L2CPUMCKEN,  0xffffffff);
> +	mtl2(L2RACMCKEN0, 0xffffffff);
> +	mtl2(L2WACMCKEN0, 0xffffffff);
> +	mtl2(L2WACMCKEN1, 0xffffffff);
> +	mtl2(L2WACMCKEN2, 0xffffffff);
> +	mtl2(L2WDFMCKEN,  0xffffffff);
> +
> +	/* L2 interrupts */
> +	mtl2(L2PLBINTEN1, 0xffff0000);
> +
> +	/*
> +	 * At a global level, enable all L2 machine checks and interrupts
> +	 * reported by the L2 subsystems, except for the external machine check
> +	 * input (UIC0.1).
> +	 */
> +	mtl2(L2MCKEN, 0x000007ff);
> +	mtl2(L2INTEN, 0x000004ff);
> +
> +	/* Enable FSP-2 configuration logic parity errors */
> +	mtdcr(DCRN_CONF_EIR_RS, 0x80000000);
>  	return 1;
>  }
>  
> 
