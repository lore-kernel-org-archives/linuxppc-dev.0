Message-ID: <3E47BC5E.2010903@intracom.gr>
Date: Mon, 10 Feb 2003 16:51:10 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 3
References: <IGEFJKJNHJDCBKALBJLLGECAFKAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLGECAFKAA.joakim.tjernlund@lumentis.se>
Content-Type: multipart/mixed;
 boundary="------------020305040105060309040706"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020305040105060309040706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Joakim Tjernlund wrote:

>>Hi guys,
>>
>>I have created a patch that applies cleanly to the head of
>>linuxppc_2_4_devel
>>and it works great.
>>
>>Keep up the good work!
>>
>>Pantelis
>>
>>
>
>Hi Pantelis
>
>I don't follow you here. Didn't my patch apply cleanly against linuxppc_2_4_devel?
>I generated my patch against linuxppc_2_4_devel(I think).
>
>    Jocke
>
>
>
>
>
Nope.

Fails at hunks #7 and #8.
Don't worry, it's trivial stuff.

Here is enet.c.rej, if you want to check it.

Regards


--------------020305040105060309040706
Content-Type: text/plain;
 name="enet.c.rej"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="enet.c.rej"

***************
*** 458,540 ****
  	 */
  	bdp = cep->cur_rx;

- for (;;) {
- 	if (bdp->cbd_sc & BD_ENET_RX_EMPTY)
- 		break;
-
  #ifndef final_version
- 	/* Since we have allocated space to hold a complete frame, both
- 	 * the first and last indicators should be set.
- 	 */
- 	if ((bdp->cbd_sc & (BD_ENET_RX_FIRST | BD_ENET_RX_LAST)) !=
- 		(BD_ENET_RX_FIRST | BD_ENET_RX_LAST))
  			printk("CPM ENET: rcv is not first+last\n");
  #endif
-
- 	/* Frame too long or too short.
- 	*/
- 	if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH))
- 		cep->stats.rx_length_errors++;
- 	if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame alignment */
- 		cep->stats.rx_frame_errors++;
- 	if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */
- 		cep->stats.rx_crc_errors++;
- 	if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
- 		cep->stats.rx_crc_errors++;
-
- 	/* Report late collisions as a frame error.
- 	 * On this error, the BD is closed, but we don't know what we
- 	 * have in the buffer.  So, just drop this frame on the floor.
- 	 */
- 	if (bdp->cbd_sc & BD_ENET_RX_CL) {
- 		cep->stats.rx_frame_errors++;
- 	}
- 	else {
-
- 		/* Process the incoming frame.
- 		*/
- 		cep->stats.rx_packets++;
- 		pkt_len = bdp->cbd_datlen;
- 		cep->stats.rx_bytes += pkt_len;
-
- 		/* This does 16 byte alignment, much more than we need.
- 		 * The packet length includes FCS, but we don't want to
- 		 * include that when passing upstream as it messes up
- 		 * bridging applications.
- 		 */
- 		skb = dev_alloc_skb(pkt_len-4);
-
- 		if (skb == NULL) {
- 			printk("%s: Memory squeeze, dropping packet.\n", dev->name);
- 			cep->stats.rx_dropped++;
- 		}
- 		else {
- 			skb->dev = dev;
- 			skb_put(skb,pkt_len-4);	/* Make room */
- 			eth_copy_and_sum(skb,
- 				cep->rx_vaddr[bdp - cep->rx_bd_base],
- 				pkt_len-4, 0);
- 			skb->protocol=eth_type_trans(skb,dev);
- 			netif_rx(skb);
  		}
  	}
-
- 	/* Clear the status flags for this buffer.
- 	*/
- 	bdp->cbd_sc &= ~BD_ENET_RX_STATS;
-
- 	/* Mark the buffer empty.
- 	*/
- 	bdp->cbd_sc |= BD_ENET_RX_EMPTY;
-
- 	/* Update BD pointer to next entry.
- 	*/
- 	if (bdp->cbd_sc & BD_ENET_RX_WRAP)
- 		bdp = cep->rx_bd_base;
- 	else
- 		bdp++;
-
-    }
  	cep->cur_rx = (cbd_t *)bdp;

  	return 0;
--- 464,556 ----
  	 */
  	bdp = cep->cur_rx;

+ 	for (;;) {
+ 		if (bdp->cbd_sc & BD_ENET_RX_EMPTY)
+ 			break;
+
+ #define RX_BD_ERRORS (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_NO | BD_ENET_RX_CR | BD_ENET_RX_OV | BD_ENET_RX_CL)
  #ifndef final_version
+ 		/* Since we have allocated space to hold a complete frame, both
+ 		 * the first and last indicators should be set.
+ 		 */
+ 		if ((bdp->cbd_sc & (BD_ENET_RX_FIRST | BD_ENET_RX_LAST)) !=
+ 		    (BD_ENET_RX_FIRST | BD_ENET_RX_LAST))
  			printk("CPM ENET: rcv is not first+last\n");
  #endif
+ 		if(bdp->cbd_sc & RX_BD_ERRORS){ /* Receive errors ? */
+ 			cep->stats.rx_errors++;
+ 			if (bdp->cbd_sc & (BD_ENET_RX_LG | BD_ENET_RX_SH)) /* Frame too long or too short. */
+ 				cep->stats.rx_length_errors++;
+ 			if (bdp->cbd_sc & BD_ENET_RX_NO)	/* Frame alignment */
+ 				cep->stats.rx_frame_errors++;
+ 			if (bdp->cbd_sc & BD_ENET_RX_CR)	/* CRC Error */
+ 				cep->stats.rx_crc_errors++;
+ 			if (bdp->cbd_sc & BD_ENET_RX_OV)	/* FIFO overrun */
+ 				cep->stats.rx_fifo_errors++;
+ 			if (bdp->cbd_sc & BD_ENET_RX_CL)        /* Late collision */
+ 				cep->stats.collisions++;
+ 		} else {
+ 			/* Process the incoming frame.
+ 			 */
+ 			cep->stats.rx_packets++;
+ 			pkt_len = bdp->cbd_datlen;
+ 			cep->stats.rx_bytes += pkt_len;
+ 			pkt_len -= 4; /* The packet length includes FCS, but we don't want to
+ 				       * include that when passing upstream as it messes up
+ 				       * bridging applications. Is this still true ???? */
+ #ifdef COPY_SMALL_FRAMES
+ 			/* Allocate the next buffer now so we are sure to have one when needed
+ 			 * This does 16 byte alignment, exactly what we need(L1_CACHE aligned). */
+ 			if(pkt_len < RX_COPYBREAK)
+ 				skb_tmp = __dev_alloc_skb(pkt_len, GFP_ATOMIC | GFP_DMA);
+ 			else
+ #endif
+ 				skb_tmp = __dev_alloc_skb(CPM_ENET_RX_FRSIZE, GFP_ATOMIC | GFP_DMA);
+
+ 			if (skb_tmp == NULL) {
+ 				printk("%s: Memory squeeze, dropping packet.\n", dev->name);
+ 				cep->stats.rx_dropped++;
+
+ 			} else {
+ 				skb = cep->rx_vaddr[bdp - cep->rx_bd_base];
+ #ifdef COPY_SMALL_FRAMES
+ 				if(pkt_len < RX_COPYBREAK) {
+ 					typeof(skb) skb_swap = skb;
+ 					memcpy(skb_put(skb_tmp, pkt_len), skb->data, pkt_len);
+ 					/* swap the skb and skb_tmp */
+ 					skb = skb_tmp;
+ 					skb_tmp = skb_swap;
+ 				}
+ 				else
+ #endif
+ 				{
+ 					skb_put(skb, pkt_len);  /* Make room */
+ 					bdp->cbd_bufaddr = __pa(skb_tmp->data);
+ 					cep->rx_vaddr[bdp - cep->rx_bd_base] = skb_tmp;
+ 				}
+ 				dma_cache_inv((unsigned long) skb_tmp->data, CPM_ENET_RX_FRSIZE);
+ 				skb->dev = dev;
+ 				skb->protocol=eth_type_trans(skb, dev);
+ 				netif_rx(skb);
+ 			}
  		}
+
+ 		/* Clear the status flags for this buffer.
+ 		 */
+ 		bdp->cbd_sc &= ~BD_ENET_RX_STATS;
+
+ 		/* Mark the buffer empty.
+ 		 */
+ 		bdp->cbd_sc |= BD_ENET_RX_EMPTY;
+
+ 		/* Update BD pointer to next entry.
+ 		 */
+ 		if (bdp->cbd_sc & BD_ENET_RX_WRAP)
+ 			bdp = cep->rx_bd_base;
+ 		else
+ 			bdp++;
+
  	}
  	cep->cur_rx = (cbd_t *)bdp;

  	return 0;
***************
*** 608,614 ****

  			dmi = dev->mc_list;

- 			for (i=0; i<dev->mc_count; i++) {

  				/* Only support group multicast for now.
  				*/
--- 624,630 ----

  			dmi = dev->mc_list;

+ 			for (i=0; i<dev->mc_count; i++, dmi = dmi->next) {

  				/* Only support group multicast for now.
  				*/

--------------020305040105060309040706--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
