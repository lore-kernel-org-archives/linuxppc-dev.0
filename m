Date: Thu, 22 Aug 2002 12:12:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: akuster <akuster@dslextreme.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Restructuring of ibm_ocp_enet driver
Message-ID: <20020822021212.GP18818@zax>
References: <20020821043627.GF18818@zax> <3D63CBDC.9010807@dslextreme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D63CBDC.9010807@dslextreme.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 21, 2002 at 10:20:28AM -0700, akuster wrote:
>
> David Gibson wrote:
> >The patch below make some first steps to restructuring the
> >ibm_ocp_enet driver to separate drivers for the EMAC and MAL
> >components.  This is necessary to sanely allocate the various IRQs.
> >It will also be necessary to sanely incorporate the driver into the
> >unified device model.
> <snipped>
> >
>
>
> David,
>
> I don't see any probelms with this for 2.5.
> I would like to see these changes done for *devel and it should just
> easely drop in since I didn't see anything UDM specific.  I would like
> to keep  delta between 2.4 and 2.5 to a minimum if at all possible. :)
> Devel will benefit from this patch because if anyone added support for
> the HDLC , I would assume it would be done in 2_4_devel and not in 2.5
> at this time.

Sure.  I'm just more comfortable with potential breakage in 2.5.  Mind
you I think I've discovered several bugs which I'll be fixing as I
go.  That probably wants to go into 2.4.

You're right, nothing is UDM specific as yet.  The idea is to first
rearrange the driver so it has the right form, then do the actually
plugging into the UDM.

Oh, and here's the next iteration:

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
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.c	2002-08-21 18:03:19.000000000 +1000
@@ -198,7 +198,6 @@

 #include "ocp_zmii.h"
 #include "ibm_ocp_enet.h"
-#include "ibm_ocp_mal.h"

 /* Forward declarations of some structures to support different PHYs */

@@ -224,10 +223,6 @@

 static struct net_device *emac_dev[EMAC_NUMS];

-dma_addr_t rx_phys_addr = 0;
-dma_addr_t tx_phys_addr = 0;
-static mal_desc_t *rx_virt_addr = 0;
-static mal_desc_t *tx_virt_addr = 0;
 mii_list_t mii_cmds[NMII];

 int emac_max;
@@ -239,16 +234,37 @@
 		 "this can help if you are routing to a tunnel or a\n"
 		 "device that needs aligned data");

+
+static void disable_mal_chan(struct ocp_enet_private *fep)
+{
+	set_mal_dcrn(fep->mal, DCRN_MALRXCARR, fep->rxchan);
+	set_mal_dcrn(fep->mal, DCRN_MALTXCARR, fep->txchan);
+
+}
+
+static void enable_mal_chan(struct ocp_enet_private *fep)
+{
+	set_mal_dcrn(fep->mal, DCRN_MALRXCASR,
+		     get_mal_dcrn(fep->mal, DCRN_MALRXCASR) | fep->rxchan);
+	set_mal_dcrn(fep->mal, DCRN_MALTXCASR,
+		     get_mal_dcrn(fep->mal, DCRN_MALTXCASR) | fep->txchan);
+	set_mal_dcrn(fep->mal, DCRN_MALIER, MALIER_DE |
+		     MALIER_NE | MALIER_TE | MALIER_OPBE | MALIER_PLBE);
+
+
+}
+
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
@@ -291,7 +307,6 @@
 		return -ENODEV;
 	}
 	disable_mal_chan(fep);
-	set_mal_chan_addr(fep);

 	/* set the high address */
 	out_be32(&emacp->em0iahr, (dev->dev_addr[0] << 8) | dev->dev_addr[1]);
@@ -354,14 +369,14 @@

 	out_be32(&emacp->em0iser, emac_ier);

-	request_irq(ocp_get_irq(EMAC,fep->emac_num), ppc405_eth_mac, 0, "OCP EMAC MAC", dev);
+	request_irq(dev->irq, ppc405_eth_mac, 0, "OCP EMAC MAC", dev);

-	if (!(get_mal_dcrn(fep, DCRN_MALTXCASR))) {
+	if (!(get_mal_dcrn(fep->mal, DCRN_MALTXCASR))) {
  		request_irq(BL_MAC_WOL,ppc405_eth_wakeup,0,"OCP EMAC Wakeup",dev);
 		request_irq(BL_MAL_SERR,ppc405_eth_serr,0,"OCP EMAC MAL SERR",dev);
 		request_irq(BL_MAL_TXDE,ppc405_eth_txde,0,"OCP EMAC TX DE ",dev);

-		request_irq(BL_MAL_RXDE,ppc405_eth_rxeob,0,"OCP EMAC RX DE",dev);
+		request_irq(BL_MAL_RXDE,ppc405_eth_rxde,0,"OCP EMAC RX DE",dev);

 		request_irq(BL_MAL_TXEOB,ppc405_eth_txeob,0,"OCP EMAC TX EOB",dev);
 		request_irq(BL_MAL_RXEOB,ppc405_eth_rxeob,0,"OCP EMAC RX EOB",dev);
@@ -446,9 +461,9 @@
 	}

 	/* Free the irq's */
-	free_irq(ocp_get_irq(EMAC,fep->emac_num), dev);
+	free_irq(dev->irq, dev);

-	if (!(get_mal_dcrn(fep, DCRN_MALTXCASR))) {
+	if (!(get_mal_dcrn(fep->mal, DCRN_MALTXCASR))) {
  		free_irq(BL_MAC_WOL,dev);
 		free_irq(BL_MAL_SERR,dev);
 		free_irq(BL_MAL_TXDE,dev);
@@ -543,6 +558,8 @@
 	struct ocp_enet_private *ep;
 	struct ocp_dev *emac_driver;

+	printk(KERN_DEBUG "ocp_enet_probe(%d)\n", curr_emac);
+
 	dev = init_etherdev(NULL, sizeof (struct ocp_enet_private));
 	if (dev == NULL) {
 		printk(KERN_ERR
@@ -550,17 +567,23 @@
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
@@ -595,7 +618,7 @@
 		       dev->name);
 		return -1;
 	}
-	config_mal(ep);
+	config_mal(ep->mal);

 	return (ret);

@@ -607,21 +630,10 @@

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
@@ -827,7 +839,7 @@
 	 * it against the first EMAC registered for the MAL.
 	 */

-	mal_error = get_mal_dcrn(fep, DCRN_MALESR);
+	mal_error = get_mal_dcrn(fep->mal, DCRN_MALESR);

 	if (mal_error & MALESR_EVB) {

@@ -848,7 +860,7 @@

 	ppc405_serr_dump_1(dev);
 	/* Clear the error status register */
-	set_mal_dcrn(fep, DCRN_MALESR, mal_error);
+	set_mal_dcrn(fep->mal, DCRN_MALESR, mal_error);
 }

 static void
@@ -886,10 +898,10 @@
 	struct ocp_enet_private *fep = dev->priv;

 	for (count = 0; count < 2; ++count) {
-		isr = get_mal_dcrn(fep, DCRN_MALTXEOBISR);
+		isr = get_mal_dcrn(fep->mal, DCRN_MALTXEOBISR);
 		if (isr == 0)
 			break;
-		set_mal_dcrn(fep, DCRN_MALTXEOBISR, isr);
+		set_mal_dcrn(fep->mal, DCRN_MALTXEOBISR, isr);

 		for (i = 0; i < emac_max; i++) {
 			if (isr & 0x80000000 >> i*2) {
@@ -1031,8 +1043,8 @@

 	disable_irq(BL_MAL_RXDE);

-	isr = get_mal_dcrn(fep, DCRN_MALRXEOBISR);
-	set_mal_dcrn(fep, DCRN_MALRXEOBISR, isr);
+	isr = get_mal_dcrn(fep->mal, DCRN_MALRXEOBISR);
+	set_mal_dcrn(fep->mal, DCRN_MALRXEOBISR, isr);

 	/* This determines which emac is sending the interrupt */
 	for (i = 0; i < emac_max; i++) {
@@ -1064,7 +1076,7 @@
 	ppc405_eth_mal_dump(dev);

 	/* Reenable the transmit channel */
-	set_mal_dcrn(fep, DCRN_MALTXCASR, get_mal_dcrn(fep, DCRN_MALTXCASR));
+	set_mal_dcrn(fep->mal, DCRN_MALTXCASR, get_mal_dcrn(fep->mal, DCRN_MALTXCASR));
 	return;
 }

@@ -1087,7 +1099,7 @@
 	/*
 	 * This really is needed.  This case encountered in stress testing.
 	 */
-	if (get_mal_dcrn(fep, DCRN_MALRXDEIR) == 0)
+	if (get_mal_dcrn(fep->mal, DCRN_MALRXDEIR) == 0)
 		return;

 	//printk(KERN_WARNING "%s: receive descriptor error\n", dev->name);
@@ -1108,7 +1120,7 @@

 	disable_irq(BL_MAL_RXEOB);
 	for (i = 0; i < emac_max; i++) {
-		isr = get_mal_dcrn(fep, DCRN_MALRXEOBISR);
+		isr = get_mal_dcrn(fep->mal, DCRN_MALRXEOBISR);
 		if (isr & 0x80000000 >> i) {
 			dev = emac_dev[i];
 			fep = dev->priv;
@@ -1125,17 +1137,17 @@
 			fep->rx_slot = 0;
 			ppc405_rx_fill(dev, 0);

-			set_mal_dcrn(fep, DCRN_MALRXEOBISR, 0x80000000 >> i);
+			set_mal_dcrn(fep->mal, DCRN_MALRXEOBISR, 0x80000000 >> i);
 		}
 	}

 	/* Clear the interrupt */
-	set_mal_dcrn(fep, DCRN_MALRXDEIR, get_mal_dcrn(fep, DCRN_MALRXDEIR));
+	set_mal_dcrn(fep->mal, DCRN_MALRXDEIR, get_mal_dcrn(fep->mal, DCRN_MALRXDEIR));

 	enable_irq(BL_MAL_RXEOB);

 	/* Reenable the receive channels */
-	set_mal_dcrn(fep, DCRN_MALRXCASR, get_mal_dcrn(fep, DCRN_MALRXCASR));
+	set_mal_dcrn(fep->mal, DCRN_MALRXCASR, get_mal_dcrn(fep->mal, DCRN_MALRXCASR));
 }

 static void
@@ -1153,7 +1165,7 @@
 		fep->stats.tx_errors++;

 		/* Reenable the transmit channel */
-		set_mal_dcrn(fep, DCRN_MALTXCASR, fep->txchan);
+		set_mal_dcrn(fep->mal, DCRN_MALTXCASR, fep->txchan);

 	} else {
 		fep->stats.rx_errors++;
@@ -1193,12 +1205,6 @@
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
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_enet.h	2002-08-21 17:40:48.000000000 +1000
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
@@ -119,24 +118,14 @@
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
 	uint txchan;
 	uint rxchan;
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
@@ -155,9 +144,13 @@
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
+
 	volatile emac_t *emacp;
 	struct ocp_dev ocpdev;
 };
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.c linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.c
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.c	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.c	2002-08-21 18:07:55.000000000 +1000
@@ -42,84 +42,152 @@
 #include <linux/ptrace.h>
 #include <linux/errno.h>
 #include <linux/netdevice.h>
+#include <linux/init.h>

 #include <asm/io.h>

-#include "ibm_ocp_enet.h"
-#include "ibm_ocp_mal.h"
+#include <asm/ocp.h>

-extern dma_addr_t rx_phys_addr;
-extern dma_addr_t tx_phys_addr;
+#include "ibm_ocp_mal.h"

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
+struct ibm_ocp_mal mal_table[NUM_MALS]; /* = 0 */
+
+static int __init init_mal(int n)
 {
-	set_mal_dcrn(fep, DCRN_MALRXCARR, fep->rxchan);
-	set_mal_dcrn(fep, DCRN_MALTXCARR, fep->txchan);
+	struct ibm_ocp_mal *mal;
+	int emac_max;
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
+
+	printk(KERN_DEBUG "init_mal(%d):  mal=%p,  dcrbase=%x\n",
+	       n, mal, mal->dcrbase);
+
+	emac_max = ocp_get_max(EMAC);
+
+	/* Wrong in general, but the best we have for now: */
+	mal->rx_channels = emac_max;
+	mal->tx_channels = 2*emac_max;
+
+	/* It would be nice to allocate buffers separately for each
+	 * channel, but we can't because the channels share the upper
+	 * 13 bits of address lines.  Each channels buffer must also
+	 * be 4k aligned, so we allocate 4k for each channel.  This is
+	 * inefficient FIXME: do better, if possible */
+
+	mal->tx_virt_addr = consistent_alloc(GFP_KERNEL,
+					     MAL_DT_ALIGN * mal->tx_channels,
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
+					     MAL_DT_ALIGN * mal->rx_channels,
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

+	return 0;
 }

-void
-enable_mal_chan(struct ocp_enet_private *fep)
+static void __exit exit_mal(struct ibm_ocp_mal *mal)
 {
-	set_mal_dcrn(fep, DCRN_MALRXCASR,
-		     get_mal_dcrn(fep, DCRN_MALRXCASR) | fep->rxchan);
-	set_mal_dcrn(fep, DCRN_MALTXCASR,
-		     get_mal_dcrn(fep, DCRN_MALTXCASR) | fep->txchan);
-	set_mal_dcrn(fep, DCRN_MALIER, MALIER_DE |
-		     MALIER_NE | MALIER_TE | MALIER_OPBE | MALIER_PLBE);
+	/* FIXME: shut down the MAL */

+	/*
+	 * Unmap the non cached memory space.
+	 */
+	consistent_free(mal->tx_virt_addr);
+	consistent_free(mal->rx_virt_addr);

+	memset(mal, 0, sizeof(*mal));
 }

-void
-set_mal_chan_addr(struct ocp_enet_private *fep)
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
 }
+
+static void __exit exit_mals(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_MALS; i++)
+		exit_mal(&mal_table[i]);
+}
+
+module_init(init_mals);
+module_exit(exit_mals);
diff -urN /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.h linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.h
--- /home/dgibson/kernel/linuxppc-2.5/drivers/net/ibm_ocp/ibm_ocp_mal.h	2002-08-09 07:27:41.000000000 +1000
+++ linux-bluefish/drivers/net/ibm_ocp/ibm_ocp_mal.h	2002-08-21 17:59:10.000000000 +1000
@@ -6,6 +6,35 @@
 #ifndef _IBM_OCP_MAL_H
 #define _IBM_OCP_MAL_H

+#define MAL_DT_ALIGN	(4096)	/* Alignment for each channel's descriptor table */
+
+/* MAL Buffer Descriptor structure */
+struct mal_descriptor {
+	volatile unsigned short ctrl;	/* MAL / Commac status control bits */
+	volatile short data_len;	/* Max length is 4K-1 (12 bits)     */
+	unsigned char *data_ptr;	/* pointer to actual data buffer    */
+} __attribute__((packed));
+
+struct ibm_ocp_mal {
+	int dcrbase;
+	int rx_channels;
+	int tx_channels;
+
+	dma_addr_t rx_phys_addr;
+	struct mal_descriptor *rx_virt_addr;
+
+	dma_addr_t tx_phys_addr;
+	struct mal_descriptor *tx_virt_addr;
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
@@ -28,9 +57,9 @@
 #endif


-#define get_mal_dcrn(fep, dcrn) ({ \
+#define get_mal_dcrn(mal, dcrn) ({ \
 	u32 x; \
-	switch ((fep)->mal) { \
+	switch ((mal)->dcrbase) { \
 		GET_MAL0_STANZA(dcrn) \
 		GET_MAL1_STANZA(dcrn) \
 	default: \
@@ -38,20 +67,15 @@
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
+extern void config_mal(struct ibm_ocp_mal *mal);

 /* the following defines are for the MadMAL status and control registers. */
 /* MADMAL transmit and receive status/control bits  */


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
