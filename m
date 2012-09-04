Return-Path: <B32616@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6A812C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 22:28:52 +1000 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Dan Williams <djbw@fb.com>
Subject: RE: [PATCH v7 1/8] Talitos: Support for async_tx XOR offload
Date: Tue, 4 Sep 2012 12:28:42 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70FFB67@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1344500448-10927-1-git-send-email-qiang.liu@freescale.com>
 <CAA9_cmdqmuhAcaqfkjvKSpsTL350BAJcY8pn6U=SJ9Nok1-XuA@mail.gmail.com>
In-Reply-To: <CAA9_cmdqmuhAcaqfkjvKSpsTL350BAJcY8pn6U=SJ9Nok1-XuA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Phillips Kim-R1AAHA <R1AAHA@freescale.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: dan.j.williams@gmail.com [mailto:dan.j.williams@gmail.com] On
> Behalf Of Dan Williams
> Sent: Sunday, September 02, 2012 4:12 PM
> To: Liu Qiang-B32616
> Cc: linux-crypto@vger.kernel.org; herbert@gondor.hengli.com.au;
> davem@davemloft.net; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Li Yang-R58472; Phillips Kim-R1AAHA;
> vinod.koul@intel.com; dan.j.williams@intel.com; arnd@arndb.de;
> gregkh@linuxfoundation.org
> Subject: Re: [PATCH v7 1/8] Talitos: Support for async_tx XOR offload
>=20
> On Thu, Aug 9, 2012 at 1:20 AM,  <qiang.liu@freescale.com> wrote:
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
> >
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index be6b2ba..f0a7c29 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -222,6 +222,15 @@ config CRYPTO_DEV_TALITOS
> >           To compile this driver as a module, choose M here: the module
> >           will be called talitos.
> >
> > +config CRYPTO_DEV_TALITOS_RAIDXOR
> > +       bool "Talitos RAID5 XOR Calculation Offload"
> > +       default y
>=20
> No, default y.  The user should explicitly enable this.
Ok, I will change it to N.

>=20
> > +       select DMA_ENGINE
> > +       depends on CRYPTO_DEV_TALITOS
> > +       help
> > +         Say 'Y' here to use the Freescale Security Engine (SEC) to
> > +         offload RAID XOR parity Calculation
> > +
>=20
> Is it faster than cpu xor?
Yes, I tested with IOZone, cpu load is also reduced.
I think one possible reason is the processor of p1022ds is not strong as ot=
hers, so the performance is improved obviously.

>=20
> Will this engine be coordinating with another to handle memory copies?
>  The dma mapping code for async_tx/raid is broken when dma mapping
> requests overlap or cross dma device boundaries [1].
>=20
> [1]: http://marc.info/?l=3Dlinux-arm-kernel&m=3D129407269402930&w=3D2
Yes, it needs fsl-dma to handle memcpy copies.
I read your link, the unmap address is stored in talitos hwdesc, the addres=
s will be unmapped when async_tx ack this descriptor, I know fsl-dma won't =
wait this ack flag in current kernel, so I fix it in fsl-dma patch 5/8. Do =
you mean that?

>=20
> > +static void talitos_process_pending(struct talitos_xor_chan *xor_chan)
> > +{
> > +       struct talitos_xor_desc *desc, *_desc;
> > +       unsigned long flags;
> > +       int status;
> > +       struct talitos_private *priv;
> > +       int ch;
> > +
> > +       priv =3D dev_get_drvdata(xor_chan->dev);
> > +       ch =3D atomic_inc_return(&priv->last_chan) &
> > +                                 (priv->num_channels - 1);
>=20
> Maybe a comment about why this this is duplicated from
> talitos_cra_init()?  It sticks out here and I had to go looking to
> find out why this channel number increments on submit.
My fault, I will correct it as below,

atomic_read((&priv->last_chan) & (priv->num_channels - 1);

>=20
>=20
> > +       spin_lock_irqsave(&xor_chan->desc_lock, flags);
> > +
> > +       list_for_each_entry_safe(desc, _desc, &xor_chan->pending_q,
> node) {
> > +               status =3D talitos_submit(xor_chan->dev, ch, &desc-
> >hwdesc,
> > +                                       talitos_release_xor, desc);
> > +               if (status !=3D -EINPROGRESS)
> > +                       break;
> > +
> > +               list_del(&desc->node);
> > +               list_add_tail(&desc->node, &xor_chan->in_progress_q);
> > +       }
> > +
> > +       spin_unlock_irqrestore(&xor_chan->desc_lock, flags);
> > +}
> > +
> > +static void talitos_xor_run_tx_complete_actions(struct
> talitos_xor_desc *desc,
> > +               struct talitos_xor_chan *xor_chan)
> > +{
> > +       struct device *dev =3D xor_chan->dev;
> > +       dma_addr_t dest, addr;
> > +       unsigned int src_cnt =3D desc->unmap_src_cnt;
> > +       unsigned int len =3D desc->unmap_len;
> > +       enum dma_ctrl_flags flags =3D desc->async_tx.flags;
> > +       struct dma_async_tx_descriptor *tx =3D &desc->async_tx;
> > +
> > +       /* unmap dma addresses */
> > +       dest =3D desc->hwdesc.ptr[6].ptr;
> > +       if (likely(!(flags & DMA_COMPL_SKIP_DEST_UNMAP)))
> > +               dma_unmap_page(dev, dest, len, DMA_BIDIRECTIONAL);
> > +
> > +       desc->idx =3D 6 - src_cnt;
> > +       if (likely(!(flags & DMA_COMPL_SKIP_SRC_UNMAP))) {
> > +               while(desc->idx < 6) {
>=20
> Checkpatch says:
> ERROR: space required before the open parenthesis '('
I will correct it next.

>=20
>=20
> > +                       addr =3D desc->hwdesc.ptr[desc->idx++].ptr;
> > +                       if (addr =3D=3D dest)
> > +                               continue;
> > +                       dma_unmap_page(dev, addr, len, DMA_TO_DEVICE);
> > +               }
> > +       }
> > +
> > +       /* run dependent operations */
> > +       dma_run_dependencies(tx);
>=20
> Here is where we run into problems if another engine accesses these
> same buffers, especially on ARM v6+.
Do you mean in dma_run_dependencies() will occur to the async_tx descriptor=
 of fsl-dma will be processed? I'm not clearly.


>=20
> > +}
> > +
> > +static void talitos_release_xor(struct device *dev, struct
> talitos_desc *hwdesc,
> > +                               void *context, int error)
> > +{
> > +       struct talitos_xor_desc *desc =3D context;
> > +       struct talitos_xor_chan *xor_chan;
> > +       dma_async_tx_callback callback;
> > +       void *callback_param;
> > +
> > +       if (unlikely(error))
> > +               dev_err(dev, "xor operation: talitos error %d\n",
> error);
> > +
> > +       xor_chan =3D container_of(desc->async_tx.chan, struct
> talitos_xor_chan,
> > +                               common);
> > +       spin_lock_bh(&xor_chan->desc_lock);
> > +       if (xor_chan->completed_cookie < desc->async_tx.cookie)
> > +               xor_chan->completed_cookie =3D desc->async_tx.cookie;
> > +
>=20
> Use dma_cookie_complete().
Ok, I will correct it.

>=20
> > +       callback =3D desc->async_tx.callback;
> > +       callback_param =3D desc->async_tx.callback_param;
> > +
> > +       if (callback) {
> > +               spin_unlock_bh(&xor_chan->desc_lock);
> > +               callback(callback_param);
> > +               spin_lock_bh(&xor_chan->desc_lock);
>=20
> As mentioned you'll either need to ensure that
> talitos_process_pending() is only called from the tasklet, or upgrade
> these locks to hardirq safe.
The point is flush_channel can be called both of interrupt and tasklet.
So the process should be redesigned that make sure talitos_process_pending(=
) is only called from tasklet. I will fix it in next series.
Thanks.

>=20
> > +       }
> > +
> > +       talitos_xor_run_tx_complete_actions(desc, xor_chan);
> > +
> > +       list_del(&desc->node);
> > +       list_add_tail(&desc->node, &xor_chan->free_desc);
> > +       spin_unlock_bh(&xor_chan->desc_lock);
> > +       if (!list_empty(&xor_chan->pending_q))
> > +               talitos_process_pending(xor_chan);
> > +}
> > +
> > +/**
> > + * talitos_issue_pending - move the descriptors in submit
> > + * queue to pending queue and submit them for processing
> > + * @chan: DMA channel
> > + */
> > +static void talitos_issue_pending(struct dma_chan *chan)
> > +{
> > +       struct talitos_xor_chan *xor_chan;
> > +
> > +       xor_chan =3D container_of(chan, struct talitos_xor_chan, common=
);
> > +       spin_lock_bh(&xor_chan->desc_lock);
> > +       list_splice_tail_init(&xor_chan->submit_q,
> > +                                &xor_chan->pending_q);
> > +       spin_unlock_bh(&xor_chan->desc_lock);
> > +       talitos_process_pending(xor_chan);
> > +}
> > +
> > +static dma_cookie_t talitos_async_tx_submit(struct
> dma_async_tx_descriptor *tx)
> > +{
> > +       struct talitos_xor_desc *desc;
> > +       struct talitos_xor_chan *xor_chan;
> > +       dma_cookie_t cookie;
> > +
> > +       desc =3D container_of(tx, struct talitos_xor_desc, async_tx);
> > +       xor_chan =3D container_of(tx->chan, struct talitos_xor_chan,
> common);
> > +
> > +       spin_lock_bh(&xor_chan->desc_lock);
> > +
> > +       cookie =3D xor_chan->common.cookie + 1;
> > +       if (cookie < 0)
> > +               cookie =3D 1;
>=20
> Should use the new dma_cookie_assign() helper.
Ok.

>=20
> > +
> > +       desc->async_tx.cookie =3D cookie;
> > +       xor_chan->common.cookie =3D desc->async_tx.cookie;
> > +
> > +       list_splice_tail_init(&desc->tx_list,
> > +                                &xor_chan->submit_q);
> > +
> > +       spin_unlock_bh(&xor_chan->desc_lock);
> > +
> > +       return cookie;
> > +}
> > +
> > +static struct talitos_xor_desc *talitos_xor_alloc_descriptor(
> > +                               struct talitos_xor_chan *xor_chan,
> gfp_t flags)
> > +{
> > +       struct talitos_xor_desc *desc;
> > +
> > +       desc =3D kmalloc(sizeof(*desc), flags);
> > +       if (desc) {
> > +               xor_chan->total_desc++;
> > +               desc->async_tx.tx_submit =3D talitos_async_tx_submit;
> > +       }
> > +
> > +       return desc;
> > +}
> > +
> [..]
I will remove this line.

> > +
> > +static struct dma_async_tx_descriptor *talitos_prep_dma_xor(
> > +                       struct dma_chan *chan, dma_addr_t dest,
> dma_addr_t *src,
> > +                       unsigned int src_cnt, size_t len, unsigned long
> flags)
> > +{
> > +       struct talitos_xor_chan *xor_chan;
> > +       struct talitos_xor_desc *new;
> > +       struct talitos_desc *desc;
> > +       int i, j;
> > +
> > +       BUG_ON(len > TALITOS_MAX_DATA_LEN);
> > +
> > +       xor_chan =3D container_of(chan, struct talitos_xor_chan, common=
);
> > +
> > +       spin_lock_bh(&xor_chan->desc_lock);
> > +       if (!list_empty(&xor_chan->free_desc)) {
> > +               new =3D container_of(xor_chan->free_desc.next,
> > +                                  struct talitos_xor_desc, node);
> > +               list_del(&new->node);
> > +       } else {
> > +                new =3D talitos_xor_alloc_descriptor(xor_chan,
> GFP_KERNEL | GFP_DMA);
>=20
> You can't hold a spin_lock over a GFP_KERNEL allocation.
Ok, I will fix it in next.

>=20
> > +       }
> > +       spin_unlock_bh(&xor_chan->desc_lock);
> > +
> > +       if (!new) {
> > +               dev_err(xor_chan->common.device->dev,
> > +                       "No free memory for XOR DMA descriptor\n");
> > +               return NULL;
> > +       }
> > +       dma_async_tx_descriptor_init(&new->async_tx, &xor_chan->common)=
;
> > +
> > +       INIT_LIST_HEAD(&new->node);
> > +       INIT_LIST_HEAD(&new->tx_list);
> > +
> > +       desc =3D &new->hwdesc;
> > +       /* Set destination: Last pointer pair */
> > +       to_talitos_ptr(&desc->ptr[6], dest);
> > +       desc->ptr[6].len =3D cpu_to_be16(len);
> > +       desc->ptr[6].j_extent =3D 0;
> > +       new->unmap_src_cnt =3D src_cnt;
> > +       new->unmap_len =3D len;
> > +
> > +       /* Set Sources: End loading from second-last pointer pair */
> > +       for (i =3D 5, j =3D 0; j < src_cnt && i >=3D 0; i--, j++) {
> > +               to_talitos_ptr(&desc->ptr[i], src[j]);
> > +               desc->ptr[i].len =3D cpu_to_be16(len);
> > +               desc->ptr[i].j_extent =3D 0;
> > +       }
> > +
> > +       /*
> > +        * documentation states first 0 ptr/len combo marks end of
> sources
> > +        * yet device produces scatter boundary error unless all
> subsequent
> > +        * sources are zeroed out
> > +        */
> > +       for (; i >=3D 0; i--) {
> > +               to_talitos_ptr(&desc->ptr[i], 0);
> > +               desc->ptr[i].len =3D 0;
> > +               desc->ptr[i].j_extent =3D 0;
> > +       }
> > +
> > +       desc->hdr =3D DESC_HDR_SEL0_AESU | DESC_HDR_MODE0_AESU_XOR |
> > +               DESC_HDR_TYPE_RAID_XOR;
> > +
> > +       new->async_tx.parent =3D NULL;
> > +       new->async_tx.next =3D NULL;
> > +       new->async_tx.cookie =3D 0;
> > +       async_tx_ack(&new->async_tx);
> > +
> > +       list_add_tail(&new->node, &new->tx_list);
> > +
> > +       new->async_tx.flags =3D flags;
> > +       new->async_tx.cookie =3D -EBUSY;
> > +
> > +       return &new->async_tx;
> > +}
> > +
> > +static void talitos_unregister_async_xor(struct device *dev)
> > +{
> > +       struct talitos_private *priv =3D dev_get_drvdata(dev);
> > +       struct talitos_xor_chan *xor_chan;
> > +       struct dma_chan *chan, *_chan;
> > +
> > +       if (priv->dma_dev_common.chancnt)
> > +               dma_async_device_unregister(&priv->dma_dev_common);
> > +
> > +       list_for_each_entry_safe(chan, _chan, &priv-
> >dma_dev_common.channels,
> > +                               device_node) {
> > +               xor_chan =3D container_of(chan, struct talitos_xor_chan=
,
> > +                                       common);
> > +               list_del(&chan->device_node);
> > +               priv->dma_dev_common.chancnt--;
> > +               kfree(xor_chan);
> > +       }
> > +}
> > +
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
> > +       struct talitos_private *priv =3D dev_get_drvdata(dev);
> > +       struct dma_device *dma_dev =3D &priv->dma_dev_common;
> > +       struct talitos_xor_chan *xor_chan;
> > +       int err;
> > +
> > +       xor_chan =3D kzalloc(sizeof(struct talitos_xor_chan), GFP_KERNE=
L);
> > +       if (!xor_chan) {
> > +               dev_err(dev, "unable to allocate xor channel\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       dma_dev->dev =3D dev;
> > +       dma_dev->device_alloc_chan_resources =3D
> talitos_alloc_chan_resources;
> > +       dma_dev->device_free_chan_resources =3D
> talitos_free_chan_resources;
> > +       dma_dev->device_prep_dma_xor =3D talitos_prep_dma_xor;
> > +       dma_dev->max_xor =3D max_xor_srcs;
> > +       dma_dev->device_tx_status =3D talitos_is_tx_complete;
> > +       dma_dev->device_issue_pending =3D talitos_issue_pending;
> > +       INIT_LIST_HEAD(&dma_dev->channels);
> > +       dma_cap_set(DMA_XOR, dma_dev->cap_mask);
> > +
> > +       xor_chan->dev =3D dev;
> > +       xor_chan->common.device =3D dma_dev;
> > +       xor_chan->total_desc =3D 0;
> > +       INIT_LIST_HEAD(&xor_chan->submit_q);
> > +       INIT_LIST_HEAD(&xor_chan->pending_q);
> > +       INIT_LIST_HEAD(&xor_chan->in_progress_q);
> > +       INIT_LIST_HEAD(&xor_chan->free_desc);
> > +       spin_lock_init(&xor_chan->desc_lock);
> > +
> > +       list_add_tail(&xor_chan->common.device_node, &dma_dev-
> >channels);
> > +       dma_dev->chancnt++;
> > +
> > +       err =3D dma_async_device_register(dma_dev);
> > +       if (err) {
> > +               dev_err(dev, "Unable to register XOR with Async_tx\n");
> > +               goto err_out;
> > +       }
> > +
> > +       return err;
> > +
> > +err_out:
> > +       talitos_unregister_async_xor(dev);
> > +       return err;
> > +}
> > +#endif
> > +
> >  /*
> >   * crypto alg
> >   */
> > @@ -2891,6 +3284,26 @@ static int talitos_probe(struct platform_device
> *ofdev)
> >                         dev_info(dev, "hwrng\n");
> >         }
> >
> > +#ifdef CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR
>=20
> Kill these ifdefs in the C file.  Do something like: if
> (xor_enabled()) { } around the code sections that are optional so you
> always get compile coverage.  Where xor_enabled() is a shorter form of
> IS_ENABLED(CONFIG_CRYPTO_DEV_TALITOS_RAIDXOR).
I'm confused how to implement this interface,
First, this feature should be added in Kconfig (default N)
Second, the only judge condition is SEC version, but some time we don't wan=
t involve function XOR even though the SEC (version is not higher than 3.0,=
 SEC 4.0 is CAAM module) support this feature.
Last, there is not any hardware support.
Can you give me an example? Thanks.
