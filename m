Date: Fri, 6 Apr 2001 07:16:44 -0700
From: David Schleef <ds@schleef.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: bugfix patch to arch/ppc/8260_io/fcc_enet.c
Message-ID: <20010406071644.A2517@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The attached patch fixes a bug with 8260 fcc_enet driver that
is related to when the TX buffer becomes full.  Currently,
the driver relies on the BD_ENET_TX_READY for determining if
a ring slot is available for a tx buffer.  This is not a
valid criterion, because the interrupt handler may not have
cleared the slot from a previous tx buffer.  This bug is easy
to generate by writing files over NFS with large wsize.

The patch should apply cleanly to 2_4 and 2_5.




dave...



--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-txring

--- fcc_enet.c.25	Fri Apr  6 03:29:06 2001
+++ fcc_enet.c	Fri Apr  6 04:59:36 2001
@@ -219,8 +219,8 @@
 struct fcc_enet_private {
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	struct	sk_buff* tx_skbuff[TX_RING_SIZE];
-	ushort	skb_cur;
-	ushort	skb_dirty;
+	uint	skb_cur;
+	uint	skb_dirty;

 	/* CPM dual port RAM relative addresses.
 	*/
@@ -329,10 +329,10 @@

 	/* Save skb pointer.
 	*/
-	cep->tx_skbuff[cep->skb_cur] = skb;
+	cep->tx_skbuff[(cep->skb_cur & TX_RING_MOD_MASK)] = skb;

 	cep->stats.tx_bytes += skb->len;
-	cep->skb_cur = (cep->skb_cur+1) & TX_RING_MOD_MASK;
+	cep->skb_cur++;

 	spin_lock_irq(&cep->lock);

@@ -355,7 +355,7 @@
 	else
 		bdp++;

-	if (bdp->cbd_sc & BD_ENET_TX_READY) {
+	if(cep->skb_cur - cep->skb_dirty >= TX_RING_SIZE){
 		netif_stop_queue(dev);
 		cep->tx_full = 1;
 	}
@@ -475,8 +475,8 @@

 		/* Free the sk buffer associated with this last transmit.
 		*/
-		dev_kfree_skb_irq(cep->tx_skbuff[cep->skb_dirty]);
-		cep->skb_dirty = (cep->skb_dirty + 1) & TX_RING_MOD_MASK;
+		dev_kfree_skb_irq(cep->tx_skbuff[(cep->skb_dirty & TX_RING_MOD_MASK)]);
+		cep->skb_dirty++;

 		/* Update pointer to next buffer descriptor to be transmitted.
 		*/

--fUYQa+Pmc3FrFX/N--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
