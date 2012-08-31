Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C8302C0325
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2012 13:08:13 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Geanta Neag Horia Ioan-B05471 <B05471@freescale.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "dan.j.williams@gmail.com" <dan.j.williams@gmail.com>,
 "herbert@gondor.hengli.com.au" <herbert@gondor.hengli.com.au>,
 "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v7 1/8] Talitos: Support for async_tx XOR offload
Date: Fri, 31 Aug 2012 03:08:05 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70FDB13@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1344500448-10927-1-git-send-email-qiang.liu@freescale.com>
 <FD18E5D573A8AB48A365D4D78185DE992E5C0D@039-SN1MPN1-001.039d.mgd.msft.net>
In-Reply-To: <FD18E5D573A8AB48A365D4D78185DE992E5C0D@039-SN1MPN1-001.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Phillips Kim-R1AAHA <R1AAHA@freescale.com>, Dan Williams <djbw@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Geanta Neag Horia Ioan-B05471
> Sent: Thursday, August 30, 2012 10:23 PM
> To: Liu Qiang-B32616; linux-crypto@vger.kernel.org;
> dan.j.williams@gmail.com; herbert@gondor.hengli.com.au;
> davem@davemloft.net; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Cc: Li Yang-R58472; Phillips Kim-R1AAHA; vinod.koul@intel.com;
> dan.j.williams@intel.com; arnd@arndb.de; gregkh@linuxfoundation.org; Liu
> Qiang-B32616
> Subject: RE: [PATCH v7 1/8] Talitos: Support for async_tx XOR offload
>=20
> On Thu, 9 Aug 2012 11:20:48 +0300, qiang.liu@freescale.com wrote:
> > From: Qiang Liu <qiang.liu@freescale.com>
> >
> > Expose Talitos's XOR functionality to be used for RAID parity
> > calculation via the Async_tx layer.
> >
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
> > Signed-off-by: Maneesh Gupta <Maneesh.Gupta@freescale.com>
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > Signed-off-by: Vishnu Suresh <Vishnu@freescale.com>
> > Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> > ---
> >  drivers/crypto/Kconfig   |    9 +
> >  drivers/crypto/talitos.c |  413
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/crypto/talitos.h |   53 ++++++
> >  3 files changed, 475 insertions(+), 0 deletions(-)
>=20
>=20
> > +static void talitos_xor_run_tx_complete_actions(struct
> talitos_xor_desc *desc,
> > +		struct talitos_xor_chan *xor_chan)
> > +{
> > +	struct device *dev =3D xor_chan->dev;
> > +	dma_addr_t dest, addr;
> > +	unsigned int src_cnt =3D desc->unmap_src_cnt;
> > +	unsigned int len =3D desc->unmap_len;
> > +	enum dma_ctrl_flags flags =3D desc->async_tx.flags;
> > +	struct dma_async_tx_descriptor *tx =3D &desc->async_tx;
> > +
> > +	/* unmap dma addresses */
> > +	dest =3D desc->hwdesc.ptr[6].ptr;
> > +	if (likely(!(flags & DMA_COMPL_SKIP_DEST_UNMAP)))
> > +		dma_unmap_page(dev, dest, len, DMA_BIDIRECTIONAL);
> > +
> > +	desc->idx =3D 6 - src_cnt;
> > +	if (likely(!(flags & DMA_COMPL_SKIP_SRC_UNMAP))) {
> > +		while(desc->idx < 6) {
> > +			addr =3D desc->hwdesc.ptr[desc->idx++].ptr;
> > +			if (addr =3D=3D dest)
> > +				continue;
> > +			dma_unmap_page(dev, addr, len, DMA_TO_DEVICE);
> > +		}
> > +	}
>=20
> No need for braces around the while block.
I will remove it.

>=20
> > +	/* run dependent operations */
> > +	dma_run_dependencies(tx);
> > +}
>=20
>=20
> > +static void talitos_release_xor(struct device *dev, struct
> talitos_desc *hwdesc,
> > +				void *context, int error)
> > +{
> > +	struct talitos_xor_desc *desc =3D context;
> > +	struct talitos_xor_chan *xor_chan;
> > +	dma_async_tx_callback callback;
> > +	void *callback_param;
> > +
> > +	if (unlikely(error))
> > +		dev_err(dev, "xor operation: talitos error %d\n", error);
> > +
> > +	xor_chan =3D container_of(desc->async_tx.chan, struct
> talitos_xor_chan,
> > +				common);
> > +	spin_lock_bh(&xor_chan->desc_lock);
> > +	if (xor_chan->completed_cookie < desc->async_tx.cookie)
> > +		xor_chan->completed_cookie =3D desc->async_tx.cookie;
> > +
> > +	callback =3D desc->async_tx.callback;
> > +	callback_param =3D desc->async_tx.callback_param;
> > +
> > +	if (callback) {
> > +		spin_unlock_bh(&xor_chan->desc_lock);
> > +		callback(callback_param);
> > +		spin_lock_bh(&xor_chan->desc_lock);
> > +	}
>=20
> Since callback_param is used only here, maybe:
>=20
> if (callback) {
> 	void *callback_param =3D desc->async_tx.callback_param;
>=20
> 	spin_unlock_bh(&xor_chan->desc_lock);
> 	callback(callback_param);
> 	spin_lock_bh(&xor_chan->desc_lock);
> }
Fine. I will modify it in next.

>=20
> > +
> > +	talitos_xor_run_tx_complete_actions(desc, xor_chan);
> > +
> > +	list_del(&desc->node);
> > +	list_add_tail(&desc->node, &xor_chan->free_desc);
> > +	spin_unlock_bh(&xor_chan->desc_lock);
> > +	if (!list_empty(&xor_chan->pending_q))
> > +		talitos_process_pending(xor_chan);
> > +}
>=20
>=20
> > +static int talitos_alloc_chan_resources(struct dma_chan *chan)
> > +{
> > +	struct talitos_xor_chan *xor_chan;
> > +	struct talitos_xor_desc *desc;
> > +	LIST_HEAD(tmp_list);
> > +	int i;
> > +
> > +	xor_chan =3D container_of(chan, struct talitos_xor_chan, common);
> > +
> > +	if (!list_empty(&xor_chan->free_desc))
> > +		return xor_chan->total_desc;
> > +
> > +	for (i =3D 0; i < TALITOS_MAX_DESCRIPTOR_NR; i++) {
> > +		desc =3D talitos_xor_alloc_descriptor(xor_chan,
> > +				GFP_KERNEL | GFP_DMA);
>=20
> talitos_xor_alloc_descriptor() is called here without holding
> the xor_chan->desc_lock and it increments xor_chan->total_desc.
> Isn't this an issue ?

No, please refer to the code as below,=20
+	list_add_tail(&desc->node, &tmp_list);

The list is temporary list, it will be merged to xor_chan->free_desc in nex=
t step, here is protected by lock,
+	spin_lock_bh(&xor_chan->desc_lock);
+	list_splice_init(&tmp_list, &xor_chan->free_desc);
+	spin_unlock_bh(&xor_chan->desc_lock);

>=20
> > +		if (!desc) {
> > +			dev_err(xor_chan->common.device->dev,
> > +				"Only %d initial descriptors\n", i);
> > +			break;
> > +		}
> > +		list_add_tail(&desc->node, &tmp_list);
> > +	}
> > +
> > +	if (!i)
> > +		return -ENOMEM;
> > +
> > +	/* At least one desc is allocated */
> > +	spin_lock_bh(&xor_chan->desc_lock);
> > +	list_splice_init(&tmp_list, &xor_chan->free_desc);
> > +	spin_unlock_bh(&xor_chan->desc_lock);
> > +
> > +	return xor_chan->total_desc;
> > +}
>=20
>=20
> > +/**
> > + * talitos_register_dma_async - Initialize the Freescale XOR ADMA
> device
> > + * It is registered as a DMA device with the capability to perform
> > + * XOR operation with the Async_tx layer.
> > + * The various queues and channel resources are also allocated.
> > + */
> > +static int talitos_register_async_tx(struct device *dev, int
> max_xor_srcs)
> > +{
> > +	struct talitos_private *priv =3D dev_get_drvdata(dev);
> > +	struct dma_device *dma_dev =3D &priv->dma_dev_common;
> > +	struct talitos_xor_chan *xor_chan;
> > +	int err;
> > +
> > +	xor_chan =3D kzalloc(sizeof(struct talitos_xor_chan), GFP_KERNEL);
> > +	if (!xor_chan) {
> > +		dev_err(dev, "unable to allocate xor channel\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dma_dev->dev =3D dev;
> > +	dma_dev->device_alloc_chan_resources =3D talitos_alloc_chan_resources=
;
> > +	dma_dev->device_free_chan_resources =3D talitos_free_chan_resources;
> > +	dma_dev->device_prep_dma_xor =3D talitos_prep_dma_xor;
> > +	dma_dev->max_xor =3D max_xor_srcs;
> > +	dma_dev->device_tx_status =3D talitos_is_tx_complete;
> > +	dma_dev->device_issue_pending =3D talitos_issue_pending;
> > +	INIT_LIST_HEAD(&dma_dev->channels);
> > +	dma_cap_set(DMA_XOR, dma_dev->cap_mask);
> > +
> > +	xor_chan->dev =3D dev;
> > +	xor_chan->common.device =3D dma_dev;
> > +	xor_chan->total_desc =3D 0;
> > +	INIT_LIST_HEAD(&xor_chan->submit_q);
> > +	INIT_LIST_HEAD(&xor_chan->pending_q);
> > +	INIT_LIST_HEAD(&xor_chan->in_progress_q);
> > +	INIT_LIST_HEAD(&xor_chan->free_desc);
> > +	spin_lock_init(&xor_chan->desc_lock);
> > +
> > +	list_add_tail(&xor_chan->common.device_node, &dma_dev->channels);
> > +	dma_dev->chancnt++;
> > +
> > +	err =3D dma_async_device_register(dma_dev);
> > +	if (err) {
> > +		dev_err(dev, "Unable to register XOR with Async_tx\n");
> > +		goto err_out;
>=20
> Replace the jump with talitos_unregister_async_xor(dev) and
> remove code under err_out label.
No, here should be reserved, it should free xor_chan and remove "dma_dev->c=
hancnt++;".
Actually, I find most of code doesn't care this return value.
I will correct it in next.

>=20
> > +	}
> > +
> > +	return err;
> > +
> > +err_out:
> > +	talitos_unregister_async_xor(dev);
> > +	return err;
> > +}
> > +#endif
>=20
>=20
> > diff --git a/drivers/crypto/talitos.h b/drivers/crypto/talitos.h
> > index 61a1405..fc9d125 100644
> > --- a/drivers/crypto/talitos.h
> > +++ b/drivers/crypto/talitos.h
> > @@ -30,6 +30,7 @@
> >
> >  #define TALITOS_TIMEOUT 100000
> >  #define TALITOS_MAX_DATA_LEN 65535
> > +#define TALITOS_MAX_DESCRIPTOR_NR 256
>=20
> This refers only to xor descriptors, so renaming it similar to
> TALITOS_MAX_XOR_DESCRIPTOR_NR would make sense.
I remember it is applied to other descriptors, I will check it again, if no=
t, I will rename it as you suggested.

>=20
> Besides these:
> 1. As Dan Williams mentioned, you should explain why you are using
> both spin_lock_bh and spin_lock_irqsave on the same lock.
I'm waiting for Dan's feedback about this patch, I will add description or =
correct it with other comments together.

> 2. I don't see anything added to talitos_remove(). Shouldn't
> talitos_unregister_async_xor() be called? Anything else?
> Have you tested with talitos built as a module?
My fault, it should be added in talitos_remove(); I will correct it in next=
.
Thanks for your review.

>=20
> Horia
