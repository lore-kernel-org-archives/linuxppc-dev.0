Message-ID: <38F413F7.CA117A07@lightning.ch>
Date: Wed, 12 Apr 2000 08:13:11 +0200
From: Daniel Marmier <daniel.marmier@lightning.ch>
Reply-To: daniel.marmier@lightning.ch
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dan Malek <dmalek@jlc.net>,
        linux kernel mailing list <linux-kernel@vger.rutgers.edu>,
        Linux PowerPC development mailing list
 <linuxppc-dev@lists.linuxppc.org>
Subject: [patch, resent] Softnet changes for arch/ppc/8xx_io/enet.c
References: <E12f77P-0008Cd-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alan Cox wrote:
>
> The diff is corrupt. Looks like your mailer trashed it

Yes, it did (forgot to disable text wrapping). Here is a hopefully better one.


				Daniel Marmier


diff -urN linux-2.3.99-pre3/arch/ppc/8xx_io/enet.c linux-2.3.99-pre3-dm/arch/ppc/8xx_io/enet.c
--- linux-2.3.99-pre3/arch/ppc/8xx_io/enet.c	Tue Dec 14 15:06:03 1999
+++ linux-2.3.99-pre3-dm/arch/ppc/8xx_io/enet.c	Mon Apr 10 09:17:49 2000
@@ -37,6 +37,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/spinlock.h>

 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
@@ -108,6 +109,10 @@
  *	Port C,  9 (CTS2) - SCC Ethernet Collision
  */

+/* The transmitter timeout
+ */
+#define TX_TIMEOUT		(200*HZ/1000)
+
 /* The number of Tx and Rx buffers.  These are allocated from the page
  * pool.  The code may assume these are power of two, so it is best
  * to keep them that size.
@@ -149,8 +154,8 @@
 	cbd_t	*dirty_tx;	/* The ring entries to be free()ed. */
 	scc_t	*sccp;
 	struct	net_device_stats stats;
-	char	tx_full;
-	unsigned long lock;
+	int	tx_full;
+	spinlock_t lock;
 };

 static int cpm_enet_open(struct net_device *dev);
@@ -190,9 +195,7 @@
 	 * a simple way to do that.
 	 */

-	dev->tbusy = 0;
-	dev->interrupt = 0;
-	dev->start = 1;
+	netif_start_queue(dev);

 	return 0;					/* Always succeed */
 }
@@ -202,55 +205,6 @@
 {
 	struct cpm_enet_private *cep = (struct cpm_enet_private *)dev->priv;
 	volatile cbd_t	*bdp;
-	unsigned long flags;
-
-	/* Transmitter timeout, serious problems. */
-	if (dev->tbusy) {
-		int tickssofar = jiffies - dev->trans_start;
-		if (tickssofar < 200)
-			return 1;
-		printk("%s: transmit timed out.\n", dev->name);
-		cep->stats.tx_errors++;
-#ifndef final_version
-		{
-			int	i;
-			cbd_t	*bdp;
-			printk(" Ring data dump: cur_tx %p%s cur_rx %p.\n",
-				   cep->cur_tx, cep->tx_full ? " (full)" : "",
-				   cep->cur_rx);
-			bdp = cep->tx_bd_base;
-			for (i = 0 ; i < TX_RING_SIZE; i++, bdp++)
-				printk("%04x %04x %08x\n",
-					bdp->cbd_sc,
-					bdp->cbd_datlen,
-					bdp->cbd_bufaddr);
-			bdp = cep->rx_bd_base;
-			for (i = 0 ; i < RX_RING_SIZE; i++, bdp++)
-				printk("%04x %04x %08x\n",
-					bdp->cbd_sc,
-					bdp->cbd_datlen,
-					bdp->cbd_bufaddr);
-		}
-#endif
-
-		dev->tbusy=0;
-		dev->trans_start = jiffies;
-
-		return 0;
-	}
-
-	/* Block a timer-based transmit from overlapping.  This could better be
-	   done with atomic_swap(1, dev->tbusy), but set_bit() works as well. */
-	if (test_and_set_bit(0, (void*)&dev->tbusy) != 0) {
-		printk("%s: Transmitter access conflict.\n", dev->name);
-		return 1;
-	}
-
-	if (test_and_set_bit(0, (void*)&cep->lock) != 0) {
-		printk("%s: tx queue lock!.\n", dev->name);
-		/* don't clear dev->tbusy flag. */
-		return 1;
-	}

 	/* Fill in a Tx ring entry */
 	bdp = cep->cur_tx;
@@ -261,7 +215,6 @@
 		 * This should not happen, since dev->tbusy should be set.
 		 */
 		printk("%s: tx queue full!.\n", dev->name);
-		cep->lock = 0;
 		return 1;
 	}
 #endif
@@ -292,7 +245,9 @@
 	/* Push the data cache so the CPM does not get stale memory
 	 * data.
 	 */
-	flush_dcache_range(skb->data, skb->data + skb->len);
+	flush_dcache_range((unsigned long)skb->data, (unsigned long)skb->data + skb->len);
+
+	spin_lock_irq(cep->lock);

 	/* Send it on its way.  Tell CPM its ready, interrupt when done,
 	 * its the last BD of the frame, and to put the CRC on the end.
@@ -308,20 +263,48 @@
 	else
 		bdp++;

-	save_flags(flags);
-	cli();
-	cep->lock = 0;
-	if (bdp->cbd_sc & BD_ENET_TX_READY)
+	if (bdp->cbd_sc & BD_ENET_TX_READY) {
 		cep->tx_full = 1;
-	else
-		dev->tbusy=0;
-	restore_flags(flags);
+		netif_stop_queue(dev);
+	}

 	cep->cur_tx = (cbd_t *)bdp;

+	spin_unlock_irq(cep->lock);
 	return 0;
 }

+static void cpm_enet_timeout(struct net_device *dev)
+{
+	struct cpm_enet_private *cep = (struct cpm_enet_private *)dev->priv;
+
+	printk("%s: transmit timed out.\n", dev->name);
+	cep->stats.tx_errors++;
+#ifndef final_version
+	{
+		int	i;
+		cbd_t	*bdp;
+		printk(" Ring data dump: cur_tx %p%s cur_rx %p.\n",
+		       cep->cur_tx, cep->tx_full ? " (full)" : "",
+		       cep->cur_rx);
+		bdp = cep->tx_bd_base;
+		for (i = 0 ; i < TX_RING_SIZE; i++, bdp++)
+			printk("%04x %04x %08x\n",
+			       bdp->cbd_sc,
+			       bdp->cbd_datlen,
+			       bdp->cbd_bufaddr);
+		bdp = cep->rx_bd_base;
+		for (i = 0 ; i < RX_RING_SIZE; i++, bdp++)
+			printk("%04x %04x %08x\n",
+			       bdp->cbd_sc,
+			       bdp->cbd_datlen,
+			       bdp->cbd_bufaddr);
+	}
+#endif
+	if (!cep->tx_full)
+		netif_wake_queue(dev);
+}
+
 /* The interrupt handler.
  * This is called from the CPM handler, not the MPC core interrupt.
  */
@@ -335,10 +318,6 @@
 	int	must_restart;

 	cep = (struct cpm_enet_private *)dev->priv;
-	if (dev->interrupt)
-		printk("%s: Re-entering the interrupt handler.\n", dev->name);
-
-	dev->interrupt = 1;

 	/* Get the interrupt events that caused us to be here.
 	*/
@@ -363,6 +342,8 @@
 	/* Transmit OK, or non-fatal error.  Update the buffer descriptors.
 	*/
 	if (int_events & (SCCE_ENET_TXE | SCCE_ENET_TXB)) {
+	    spin_lock(&cep->lock);
+
 	    bdp = cep->dirty_tx;
 	    while ((bdp->cbd_sc&BD_ENET_TX_READY)==0) {
 		if ((bdp==cep->cur_tx) && (cep->tx_full == 0))
@@ -394,12 +375,13 @@
 		/* Deferred means some collisions occurred during transmit,
 		 * but we eventually sent the packet OK.
 		 */
-		if (bdp->cbd_sc & BD_ENET_TX_DEF)
-			cep->stats.collisions++;
+		if (bdp->cbd_sc & BD_ENET_TX_DEF) {
+                    cep->stats.collisions++;
+                }

 		/* Free the sk buffer associated with this last transmit.
 		*/
-		dev_kfree_skb(cep->tx_skbuff[cep->skb_dirty]/*, FREE_WRITE*/);
+		dev_kfree_skb_irq(cep->tx_skbuff[cep->skb_dirty]);
 		cep->skb_dirty = (cep->skb_dirty + 1) & TX_RING_MOD_MASK;

 		/* Update pointer to next buffer descriptor to be transmitted.
@@ -409,6 +391,15 @@
 		else
 			bdp++;

+		/* Since we have freed up a buffer, the ring is no longer
+		 * full.
+		 */
+		if (cep->tx_full) {
+			cep->tx_full = 0;
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+		}
+
 		/* I don't know if we can be held off from processing these
 		 * interrupts for more than one frame time.  I really hope
 		 * not.  In such a case, we would now want to check the
@@ -418,15 +409,6 @@
 		 * does not have BD_ENET_TX_READY set.
 		 */

-		/* Since we have freed up a buffer, the ring is no longer
-		 * full.
-		 */
-		if (cep->tx_full && dev->tbusy) {
-			cep->tx_full = 0;
-			dev->tbusy = 0;
-			mark_bh(NET_BH);
-		}
-
 		cep->dirty_tx = (cbd_t *)bdp;
 	    }

@@ -444,6 +426,8 @@
 		    mk_cr_cmd(CPM_CR_ENET, CPM_CR_RESTART_TX) | CPM_CR_FLG;
 		while (cp->cp_cpcr & CPM_CR_FLG);
 	    }
+
+	    spin_unlock(&cep->lock);
 	}

 	/* Check for receive busy, i.e. packets coming but no place to
@@ -454,10 +438,6 @@
 		cep->stats.rx_dropped++;
 		printk("CPM ENET: BSY can't happen.\n");
 	}
-
-	dev->interrupt = 0;
-
-	return;
 }

 /* During a receive, the cur_rx points to the current incoming buffer.
@@ -562,8 +542,7 @@
 static int
 cpm_enet_close(struct net_device *dev)
 {
-	/* Don't know what to do yet.
-	*/
+	netif_stop_queue(dev);

 	return 0;
 }
@@ -686,6 +665,7 @@
 	cep = (struct cpm_enet_private *)kmalloc(sizeof(*cep), GFP_KERNEL);
 	/*memset(cep, 0, sizeof(*cep));*/
 	__clear_user(cep,sizeof(*cep));
+	spin_lock_init(&cep->lock);

 	/* Create an Ethernet device instance.
 	*/
@@ -857,7 +837,7 @@
 		*/
 		pte = find_pte(&init_mm, mem_addr);
 		pte_val(*pte) |= _PAGE_NO_CACHE;
-		flush_tlb_page(current->mm->mmap, mem_addr);
+		flush_tlb_page(init_mm.mmap, mem_addr);

 		/* Initialize the BD for every fragment in the page.
 		*/
@@ -954,6 +934,8 @@
 	/* The CPM Ethernet specific entries in the device structure. */
 	dev->open = cpm_enet_open;
 	dev->hard_start_xmit = cpm_enet_start_xmit;
+	dev->tx_timeout = cpm_enet_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->stop = cpm_enet_close;
 	dev->get_stats = cpm_enet_get_stats;
 	dev->set_multicast_list = set_multicast_list;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
