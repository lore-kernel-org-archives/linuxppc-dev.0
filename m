Date: Tue, 11 Sep 2001 20:27:12 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: another set of ppc405_enet changes
Message-ID: <20010911202712.B8620@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oC1+HKm2/end4ao3"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii

I wanted to limit this patch to be just a rework of the static var's but I
ended up changing more things. I will attempt a summary of the changes.
I did not compile/fix the stuff ifdef'd out by default.

I attached the output from some runs with nttcp before and after the changes.
It does not appear like there is any noticable change in performace from these
changes. "-u" is for UDP "-r" is Rx'd on the 405GP Tx'd by my x86 box, "-t" is
Tx'd by the 405GP Rx'd by the x86.
One thing to look into would be the diff between UDP tx packets to the
number rx'd on the other side. I don't know where the packets are being dropped
now.

Config.ini changed to CONFIG_PPC405_ENET to be tristate instead of just bool.

Change NUM_RX to 32 and NUM_TX to 8. Doesn't change performace noticablely.
Moved probe1 code into init function.

kfree of private struct on module unload or failure to register netdevice.

Used skb->len instead of tail-head in places.

For both tx/rx eob int's clear reg first then loop through, instead of loop
clear, goto top of loop again.

Moved tx stat counts into tx eob from hard_xmit. In tx_eob moved netif_wake
outside of loop.

In rx_eob wait untill end of function to refill slots instead of after
each packet. Also did skb_put instead of += tail and len. Put in check
for dev_alloc_skb failure but still no recovery when OOM.

Orig--------------------
# ./nttcp-ppc -T  -u -r -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   36.75   24.11     89.1642    135.9104  100001   2721.10    4147.7
1409600000   36.75    3.10     89.1754   1057.0323  100003   2721.50   32259.0
# ./nttcp-ppc -T  -u -t -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   34.81   22.75     94.1400    144.0352  100003   2873.01    4395.7
1388304896   34.81    1.54     89.2353   2017.1683   94802   2723.27   61559.7
# ./nttcp-ppc -T   -t -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   46.71   44.44     70.1553     73.7354  100000   2140.97    2250.2
1409600000   46.71    6.79     70.1555    482.5920  288192   6170.12   42443.6
# ./nttcp-ppc -T   -r -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   44.21   42.45     74.1172     77.1920  100161   2265.52    2359.5
1409600000   44.21    2.01     74.1199   1630.2488  100000   2261.96   49751.2

With Patch--------------------

# ./nttcp-ppc -T -u -r -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   36.39   24.43     90.0534    134.1302  100001   2748.24    4093.4
1409600000   36.38    3.19     90.0617   1027.2100  100003   2748.55   31348.9
# ./nttcp-ppc -T -u -r -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   36.33   24.14     90.1953    135.7415  100001   2752.57    4142.5
1409600000   36.32    3.34     90.2083    981.0778  100003   2753.02   29941.0
# ./nttcp-ppc -T -u -t -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   34.81   20.59     94.1261    159.1452  100003   2872.59    4856.9
1386686976   34.82    1.77     88.8523   1747.7377   94407   2711.58   53337.3
# ./nttcp-ppc -T -t -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   46.22   41.92     70.8989     78.1679  100000   2163.66    2385.5
1409600000   46.22    6.35     70.8987    516.0315  287353   6217.33   45252.4
# ./nttcp-ppc -T -r -n 100000 192.168.1.5
     Bytes  Real s   CPU s Real-MBit/s  CPU-MBit/s   Calls  Real-C/s   CPU-C/s
l409600000   44.79   42.63     73.1577     76.8661  100099   2234.81    2348.1
1409600000   44.79    2.80     73.1578   1170.2857  100000   2232.60   35714.3


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="enet_2.diff"

diff -wur linux-bk/drivers/net/Config.in linux-bk-new/drivers/net/Config.in
--- linux-bk/drivers/net/Config.in	Tue Sep 11 01:30:43 2001
+++ linux-bk-new/drivers/net/Config.in	Tue Sep 11 16:17:04 2001
@@ -42,7 +42,7 @@
       tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
       tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
       if [ "$CONFIG_405GP" = "y" ]; then
-        bool '  PowerPC 405 on-chip ethernet' CONFIG_PPC405_ENET
+        tristate '  PowerPC 405 on-chip ethernet' CONFIG_PPC405_ENET
         if [ "$CONFIG_PPC405_ENET" = "y" ]; then
           int  '    PHY Address' CONFIG_PPC405_ENET_PHY_ADDR 1
           bool '    Include extended error messages' CONFIG_PPC405_ENET_ERROR_MSG n
diff -wur linux-bk/drivers/net/ppc405_enet.c linux-bk-new/drivers/net/ppc405_enet.c
--- linux-bk/drivers/net/ppc405_enet.c	Tue Sep 11 01:30:39 2001
+++ linux-bk-new/drivers/net/ppc405_enet.c	Tue Sep 11 20:49:12 2001
@@ -55,11 +55,10 @@

 #include "ppc405_enet.h"

-static int	ppc405_enet_probe1(struct net_device *);
-static int	ppc405_phy_speed(void);
-static int	ppc405_phy_duplex(void);
-static int	ppc405_phy_read(unsigned char, unsigned short *);
-static int	ppc405_phy_dump(char *log_level);
+static int	ppc405_phy_speed(struct net_device *);
+static int	ppc405_phy_duplex(struct net_device *);
+static int	ppc405_phy_read(struct net_device *, unsigned char, unsigned short *);
+static int	ppc405_phy_dump(struct net_device *, char *log_level);
 static int	ppc405_enet_open(struct net_device *);
 static int	ppc405_enet_start_xmit(struct sk_buff *, struct net_device *);
 static struct net_device_stats *ppc405_enet_stats(struct net_device *);
@@ -82,19 +81,6 @@

 static unsigned long crc32(char *, int);

-/* Physical mapping of ethernet register space. */
-static struct	ppc405_enet_regs *ppc405_enet_regp =
-			(struct ppc405_enet_regs *)PPC405_EM0_REG_ADDR;
-
-/* structures to define the ring buffer access. */
-static mal_desc_t	*ppc405_enet_tx;
-static mal_desc_t	*ppc405_enet_rx;
-static struct sk_buff	*ppc405_skb_rx[NUM_RX_BUFF];
-
-static volatile int	ppc405_enet_tx_slot = 0;
-static volatile int	ppc405_enet_ack_slot = 0;
-static volatile int	ppc405_enet_rx_slot = 0;
-
 static struct net_device ppc405_enet_dev;

 static int
@@ -106,8 +92,6 @@
 	dma_addr_t rx_phys_addr;
 	dma_addr_t tx_phys_addr;
 	unsigned long emac_ier;
-	unsigned short ctrl;
-

 	emac_ier = 0;

@@ -117,10 +101,10 @@
 	mtdcr(DCRN_MALCR, MALCR_MMSR);

 	/* Reset the EMAC */
-	ppc405_enet_regp->em0mr0 = EMAC_M0_SRST;
+	lo_priv->regp->em0mr0 = EMAC_M0_SRST;
 	eieio();
 	for (loop = 0; loop < 1000; loop++);
-	ppc405_enet_regp->em0mr0 = ppc405_enet_regp->em0mr0 & ~EMAC_M0_SRST;
+	lo_priv->regp->em0mr0 = lo_priv->regp->em0mr0 & ~EMAC_M0_SRST;
 	eieio();


@@ -132,41 +116,38 @@
 	 * address.
 	 */

-
-	ppc405_enet_tx = (mal_desc_t *) consistent_alloc(GFP_KERNEL, PAGE_SIZE,
+	lo_priv->tx_desc = (mal_desc_t *) consistent_alloc(GFP_KERNEL, PAGE_SIZE,
 						&tx_phys_addr);

-	ppc405_enet_rx = (mal_desc_t *) consistent_alloc(GFP_KERNEL, PAGE_SIZE,
+	lo_priv->rx_desc = (mal_desc_t *) consistent_alloc(GFP_KERNEL, PAGE_SIZE,
 						&rx_phys_addr);

 	/* Fill in the transmit descriptor ring.  */
 	for (loop = 0; loop < NUM_TX_BUFF; loop++) {
-		ctrl = 0;
-		if ((NUM_TX_BUFF - 1) == loop)
-			ctrl |= MAL_TX_CTRL_WRAP;
-		ppc405_enet_tx[loop].ctrl     = ctrl;
-		ppc405_enet_tx[loop].data_len = 0;
-		ppc405_enet_tx[loop].data_ptr = NULL;
+		lo_priv->tx_desc[loop].ctrl	= 0;
+		lo_priv->tx_desc[loop].data_len = 0;
+		lo_priv->tx_desc[loop].data_ptr = NULL;
+		lo_priv->tx_skb[loop] = (struct sk_buff *)NULL;
 	}
+	lo_priv->tx_desc[loop-1].ctrl	  |= MAL_TX_CTRL_WRAP;

 	/* Format the receive descriptor ring. */
 	for (loop = 0; loop < NUM_RX_BUFF; loop++) {
-		ctrl =  MAL_RX_CTRL_EMPTY | MAL_RX_CTRL_INTR;
-		if ((NUM_RX_BUFF - 1) == loop)
-			ctrl |= MAL_RX_CTRL_WRAP;
-		ppc405_skb_rx[loop]           = dev_alloc_skb(DESC_BUF_SIZE);
-		ppc405_enet_rx[loop].data_len = 0;
-		ppc405_enet_rx[loop].data_ptr =
-				(char *)virt_to_phys(ppc405_skb_rx[loop]->data);
-		ppc405_enet_rx[loop].ctrl     =  ctrl;
+		lo_priv->rx_skb[loop]		= dev_alloc_skb(DESC_BUF_SIZE);
+		lo_priv->rx_desc[loop].data_len = 0;
+		lo_priv->rx_desc[loop].data_ptr =
+				(char *)virt_to_phys(lo_priv->rx_skb[loop]->data);
+		lo_priv->rx_desc[loop].ctrl	=  MAL_RX_CTRL_EMPTY | MAL_RX_CTRL_INTR;

 		dma_cache_wback_inv((unsigned long)
-				ppc405_skb_rx[loop]->data, DESC_BUF_SIZE);
+				lo_priv->rx_skb[loop]->data, DESC_BUF_SIZE);
 	}
+	lo_priv->rx_desc[loop-1].ctrl	 |= MAL_RX_CTRL_WRAP;

-	ppc405_enet_rx_slot  = 0;
-	ppc405_enet_tx_slot  = 0;
-	ppc405_enet_ack_slot = 0;
+	lo_priv->tx_cnt = 0;
+	lo_priv->rx_slot    = 0;
+	lo_priv->tx_slot    = 0;
+	lo_priv->tx_ack_slot   = 0;

 	/* setup MAL tx and rx channel pointers */
 	mtdcr(DCRN_MALTXCTP0R, tx_phys_addr);
@@ -186,11 +167,11 @@
 	request_irq(15, &ppc405_eth_mac  ,  0, "405eth MAC",      dev);

 	/* set the high address */
-	ppc405_enet_regp->em0iahr = (dev->dev_addr[0] << 8) | dev->dev_addr[1];
+	lo_priv->regp->em0iahr = (dev->dev_addr[0] << 8) | dev->dev_addr[1];
 	eieio();

 	/* set the low address */
-	ppc405_enet_regp->em0ialr =
+	lo_priv->regp->em0ialr =
 		      (dev->dev_addr[2] << 24)
 	            | (dev->dev_addr[3] << 16)
 		    | (dev->dev_addr[4] <<  8)
@@ -216,36 +197,27 @@
 	if( lo_priv->ep_duplex == FULL)
 		mode_reg = mode_reg | EMAC_M1_FDE | EMAC_M1_EIFC;

-	ppc405_enet_regp->em0mr1 = mode_reg;
+	lo_priv->regp->em0mr1 = mode_reg;
 	eieio();

 	/* enable broadcast and individual address */
-	ppc405_enet_regp->em0rmr = EMAC_RMR_IAE | EMAC_RMR_BAE;
+	lo_priv->regp->em0rmr = EMAC_RMR_IAE | EMAC_RMR_BAE;
 	eieio();

 	/* set transmit request threshold register */
-	ppc405_enet_regp->em0trtr = EMAC_TRTR_256;
+	lo_priv->regp->em0trtr = EMAC_TRTR_256;

 	eieio();
 	/* set receive low/high water mark register */
-	ppc405_enet_regp->em0rwmr = 0x0f002000;
+	lo_priv->regp->em0rwmr = 0x0f002000;
 	eieio();

 	/* set frame gap */
-	ppc405_enet_regp->em0ipgvr = CONFIG_PPC405_ENET_GAP;
+	lo_priv->regp->em0ipgvr = CONFIG_PPC405_ENET_GAP;
 	eieio();

 	netif_start_queue(dev);

-	for (loop = 0; loop < NUM_TX_BUFF; loop++) {
-		lo_priv->ep_xmit_skb[loop] = (struct sk_buff *)NULL;
-	}
-
-	lo_priv->ep_xmit_pend         = (struct ppc405_skb_list *)NULL;
-	lo_priv->ep_xmit_pend_cnt     = 0;
-	lo_priv->ep_xmit_active_count = 0;
-
-
 	/* set the MAL IER */
 	mtdcr(DCRN_MALIER, MALIER_DE |
 			MALIER_NE | MALIER_TE | MALIER_OPBE | MALIER_PLBE);
@@ -255,7 +227,7 @@
 		   EMAC_ISR_PTLE | EMAC_ISR_BFCS |
 		   EMAC_ISR_ORE  | EMAC_ISR_IRE;

-	ppc405_enet_regp->em0iser = emac_ier;
+	lo_priv->regp->em0iser = emac_ier;
 	eieio();

 	/* enable MAL transmit channel 0 and receive channel 0 */
@@ -263,7 +235,7 @@
 	mtdcr(DCRN_MALTXCASR, 0x80000000);

 	/* set transmit and receive enable */
-	ppc405_enet_regp->em0mr0 = EMAC_M0_TXE | EMAC_M0_RXE;
+	lo_priv->regp->em0mr0 = EMAC_M0_TXE | EMAC_M0_RXE;
 	eieio();

 	printk(KERN_NOTICE "%s: PPC405 Enet open completed\n", dev->name);
@@ -276,7 +248,6 @@
 ppc405_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned short			ctrl;
-	int				frame_length;
 	unsigned long			flags;
 	struct ppc405_enet_private	*lo_priv;

@@ -287,7 +258,7 @@
 	cli();

 	if (netif_queue_stopped(dev) ||
-			(lo_priv->ep_xmit_active_count == NUM_TX_BUFF)) {
+			(lo_priv->tx_cnt == NUM_TX_BUFF)) {

 		lo_priv->ep_stats.tx_dropped++;

@@ -296,34 +267,29 @@
 		return -EBUSY;
 	}

-	frame_length = (int)(skb->tail - skb->data);
-
-	if (++lo_priv->ep_xmit_active_count == NUM_TX_BUFF)
+	if (++lo_priv->tx_cnt == NUM_TX_BUFF)
 		netif_stop_queue(dev);

 	/* Store the skb buffer for later ack by the transmit end of buffer
 	 * interrupt.
 	 */
-	lo_priv->ep_xmit_skb[ppc405_enet_tx_slot] = skb;
+	lo_priv->tx_skb[lo_priv->tx_slot] = skb;

-	dma_cache_wback_inv((unsigned long)skb->data, frame_length);
+	dma_cache_wback_inv((unsigned long)skb->data, skb->len);

 	ctrl = EMAC_TX_CTRL_DFLT;
-	if ((NUM_TX_BUFF - 1) == ppc405_enet_tx_slot)
+	if ((NUM_TX_BUFF - 1) == lo_priv->tx_slot)
 		ctrl |= MAL_TX_CTRL_WRAP;

-	ppc405_enet_tx[ppc405_enet_tx_slot].data_ptr = (char *)virt_to_phys(skb->data);
-	ppc405_enet_tx[ppc405_enet_tx_slot].data_len = (short)frame_length;
-	ppc405_enet_tx[ppc405_enet_tx_slot].ctrl     = ctrl;
+	lo_priv->tx_desc[lo_priv->tx_slot].data_ptr = (char *)virt_to_phys(skb->data);
+	lo_priv->tx_desc[lo_priv->tx_slot].data_len = (short)skb->len;
+	lo_priv->tx_desc[lo_priv->tx_slot].ctrl	    = ctrl;

 	/* Send the packet out. */
-	ppc405_enet_regp->em0tmr0 = EMAC_TXM0_GNP0;
+	lo_priv->regp->em0tmr0 = EMAC_TXM0_GNP0;

-	if(++ppc405_enet_tx_slot == NUM_TX_BUFF)
-		ppc405_enet_tx_slot = 0;
-
-	lo_priv->ep_stats.tx_packets++;
-	lo_priv->ep_stats.tx_bytes += frame_length;
+	lo_priv->tx_slot =
+		(lo_priv->tx_slot + 1) % NUM_TX_BUFF;

 	restore_flags(flags);

@@ -334,6 +300,7 @@
 static int
 ppc405_enet_close(struct net_device *dev)
 {
+	struct ppc405_enet_private *lo_priv = dev->priv;
 	int delay;

 	/* Free the irq's */
@@ -348,21 +315,21 @@
 	/* reset the MAL and EMAC */
 	mtdcr(DCRN_MALCR, MALCR_MMSR);

-        ppc405_enet_regp->em0mr0 = EMAC_M0_SRST;
+	lo_priv->regp->em0mr0 = EMAC_M0_SRST;
 	eieio();

         for (delay = 0; delay < 1000; delay++);

-        ppc405_enet_regp->em0mr0 = ppc405_enet_regp->em0mr0 & ~EMAC_M0_SRST;
+	lo_priv->regp->em0mr0 = lo_priv->regp->em0mr0 & ~EMAC_M0_SRST;
 	eieio();

 	/*
 	 * Unmap the non cached memory space.
 	 */
-	//iounmap((void *)ppc405_enet_tx);
-	//iounmap((void *)ppc405_enet_rx);
-	consistent_free((void *)ppc405_enet_tx, PAGE_SIZE);
-	consistent_free((void *)ppc405_enet_rx, PAGE_SIZE);
+
+	consistent_free((void *)lo_priv->tx_desc, PAGE_SIZE);
+	consistent_free((void *)lo_priv->rx_desc, PAGE_SIZE);
+
 	/*
 	 * revisit
 	 * need to free memory allocated by get_free_page()
@@ -380,6 +347,7 @@
 static void
 ppc405_enet_set_multicast_list(struct net_device *dev)
 {
+	struct ppc405_enet_private *lo_priv = dev->priv;
 	struct dev_mc_list *dmi = dev->mc_list;
 	unsigned char *mc_addr;
 	unsigned long mc_crc;
@@ -388,14 +356,14 @@

 	/* If promiscuous mode is set then we do not need anything else */
 	if (dev->flags & IFF_PROMISC) {
-		ppc405_enet_regp->em0rmr = EMAC_RMR_PME;
+		lo_priv->regp->em0rmr = EMAC_RMR_PME;
 		eieio();
 		return;
 	}

 	/* If multicast mode is not set then we are turning it off at this point */
 	if (!(dev->flags & IFF_MULTICAST)) {
-		ppc405_enet_regp->em0rmr = EMAC_RMR_IAE | EMAC_RMR_BAE;
+		lo_priv->regp->em0rmr = EMAC_RMR_IAE | EMAC_RMR_BAE;
 		eieio();
 		return;
 	}
@@ -404,13 +372,13 @@
 	 * multicast
 	 */
 	if (dev->flags & IFF_ALLMULTI) {
-		ppc405_enet_regp->em0rmr |= EMAC_RMR_PMME;
+		lo_priv->regp->em0rmr |= EMAC_RMR_PMME;
 		eieio();
 		return;
 	}

 	/* Turn on multicast addressing */
-	ppc405_enet_regp->em0rmr |= EMAC_RMR_MAE;
+	lo_priv->regp->em0rmr |= EMAC_RMR_MAE;

 	/* Need to hash on the multicast address. */
 	for (dmi_count = 0; dmi_count < dev->mc_count; dmi_count++) {
@@ -422,20 +390,20 @@

 			switch (bit_number & 0x30) {  /* determine the group register */
 			case 0x00:
-				ppc405_enet_regp->em0gaht1 =
-						ppc405_enet_regp->em0gaht1 | (0x8000 >> bit_number);
+				lo_priv->regp->em0gaht1 =
+						lo_priv->regp->em0gaht1 | (0x8000 >> bit_number);
 				break;
 			case 0x10:
-				ppc405_enet_regp->em0gaht2 =
-						ppc405_enet_regp->em0gaht2 | (0x8000 >> bit_number);
+				lo_priv->regp->em0gaht2 =
+						lo_priv->regp->em0gaht2 | (0x8000 >> bit_number);
 				break;
 			case 0x20:
-				ppc405_enet_regp->em0gaht3 =
-						ppc405_enet_regp->em0gaht3 | (0x8000 >> bit_number);
+				lo_priv->regp->em0gaht3 =
+						lo_priv->regp->em0gaht3 | (0x8000 >> bit_number);
 				break;
 			case 0x30:
-				ppc405_enet_regp->em0gaht4 =
-						ppc405_enet_regp->em0gaht4 | (0x8000 >> bit_number);
+				lo_priv->regp->em0gaht4 =
+						lo_priv->regp->em0gaht4 | (0x8000 >> bit_number);
 				break;
 			}
 		}
@@ -455,73 +423,14 @@


 static int
-ppc405_enet_probe1(struct net_device *dev)
-{
-	int	delay, i;
-	bd_t	*bd;
-	struct ppc405_enet_private *lo_priv;
-
-	/* Reset the MAL */
-	mtdcr(DCRN_MALCR, MALCR_MMSR);
-
-	/* Reset the EMAC */
-	ppc405_enet_regp->em0mr0 = EMAC_M0_SRST;
-	eieio();
-	for (delay = 0; delay < 1000; delay++);
-	ppc405_enet_regp->em0mr0 = ppc405_enet_regp->em0mr0 & ~EMAC_M0_SRST;
-	eieio();
-
-	/* read the MAC Address */
-	bd = (bd_t *)__res;
-	for (i=0; i<6; i++) {
-		dev->dev_addr[i] = bd->bi_enetaddr[i];
-	}
-
-	dev->base_addr = 0xffe0;  /* indicate no actual physical probing */
-	dev->irq = BL_MAC0_WOL;   /* the first ethernet irq - need something here */
-
-	/* initialize the private data pointer */
-	lo_priv = (void *)(((long)kmalloc(
-		sizeof(struct ppc405_enet_private),
-		GFP_KERNEL | GFP_DMA) + 7) & ~7);
-	memset(lo_priv, 0, sizeof(struct ppc405_enet_private));
-	dev->priv = lo_priv;
-
-	/* Find out the default network settings from the phy */
-	lo_priv->ep_speed  = ppc405_phy_speed();
-	lo_priv->ep_duplex = ppc405_phy_duplex();
-
-	printk(KERN_NOTICE "%s: PPC405 EMAC %d Mbs %s duplex ",
-			dev->name, lo_priv->ep_speed,
-			(lo_priv->ep_duplex == HALF)? "Half": "Full");
-
-	/* no KERN_NOTICE, this continues previous printk */
-	printk("MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
-			dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
-			dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
-
-	/* Fill in the driver function table */
-	dev->open               = &ppc405_enet_open;
-	dev->hard_start_xmit    = &ppc405_enet_start_xmit;
-	dev->stop               = &ppc405_enet_close;
-	dev->get_stats          = &ppc405_enet_stats;
-	dev->set_multicast_list = &ppc405_enet_set_multicast_list;
-
-	/* Fill in the generic fields of the device structure. */
-	ether_setup(dev);
-	return 0;
-}
-
-
-static int
-ppc405_phy_speed(void)
+ppc405_phy_speed(struct net_device *dev)
 {
 	int speed = _10BASET;
 	unsigned short bmcr = 0x0;

-	if (ppc405_phy_read(PHY_BMCR, &bmcr)) {
+	if (ppc405_phy_read(dev, PHY_BMCR, &bmcr)) {
 		printk(KERN_ERR "phy speed read failed \n");
-		ppc405_phy_dump(KERN_ERR);
+		ppc405_phy_dump(dev, KERN_ERR);
 	}

 	if ((bmcr & PHY_BMCR_100MB) != 0) {
@@ -533,14 +442,14 @@


 static int
-ppc405_phy_duplex(void)
+ppc405_phy_duplex(struct net_device *dev)
 {
 	int duplex = HALF;          /* Assume HALF */
 	unsigned short bmcr = 0x0;

-	if (ppc405_phy_read(PHY_BMCR,&bmcr)) {
+	if (ppc405_phy_read(dev, PHY_BMCR,&bmcr)) {
 		printk(KERN_ERR "phy duplex read failed \n\r");
-		ppc405_phy_dump(KERN_ERR);
+		ppc405_phy_dump(dev, KERN_ERR);
 	}

 	if ((bmcr & PHY_BMCR_DPLX) != 0)
@@ -551,13 +460,14 @@


 static int
-ppc405_phy_read(unsigned char reg, unsigned short * value)
+ppc405_phy_read(struct net_device *dev, unsigned char reg, unsigned short * value)
 {
+	struct ppc405_enet_private *lo_priv = dev->priv;
 	unsigned long i;
 	unsigned long sta_reg;

 	/* Wait for data transfer complete bit */
-	while ((ppc405_enet_regp->em0stacr & EMAC_STACR_OC) == 0) {
+	while ((lo_priv->regp->em0stacr & EMAC_STACR_OC) == 0) {
 		udelay(7);
 		if (i == 5) {
 			return -1;
@@ -570,15 +480,15 @@
 	sta_reg = (sta_reg | EMAC_STACR_READ) & ~EMAC_STACR_CLK_100MHZ;
 	sta_reg = sta_reg | (PHY_ADDR << 5);

-	ppc405_enet_regp->em0stacr = sta_reg;
+	lo_priv->regp->em0stacr = sta_reg;
 	eieio();

-	sta_reg = ppc405_enet_regp->em0stacr;
+	sta_reg = lo_priv->regp->em0stacr;
 	eieio();
 	i = 0;

 	/* Wait for data transfer complete bit */
-	while (((sta_reg = ppc405_enet_regp->em0stacr) & EMAC_STACR_OC) == 0) {
+	while (((sta_reg = lo_priv->regp->em0stacr) & EMAC_STACR_OC) == 0) {
 		udelay(7);
 		if (i == 5) {
 			return -1;
@@ -597,13 +507,13 @@


 static int
-ppc405_phy_dump(char *log_level)
+ppc405_phy_dump(struct net_device *dev, char *log_level)
 {
 	unsigned long i;
 	unsigned short data;

 	for (i = 0; i < 0x1A; i++) {
-		if (ppc405_phy_read(i, &data)) {
+		if (ppc405_phy_read(dev, i, &data)) {
 			return -1;
 		}

@@ -709,65 +619,36 @@
 ppc405_eth_txeob(int irq, void *dev_instance, struct pt_regs *regs)
 {
 	struct net_device		*dev;
-	int				first_time;
 	struct ppc405_enet_private	*lo_priv;


 	dev        = (struct net_device *)dev_instance;
 	lo_priv    = dev->priv;
-	first_time = 1;
-
-do_it_again:

-	while (lo_priv->ep_xmit_active_count &&
-		!(ppc405_enet_tx[ppc405_enet_ack_slot].ctrl & MAL_TX_CTRL_READY)) {
+		/* Clear the interrupt bits. */
+	mtdcr(DCRN_MALTXEOBISR, mfdcr(DCRN_MALTXEOBISR));

-		/* Tell the system the transmit completed. */
-		dev_kfree_skb_irq(lo_priv->ep_xmit_skb[ppc405_enet_ack_slot]);
+	while (lo_priv->tx_cnt &&
+		!(lo_priv->tx_desc[lo_priv->tx_ack_slot].ctrl & MAL_TX_CTRL_READY)) {

-		if (ppc405_enet_tx[ppc405_enet_ack_slot].ctrl &
+		if (lo_priv->tx_desc[lo_priv->tx_ack_slot].ctrl &
 		    (EMAC_TX_ST_EC | EMAC_TX_ST_MC | EMAC_TX_ST_SC)
 		   ) {
 			lo_priv->ep_stats.collisions++;
 		}
+		lo_priv->ep_stats.tx_packets++;
+		lo_priv->ep_stats.tx_bytes += lo_priv->tx_skb[lo_priv->tx_ack_slot]->len;

-		lo_priv->ep_xmit_skb[ppc405_enet_ack_slot] = (struct sk_buff *)NULL;
-		if (++ppc405_enet_ack_slot == NUM_TX_BUFF)
-			ppc405_enet_ack_slot = 0;
-
-		lo_priv->ep_xmit_active_count--;
-
-		netif_wake_queue(dev);
-	}
-
-	/*
-	** Don't stay stuck in this handler forever.
-	** The first time through:
-	**   Acknowledge the interrupt from the MAL.
-	**   If another interrupt has come in, go back and process it.
-	**   (Otherwise, return; the interrupt has been cleared in the device.)
-	** The second time through:
-	**   Don't acknowledge the interrupt from the MAL, just return.
-	**   If another interrupt has come in, ignore it.
-	**   Didn't acknowledge the interrupt.  That means the UIC interrupt
-	**     will be reasserted as soon as it is acknowledged and we'll end
-	**     up in this handler again soon (possibly with no new data to
-	**     process).  But, in the meantime, other interrupt handlers will
-	**     have had a shot at the cpu.
-	*/
-	if (first_time) {
+		/* Tell the system the transmit completed. */
+		dev_kfree_skb_irq(lo_priv->tx_skb[lo_priv->tx_ack_slot]);

-		/* Clear the interrupt bits. */
-		mtdcr(DCRN_MALTXEOBISR, mfdcr(DCRN_MALTXEOBISR));
+		lo_priv->tx_skb[lo_priv->tx_ack_slot] = (struct sk_buff *)NULL;
+		lo_priv->tx_ack_slot =
+			(lo_priv->tx_ack_slot + 1) % NUM_TX_BUFF;

-		/* make sure no interrupt gets lost */
-		if (lo_priv->ep_xmit_active_count &&
-		    !(ppc405_enet_tx[ppc405_enet_ack_slot].ctrl & MAL_TX_CTRL_READY)
-		   ) {
-			first_time = 0;
-			goto do_it_again;
-		}
+		lo_priv->tx_cnt--;
 	}
+	netif_wake_queue(dev);

 	return;
 }
@@ -778,22 +659,22 @@
 {
 	struct net_device		*dev;
 	int				error;
-	int				first_time;
 	int				frame_length;
 	struct ppc405_enet_private	*lo_priv;
 	mal_desc_t			*rx_desc;
 	struct sk_buff			*skb_rx;
-	struct sk_buff			**skb_rx_p;
+	int				fill;


 	dev          = (struct net_device *)dev_instance;
 	lo_priv      = dev->priv;
-	first_time   = 1;
 	frame_length = 0;

-do_it_again:
+	/* Ack the interrupt bits */
+	mtdcr(DCRN_MALRXEOBISR, mfdcr(DCRN_MALRXEOBISR));

-	rx_desc = &ppc405_enet_rx[ppc405_enet_rx_slot];
+	fill	= lo_priv->rx_slot;
+	rx_desc = &lo_priv->rx_desc[lo_priv->rx_slot];

 	while (!(rx_desc->ctrl & MAL_RX_CTRL_EMPTY)) {

@@ -820,11 +701,10 @@

 			frame_length     = rx_desc->data_len;

-			skb_rx_p = &ppc405_skb_rx[ppc405_enet_rx_slot];
-			skb_rx   = *skb_rx_p;
+			skb_rx = lo_priv->rx_skb[lo_priv->rx_slot];
+			lo_priv->rx_skb[lo_priv->rx_slot] = 0;

-			skb_rx->tail    += frame_length;
-			skb_rx->len     += frame_length;
+			skb_put( skb_rx, frame_length );
 			skb_rx->dev      = dev;
 			skb_rx->protocol = eth_type_trans(skb_rx, dev);

@@ -833,52 +713,31 @@
 			if ((error == NET_RX_DROP) || (error == NET_RX_BAD))
 				lo_priv->ep_stats.rx_dropped++;

-			*skb_rx_p = dev_alloc_skb(DESC_BUF_SIZE);
-			skb_rx    = *skb_rx_p;
-			dma_cache_wback_inv((unsigned long)skb_rx->data, DESC_BUF_SIZE);
-
-			rx_desc->data_ptr = (char *)virt_to_phys(skb_rx->data);
-
 			lo_priv->ep_stats.rx_packets++;
 			lo_priv->ep_stats.rx_bytes += frame_length;
 		}


-		rx_desc->ctrl |= MAL_RX_CTRL_EMPTY;

-		if(++ppc405_enet_rx_slot >= NUM_RX_BUFF )
-			ppc405_enet_rx_slot = 0;
+		lo_priv->rx_slot =
+			(lo_priv->rx_slot + 1) % NUM_RX_BUFF;

-		rx_desc = &ppc405_enet_rx[ppc405_enet_rx_slot];
+		rx_desc = &lo_priv->rx_desc[lo_priv->rx_slot];
 	}
-
-	/*
-	** Don't stay stuck in this handler forever.
-	** The first time through:
-	**   Acknowledge the interrupt from the MAL.
-	**   If another interrupt has come in, go back and process it.
-	**   (Otherwise, return; the interrupt has been cleared in the device.)
-	** The second time through:
-	**   Don't acknowledge the interrupt from the MAL, just return.
-	**   If another interrupt has come in, ignore it.
-	**   Didn't acknowledge the interrupt.  That means the UIC interrupt
-	**     will be reasserted as soon as it is acknowledged and we'll end
-	**     up in this handler again soon (possibly with no new data to
-	**     process).  But, in the meantime, other interrupt handlers will
-	**     have had a shot at the cpu.
-	*/
-	if (first_time) {
-
-		/* Ack the interrupt bits */
-		mtdcr(DCRN_MALRXEOBISR, mfdcr(DCRN_MALRXEOBISR));
-
-		/* make sure no interrupt gets lost */
-		if (!(rx_desc->ctrl & MAL_RX_CTRL_EMPTY)) {
-			first_time = 0;
-			goto do_it_again;
+	while( fill != lo_priv->rx_slot ){
+		if( lo_priv->rx_skb[fill] == 0 ){
+			lo_priv->rx_skb[fill] = dev_alloc_skb(DESC_BUF_SIZE);
+			if( lo_priv->rx_skb[fill] == 0 ){
+				printk( KERN_ERR "%s: PPC405 Enet OOM doesn't cope well\n", dev->name );
+				return;
 		}
+			dma_cache_wback_inv((unsigned long)lo_priv->rx_skb[fill]->data, DESC_BUF_SIZE);
+		}
+		lo_priv->rx_desc[fill].data_ptr =
+			(char *)virt_to_phys(lo_priv->rx_skb[fill]->data);
+		lo_priv->rx_desc[fill].ctrl    |= MAL_RX_CTRL_EMPTY;
+		fill = (fill+1) % NUM_RX_BUFF;
 	}
-
 	return;
 }

@@ -914,26 +773,26 @@
 	 * Move descriptor entries to the beginning of the table.
 	 */

-	lo_priv->ep_xmit_active_count = 0;
-	k                             = ppc405_enet_ack_slot;
-	ppc405_enet_ack_slot          = 0;
-	ppc405_enet_tx_slot           = 0;
+	lo_priv->tx_cnt		      = 0;
+	k			      = lo_priv->tx_ack_slot;
+	lo_priv->tx_ack_slot	      = 0;
+	lo_priv->tx_slot	      = 0;

 	for (loop = 0; loop < NUM_TX_BUFF;loop++) {
-		if (ppc405_enet_tx[k].ctrl & MAL_TX_CTRL_READY) {
-			lo_priv->ep_xmit_active_count++;
-			tmp_desc[loop].ctrl     = ppc405_enet_tx[k].ctrl;
-			tmp_desc[loop].data_len = ppc405_enet_tx[k].data_len;
-			tmp_desc[loop].data_ptr = ppc405_enet_tx[k].data_ptr;
+		if (lo_priv->tx_desc[k].ctrl & MAL_TX_CTRL_READY) {
+			lo_priv->tx_cnt++;
+			tmp_desc[loop].ctrl	= lo_priv->tx_desc[k].ctrl;
+			tmp_desc[loop].data_len = lo_priv->tx_desc[k].data_len;
+			tmp_desc[loop].data_ptr = lo_priv->tx_desc[k].data_ptr;
 			if (++k == NUM_TX_BUFF)
 				k = 0;
 		}
 	}

 	for (loop = 0; loop < NUM_TX_BUFF;loop++) {
-		ppc405_enet_tx[loop].ctrl     = tmp_desc[loop].ctrl;
-		ppc405_enet_tx[loop].data_len = tmp_desc[loop].data_len;
-		ppc405_enet_tx[loop].data_ptr = tmp_desc[loop].data_ptr;
+		lo_priv->tx_desc[loop].ctrl	= tmp_desc[loop].ctrl;
+		lo_priv->tx_desc[loop].data_len = tmp_desc[loop].data_len;
+		lo_priv->tx_desc[loop].data_ptr = tmp_desc[loop].data_ptr;
 	}


@@ -981,36 +840,35 @@
 	ppc405_eth_desc_dump(KERN_DEBUG);
 #endif

-	loop = ppc405_enet_rx_slot;
-	end  = ppc405_enet_rx_slot;
+	loop = end = lo_priv->rx_slot;

 	if (end == -1)
 			end = NUM_RX_BUFF - 1;

 	do {
 		/*  If this descriptor not marked empty */
-		if (!(ppc405_enet_rx[loop].ctrl & MAL_RX_CTRL_EMPTY)) {
+		if (!(lo_priv->rx_desc[loop].ctrl & MAL_RX_CTRL_EMPTY)) {
 			/* Send the skb up the chain. */
-			frame_length = ppc405_enet_rx[loop].data_len;
-			ppc405_skb_rx[loop]->tail += frame_length;
-			ppc405_skb_rx[loop]->len  += frame_length;
-
-			ppc405_skb_rx[loop]->dev = dev;
-			ppc405_skb_rx[loop]->protocol =
-					eth_type_trans(ppc405_skb_rx[loop], dev);
+			frame_length = lo_priv->rx_desc[loop].data_len;
+			lo_priv->rx_skb[loop]->tail += frame_length;
+			lo_priv->rx_skb[loop]->len  += frame_length;
+
+			lo_priv->rx_skb[loop]->dev = dev;
+			lo_priv->rx_skb[loop]->protocol =
+					eth_type_trans(lo_priv->rx_skb[loop], dev);

-			netif_rx(ppc405_skb_rx[loop]);
+			netif_rx(lo_priv->rx_skb[loop]);

 			/* Allocate the next skb */
-			ppc405_skb_rx[loop] = dev_alloc_skb(DESC_BUF_SIZE);
-			ppc405_enet_rx[loop].data_ptr =
-					(char *)virt_to_phys(ppc405_skb_rx[loop]->data);
+			lo_priv->rx_skb[loop] = dev_alloc_skb(DESC_BUF_SIZE);
+			lo_priv->rx_desc[loop].data_ptr =
+					(char *)virt_to_phys(lo_priv->rx_skb[loop]->data);
 			dma_cache_wback_inv((unsigned long)
-					ppc405_skb_rx[loop]->data, DESC_BUF_SIZE);
+					lo_priv->rx_skb[loop]->data, DESC_BUF_SIZE);
 		}

 		/* Reset the control bits for every descriptor */
-		ppc405_enet_rx[loop].ctrl |= MAL_RX_CTRL_EMPTY;
+		lo_priv->rx_desc[loop].ctrl |= MAL_RX_CTRL_EMPTY;

 		if (++loop >= NUM_RX_BUFF)
 			loop = 0;
@@ -1019,7 +877,7 @@
 	/* The manual states that when the interface is stoped and restarted
 	 * it resets processing to the first descriptor in the table.
 	 */
-	ppc405_enet_rx_slot = 0;
+	lo_priv->rx_slot = 0;

 	/* Reenable the receive channel */
 	mtdcr(DCRN_MALRXCASR, 0x80000000);
@@ -1043,7 +901,7 @@
 	dev     = (struct net_device *)dev_instance;
 	lo_priv = dev->priv;

-	tmp_em0isr  = ppc405_enet_regp->em0isr;
+	tmp_em0isr  = lo_priv->regp->em0isr;

 	if (tmp_em0isr & (EMAC_ISR_TE0 | EMAC_ISR_TE1)) {
 		/* This error is a hard transmit error - could retransmit */
@@ -1125,7 +983,7 @@
 	ppc405_eth_mal_dump(KERN_DEBUG);
 #endif

-	ppc405_enet_regp->em0isr = tmp_em0isr;
+	lo_priv->regp->em0isr = tmp_em0isr;
 	eieio();
 }

@@ -1137,14 +995,14 @@
 	int curr_slot;

 	printk("%s\ndumping the receive descriptors:  current slot is %d\n",
-		log_level, ppc405_enet_rx_slot);
+		log_level, rx_slot);
 	for (curr_slot = 0; curr_slot < NUM_RX_BUFF; curr_slot++) {
 		printk("%sDesc %02d: status 0x%04x, length %3d, addr 0x%x\n",
 			log_level,
 			curr_slot,
-			ppc405_enet_rx[curr_slot].ctrl,
-			ppc405_enet_rx[curr_slot].data_len,
-			(unsigned int)ppc405_enet_rx[curr_slot].data_ptr);
+			rx_desc[curr_slot].ctrl,
+			rx_desc[curr_slot].data_len,
+			(unsigned int)rx_desc[curr_slot].data_ptr);
 	}
 }

@@ -1153,26 +1011,26 @@
 ppc405_eth_emac_dump(char *log_level)
 {
 	printk("%sEMAC DEBUG ********** \n", log_level);
-	printk("%sEMAC_M0  ==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0mr0);
+	printk("%sEMAC_M0  ==> 0x%x\n", log_level, (unsigned int)regp->em0mr0);
 	eieio();
-	printk("%sEMAC_M1  ==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0mr1);
+	printk("%sEMAC_M1  ==> 0x%x\n", log_level, (unsigned int)regp->em0mr1);
 	eieio();
-	printk("%sEMAC_TXM0==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0tmr0);
+	printk("%sEMAC_TXM0==> 0x%x\n", log_level, (unsigned int)regp->em0tmr0);
 	eieio();
-	printk("%sEMAC_TXM1==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0tmr1);
+	printk("%sEMAC_TXM1==> 0x%x\n", log_level, (unsigned int)regp->em0tmr1);
 	eieio();
-	printk("%sEMAC_RXM ==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0rmr);
+	printk("%sEMAC_RXM ==> 0x%x\n", log_level, (unsigned int)regp->em0rmr);
 	eieio();
-	printk("%sEMAC_ISR ==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0isr);
+	printk("%sEMAC_ISR ==> 0x%x\n", log_level, (unsigned int)regp->em0isr);
 	eieio();
-	printk("%sEMAC_IER ==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0iser);
+	printk("%sEMAC_IER ==> 0x%x\n", log_level, (unsigned int)regp->em0iser);
 	eieio();
-	printk("%sEMAC_IAH ==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0iahr);
+	printk("%sEMAC_IAH ==> 0x%x\n", log_level, (unsigned int)regp->em0iahr);
 	eieio();
-	printk("%sEMAC_IAL ==> 0x%x\n", log_level, (unsigned int)ppc405_enet_regp->em0ialr);
+	printk("%sEMAC_IAL ==> 0x%x\n", log_level, (unsigned int)regp->em0ialr);
 	eieio();
 	printk("%sEMAC_VLAN_TPID_REG ==> 0x%x\n",
-				        log_level, (unsigned int)ppc405_enet_regp->em0vtpid);
+					log_level, (unsigned int)regp->em0vtpid);
 	eieio();
 	printk("%s\n", log_level);
 }
@@ -1249,14 +1107,68 @@
 init_ppc405_enet(void)
 {
 	int rc;
+	int	delay, i;
+	bd_t	*bd;
+	struct net_device* dev;
+	struct ppc405_enet_private *lo_priv;

-	rc = ppc405_enet_probe1(&ppc405_enet_dev);
-	if (rc)
-		return rc;
+	dev = &ppc405_enet_dev;
+	/* Reset the MAL */
+	mtdcr(DCRN_MALCR, MALCR_MMSR);

-	rc = register_netdev(&ppc405_enet_dev);
-	if (rc)
+	/* initialize the private data pointer */
+	lo_priv = (void *)(((long)kmalloc(
+		sizeof(struct ppc405_enet_private),
+		GFP_KERNEL | GFP_DMA) + 7) & ~7);
+	memset(lo_priv, 0, sizeof(struct ppc405_enet_private));
+	dev->priv = lo_priv;
+
+	lo_priv->regp	    = (struct ppc405_enet_regs *)PPC405_EM0_REG_ADDR;
+
+	/* Reset the EMAC */
+	lo_priv->regp->em0mr0 = EMAC_M0_SRST;
+	eieio();
+	for (delay = 0; delay < 1000; delay++);
+	lo_priv->regp->em0mr0 = lo_priv->regp->em0mr0 & ~EMAC_M0_SRST;
+	eieio();
+
+	/* read the MAC Address */
+	bd = (bd_t *)__res;
+	for (i=0; i<6; i++) {
+		dev->dev_addr[i] = bd->bi_enetaddr[i];
+	}
+
+	dev->base_addr = 0xffe0;  /* indicate no actual physical probing */
+	dev->irq = BL_MAC0_WOL;	  /* the first ethernet irq - need something here */
+
+	/* Find out the default network settings from the phy */
+	lo_priv->ep_speed  = ppc405_phy_speed(dev);
+	lo_priv->ep_duplex = ppc405_phy_duplex(dev);
+
+	/* Fill in the driver function table */
+	dev->open		= &ppc405_enet_open;
+	dev->hard_start_xmit	= &ppc405_enet_start_xmit;
+	dev->stop		= &ppc405_enet_close;
+	dev->get_stats		= &ppc405_enet_stats;
+	dev->set_multicast_list = &ppc405_enet_set_multicast_list;
+
+	/* Fill in the generic fields of the device structure. */
+	ether_setup(dev);
+
+	/*Let the net/core keep track of module use count*/
+	SET_MODULE_OWNER(dev);
+
+	rc = register_netdev(dev);
+	if (rc){
+		kfree(dev->priv);
 		return rc;
+	}
+	printk(KERN_NOTICE "%s: PPC405 EMAC %d Mbs %s duplex "
+	       "MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       dev->name, lo_priv->ep_speed,
+	       (lo_priv->ep_duplex == HALF)? "Half": "Full",
+	       dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+	       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5] );

 	return 0;
 }
@@ -1265,6 +1177,9 @@
 exit_ppc405_enet(void)
 {
 	unregister_netdev(&ppc405_enet_dev);
+	if( ppc405_enet_dev.priv )
+		kfree(ppc405_enet_dev.priv);
+	ppc405_enet_dev.priv = 0;
 }

 module_init(init_ppc405_enet);
diff -wur linux-bk/drivers/net/ppc405_enet.h linux-bk-new/drivers/net/ppc405_enet.h
--- linux-bk/drivers/net/ppc405_enet.h	Tue Sep 11 14:40:27 2001
+++ linux-bk-new/drivers/net/ppc405_enet.h	Tue Sep 11 20:45:00 2001
@@ -34,8 +34,8 @@
 #define _PPC405_ENET_H_

 #ifndef CONFIG_PPC405_ENET_TX_BUFF  // need to add to config.in ak
-#define NUM_TX_BUFF		6
-#define NUM_RX_BUFF		64
+#define NUM_TX_BUFF		8
+#define NUM_RX_BUFF		32
 #else
 #define NUM_TX_BUFF		CONFIG_PPC405_ENET_TX_BUFF
 #define NUM_RX_BUFF		CONFIG_PPC405_ENET_RX_BUFF
@@ -57,8 +57,7 @@
 #define BL_MAL0_RXDE	14
 #define BL_MAC0_ETH	15

-#endif
-
+#endif /* CONFIG_405GP */

 /* Register set */
 struct ppc405_enet_regs {
@@ -97,20 +96,24 @@
 	unsigned char  *data_ptr;	/* pointer to actual data buffer    */
 } mal_desc_t;

-/* Keeps track of waiting transmits of busy */
-struct ppc405_skb_list {
-	struct ppc405_skb_list	*l_next;
-	struct sk_buff		*l_skb;
-};
-
 struct ppc405_enet_private {
+	/* Physical mapping of ethernet register space. */
+	struct	ppc405_enet_regs *regp;
+
+	int	tx_slot;
+	int	tx_ack_slot;
+	int	tx_cnt;
+	int	rx_slot;
+	/* structures to define the ring buffer access. */
+	mal_desc_t	*tx_desc;
+	mal_desc_t	*rx_desc;
+	struct sk_buff	*rx_skb[NUM_RX_BUFF];
+	struct sk_buff	*tx_skb[NUM_TX_BUFF];
+
+	struct net_device_stats	ep_stats;
 	int     		ep_speed;
 	int     		ep_duplex;
-	struct sk_buff 		*ep_xmit_skb[NUM_TX_BUFF];
-	int			ep_xmit_active_count;
-	struct ppc405_skb_list	*ep_xmit_pend;
-	int			ep_xmit_pend_cnt;
-	struct net_device_stats	ep_stats;
+
 };

 /* General defines needed for the driver */

--oC1+HKm2/end4ao3--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
