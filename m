Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3F91A2C0339
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 09:29:55 +1000 (EST)
Message-ID: <1343086186.2957.46.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Date: Tue, 24 Jul 2012 09:29:46 +1000
In-Reply-To: <500DDB1B.9030900@freescale.com>
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop>	<500D7921.6060804@freescale.com>
 <1343082030.2957.38.camel@pasglop>
 <CAOZdJXXd6GuLAed_Z4zNMjDN+DBBXHdd0yVRHof+BJ_eiUMbqQ@mail.gmail.com>
 <1343085145.2957.44.camel@pasglop> <500DDB1B.9030900@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Chen Yuanquan-B41889 <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 18:15 -0500, Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> > Sure, that's the right way to go, I meant bits of pieces of the
> > infrastructure in between. Why diverge from other archs gratuituously
> > here ?
> 
> Ok, I'm confused.  Are you suggesting that drivers do this:
> 
> u64 fsl_dma_dmamask = DMA_BIT_MASK(36);
> dev->dma_mask = &fsl_dma_dmamask;
> v = dma_alloc_coherent(dev, ..., GFP_DMA32);
> 
> That is, set the DMA mask *and* set GFP_DMA32?  That seems redundant.

No, but dma_alloc_coherent would under the hood.

> I don't understand why a driver would set GFP_DMA32 if it has already set
> the mask.

The layers in between, not the well behaved drivers. Again, we have
ZONE_DMA32 specifically for the purpose, why use something else ?

In any case, make the whole thing at the very least a config option, I
don't want sane HW to have to deal with split zones.

Cheers,
Ben.
