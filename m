Message-ID: <01139FC052A0D411900B00508B9535FC0F0D2783@ZCH07EXM04.corp.mot.com>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] PQII FCC Ethernet driver: transmit buffer leak for 2.4
Date: Mon, 28 Jun 2004 19:40:39 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

When PQII FCC Ethernet runs under heavy tx load(such as using NetPIPE to
measure network performance), you may observe memory leak. Eventually
makes system crash. I digged into this problem and found that 2.6.7
don't have this problem. I pulled the fix to 2.4.x, and generated patch
(for 2.4.26, and can be easily modified for other versions). I suggest
that anyone using linux-2.4.x on PQII apply this patch. The problem is
kind of serious. And this should be merged into kernel.org tree as soon
as possible. Who can pass this to the 2.4 maintainer?

--
Leo Li
Software Engineer
Metrowerks -- Freescale

Patch
======

--- linux-2.4.26/arch/ppc/cpm2_io/fcc_enet.c	2004-04-14 21:05:27.000000000 +0800
+++ linux-2.4.26/arch/ppc/cpm2_io/fcc_enet.c.new	2004-06-28 17:02:19.060144928 +0800
@@ -304,6 +304,8 @@
 	struct	sk_buff* tx_skbuff[TX_RING_SIZE];
 	ushort	skb_cur;
 	ushort	skb_dirty;
+
+	atomic_t n_pkts;        /* Number of packets in tx ring */

 	/* CPM dual port RAM relative addresses.
 	*/
@@ -396,13 +398,15 @@
 	bdp->cbd_datlen = skb->len;
 	bdp->cbd_bufaddr = __pa(skb->data);

+	spin_lock_irq(&cep->lock);
+
 	/* Save skb pointer. */
 	cep->tx_skbuff[cep->skb_cur] = skb;

 	cep->stats.tx_bytes += skb->len;
 	cep->skb_cur = (cep->skb_cur+1) & TX_RING_MOD_MASK;

-	spin_lock_irq(&cep->lock);
+	atomic_inc(&cep->n_pkts);

 	/* Send it on its way.  Tell CPM its ready, interrupt when done,
 	 * its the last BD of the frame, and to put the CRC on the end.
@@ -421,9 +425,12 @@
 	else
 		bdp++;

-	if (bdp->cbd_sc & BD_ENET_TX_READY) {
-		netif_stop_queue(dev);
+	/* If the tx_ring is full, stop the queue */
+	if (atomic_read(&cep->n_pkts) >= (TX_RING_SIZE-1)) {
+	  if (!netif_queue_stopped(dev)) {
+	  	netif_stop_queue(dev);
 		cep->tx_full = 1;
+	  }
 	}

 	cep->cur_tx = (cbd_t *)bdp;
@@ -541,6 +548,8 @@
 		/* Free the sk buffer associated with this last transmit. */
 		dev_kfree_skb_irq(cep->tx_skbuff[cep->skb_dirty]);
 		cep->skb_dirty = (cep->skb_dirty + 1) & TX_RING_MOD_MASK;
+
+		atomic_dec(&cep->n_pkts);

 		/* Update pointer to next buffer descriptor to be transmitted. */
 		if (bdp->cbd_sc & BD_ENET_TX_WRAP)
@@ -1782,6 +1791,7 @@
 	while (cp->cp_cpcr & CPM_CR_FLG);

 	cep->skb_cur = cep->skb_dirty = 0;
+	atomic_set(&cep->n_pkts, 0);
 }

 /* Let 'er rip.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
