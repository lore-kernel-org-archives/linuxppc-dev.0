Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
	[209.85.211.175]) by ozlabs.org (Postfix) with ESMTP id 7405EB7C05
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 08:24:25 +1100 (EST)
Received: by ywh5 with SMTP id 5so2696229ywh.11
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Dec 2009 13:24:24 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091204211737.26998.58504.stgit@angua>
References: <20091204211737.26998.58504.stgit@angua>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 4 Dec 2009 14:24:03 -0700
Message-ID: <fa686aa40912041324t20c3d32dy3260ed313a205a93@mail.gmail.com>
Subject: Re: [PATCH] Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Asier Llano <a.llano@ziv.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops, sorry about the messed up subject.  that was sloppy.  Real
subject should be:

net/mpc5200: Fix locking on fec_mpc52xx driver

On Fri, Dec 4, 2009 at 2:20 PM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> From: Asier Llano Palacios <asierllano@gmail.com>
>
> net/mpc5200: Fix locking on fec_mpc52xx driver
>
> Fix the locking scheme on the fec_mpc52xx driver. =A0This device can
> receive IRQs from three sources; the FEC itself, the tx DMA, and the
> rx DMA. =A0Mutual exclusion was handled by taking a spin_lock() in the
> critical regions, but because the handlers are run with IRQs enabled,
> spin_lock() is insufficient and the driver can end up interrupting
> a critical region anyway from another IRQ.
>
> Asier Llano discovered that this occurs when an error IRQ is raised
> in the middle of handling rx irqs which resulted in an sk_buff memory
> leak.
>
> In addition, locking is spotty at best in the driver and inspection
> revealed quite a few places with insufficient locking.
>
> This patch is based on Asier's initial work, but reworks a number of
> things so that locks are held for as short a time as possible, so
> that spin_lock_irqsave() is used everywhere, and so the locks are
> dropped when calling into the network stack (because the lock only
> protects the hardware interface; not the network stack).
>
> Boot tested on a lite5200 with an NFS root. =A0Has not been performance
> tested.
>
> Signed-off-by: Asier Llano <a.llano@ziv.es>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> Asier, can you please test this? =A0It took me a while to respond to
> your initial post because I was concerned about some of the latency
> issues, and I was concerned about disabling IRQs for long periods in
> the RX handler. =A0I think it should be good now, but it needs testing.
>
> Cheers,
> g.
>
> =A0drivers/net/fec_mpc52xx.c | =A0121 +++++++++++++++++++++++------------=
----------
> =A01 files changed, 62 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index 66dace6..4889b4d 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -85,11 +85,15 @@ MODULE_PARM_DESC(debug, "debugging messages level");
>
> =A0static void mpc52xx_fec_tx_timeout(struct net_device *dev)
> =A0{
> + =A0 =A0 =A0 struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> + =A0 =A0 =A0 unsigned long flags;
> +
> =A0 =A0 =A0 =A0dev_warn(&dev->dev, "transmit timed out\n");
>
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> =A0 =A0 =A0 =A0mpc52xx_fec_reset(dev);
> -
> =A0 =A0 =A0 =A0dev->stats.tx_errors++;
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>
> =A0 =A0 =A0 =A0netif_wake_queue(dev);
> =A0}
> @@ -135,28 +139,32 @@ static void mpc52xx_fec_free_rx_buffers(struct net_=
device *dev, struct bcom_task
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static void
> +mpc52xx_fec_rx_submit(struct net_device *dev, struct sk_buff *rskb)
> +{
> + =A0 =A0 =A0 struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> + =A0 =A0 =A0 struct bcom_fec_bd *bd;
> +
> + =A0 =A0 =A0 bd =3D (struct bcom_fec_bd *) bcom_prepare_next_buffer(priv=
->rx_dmatsk);
> + =A0 =A0 =A0 bd->status =3D FEC_RX_BUFFER_SIZE;
> + =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(dev->dev.parent, rskb->data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FEC=
_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 bcom_submit_next_buffer(priv->rx_dmatsk, rskb);
> +}
> +
> =A0static int mpc52xx_fec_alloc_rx_buffers(struct net_device *dev, struct=
 bcom_task *rxtsk)
> =A0{
> - =A0 =A0 =A0 while (!bcom_queue_full(rxtsk)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sk_buff *skb;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct bcom_fec_bd *bd;
> + =A0 =A0 =A0 struct sk_buff *skb;
>
> + =A0 =A0 =A0 while (!bcom_queue_full(rxtsk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb =3D dev_alloc_skb(FEC_RX_BUFFER_SIZE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (skb =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!skb)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EAGAIN;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* zero out the initial receive buffers to=
 aid debugging */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(skb->data, 0, FEC_RX_BUFFER_SIZE);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd =3D (struct bcom_fec_bd *)bcom_prepare_n=
ext_buffer(rxtsk);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->status =3D FEC_RX_BUFFER_SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(dev->dev.pare=
nt, skb->data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FEC_RX_BUFF=
ER_SIZE, DMA_FROM_DEVICE);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_submit_next_buffer(rxtsk, skb);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_fec_rx_submit(dev, skb);
> =A0 =A0 =A0 =A0}
> -
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -328,13 +336,12 @@ static int mpc52xx_fec_start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DM=
A_TO_DEVICE);
>
> =A0 =A0 =A0 =A0bcom_submit_next_buffer(priv->tx_dmatsk, skb);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>
> =A0 =A0 =A0 =A0if (bcom_queue_full(priv->tx_dmatsk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0netif_stop_queue(dev);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
> -
> =A0 =A0 =A0 =A0return NETDEV_TX_OK;
> =A0}
>
> @@ -359,9 +366,9 @@ static irqreturn_t mpc52xx_fec_tx_interrupt(int irq, =
void *dev_id)
> =A0{
> =A0 =A0 =A0 =A0struct net_device *dev =3D dev_id;
> =A0 =A0 =A0 =A0struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> + =A0 =A0 =A0 unsigned long flags;
>
> - =A0 =A0 =A0 spin_lock(&priv->lock);
> -
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> =A0 =A0 =A0 =A0while (bcom_buffer_done(priv->tx_dmatsk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sk_buff *skb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct bcom_fec_bd *bd;
> @@ -372,11 +379,10 @@ static irqreturn_t mpc52xx_fec_tx_interrupt(int irq=
, void *dev_id)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_kfree_skb_irq(skb);
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>
> =A0 =A0 =A0 =A0netif_wake_queue(dev);
>
> - =A0 =A0 =A0 spin_unlock(&priv->lock);
> -
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> @@ -384,67 +390,60 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq=
, void *dev_id)
> =A0{
> =A0 =A0 =A0 =A0struct net_device *dev =3D dev_id;
> =A0 =A0 =A0 =A0struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> + =A0 =A0 =A0 struct sk_buff *rskb; /* received sk_buff */
> + =A0 =A0 =A0 struct sk_buff *skb; =A0/* new sk_buff to enqueue in its pl=
ace */
> + =A0 =A0 =A0 struct bcom_fec_bd *bd;
> + =A0 =A0 =A0 u32 status, physaddr;
> + =A0 =A0 =A0 int length;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
>
> =A0 =A0 =A0 =A0while (bcom_buffer_done(priv->rx_dmatsk)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sk_buff *skb;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sk_buff *rskb;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct bcom_fec_bd *bd;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 status;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rskb =3D bcom_retrieve_buffer(priv->rx_dma=
tsk, &status,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct bco=
m_bd **)&bd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(dev->dev.parent, bd->skb_p=
a, rskb->len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_FROM=
_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 (struct bcom_bd **)&bd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 physaddr =3D bd->skb_pa;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Test for errors in received frame */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status & BCOM_FEC_RX_BD_ERRORS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Drop packet and reuse t=
he buffer */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd =3D (struct bcom_fec_bd =
*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_prepar=
e_next_buffer(priv->rx_dmatsk);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->status =3D FEC_RX_BUFFE=
R_SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_sing=
le(dev->dev.parent,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 rskb->data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_submit_next_buffer(pri=
v->rx_dmatsk, rskb);
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_fec_rx_submit(dev, =
rskb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->stats.rx_dropped++;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* skbs are allocated on open, so now we a=
llocate a new one,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * and remove the old (with the packet) */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb =3D dev_alloc_skb(FEC_RX_BUFFER_SIZE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (skb) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Process the received skb=
 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int length =3D status & BCO=
M_FEC_RX_BD_LEN_MASK;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_put(rskb, length - 4); =
=A0 =A0 =A0/* length without CRC32 */
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rskb->dev =3D dev;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rskb->protocol =3D eth_type=
_trans(rskb, dev);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 netif_rx(rskb);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!skb) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Can't get a new one : r=
euse the same & drop pkt */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_notice(&dev->dev, "Memo=
ry squeeze, dropping packet.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_notice(&dev->dev, "Low =
memory - dropped packet.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_fec_rx_submit(dev, =
rskb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->stats.rx_dropped++;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb =3D rskb;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd =3D (struct bcom_fec_bd *)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_prepare_next_buffer(pr=
iv->rx_dmatsk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enqueue the new sk_buff back on the hard=
ware */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_fec_rx_submit(dev, skb);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->status =3D FEC_RX_BUFFER_SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(dev->dev.pare=
nt, skb->data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FEC_RX_BUFF=
ER_SIZE, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Process the received skb - Drop the spin=
 lock while
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* calling into the network stack */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bcom_submit_next_buffer(priv->rx_dmatsk, sk=
b);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(dev->dev.parent, physaddr,=
 rskb->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_FROM=
_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D status & BCOM_FEC_RX_BD_LEN_MASK=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_put(rskb, length - 4); =A0 =A0 =A0/* le=
ngth without CRC32 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rskb->dev =3D dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rskb->protocol =3D eth_type_trans(rskb, dev=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 netif_rx(rskb);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
> +
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> @@ -454,6 +453,7 @@ static irqreturn_t mpc52xx_fec_interrupt(int irq, voi=
d *dev_id)
> =A0 =A0 =A0 =A0struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> =A0 =A0 =A0 =A0struct mpc52xx_fec __iomem *fec =3D priv->fec;
> =A0 =A0 =A0 =A0u32 ievent;
> + =A0 =A0 =A0 unsigned long flags;
>
> =A0 =A0 =A0 =A0ievent =3D in_be32(&fec->ievent);
>
> @@ -471,9 +471,10 @@ static irqreturn_t mpc52xx_fec_interrupt(int irq, vo=
id *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (net_ratelimit() && (ievent & FEC_IEVEN=
T_XFIFO_ERROR))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&dev->dev, "FEC_I=
EVENT_XFIFO_ERROR\n");
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc52xx_fec_reset(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 netif_wake_queue(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0 =A0 =A0 =A0}
>
> @@ -768,6 +769,8 @@ static void mpc52xx_fec_reset(struct net_device *dev)
> =A0 =A0 =A0 =A0bcom_enable(priv->tx_dmatsk);
>
> =A0 =A0 =A0 =A0mpc52xx_fec_start(dev);
> +
> + =A0 =A0 =A0 netif_wake_queue(dev);
> =A0}
>
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
