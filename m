Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 0AEDADDDF0
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 06:10:15 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1600014ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 12:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0947433F-BDDA-48D8-A59C-BCF321EE465C@kernel.crashing.org>
References: <20090331022428.26151.55232.stgit@localhost.localdomain>
	<0947433F-BDDA-48D8-A59C-BCF321EE465C@kernel.crashing.org>
Date: Tue, 31 Mar 2009 13:10:13 -0600
Message-ID: <fa686aa40903311210k10ea4966g24ec6541af90b7cb@mail.gmail.com>
Subject: Re: [PATCH] net/fec_mpc52xx: fix BUG on missing dma_ops
From: Grant Likely <grant.likely@secretlab.ca>
To: Becky Bruce <beckyb@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, galak@kernel.crashing.net,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Becky.

g.

2009/3/31 Becky Bruce <beckyb@kernel.crashing.org>:
>
> On Mar 30, 2009, at 9:25 PM, Grant Likely wrote:
>
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> The driver triggers a BUG_ON() when allocating DMA buffers if the
>> arch/powerpc dma_ops from the of_platform device are not copied
>> into net_device structure.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> Becky, does this look better to you?
>
> Reviewed-by: Becky Bruce <beckyb@kernel.crashing.org>
>
> I think this is OK now, and Kumar agrees....
>
> Thanks!
> B
>
>>
>>
>> g.
>>
>> drivers/net/fec_mpc52xx.c | =A0 19 ++++++++++++-------
>> 1 files changed, 12 insertions(+), 7 deletions(-)
>>
>>
>> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
>> index 049b0a7..f99463f 100644
>> --- a/drivers/net/fec_mpc52xx.c
>> +++ b/drivers/net/fec_mpc52xx.c
>> @@ -129,7 +129,8 @@ static void mpc52xx_fec_free_rx_buffers(struct
>> net_device *dev, struct bcom_task
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sk_buff *skb;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb =3D bcom_retrieve_buffer(s, NULL, (st=
ruct bcom_bd
>> **)&bd);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&dev->dev, bd->skb_pa, sk=
b->len,
>> DMA_FROM_DEVICE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(dev->dev.parent, bd->skb_=
pa, skb->len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_FRO=
M_DEVICE);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree_skb(skb);
>> =A0 =A0 =A0 =A0}
>> }
>> @@ -150,7 +151,7 @@ static int mpc52xx_fec_alloc_rx_buffers(struct
>> net_device *dev, struct bcom_task
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd =3D (struct bcom_fec_bd *)bcom_prepare=
_next_buffer(rxtsk);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D FEC_RX_BUFFER_SIZE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&dev->dev, s=
kb->data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(dev->dev.par=
ent, skb->data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEC_RX_BU=
FFER_SIZE, DMA_FROM_DEVICE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(rxtsk, skb);
>> @@ -388,7 +389,8 @@ static int mpc52xx_fec_hard_start_xmit(struct sk_buf=
f
>> *skb, struct net_device *d
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_prepare_next_buffer(priv->tx_dmatsk)=
;
>>
>> =A0 =A0 =A0 =A0bd->status =3D skb->len | BCOM_FEC_TX_BD_TFD | BCOM_FEC_T=
X_BD_TC;
>> - =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&dev->dev, skb->data, skb->l=
en,
>> DMA_TO_DEVICE);
>> + =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(dev->dev.parent, skb->data, =
skb->len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DM=
A_TO_DEVICE);
>>
>> =A0 =A0 =A0 =A0bcom_submit_next_buffer(priv->tx_dmatsk, skb);
>>
>> @@ -430,7 +432,8 @@ static irqreturn_t mpc52xx_fec_tx_interrupt(int irq,
>> void *dev_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct bcom_fec_bd *bd;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb =3D bcom_retrieve_buffer(priv->tx_dma=
tsk, NULL,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(struct b=
com_bd **)&bd);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&dev->dev, bd->skb_pa, sk=
b->len,
>> DMA_TO_DEVICE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(dev->dev.parent, bd->skb_=
pa, skb->len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_TO_=
DEVICE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_kfree_skb_irq(skb);
>> =A0 =A0 =A0 =A0}
>> @@ -455,7 +458,8 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq,
>> void *dev_id)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rskb =3D bcom_retrieve_buffer(priv->rx_dm=
atsk, &status,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(struct b=
com_bd **)&bd);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(&dev->dev, bd->skb_pa, rs=
kb->len,
>> DMA_FROM_DEVICE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_single(dev->dev.parent, bd->skb_=
pa, rskb->len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_FRO=
M_DEVICE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Test for errors in received frame */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status & BCOM_FEC_RX_BD_ERRORS) {
>> @@ -464,7 +468,8 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq,
>> void *dev_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_prep=
are_next_buffer(priv->rx_dmatsk);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D FEC_RX_BUF=
FER_SIZE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_sin=
gle(&dev->dev, rskb->data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_sin=
gle(dev->dev.parent,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 rskb->data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0FEC_RX_BUFFER_SIZE,
>> DMA_FROM_DEVICE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(p=
riv->rx_dmatsk, rskb);
>> @@ -499,7 +504,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int irq,
>> void *dev_id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_prepare_next_buffer(=
priv->rx_dmatsk);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bd->status =3D FEC_RX_BUFFER_SIZE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(&dev->dev, s=
kb->data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd->skb_pa =3D dma_map_single(dev->dev.par=
ent, skb->data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FEC_RX_BU=
FFER_SIZE, DMA_FROM_DEVICE);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bcom_submit_next_buffer(priv->rx_dmatsk, =
skb);
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
