Content-Type: text/plain;
  charset="iso-8859-1"
From: jim <jduey@ccc-dcs.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Question about ppc4xx_dma.h
Date: Tue, 20 Aug 2002 15:26:18 +0000
MIME-Version: 1.0
Message-Id: <20020820203619.A456239211@server.weathercom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been trying to get DMA working on the 405GP and I've run across
something in ppc4xx_dma.h.

In the function 'enable_dma' the following piece of code appears:

(begin excerpt)
	/* for other xfer modes, the addresses are already set */
	control = mfdcr(DCRN_DMACR0);
	control &= ~(DMA_TM_MASK | DMA_TD);	/* clear all mode bits */
	if (p_dma_ch->mode == DMA_MODE_MM) {
		/* software initiated memory to memory */
		control |= control | DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
	}
	control |= (p_dma_ch->mode | DMA_CH_ENABLE);
	mtdcr(DCRN_DMACR0, control);
(end excerpt)

It looks to me like this code will always read/write the control register for
DMA channel 0 regardless of the channel specified by the parameter 'dmanr'
that is passed to the function.  Is this observation correct?  What would the
fix be, if so?

Also, does anyone have a short piece of code that shows how to start a DMA
read on the 405?

Thanks,
Jim

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
