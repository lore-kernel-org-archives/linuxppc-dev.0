Message-ID: <3D641186.2020800@mvista.com>
Date: Wed, 21 Aug 2002 15:17:42 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: akuster@dslextreme.com
Cc: jim <jduey@ccc-dcs.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question about ppc4xx_dma.h
References: <20020820203619.A456239211@server.weathercom.com> <3D62CE63.1030606@dslextreme.com> <3D63EC67.4000302@dslextreme.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Noticed that the order of clearing the old transfer mode bits and
setting the p_dma_ch->mode bits is reversed in the new patch, not sure
if this causes problems:

+       tmp_cntl |= (p_dma_ch->mode | DMA_CH_ENABLE);
+
+       switch (dmanr) {
+       case 0:
+               control = mfdcr(DCRN_DMACR0);
+               control |= tmp_cntl;
+               control &= ~(DMA_TM_MASK | DMA_TD);     /* clear all
mode bits */

This seems to set and then clear the p_dma_ch->mode bits in control
prior to writing to the DMACR, a problem?


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
