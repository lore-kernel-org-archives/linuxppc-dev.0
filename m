Date: Mon, 10 Feb 2003 15:35:34 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 3
In-reply-to: <3E4793BE.3010803@imc-berlin.de>
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKECAFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Hi there,
>
> has someone actually ported Jocke's patch to 8xx FEC !?
>
> Any benchmarks?
>
> Thanks,
>
> Steven

Actually I had a copy at work so here it goes. Not tested(not even compiled)

 Jocke

--- arch/ppc/8xx_io/fec.c	Fri Nov  1 14:44:05 2002
+++ arch/ppc/8xx_io/new_fec.c	Sun Feb  9 14:24:45 2003
@@ -83,26 +83,34 @@
 } phy_info_t;
 #endif	/* CONFIG_USE_MDIO */

+/* Define COPY_SMALL_FRAMES if you want to save buffer memory for small packets
+ * at a small performance hit. Note performance testing needed */
+/* #define COPY_SMALL_FRAMES 1  */
+
+#ifdef COPY_SMALL_FRAMES
+  #define RX_COPYBREAK (256-16) /* dev_alloc_skb() adds 16 bytes for internal use */
+#endif
+
+
 /* The number of Tx and Rx buffers.  These are allocated from the page
  * pool.  The code may assume these are power of two, so it is best
  * to keep them that size.
  * We don't need to allocate pages for the transmitter.  We just use
  * the skbuffer directly.
  */
+
 #ifdef CONFIG_ENET_BIG_BUFFERS
-#define FEC_ENET_RX_PAGES	16
-#define FEC_ENET_RX_FRSIZE	2048
-#define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
-#define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
-#define TX_RING_SIZE		16	/* Must be power of two */
-#define TX_RING_MOD_MASK	15	/*   for this to work */
+  #define RX_RING_SIZE		32
+  #define TX_RING_SIZE		16	/* Must be power of two for this to work */
 #else
-#define FEC_ENET_RX_PAGES	4
-#define FEC_ENET_RX_FRSIZE	2048
-#define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
-#define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
-#define TX_RING_SIZE		8	/* Must be power of two */
-#define TX_RING_MOD_MASK	7	/*   for this to work */
+  #define RX_RING_SIZE		8
+  #define TX_RING_SIZE		8	/* Must be power of two for this to work */
+#endif
+#define TX_RING_MOD_MASK	(TX_RING_SIZE-1)
+
+#define CPM_ENET_RX_FRSIZE	1552 /* must be a multiple of cache line */
+#if CPM_ENET_RX_FRSIZE % L1_CACHE_LINE_SIZE != 0
+    #error CPM_ENET_RX_FRSIZE must be a multiple of L1 cache size
 #endif

 /* Interrupt events/masks.
@@ -573,7 +581,7 @@

 	/* Check for errors. */
 	if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO |
-			   BD_ENET_RX_CR | BD_ENET_RX_OV)) {
+			   BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_CL)) {
 		fep->stats.rx_errors++;
 		if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH)) {
 		/* Frame too long or too short. */
@@ -585,41 +593,53 @@
 			fep->stats.rx_crc_errors++;
 		if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
 			fep->stats.rx_crc_errors++;
-	}
-
-	/* Report late collisions as a frame error.
-	 * On this error, the BD is closed, but we don't know what we
-	 * have in the buffer.  So, just drop this frame on the floor.
-	 */
-	if (bdp->cbd_sc & BD_ENET_RX_CL) {
-		fep->stats.rx_errors++;
-		fep->stats.rx_frame_errors++;
-		goto rx_processing_done;
-	}
-
-	/* Process the incoming frame.
-	 */
-	fep->stats.rx_packets++;
-	pkt_len = bdp->cbd_datlen;
-	fep->stats.rx_bytes += pkt_len;
-	data = fep->rx_vaddr[bdp - fep->rx_bd_base];
-
-	/* This does 16 byte alignment, exactly what we need.
-	 * The packet length includes FCS, but we don't want to
-	 * include that when passing upstream as it messes up
-	 * bridging applications.
-	 */
-	skb = dev_alloc_skb(pkt_len-4);
-
-	if (skb == NULL) {
-		printk("%s: Memory squeeze, dropping packet.\n", dev->name);
-		fep->stats.rx_dropped++;
+		if (bdp->cbd_sc & BD_ENET_RX_CL)	/* Late collision */
+			fep->stats.rx_frame_errors++;	/* Report as a frame error. */
 	} else {
-		skb->dev = dev;
-		skb_put(skb,pkt_len-4);	/* Make room */
-		eth_copy_and_sum(skb, data, pkt_len-4, 0);
-		skb->protocol=eth_type_trans(skb,dev);
-		netif_rx(skb);
+
+		/* Process the incoming frame.
+		 */
+		fep->stats.rx_packets++;
+		pkt_len = bdp->cbd_datlen;
+		fep->stats.rx_bytes += pkt_len;
+		pkt_len -= 4; /* The packet length includes FCS, but we don't want to
+			       * include that when passing upstream as it messes up
+			       * bridging applications. Is this still true ???? */
+#ifdef COPY_SMALL_FRAMES
+		/* Allocate the next buffer now so we are sure to have one when needed
+		 * This does 16 byte alignment, exactly what we need(L1_CACHE aligned). */
+		if(pkt_len < RX_COPYBREAK)
+			skb_tmp = __dev_alloc_skb(pkt_len, GFP_ATOMIC | GFP_DMA);
+		else
+#endif
+			skb_tmp = __dev_alloc_skb(CPM_ENET_RX_FRSIZE, GFP_ATOMIC | GFP_DMA);
+
+		if (skb_tmp == NULL) {
+			printk("%s: Memory squeeze, dropping packet.\n", dev->name);
+			fep->stats.rx_dropped++;
+
+		} else {
+			skb = fep->rx_vaddr[bdp - fep->rx_bd_base];
+#ifdef COPY_SMALL_FRAMES
+			if(pkt_len < RX_COPYBREAK) {
+				typeof(skb) skb_swap = skb;
+				memcpy(skb_put(skb_tmp, pkt_len), skb->data, pkt_len);
+				/* swap the skb and skb_tmp */
+				skb = skb_tmp;
+				skb_tmp = skb_swap;
+			}
+			else
+#endif
+			{
+				skb_put(skb, pkt_len);  /* Make room */
+				bdp->cbd_bufaddr = __pa(skb_tmp->data);
+				fep->rx_vaddr[bdp - fep->rx_bd_base] = skb_tmp;
+			}
+			dma_cache_inv((unsigned long) skb_tmp->data, CPM_ENET_RX_FRSIZE);
+			skb->dev = dev;
+			skb->protocol=eth_type_trans(skb, dev);
+			netif_rx(skb);
+		}
 	}
   rx_processing_done:

@@ -1662,7 +1682,7 @@

 			dmi = dev->mc_list;

-			for (i=0; i<dev->mc_count; i++) {
+			for (i=0; i<dev->mc_count; i++, dmi = dmi->next) {

 				/* Only support group multicast for now.
 				*/
@@ -1698,8 +1718,7 @@
 	struct net_device *dev;
 	struct fec_enet_private *fep;
 	int i, j, k;
-	unsigned char	*eap, *iap, *ba;
-	unsigned long	mem_addr;
+	unsigned char	*eap, *iap;
 	volatile	cbd_t	*bdp;
 	cbd_t		*cbd_base;
 	volatile	immap_t	*immap;
@@ -1783,24 +1802,15 @@
 	*/
 	bdp = fep->rx_bd_base;
 	k = 0;
-	for (i=0; i<FEC_ENET_RX_PAGES; i++) {
-
-		/* Allocate a page.
-		*/
-		ba = (unsigned char *)consistent_alloc(GFP_KERNEL, PAGE_SIZE, &mem_addr);
-
-		/* Initialize the BD for every fragment in the page.
-		*/
-		for (j=0; j<FEC_ENET_RX_FRPPG; j++) {
-			bdp->cbd_sc = BD_ENET_RX_EMPTY;
-			bdp->cbd_bufaddr = mem_addr;
-			fep->rx_vaddr[k++] = ba;
-			mem_addr += FEC_ENET_RX_FRSIZE;
-			ba += FEC_ENET_RX_FRSIZE;
-			bdp++;
-		}
+	/* Initialize the BDs. */
+	for (j=0; j < RX_RING_SIZE; j++) {
+		struct	sk_buff * skb = __dev_alloc_skb(CPM_ENET_RX_FRSIZE, GFP_ATOMIC | GFP_DMA);
+		dma_cache_inv((unsigned long) skb->data, CPM_ENET_RX_FRSIZE);
+		bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
+		bdp->cbd_bufaddr = __pa(skb->data);
+		fep->rx_vaddr[k++] = skb;
+		bdp++;
 	}
-
 	/* Set the last buffer to wrap.
 	*/
 	bdp--;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
