Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 4BCBCDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 20:45:14 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1118418wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 02:45:12 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>
Date: Fri, 27 Mar 2009 17:45:12 +0800
Message-ID: <2a27d3730903270245k6e8633eehfb5cd3fcebd36240@mail.gmail.com>
Subject: Re: [PATCH] ucc_geth: Rework the TX logic.
From: Li Yang <leoli@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2009 at 1:44 AM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:
> The line:
> =C2=A0if ((bd =3D=3D ugeth->txBd[txQ]) && (netif_queue_stopped(dev) =3D=
=3D 0))
> =C2=A0 =C2=A0 =C2=A0 break;
> in ucc_geth_tx() didn not make sense to me. Rework & cleanup
> this logic to something understandable.
> ---
>
> Reworked the patch according to Antons comments.
>
> =C2=A0drivers/net/ucc_geth.c | =C2=A0 66 +++++++++++++++++++++++++++-----=
---------------
> =C2=A01 files changed, 38 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 7fc91aa..465de3a 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -161,6 +161,17 @@ static struct ucc_geth_info ugeth_primary_info =3D {
>
> =C2=A0static struct ucc_geth_info ugeth_info[8];
>
> +
> +static inline u32 __iomem *bd2buf(u8 __iomem *bd)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (u32 __iomem *)(bd+4);
> +}
> +
> +static inline u32 __iomem *bd2status(u8 __iomem *bd)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return (u32 __iomem *)bd;
> +}


When the driver was reviewed for upstream merge, I was told to remove
this kind of thing in favor of direct struct qe_bd access.  So do we
really have a guideline on this?  Or it's just a matter of personal
preference?

> +
> =C2=A0#ifdef DEBUG
> =C2=A0static void mem_disp(u8 *addr, int size)
> =C2=A0{
> @@ -3048,6 +3059,7 @@ static int ucc_geth_start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 __iomem *bd; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* BD pointer */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 bd_status;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 txQ =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int tx_ind;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth_vdbg("%s: IN", __func__);
>
> @@ -3057,21 +3069,19 @@ static int ucc_geth_start_xmit(struct sk_buff *sk=
b, struct net_device *dev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Start from the next BD that should be fille=
d */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bd =3D ugeth->txBd[txQ];
> - =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32((u32 __iomem *)bd);
> + =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32(bd2status(bd));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Save the skb pointer so we can free it late=
r */
> - =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[txQ][ugeth->skb_curtx[txQ]] =3D s=
kb;
> + =C2=A0 =C2=A0 =C2=A0 tx_ind =3D ugeth->skb_curtx[txQ];
> + =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[txQ][tx_ind] =3D skb;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update the current skb pointer (wrapping if=
 this was the last) */
> - =C2=A0 =C2=A0 =C2=A0 ugeth->skb_curtx[txQ] =3D
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ugeth->skb_curtx[txQ] +
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01) & TX_RING_MOD_MASK(ugeth->u=
g_info->bdRingLenTx[txQ]);
> + =C2=A0 =C2=A0 =C2=A0 tx_ind =3D (tx_ind + 1) & TX_RING_MOD_MASK(ugeth->=
ug_info->bdRingLenTx[txQ]);
> + =C2=A0 =C2=A0 =C2=A0 ugeth->skb_curtx[txQ] =3D tx_ind;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set up the buffer descriptor */
> - =C2=A0 =C2=A0 =C2=A0 out_be32(&((struct qe_bd __iomem *)bd)->buf,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
ma_map_single(&ugeth->dev->dev, skb->data,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 skb->len, DMA_TO_DEVICE));
> -
> - =C2=A0 =C2=A0 =C2=A0 /* printk(KERN_DEBUG"skb->data is 0x%x\n",skb->dat=
a); */
> + =C2=A0 =C2=A0 =C2=A0 out_be32(bd2buf(bd),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_map_single(&=
ugeth->dev->dev, skb->data,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skb->len, DMA_TO_DEVICE));
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bd_status =3D (bd_status & T_W) | T_R | T_I | =
T_L | skb->len;
>
> @@ -3088,9 +3098,9 @@ static int ucc_geth_start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the next BD still needs to be cleaned up=
, then the bds
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are full. =C2=A0We need to tell the ke=
rnel to stop sending us stuff. */
> - =C2=A0 =C2=A0 =C2=A0 if (bd =3D=3D ugeth->confBd[txQ]) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!netif_queue_stopp=
ed(dev))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 netif_stop_queue(dev);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!in_be32(bd2buf(bd))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netif_stop_queue(dev);

Why does this make more sense?  The BD with a NULL buffer means the
ring is full?  It's not the normal case.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth->txBd[txQ] =3D bd;
> @@ -3198,41 +3208,41 @@ static int ucc_geth_tx(struct net_device *dev, u8=
 txQ)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ucc_geth_private *ugeth =3D netdev_priv=
(dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 __iomem *bd; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 BD pointer */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 bd_status;
> + =C2=A0 =C2=A0 =C2=A0 int tx_ind, num_freed;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bd =3D ugeth->confBd[txQ];
> - =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32((u32 __iomem *)bd);
> -
> + =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32(bd2status(bd));
> + =C2=A0 =C2=A0 =C2=A0 tx_ind =3D ugeth->skb_dirtytx[txQ];
> + =C2=A0 =C2=A0 =C2=A0 num_freed =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Normal processing. */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((bd_status & T_R) =3D=3D 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* BD contains alr=
eady transmitted buffer. =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Handle the tran=
smitted buffer and release */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* the BD to be us=
ed with the current frame =C2=A0*/
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((bd =3D=3D ugeth->=
txBd[txQ]) && (netif_queue_stopped(dev) =3D=3D 0))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bd =3D=3D ugeth->t=
xBd[txQ])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break; /* Queue is empty */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->stats.tx_pack=
ets++;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Free the sk buf=
fer associated with this TxBD */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_kfree_skb(ugeth->
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_skbuff[txQ][ugeth->skb_dirtytx=
[txQ]]);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[txQ][=
ugeth->skb_dirtytx[txQ]] =3D NULL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ugeth->skb_dirtytx[txQ=
] =3D
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ugeth->=
skb_dirtytx[txQ] +
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01)=
 & TX_RING_MOD_MASK(ugeth->ug_info->bdRingLenTx[txQ]);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We freed a buffer, =
so now we can restart transmission */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (netif_queue_stoppe=
d(dev))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 netif_wake_queue(dev);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_kfree_skb(ugeth->t=
x_skbuff[txQ][tx_ind]);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[txQ][=
tx_ind] =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(bd2buf(bd), 0=
); /* Mark it free */

Now I see why you depend on the buffer to judge if the BD ring is
full.  If you want to do this, make sure it's well documented in code,
or others will be confused.  And as Anton already commented, in/out
access is slow.  I think the original way can be fixed if you think
it's broken, and will have better performance.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_freed++;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_ind =3D (tx_ind + 1=
) & TX_RING_MOD_MASK(ugeth->ug_info->bdRingLenTx[txQ]);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Advance the con=
firmation BD pointer */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(bd_status & =
T_W))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bd +=3D sizeof(struct qe_bd);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bd =3D ugeth->p_tx_bd_ring[txQ];
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32(=
(u32 __iomem *)bd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32(=
bd2status(bd));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth->confBd[txQ] =3D bd;
> + =C2=A0 =C2=A0 =C2=A0 ugeth->skb_dirtytx[txQ] =3D tx_ind;
> + =C2=A0 =C2=A0 =C2=A0 if (num_freed)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netif_wake_queue(dev);=
 /* We freed some buffers, so restart transmission */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
