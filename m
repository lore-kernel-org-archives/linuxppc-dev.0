Message-ID: <3D62CE63.1030606@dslextreme.com>
Date: Tue, 20 Aug 2002 16:18:59 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: jim <jduey@ccc-dcs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question about ppc4xx_dma.h
References: <20020820203619.A456239211@server.weathercom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jim wrote:
> I've been trying to get DMA working on the 405GP and I've run across
> something in ppc4xx_dma.h.
>
> In the function 'enable_dma' the following piece of code appears:
>
> (begin excerpt)
> 	/* for other xfer modes, the addresses are already set */
> 	control = mfdcr(DCRN_DMACR0);
> 	control &= ~(DMA_TM_MASK | DMA_TD);	/* clear all mode bits */
> 	if (p_dma_ch->mode == DMA_MODE_MM) {
> 		/* software initiated memory to memory */
> 		control |= control | DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
> 	}
> 	control |= (p_dma_ch->mode | DMA_CH_ENABLE);
> 	mtdcr(DCRN_DMACR0, control);
> (end excerpt)
>
> It looks to me like this code will always read/write the control register for
> DMA channel 0 regardless of the channel specified by the parameter 'dmanr'
> that is passed to the function.  Is this observation correct?

good catch.

>What would the
> fix be, if so?
>
Most likey switch statment like the disable has.

give me a day

Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
