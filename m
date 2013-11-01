Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97FBF2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 21:04:35 +1100 (EST)
Date: Fri, 1 Nov 2013 11:04:18 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v5 1/5] dma: mpc512x: reorder mpc8308 specific
 instructions
Message-ID: <20131101110418.1158b999@crub>
In-Reply-To: <1383290374-17484-2-git-send-email-a13xp0p0v88@gmail.com>
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-2-git-send-email-a13xp0p0v88@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  1 Nov 2013 11:19:30 +0400
Alexander Popov <a13xp0p0v88@gmail.com> wrote:

> Concentrate the specific code for MPC8308 in the 'if' branch
> and handle MPC512x in the 'else' branch.
> This modification only reorders instructions but doesn't change behaviour.
> 
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> ---
>  drivers/dma/mpc512x_dma.c | 42 +++++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)

Acked-by: Anatolij Gustschin <agust@denx.de>

> 
> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> index 2fe4353..f41639f 100644
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -50,9 +50,17 @@
>  #define MPC_DMA_DESCRIPTORS	64
>  
>  /* Macro definitions */
> -#define MPC_DMA_CHANNELS	64
>  #define MPC_DMA_TCD_OFFSET	0x1000
>  
> +/*
> + * Maximum channel counts for individual hardware variants
> + * and the maximum channel count over all supported controllers,
> + * used for data structure size
> + */
> +#define MPC8308_DMACHAN_MAX	16
> +#define MPC512x_DMACHAN_MAX	64
> +#define MPC_DMA_CHANNELS	64
> +
>  /* Arbitration mode of group and channel */
>  #define MPC_DMA_DMACR_EDCG	(1 << 31)
>  #define MPC_DMA_DMACR_ERGA	(1 << 3)
> @@ -708,10 +716,10 @@ static int mpc_dma_probe(struct platform_device *op)
>  
>  	dma = &mdma->dma;
>  	dma->dev = dev;
> -	if (!mdma->is_mpc8308)
> -		dma->chancnt = MPC_DMA_CHANNELS;
> +	if (mdma->is_mpc8308)
> +		dma->chancnt = MPC8308_DMACHAN_MAX;
>  	else
> -		dma->chancnt = 16; /* MPC8308 DMA has only 16 channels */
> +		dma->chancnt = MPC512x_DMACHAN_MAX;
>  	dma->device_alloc_chan_resources = mpc_dma_alloc_chan_resources;
>  	dma->device_free_chan_resources = mpc_dma_free_chan_resources;
>  	dma->device_issue_pending = mpc_dma_issue_pending;
> @@ -745,7 +753,19 @@ static int mpc_dma_probe(struct platform_device *op)
>  	 * - Round-robin group arbitration,
>  	 * - Round-robin channel arbitration.
>  	 */
> -	if (!mdma->is_mpc8308) {
> +	if (mdma->is_mpc8308) {
> +		/* MPC8308 has 16 channels and lacks some registers */
> +		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_ERCA);
> +
> +		/* enable snooping */
> +		out_be32(&mdma->regs->dmagpor, MPC_DMA_DMAGPOR_SNOOP_ENABLE);
> +		/* Disable error interrupts */
> +		out_be32(&mdma->regs->dmaeeil, 0);
> +
> +		/* Clear interrupts status */
> +		out_be32(&mdma->regs->dmaintl, 0xFFFF);
> +		out_be32(&mdma->regs->dmaerrl, 0xFFFF);
> +	} else {
>  		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_EDCG |
>  					MPC_DMA_DMACR_ERGA | MPC_DMA_DMACR_ERCA);
>  
> @@ -766,18 +786,6 @@ static int mpc_dma_probe(struct platform_device *op)
>  		/* Route interrupts to IPIC */
>  		out_be32(&mdma->regs->dmaihsa, 0);
>  		out_be32(&mdma->regs->dmailsa, 0);
> -	} else {
> -		/* MPC8308 has 16 channels and lacks some registers */
> -		out_be32(&mdma->regs->dmacr, MPC_DMA_DMACR_ERCA);
> -
> -		/* enable snooping */
> -		out_be32(&mdma->regs->dmagpor, MPC_DMA_DMAGPOR_SNOOP_ENABLE);
> -		/* Disable error interrupts */
> -		out_be32(&mdma->regs->dmaeeil, 0);
> -
> -		/* Clear interrupts status */
> -		out_be32(&mdma->regs->dmaintl, 0xFFFF);
> -		out_be32(&mdma->regs->dmaerrl, 0xFFFF);
>  	}
>  
>  	/* Register DMA engine */
