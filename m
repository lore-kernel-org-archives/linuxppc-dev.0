Message-ID: <3FE19DA9.2060809@sysgo.com>
Date: Thu, 18 Dec 2003 13:29:29 +0100
From: Pavel Bartusek <pba@sysgo.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] PPC4xx PHY interrupts patch
Content-Type: multipart/mixed;
 boundary="------------020309060807030203040202"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020309060807030203040202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

On PPC4xx are not currently supported interrupts from external PHY. It's
OK on all CPUs instead of IBM PPC440. The CPU has internal ZMII bridge
where must be set the current link speed (Speed Selection Register -
ZMII0_SSR).
The current interruptless implementation fails in the following cases:
- Linux starts without ethernet connection with default 10MB speed. When
you will try connect 100MB link it fails
- reconection between 100 and 10 MB connection

The attached patch uses the interrpts from PHY to detect link change and
sets apporiate speed in the Speed Selection Register and reports link
change to console. The patch was tested with the IBM evaluation Ebony board.

regards

--

Pavel Bartusek <pba@sysgo.de>
Software Engineering

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Lise-Meitner-Str.15
89081 Ulm, Germany

Voice: +49-731-9533-1295
FAX:   +49-731-94683-10
www.sysgo.de | www.elinos.com | www.osek.de


--------------020309060807030203040202
Content-Type: text/plain;
 name="ppc4xx_phy_int.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc4xx_phy_int.patch"

--- linux.ori/drivers/net/ibm_ocp/ibm_ocp_enet.c	Wed Dec  3 09:01:26 2003
+++ linux/drivers/net/ibm_ocp/ibm_ocp_enet.c	Wed Dec 17 15:38:30 2003
@@ -178,6 +178,9 @@
  *         any BD, ppc405_rx_fill() gets called anyway with i == fep->rx_slot. It will
  *         corrupt the current BD (fep->rx_slot) and NUM_RX_BUFF packets will be lost
  *
+ *	Version: 4.8 12/17/03 - Pavel Bartusek
+ *      Added support for PHY interrupts
+ *
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -210,6 +213,10 @@
 #include "ibm_ocp_enet.h"
 #include "ibm_ocp_mal.h"

+#if defined(PHY0_INTERRUPT) || defined(PHY1_INTERRUPT)
+# define PHY_INTERRUPT
+#endif
+
 /* Forward declarations of some structures to support different PHYs */

 static int ppc405_enet_open(struct net_device *);
@@ -227,10 +234,15 @@
 static void ppc405_eth_mac(int, void *, struct pt_regs *);
 static void ppc405_rx_fill(struct net_device *, int);
 static void ppc405_rx_clean(struct net_device *, int);
+#ifdef PHY_INTERRUPT
+static void ppc405_phy(int irq, void * dev_id, struct pt_regs * regs);
+#endif

 int ocp_enet_mdio_read(struct net_device *dev, int reg, uint * value);
 int ocp_enet_mdio_write(struct net_device *dev, int reg);
 int ocp_enet_ioctl(struct net_device *, struct ifreq *rq, int cmd);
+void process_mii_queue(struct net_device *dev);
+

 static struct net_device *emac_dev[EMAC_NUMS];

@@ -301,18 +313,53 @@
 static int
 ppc405_enet_open(struct net_device *dev)
 {
+#ifdef PHY_INTERRUPT
+	int ret;
+#else
 	unsigned long mode_reg;
+#endif
 	struct ocp_enet_private *fep = dev->priv;
 	volatile emac_t *emacp = fep->emacp;
 	unsigned long emac_ier;

-	if (!fep->link) {
+
+	if (!fep->phy) {
 		printk(KERN_NOTICE "%s: Cannot open interface without phy\n",
 		       dev->name);
 		return -ENODEV;
 	}
+
 	disable_mal_chan(fep);
 	set_mal_chan_addr(fep);
+
+#ifdef PHY_INTERRUPT
+	/*
+	 * we must disable irq before the startup PHY sequence, because it
+	 * will assert interrupt line which can be shared
+	 */
+	fep->phy_irq = -1;
+	switch (fep->emac_num) {
+		case 0:
+#ifdef PHY0_INTERRUPT
+			fep->phy_irq = PHY0_INTERRUPT;
+#endif
+			break;
+		case 1:
+#ifdef PHY1_INTERRUPT
+			fep->phy_irq = PHY1_INTERRUPT;
+#endif
+			break;
+	}
+	if (fep->phy_irq != -1) {
+		snprintf(fep->phy_irqname, sizeof(fep->phy_irqname), "%s PHY %s", dev->name, fep->phy->name);
+		ret = request_irq(fep->phy_irq, ppc405_phy, SA_SHIRQ, fep->phy_irqname, dev);
+		if (ret) {
+			printk("Error allocating irq %d for %s",fep->phy_irq ,fep->phy_irqname);
+			return ret;
+		}
+		disable_irq(fep->phy_irq);
+	}
+#endif

 	/* set the high address */
 	out_be32(&emacp->em0iahr, (dev->dev_addr[0] << 8) | dev->dev_addr[1]);
@@ -321,7 +368,8 @@
 	out_be32(&emacp->em0ialr,
 		 (dev->dev_addr[2] << 24) | (dev->dev_addr[3] << 16)
 		 | (dev->dev_addr[4] << 8) | dev->dev_addr[5]);
-
+
+	fep->sequence_done = 0;
 	mii_do_cmd(dev, fep->phy->startup);
 	mii_do_cmd(dev, fep->phy->ack_int);
 	mii_do_cmd(dev, fep->phy->config);
@@ -329,8 +377,10 @@
 	while (!fep->sequence_done)
 		schedule();

-	mii_display_status(dev);
-
+#ifdef PHY_INTERRUPT
+	if (fep->phy_irq != -1)
+		enable_irq(fep->phy_irq);
+#else
 	/* set receive fifo to 4k and tx fifo to 2k */
 	mode_reg = EMAC_M1_RFS_4K | EMAC_M1_TX_FIFO_2K | EMAC_M1_APP |
 	    EMAC_M1_TR0_MULTI;
@@ -350,7 +400,7 @@
 		mode_reg = mode_reg & ~(EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_ILE);	/* half duplex */

 	out_be32(&emacp->em0mr1, mode_reg);
-
+#endif
 	/* enable broadcast and individual address */
 	out_be32(&emacp->em0rmr, EMAC_RMR_IAE | EMAC_RMR_BAE);

@@ -386,7 +436,6 @@
 		request_irq(BL_MAL_TXEOB,ppc405_eth_txeob,0,"OCP EMAC TX EOB",dev);
 		request_irq(BL_MAL_RXEOB,ppc405_eth_rxeob,0,"OCP EMAC RX EOB",dev);
 	}
-
 	/* init buffer descriptors rings */
 	init_rings(dev);

@@ -480,7 +529,18 @@
 		free_irq(BL_MAL_RXEOB,dev);
 	}

-
+#ifdef PHY_INTERRUPT
+	if (fep->phy_irq != -1)
+		free_irq(fep->phy_irq, dev);
+#endif
+	fep->sequence_done = 0;
+	mii_do_cmd(dev, fep->phy->shutdown);
+	mii_queue_schedule(dev);
+	while (!fep->sequence_done)
+		schedule();
+
+	fep->old_phy_status = 0;
+	fep->link = 0;
 	free_phy(dev);
 	return 0;
 }
@@ -613,7 +673,7 @@
 		ocp_remove_one(emac_driver);
 		return -1;
 	}
-	ep->link = 1;
+	ep->link = 0;
 	ep->txchan = 0x80000000  >> curr_emac*2 ;
 	ep->rxchan = 0x80000000 >> curr_emac;
 	dev->irq = ocp_get_irq(EMAC,curr_emac);
@@ -1200,6 +1260,60 @@
 		     get_mal_dcrn(fep, DCRN_MALRXCASR) | reenable_rxchans);
 }

+#ifdef PHY_INTERRUPT
+LIST_HEAD(phy_check_head);
+
+static void
+proc_mii_queue_do_tasklet(unsigned long unused)
+{
+	struct ocp_enet_private *fep;
+	int flags;
+	struct list_head *pos;
+	struct net_device *dev;
+	static spinlock_t phy_check_list_lock;
+
+	spin_lock_irqsave(&phy_check_list_lock, flags);
+	list_for_each(pos, &phy_check_head) {
+		fep = list_entry(pos, struct ocp_enet_private, emac_list);
+		spin_unlock_irqrestore(&phy_check_list_lock, flags);
+		dev = emac_dev[fep->emac_num];
+		fep->sequence_done = 0;
+		mii_do_cmd(dev, fep->phy->ack_int);
+		process_mii_queue(dev);
+
+		spin_lock_irqsave(&phy_check_list_lock, flags);
+	}
+	/* reenable PHY interrupt(s) */
+	list_for_each(pos, &phy_check_head) {
+		fep = list_entry(pos, struct ocp_enet_private, emac_list);
+		if (fep->phy_irq != -1)
+			enable_irq(fep->phy_irq);
+	}
+	/* clear the list */
+	INIT_LIST_HEAD(&phy_check_head);
+
+	spin_unlock_irqrestore(&phy_check_list_lock, flags);
+}
+
+DECLARE_TASKLET(proc_mii_queue_tasklet, proc_mii_queue_do_tasklet, 0);
+
+/*
+ * This interrupt occurs when the PHY detects a link change
+ */
+static void
+ppc405_phy(int irq, void * dev_id, struct pt_regs * regs)
+{
+	struct net_device *dev = dev_id;
+	struct ocp_enet_private *fep = dev->priv;
+
+	list_add_tail(&fep->emac_list, &phy_check_head);
+	tasklet_schedule(&proc_mii_queue_tasklet);
+
+	disable_irq(irq);
+	return;
+}
+#endif
+
 static void
 ppc405_eth_mac(int irq, void *dev_instance, struct pt_regs *regs)
 {
--- linux.ori/drivers/net/ibm_ocp/ibm_ocp_enet.h	Mon Mar 24 18:09:56 2003
+++ linux/drivers/net/ibm_ocp/ibm_ocp_enet.h	Wed Dec 17 15:04:00 2003
@@ -164,6 +164,10 @@
 	int mal;
 	volatile emac_t *emacp;
 	struct ocp_dev ocpdev;
+	char phy_irqname[32];
+	int phy_irq;
+	uint old_phy_status;
+	struct list_head emac_list;
 };


--- linux.ori/drivers/net/ibm_ocp/ibm_ocp_phy.c	Wed Dec  3 09:01:26 2003
+++ linux/drivers/net/ibm_ocp/ibm_ocp_phy.c	Wed Dec 17 15:36:36 2003
@@ -75,6 +75,10 @@
  *  	using zmii_phyid_adj() to adjust phy addrs on those cpus
  *  	that use a zmii bridge
  *  	fixed find_phy for zmii bridge support
+ *
+ * Version: 2.2 12/17/03 - Pavel Bartusek
+ *      Added support for PHY interrupts
+
  */

 #include <linux/module.h>
@@ -92,6 +96,8 @@
 #include <asm/io.h>

 #include "ibm_ocp_enet.h"
+#include "ocp_zmii.h"
+
 static int next_phy_available = MIN_PHY_ADDR;

 /* Forward declarations of some structures to support different PHYs */
@@ -135,6 +141,8 @@
 static int mii_queue(struct net_device *dev, int request,
 		     void (*func) (uint, struct net_device *));

+static void check_phy_configuration(uint mii_reg, struct net_device *dev);
+
 /* Register definitions for the PHY. */

 #define MII_REG_CR		0	/* Control Register */
@@ -791,8 +798,8 @@
 			     },
 	(const phy_cmd_t[]) {	/* startup - enable interrupts */
 			     {mk_mii_write(MII_REG_CR, PHY_BMCR_AUTON), NULL},	/* Auto neg. on */
-//              { mk_mii_write(MII_AM79C875_MFR, 0x4000), NULL}, /* int 1 to signle interrupt */
-//              { mk_mii_write(MII_AM79C875_ICR, 0x00ff), NULL }, /* enable interrupts */
+			     { mk_mii_write(MII_AM79C875_MFR, 0x0000), NULL}, /* int 0 to signle interrupt */
+			     { mk_mii_write(MII_AM79C875_ICR, 0x00ff), NULL }, /* enable interrupts */
 			     {mk_mii_write(MII_REG_CR, PHY_BMCR_RST_NEG), NULL},	/* autonegotiate */
 			     {mk_mii_read(MII_REG_ANLPAR),
 			      mii_parse_Am79C875_pcr},
@@ -798,8 +808,8 @@
 			     {mk_mii_read(MII_AM79C875_ICR), NULL},
 			     {mk_mii_read(MII_REG_SR), mii_parse_sr},
 			     {mk_mii_read(MII_REG_ANAR), mii_parse_anar},
-			     {mk_mii_read(MII_REG_ANLPAR),
-			      mii_parse_Am79C875_pcr},
+			     {mk_mii_read(MII_REG_ANLPAR), mii_parse_Am79C875_pcr},
+			     {mk_mii_read(MII_REG_PHYIR1), check_phy_configuration},
 			     {mk_mii_end,}
 			     },
 	(const phy_cmd_t[]) {	/* shutdown - nothing */
@@ -1172,3 +1182,48 @@
 	return(next_phy_available);

 }
+
+static void
+check_phy_configuration(uint mii_reg, struct net_device *dev)
+{
+	struct ocp_enet_private *fep = dev->priv;
+	volatile emac_t *emacp = fep->emacp;
+	unsigned long mode_reg;
+
+	if (fep->old_phy_status != fep->phy_status) {
+		fep->old_phy_status = fep->phy_status;
+		fep->old_link = fep->link;
+		if ((fep->phy_status & PHY_STAT_FAULT) || !(fep->phy_status & PHY_STAT_LINK)) {
+			/* the link is down */
+			fep->link = 0;
+		} else {
+			/* the link is up */
+			fep->link = 1;
+		}
+		if (fep->old_link != fep->link) {
+			/* display only the link configuration change */
+			mii_display_status(dev);
+		}
+
+		/* set receive fifo to 4k and tx fifo to 2k */
+		mode_reg = EMAC_M1_RFS_4K | EMAC_M1_TX_FIFO_2K | EMAC_M1_APP |
+		    EMAC_M1_TR0_MULTI;
+
+		/* set speed */
+		if (fep->phy_speed == _100BASET) {
+			mode_reg = mode_reg | EMAC_M1_MF_100MBPS;	/* 100 MBPS */
+			zmii_port_speed(100, dev);
+		} else {
+			mode_reg = mode_reg & ~EMAC_M1_MF_100MBPS;	/* 10 MBPS */
+			zmii_port_speed(10, dev);
+		}
+
+		/* set duplex */
+		if (fep->phy_duplex == FULL)
+			mode_reg = mode_reg | EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_IST;
+		else
+			mode_reg = mode_reg & ~(EMAC_M1_FDE | EMAC_M1_EIFC | EMAC_M1_ILE);	/* half duplex */
+
+		out_be32(&emacp->em0mr1, mode_reg);
+	}
+}
--- linux.ori/drivers/net/ibm_ocp/ibm_ocp_zmii.c	Mon Mar 24 18:11:04 2003
+++ linux/drivers/net/ibm_ocp/ibm_ocp_zmii.c	Tue Nov  4 13:08:03 2003
@@ -105,6 +105,9 @@
 	if (speed == 100)
 		zmii_speed |= zmii_speed100[fep->emac_num];

+	if (speed == 10)
+		zmii_speed &= ~zmii_speed100[fep->emac_num];
+
 	out_be32(&zmiip->ssr, zmii_speed);
 	return;
 }


--------------020309060807030203040202--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
