Message-ID: <3E4788BA.3060007@intracom.gr>
Date: Mon, 10 Feb 2003 13:10:50 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 3
References: <IGEFJKJNHJDCBKALBJLLKEOKFJAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKEOKFJAA.joakim.tjernlund@lumentis.se>
Content-Type: multipart/mixed;
 boundary="------------010004050303060700080809"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010004050303060700080809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joakim Tjernlund wrote:

>>Hi,
>>
>>I am on an 862. Anyway I can't find another definition of dma_cache_inv() but the NO OP in asm-ppc/io.h. Could you give me e hint
>>where it is defined in your kernel?
>>
>
>It's in asm-ppc/io.h (2.4.20) and there are 2 definitions of dma_cache_inv() which depends on
>CONFIG_NOT_COHERENT_CACHE(should be defined for 8xx). What kernel version are you running?
>
> Jocke
>
>>Thanks, Stephan
>>
>>
>>>-----Original Message-----
>>>From: Joakim Tjernlund [mailto:joakim.tjernlund@lumentis.se]
>>>Sent: Montag, 3. Februar 2003 18:23
>>>To: Stephan Linke
>>>Subject: RE: [PATCH] arch/ppc/8xx_io/enet.c, version 3
>>>
>>>
>>>
>>>>Hi Jocke,
>>>>
>>>>in your latest patch you are using dma_cache_inv() instead of invalidate_dcache_range().
>>>>The only dma_cache_inv() I can find is in include/asm-ppc/io.h. and it's a "do{}while(0)".
>>>>Are you shure that this was your intention? It seames to me like you could remove that call as well.
>>>>
>>>I guess you are on 8260? On 8260 there is no need for invalidate_dcache_range() since
>>>it's the CPM is cache coherent. On 8xx it is not cache coherent. I switched
>>>to dma_cache_inv() because it's a no op on 8260 and a invalidate_dcache_range() on 8xx so
>>>it would be easy to adapt the patch to both CPU's.
>>>
>>> Jocke
>>>
>>>
>>>
>>
>
>
>
>
>
>
Hi guys,

I have created a patch that applies cleanly to the head of
linuxppc_2_4_devel
and it works great.

Keep up the good work!

Pantelis



--------------010004050303060700080809
Content-Type: text/plain;
 name="joakim-enet-8xx-panto.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="joakim-enet-8xx-panto.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1207  -> 1.1209
#	arch/ppc/8xx_io/enet.c	1.25    -> 1.27
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/10	panto@macpanto.intranet.gr	1.1208
# Import of Joakim Tjernlund enet patch.
# --------------------------------------------
# 03/02/10	panto@macpanto.intranet.gr	1.1209
# Removed private declaration of dma_cache_inv, include header.
# --------------------------------------------
#
diff -Nru a/arch/ppc/8xx_io/enet.c b/arch/ppc/8xx_io/enet.c
--- a/arch/ppc/8xx_io/enet.c	Mon Feb 10 13:06:35 2003
+++ b/arch/ppc/8xx_io/enet.c	Mon Feb 10 13:06:35 2003
@@ -34,7 +34,6 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/netdevice.h>
@@ -42,6 +41,7 @@
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>

+#include <asm/io.h>
 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
 #include <asm/mpc8xx.h>
@@ -86,6 +86,14 @@
  * All functions are directly controlled using I/O pins.  See <asm/commproc.h>.
  */

+/* Define COPY_SMALL_FRAMES if you want to save buffer memory for small packets
+ * at a small performance hit. Note performance testing needed */
+/* #define COPY_SMALL_FRAMES 1  */
+
+#ifdef COPY_SMALL_FRAMES
+  #define RX_COPYBREAK (256-16) /* dev_alloc_skb() adds 16 bytes for internal use */
+#endif
+
 /* The transmitter timeout
  */
 #define TX_TIMEOUT	(2*HZ)
@@ -97,19 +105,17 @@
  * the skbuffer directly.
  */
 #ifdef CONFIG_ENET_BIG_BUFFERS
-#define CPM_ENET_RX_PAGES	32
-#define CPM_ENET_RX_FRSIZE	2048
-#define CPM_ENET_RX_FRPPG	(PAGE_SIZE / CPM_ENET_RX_FRSIZE)
-#define RX_RING_SIZE		(CPM_ENET_RX_FRPPG * CPM_ENET_RX_PAGES)
-#define TX_RING_SIZE		64	/* Must be power of two */
-#define TX_RING_MOD_MASK	63	/*   for this to work */
+  #define RX_RING_SIZE		64
+  #define TX_RING_SIZE		64	/* Must be power of two for this to work */
 #else
-#define CPM_ENET_RX_PAGES	4
-#define CPM_ENET_RX_FRSIZE	2048
-#define CPM_ENET_RX_FRPPG	(PAGE_SIZE / CPM_ENET_RX_FRSIZE)
-#define RX_RING_SIZE		(CPM_ENET_RX_FRPPG * CPM_ENET_RX_PAGES)
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

 /* The CPM stores dest/src/type, data, and checksum for receive packets.
@@ -143,7 +149,7 @@
 	/* Virtual addresses for the receive buffers because we can't
 	 * do a __va() on them anymore.
 	 */
-	unsigned char *rx_vaddr[RX_RING_SIZE];
+	void    *rx_vaddr[RX_RING_SIZE];
 	struct	net_device_stats stats;
 	uint	tx_full;
 	spinlock_t lock;
@@ -205,7 +211,6 @@
 	/* Fill in a Tx ring entry */
 	bdp = cep->cur_tx;

-#ifndef final_version
 	if (bdp->cbd_sc & BD_ENET_TX_READY) {
 		/* Ooops.  All transmit buffers are full.  Bail out.
 		 * This should not happen, since cep->tx_busy should be set.
@@ -213,7 +218,6 @@
 		printk("%s: tx queue full!.\n", dev->name);
 		return 1;
 	}
-#endif

 	/* Clear all of the status flags.
 	 */
@@ -279,7 +283,6 @@

 	printk("%s: transmit timed out.\n", dev->name);
 	cep->stats.tx_errors++;
-#ifndef final_version
 	{
 		int	i;
 		cbd_t	*bdp;
@@ -299,7 +302,6 @@
 			       bdp->cbd_datlen,
 			       bdp->cbd_bufaddr);
 	}
-#endif
 	if (!cep->tx_full)
 		netif_wake_queue(dev);
 }
@@ -370,11 +372,11 @@

 		cep->stats.tx_packets++;

-		/* Deferred means some collisions occurred during transmit,
-		 * but we eventually sent the packet OK.
-		 */
-		if (bdp->cbd_sc & BD_ENET_TX_DEF)
-			cep->stats.collisions++;
+		/* Check retry counter, i.e. collision counter */
+		if (bdp->cbd_sc & BD_ENET_TX_RCMASK){
+			/* Note that counter cannot go higher than 15 */
+			cep->stats.collisions+=(bdp->cbd_sc & BD_ENET_TX_RCMASK)>>2;
+		}

 		/* Free the sk buffer associated with this last transmit.
 		*/
@@ -449,6 +451,7 @@
 	struct	scc_enet_private *cep;
 	volatile cbd_t	*bdp;
 	struct	sk_buff *skb;
+	struct	sk_buff *skb_tmp;
 	ushort	pkt_len;

 	cep = (struct scc_enet_private *)dev->priv;
@@ -458,83 +461,93 @@
 	 */
 	bdp = cep->cur_rx;

-for (;;) {
-	if (bdp->cbd_sc & BD_ENET_RX_EMPTY)
-		break;
-
+	for (;;) {
+		if (bdp->cbd_sc & BD_ENET_RX_EMPTY)
+			break;
+
+#define RX_BD_ERRORS (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO | BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_CL)
 #ifndef final_version
-	/* Since we have allocated space to hold a complete frame, both
-	 * the first and last indicators should be set.
-	 */
-	if ((bdp->cbd_sc & (BD_ENET_RX_FIRST | BD_ENET_RX_LAST)) !=
-		(BD_ENET_RX_FIRST | BD_ENET_RX_LAST))
+		/* Since we have allocated space to hold a complete frame, both
+		 * the first and last indicators should be set.
+		 */
+		if ((bdp->cbd_sc & (BD_ENET_RX_FIRST | BD_ENET_RX_LAST)) !=
+		    (BD_ENET_RX_FIRST | BD_ENET_RX_LAST))
 			printk("CPM ENET: rcv is not first+last\n");
 #endif
+		if(bdp->cbd_sc & RX_BD_ERRORS){ /* Receive errors ? */
+			cep->stats.rx_errors++;
+			if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH)) /* Frame too long or too short. */
+				cep->stats.rx_length_errors++;
+			if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame alignment */
+				cep->stats.rx_frame_errors++;
+			if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */
+				cep->stats.rx_crc_errors++;
+			if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
+				cep->stats.rx_fifo_errors++;
+			if (bdp->cbd_sc & BD_ENET_RX_CL)        /* Late collision */
+				cep->stats.collisions++;
+		} else {
+			/* Process the incoming frame.
+			 */
+			cep->stats.rx_packets++;
+			pkt_len = bdp->cbd_datlen;
+			cep->stats.rx_bytes += pkt_len;
+			pkt_len -= 4; /* The packet length includes FCS, but we don't want to
+				       * include that when passing upstream as it messes up
+				       * bridging applications. Is this still true ???? */
+#ifdef COPY_SMALL_FRAMES
+			/* Allocate the next buffer now so we are sure to have one when needed
+			 * This does 16 byte alignment, exactly what we need(L1_CACHE aligned). */
+			if(pkt_len < RX_COPYBREAK)
+				skb_tmp = __dev_alloc_skb(pkt_len, GFP_ATOMIC | GFP_DMA);
+			else
+#endif
+				skb_tmp = __dev_alloc_skb(CPM_ENET_RX_FRSIZE, GFP_ATOMIC | GFP_DMA);

-	/* Frame too long or too short.
-	*/
-	if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH))
-		cep->stats.rx_length_errors++;
-	if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame alignment */
-		cep->stats.rx_frame_errors++;
-	if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */
-		cep->stats.rx_crc_errors++;
-	if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
-		cep->stats.rx_crc_errors++;
-
-	/* Report late collisions as a frame error.
-	 * On this error, the BD is closed, but we don't know what we
-	 * have in the buffer.  So, just drop this frame on the floor.
-	 */
-	if (bdp->cbd_sc & BD_ENET_RX_CL) {
-		cep->stats.rx_frame_errors++;
-	}
-	else {
-
-		/* Process the incoming frame.
-		*/
-		cep->stats.rx_packets++;
-		pkt_len = bdp->cbd_datlen;
-		cep->stats.rx_bytes += pkt_len;
-
-		/* This does 16 byte alignment, much more than we need.
-		 * The packet length includes FCS, but we don't want to
-		 * include that when passing upstream as it messes up
-		 * bridging applications.
-		 */
-		skb = dev_alloc_skb(pkt_len-4);
-
-		if (skb == NULL) {
-			printk("%s: Memory squeeze, dropping packet.\n", dev->name);
-			cep->stats.rx_dropped++;
-		}
-		else {
-			skb->dev = dev;
-			skb_put(skb,pkt_len-4);	/* Make room */
-			eth_copy_and_sum(skb,
-				cep->rx_vaddr[bdp - cep->rx_bd_base],
-				pkt_len-4, 0);
-			skb->protocol=eth_type_trans(skb,dev);
-			netif_rx(skb);
+			if (skb_tmp == NULL) {
+				printk("%s: Memory squeeze, dropping packet.\n", dev->name);
+				cep->stats.rx_dropped++;
+
+			} else {
+				skb = cep->rx_vaddr[bdp - cep->rx_bd_base];
+#ifdef COPY_SMALL_FRAMES
+				if(pkt_len < RX_COPYBREAK) {
+					typeof(skb) skb_swap = skb;
+					memcpy(skb_put(skb_tmp, pkt_len), skb->data, pkt_len);
+					/* swap the skb and skb_tmp */
+					skb = skb_tmp;
+					skb_tmp = skb_swap;
+				}
+				else
+#endif
+				{
+					skb_put(skb, pkt_len);  /* Make room */
+					bdp->cbd_bufaddr = __pa(skb_tmp->data);
+					cep->rx_vaddr[bdp - cep->rx_bd_base] = skb_tmp;
+				}
+				dma_cache_inv((unsigned long) skb_tmp->data, CPM_ENET_RX_FRSIZE);
+				skb->dev = dev;
+				skb->protocol=eth_type_trans(skb, dev);
+				netif_rx(skb);
+			}
 		}
-	}

-	/* Clear the status flags for this buffer.
-	*/
-	bdp->cbd_sc &= ~BD_ENET_RX_STATS;
+		/* Clear the status flags for this buffer.
+		 */
+		bdp->cbd_sc &= ~BD_ENET_RX_STATS;

-	/* Mark the buffer empty.
-	*/
-	bdp->cbd_sc |= BD_ENET_RX_EMPTY;
+		/* Mark the buffer empty.
+		 */
+		bdp->cbd_sc |= BD_ENET_RX_EMPTY;

-	/* Update BD pointer to next entry.
-	*/
-	if (bdp->cbd_sc & BD_ENET_RX_WRAP)
-		bdp = cep->rx_bd_base;
-	else
-		bdp++;
+		/* Update BD pointer to next entry.
+		 */
+		if (bdp->cbd_sc & BD_ENET_RX_WRAP)
+			bdp = cep->rx_bd_base;
+		else
+			bdp++;

-   }
+  	}
 	cep->cur_rx = (cbd_t *)bdp;

 	return 0;
@@ -647,8 +660,7 @@
 	struct net_device *dev;
 	struct scc_enet_private *cep;
 	int i, j, k;
-	unsigned char	*eap, *ba;
-	dma_addr_t	mem_addr;
+	unsigned char	*eap;
 	bd_t		*bd;
 	volatile	cbd_t		*bdp;
 	volatile	cpm8xx_t	*cp;
@@ -839,22 +851,14 @@

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
+		struct	sk_buff * skb = __dev_alloc_skb(CPM_ENET_RX_FRSIZE, GFP_ATOMIC | GFP_DMA);
+		dma_cache_inv((unsigned long) skb->data, CPM_ENET_RX_FRSIZE);
+		bdp->cbd_sc = BD_ENET_RX_EMPTY | BD_ENET_RX_INTR;
+		bdp->cbd_bufaddr = __pa(skb->data);
+		cep->rx_vaddr[k++] = skb;
+		bdp++;
 	}

 	/* Set the last buffer to wrap.

--------------010004050303060700080809--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
