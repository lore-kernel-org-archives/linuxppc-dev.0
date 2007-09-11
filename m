Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 04EC5DDE49
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 20:30:22 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l8BAUGmh020684
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 03:30:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l8BAUFQI027666
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:30:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
Date: Tue, 11 Sep 2007 18:30:14 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D620@zch01exm26.fsl.freescale.net>
In-Reply-To: <e9c3a7c20709091053u607e710ay1eb76c53312706ea@mail.gmail.com>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20709091053u607e710ay1eb76c53312706ea@mail.gmail.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Dan Williams" <dan.j.williams@intel.com>
Cc: shannon.nelson@intel.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Dan,

Does I have followed your new API? :-)

> > ---
> Greetings,
>=20
> Please copy me on any updates to this driver, drivers/dma, or=20
> crypto/async_tx.

Ok.

>=20
> Below are a few review comments...
>=20
> Regards,
> Dan
>=20
> > +/**
> > + * fsl_dma_alloc_descriptor - Allocate descriptor from=20
> channel's DMA pool.
> > + *
> > + * Return - The descriptor allocated. NULL for failed.
> > + */
> > +static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
> > +                                       struct fsl_dma_chan=20
> *fsl_chan,
> > +                                       gfp_t flags)
> > +{
> > +       dma_addr_t pdesc;
> > +       struct fsl_desc_sw *desc_sw;
> > +
> > +       desc_sw =3D dma_pool_alloc(fsl_chan->desc_pool,=20
> flags, &pdesc);
> > +       if (desc_sw) {
> > +               memset(desc_sw, 0, sizeof(struct fsl_desc_sw));
> > +               dma_async_tx_descriptor_init(&desc_sw->async_tx,
> > +                                               &fsl_chan->common);
> > +               desc_sw->async_tx.tx_set_src =3D fsl_dma_set_src;
> > +               desc_sw->async_tx.tx_set_dest =3D fsl_dma_set_dest;
> > +               desc_sw->async_tx.tx_submit =3D fsl_dma_tx_submit;
> > +               INIT_LIST_HEAD(&desc_sw->async_tx.tx_list);
> > +               desc_sw->async_tx.phys =3D pdesc;
> > +       }
> > +
> > +       return desc_sw;
> > +}
>=20
> I suggest pre-allocating the descriptors:
> 1/ It alleviates the need to initialize these async_tx fields=20
> which never change

The dma pool has already stored the descriptors in it's list,

> 2/ The GFP_ATOMIC allocation can be removed.
>=20

Ok.

> iop-adma gets by with one PAGE_SIZE buffer (128 descriptors).
>=20
> [..]
> > +static irqreturn_t fsl_dma_chan_do_interrupt(int irq, void *data)
> > +{
> > +       struct fsl_dma_chan *fsl_chan =3D (struct fsl_dma_chan =
*)data;
> > +       dma_addr_t stat;
> > +
> > +       stat =3D get_sr(fsl_chan);
> > +       dev_dbg(fsl_chan->device->dev, "event: channel %d,=20
> stat =3D 0x%x\n",
> > +                                               fsl_chan->id, stat);
> > +       set_sr(fsl_chan, stat);         /* Clear the event=20
> register */
> > +
> > +       stat &=3D ~(FSL_DMA_SR_CB | FSL_DMA_SR_CH);
> > +       if (!stat)
> > +               return IRQ_NONE;
> > +
> > +       /* If the link descriptor segment transfer finishes,
> > +        * we will recycle the used descriptor.
> > +        */
> > +       if (stat & FSL_DMA_SR_EOSI) {
> > +               dev_dbg(fsl_chan->device->dev, "event:=20
> End-of-segments INT\n");
> > +               dev_dbg(fsl_chan->device->dev, "event:=20
> clndar 0x%016llx, "
> > +                               "nlndar 0x%016llx\n",=20
> (u64)get_cdar(fsl_chan),
> > +                               (u64)get_ndar(fsl_chan));
> > +               stat &=3D ~FSL_DMA_SR_EOSI;
> > +               fsl_chan_ld_cleanup(fsl_chan, 1);
> > +       }
> > +
> > +       /* If it current transfer is the end-of-transfer,
> > +        * we should clear the Channel Start bit for
> > +        * prepare next transfer.
> > +        */
> > +       if (stat & (FSL_DMA_SR_EOLNI | FSL_DMA_SR_EOCDI)) {
> > +               dev_dbg(fsl_chan->device->dev, "event:=20
> End-of-link INT\n");
> > +               stat &=3D ~FSL_DMA_SR_EOLNI;
> > +               fsl_chan_xfer_ld_queue(fsl_chan);
> > +       }
> > +
> > +       if (stat)
> > +               dev_dbg(fsl_chan->device->dev, "event:=20
> unhandled sr 0x%02x\n",
> > +                                       stat);
> > +
> > +       dev_dbg(fsl_chan->device->dev, "event: Exit\n");
> > +       tasklet_hi_schedule(&dma_tasklet);
> > +       return IRQ_HANDLED;
> > +}
>=20
> This driver implements locking and callbacks inconsistently with how
> it is done in ioatdma and iop-adma.  The big changes are that all
> locks have been upgraded from 'spin_lock_bh' to 'spin_lock_irqsave',
> and async_tx callbacks can happen in irq context.  I would like to
> keep everything in bottom-half context to lessen the restrictions on
> what async_tx clients can perform in their callback routines.  What
> are the implications of moving 'fsl_chan_ld_cleanup' to the tasklet
> and changing the 'tasklet_hi_schedule' to 'tasklet_schedule'?

A good suggestion :), I need some investigation here.

>=20
> [..]
> > +static struct dma_chan=20
> *of_find_dma_chan_by_phandle(phandle phandle)
> > +{
> > +       struct device_node *np;
> > +       struct dma_chan *chan;
> > +       struct fsl_dma_device *fdev;
> > +
> > +       np =3D of_find_node_by_phandle(phandle);
> > +       if (!np || !of_device_is_compatible(np->parent, "fsl,dma"))
> > +               return NULL;
> > +
> > +       fdev =3D=20
> dev_get_drvdata(&of_find_device_by_node(np->parent)->dev);
> > +
> > +       list_for_each_entry(chan, &fdev->common.channels,=20
> device_node)
> > +               if=20
> (to_of_device(to_fsl_chan(chan)->chan_dev)->node =3D=3D np)
> > +                       return chan;
> > +       return NULL;
> > +}
> > +EXPORT_SYMBOL(of_find_dma_chan_by_phandle);
>=20
> This routine implies that there is a piece of code somewhere that
> wants to select which channels it can use.  A similar effect can be
> achieved by registering a dma_client with the dmaengine interface
> ('dma_async_client_register').  Then when the client code makes a call
> to 'dma_async_client_chan_request' it receives a 'dma_event_callback'
> for each channel in the system.  It will also be asynchronously
> notified of channels entering and leaving the system.  The goal is to
> share a common infrastructure for channel management.
>=20

It's speacial codes for our processors. Some device need the speacial =
DMA channel, such as must be DMA channel 0. So I add these codes. Or, is =
it possible to add a API for the special DMA channel getting?

> > +
> > +static int __devinit of_fsl_dma_probe(struct of_device *dev,
> > +                       const struct of_device_id *match)
> > +{
> > +       int err;
> > +       unsigned int irq;
> > +       struct fsl_dma_device *fdev;
> > +
> > +       fdev =3D kzalloc(sizeof(struct fsl_dma_device), GFP_KERNEL);
> > +       if (!fdev) {
> > +               dev_err(&dev->dev, "No enough memory for 'priv'\n");
> > +               err =3D -ENOMEM;
> > +               goto err;
> > +       }
> > +       fdev->dev =3D &dev->dev;
> > +       INIT_LIST_HEAD(&fdev->common.channels);
> > +
> > +       /* get DMA controller register base */
> > +       err =3D of_address_to_resource(dev->node, 0, &fdev->reg);
> > +       if (err) {
> > +               dev_err(&dev->dev, "Can't get %s property 'reg'\n",
> > +                               dev->node->full_name);
> > +               goto err;
> > +       }
> > +
> > +       dev_info(&dev->dev, "Probe the Freescale DMA driver for %s "
> > +                       "controller at 0x%08x...\n",
> > +                       match->compatible, fdev->reg.start);
> > +       fdev->reg_base =3D ioremap(fdev->reg.start, fdev->reg.end
> > +                                               -=20
> fdev->reg.start + 1);
> > +
> > +       dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
> > +       fdev->common.device_alloc_chan_resources =3D=20
> fsl_dma_alloc_chan_resources;
> > +       fdev->common.device_free_chan_resources =3D=20
> fsl_dma_free_chan_resources;
> > +       fdev->common.device_prep_dma_memcpy =3D fsl_dma_prep_memcpy;
> > +       fdev->common.device_is_tx_complete =3D fsl_dma_is_complete;
> > +       fdev->common.device_issue_pending =3D=20
> fsl_dma_memcpy_issue_pending;
> > +       fdev->common.device_dependency_added =3D=20
> fsl_dma_dependency_added;
> > +       fdev->common.dev =3D &dev->dev;
> > +
> If this driver adds:
>=20
> dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
> fdev->common.device_prep_dma_interrupt =3D fsl_dma_prep_interrupt;
>=20
> It will be able to take advantage of interrupt triggered callbacks in
> async_tx.  Without these changes async_tx will poll for the completion
> of each transaction.
>=20

The new API have lacking documents :) I'll make some study here.

Thanks!
- zw
