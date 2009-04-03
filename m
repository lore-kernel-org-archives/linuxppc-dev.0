Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id C7351DDD1C
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 01:18:46 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so678072ywe.39
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Apr 2009 07:18:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <12387682193290-git-send-email-gjb@semihalf.com>
References: <12387682193290-git-send-email-gjb@semihalf.com>
Date: Fri, 3 Apr 2009 08:18:30 -0600
Message-ID: <fa686aa40904030718g40d0c021m29d6000d42fc52d7@mail.gmail.com>
Subject: Re: [PATCH] fec fix: Use OF 'ethernet' device as a provider of dma
	ops.
From: Grant Likely <grant.likely@secretlab.ca>
To: Grzegorz Bernacki <gjb@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is already fixed in the netdev tree

g.

On Fri, Apr 3, 2009 at 8:16 AM, Grzegorz Bernacki <gjb@semihalf.com> wrote:
> Commit 4ae0ff6 "powerpc: expect all devices calling dma
> ops to have archdata set" assumes that all devices use
> correct dma ops. However FEC uses dma ops from 'eth'
> device which doesn't have proper archdata. This patch
> makes FEC use dma operation from OF 'ethernet' device,
> similarly to what other drivers (like gianfar) do.
>
> Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
> ---
> This is fix for not working FEC. Mounting root
> filesystem via NFS ends up with:
>
> Kernel BUG at c021b788 [verbose debug info unavailable]
> Oops: Exception in kernel mode, sig: 5 [#1]
> mpc5200-simple-platform
> Modules linked in:
> NIP: c021b788 LR: c021b758 CTR: 00000000
> REGS: c3825d40 TRAP: 0700 =A0 Not tainted =A0(2.6.29-07103-gd0b70e8)
> MSR: 00029032 <EE,ME,CE,IR,DR> =A0CR: 42008048 =A0XER: 20000000
> TASK =3D c3820000[1] 'swapper' THREAD: c3824000
> [...]
>
> =A0drivers/net/fec_mpc52xx.c | =A0 31 +++++++++++++++++++++----------
> =A01 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index cd8e98b..960b239 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -58,6 +58,8 @@ struct mpc52xx_fec_priv {
> =A0 =A0 =A0 =A0spinlock_t lock;
> =A0 =A0 =A0 =A0int msg_enable;
>
> + =A0 =A0 =A0 struct of_device *ofdev;
> +
> =A0 =A0 =A0 =A0/* MDIO link details */
> =A0 =A0 =A0 =A0int phy_addr;
> =A0 =A0 =A0 =A0unsigned int phy_speed;
> @@ -124,18 +126,23 @@ static int mpc52xx_fec_set_mac_address(struct net_d=
evice *dev, void *addr)
>
> =A0static void mpc52xx_fec_free_rx_buffers(struct net_device *dev, struct=
 bcom_task *s)
> =A0{
> + =A0 =A0 =A0 struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> +
> =A0 =A0 =A0 =A0while (!bcom_queue_empty(s)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct bcom_fec_bd *bd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sk_buff *skb;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb =3D bcom_retrieve_buffer(s, NULL, (str=
uct bcom_bd **)&bd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&dev->dev, bd->skb_pa, skb=
->len, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&priv->ofdev->dev, bd->skb=
_pa, skb->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_FROM_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree_skb(skb);
> =A0 =A0 =A0 =A0}
> =A0}
>
> =A0static int mpc52xx_fec_alloc_rx_buffers(struct net_device *dev, struct=
 bcom_task *rxtsk)
> =A0{
> + =A0 =A0 =A0 struct mpc52xx_fec_priv *priv =3D netdev_priv(dev);
> +
> =A0 =A0 =A0 =A0while (!bcom_queue_full(rxtsk)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sk_buff *skb;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct bcom_fec_bd *bd;
> @@ -150,8 +157,8 @@ static int mpc52xx_fec_alloc_rx_buffers(struct net_de=
vice *dev, struct bcom_task
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd =3D (struct bcom_fec_bd *)bcom_prepare_=
next_buffer(rxtsk);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D FEC_RX_BUFFER_SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&dev->dev, sk=
b->data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FEC_RX_BUFF=
ER_SIZE, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&priv->ofdev-=
>dev, skb->data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(rxtsk, skb);
> =A0 =A0 =A0 =A0}
> @@ -388,7 +395,8 @@ static int mpc52xx_fec_hard_start_xmit(struct sk_buff=
 *skb, struct net_device *d
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_prepare_next_buffer(priv->tx_dmatsk);
>
> =A0 =A0 =A0 =A0bd->status =3D skb->len | BCOM_FEC_TX_BD_TFD | BCOM_FEC_TX=
_BD_TC;
> - =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&dev->dev, skb->data, skb->le=
n, DMA_TO_DEVICE);
> + =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&priv->ofdev->dev, skb->data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 skb->len, DMA_TO_DEVICE);
>
> =A0 =A0 =A0 =A0bcom_submit_next_buffer(priv->tx_dmatsk, skb);
>
> @@ -430,7 +438,8 @@ static irqreturn_t mpc52xx_fec_tx_interrupt(int irq, =
void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct bcom_fec_bd *bd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb =3D bcom_retrieve_buffer(priv->tx_dmat=
sk, NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(struct bc=
om_bd **)&bd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&dev->dev, bd->skb_pa, skb=
->len, DMA_TO_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&priv->ofdev->dev, bd->skb=
_pa, skb->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_TO_DEVICE);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_kfree_skb_irq(skb);
> =A0 =A0 =A0 =A0}
> @@ -455,7 +464,8 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, =
void *dev_id)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rskb =3D bcom_retrieve_buffer(priv->rx_dma=
tsk, &status,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(struct bc=
om_bd **)&bd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&dev->dev, bd->skb_pa, rsk=
b->len, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&priv->ofdev->dev, bd->skb=
_pa, rskb->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DMA_FROM_DEVICE);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Test for errors in received frame */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status & BCOM_FEC_RX_BD_ERRORS) {
> @@ -464,8 +474,9 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, =
void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_prepa=
re_next_buffer(priv->rx_dmatsk);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D FEC_RX_BUFF=
ER_SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_sing=
le(&dev->dev, rskb->data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_sing=
le(&priv->ofdev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 rskb->data, FEC_RX_BUFFER_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_FROM_DEVICE);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(pr=
iv->rx_dmatsk, rskb);
>
> @@ -499,7 +510,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq, =
void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_prepare_next_buffer(p=
riv->rx_dmatsk);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D FEC_RX_BUFFER_SIZE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&dev->dev, sk=
b->data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&priv->ofdev-=
>dev, skb->data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEC_RX_BUF=
FER_SIZE, DMA_FROM_DEVICE);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(priv->rx_dmatsk, s=
kb);
> @@ -910,7 +921,7 @@ mpc52xx_fec_probe(struct of_device *op, const struct =
of_device_id *match)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> =A0 =A0 =A0 =A0priv =3D netdev_priv(ndev);
> -
> + =A0 =A0 =A0 priv->ofdev =3D op;
> =A0 =A0 =A0 =A0/* Reserve FEC control zone */
> =A0 =A0 =A0 =A0rv =3D of_address_to_resource(op->node, 0, &mem);
> =A0 =A0 =A0 =A0if (rv) {
> --
> 1.5.2.2
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
