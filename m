Date: Sat, 5 Jun 1999 00:48:30 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org, becker@cesdis1.gsfc.nasa.gov
Subject: [patch] Making tulip.c work on linuxppc
Message-ID: <19990605004830.A521@drow.res.cmu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=EVF5PPMfhYS0aIcm
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii

I noticed in the comments to 0.91 that it claimed to support powerpc on
"all but <one early 21x4x> which does not have native mixed-endian
support".  Well, I've gone through two tulip clones (a PNIC and my
current Macronix 98713) which apparently don't either.  So, I made
tulip work in little-endian mode for these.

I don't know how this patch would interact with a card which has this
fabled mixed-endian support -- probably very badly.  But for my two, it
worked.  It also cleans up a few warnings that I noticed while working
- one of the comparison between signed and unsigned turned out to make
a significant difference).

Thoughts, anyone?

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tulip-0.91.c.ppc.diff"

--- ../tulip-0.91e.c	Wed May 26 18:53:36 1999
+++ tulip-0.91e.c	Sat Jun  5 00:29:18 1999
@@ -339,7 +339,7 @@
 	0x8086, 0x0039, 0xffff, PCI_ADDR0_IO, 128, 32, tulip_probe1 },
   { "Xircom Tulip clone",
 	0x115d, 0x0003, 0xffff, PCI_ADDR0_IO, 128, 32, tulip_probe1 },
-  {0},
+  {0, 0, 0, 0, 0, 0, 0, 0},
 };
 #endif /* !CARD_BUS */
 
@@ -393,7 +393,7 @@
   { "Xircom tulip work-alike", 128, 0x0801fbff,
 	HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_PWRDWN | HAS_NWAY143,
 	t21142_timer },
-  {0},
+  {0, 0, 0, 0, 0},
 };
 /* This matches the table above.  Note 21142 == 21143. */
 enum chips {
@@ -1447,9 +1447,9 @@
 		*setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
 		*setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
 		/* Put the setup frame on the Tx list. */
-		tp->tx_ring[0].length = 0x08000000 | 192;
-		tp->tx_ring[0].buffer1 = virt_to_bus(tp->setup_frame);
-		tp->tx_ring[0].status = DescOwned;
+		tp->tx_ring[0].length = cpu_to_le32(0x08000000 | 192);
+		tp->tx_ring[0].buffer1 = cpu_to_le32(virt_to_bus(tp->setup_frame));
+		tp->tx_ring[0].status = cpu_to_le32(DescOwned);
 
 		tp->cur_tx++;
 	}
@@ -2003,7 +2003,7 @@
 	long ioaddr = dev->base_addr;
 	int csr12 = inl(ioaddr + CSR12);
 	int next_tick = 60*HZ;
-	int new_csr6 = 0;
+	u32 new_csr6 = 0;
 
 	if (tulip_debug > 2)
 		printk(KERN_INFO"%s: 21143 negotiation status %8.8x, %s.\n",
@@ -2291,7 +2291,7 @@
 			next_tick = 3*HZ;
 	} else {
 		int csr12 = inl(ioaddr + CSR12);
-		int new_csr6 = tp->csr6 & ~0x40C40200;
+		u32 new_csr6 = tp->csr6 & ~0x40C40200;
 		int phy_reg = inl(ioaddr + 0xB8);
 		int csr5 = inl(ioaddr + CSR5);
 
@@ -2428,11 +2428,11 @@
 	if (tulip_debug > 3) {
 		int i;
 		for (i = 0; i < RX_RING_SIZE; i++) {
-			u8 *buf = (u8 *)(tp->rx_ring[i].buffer1);
+			u8 *buf = (u8 *)bus_to_virt(le32_to_cpu(tp->rx_ring[i].buffer1));
 			int j;
 			printk(KERN_DEBUG "%2d: %8.8x %8.8x %8.8x %8.8x  "
 				   "%2.2x %2.2x %2.2x.\n",
-				   i, (unsigned int)tp->rx_ring[i].status,
+				   i, (unsigned int)le32_to_cpu(tp->rx_ring[i].status),
 				   (unsigned int)tp->rx_ring[i].length,
 				   (unsigned int)tp->rx_ring[i].buffer1,
 				   (unsigned int)tp->rx_ring[i].buffer2,
@@ -2443,10 +2443,10 @@
 		}
 		printk(KERN_DEBUG "  Rx ring %8.8x: ", (int)tp->rx_ring);
 		for (i = 0; i < RX_RING_SIZE; i++)
-			printk(" %8.8x", (unsigned int)tp->rx_ring[i].status);
+			printk(" %8.8x", (unsigned int)le32_to_cpu(tp->rx_ring[i].status));
 		printk("\n" KERN_DEBUG "  Tx ring %8.8x: ", (int)tp->tx_ring);
 		for (i = 0; i < TX_RING_SIZE; i++)
-			printk(" %8.8x", (unsigned int)tp->tx_ring[i].status);
+			printk(" %8.8x", (unsigned int)le32_to_cpu(tp->tx_ring[i].status));
 		printk("\n");
 	}
 #endif
@@ -2474,14 +2474,14 @@
 	tp->dirty_rx = tp->dirty_tx = 0;
 
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		tp->rx_ring[i].status = 0x00000000;
-		tp->rx_ring[i].length = PKT_BUF_SZ;
-		tp->rx_ring[i].buffer2 = virt_to_bus(&tp->rx_ring[i+1]);
+		tp->rx_ring[i].status = 0;
+		tp->rx_ring[i].length = cpu_to_le32(PKT_BUF_SZ);
+		tp->rx_ring[i].buffer2 = cpu_to_le32(virt_to_bus(&tp->rx_ring[i+1]));
 		tp->rx_skbuff[i] = NULL;
 	}
 	/* Mark the last entry as wrapping the ring. */
-	tp->rx_ring[i-1].length = PKT_BUF_SZ | DESC_RING_WRAP;
-	tp->rx_ring[i-1].buffer2 = virt_to_bus(&tp->rx_ring[0]);
+	tp->rx_ring[i-1].length = cpu_to_le32(PKT_BUF_SZ | DESC_RING_WRAP);
+	tp->rx_ring[i-1].buffer2 = cpu_to_le32(virt_to_bus(&tp->rx_ring[0]));
 
 
 	for (i = 0; i < RX_RING_SIZE; i++) {
@@ -2493,8 +2493,8 @@
 		if (skb == NULL)
 			break;
 		skb->dev = dev;			/* Mark as being used by this device. */
-		tp->rx_ring[i].status = DescOwned;	/* Owned by Tulip chip */
-		tp->rx_ring[i].buffer1 = virt_to_bus(skb->tail);
+		tp->rx_ring[i].status = cpu_to_le32(DescOwned);	/* Owned by Tulip chip */
+		tp->rx_ring[i].buffer1 = cpu_to_le32(virt_to_bus(skb->tail));
 	}
 	tp->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
 
@@ -2502,10 +2502,10 @@
 	   do need to clear the ownership bit. */
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		tp->tx_skbuff[i] = 0;
-		tp->tx_ring[i].status = 0x00000000;
-		tp->tx_ring[i].buffer2 = virt_to_bus(&tp->tx_ring[i+1]);
+		tp->tx_ring[i].status = 0;
+		tp->tx_ring[i].buffer2 = cpu_to_le32(virt_to_bus(&tp->tx_ring[i+1]));
 	}
-	tp->tx_ring[i-1].buffer2 = virt_to_bus(&tp->tx_ring[0]);
+	tp->tx_ring[i-1].buffer2 = cpu_to_le32(virt_to_bus(&tp->tx_ring[0]));
 }
 
 static int
@@ -2531,7 +2531,7 @@
 	entry = tp->cur_tx % TX_RING_SIZE;
 
 	tp->tx_skbuff[entry] = skb;
-	tp->tx_ring[entry].buffer1 = virt_to_bus(skb->data);
+	tp->tx_ring[entry].buffer1 = cpu_to_le32(virt_to_bus(skb->data));
 
 	if (tp->cur_tx - tp->dirty_tx < TX_RING_SIZE/2) {/* Typical path */
 		flag = 0x60000000; /* No interrupt */
@@ -2546,8 +2546,8 @@
 	if (entry == TX_RING_SIZE-1)
 		flag |= 0xe0000000 | DESC_RING_WRAP;
 
-	tp->tx_ring[entry].length = skb->len | flag;
-	tp->tx_ring[entry].status = DescOwned;	/* Pass ownership to the chip. */
+	tp->tx_ring[entry].length = cpu_to_le32(skb->len | flag);
+	tp->tx_ring[entry].status = cpu_to_le32(DescOwned);	/* Pass ownership to the chip. */
 	tp->cur_tx++;
 	if ( ! tp->tx_full)
 		clear_bit(0, (void*)&dev->tbusy);
@@ -2566,7 +2566,8 @@
 	struct device *dev = (struct device *)dev_instance;
 	struct tulip_private *tp = (struct tulip_private *)dev->priv;
 	long ioaddr = dev->base_addr;
-	int csr5, work_budget = max_interrupt_work;
+	int work_budget = max_interrupt_work;
+	u32 csr5;
 
 #if defined(__i386__) && defined(SMP_CHECK)
 	if (test_and_set_bit(0, (void*)&dev->interrupt)) {
@@ -2605,7 +2606,7 @@
 			for (dirty_tx = tp->dirty_tx; tp->cur_tx - dirty_tx > 0;
 				 dirty_tx++) {
 				int entry = dirty_tx % TX_RING_SIZE;
-				int status = tp->tx_ring[entry].status;
+				int status = le32_to_cpu(tp->tx_ring[entry].status);
 
 				if (status < 0)
 					break;			/* It still hasn't been Txed */
@@ -2635,7 +2636,7 @@
 					if (status & 0x0001) tp->stats.tx_deferred++;
 #endif
 #if LINUX_VERSION_CODE > 0x20127
-					tp->stats.tx_bytes += tp->tx_ring[entry].length & 0x7ff;
+					tp->stats.tx_bytes += le32_to_cpu(tp->tx_ring[entry].length) & 0x7ff;
 #endif
 					tp->stats.collisions += (status >> 3) & 15;
 					tp->stats.tx_packets++;
@@ -2740,14 +2741,14 @@
 
 	if (tulip_debug > 4)
 		printk(KERN_DEBUG " In tulip_rx(), entry %d %8.8x.\n", entry,
-			   tp->rx_ring[entry].status);
+			   le32_to_cpu(tp->rx_ring[entry].status));
 	/* If we own the next entry, it's a new packet. Send it up. */
-	while (tp->rx_ring[entry].status >= 0) {
-		s32 status = tp->rx_ring[entry].status;
+	while ((s32)le32_to_cpu(tp->rx_ring[entry].status) >= 0) {
+		s32 status = le32_to_cpu(tp->rx_ring[entry].status);
 
 		if (tulip_debug > 5)
 			printk(KERN_DEBUG " In tulip_rx(), entry %d %8.8x.\n", entry,
-				   tp->rx_ring[entry].status);
+				   le32_to_cpu(tp->rx_ring[entry].status));
 		if (--rx_work_limit < 0)
 			break;
 		if ((status & 0x38008300) != 0x0300) {
@@ -2791,22 +2792,22 @@
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
 #if ! defined(__alpha__)
-				eth_copy_and_sum(skb, bus_to_virt(tp->rx_ring[entry].buffer1),
+				eth_copy_and_sum(skb, bus_to_virt( le32_to_cpu(tp->rx_ring[entry].buffer1) ),
 								 pkt_len, 0);
 				skb_put(skb, pkt_len);
 #else
 				memcpy(skb_put(skb, pkt_len),
-					   bus_to_virt(tp->rx_ring[entry].buffer1), pkt_len);
+					   bus_to_virt( le32_to_cpu(tp->rx_ring[entry].buffer1) ), pkt_len);
 #endif
 				work_done++;
 			} else { 	/* Pass up the skb already on the Rx ring. */
 				char *temp = skb_put(skb = tp->rx_skbuff[entry], pkt_len);
 				tp->rx_skbuff[entry] = NULL;
 #ifndef final_version
-				if (bus_to_virt(tp->rx_ring[entry].buffer1) != temp)
+				if (bus_to_virt( le32_to_cpu(tp->rx_ring[entry].buffer1) ) != temp)
 					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
 						   "do not match in tulip_rx: %p vs. %p / %p.\n",
-						   dev->name, bus_to_virt(tp->rx_ring[entry].buffer1),
+						   dev->name, bus_to_virt( le32_to_cpu(tp->rx_ring[entry].buffer1) ),
 						   skb->head, temp);
 #endif
 			}
@@ -2830,10 +2831,10 @@
 			if (skb == NULL)
 				break;
 			skb->dev = dev;			/* Mark as being used by this device. */
-			tp->rx_ring[entry].buffer1 = virt_to_bus(skb->tail);
+			tp->rx_ring[entry].buffer1 = cpu_to_le32(virt_to_bus(skb->tail));
 			work_done++;
 		}
-		tp->rx_ring[entry].status = DescOwned;
+		tp->rx_ring[entry].status = cpu_to_le32(DescOwned);
 	}
 
 	return work_done;
@@ -2876,7 +2877,7 @@
 		tp->rx_skbuff[i] = 0;
 		tp->rx_ring[i].status = 0;		/* Not owned by Tulip chip. */
 		tp->rx_ring[i].length = 0;
-		tp->rx_ring[i].buffer1 = 0xBADF00D0; /* An invalid address. */
+		tp->rx_ring[i].buffer1 = cpu_to_le32(0xBADF00D0); /* An invalid address. */
 		if (skb) {
 #if LINUX_VERSION_CODE < 0x20100
 			skb->free = 1;
@@ -3119,9 +3120,9 @@
 				/* Avoid a chip errata by prefixing a dummy entry. */
 				tp->tx_skbuff[entry] = 0;
 				tp->tx_ring[entry].length =
-					(entry == TX_RING_SIZE-1) ? DESC_RING_WRAP : 0;
+					(entry == TX_RING_SIZE-1) ? cpu_to_le32(DESC_RING_WRAP) : 0;
 				tp->tx_ring[entry].buffer1 = 0;
-				tp->tx_ring[entry].status = DescOwned;
+				tp->tx_ring[entry].status = cpu_to_le32(DescOwned);
 				entry = tp->cur_tx++ % TX_RING_SIZE;
 			}
 
@@ -3129,9 +3130,9 @@
 			/* Put the setup frame on the Tx list. */
 			if (entry == TX_RING_SIZE-1)
 				tx_flags |= DESC_RING_WRAP;		/* Wrap ring. */
-			tp->tx_ring[entry].length = tx_flags;
-			tp->tx_ring[entry].buffer1 = virt_to_bus(tp->setup_frame);
-			tp->tx_ring[entry].status = DescOwned;
+			tp->tx_ring[entry].length = cpu_to_le32(tx_flags);
+			tp->tx_ring[entry].buffer1 = cpu_to_le32(virt_to_bus(tp->setup_frame));
+			tp->tx_ring[entry].status = cpu_to_le32(DescOwned);
 			if (tp->cur_tx - tp->dirty_tx >= TX_RING_SIZE - 2) {
 				set_bit(0, (void*)&dev->tbusy);
 				tp->tx_full = 1;

--EVF5PPMfhYS0aIcm--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
