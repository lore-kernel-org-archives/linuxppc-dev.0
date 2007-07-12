Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3DD25DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 20:06:54 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6CA6iK9005944
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 03:06:45 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6CA6h4P025841
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 05:06:44 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 4/4] Add DMA engine driver for Freescale MPC8xxx
	processors.
Date: Thu, 12 Jul 2007 18:06:41 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3E46@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070711163438.GA17293@ld0162-tx32.am.freescale.net>
References: <11840607262279-git-send-email-wei.zhang@freescale.com>
	<20070711163438.GA17293@ld0162-tx32.am.freescale.net>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Wood Scott-B07421=20
>=20
> On Tue, Jul 10, 2007 at 05:45:26PM +0800, Zhang Wei wrote:
> > +config FSL_DMA
> > +	bool "Freescale MPC8xxx DMA support"
> > +	depends on DMA_ENGINE && (PPC_86xx || PPC_85xx)
>=20
> Remove the dependency on specific PPC chips...  let the=20
> device tree say
> whether the hardware is present.

.... Remove it.

>=20
> > +static inline int fsl_dma_idle(struct fsl_dma_chan *fsl_chan)
> > +{
> > +	return (((in_be32(&fsl_chan->reg_base->sr) &=20
> FSL_DMA_SR_CB) =3D=3D 0) &&
> > +		((in_be32(&fsl_chan->reg_base->mr) &=20
> FSL_DMA_MR_CC) =3D=3D 0));
> > +}
>=20
> I'm still not convinced that there's any reason to check=20
> MR_CC, even if
> the driver *did* set it.
>=20
Remove it.

> > +	/* We need the descriptor to be aligned to 32bytes
> > +	 * for meeting FSL DMA specification requirement.
> > +	 */
> > +	fsl_chan->desc_pool =3D=20
> dma_pool_create("fsl_dma_engine_desc_pool",
> > +			fsl_chan->device->dev, sizeof(struct=20
> fsl_desc_sw),
> > +			32, 0);
> > +	if (unlikely(!fsl_chan->desc_pool)) {
> > +		dev_err(fsl_chan->device->dev, "No memory for=20
> channel %d "
> > +			"descriptor dma pool.\n", fsl_chan->id);
> > +		return 0;
> > +	}
> > +
> > +	/* Allocate list ring, and form the static list ring */
> > +	for (i =3D 0; i < FSLDMA_LD_INIT_RING_SIZE; i++) {
> > +		desc =3D fsl_dma_alloc_descriptor(fsl_chan->desc_pool,
> > +				GFP_KERNEL);
>=20
> It'd be much simpler to allocate the entire ring at once.  No need for
> linked lists, DMA pools, etc.  Just a single dma_alloc_coherent.
>=20

I use a flexible ld ring size here. If there is no more free ring, the
driver can add new ld to the ring.

> In general, this driver seems far more complex than it needs to be.
>=20
> > +		switch (fsl_chan->mode) {
> > +		case FSL_DMA_EXTENDED:
>=20
> What benefit do we get out of using extended mode?  If the=20
> driver can do
> everything it needs to with basic, with no performance=20
> penalty, why not
> always use basic?
>=20

Why there are extended mode in silicon? :) Since there are here, we use
it.

> > +static dma_cookie_t do_fsl_dma_memcpy(struct fsl_dma_chan=20
> *fsl_chan,
> > +				      dma_addr_t dest,
> > +				      dma_addr_t src, size_t len,
> > +				      dma_xfer_callback cb, void *data)
> > +{
> > +	struct fsl_desc_sw *first =3D NULL, *prev =3D NULL, *list, *new;
> > +	size_t copy;
> > +	dma_cookie_t cookie;
> > +	unsigned long flags;
> > +	struct fsl_dma_device *fdev =3D fsl_chan->device;
> > +	int err =3D 0;
> > +	LIST_HEAD(link_chain);
> > +
> > +	if (unlikely(!fsl_chan || !dest || !src))
> > +		return -EFAULT;
>=20
> -EINVAL for fsl_chan, if you bother checking at all (I wouldn't; it
> doesn't come from untrusted code.  Better to show a=20
> nasty-looking oops to
> bring attention to the problem).
>=20
> Don't check dest and src against NULL; zero is a potentially valid DMA
> address.

Ok. Do not check dest and src with NULL value. Hope the caller know what
he do.:)

>=20
> > +		/* Stop the DMA */
> > +		fsl_dma_halt(fsl_chan);
> > +		/* Insert the ld descriptor to the LD ring */
> > +		list_add(&ld->node, fsl_chan->enque);
> > +		switch (fsl_chan->mode) {
> > +		case FSL_DMA_EXTENDED:
> > +			INSERT_LD_RING(fsl_chan, ld, list,=20
> next_ls_addr);
> > +			break;
> > +		case FSL_DMA_BASIC:
> > +			INSERT_LD_RING(fsl_chan, ld, link,=20
> next_ln_addr);
> > +			break;
> > +		}
> > +		spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);
>=20
> It'd be nice if we didn't have to stop the DMA in order to insert new
> descriptors.

Since there is only happen at no more free ld in the ring. We need to
break the ld-ring and add new ld to it. So the most safe operation is to
stop DMA controller.

>=20
> > +	/* cookie incr and addition to used_list must be atomic */
> > +	cookie =3D fsl_chan->common.cookie;
> > +	cookie++;
> > +	if (cookie < 0)
> > +		cookie =3D 1;
>=20
> Why not just use the index into the ring as the cookie?

The cookie will record all transfer by increased number. The ring index
is less for all transfer.

>=20
> > +	stat =3D in_be32(&fsl_chan->reg_base->sr);
> > +	dev_dbg(fsl_chan->device->dev, "event: channel %d, stat=20
> =3D 0x%x\n",
> > +						fsl_chan->id, stat);
> > +	if (!stat)
> > +		return IRQ_NONE;
> > +	busy =3D stat & (FSL_DMA_SR_CB);
> > +	stat &=3D ~(FSL_DMA_SR_CB | FSL_DMA_SR_CH);
>=20
> This masking must happen *before* the IRQ_NONE check.
>=20
Really? FSL_DMA_SR_CH is also a stat of event. And I need the
FSL_DMA_SR_CB status.

Thanks!
Wei.
