Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ylcFv6mX5zDr5b
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 17:24:19 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] 44x/fsp2: tvsense workaround for dd1
Date: Mon, 27 Nov 2017 16:50:34 +1100
Message-ID: <11283941.vsV5PFyQhs@new-mexico>
In-Reply-To: <20171102130706.76056-4-ivan@de.ibm.com>
References: <20171102130706.76056-4-ivan@de.ibm.com>
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

Again, I'm not familiar with this specific hardware so can only provide general
comments.

On Thursday, 2 November 2017 4:07:05 PM AEDT Ivan Mikhaylov wrote:
> * tvsense(temperature and voltage sensors) may provide
>   erratic sense values which may result in parity errors
>   on CMU.

It would be good if you could provide a more detailed description of the problem
(like in the comment below) and what this patch does to address it.

Feel free to add my reviewed by as well.

- Alistair

> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
> ---
>  arch/powerpc/platforms/44x/fsp2.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
> index 9585725..4e12490 100644
> --- a/arch/powerpc/platforms/44x/fsp2.c
> +++ b/arch/powerpc/platforms/44x/fsp2.c
> @@ -59,6 +59,23 @@ static int __init fsp2_probe(void)
>  	mtdcr(DCRN_PLB6_HD, 0xffff0000);
>  	mtdcr(DCRN_PLB6_SHD, 0xffff0000);
>  
> +	/* TVSENSE reset is blocked (clock gated) by the POR default of the TVS
> +	 * sleep config bit. As a consequence, TVSENSE will provide erratic
> +	 * sensor values, which may result in spurious (parity) errors
> +	 * recorded in the CMU FIR and leading to erroneous interrupt requests
> +	 * once the CMU interrupt is unmasked.
> +	 */
> +
> +	/* 1. set TVS1[UNDOZE] */
> +	val = mfcmu(CMUN_TVS1);
> +	val |= 0x4;
> +	mtcmu(CMUN_TVS1, val);
> +
> +	/* 2. clear FIR[TVS] and FIR[TVSPAR] */
> +	val = mfcmu(CMUN_FIR0);
> +	val |= 0x30000000;
> +	mtcmu(CMUN_FIR0, val);
> +
>  	/* L2 machine checks */
>  	mtl2(L2PLBMCKEN0, 0xffffffff);
>  	mtl2(L2PLBMCKEN1, 0x0000ffff);
> 
