Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD910B7B99
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 04:23:12 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nA5HN9uD003124
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 10:23:10 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nA5HQvc2027674
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:26:59 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH RFC] gianfar: Do not call skb recycling with disabled IRQs
Date: Thu, 5 Nov 2009 22:53:08 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81B950713@zin33exm22.fsl.freescale.net>
In-Reply-To: <20091105165738.GA31923@oksana.dev.rtsoft.ru>
References: <20091104225711.GA30844@oksana.dev.rtsoft.ru>
	<E1N62ti-0003iS-K2@jdl.com>
	<20091105142028.GB17171@oksana.dev.rtsoft.ru>
	<E1N63WM-0003xK-PN@jdl.com> <E1N64UY-00049g-Hb@jdl.com>
	<20091105165738.GA31923@oksana.dev.rtsoft.ru>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: <avorontsov@ru.mvista.com>, "Jon Loeliger" <jdl@jdl.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Fleming Andy-AFLEMING <afleming@freescale.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
	David Miller <davem@davemloft.net>,
	Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20


[.....]
> drivers/net/gianfar.c |   19 +++----------------
> 1 files changed, 3 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c=20
>index 197b358..a0ae604 100644
>--- a/drivers/net/gianfar.c
>+++ b/drivers/net/gianfar.c
>@@ -1899,10 +1899,8 @@ static int gfar_start_xmit(struct=20
>sk_buff *skb, struct net_device *dev)
> 	u32 lstatus;
> 	int i, rq =3D 0;
> 	u32 bufaddr;
>-	unsigned long flags;
> 	unsigned int nr_frags, length;
>=20
>-
> 	rq =3D skb->queue_mapping;
> 	tx_queue =3D priv->tx_queue[rq];
> 	txq =3D netdev_get_tx_queue(dev, rq);
>@@ -1928,14 +1926,11 @@ static int gfar_start_xmit(struct=20
>sk_buff *skb, struct net_device *dev)
> 	/* total number of fragments in the SKB */
> 	nr_frags =3D skb_shinfo(skb)->nr_frags;
>=20
>-	spin_lock_irqsave(&tx_queue->txlock, flags);
>-
> 	/* check if there is space to queue this packet */
> 	if ((nr_frags+1) > tx_queue->num_txbdfree) {
> 		/* no space, stop the queue */
> 		netif_tx_stop_queue(txq);
> 		dev->stats.tx_fifo_errors++;
>-		spin_unlock_irqrestore(&tx_queue->txlock, flags);
> 		return NETDEV_TX_BUSY;
> 	}
>=20
>@@ -2033,9 +2028,6 @@ static int gfar_start_xmit(struct=20
>sk_buff *skb, struct net_device *dev)
> 	/* Tell the DMA to go go go */
> 	gfar_write(&regs->tstat, TSTAT_CLEAR_THALT >> tx_queue->qindex);
>=20
>-	/* Unlock priv */
>-	spin_unlock_irqrestore(&tx_queue->txlock, flags);
>-
> 	return NETDEV_TX_OK;
> }
>=20
>@@ -2550,7 +2542,6 @@ static int gfar_poll(struct napi_struct=20
>*napi, int budget)
> 	int tx_cleaned =3D 0, i, left_over_budget =3D budget;
> 	unsigned long serviced_queues =3D 0;
> 	int num_queues =3D 0;
>-	unsigned long flags;
>=20
> 	num_queues =3D gfargrp->num_rx_queues;
> 	budget_per_queue =3D budget/num_queues;
>@@ -2570,13 +2561,9 @@ static int gfar_poll(struct napi_struct=20
>*napi, int budget)
> 			rx_queue =3D priv->rx_queue[i];
> 			tx_queue =3D priv->tx_queue[rx_queue->qindex];
>=20
>-			/* If we fail to get the lock,
>-			 * don't bother with the TX BDs */
>-			if=20
>(spin_trylock_irqsave(&tx_queue->txlock, flags)) {
>-				tx_cleaned +=3D=20
>gfar_clean_tx_ring(tx_queue);
>-			=09
>spin_unlock_irqrestore(&tx_queue->txlock,
>-							flags);
>-			}
>+			netif_tx_lock_bh(priv->ndev);

Will this not lead to locking all the tx queues even though at this
point we are working on a "particular queue" ?

>+			tx_cleaned +=3D gfar_clean_tx_ring(tx_queue);
>+			netif_tx_unlock_bh(priv->ndev);
>=20
> 			rx_cleaned_per_queue =3D=20
>gfar_clean_rx_ring(rx_queue,
> 						=09
>budget_per_queue);
>--

--

Thanks
Sandeep
