Return-Path: <pku.leo@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 1C6ACDDDB6
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 21:50:10 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so1028782rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 03:50:09 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
Date: Fri, 27 Mar 2009 18:50:09 +0800
Message-ID: <2a27d3730903270350m52fcb837ge78c0b87cc3887d5@mail.gmail.com>
Subject: Re: [PATCH 1/2] ucc_geth: Move freeing of TX packets to NAPI context.
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

On Thu, Mar 26, 2009 at 8:54 PM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:
> Also set NAPI weight to 64 as this is a common value.
> This will make the system alot more responsive while
> ping flooding the ucc_geth ethernet interaface.
>
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
> =C2=A0drivers/net/ucc_geth.c | =C2=A0 32 ++++++++++++--------------------
> =C2=A0drivers/net/ucc_geth.h | =C2=A0 =C2=A01 -
> =C2=A02 files changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index 097aed8..7fc91aa 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -3214,7 +3214,7 @@ static int ucc_geth_tx(struct net_device *dev, u8 t=
xQ)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->stats.tx_pack=
ets++;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Free the sk buf=
fer associated with this TxBD */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_kfree_skb_irq(uget=
h->
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_kfree_skb(ugeth->
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tx_skbuff[txQ][ugeth->skb_dirt=
ytx[txQ]]);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth->tx_skbuff[t=
xQ][ugeth->skb_dirtytx[txQ]] =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth->skb_dirtytx=
[txQ] =3D
> @@ -3248,9 +3248,16 @@ static int ucc_geth_poll(struct napi_struct *napi,=
 int budget)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < ug_info->numQueuesRx; i++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0howmany +=3D ucc_g=
eth_rx(ugeth, i, budget - howmany);
>
> + =C2=A0 =C2=A0 =C2=A0 /* Tx event processing */
> + =C2=A0 =C2=A0 =C2=A0 spin_lock(&ugeth->lock);
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ug_info->numQueuesTx; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ucc_geth_tx(ugeth->dev=
, i);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock(&ugeth->lock);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (howmany < budget) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netif_rx_complete(=
napi);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setbits32(ugeth->uccf-=
>p_uccm, UCCE_RX_EVENTS);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setbits32(ugeth->uccf-=
>p_uccm, UCCE_RX_EVENTS | UCCE_TX_EVENTS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return howmany;
> @@ -3264,8 +3271,6 @@ static irqreturn_t ucc_geth_irq_handler(int irq, vo=
id *info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ucc_geth_info *ug_info;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0register u32 ucce;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0register u32 uccm;
> - =C2=A0 =C2=A0 =C2=A0 register u32 tx_mask;
> - =C2=A0 =C2=A0 =C2=A0 u8 i;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ugeth_vdbg("%s: IN", __func__);
>
> @@ -3279,27 +3284,14 @@ static irqreturn_t ucc_geth_irq_handler(int irq, =
void *info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0out_be32(uccf->p_ucce, ucce);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* check for receive events that require proce=
ssing */
> - =C2=A0 =C2=A0 =C2=A0 if (ucce & UCCE_RX_EVENTS) {
> + =C2=A0 =C2=A0 =C2=A0 if (ucce & (UCCE_RX_EVENTS | UCCE_TX_EVENTS)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (netif_rx_sched=
ule_prep(&ugeth->napi)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uccm &=3D ~UCCE_RX_EVENTS;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uccm &=3D ~(UCCE_RX_EVENTS | UCCE_TX_EVENTS);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0out_be32(uccf->p_uccm, uccm);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__netif_rx_schedule(&ugeth->napi);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 /* Tx event processing */
> - =C2=A0 =C2=A0 =C2=A0 if (ucce & UCCE_TX_EVENTS) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&ugeth->lock=
);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_mask =3D UCC_GETH_U=
CCE_TXB0;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < ug_i=
nfo->numQueuesTx; i++) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (ucce & tx_mask)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ucc_geth_tx(dev, i);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ucce &=3D ~tx_mask;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 tx_mask <<=3D 1;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&ugeth->lo=
ck);
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Errors and other events */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ucce & UCCE_OTHER) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ucce & UCC_GET=
H_UCCE_BSY)
> @@ -3733,7 +3725,7 @@ static int ucc_geth_probe(struct of_device* ofdev, =
const struct of_device_id *ma
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->netdev_ops =3D &ucc_geth_netdev_ops;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->watchdog_timeo =3D TX_TIMEOUT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&ugeth->timeout_work, ucc_geth_timeo=
ut_work);
> - =C2=A0 =C2=A0 =C2=A0 netif_napi_add(dev, &ugeth->napi, ucc_geth_poll, U=
CC_GETH_DEV_WEIGHT);
> + =C2=A0 =C2=A0 =C2=A0 netif_napi_add(dev, &ugeth->napi, ucc_geth_poll, 6=
4);

It doesn't make sense to have larger napi budget than the size of RX
BD ring.  You can't have more BDs than RX_BD_RING_LEN in backlog for
napi_poll to process.  Increase the RX_BD_RING_LEN if you want to
increase UCC_GETH_DEV_WEIGHT.  However please also provide the
performance comparison for this kind of change.  Thanks

- Leo
