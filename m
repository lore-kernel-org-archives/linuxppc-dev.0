Message-Id: <200210211313.g9LDDn4d017057@blooper.utfors.se>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] arch/ppc/8xx_io/enet.c
Date: Mon, 21 Oct 2002 15:13:48 +0200
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Here is a patch to drop the expensive memcpy of received ethernet frames in
interrupt context. I have not done any bench marking, but mounting a NFS rootfs feels faster.

I am using a heavily modified enet.c in my system, but I think I got the patch correct.

Also fixed a bug in set_multicast_list(), move the dmi list forward when walking it(dmi = dmi->next;)

Comments? Anyone care to do some benchmarking?

        Jocke

 --- arch/ppc/8xx_io/enet.c.org	Mon Oct 21 14:35:59 2002
+++ arch/ppc/8xx_io/enet.c	Mon Oct 21 15:06:04 2002
@@ -96,18 +96,17 @@
  * We don't need to allocate pages for the transmitter.  We just use
  * the skbuffer directly.
  */
+#define CPM_ENET_RX_FRSIZE	1600   /* MUST be a multiple of cache line! */
+#if CPM_ENET_RX_FRSIZE % L1_CACHE_LINE_SIZE != 0
+    #error CPM_ENET_RX_FRSIZE must be a multiple of L1 cache size
+#endif
+
 #ifdef CONFIG_ENET_BIG_BUFFERS
-#define CPM_ENET_RX_PAGES	32
-#define CPM_ENET_RX_FRSIZE	2048
-#define CPM_ENET_RX_FRPPG	(PAGE_SIZE / CPM_ENET_RX_FRSIZE)
-#define RX_RING_SIZE		(CPM_ENET_RX_FRPPG * CPM_ENET_RX_PAGES)
+#define RX_RING_SIZE		64
 #define TX_RING_SIZE		64	/* Must be power of two */
 #define TX_RING_MOD_MASK	63	/*   for this to work */
 #else
-#define CPM_ENET_RX_PAGES	4
-#define CPM_ENET_RX_FRSIZE	2048
-#define CPM_ENET_RX_FRPPG	(PAGE_SIZE / CPM_ENET_RX_FRSIZE)
-#define RX_RING_SIZE		(CPM_ENET_RX_FRPPG * CPM_ENET_RX_PAGES)
+#define RX_RING_SIZE		8
 #define TX_RING_SIZE		8	/* Must be power of two */
 #define TX_RING_MOD_MASK	7	/*   for this to work */
 #endif
@@ -143,7 +142,7 @@
 	/* Virtual addresses for the receive buffers because we can't
 	 * do a __va() on them anymore.
 	 */
-	unsigned char *rx_vaddr[RX_RING_SIZE];
+	void    *rx_vaddr[RX_RING_SIZE];
 	struct	net_device_stats stats;
 	uint	tx_full;
 	spinlock_t lock;
@@ -449,6 +448,7 @@
 	struct	scc_enet_private *cep;
 	volatile cbd_t	*bdp;
 	struct	sk_buff *skb;
+	struct	sk_buff *skb_tmp;
 	ushort	pkt_len;

 	cep = (struct scc_enet_private *)dev->priv;
@@ -497,25 +497,26 @@
 		pkt_len = bdp->cbd_datlen;
 		cep->stats.rx_bytes += pkt_len;

-		/* This does 16 byte alignment, much more than we need.
+		/* This does 16 byte alignment, exactly what we need.
 		 * The packet length includes FCS, but we don't want to
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = dev_alloc_skb(pkt_len-4);
-
-		if (skb == NULL) {
+		skb_tmp = dev_alloc_skb(CPM_ENET_RX_FRSIZE);
+		if (skb_tmp == NULL) {
 			printk("%s: Memory squeeze, dropping packet.\n", dev->name);
 			cep->stats.rx_dropped++;
-		}
-		else {
+		} else {
+			skb = cep->rx_vaddr[bdp - cep->rx_bd_base];
 			skb->dev = dev;
 			skb_put(skb,pkt_len-4);	/* Make room */
-			eth_copy_and_sum(skb,
-				cep->rx_vaddr[bdp - cep->rx_bd_base],
-				pkt_len-4, 0);
 			skb->protocol=eth_type_trans(skb,dev);
 			netif_rx(skb);
+
+			invalidate_dcache_range((unsigned long) skb_tmp->data,
+						(unsigned long) skb_tmp->data + CPM_ENET_RX_FRSIZE);
+			bdp->cbd_bufaddr = __pa(skb_tmp->data);
+			cep->rx_vaddr[bdp - cep->rx_bd_base] = skb_tmp;
 		}
 	}

@@ -631,6 +632,7 @@
 				/* this delay is necessary here -- Cort */
 				udelay(10);
 				while (cpmp->cp_cpcr & CPM_CR_FLG);
+				dmi = dmi->next;
 			}
 		}
 	}
@@ -647,8 +649,7 @@
 	struct net_device *dev;
 	struct scc_enet_private *cep;
 	int i, j, k;
-	unsigned char	*eap, *ba;
-	dma_addr_t	mem_addr;
+	unsigned char	*eap;
 	bd_t		*bd;
 	volatile	cbd_t		*bdp;
 	volatile	cpm8xx_t	*cp;
@@ -839,22 +840,15 @@

 	bdp = cep->rx_bd_base;
 	k = 0;
-	for (i=0; i<CPM_ENET_RX_PAGES; i++) {
-
-		/* Allocate a page.
-		*/
-		ba = (unsigned char *)consistent_alloc(GFP_KERNEL, PAGE_SIZE, &mem_addr);
-
-		/* Initialize the BD for every fragment in the page.
-		*/
-		for (j=0; j<CPM_ENET_RX_FRPPG; j++) {
-			bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
-			bdp->cbd_bufaddr = mem_addr;
-			cep->rx_vaddr[k++] = ba;
-			mem_addr += CPM_ENET_RX_FRSIZE;
-			ba += CPM_ENET_RX_FRSIZE;
-			bdp++;
-		}
+	/* Initialize the BDs. */
+	for (j=0; j < RX_RING_SIZE; j++) {
+		struct	sk_buff * skb = dev_alloc_skb(CPM_ENET_RX_FRSIZE);
+		bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
+		bdp->cbd_bufaddr = __pa(skb->data);
+		invalidate_dcache_range((unsigned long) skb->data,
+					(unsigned long) skb->data + CPM_ENET_RX_FRSIZE);
+		cep->rx_vaddr[k++] = skb;
+		bdp++;
 	}

 	/* Set the last buffer to wrap.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
