Date: Mon, 4 Mar 2002 13:17:03 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] ocp enet
Message-ID: <20020304131703.A15551@ecam.san.rr.com>
References: <Pine.LNX.4.30.0202271525500.15001-200000@hill.cs.ucr.edu> <3C7D0AB9.5070801@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
In-Reply-To: <3C7D0AB9.5070801@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii

On Wed, Feb 27, 2002 at 04:35:05PM +0000, Armin wrote:
> Thanks,
>
> I want to try in on a few boards I have before it goes in.
>
> --armin

Have you gotten a chance to try it yet? The testing I have
done has not shown any problems and I have been able to test
just about all of the cases. Boards with/without the correct
pull-ups. Remove the correct phy-id from the table. Booting
without a link.

Here is another patch that for the driver. It removes some
cut and paste code from the rx interupts and breaks the work
into rx_clean and rx_fill functions. rx_fill is also called from
open.

If rx_fill fails to alloc a skb, it leave the rx_slot there, so
the next time through rx_clean skips over all the slots without
skb's and hopefully rx_fill with then be able to do the alloc.
This prevents taking a rxde interrupt for a single alloc failure.

I also added a skb_res module parm, I should have defaulted it
down to 0 for most people, but I forgot and left it at the value
I use.

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ocp_enet.diff2"

--- drivers/net/ibm_ocp_enet.c	Thu Feb 28 12:17:17 2002
+++ drivers/net/ibm_ocp_enet.c	Mon Mar  4 12:54:51 2002
@@ -123,6 +123,8 @@
 void ppc405_eth_txde(int, void *, struct pt_regs *);
 void ppc405_eth_rxde(int, void *, struct pt_regs *);
 void ppc405_eth_mac(int, void *, struct pt_regs *);
+static void ppc405_rx_fill(struct net_device *, int);
+static int ppc405_rx_clean(struct net_device *);

 int fec_enet_mdio_read(struct net_device *dev, int reg, uint * value);
 int fec_enet_mdio_write(struct net_device *dev, int reg);
@@ -156,6 +158,12 @@

 int zmii_bridge;

+static int skb_res=(64+2);
+MODULE_PARM(skb_res, "i");
+MODULE_PARM_DESC(skb_res, "Amount of data to reserve on skb buffs\n"
+                 "The 405 handles a missaligned IP header fine but\n"
+                 "this can help if you are routing to a tunnel or a device that needs aligned data" );
+
 static int
 ppc405_enet_open(struct net_device *dev)
 {
@@ -216,21 +224,17 @@
 	fep->tx_desc[loop - 1].ctrl |= MAL_TX_CTRL_WRAP;

 	/* Format the receive descriptor ring. */
-	for (loop = 0; loop < NUM_RX_BUFF; loop++) {
-		fep->rx_skb[loop] = dev_alloc_skb(DESC_RX_BUF_SIZE);
-		fep->rx_desc[loop].data_len = 0;
-		fep->rx_desc[loop].data_ptr =
-		    (char *) virt_to_phys(fep->rx_skb[loop]->data);
-		fep->rx_desc[loop].ctrl = MAL_RX_CTRL_EMPTY | MAL_RX_CTRL_INTR;
-
-		dma_cache_wback_inv((unsigned long)
-				    fep->rx_skb[loop]->data, DESC_RX_BUF_SIZE);
-	}
-
-	fep->rx_desc[loop - 1].ctrl |= MAL_RX_CTRL_WRAP;
+	fep->rx_slot = 0;
+        ppc405_rx_fill(dev,0);
+        if( fep->rx_slot != 0 ){
+                printk(KERN_ERR "%s: Not enough mem for RxChain durning Open?\n", dev->name );
+                /*We couldn't fill the ring at startup?
+                 *We could clean up and fail to open but right now we will try to
+                 *carry on. It may be a sign of a bad NUM_RX_BUFF value
+                 */
+        }

 	fep->tx_cnt = 0;
-	fep->rx_slot = 0;
 	fep->tx_slot = 0;
 	fep->ack_slot = 0;

@@ -918,133 +922,145 @@

 	return;
 }
+/*
+  Fill/Re-fill the rx chain with valid ctrl/ptrs.
+  This function will fill from rx_slot up to the parm end.
+  So to completely fill the chain pre-set rx_slot to 0 and
+  pass in an end of 0.
+ */
+static void ppc405_rx_fill(struct net_device *dev, int end)
+{
+        int i;
+	struct fec_enet_private *fep = (struct fec_enet_private *)dev->priv;
+        unsigned char* ptr;
+
+        i=fep->rx_slot;
+        do {
+                if( fep->rx_skb[i] != NULL ){
+                        /*We will trust the skb is still in a good state */
+                        ptr =
+                                (char *) virt_to_phys(fep->rx_skb[i]->data);
+                }else{
+
+                        fep->rx_skb[i] = dev_alloc_skb(DESC_RX_BUF_SIZE+skb_res);
+
+                        if( fep->rx_skb[i] == NULL ){
+                                /* Keep rx_slot here, the next time clean/fill is called
+                                 * we will try again before the MAL wraps back here
+                                 * If the MAL tries to use this descriptor with
+                                 * the EMPTY bit off it will cause the
+                                 * rxde interrupt.  That is where we will
+                                 * try again to allocate an sk_buff.
+                                 */
+                                break;
+
+                        }
+
+                        if( skb_res ) skb_reserve(fep->rx_skb[i], skb_res);
+
+                        dma_cache_wback_inv((unsigned long) fep->rx_skb[i]->
+                                            data, DESC_RX_BUF_SIZE);
+                        ptr =
+                                (char *) virt_to_phys(fep->rx_skb[i]->data);
+                }
+                fep->rx_desc[i].ctrl      =
+                        MAL_RX_CTRL_EMPTY |
+                        MAL_RX_CTRL_INTR  | /*could be smarter about this to avoid ints at high loads*/
+                        (i == (NUM_RX_BUFF-1) ? MAL_RX_CTRL_WRAP : 0);
+
+                fep->rx_desc[i].data_ptr  = ptr;
+        }while( (i = (i+1) % NUM_RX_BUFF) != end );

-void
-ppc405_eth_rxeob(int irq, void *dev_instance, struct pt_regs *regs)
+        fep->rx_slot = i;
+}
+static int ppc405_rx_clean(struct net_device *dev)
 {
-	struct net_device *dev;
+        int i;
 	int error, frame_length;
-	struct fec_enet_private *fep;
-	mal_desc_t *rx_desc;
-	struct sk_buff *skb_rx, **skb_rx_p;
-	int first_time;
-
-	/*
-	 * Protect against ppc405_eth_rxde() modifying data structures
-	 * this function is using.  Note that ppc405_eth_rxde() does
-	 * not have to protect against this function because if an rxde
-	 * interrupt occurs the hardware will have disabled the EMAC and
-	 * thus the rxeob interrupt will not occur until ppc405_eth_rxde()
-	 * re-enables the EMAC.
-	 */
-
-	dev = (struct net_device *) dev_instance;
-	fep = dev->priv;
-	disable_irq(irq_resource[fep->emac_num][BL_MAL_RXDE].irq);
-
-	first_time = 1;
-	frame_length = 0;
+	struct fec_enet_private *fep = (struct fec_enet_private *)dev->priv;
+        unsigned short ctrl;

-      do_it_again:
-	rx_desc = &fep->rx_desc[fep->rx_slot];
-	skb_rx_p = &fep->rx_skb[fep->rx_slot];
-	skb_rx = *skb_rx_p;
+        i = fep->rx_slot;

-	while ((!(rx_desc->ctrl & MAL_RX_CTRL_EMPTY)) && (skb_rx != NULL)) {
+        do{
+                if( fep->rx_skb[i] == NULL )
+                        goto skip;/*we have already handled the packet but haved failed to alloc*/
+                /*
+                   since rx_desc is in uncached mem we don't keep reading it directly
+                   we pull out a local copy of ctrl and do the checks on the copy.
+                */
+                ctrl      = fep->rx_desc[i].ctrl;
+                if( ctrl & MAL_RX_CTRL_EMPTY )
+                        break; /*we don't have any more ready packets*/

-		if (rx_desc->ctrl & EMAC_BAD_RX_PACKET) {
+		if (ctrl & EMAC_BAD_RX_PACKET) {

 			fep->stats.rx_errors++;
 			fep->stats.rx_dropped++;

-			if (rx_desc->ctrl & EMAC_RX_ST_OE)
+			if (ctrl & EMAC_RX_ST_OE)
 				fep->stats.rx_fifo_errors++;
-			if (rx_desc->ctrl & EMAC_RX_ST_AE)
+			if (ctrl & EMAC_RX_ST_AE)
 				fep->stats.rx_frame_errors++;
-			if (rx_desc->ctrl & EMAC_RX_ST_BFCS)
+			if (ctrl & EMAC_RX_ST_BFCS)
 				fep->stats.rx_crc_errors++;
-			if (rx_desc->ctrl & (EMAC_RX_ST_RP | EMAC_RX_ST_PTL |
-					     EMAC_RX_ST_ORE | EMAC_RX_ST_IRE))
+			if (ctrl & (EMAC_RX_ST_RP | EMAC_RX_ST_PTL |
+                                    EMAC_RX_ST_ORE | EMAC_RX_ST_IRE))
 				fep->stats.rx_length_errors++;
-
-			rx_desc->ctrl &= ~EMAC_BAD_RX_PACKET;
-			rx_desc->ctrl |= MAL_RX_CTRL_EMPTY;
-
 		} else {

 			/* Send the skb up the chain. */
+			frame_length = fep->rx_desc[i].data_len - 4;

-			frame_length = rx_desc->data_len - 4;
-
-			skb_put(skb_rx, frame_length);
-			skb_rx->dev = dev;
-			skb_rx->protocol = eth_type_trans(skb_rx, dev);
+			skb_put(fep->rx_skb[i], frame_length);
+			fep->rx_skb[i]->dev = dev;
+			fep->rx_skb[i]->protocol = eth_type_trans(fep->rx_skb[i], dev);

-			error = netif_rx(skb_rx);
+			error = netif_rx(fep->rx_skb[i]);
 			if ((error == NET_RX_DROP) || (error == NET_RX_BAD)) {
 				fep->stats.rx_dropped++;
 			} else {
 				fep->stats.rx_packets++;
 				fep->stats.rx_bytes += frame_length;
 			}
-
-			*skb_rx_p = dev_alloc_skb(DESC_RX_BUF_SIZE);
-
-			if (*skb_rx_p == NULL) {
-
-				/* When MAL tries to use this descriptor with
-				 * the EMPTY bit off it will cause the
-				 * rxde interrupt.  That is where we will
-				 * try again to allocate an sk_buff.
-				 */
-
-			} else {
-
-				skb_rx = *skb_rx_p;
-
-				dma_cache_wback_inv((unsigned long) skb_rx->
-						    data, DESC_RX_BUF_SIZE);
-				rx_desc->data_ptr =
-				    (char *) virt_to_phys(skb_rx->data);
-				rx_desc->ctrl |= MAL_RX_CTRL_EMPTY;
-			}
+                        fep->rx_skb[i] = NULL;
 		}
+        skip:
+	}while( (i = (i+1) % NUM_RX_BUFF) != fep->rx_slot );
+        return i;
+}

-		if (++fep->rx_slot >= NUM_RX_BUFF)
-			fep->rx_slot = 0;
-
-		rx_desc = &fep->rx_desc[fep->rx_slot];
-		skb_rx_p = &fep->rx_skb[fep->rx_slot];
-		skb_rx = *skb_rx_p;
-	}
+void
+ppc405_eth_rxeob(int irq, void *dev_instance, struct pt_regs *regs)
+{
+        int i;
+	struct net_device *dev;
+	struct fec_enet_private *fep;

 	/*
-	 * Don't stay stuck in this handler forever.
-	 * The first time through:
-	 *   Acknowledge the interrupt from the MAL.
-	 *   If another interrupt has come in, go back and process it.
-	 *   (Otherwise, return; the interrupt has been cleared in the device.)
-	 * The second time through:
-	 *   Don't acknowledge the interrupt from the MAL, just return.
-	 *   If another interrupt has come in, ignore it.
-	 *   Didn't acknowledge the interrupt.  That means the UIC interrupt
-	 *     will be reasserted as soon as it is acknowledged and we'll end
-	 *     up in this handler again soon (possibly with no new data to
-	 *     process).  But, in the meantime, other interrupt handlers will
-	 *     have had a shot at the cpu.
+	 * Protect against ppc405_eth_rxde() modifying data structures
+	 * this function is using.  Note that ppc405_eth_rxde() does
+	 * not have to protect against this function because if an rxde
+	 * interrupt occurs the hardware will have disabled the EMAC and
+	 * thus the rxeob interrupt will not occur until ppc405_eth_rxde()
+	 * re-enables the EMAC.
 	 */

-	if (first_time) {
+	dev = (struct net_device *) dev_instance;
+	fep = dev->priv;
+	disable_irq(irq_resource[fep->emac_num][BL_MAL_RXDE].irq);

-		/* Ack the interrupt bits */
-		set_malrxeobisr(fep->mal_num, get_malrxeobisr(fep->mal_num));
+        /*
+         *There was a rx_clean loop before the int ack then a goto to loop
+         *again. This should have a similar behaivor.
+         *
+         */
+        ppc405_rx_clean(dev);
+        /* Ack the interrupt bits */
+        set_malrxeobisr(fep->mal_num, get_malrxeobisr(fep->mal_num));

-		/* make sure no interrupt gets lost */
-		if (!(rx_desc->ctrl & MAL_RX_CTRL_EMPTY)) {
-			first_time = 0;
-			goto do_it_again;
-		}
-	}
+        i = ppc405_rx_clean(dev);
+        ppc405_rx_fill(dev, i);

 	enable_irq(irq_resource[fep->emac_num][BL_MAL_RXDE].irq);

@@ -1089,12 +1105,7 @@
 {
 	struct net_device *dev;
 	struct fec_enet_private *fep;
-	int curr;
-	int end;
-	int frame_length, error;
-	mal_desc_t *rx_desc;
-	struct sk_buff *skb_rx, **skb_rx_p;
-
+
 	dev = (struct net_device *) dev_instance;
 	fep = dev->priv;

@@ -1114,92 +1125,14 @@
 	ppc405_eth_mal_dump(dev, KERN_DEBUG);
 	ppc405_eth_desc_dump(dev, KERN_DEBUG);
 #endif
-
-	curr = fep->rx_slot;
-	end = curr;
-
-	do {
-		rx_desc = &fep->rx_desc[curr];
-
-		if (rx_desc->ctrl & MAL_RX_CTRL_EMPTY) {
-			if (++curr >= NUM_RX_BUFF)
-				curr = 0;
-			continue;
-		}
-
-		if (rx_desc->ctrl & EMAC_BAD_RX_PACKET) {
-
-			fep->stats.rx_errors++;
-			fep->stats.rx_dropped++;
-			if (rx_desc->ctrl & EMAC_RX_ST_OE)
-				fep->stats.rx_fifo_errors++;
-			if (rx_desc->ctrl & EMAC_RX_ST_AE)
-				fep->stats.rx_frame_errors++;
-			if (rx_desc->ctrl & EMAC_RX_ST_BFCS)
-				fep->stats.rx_crc_errors++;
-			if (rx_desc->ctrl & (EMAC_RX_ST_RP | EMAC_RX_ST_PTL |
-					     EMAC_RX_ST_ORE | EMAC_RX_ST_IRE))
-				fep->stats.rx_length_errors++;
-
-			rx_desc->ctrl &= ~EMAC_BAD_RX_PACKET;
-			rx_desc->ctrl |= MAL_RX_CTRL_EMPTY;
-
-		} else {
-
-			/* Send the skb up the chain. */
-			frame_length = rx_desc->data_len - 4;
-
-			skb_rx_p = &fep->rx_skb[curr];
-			skb_rx = *skb_rx_p;
-
-			if (*skb_rx_p) {
-
-				skb_put(skb_rx, frame_length);
-				skb_rx->dev = dev;
-				skb_rx->protocol = eth_type_trans(skb_rx, dev);
-
-				error = netif_rx(skb_rx);
-				if ((error == NET_RX_DROP) ||
-				    (error == NET_RX_BAD)) {
-					fep->stats.rx_dropped++;
-				} else {
-					fep->stats.rx_packets++;
-					fep->stats.rx_bytes += frame_length;
-				}
-			}
-
-			*skb_rx_p = dev_alloc_skb(DESC_RX_BUF_SIZE);
-
-			if (*skb_rx_p == NULL) {
-
-				/* When MAL tries to use this descriptor with
-				 * the EMPTY bit off it will cause the
-				 * rxde interrupt.  That is where we will
-				 * try again to allocate an sk_buff.
-				 */
-
-			} else {
-
-				skb_rx = *skb_rx_p;
-				dma_cache_wback_inv((unsigned long)
-						    skb_rx->data,
-						    DESC_RX_BUF_SIZE);
-				rx_desc->data_ptr = (char *)
-				    virt_to_phys(skb_rx->data);
-
-				rx_desc->ctrl |= MAL_RX_CTRL_EMPTY;
-			}
-		}
-
-		if (++curr >= NUM_RX_BUFF)
-			curr = 0;
-
-	} while (curr != end);
+        /* so do we have any good packets still?*/
+        ppc405_rx_clean(dev);

 	/* When the interface is restarted it resets processing to the first
 	 * descriptor in the table.
 	 */
 	fep->rx_slot = 0;
+        ppc405_rx_fill(dev, 0);

 	/* Clear the interrupt */
 	set_malrxdeir(fep->mal_num, get_malrxdeir(fep->mal_num));

--zhXaljGHf11kAtnf--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
