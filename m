Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id AC0072C03B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 03:26:00 +1000 (EST)
Date: Wed, 1 Aug 2012 10:25:57 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: qiang.liu@freescale.com
Subject: Re: [PATCH v5 6/6] fsl-dma: fix a warning of unitialized cookie
Message-ID: <20120801172557.GE11359@ovro.caltech.edu>
References: <1343811027-25516-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343811027-25516-1-git-send-email-qiang.liu@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org,
 dan.j.williams@gmail.com, herbert@gondor.hengli.com.au,
 linux-crypto@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 01, 2012 at 04:50:27PM +0800, qiang.liu@freescale.com wrote:
> From: Qiang Liu <qiang.liu@freescale.com>
> 
> Fix a warning of unitialized value when compile with -Wuninitialized.
> 

Looks good to me.

Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>

> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Li Yang <leoli@freescale.com>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> Reported-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  drivers/dma/fsldma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index e3814aa..6fc22eb 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -645,7 +645,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  	struct fsldma_chan *chan = to_fsl_chan(tx->chan);
>  	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
>  	struct fsl_desc_sw *child;
> -	dma_cookie_t cookie;
> +	dma_cookie_t cookie = 0;
> 
>  	spin_lock_bh(&chan->desc_lock);
> 
> --
> 1.7.5.1
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
