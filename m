Return-Path: <pku.leo@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 2DBAFDDDA1
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 21:39:08 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1136623wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 03:39:07 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
References: <1238089445-28396-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<2a27d3730903270245k6e8633eehfb5cd3fcebd36240@mail.gmail.com>
	<OFDCE90357.0EDC5DC1-ONC1257586.003759A3-C1257586.00390AD3@transmode.se>
Date: Fri, 27 Mar 2009 18:39:07 +0800
Message-ID: <2a27d3730903270339l44ccb55fo9079402104afc458@mail.gmail.com>
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

On Fri, Mar 27, 2009 at 6:23 PM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:
> pku.leo@gmail.com wrote on 27/03/2009 10:45:12:
>> On Fri, Mar 27, 2009 at 1:44 AM, Joakim Tjernlund
>> <Joakim.Tjernlund@transmode.se> wrote:
>> > The line:
>> > =C2=A0if ((bd =3D=3D ugeth->txBd[txQ]) && (netif_queue_stopped(dev) =
=3D=3D 0))
>> > =C2=A0 =C2=A0 =C2=A0 break;
>> > in ucc_geth_tx() didn not make sense to me. Rework & cleanup
>> > this logic to something understandable.
>> > ---
>> >
>> > Reworked the patch according to Antons comments.
>> >
>> > =C2=A0drivers/net/ucc_geth.c | =C2=A0 66
> +++++++++++++++++++++++++++--------------------
>> > =C2=A01 files changed, 38 insertions(+), 28 deletions(-)
>> >
>> > diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
>> > index 7fc91aa..465de3a 100644
>> > --- a/drivers/net/ucc_geth.c
>> > +++ b/drivers/net/ucc_geth.c
>> > @@ -161,6 +161,17 @@ static struct ucc_geth_info ugeth_primary_info =
=3D
> {
>> >
>> > =C2=A0static struct ucc_geth_info ugeth_info[8];
>> >
>> > +
>> > +static inline u32 __iomem *bd2buf(u8 __iomem *bd)
>> > +{
>> > + =C2=A0 =C2=A0 =C2=A0 return (u32 __iomem *)(bd+4);
>> > +}
>> > +
>> > +static inline u32 __iomem *bd2status(u8 __iomem *bd)
>> > +{
>> > + =C2=A0 =C2=A0 =C2=A0 return (u32 __iomem *)bd;
>> > +}
>>
>>
>> When the driver was reviewed for upstream merge, I was told to remove
>> this kind of thing in favor of direct struct qe_bd access. =C2=A0So do w=
e
>> really have a guideline on this? =C2=A0Or it's just a matter of personal
>> preference?
>
> This is a bit better than the current type casts. Moving over to qe_bd
> accesses is a bigger cleanup that will have to be a seperate patch.
> I am not sure it is an all win as you probably loose the ability
> to read both status and len in one access.
>
>>
>> > +
>> > =C2=A0#ifdef DEBUG
>> > =C2=A0static void mem_disp(u8 *addr, int size)
>> > =C2=A0{
>> > @@ -3048,6 +3059,7 @@ static int ucc_geth_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 __iomem *bd; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* BD pointer */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 bd_status;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 txQ =3D 0;
>> > + =C2=A0 =C2=A0 =C2=A0 int tx_ind;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth_vdbg("%s: IN", __func__);
>> >
>> > @@ -3057,21 +3069,19 @@ static int ucc_geth_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Start from the next BD that should be fi=
lled */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0bd =3D ugeth->txBd[txQ];
>> > - =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32((u32 __iomem *)bd);
>> > + =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32(bd2status(bd));
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Save the skb pointer so we can free it l=
ater */
>> > - =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[txQ][ugeth->skb_curtx[txQ]] =
=3D skb;
>> > + =C2=A0 =C2=A0 =C2=A0 tx_ind =3D ugeth->skb_curtx[txQ];
>> > + =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[txQ][tx_ind] =3D skb;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update the current skb pointer (wrapping=
 if this was the
> last) */
>> > - =C2=A0 =C2=A0 =C2=A0 ugeth->skb_curtx[txQ] =3D
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ugeth->skb_curtx[txQ] +
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01) & TX_RING_MOD_MASK(ugeth=
->ug_info->bdRingLenTx[txQ]);
>> > + =C2=A0 =C2=A0 =C2=A0 tx_ind =3D (tx_ind + 1) &
> TX_RING_MOD_MASK(ugeth->ug_info->bdRingLenTx[txQ]);
>> > + =C2=A0 =C2=A0 =C2=A0 ugeth->skb_curtx[txQ] =3D tx_ind;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* set up the buffer descriptor */
>> > - =C2=A0 =C2=A0 =C2=A0 out_be32(&((struct qe_bd __iomem *)bd)->buf,
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dma_map_single(&ugeth->dev->dev, skb->data,
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skb->len, DMA_TO_DEVICE));
>> > -
>> > - =C2=A0 =C2=A0 =C2=A0 /* printk(KERN_DEBUG"skb->data is 0x%x\n",skb->=
data); */
>> > + =C2=A0 =C2=A0 =C2=A0 out_be32(bd2buf(bd),
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_map_singl=
e(&ugeth->dev->dev, skb->data,
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skb->len, DMA_TO_DEVICE));
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0bd_status =3D (bd_status & T_W) | T_R | T_I=
 | T_L | skb->len;
>> >
>> > @@ -3088,9 +3098,9 @@ static int ucc_geth_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If the next BD still needs to be cleaned=
 up, then the bds
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 are full. =C2=A0We need to tell the=
 kernel to stop sending us
> stuff. */
>> > - =C2=A0 =C2=A0 =C2=A0 if (bd =3D=3D ugeth->confBd[txQ]) {
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!netif_queue_st=
opped(dev))
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 netif_stop_queue(dev);
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 if (!in_be32(bd2buf(bd))) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netif_stop_queue(de=
v);
>>
>> Why does this make more sense? =C2=A0The BD with a NULL buffer means the
>> ring is full? =C2=A0It's not the normal case.
>>
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth->txBd[txQ] =3D bd;
>> > @@ -3198,41 +3208,41 @@ static int ucc_geth_tx(struct net_device *dev,
> u8 txQ)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ucc_geth_private *ugeth =3D netdev_p=
riv(dev);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 __iomem *bd; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* BD pointer */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 bd_status;
>> > + =C2=A0 =C2=A0 =C2=A0 int tx_ind, num_freed;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0bd =3D ugeth->confBd[txQ];
>> > - =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32((u32 __iomem *)bd);
>> > -
>> > + =C2=A0 =C2=A0 =C2=A0 bd_status =3D in_be32(bd2status(bd));
>> > + =C2=A0 =C2=A0 =C2=A0 tx_ind =3D ugeth->skb_dirtytx[txQ];
>> > + =C2=A0 =C2=A0 =C2=A0 num_freed =3D 0;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Normal processing. */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((bd_status & T_R) =3D=3D 0) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* BD contains =
already transmitted buffer. =C2=A0 */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Handle the t=
ransmitted buffer and release */
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* the BD to be=
 used with the current frame =C2=A0*/
>> >
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((bd =3D=3D uget=
h->txBd[txQ]) &&
> (netif_queue_stopped(dev) =3D=3D 0))
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bd =3D=3D ugeth=
->txBd[txQ])
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break; /* Queue is empty */
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->stats.tx_p=
ackets++;
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Free the sk =
buffer associated with this TxBD */
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_kfree_skb(ugeth=
->
>> > -
> tx_skbuff[txQ][ugeth->skb_dirtytx[txQ]]);
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[tx=
Q][ugeth->skb_dirtytx[txQ]] =3D NULL;
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ugeth->skb_dirtytx[=
txQ] =3D
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uget=
h->skb_dirtytx[txQ] +
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A01) &
> TX_RING_MOD_MASK(ugeth->ug_info->bdRingLenTx[txQ]);
>> > -
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We freed a buffe=
r, so now we can restart
> transmission */
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (netif_queue_sto=
pped(dev))
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 netif_wake_queue(dev);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_kfree_skb(ugeth=
->tx_skbuff[txQ][tx_ind]);
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ugeth->tx_skbuff[tx=
Q][tx_ind] =3D NULL;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(bd2buf(bd)=
, 0); /* Mark it free */
>>
>> Now I see why you depend on the buffer to judge if the BD ring is
>> full. =C2=A0If you want to do this, make sure it's well documented in co=
de,
>> or others will be confused. =C2=A0And as Anton already commented, in/out
>> access is slow. =C2=A0I think the original way can be fixed if you think
>> it's broken, and will have better performance.
>
> The code could use a better comment, but I really think this method
> is superior and more robust. The problem is that in/out functions is
> much slower than it has to be for QE IO memory.
>
> The original way is broken and I tired to fix it but it always broke
> as soon one applied some load.

The only difference I see between your method and the original code is
that you update the cleanup progress on every BD.  The original code
updates progress only after all sent BDs are processed.  You can try
move ugeth->confBd[txQ] =3D bd; into the loop then it will be the same
as your proposed code.

- Leo
