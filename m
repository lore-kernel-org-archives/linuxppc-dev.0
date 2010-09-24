Return-Path: <dan.j.williams@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 5872CB7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 06:41:00 +1000 (EST)
Received: by wwa36 with SMTP id 36so2893369wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 13:40:57 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1285357571-23377-2-git-send-email-iws@ovro.caltech.edu>
References: <1285357571-23377-1-git-send-email-iws@ovro.caltech.edu>
	<1285357571-23377-2-git-send-email-iws@ovro.caltech.edu>
Date: Fri, 24 Sep 2010 13:40:56 -0700
Message-ID: <AANLkTimfZa+N51Tww_pWFqtqMmcYYkH_V0V_P1Qizt5b@mail.gmail.com>
Subject: Re: [PATCH RFCv1 1/2] dmaengine: add support for scatterlist to
	scatterlist transfers
From: Dan Williams <dan.j.williams@intel.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 12:46 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrot=
e:
> This adds support for scatterlist to scatterlist DMA transfers. As
> requested by Dan, this is hidden behind an ifdef so that it can be
> selected by the drivers that need it.
>
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> =A0drivers/dma/Kconfig =A0 =A0 =A0 | =A0 =A04 ++
> =A0drivers/dma/dmaengine.c =A0 | =A0119 +++++++++++++++++++++++++++++++++=
++++++++++++
> =A0include/linux/dmaengine.h | =A0 10 ++++
> =A03 files changed, 133 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 9520cf0..f688669 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -89,10 +89,14 @@ config AT_HDMAC
> =A0 =A0 =A0 =A0 =A0Support the Atmel AHB DMA controller. =A0This can be i=
ntegrated in
> =A0 =A0 =A0 =A0 =A0chips such as the Atmel AT91SAM9RL.
>
> +config DMAENGINE_SG_TO_SG
> + =A0 =A0 =A0 bool
> +
> =A0config FSL_DMA
> =A0 =A0 =A0 =A0tristate "Freescale Elo and Elo Plus DMA support"
> =A0 =A0 =A0 =A0depends on FSL_SOC
> =A0 =A0 =A0 =A0select DMA_ENGINE
> + =A0 =A0 =A0 select DMAENGINE_SG_TO_SG
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0Enable support for the Freescale Elo and Elo Plus DMA =
controllers.
> =A0 =A0 =A0 =A0 =A0The Elo is the DMA controller on some 82xx and 83xx pa=
rts, and the
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 9d31d5e..57ec1e5 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -972,10 +972,129 @@ dma_async_memcpy_pg_to_pg(struct dma_chan *chan, s=
truct page *dest_pg,
> =A0}
> =A0EXPORT_SYMBOL(dma_async_memcpy_pg_to_pg);
>
> +#ifdef CONFIG_DMAENGINE_SG_TO_SG
> +dma_cookie_t
> +dma_async_memcpy_sg_to_sg(struct dma_chan *chan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct scatterlist *dst=
_sg, unsigned int dst_nents,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct scatterlist *src=
_sg, unsigned int src_nents,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_async_tx_callback c=
b, void *cb_param)
> +{
> + =A0 =A0 =A0 struct dma_device *dev =3D chan->device;
> + =A0 =A0 =A0 struct dma_async_tx_descriptor *tx;
> + =A0 =A0 =A0 dma_cookie_t cookie =3D -ENOMEM;
> + =A0 =A0 =A0 size_t dst_avail, src_avail;
> + =A0 =A0 =A0 struct list_head tx_list;
> + =A0 =A0 =A0 size_t transferred =3D 0;
> + =A0 =A0 =A0 dma_addr_t dst, src;
> + =A0 =A0 =A0 size_t len;
> +
> + =A0 =A0 =A0 if (dst_nents =3D=3D 0 || src_nents =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (dst_sg =3D=3D NULL || src_sg =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 /* get prepared for the loop */
> + =A0 =A0 =A0 dst_avail =3D sg_dma_len(dst_sg);
> + =A0 =A0 =A0 src_avail =3D sg_dma_len(src_sg);
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&tx_list);
> +
> + =A0 =A0 =A0 /* run until we are out of descriptors */
> + =A0 =A0 =A0 while (true) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* create the largest transaction possible =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D min_t(size_t, src_avail, dst_avail)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fetch;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst =3D sg_dma_address(dst_sg) + sg_dma_len=
(dst_sg) - dst_avail;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src =3D sg_dma_address(src_sg) + sg_dma_len=
(src_sg) - src_avail;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* setup the transaction */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D dev->device_prep_dma_memcpy(chan, ds=
t, src, len, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tx) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev->dev, "failed t=
o alloc desc for memcpy\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;

I don't think any dma channels gracefully handle descriptors that were
prepped but not submitted.  You would probably need to submit the
backlog, poll for completion, and then return the error.
Alternatively, the expectation is that descriptor allocations are
transient, i.e. once previously submitted transactions are completed
the descriptors will return to the available pool.  So you could do
what async_tx routines do and just poll for a descriptor.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keep track of the tx for later */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&tx->entry, &tx_list);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* update metadata */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 transferred +=3D len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst_avail -=3D len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_avail -=3D len;
> +
> +fetch:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fetch the next dst scatterlist entry */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dst_avail =3D=3D 0) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no more entries: we're d=
one */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dst_nents =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fetch the next entry: if=
 there are no more: done */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst_sg =3D sg_next(dst_sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dst_sg =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst_nents--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dst_avail =3D sg_dma_len(ds=
t_sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fetch the next src scatterlist entry */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (src_avail =3D=3D 0) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* no more entries: we're d=
one */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (src_nents =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fetch the next entry: if=
 there are no more: done */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_sg =3D sg_next(src_sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (src_sg =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_nents--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 src_avail =3D sg_dma_len(sr=
c_sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* loop through the list of descriptors and submit them */
> + =A0 =A0 =A0 list_for_each_entry(tx, &tx_list, entry) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this is the last descriptor: add the cal=
lback */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_is_last(&tx->entry, &tx_list)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx->callback =3D cb;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx->callback_param =3D cb_p=
aram;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* submit the transaction */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cookie =3D tx->tx_submit(tx);

Some dma drivers cannot tolerate prep being reordered with respect to
submit (ioatdma enforces this ordering by locking in prep and
unlocking in submit).  In general those channels can be identified by
ones that select CONFIG_ASYNC_TX_DISABLE_CHANNEL_SWITCH.  However this
opt-out arrangement is awkward so I'll put together a patch to make it
opt-in (CONFIG_ASYNC_TX_CHANNEL_SWITCH).

The end implication for this patch is that CONFIG_DMAENGINE_SG_TO_SG
can only be supported by those channels that are also prepared to
handle channel switching i.e. can tolerate intervening calls to prep()
before the eventual submit().

[snip]

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index c61d4ca..5507f4c 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -24,6 +24,7 @@
> =A0#include <linux/device.h>
> =A0#include <linux/uio.h>
> =A0#include <linux/dma-mapping.h>
> +#include <linux/list.h>
>
> =A0/**
> =A0* typedef dma_cookie_t - an opaque DMA cookie
> @@ -316,6 +317,9 @@ struct dma_async_tx_descriptor {
> =A0 =A0 =A0 =A0dma_cookie_t (*tx_submit)(struct dma_async_tx_descriptor *=
tx);
> =A0 =A0 =A0 =A0dma_async_tx_callback callback;
> =A0 =A0 =A0 =A0void *callback_param;
> +#ifdef CONFIG_DMAENGINE_SG_TO_SG
> + =A0 =A0 =A0 struct list_head entry;
> +#endif
> =A0#ifndef CONFIG_ASYNC_TX_DISABLE_CHANNEL_SWITCH
> =A0 =A0 =A0 =A0struct dma_async_tx_descriptor *next;
> =A0 =A0 =A0 =A0struct dma_async_tx_descriptor *parent;

Per the above comment if we are already depending on channel switch
being enabled for sg-to-sg operation, then you can just use the 'next'
pointer to have a singly linked list of descriptors.  Rather than
increase the size of the base descriptor.

--
Dan
