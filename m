Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6CEF0B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 15:30:18 +1000 (EST)
Message-ID: <1335763810.20866.38.camel@pasglop>
Subject: Re: [PATCH] powerpc: Support lower minimum entitlement for virtual
 processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Date: Mon, 30 Apr 2012 15:30:10 +1000
In-Reply-To: <20120323212213.GB9456@linux.vnet.ibm.com>
References: <20120323212213.GB9456@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-23 at 16:22 -0500, Robert Jennings wrote:
> This patch changes the architecture vector to advertise support for a
> lower minimum virtual processor entitled capacity.  The default
> minimum without this patch is 10%, this patch specifies 5%.  This will
> allow 20 LPARs per CPU rather than only 10.

Any reason why we don't just put 1% in there and thus don't have to
change again when pHyp decides to lower their minimum ? :-)

(Can you test that it works, ie, that pHyp doesn't barf if we put 1% and
properly uses 5% in that case ?)

Cheers,
Ben.

> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/prom_init.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index eca626e..3d882ea 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -689,6 +689,9 @@ static void __init early_cmdline_parse(void)
>  #define OV3_VMX			0x40	/* VMX/Altivec */
>  #define OV3_DFP			0x20	/* decimal FP */
>  
> +/* Option vector 4: IBM PAPR implementation */
> +#define OV4_MIN_ENT_CAP		0x05	/* minimum VP entitled capacity */
> +
>  /* Option vector 5: PAPR/OF options supported */
>  #define OV5_LPAR		0x80	/* logical partitioning supported */
>  #define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
> @@ -753,8 +756,9 @@ static unsigned char ibm_architecture_vec[] = {
>  	OV3_FP | OV3_VMX | OV3_DFP,
>  
>  	/* option vector 4: IBM PAPR implementation */
> -	2 - 2,				/* length */
> +	3 - 2,				/* length */
>  	0,				/* don't halt */
> +	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
>  
>  	/* option vector 5: PAPR/OF options */
>  	13 - 2,				/* length */
> @@ -771,7 +775,7 @@ static unsigned char ibm_architecture_vec[] = {
>  	 * must match by the macro below. Update the definition if
>  	 * the structure layout changes.
>  	 */
> -#define IBM_ARCH_VEC_NRCORES_OFFSET	100
> +#define IBM_ARCH_VEC_NRCORES_OFFSET	101
>  	W(NR_CPUS),			/* number of cores supported */
>  
>  	/* option vector 6: IBM PAPR hints */
