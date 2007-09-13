Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC1E5DDD0D
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 20:13:14 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l8DAD7Nc020366
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 03:13:07 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l8DAD64l006793
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 05:13:06 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xxprocessors.
Date: Thu, 13 Sep 2007 18:13:06 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D8A5@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070907223553.GA18599@freescale.com>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<20070907223553.GA18599@freescale.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>, <dan.j.williams@intel.com>
Cc: linuxppc-dev@ozlabs.org, shannon.nelson@intel.com, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,=20

> > +static void fsl_dma_set_src(dma_addr_t addr,
> > +				struct dma_async_tx_descriptor=20
> *tx, int index)
> > +{
>=20
> What is index supposed to mean?  It's not used, or documented=20
> anywhere than
> I can see.

I've also got more document here. Hi, Dan, could you give me some
explanation about this API? :)

>=20
> > +		else {
> > +			/* Run the link descriptor callback function */
> > +			if (desc->async_tx.callback) {
> > +			=09
> spin_unlock_irqrestore(&fsl_chan->desc_lock,
> > +								flags);
> > +				dev_dbg(fsl_chan->device->dev,
> > +					"link descriptor %p=20
> callback\n", desc);
> > +				desc->async_tx.callback(
> > +					=09
> desc->async_tx.callback_param);
> > +			=09
> spin_lock_irqsave(&fsl_chan->desc_lock, flags);
>=20
> After dropping the lock, you can no longer assume that your=20
> iterator is
> still valid; you need to work off of the list head.
>=20

list_for_each_entry_safe() is used here. I think the safe should be ok.
:P

> > +	/* Find the first un-transfer desciptor */
> > +	for (ld_node =3D fsl_chan->ld_queue.next;
> > +		(ld_node !=3D &fsl_chan->ld_queue)
> > +			&& (DMA_SUCCESS =3D=3D dma_async_is_complete(
> > +				=09
> to_fsl_desc(ld_node)->async_tx.cookie,
> > +					fsl_chan->completed_cookie,
> > +					fsl_chan->common.cookie));
> > +		ld_node =3D ld_node->next);
>=20
> Call fsl_dma_is_complete directly, don't waste time going through the
> virtual call.
>=20
> And you have a recursive lock usage here; fsl_dma_is_complete calls
> fsl_chan_ld_cleanup, which acquires desc_lock, but you=20
> already have it.
>=20
> Couldn't you just call fsl_chan_ld_cleanup, and then check=20
> what's at the
> head of the list?
>=20

I'll split interrupt and poll here.

> > +static irqreturn_t fsl_dma_do_interrupt(int irq, void *data)
> > +{
> > +	struct fsl_dma_device *fdev =3D (struct fsl_dma_device *)data;
> > +	struct fsl_dma_chan *fsl_chan =3D NULL;
> > +	u32 gsr;
> > +	int ch_nr;
> > +	struct dma_chan *int_chan;
> > +
> > +	gsr =3D (fdev->feature & FSL_DMA_BIG_ENDIAN) ?=20
> in_be32(fdev->reg_base)
> > +			: in_le32(fdev->reg_base);
> > +	ch_nr =3D (32 - ffs(gsr)) / 8;
> > +
> > +	list_for_each_entry(int_chan, &fdev->common.channels,=20
> device_node)
> > +		if (to_fsl_chan(int_chan)->id =3D=3D ch_nr)
> > +			fsl_chan =3D to_fsl_chan(int_chan);
>=20
> Why not use an array of channels?

The list is used in dma engine core file. And it's possible that there
are not all channel listed in dts and array.

> > +
> > +	return fsl_chan ? fsl_dma_chan_do_interrupt(irq,=20
> fsl_chan) : IRQ_NONE;
> > +
> > +}
> > +
> > +static void dma_do_tasklet(unsigned long unused)
> > +{
> > +	struct fsl_desc_sw *desc, *_desc;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&recy_ln_lock, flags);
> > +	list_for_each_entry_safe(desc, _desc, &recy_ln_chain, node) {
> > +		struct fsl_dma_chan *fsl_chan =3D
> > +				=09
> to_fsl_chan(desc->async_tx.chan);
> > +		/* Run the link descriptor callback function */
> > +		if (desc->async_tx.callback) {
> > +			spin_unlock_irqrestore(&recy_ln_lock, flags);
> > +			dev_dbg(fsl_chan->device->dev,
> > +				"dma_tasklet: link descriptor=20
> %p callback\n",
> > +				desc);
> > +			desc->async_tx.callback(
> > +					desc->async_tx.callback_param);
> > +			spin_lock_irqsave(&recy_ln_lock, flags);
> > +		}
> > +		/* Recycle it! */
> > +		list_del(&desc->node);
>=20
> You should remove it from the list before dropping the lock,=20
> as otherwise
> something else could come along and remove it again.

All right!

>=20
> > +	if (strcmp(match->compatible, "fsl,mpc8540-dma-channel") =3D=3D 0)
> > +		new_fsl_chan->feature =3D FSL_DMA_IP_86XX |=20
> FSL_DMA_BIG_ENDIAN;
>=20
> Shouldn't it be 85XX, to be consistent?
>=20
> > +	else if (strcmp(match->compatible,=20
> "fsl,mpc8349-dma-channel") =3D=3D 0)
> > +		new_fsl_chan->feature =3D FSL_DMA_IP_83XX |=20
> FSL_DMA_LITTLE_ENDIAN;
>=20
> You could have the features be part of the match struct, so=20
> you don't have
> to do extra strcmps.
>=20

Can I use the data field of struct of_device_id?

>=20
> > +static struct of_device_id of_fsl_dma_ids[] =3D {
> > +	{ .compatible =3D "fsl,dma", },
> > +};
>=20
> Why do we need to bind to the parent node at all?

Yes, the MPC83xx should get interrupt source from DMA device register.

>=20
> > +/* There is no asm instructions for 64 bits reverse loads=20
> and stores */
> > +static u64 in_le64(const u64 __iomem *addr)
> > +{
> > +	return le64_to_cpu(in_be64(addr));
> > +}
> > +
> > +static void out_le64(u64 __iomem *addr, u64 val)
> > +{
> > +	out_be64(addr, cpu_to_le64(val));
> > +}
> > +#endif
>=20
> You can use asm instructions for this, as such:

Aha, they are just copied from io.h.

>=20
> static u64 in_le64(const u64 __iomem *addr)
> {
> 	return ((u64)in_le32((u32 *)addr + 1) << 32) |=20
> (in_le32((u32 *)addr));
> }
>=20
>=20
> static void out_le64(u64 __iomem *addr, u64 val)
> {
> 	out_le32((u32 *)addr, (u32)val);
> 	out_le32((u32 *)addr + 1, val >> 32);
> }
>=20

And I agree with your other comments.

Thanks a lot!
- zw
