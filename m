Date: Fri, 23 Aug 2002 14:48:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ibm_ocp_enet restructuring, third cut
Message-ID: <20020823044819.GC18818@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The basics if the MAL<->EMAC separation are now complete.  It now
needs more helper functions in the MAL code to remove the last MAL
frobbing from the EMAC part, and some cleanup of the mess in the
process.

Note that in the interrupt handlers (rxeob, txeob, rxde and txde) the
MAL code scans a list of COMMACS for one claiming ownership of the
relevant channel.  I used this approach rather than scanning the
channels and having a callback registered per channel because I think
this will be better suited for the HDLC adaptors that also use the
MAL.

diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/Makefile linux-bluefish/drivers/net/ibm_ocp/Makefile
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/Makefile	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/Makefile	2002-08-21 12:55:05.000000000 +1000
@@ -13,7 +13,9 @@

 obj-$(CONFIG_IBM_OCP_ENET) += ibm_ocp.o

-ibm_ocp-objs := ibm_ocp_enet.o ibm_ocp_phy.o ibm_ocp_mal.o
+# NB! Link order matters
+
+ibm_ocp-objs := ibm_ocp_mal.o ibm_ocp_enet.o ibm_ocp_phy.o

 # Only one of these can ever be set at a time, so this works.
 ifeq ($(CONFIG_NP405L)$(CONFIG_NP405H)$(CONFIG_440),y)
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_debug.c linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_debug.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_debug.c	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_debug.c	2002-08-21 13:21:08.000000000 +1000
@@ -109,47 +109,47 @@

 	printk(KERN_DEBUG " MAL DEBUG ********** \n");
 	printk(KERN_DEBUG " MCR      ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALCR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALCR));
 	printk(KERN_DEBUG " ESR      ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALESR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALESR));
 	printk(KERN_DEBUG " IER      ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALIER));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALIER));
 #ifdef CONFIG_40x
 	printk(KERN_DEBUG " DBR      ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALDBR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALDBR));
 #endif				/* CONFIG_40x */
 	printk(KERN_DEBUG " TXCASR   ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXCASR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXCASR));
 	printk(KERN_DEBUG " TXCARR   ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXCARR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXCARR));
 	printk(KERN_DEBUG " TXEOBISR ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXEOBISR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXEOBISR));
 	printk(KERN_DEBUG " TXDEIR   ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXDEIR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXDEIR));
 	printk(KERN_DEBUG " RXCASR   ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRXCASR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRXCASR));
 	printk(KERN_DEBUG " RXCARR   ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRXCARR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRXCARR));
 	printk(KERN_DEBUG " RXEOBISR ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRXEOBISR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRXEOBISR));
 	printk(KERN_DEBUG " RXDEIR   ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRXDEIR));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRXDEIR));
 	printk(KERN_DEBUG " TXCTP0R  ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXCTP0R));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXCTP0R));
 	printk(KERN_DEBUG " TXCTP1R  ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXCTP1R));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXCTP1R));
 	printk(KERN_DEBUG " TXCTP2R  ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXCTP2R));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXCTP2R));
 	printk(KERN_DEBUG " TXCTP3R  ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALTXCTP3R));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALTXCTP3R));
 	printk(KERN_DEBUG " RXCTP0R  ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRXCTP0R));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRXCTP0R));
 	printk(KERN_DEBUG " RXCTP1R  ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRXCTP1R));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRXCTP1R));
 	printk(KERN_DEBUG " RCBS0    ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRCBS0));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRCBS0));
 	printk(KERN_DEBUG " RCBS1    ==> 0x%x\n",
-	       (unsigned int) get_mal_dcrn(fep, DCRN_MALRCBS1));
+	       (unsigned int) get_mal_dcrn(fep->mal, DCRN_MALRCBS1));
 }

 void
@@ -158,7 +158,7 @@
 	struct ocp_enet_private *fep = dev->priv;
 	unsigned long int mal_error, plb_error, plb_addr;

-	mal_error = get_mal_dcrn(fep, DCRN_MALESR);
+	mal_error = get_mal_dcrn(fep->mal, DCRN_MALESR);
 	printk(KERN_DEBUG "ppc405_eth_serr: %s channel %ld \n",
 	       (mal_error & 0x40000000) ? "Receive" :
 	       "Transmit", (mal_error & 0x3e000000) >> 25);
@@ -189,7 +189,7 @@
 ppc405_serr_dump_1(struct net_device *dev)
 {
 	struct ocp_enet_private *fep = dev->priv;
-	int mal_error = get_mal_dcrn(fep, DCRN_MALESR);
+	int mal_error = get_mal_dcrn(fep->mal, DCRN_MALESR);

 	printk(KERN_DEBUG "  -----  cumulative errors  -----\n");
 	if (mal_error & MALESR_DEI)
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_enet.c linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_enet.c	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.c	2002-08-23 14:34:59.000000000 +1000
@@ -198,7 +198,6 @@

 #include "ocp_zmii.h"
 #include "ibm_ocp_enet.h"
-#include "ibm_ocp_mal.h"

 /* Forward declarations of some structures to support different PHYs */

@@ -209,11 +208,10 @@
 static void ppc405_enet_set_multicast_list(struct net_device *);

 static void ppc405_eth_wakeup(int, void *, struct pt_regs *);
-static void ppc405_eth_serr(int, void *, struct pt_regs *);
-static void ppc405_eth_txeob(int, void *, struct pt_regs *);
-static void ppc405_eth_rxeob(int, void *, struct pt_regs *);
-static void ppc405_eth_txde(int, void *, struct pt_regs *);
-static void ppc405_eth_rxde(int, void *, struct pt_regs *);
+static void ppc405_eth_txeob_dev(void *, u32);
+static void ppc405_eth_rxeob_dev(void *, u32);
+static void ppc405_eth_txde_dev(void *, u32);
+static void ppc405_eth_rxde_dev(void *, u32);
 static void ppc405_eth_mac(int, void *, struct pt_regs *);
 static void ppc405_rx_fill(struct net_device *, int);
 static int ppc405_rx_clean(struct net_device *);
@@ -224,10 +222,6 @@

 static struct net_device *emac_dev[EMAC_NUMS];

-dma_addr_t rx_phys_addr = 0;
-dma_addr_t tx_phys_addr = 0;
-static mal_desc_t *rx_virt_addr = 0;
-static mal_desc_t *tx_virt_addr = 0;
 mii_list_t mii_cmds[NMII];

 int emac_max;
@@ -239,16 +233,36 @@
 		 "this can help if you are routing to a tunnel or a\n"
 		 "device that needs aligned data");

+
+static void disable_mal_chan(struct ocp_enet_private *fep)
+{
+	set_mal_dcrn(fep->mal, DCRN_MALRXCARR, MAL_CHAN_MASK(fep->mal_rx_chan));
+	set_mal_dcrn(fep->mal, DCRN_MALTXCARR, MAL_CHAN_MASK(fep->mal_tx_chan));
+
+}
+
+static void enable_mal_chan(struct ocp_enet_private *fep)
+{
+	set_mal_dcrn(fep->mal, DCRN_MALRXCASR,
+		     get_mal_dcrn(fep->mal, DCRN_MALRXCASR) | MAL_CHAN_MASK(fep->mal_rx_chan));
+	set_mal_dcrn(fep->mal, DCRN_MALTXCASR,
+		     get_mal_dcrn(fep->mal, DCRN_MALTXCASR) | MAL_CHAN_MASK(fep->mal_tx_chan));
+	set_mal_dcrn(fep->mal, DCRN_MALIER, MALIER_DE |
+		     MALIER_NE | MALIER_TE | MALIER_OPBE | MALIER_PLBE);
+
+
+}
+
 static void
 init_rings(struct net_device *dev)
 {
 	struct ocp_enet_private *ep = dev->priv;
 	int loop;

-	ep->tx_desc = (mal_desc_t *) ((char *) tx_virt_addr +
-				      (ep->emac_num * PAGE_SIZE));
-	ep->rx_desc = (mal_desc_t *) ((char *) rx_virt_addr +
-				      (ep->emac_num * PAGE_SIZE));
+	ep->tx_desc = (struct mal_descriptor *) ((char *) ep->mal->tx_virt_addr +
+				      (ep->mal_tx_chan * MAL_DT_ALIGN));
+	ep->rx_desc = (struct mal_descriptor *) ((char *) ep->mal->rx_virt_addr +
+				      (ep->mal_rx_chan * MAL_DT_ALIGN));

 	/* Fill in the transmit descriptor ring. */
 	for (loop = 0; loop < NUM_TX_BUFF; loop++) {
@@ -291,7 +305,7 @@
 		return -ENODEV;
 	}
 	disable_mal_chan(fep);
-	set_mal_chan_addr(fep);
+	ibm_ocp_mal_set_rcbs(fep->mal, fep->mal_rx_chan, DESC_BUF_SIZE_REG);

 	/* set the high address */
 	out_be32(&emacp->em0iahr, (dev->dev_addr[0] << 8) | dev->dev_addr[1]);
@@ -354,17 +368,10 @@

 	out_be32(&emacp->em0iser, emac_ier);

-	request_irq(ocp_get_irq(EMAC,fep->emac_num), ppc405_eth_mac, 0, "OCP EMAC MAC", dev);
+	request_irq(dev->irq, ppc405_eth_mac, 0, "OCP EMAC MAC", dev);

-	if (!(get_mal_dcrn(fep, DCRN_MALTXCASR))) {
+	if (!(get_mal_dcrn(fep->mal, DCRN_MALTXCASR))) {
  		request_irq(BL_MAC_WOL,ppc405_eth_wakeup,0,"OCP EMAC Wakeup",dev);
-		request_irq(BL_MAL_SERR,ppc405_eth_serr,0,"OCP EMAC MAL SERR",dev);
-		request_irq(BL_MAL_TXDE,ppc405_eth_txde,0,"OCP EMAC TX DE ",dev);
-
-		request_irq(BL_MAL_RXDE,ppc405_eth_rxeob,0,"OCP EMAC RX DE",dev);
-
-		request_irq(BL_MAL_TXEOB,ppc405_eth_txeob,0,"OCP EMAC TX EOB",dev);
-		request_irq(BL_MAL_RXEOB,ppc405_eth_rxeob,0,"OCP EMAC RX EOB",dev);
 	}

 	/* enable all MAL transmit and receive channels */
@@ -446,17 +453,10 @@
 	}

 	/* Free the irq's */
-	free_irq(ocp_get_irq(EMAC,fep->emac_num), dev);
+	free_irq(dev->irq, dev);

-	if (!(get_mal_dcrn(fep, DCRN_MALTXCASR))) {
+	if (!(get_mal_dcrn(fep->mal, DCRN_MALTXCASR))) {
  		free_irq(BL_MAC_WOL,dev);
-		free_irq(BL_MAL_SERR,dev);
-		free_irq(BL_MAL_TXDE,dev);
-
-		free_irq(BL_MAL_RXDE,dev);
-
-		free_irq(BL_MAL_TXEOB,dev);
-		free_irq(BL_MAL_RXEOB,dev);
 	}


@@ -533,16 +533,25 @@

 }

+struct mal_commac_ops emac_commac_ops = {
+	.txeob = &ppc405_eth_txeob_dev,
+	.txde = &ppc405_eth_txde_dev,
+	.rxeob = &ppc405_eth_rxeob_dev,
+	.rxde = &ppc405_eth_rxde_dev,
+};
+
 static int
 ocp_enet_probe(int curr_emac)
 {
-	int ret = 1;
+	int err = 0;
 	int i;
 	bd_t *bd;
 	struct net_device *dev;
 	struct ocp_enet_private *ep;
 	struct ocp_dev *emac_driver;

+	printk(KERN_DEBUG "ocp_enet_probe(%d)\n", curr_emac);
+
 	dev = init_etherdev(NULL, sizeof (struct ocp_enet_private));
 	if (dev == NULL) {
 		printk(KERN_ERR
@@ -550,17 +559,23 @@
 		return -1;
 	}
 	ep = dev->priv;
-	ep->emac_num = curr_emac;
-	ep->mal = DCRN_MAL_BASE;
+
+	ep->mal = &mal_table[0];
+	/* FIXME: need a better way of determining these */
+	ep->mal_tx_chan = curr_emac * 2;
+	ep->mal_rx_chan = curr_emac;
+
 	ep->sequence_done = 0;

+	printk(KERN_DEBUG "ep->mal = %p\n", ep->mal);
+
 	emac_driver = &ep->ocpdev;
 	emac_driver->type = EMAC;
 	ocp_register(emac_driver);
 	ocp_set_drvdata(emac_driver, dev);

-	ep->emacp = (volatile emac_t *) __ioremap
-	    (emac_driver->paddr, sizeof (emac_t), _PAGE_NO_CACHE);
+	ep->emacp = ioremap(emac_driver->paddr, sizeof (emac_t));
+
 	init_zmii(ZMII_AUTO, dev);
 	find_phy(dev);
 	if (!ep->phy) {
@@ -568,14 +583,21 @@
 		return -1;
 	}
 	ep->link = 1;
-	ep->txchan = 0x80000000  >> curr_emac*2 ;
-	ep->rxchan = 0x80000000 >> curr_emac;
 	dev->irq = ocp_get_irq(EMAC,curr_emac);
 	/* read the MAC Address */
 	bd = (bd_t *) __res;
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = bd->BD_EMAC_ADDR(curr_emac, i);	/* Marco to disques array */

+	ep->commac.ops = &emac_commac_ops;
+	ep->commac.dev = dev;
+	ep->commac.tx_chan_mask = MAL_CHAN_MASK(ep->mal_tx_chan);
+	ep->commac.rx_chan_mask = MAL_CHAN_MASK(ep->mal_rx_chan);
+	err = ibm_ocp_mal_register_commac(ep->mal, &ep->commac);
+	if (err)
+		return err; /* FIXME: cleanup needed? */
+
+
 	/* Fill in the driver function table */
 	dev->open = &ppc405_enet_open;
 	dev->hard_start_xmit = &ppc405_enet_start_xmit;
@@ -595,9 +617,9 @@
 		       dev->name);
 		return -1;
 	}
-	config_mal(ep);
+	config_mal(ep->mal);

-	return (ret);
+	return 0;

 }
 static int __init
@@ -607,21 +629,10 @@

 	emac_max = ocp_get_max(EMAC);

-	/* Allocate memory for the transmit descriptors and save its physical
-	 * address.  EMACs share the upper 13 bits of address lines, so
-	 * allocate one buffer big enough for everybody.
-	 * FIXME: How to ensure aligned on 32768-byte boundary?
-	 */
-
-	tx_virt_addr = (mal_desc_t *)
-	    consistent_alloc(GFP_KERNEL, PAGE_SIZE * emac_max, &tx_phys_addr);
-
-	rx_virt_addr = (mal_desc_t *)
-	    consistent_alloc(GFP_KERNEL, PAGE_SIZE * emac_max, &rx_phys_addr);
+	printk(KERN_DEBUG "init_ppc405_enet\n");
 	for (curr_emac = 0; curr_emac < emac_max; curr_emac++) {
 		ocp_enet_probe(curr_emac);
 	}
-
 	for (i = 0; i < NMII - 1; i++)
 		mii_cmds[i].mii_next = &mii_cmds[i + 1];
 	mii_free = mii_cmds;
@@ -815,6 +826,7 @@
 	printk(KERN_INFO "interrupt ppc405_eth_wakeup\n");
 }

+#if 0
 static void
 ppc405_eth_serr(int irq, void *dev_instance, struct pt_regs *regs)
 {
@@ -827,7 +839,7 @@
 	 * it against the first EMAC registered for the MAL.
 	 */

-	mal_error = get_mal_dcrn(fep, DCRN_MALESR);
+	mal_error = get_mal_dcrn(fep->mal, DCRN_MALESR);

 	if (mal_error & MALESR_EVB) {

@@ -848,12 +860,13 @@

 	ppc405_serr_dump_1(dev);
 	/* Clear the error status register */
-	set_mal_dcrn(fep, DCRN_MALESR, mal_error);
+	set_mal_dcrn(fep->mal, DCRN_MALESR, mal_error);
 }
+#endif

-static void
-ppc405_eth_txeob_dev(struct net_device *dev)
+static void ppc405_eth_txeob_dev(void *p, u32 chanmask)
 {
+	struct net_device *dev = p;
 	struct ocp_enet_private *fep = dev->priv;

 	while (fep->tx_cnt &&
@@ -878,28 +891,6 @@
 	return;
 }

-static void
-ppc405_eth_txeob(int irq, void *dev_instance, struct pt_regs *regs)
-{
-	int i, count, isr;
-	struct net_device *dev = dev_instance;
-	struct ocp_enet_private *fep = dev->priv;
-
-	for (count = 0; count < 2; ++count) {
-		isr = get_mal_dcrn(fep, DCRN_MALTXEOBISR);
-		if (isr == 0)
-			break;
-		set_mal_dcrn(fep, DCRN_MALTXEOBISR, isr);
-
-		for (i = 0; i < emac_max; i++) {
-			if (isr & 0x80000000 >> i*2) {
-				dev = emac_dev[i];
-				ppc405_eth_txeob_dev(dev);
-			}
-		}
-	}
-}
-
 /*
   Fill/Re-fill the rx chain with valid ctrl/ptrs.
   This function will fill from rx_slot up to the parm end.
@@ -1017,44 +1008,22 @@
 	return i;
 }

-static void
-ppc405_eth_rxeob(int irq, void *dev_instance, struct pt_regs *regs)
+static void ppc405_eth_rxeob_dev(void *p, u32 chanmask)
 {
-	int i, n, isr;
-	struct net_device *dev = dev_instance;
-	struct ocp_enet_private *fep = dev->priv;
-
-	/*
-	 * Protect against ppc405_eth_rxde() modifying data structures
-	 * this function is using.
-	 */
-
-	disable_irq(BL_MAL_RXDE);
-
-	isr = get_mal_dcrn(fep, DCRN_MALRXEOBISR);
-	set_mal_dcrn(fep, DCRN_MALRXEOBISR, isr);
-
-	/* This determines which emac is sending the interrupt */
-	for (i = 0; i < emac_max; i++) {
-		if (isr & 0x80000000 >> i) {
-			dev = emac_dev[i];
-			n = ppc405_rx_clean(dev);
-			ppc405_rx_fill(dev, n);
-		}
-	}
-
-	enable_irq(BL_MAL_RXDE);
-	return;
+	struct net_device *dev = p;
+	int n;
+
+	n = ppc405_rx_clean(dev);
+	ppc405_rx_fill(dev, n);
 }

 /*
  * This interrupt should never occurr, we don't program
  * the MAL for contiunous mode.
  */
-static void
-ppc405_eth_txde(int irq, void *dev_instance, struct pt_regs *regs)
+static void ppc405_eth_txde_dev(void *p, u32 chanmask)
 {
-	struct net_device *dev = dev_instance;
+	struct net_device *dev = p;
 	struct ocp_enet_private *fep = dev->priv;

 	printk(KERN_WARNING "%s: transmit descriptor error\n",
@@ -1064,7 +1033,7 @@
 	ppc405_eth_mal_dump(dev);

 	/* Reenable the transmit channel */
-	set_mal_dcrn(fep, DCRN_MALTXCASR, get_mal_dcrn(fep, DCRN_MALTXCASR));
+	set_mal_dcrn(fep->mal, DCRN_MALTXCASR, MAL_CHAN_MASK(fep->mal_tx_chan));
 	return;
 }

@@ -1077,65 +1046,38 @@
  * handled and reinitialize each along the way.  At that point the driver
  * will be restarted.
  */
-static void
-ppc405_eth_rxde(int irq, void *dev_instance, struct pt_regs *regs)
+static void ppc405_eth_rxde_dev(void *p, u32 chanmask)
 {
-	int i, isr;
-	struct net_device *dev = dev_instance;
+	struct net_device *dev = p;
 	struct ocp_enet_private *fep = dev->priv;

-	/*
-	 * This really is needed.  This case encountered in stress testing.
-	 */
-	if (get_mal_dcrn(fep, DCRN_MALRXDEIR) == 0)
-		return;
-
-	//printk(KERN_WARNING "%s: receive descriptor error\n", dev->name);
-	printk("%s: receive descriptor error\n", "PPC 405 MAL0 eth");
+	printk("%s: Rx descriptor error\n", dev->name);

 	ppc405_eth_emac_dump(dev);
 	ppc405_eth_mal_dump(dev);
 	ppc405_eth_desc_dump(dev);

-	/*
-	 * Protect against ppc405_eth_rxeob modifying these same
-	 * structures.  If an rxde interrupt occurs the hardware will
-	 * have disabled that EMAC, but since there may be multiple
-	 * EMACs on the same MAL another rxeob interrupt could occur
-	 * for another EMAC prior to ppc405_eth_rxde() re-enabling
-	 * EMACs below.
-	 */
-
-	disable_irq(BL_MAL_RXEOB);
-	for (i = 0; i < emac_max; i++) {
-		isr = get_mal_dcrn(fep, DCRN_MALRXEOBISR);
-		if (isr & 0x80000000 >> i) {
-			dev = emac_dev[i];
-			fep = dev->priv;
-			/* For now, charge the error against all emacs */
-			fep->stats.rx_errors++;
-
-			/* so do we have any good packets still? */
-			ppc405_rx_clean(dev);

-			/* When the interface is restarted it resets processing to the
-			 *  first descriptor in the table.
-			 */
+	/* For now, charge the error against all emacs */
+	fep->stats.rx_errors++;

-			fep->rx_slot = 0;
-			ppc405_rx_fill(dev, 0);
+	/* so do we have any good packets still? */
+	ppc405_rx_clean(dev);
+
+	/* When the interface is restarted it resets processing to the
+	 *  first descriptor in the table.
+	 */

-			set_mal_dcrn(fep, DCRN_MALRXEOBISR, 0x80000000 >> i);
-		}
-	}
+	fep->rx_slot = 0;
+	ppc405_rx_fill(dev, 0);
+
+	set_mal_dcrn(fep->mal, DCRN_MALRXEOBISR, MAL_CHAN_MASK(fep->mal_rx_chan));

 	/* Clear the interrupt */
-	set_mal_dcrn(fep, DCRN_MALRXDEIR, get_mal_dcrn(fep, DCRN_MALRXDEIR));
+	set_mal_dcrn(fep->mal, DCRN_MALRXDEIR, MAL_CHAN_MASK(fep->mal_rx_chan));

-	enable_irq(BL_MAL_RXEOB);
-
-	/* Reenable the receive channels */
-	set_mal_dcrn(fep, DCRN_MALRXCASR, get_mal_dcrn(fep, DCRN_MALRXCASR));
+	/* Reenable the receive channel */
+	set_mal_dcrn(fep->mal, DCRN_MALRXCASR, MAL_CHAN_MASK(fep->mal_rx_chan));
 }

 static void
@@ -1153,7 +1095,7 @@
 		fep->stats.tx_errors++;

 		/* Reenable the transmit channel */
-		set_mal_dcrn(fep, DCRN_MALTXCASR, fep->txchan);
+		set_mal_dcrn(fep->mal, DCRN_MALTXCASR, MAL_CHAN_MASK(fep->mal_tx_chan));

 	} else {
 		fep->stats.rx_errors++;
@@ -1193,12 +1135,6 @@
 static void __exit
 exit_ppc405_enet(void)
 {
-	/*
-	 * Unmap the non cached memory space.
-	 */
-	consistent_free((void *) tx_virt_addr);
-	consistent_free((void *) rx_virt_addr);
-
 }

 module_init(init_ppc405_enet);
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_enet.h linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.h
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_enet.h	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.h	2002-08-23 13:46:58.000000000 +1000
@@ -57,6 +57,7 @@
 #include <asm/mmu.h>		/* For phys_addr_t */
 #include "ibm_ocp_emac.h"
 #include "ibm_ocp_phy.h"
+#include "ibm_ocp_mal.h"

 #ifndef CONFIG_IBM_OCP_ENET_TX_BUFF
 #define NUM_TX_BUFF		6
@@ -84,8 +85,6 @@
 #define DESC_BUF_SIZE_REG	(DESC_RX_BUF_SIZE / 16)


-#define LAST_EMAC		EMAC_NUMS -1
-
 #define MIN_PHY_ADDR            0x00
 #define MAX_PHY_ADDR            0x1f
 /* Transmitter timeout. */
@@ -119,24 +118,12 @@
 						~EMAC_STACR_CLK_100MHZ) | \
 						((VAL & 0xffff) << 16))

-/* MAL Buffer Descriptor structure */
-typedef struct {
-	volatile unsigned short ctrl;	/* MAL / Commac status control bits */
-	volatile short data_len;	/* Max length is 4K-1 (12 bits)     */
-	unsigned char *data_ptr;	/* pointer to actual data buffer    */
-} mal_desc_t;
-
-
-
 struct ocp_enet_private {
-	uint emac_num;
-	uint txchan;
-	uint rxchan;
 	struct sk_buff *tx_skb[NUM_TX_BUFF];
 	struct sk_buff *rx_skb[NUM_RX_BUFF];
-	mal_desc_t *tx_desc;
-	mal_desc_t *rx_desc;
-	mal_desc_t *rx_dirty;
+	struct mal_descriptor *tx_desc;
+	struct mal_descriptor *rx_desc;
+	struct mal_descriptor *rx_dirty;
 	struct net_device_stats stats;
 	int tx_cnt;
 	int rx_slot;
@@ -155,9 +142,14 @@
 	int link;
 	int old_link;
 	int full_duplex;
+
 	zmii_t *zmii_base;
 	int zmii_mode;
-	int mal;
+
+	struct ibm_ocp_mal *mal;
+	int mal_tx_chan, mal_rx_chan;
+	struct mal_commac commac;
+
 	volatile emac_t *emacp;
 	struct ocp_dev ocpdev;
 };
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.c linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.c	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.c	2002-08-23 14:36:25.000000000 +1000
@@ -39,87 +39,375 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
+#include <linux/init.h>

 #include <asm/io.h>
+#include <asm/irq.h>
+
+#include <asm/ocp.h>

-#include "ibm_ocp_enet.h"
 #include "ibm_ocp_mal.h"

-extern dma_addr_t rx_phys_addr;
-extern dma_addr_t tx_phys_addr;
+struct ibm_ocp_mal mal_table[NUM_MALS]; /* = 0 */
+
+static void __exit exit_mal(struct ibm_ocp_mal *mal);

 void
-config_mal(struct ocp_enet_private *fep)
+config_mal(struct ibm_ocp_mal *mal)
 {
+	printk(KERN_DEBUG "config_mal(%p):  dcrbase = %x\n",
+	       mal, mal->dcrbase);
+	set_mal_dcrn(mal, DCRN_MALRXCARR, 0xFFFFFFFF);
+	set_mal_dcrn(mal, DCRN_MALTXCARR, 0xFFFFFFFF);

-	set_mal_dcrn(fep, DCRN_MALRXCARR, 0xFFFFFFFF);
-	set_mal_dcrn(fep, DCRN_MALTXCARR, 0xFFFFFFFF);
-
-	set_mal_dcrn(fep, DCRN_MALCR, MALCR_MMSR);	/* 384 */
+	set_mal_dcrn(mal, DCRN_MALCR, MALCR_MMSR);	/* 384 */
 	/* FIXME: Add delay */

 	/* Set the MAL configuration register */
-	set_mal_dcrn(fep, DCRN_MALCR,
+	set_mal_dcrn(mal, DCRN_MALCR,
 		     MALCR_PLBB | MALCR_OPBBL | MALCR_LEA |
 		     MALCR_PLBLT_DEFAULT);

 }

-void
-disable_mal_chan(struct ocp_enet_private *fep)
+int ibm_ocp_mal_register_commac(struct ibm_ocp_mal *mal, struct mal_commac *commac)
 {
-	set_mal_dcrn(fep, DCRN_MALRXCARR, fep->rxchan);
-	set_mal_dcrn(fep, DCRN_MALTXCARR, fep->txchan);
+	/* FIXME: locking? */

+	/* Don't let multiple commacs claim the same channel */
+	if ( (mal->tx_chan_mask & commac->tx_chan_mask) ||
+	     (mal->rx_chan_mask & commac->rx_chan_mask) )
+		return -EBUSY;
+
+	mal->tx_chan_mask |= commac->tx_chan_mask;
+	mal->rx_chan_mask |= commac->rx_chan_mask;
+
+	list_add(&commac->list, &mal->commac);
+
+	return 0;
 }

-void
-enable_mal_chan(struct ocp_enet_private *fep)
+int ibm_ocp_mal_set_rcbs(struct ibm_ocp_mal *mal, int channel, unsigned long size)
+{
+	switch (channel) {
+	case 0:
+		set_mal_dcrn(mal, DCRN_MALRCBS0, size);
+		break;
+#ifdef DCRN_RCBS1
+	case 1:
+		set_mal_dcrn(mal, DCRN_MALRCBS1, size);
+		break;
+#endif
+#ifdef DCRN_RCBS2
+	case 2:
+		set_mal_dcrn(mal, DCRN_MALRCBS2, size);
+		break;
+#endif
+#ifdef DCRN_RCBS3
+	case 3:
+		set_mal_dcrn(mal, DCRN_MALRCBS3, size);
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void mal_serr(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ibm_ocp_mal *mal = dev_instance;
+	unsigned long mal_error;
+
+	/*
+	 * This SERR applies to one of the devices on the MAL, here we charge
+	 * it against the first EMAC registered for the MAL.
+	 */
+
+	mal_error = get_mal_dcrn(mal, DCRN_MALESR);
+
+	printk(KERN_ERR "%s: System Error (MALESR=%lx)\n",
+	       "MAL" /* FIXME: get the name right */, mal_error);
+
+	/* FIXME: decipher error */
+	/* DIXME: distribute to commacs, if possible */
+
+	/* Clear the error status register */
+	set_mal_dcrn(mal, DCRN_MALESR, mal_error);
+}
+
+static void mal_txeob(int irq, void *dev_instance, struct pt_regs *regs)
 {
-	set_mal_dcrn(fep, DCRN_MALRXCASR,
-		     get_mal_dcrn(fep, DCRN_MALRXCASR) | fep->rxchan);
-	set_mal_dcrn(fep, DCRN_MALTXCASR,
-		     get_mal_dcrn(fep, DCRN_MALTXCASR) | fep->txchan);
-	set_mal_dcrn(fep, DCRN_MALIER, MALIER_DE |
-		     MALIER_NE | MALIER_TE | MALIER_OPBE | MALIER_PLBE);
+	struct ibm_ocp_mal *mal = dev_instance;
+	struct list_head *l;
+	unsigned long isr;
+
+	/* Loop to better handle lots of interrupts */

+	isr = get_mal_dcrn(mal, DCRN_MALTXEOBISR);
+	set_mal_dcrn(mal, DCRN_MALTXEOBISR, isr);

+	list_for_each(l, &mal->commac) {
+		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
+
+		if (isr & mc->tx_chan_mask) {
+			mc->ops->txeob(mc->dev, isr & mc->tx_chan_mask);
+		}
+	}
+	/* What if we don't get a hit in the list? */
 }

-void
-set_mal_chan_addr(struct ocp_enet_private *fep)
+static void mal_rxeob(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ibm_ocp_mal *mal = dev_instance;
+	struct list_head *l;
+	unsigned long isr;
+
+	/*
+	 * Protect against mal_rxde() modifying data structures this
+	 * function is using. FIXME: synchronisation should move within
+	 * the client drivers */
+	disable_irq(mal->rxde_irq);
+
+
+	/* FIXME: Loop to better handle lots of interrupts? */
+
+	isr = get_mal_dcrn(mal, DCRN_MALRXEOBISR);
+	set_mal_dcrn(mal, DCRN_MALRXEOBISR, isr);
+
+	list_for_each(l, &mal->commac) {
+		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
+
+		if (isr & mc->rx_chan_mask) {
+			mc->ops->rxeob(mc->dev, isr & mc->rx_chan_mask);
+		}
+	}
+	/* FIXME: What if we don't get a hit in the list? */
+
+	enable_irq(mal->rxde_irq);
+}
+
+static void mal_txde(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ibm_ocp_mal *mal = dev_instance;
+	struct list_head *l;
+	unsigned long deir;
+
+	deir = get_mal_dcrn(mal, DCRN_MALTXDEIR);
+
+	/* FIXME: print which MAL correctly */
+	printk(KERN_WARNING "%s: Tx descriptor error (MALTXDEIR=%lx)\n",
+	       "MAL", deir);
+
+	list_for_each(l, &mal->commac) {
+		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
+
+		if (deir & mc->tx_chan_mask) {
+			mc->ops->txde(mc->dev, deir & mc->tx_chan_mask);
+		}
+	}
+	/* What if there is no match in the list? */
+	return;
+}
+
+/*
+ * This interrupt should be very rare at best.  This occurs when
+ * the hardware has a problem with the receive descriptors.  The manual
+ * states that it occurs when the hardware cannot the receive descriptor
+ * empty bit is not set.  The recovery mechanism will be to
+ * traverse through the descriptors, handle any that are marked to be
+ * handled and reinitialize each along the way.  At that point the driver
+ * will be restarted.
+ */
+static void mal_rxde(int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ibm_ocp_mal *mal = dev_instance;
+	struct list_head *l;
+	unsigned long deir;
+
+	deir = get_mal_dcrn(mal, DCRN_MALRXDEIR);
+
+	/*
+	 * This really is needed.  This case encountered in stress testing.
+	 */
+	if (deir == 0)
+		return;
+
+	/* FIXME: print which MAL correctly */
+	printk(KERN_WARNING "%s: Rx descriptor error (MALRXDEIR=%lx)\n",
+	       "MAL", deir);
+
+
+	/*
+	 * Protect against ppc405_eth_rxeob modifying these same
+	 * structures.  If an rxde interrupt occurs the hardware will
+	 * have disabled that EMAC, but since there may be multiple
+	 * EMACs on the same MAL another rxeob interrupt could occur
+	 * for another EMAC prior to ppc405_eth_rxde() re-enabling
+	 * EMACs below.  FIXME: this looks bogus
+	 */
+	disable_irq(BL_MAL_RXEOB);
+
+	list_for_each(l, &mal->commac) {
+		struct mal_commac *mc = list_entry(l, struct mal_commac, list);
+
+		if (deir & mc->rx_chan_mask) {
+			mc->ops->rxde(mc->dev, deir & mc->rx_chan_mask);
+		}
+	}
+
+	enable_irq(BL_MAL_RXEOB);
+}
+
+static int __init init_mal(int n)
+{
+	struct ibm_ocp_mal *mal;
+	int err;
+
+	mal = &mal_table[n];
+
+
+	switch (n) {
+	case 0:
+		mal->dcrbase = DCRN_MAL_BASE;
+		break;
+#ifdef DCRN_MAL1_BASE
+	case 1:
+		mal->dcrbase = DCRN_MAL1_BASE;
+		break;
+#endif
+	default:
+		BUG();
+	}
+	mal->serr_irq = BL_MAL_SERR;
+	mal->txde_irq = BL_MAL_TXDE;
+	mal->txeob_irq = BL_MAL_TXEOB;
+	mal->rxde_irq = BL_MAL_RXDE;
+	mal->rxeob_irq = BL_MAL_RXEOB;
+
+	/* Wrong in general, but the best we have for now: */
+	mal->num_tx_channels = 2*EMAC_NUMS;
+	mal->num_rx_channels = EMAC_NUMS;
+
+	/**************************/
+
+	INIT_LIST_HEAD(&mal->commac);
+
+	/* It would be nice to allocate buffers separately for each
+	 * channel, but we can't because the channels share the upper
+	 * 13 bits of address lines.  Each channels buffer must also
+	 * be 4k aligned, so we allocate 4k for each channel.  This is
+	 * inefficient FIXME: do better, if possible */
+
+	mal->tx_virt_addr = consistent_alloc(GFP_KERNEL,
+					     MAL_DT_ALIGN * mal->num_tx_channels,
+					     &mal->tx_phys_addr);
+
+	/* God, oh, god, I hate DCRs */
+	set_mal_dcrn(mal, DCRN_MALTXCTP0R, mal->tx_phys_addr);
+#ifdef DCRN_MALTXCTP1R
+	set_mal_dcrn(mal, DCRN_MALTXCTP1R, mal->tx_phys_addr + MAL_DT_ALIGN);
+#endif /* DCRN_MALTXCTP1R */
+#ifdef DCRN_MALTXCTP2R
+	set_mal_dcrn(mal, DCRN_MALTXCTP2R, mal->tx_phys_addr + 2*MAL_DT_ALIGN);
+#endif /* DCRN_MALTXCTP2R */
+#ifdef DCRN_MALTXCTP3R
+	set_mal_dcrn(mal, DCRN_MALTXCTP3R, mal->tx_phys_addr + 3*MAL_DT_ALIGN);
+#endif /* DCRN_MALTXCTP3R */
+#ifdef DCRN_MALTXCTP4R
+	set_mal_dcrn(mal, DCRN_MALTXCTP4R, mal->tx_phys_addr + 4*MAL_DT_ALIGN);
+#endif /* DCRN_MALTXCTP4R */
+#ifdef DCRN_MALTXCTP5R
+	set_mal_dcrn(mal, DCRN_MALTXCTP5R, mal->tx_phys_addr + 5*MAL_DT_ALIGN);
+#endif /* DCRN_MALTXCTP5R */
+#ifdef DCRN_MALTXCTP6R
+	set_mal_dcrn(mal, DCRN_MALTXCTP6R, mal->tx_phys_addr + 6*MAL_DT_ALIGN);
+#endif /* DCRN_MALTXCTP6R */
+#ifdef DCRN_MALTXCTP7R
+	set_mal_dcrn(mal, DCRN_MALTXCTP7R, mal->tx_phys_addr + 7*MAL_DT_ALIGN);
+#endif /* DCRN_MALTXCTP7R */
+
+	mal->rx_virt_addr = consistent_alloc(GFP_KERNEL,
+					     MAL_DT_ALIGN * mal->num_rx_channels,
+					     &mal->rx_phys_addr);
+
+	set_mal_dcrn(mal, DCRN_MALRXCTP0R, mal->rx_phys_addr);
+#ifdef DCRN_MALRXCTP1R
+	set_mal_dcrn(mal, DCRN_MALRXCTP1R, mal->rx_phys_addr + MAL_DT_ALIGN);
+#endif /* DCRN_MALRXCTP1R */
+#ifdef DCRN_MALRXCTP2R
+	set_mal_dcrn(mal, DCRN_MALRXCTP2R, mal->rx_phys_addr + 2*MAL_DT_ALIGN);
+#endif /* DCRN_MALRXCTP2R */
+#ifdef DCRN_MALRXCTP3R
+	set_mal_dcrn(mal, DCRN_MALRXCTP3R, mal->rx_phys_addr + 3*MAL_DT_ALIGN);
+#endif /* DCRN_MALRXCTP3R */
+
+	err = request_irq(mal->serr_irq, mal_serr, 0 ,"MAL SERR", mal);
+	if (err)
+		goto fail;
+	err = request_irq(mal->txde_irq, mal_txde,0, "MAL TX DE ", mal);
+	if (err)
+		goto fail;
+	err = request_irq(mal->txeob_irq, mal_txeob, 0, "MAL TX EOB", mal);
+	if (err)
+		goto fail;
+	err = request_irq(mal->rxde_irq, mal_rxde, 0, "MAL RX DE", mal);
+	if (err)
+		goto fail;
+	err = request_irq(mal->rxeob_irq, mal_rxeob, 0, "MAL RX EOB", mal);
+	if (err)
+		goto fail;
+
+	return 0;
+
+ fail:
+	exit_mal(mal);
+	return err;
+}
+
+static void __exit exit_mal(struct ibm_ocp_mal *mal)
+{
+	/* FIXME: shut down the MAL */
+	free_irq(mal->serr_irq, mal);
+	free_irq(mal->txde_irq, mal);
+	free_irq(mal->txeob_irq, mal);
+	free_irq(mal->rxde_irq, mal);
+	free_irq(mal->rxeob_irq, mal);
+
+	if (mal->tx_virt_addr)
+		consistent_free(mal->tx_virt_addr);
+	if (mal->rx_virt_addr)
+		consistent_free(mal->rx_virt_addr);
+
+	memset(mal, 0, sizeof(*mal));
+}
+
+static int __init init_mals(void)
 {
-#ifdef CONFIG_NP405H
-	/* setup MAL tx and rx channel pointers */
-	if (fep->emac_num == 3) {
-		set_mal_dcrn(fep, DCRN_MALTXCTP6R,
-			     tx_phys_addr + (fep->emac_num * PAGE_SIZE));
-		set_mal_dcrn(fep, DCRN_MALRXCTP3R,
-			     rx_phys_addr + (fep->emac_num * PAGE_SIZE));
-		set_mal_dcrn(fep, DCRN_MALRCBS3, DESC_BUF_SIZE_REG);
-
-	} else if (fep->emac_num == 2) {
-		set_mal_dcrn(fep, DCRN_MALTXCTP4R,
-			     tx_phys_addr + (fep->emac_num * PAGE_SIZE));
-		set_mal_dcrn(fep, DCRN_MALRXCTP2R,
-			     rx_phys_addr + (fep->emac_num * PAGE_SIZE));
-		set_mal_dcrn(fep, DCRN_MALRCBS2, DESC_BUF_SIZE_REG);
-
-	} else
-#endif				/* CONFIG_440 */
-	if (fep->emac_num == 1) {
-		set_mal_dcrn(fep, DCRN_MALTXCTP2R,
-			     tx_phys_addr + (fep->emac_num * PAGE_SIZE));
-		set_mal_dcrn(fep, DCRN_MALRXCTP1R,
-			     rx_phys_addr + (fep->emac_num * PAGE_SIZE));
-		set_mal_dcrn(fep, DCRN_MALRCBS1, DESC_BUF_SIZE_REG);
-
-	} else if (fep->emac_num == 0) {
-		set_mal_dcrn(fep, DCRN_MALTXCTP0R, tx_phys_addr);
-		set_mal_dcrn(fep, DCRN_MALRXCTP0R, rx_phys_addr);
-		set_mal_dcrn(fep, DCRN_MALRCBS0, DESC_BUF_SIZE_REG);
+	int i;
+	int err;
+
+	printk(KERN_DEBUG "init_mals()\n");
+
+	for (i = 0; i < NUM_MALS; i++) {
+		err = init_mal(i);
+		if (err)
+			return err; /* FIXME: cleanup initalized MALs */
 	}
+
+	return 0;
+}
+
+static void __exit exit_mals(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_MALS; i++)
+		exit_mal(&mal_table[i]);
 }
+
+module_init(init_mals);
+module_exit(exit_mals);
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.h linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.h
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.h	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.h	2002-08-23 14:30:15.000000000 +1000
@@ -6,6 +6,76 @@
 #ifndef _IBM_OCP_MAL_H
 #define _IBM_OCP_MAL_H

+#include <linux/list.h>
+
+#define MAL_DT_ALIGN	(4096)	/* Alignment for each channel's descriptor table */
+
+#define MAL_CHAN_MASK(chan)	(0x80000000 >> (chan))
+
+/* MAL Buffer Descriptor structure */
+struct mal_descriptor {
+	volatile unsigned short ctrl;	/* MAL / Commac status control bits */
+	volatile short data_len;	/* Max length is 4K-1 (12 bits)     */
+	unsigned char *data_ptr;	/* pointer to actual data buffer    */
+} __attribute__((packed));
+
+/* the following defines are for the MadMAL status and control registers. */
+/* MADMAL transmit and receive status/control bits  */
+#define MAL_RX_CTRL_EMPTY		0x8000
+#define MAL_RX_CTRL_WRAP		0x4000
+#define MAL_RX_CTRL_CM			0x2000
+#define MAL_RX_CTRL_LAST		0x1000
+#define MAL_RX_CTRL_FIRST		0x0800
+#define MAL_RX_CTRL_INTR		0x0400
+
+#define MAL_TX_CTRL_READY		0x8000
+#define MAL_TX_CTRL_WRAP		0x4000
+#define MAL_TX_CTRL_CM			0x2000
+#define MAL_TX_CTRL_LAST		0x1000
+#define MAL_TX_CTRL_INTR		0x0400
+
+struct mal_commac_ops {
+	void (*txeob)(void *dev, u32 chanmask);
+	void (*txde)(void *dev, u32 chanmask);
+	void (*rxeob)(void *dev, u32 chanmask);
+	void (*rxde)(void *dev, u32 chanmask);
+};
+
+struct mal_commac {
+	struct mal_commac_ops *ops;
+	void *dev;
+	u32 tx_chan_mask, rx_chan_mask;
+	struct list_head list;
+};
+
+/* FIXME: Work this out better */
+#define MAL_MAX_TX_CHANNELS	(EMAC_NUMS*2)
+#define MAL_MAX_RX_CHANNELS	(EMAC_NUMS)
+
+struct ibm_ocp_mal {
+	int dcrbase;
+	int serr_irq, txeob_irq, txde_irq, rxeob_irq, rxde_irq;
+
+	struct list_head commac;
+	u32 tx_chan_mask, rx_chan_mask;
+
+	int num_tx_channels;
+	dma_addr_t tx_phys_addr;
+	struct mal_descriptor *tx_virt_addr;
+
+	int num_rx_channels;
+	dma_addr_t rx_phys_addr;
+	struct mal_descriptor *rx_virt_addr;
+};
+
+#ifdef DCRN_MAL1_BASE
+#define NUM_MALS	2
+#else
+#define	NUM_MALS	1
+#endif
+
+extern struct ibm_ocp_mal mal_table[NUM_MALS];
+
 #define GET_MAL_STANZA(base,dcrn) \
 	case base: \
 		x = mfdcr(dcrn(base)); \
@@ -28,9 +98,9 @@
 #endif


-#define get_mal_dcrn(fep, dcrn) ({ \
+#define get_mal_dcrn(mal, dcrn) ({ \
 	u32 x; \
-	switch ((fep)->mal) { \
+	switch ((mal)->dcrbase) { \
 		GET_MAL0_STANZA(dcrn) \
 		GET_MAL1_STANZA(dcrn) \
 	default: \
@@ -38,35 +108,16 @@
 	} \
 x; })

-#define set_mal_dcrn(fep, dcrn, val) do { \
-	switch ((fep)->mal) { \
+#define set_mal_dcrn(mal, dcrn, val) do { \
+	switch ((mal)->dcrbase) { \
 		SET_MAL0_STANZA(dcrn,val) \
 		SET_MAL1_STANZA(dcrn,val) \
 	default: \
 		BUG(); \
 	} } while (0)

-
-extern void config_mal(struct ocp_enet_private *fep);
-extern void disable_mal_chan(struct ocp_enet_private *fep);
-extern void enable_mal_chan(struct ocp_enet_private *fep);
-extern void set_mal_chan_addr(struct ocp_enet_private *fep);
-
-
-/* the following defines are for the MadMAL status and control registers. */
-/* MADMAL transmit and receive status/control bits  */
-#define MAL_RX_CTRL_EMPTY		0x8000
-#define MAL_RX_CTRL_WRAP		0x4000
-#define MAL_RX_CTRL_CM			0x2000
-#define MAL_RX_CTRL_LAST		0x1000
-#define MAL_RX_CTRL_FIRST		0x0800
-#define MAL_RX_CTRL_INTR		0x0400
-
-#define MAL_TX_CTRL_READY		0x8000
-#define MAL_TX_CTRL_WRAP		0x4000
-#define MAL_TX_CTRL_CM			0x2000
-#define MAL_TX_CTRL_LAST		0x1000
-#define MAL_TX_CTRL_INTR		0x0400
-
+extern void config_mal(struct ibm_ocp_mal *mal);
+extern int ibm_ocp_mal_register_commac(struct ibm_ocp_mal *mal, struct mal_commac *commac);
+extern int ibm_ocp_mal_set_rcbs(struct ibm_ocp_mal *mal, int channel, unsigned long size);

 #endif /* _IBM_OCP_MAL_H */
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_phy.c linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_phy.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_phy.c	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_phy.c	2002-08-22 12:50:02.000000000 +1000
@@ -80,7 +80,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/init.h>


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
