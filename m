Return-Path: <Manfred.Rudigier@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99C78B7D0B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Apr 2010 19:10:48 +1000 (EST)
From: Manfred Rudigier <Manfred.Rudigier@omicron.at>
To: "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 9 Apr 2010 11:10:35 +0200
Subject: [PATCH v2 net-next 2/2] gianfar: Add hardware TX timestamping support
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E311B26A78@alice.at.omicron.at>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: 'Scott Wood' <scottwood@freescale.com>,
	"'sandeep.kumar@freescale.com'" <sandeep.kumar@freescale.com>, 'David
	Miller' <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a packet has the skb_shared_tx->hardware flag set the device is
instructed to generate a TX timestamp and write it back to memory after
the frame is transmitted. During the clean_tx_ring operation the
timestamp will be extracted and copied into the skb_shared_hwtstamps
struct of the skb.

TX timestamping is enabled by setting the tx_type to something else
than HWTSTAMP_TX_OFF with the SIOCSHWTSTAMP ioctl command. It is only
supported by eTSEC devices.

Signed-off-by: Manfred Rudigier <manfred.rudigier@omicron.at>
---
 drivers/net/gianfar.c |  118 +++++++++++++++++++++++++++++++++++++++++----=
----
 drivers/net/gianfar.h |    3 +-
 2 files changed, 101 insertions(+), 20 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 552e10d..becc3f3 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -795,8 +795,18 @@ static int gfar_hwtstamp_ioctl(struct net_device *netd=
ev,
 	if (config.flags)
 		return -EINVAL;
=20
-	if (config.tx_type)
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		priv->hwts_tx_en =3D 0;
+		break;
+	case HWTSTAMP_TX_ON:
+		if (!(priv->device_flags & FSL_GIANFAR_DEV_HAS_TIMER))
+			return -ERANGE;
+		priv->hwts_tx_en =3D 1;
+		break;
+	default:
 		return -ERANGE;
+	}
=20
 	switch (config.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
@@ -1972,23 +1982,29 @@ static int gfar_start_xmit(struct sk_buff *skb, str=
uct net_device *dev)
 	struct netdev_queue *txq;
 	struct gfar __iomem *regs =3D NULL;
 	struct txfcb *fcb =3D NULL;
-	struct txbd8 *txbdp, *txbdp_start, *base;
+	struct txbd8 *txbdp, *txbdp_start, *base, *txbdp_tstamp =3D NULL;
 	u32 lstatus;
-	int i, rq =3D 0;
+	int i, rq =3D 0, do_tstamp =3D 0;
 	u32 bufaddr;
 	unsigned long flags;
-	unsigned int nr_frags, length;
-
+	unsigned int nr_frags, nr_txbds, length;
+	union skb_shared_tx *shtx;
=20
 	rq =3D skb->queue_mapping;
 	tx_queue =3D priv->tx_queue[rq];
 	txq =3D netdev_get_tx_queue(dev, rq);
 	base =3D tx_queue->tx_bd_base;
 	regs =3D tx_queue->grp->regs;
+	shtx =3D skb_tx(skb);
+
+	/* check if time stamp should be generated */
+	if (unlikely(shtx->hardware && priv->hwts_tx_en))
+		do_tstamp =3D 1;
=20
 	/* make space for additional header when fcb is needed */
 	if (((skb->ip_summed =3D=3D CHECKSUM_PARTIAL) ||
-			(priv->vlgrp && vlan_tx_tag_present(skb))) &&
+			(priv->vlgrp && vlan_tx_tag_present(skb)) ||
+			unlikely(do_tstamp)) &&
 			(skb_headroom(skb) < GMAC_FCB_LEN)) {
 		struct sk_buff *skb_new;
=20
@@ -2005,8 +2021,14 @@ static int gfar_start_xmit(struct sk_buff *skb, stru=
ct net_device *dev)
 	/* total number of fragments in the SKB */
 	nr_frags =3D skb_shinfo(skb)->nr_frags;
=20
+	/* calculate the required number of TxBDs for this skb */
+	if (unlikely(do_tstamp))
+		nr_txbds =3D nr_frags + 2;
+	else
+		nr_txbds =3D nr_frags + 1;
+
 	/* check if there is space to queue this packet */
-	if ((nr_frags+1) > tx_queue->num_txbdfree) {
+	if (nr_txbds > tx_queue->num_txbdfree) {
 		/* no space, stop the queue */
 		netif_tx_stop_queue(txq);
 		dev->stats.tx_fifo_errors++;
@@ -2018,9 +2040,19 @@ static int gfar_start_xmit(struct sk_buff *skb, stru=
ct net_device *dev)
 	txq->tx_packets ++;
=20
 	txbdp =3D txbdp_start =3D tx_queue->cur_tx;
+	lstatus =3D txbdp->lstatus;
+
+	/* Time stamp insertion requires one additional TxBD */
+	if (unlikely(do_tstamp))
+		txbdp_tstamp =3D txbdp =3D next_txbd(txbdp, base,
+				tx_queue->tx_ring_size);
=20
 	if (nr_frags =3D=3D 0) {
-		lstatus =3D txbdp->lstatus | BD_LFLAG(TXBD_LAST | TXBD_INTERRUPT);
+		if (unlikely(do_tstamp))
+			txbdp_tstamp->lstatus |=3D BD_LFLAG(TXBD_LAST |
+					TXBD_INTERRUPT);
+		else
+			lstatus |=3D BD_LFLAG(TXBD_LAST | TXBD_INTERRUPT);
 	} else {
 		/* Place the fragment addresses and lengths into the TxBDs */
 		for (i =3D 0; i < nr_frags; i++) {
@@ -2066,11 +2098,32 @@ static int gfar_start_xmit(struct sk_buff *skb, str=
uct net_device *dev)
 		gfar_tx_vlan(skb, fcb);
 	}
=20
-	/* setup the TxBD length and buffer pointer for the first BD */
+	/* Setup tx hardware time stamping if requested */
+	if (unlikely(do_tstamp)) {
+		shtx->in_progress =3D 1;
+		if (fcb =3D=3D NULL)
+			fcb =3D gfar_add_fcb(skb);
+		fcb->ptp =3D 1;
+		lstatus |=3D BD_LFLAG(TXBD_TOE);
+	}
+
 	txbdp_start->bufPtr =3D dma_map_single(&priv->ofdev->dev, skb->data,
 			skb_headlen(skb), DMA_TO_DEVICE);
=20
-	lstatus |=3D BD_LFLAG(TXBD_CRC | TXBD_READY) | skb_headlen(skb);
+	/*
+	 * If time stamping is requested one additional TxBD must be set up. The
+	 * first TxBD points to the FCB and must have a data length of
+	 * GMAC_FCB_LEN. The second TxBD points to the actual frame data with
+	 * the full frame length.
+	 */
+	if (unlikely(do_tstamp)) {
+		txbdp_tstamp->bufPtr =3D txbdp_start->bufPtr + GMAC_FCB_LEN;
+		txbdp_tstamp->lstatus |=3D BD_LFLAG(TXBD_READY) |
+				(skb_headlen(skb) - GMAC_FCB_LEN);
+		lstatus |=3D BD_LFLAG(TXBD_CRC | TXBD_READY) | GMAC_FCB_LEN;
+	} else {
+		lstatus |=3D BD_LFLAG(TXBD_CRC | TXBD_READY) | skb_headlen(skb);
+	}
=20
 	/*
 	 * We can work in parallel with gfar_clean_tx_ring(), except
@@ -2110,7 +2163,7 @@ static int gfar_start_xmit(struct sk_buff *skb, struc=
t net_device *dev)
 	tx_queue->cur_tx =3D next_txbd(txbdp, base, tx_queue->tx_ring_size);
=20
 	/* reduce TxBD free count */
-	tx_queue->num_txbdfree -=3D (nr_frags + 1);
+	tx_queue->num_txbdfree -=3D (nr_txbds);
=20
 	dev->trans_start =3D jiffies;
=20
@@ -2301,16 +2354,18 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q=
 *tx_queue)
 	struct net_device *dev =3D tx_queue->dev;
 	struct gfar_private *priv =3D netdev_priv(dev);
 	struct gfar_priv_rx_q *rx_queue =3D NULL;
-	struct txbd8 *bdp;
+	struct txbd8 *bdp, *next =3D NULL;
 	struct txbd8 *lbdp =3D NULL;
 	struct txbd8 *base =3D tx_queue->tx_bd_base;
 	struct sk_buff *skb;
 	int skb_dirtytx;
 	int tx_ring_size =3D tx_queue->tx_ring_size;
-	int frags =3D 0;
+	int frags =3D 0, nr_txbds =3D 0;
 	int i;
 	int howmany =3D 0;
 	u32 lstatus;
+	size_t buflen;
+	union skb_shared_tx *shtx;
=20
 	rx_queue =3D priv->rx_queue[tx_queue->qindex];
 	bdp =3D tx_queue->dirty_tx;
@@ -2320,7 +2375,18 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q =
*tx_queue)
 		unsigned long flags;
=20
 		frags =3D skb_shinfo(skb)->nr_frags;
-		lbdp =3D skip_txbd(bdp, frags, base, tx_ring_size);
+
+		/*
+		 * When time stamping, one additional TxBD must be freed.
+		 * Also, we need to dma_unmap_single() the TxPAL.
+		 */
+		shtx =3D skb_tx(skb);
+		if (unlikely(shtx->in_progress))
+			nr_txbds =3D frags + 2;
+		else
+			nr_txbds =3D frags + 1;
+
+		lbdp =3D skip_txbd(bdp, nr_txbds - 1, base, tx_ring_size);
=20
 		lstatus =3D lbdp->lstatus;
=20
@@ -2329,10 +2395,24 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q=
 *tx_queue)
 				(lstatus & BD_LENGTH_MASK))
 			break;
=20
-		dma_unmap_single(&priv->ofdev->dev,
-				bdp->bufPtr,
-				bdp->length,
-				DMA_TO_DEVICE);
+		if (unlikely(shtx->in_progress)) {
+			next =3D next_txbd(bdp, base, tx_ring_size);
+			buflen =3D next->length + GMAC_FCB_LEN;
+		} else
+			buflen =3D bdp->length;
+
+		dma_unmap_single(&priv->ofdev->dev, bdp->bufPtr,
+				buflen, DMA_TO_DEVICE);
+
+		if (unlikely(shtx->in_progress)) {
+			struct skb_shared_hwtstamps shhwtstamps;
+			u64 *ns =3D (u64*) (((u32)skb->data + 0x10) & ~0x7);
+			memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+			shhwtstamps.hwtstamp =3D ns_to_ktime(*ns);
+			skb_tstamp_tx(skb, &shhwtstamps);
+			bdp->lstatus &=3D BD_LFLAG(TXBD_WRAP);
+			bdp =3D next;
+		}
=20
 		bdp->lstatus &=3D BD_LFLAG(TXBD_WRAP);
 		bdp =3D next_txbd(bdp, base, tx_ring_size);
@@ -2364,7 +2444,7 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *=
tx_queue)
=20
 		howmany++;
 		spin_lock_irqsave(&tx_queue->txlock, flags);
-		tx_queue->num_txbdfree +=3D frags + 1;
+		tx_queue->num_txbdfree +=3D nr_txbds;
 		spin_unlock_irqrestore(&tx_queue->txlock, flags);
 	}
=20
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index 1ea287c..ac4a92e 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -540,7 +540,7 @@ struct txbd8
=20
 struct txfcb {
 	u8	flags;
-	u8	reserved;
+	u8	ptp;    /* Flag to enable tx timestamping */
 	u8	l4os;	/* Level 4 Header Offset */
 	u8	l3os; 	/* Level 3 Header Offset */
 	u16	phcs;	/* Pseudo-header Checksum */
@@ -1105,6 +1105,7 @@ struct gfar_private {
=20
 	/* HW time stamping enabled flag */
 	int hwts_rx_en;
+	int hwts_tx_en;
 };
=20
 extern unsigned int ftp_rqfpr[MAX_FILER_IDX + 1];
--=20
1.6.3.3
