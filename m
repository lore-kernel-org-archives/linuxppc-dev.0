Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4815E2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 05:33:52 +1000 (EST)
Date: Wed, 24 Jul 2013 14:33:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5 4/4] DMA: Freescale: eliminate a compiling warning
To: <hongbo.zhang@freescale.com>
References: <1374646870-5162-1-git-send-email-hongbo.zhang@freescale.com>
 <1374646870-5162-5-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1374646870-5162-5-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Wed Jul 24 01:21:09 2013)
Message-ID: <1374694411.15592.63@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, Hongbo Zhang <hongbo.zhang@freescale.com>,
 djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2013 01:21:09 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> The variable cookie is initialized in a list_for_each_entry loop, =20
> if(unlikely)
> the list is empty, this variable will be used uninitialized, so we =20
> get a gcc
> compiling warning about this. This patch fixes this defect by setting =20
> an
> initial value to the varialble cookie.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  drivers/dma/fsldma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 16a9a48..14d68a4 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -406,7 +406,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct =20
> dma_async_tx_descriptor *tx)
>  	struct fsl_desc_sw *desc =3D tx_to_fsl_desc(tx);
>  	struct fsl_desc_sw *child;
>  	unsigned long flags;
> -	dma_cookie_t cookie;
> +	dma_cookie_t cookie =3D 0;
>=20
>  	spin_lock_irqsave(&chan->desc_lock, flags);

This patch is unrelated to the rest of the patch series...

What are the semantics of this function if there are multiple entries =20
in the list?  Returning the last cookie seems a bit odd.

Is zero the proper error value?  include/linux/dmaengine.h suggests =20
that cookies should be < 0 to indicate error.

-Scott=
