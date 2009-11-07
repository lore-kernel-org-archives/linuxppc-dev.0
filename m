Return-Path: <lgirdwood@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by ozlabs.org (Postfix) with ESMTP id 6E491B7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Nov 2009 21:36:03 +1100 (EST)
Received: by ey-out-1920.google.com with SMTP id 3so374551eyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 07 Nov 2009 02:35:59 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 1/6] ASoC/mpc5200: Track DMA position by
	period number instead	of bytes
From: Liam Girdwood <lrg@slimlogic.co.uk>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20091107083345.18908.96473.stgit@angua>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083345.18908.96473.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 Nov 2009 10:35:53 +0000
Message-ID: <1257590153.3960.3.camel@odin>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-11-07 at 01:33 -0700, Grant Likely wrote:
> All DMA blocks are lined up to period boundaries, but the DMA
> handling code tracks bytes instead.  This patch reworks the code
> to track the period index into the DMA buffer instead of the
> physical address pointer.  Doing so makes the code simpler and
> easier to understand.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Very minor coding style thing below otherwise all get my Ack.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

 

> ---
> 
>  sound/soc/fsl/mpc5200_dma.c |   28 +++++++++-------------------
>  sound/soc/fsl/mpc5200_dma.h |    8 ++------
>  2 files changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index 6096d22..986d3c8 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -58,13 +58,11 @@ static void psc_dma_bcom_enqueue_next_buffer(struct psc_dma_stream *s)
>  	/* Prepare and enqueue the next buffer descriptor */
>  	bd = bcom_prepare_next_buffer(s->bcom_task);
>  	bd->status = s->period_bytes;
> -	bd->data[0] = s->period_next_pt;
> +	bd->data[0] = s->runtime->dma_addr + (s->period_next * s->period_bytes);
>  	bcom_submit_next_buffer(s->bcom_task, NULL);
>  
>  	/* Update for next period */
> -	s->period_next_pt += s->period_bytes;
> -	if (s->period_next_pt >= s->period_end)
> -		s->period_next_pt = s->period_start;
> +	s->period_next = (s->period_next + 1) % s->runtime->periods;
>  }
>  
>  static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
> @@ -79,7 +77,7 @@ static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
>  			if (bcom_queue_full(s->bcom_task))
>  				return;
>  
> -			s->appl_ptr += s->period_size;
> +			s->appl_ptr += s->runtime->period_size;
>  
>  			psc_dma_bcom_enqueue_next_buffer(s);
>  		}
> @@ -91,7 +89,7 @@ static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
>  		if (bcom_queue_full(s->bcom_task))
>  			return;
>  
> -		s->appl_ptr += s->period_size;
> +		s->appl_ptr += s->runtime->period_size;
>  
>  		psc_dma_bcom_enqueue_next_buffer(s);
>  	}
> @@ -108,9 +106,7 @@ static irqreturn_t psc_dma_bcom_irq_tx(int irq, void *_psc_dma_stream)
>  	while (bcom_buffer_done(s->bcom_task)) {
>  		bcom_retrieve_buffer(s->bcom_task, NULL, NULL);
>  
> -		s->period_current_pt += s->period_bytes;
> -		if (s->period_current_pt >= s->period_end)
> -			s->period_current_pt = s->period_start;
> +		s->period_current = (s->period_current+1) % s->runtime->periods;

I prefer a space around operators.

s->period_current = (s->period_current + 1) % s->runtime->periods;

Liam
