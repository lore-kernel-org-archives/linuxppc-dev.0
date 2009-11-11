Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9DD8B7067
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 15:20:28 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAB4K9ix013439
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 21:20:20 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id nAB4K9vO001788
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 22:20:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 6/6] gianfar: Revive SKB recycling
Date: Wed, 11 Nov 2009 09:50:04 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81B950979@zin33exm22.fsl.freescale.net>
In-Reply-To: <20091111001110.GF8817@oksana.dev.rtsoft.ru>
References: <20091111001036.GA28576@oksana.dev.rtsoft.ru>
	<20091111001110.GF8817@oksana.dev.rtsoft.ru>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"David Miller" <davem@davemloft.net>
Cc: Jon Loeliger <jdl@jdl.com>, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Fleming Andy-AFLEMING <afleming@freescale.com>,
	Stephen Hemminger <shemminger@vyatta.com>,
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

>-----Original Message-----
>From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
>Sent: Wednesday, November 11, 2009 5:41 AM
>To: David Miller
>Cc: Fleming Andy-AFLEMING; Jon Loeliger; Kumar=20
>Gopalpet-B05799; Lennert Buytenhek; Stephen Hemminger;=20
>netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
>Subject: [PATCH 6/6] gianfar: Revive SKB recycling
>
>Before calling gfar_clean_tx_ring() the driver grabs an=20
>irqsave spinlock, and then tries to recycle skbs. But since
>skb_recycle_check() returns 0 with IRQs disabled, we'll never=20
>recycle any skbs.
>
>It appears that gfar_clean_tx_ring() and gfar_start_xmit() are=20
>mostly idependent and can work in parallel, except when they=20
>modify num_txbdfree.
>
>So we can drop the lock from most sections and thus fix the=20
>skb recycling.
>
>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>---
> drivers/net/gianfar.c |   31 +++++++++++++++++++------------
> 1 files changed, 19 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c=20
>index fde430a..16def13 100644
>--- a/drivers/net/gianfar.c
>+++ b/drivers/net/gianfar.c
>@@ -1928,14 +1928,11 @@ static int gfar_start_xmit(struct=20
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
>@@ -1999,6 +1996,20 @@ static int gfar_start_xmit(struct=20
>sk_buff *skb, struct net_device *dev)
> 	lstatus |=3D BD_LFLAG(TXBD_CRC | TXBD_READY) | skb_headlen(skb);
>=20
> 	/*
>+	 * We can work in parallel with gfar_clean_tx_ring(), except
>+	 * when modifying num_txbdfree. Note that we didn't=20
>grab the lock
>+	 * when we were reading the num_txbdfree and checking=20
>for available
>+	 * space, that's because outside of this function it=20
>can only grow,
>+	 * and once we've got needed space, it cannot suddenly=20
>disappear.
>+	 *
>+	 * The lock also protects us from gfar_error(), which can modify
>+	 * regs->tstat and thus retrigger the transfers, which is why we
>+	 * also must grab the lock before setting ready bit for=20
>the first
>+	 * to be transmitted BD.
>+	 */
>+	spin_lock_irqsave(&tx_queue->txlock, flags);
>+
>+	/*
> 	 * The powerpc-specific eieio() is used, as wmb() has too strong
> 	 * semantics (it requires synchronization between cacheable and
> 	 * uncacheable mappings, which eieio doesn't provide=20
>and which we @@ -2225,6 +2236,8 @@ static int=20
>gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
> 	skb_dirtytx =3D tx_queue->skb_dirtytx;
>=20
> 	while ((skb =3D tx_queue->tx_skbuff[skb_dirtytx])) {
>+		unsigned long flags;
>+
> 		frags =3D skb_shinfo(skb)->nr_frags;
> 		lbdp =3D skip_txbd(bdp, frags, base, tx_ring_size);
>=20
>@@ -2269,7 +2282,9 @@ static int gfar_clean_tx_ring(struct=20
>gfar_priv_tx_q *tx_queue)
> 			TX_RING_MOD_MASK(tx_ring_size);
>=20
> 		howmany++;
>+		spin_lock_irqsave(&tx_queue->txlock, flags);
> 		tx_queue->num_txbdfree +=3D frags + 1;
>+		spin_unlock_irqrestore(&tx_queue->txlock, flags);
> 	}
>=20
> 	/* If we freed a buffer, we can restart transmission,=20
>if necessary */ @@ -2548,7 +2563,6 @@ static int=20
>gfar_poll(struct napi_struct *napi, int budget)
> 	int tx_cleaned =3D 0, i, left_over_budget =3D budget;
> 	unsigned long serviced_queues =3D 0;
> 	int num_queues =3D 0;
>-	unsigned long flags;
>=20
> 	num_queues =3D gfargrp->num_rx_queues;
> 	budget_per_queue =3D budget/num_queues;
>@@ -2568,14 +2582,7 @@ static int gfar_poll(struct napi_struct=20
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
>-
>+			tx_cleaned +=3D gfar_clean_tx_ring(tx_queue);
> 			rx_cleaned_per_queue =3D=20
>gfar_clean_rx_ring(rx_queue,
> 						=09
>budget_per_queue);
> 			rx_cleaned +=3D rx_cleaned_per_queue;
>--


Anton, we tried some experiments too at our end, and removing the
spinlocks did help improve the performance and recycling was effective
although, I don't have exact numbers to specify.

But overall I agree with you in removing the spinlocks from the
gfar_poll context.


--

Thanks
Sandeep
