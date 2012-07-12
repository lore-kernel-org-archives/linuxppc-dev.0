Return-Path: <B32616@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 967902C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 12:33:17 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: RE: [PATCH v2 2/4] fsl-dma: remove attribute DMA_INTERRUPT of
 dmaengine
Date: Thu, 12 Jul 2012 02:33:09 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C07CD@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1341997253-18424-1-git-send-email-qiang.liu@freescale.com>
 <20120711161713.GC17539@ovro.caltech.edu>
In-Reply-To: <20120711161713.GC17539@ovro.caltech.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Vinod Koul <vinod.koul@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "herbert@gondor.hengli.org.au" <herbert@gondor.hengli.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Ira W. Snyder [mailto:iws@ovro.caltech.edu]
> Sent: Thursday, July 12, 2012 12:17 AM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Vinod
> Koul; herbert@gondor.hengli.com.au; Dan Williams; davem@davemloft.net
> Subject: Re: [PATCH v2 2/4] fsl-dma: remove attribute DMA_INTERRUPT of
> dmaengine
>=20
> On Wed, Jul 11, 2012 at 05:00:53PM +0800, Qiang Liu wrote:
> > Delete attribute DMA_INTERRUPT because fsl-dma doesn't support this
> function,
> > exception will be thrown if talitos is used to offload xor at the same
> time.
> >
>=20
> Both drivers/misc/carma/carma-fpga.c and
> drivers/misc/carma/carma-fpga-program.c expect the DMA_INTERRUPT
> property, though they do not use it. The mask is set for historical
> reasons. It is safe to delete the line "dma_cap_set(DMA_INTERRUPT,
> mask);"
> from both drivers.
>=20
> I don't know which other drivers may expect this feature to be present.
> These are only the ones which I maintain.
The only place is in async_tx api which the feature is used. But it does no=
t
work fine as expected of DMA_INTERRUPT. In fsl-dma, it will raise a program
error if source or destination address is zero.

>=20
> Other than that, you can add my:
> Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>
Thanks.

>=20
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Li Yang <leoli@freescale.com>
> > Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> > ---
> >  drivers/dma/fsldma.c |   31 -------------------------------
> >  1 files changed, 0 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > index 8f84761..4f2f212 100644
> > --- a/drivers/dma/fsldma.c
> > +++ b/drivers/dma/fsldma.c
> > @@ -543,35 +543,6 @@ static void fsl_dma_free_chan_resources(struct
> dma_chan *dchan)
> >  }
> >
> >  static struct dma_async_tx_descriptor *
> > -fsl_dma_prep_interrupt(struct dma_chan *dchan, unsigned long flags)
> > -{
> > -	struct fsldma_chan *chan;
> > -	struct fsl_desc_sw *new;
> > -
> > -	if (!dchan)
> > -		return NULL;
> > -
> > -	chan =3D to_fsl_chan(dchan);
> > -
> > -	new =3D fsl_dma_alloc_descriptor(chan);
> > -	if (!new) {
> > -		chan_err(chan, "%s\n", msg_ld_oom);
> > -		return NULL;
> > -	}
> > -
> > -	new->async_tx.cookie =3D -EBUSY;
> > -	new->async_tx.flags =3D flags;
> > -
> > -	/* Insert the link descriptor to the LD ring */
> > -	list_add_tail(&new->node, &new->tx_list);
> > -
> > -	/* Set End-of-link to the last link descriptor of new list */
> > -	set_ld_eol(chan, new);
> > -
> > -	return &new->async_tx;
> > -}
> > -
> > -static struct dma_async_tx_descriptor *
> >  fsl_dma_prep_memcpy(struct dma_chan *dchan,
> >  	dma_addr_t dma_dst, dma_addr_t dma_src,
> >  	size_t len, unsigned long flags)
> > @@ -1352,12 +1323,10 @@ static int __devinit fsldma_of_probe(struct
> platform_device *op)
> >  	fdev->irq =3D irq_of_parse_and_map(op->dev.of_node, 0);
> >
> >  	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
> > -	dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
> >  	dma_cap_set(DMA_SG, fdev->common.cap_mask);
> >  	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
> >  	fdev->common.device_alloc_chan_resources =3D
> fsl_dma_alloc_chan_resources;
> >  	fdev->common.device_free_chan_resources =3D
> fsl_dma_free_chan_resources;
> > -	fdev->common.device_prep_dma_interrupt =3D fsl_dma_prep_interrupt;
> >  	fdev->common.device_prep_dma_memcpy =3D fsl_dma_prep_memcpy;
> >  	fdev->common.device_prep_dma_sg =3D fsl_dma_prep_sg;
> >  	fdev->common.device_tx_status =3D fsl_tx_status;
> > --
> > 1.7.5.1
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
