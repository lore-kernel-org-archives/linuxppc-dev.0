Date: Fri, 7 Sep 2001 20:13:41 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Dan Malek <dan@mvista.com>
Subject: [PATCH] some fixups for ppc405_enet init code
Message-ID: <20010907201341.A1856@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii

This change is for Config.in and the Makefile to add the
ppc405_enet driver.

I also removed the _probe1 function and moved the code down
into the init function. This was done for 2 reasons: 1 the
dev->name is not know until the device is registered and
2 so the code would be removed after init.

I also added a kfree of the private data when the register
fails and when the module is removed.

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc_enet.diff"

diff -ur linux-bk/drivers/net/Config.in linux-bk-local/drivers/net/Config.in
--- linux-bk/drivers/net/Config.in	Fri Sep  7 08:36:06 2001
+++ linux-bk-local/drivers/net/Config.in	Fri Sep  7 17:44:46 2001
@@ -42,7 +42,7 @@
       tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
       tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
       if [ "$CONFIG_405GP" = "y" ]; then
-        bool '  PowerPC 405 on-chip ethernet' CONFIG_PPC405_ENET
+        tristate '  PowerPC 405 on-chip ethernet' CONFIG_PPC405_ENET
         if [ "$CONFIG_PPC405_ENET" = "y" ]; then
           int  '    PHY Address' CONFIG_PPC405_ENET_PHY_ADDR 1
           bool '    Include extended error messages' CONFIG_PPC405_ENET_ERROR_MSG n
diff -ur linux-bk/drivers/net/Makefile linux-bk-local/drivers/net/Makefile
--- linux-bk/drivers/net/Makefile	Fri Sep  7 08:36:31 2001
+++ linux-bk-local/drivers/net/Makefile	Fri Sep  7 17:45:38 2001
@@ -205,6 +205,7 @@
 obj-$(CONFIG_MAC89x0) += mac89x0.o
 obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_DL2K) += dl2k.o
+obj-$(CONFIG_PPC405_ENET) += ppc405_enet.o

 ifeq ($(CONFIG_ARCH_ACORN),y)
 mod-subdirs	+= ../acorn/net
diff -ur linux-bk/drivers/net/ppc405_enet.c linux-bk-local/drivers/net/ppc405_enet.c
--- linux-bk/drivers/net/ppc405_enet.c	Fri Sep  7 08:36:05 2001
+++ linux-bk-local/drivers/net/ppc405_enet.c	Fri Sep  7 18:50:44 2001
@@ -55,7 +55,6 @@

 #include "ppc405_enet.h"

-static int	ppc405_enet_probe1(struct net_device *);
 static int	ppc405_phy_speed(void);
 static int	ppc405_phy_duplex(void);
 static int	ppc405_phy_read(unsigned char, unsigned short *);
@@ -455,65 +454,6 @@


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
 ppc405_phy_speed(void)
 {
 	int speed = _10BASET;
@@ -1248,15 +1188,67 @@
 static int __init
 init_ppc405_enet(void)
 {
-	int rc;
+	int     rc;
+	int	delay, i;
+	bd_t	*bd;
+        struct net_device* dev;
+	struct ppc405_enet_private *lo_priv;

-	rc = ppc405_enet_probe1(&ppc405_enet_dev);
-	if (rc)
-		return rc;
+        dev = &ppc405_enet_dev;
+	/* Reset the MAL */
+	mtdcr(DCRN_MALCR, MALCR_MMSR);
+
+	/* Reset the EMAC */
+	ppc405_enet_regp->em0mr0 = EMAC_M0_SRST;
+	eieio();
+	for (delay = 0; delay < 1000; delay++);
+	ppc405_enet_regp->em0mr0 = ppc405_enet_regp->em0mr0 & ~EMAC_M0_SRST;
+	eieio();
+
+	/* read the MAC Address */
+	bd = (bd_t *)__res;
+	for (i=0; i<6; i++) {
+		dev->dev_addr[i] = bd->bi_enetaddr[i];
+	}
+
+	dev->base_addr = 0xffe0;  /* indicate no actual physical probing */
+	dev->irq = BL_MAC0_WOL;   /* the first ethernet irq - need something here */
+
+	/* initialize the private data pointer */
+	lo_priv = (void *)(((long)kmalloc(
+		sizeof(struct ppc405_enet_private),
+		GFP_KERNEL | GFP_DMA) + 7) & ~7);
+	memset(lo_priv, 0, sizeof(struct ppc405_enet_private));
+	dev->priv = lo_priv;
+
+	/* Find out the default network settings from the phy */
+	lo_priv->ep_speed  = ppc405_phy_speed();
+	lo_priv->ep_duplex = ppc405_phy_duplex();
+
+	/* Fill in the driver function table */
+	dev->open               = &ppc405_enet_open;
+	dev->hard_start_xmit    = &ppc405_enet_start_xmit;
+	dev->stop               = &ppc405_enet_close;
+	dev->get_stats          = &ppc405_enet_stats;
+	dev->set_multicast_list = &ppc405_enet_set_multicast_list;
+
+	/* Fill in the generic fields of the device structure. */
+	ether_setup(dev);
+
+        /*Let the net/core keep track of module use count*/
+        SET_MODULE_OWNER(dev);

-	rc = register_netdev(&ppc405_enet_dev);
-	if (rc)
+	rc = register_netdev(dev);
+	if (rc){
+                kfree(dev->priv);
 		return rc;
+        }
+	printk(KERN_NOTICE "%s: PPC405 EMAC %d Mbs %s duplex "
+               "MAC %02x:%02x:%02x:%02x:%02x:%02x\n",
+               dev->name, lo_priv->ep_speed,
+               (lo_priv->ep_duplex == HALF)? "Half": "Full",
+               dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2],
+               dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5] );

 	return 0;
 }
@@ -1265,6 +1257,9 @@
 exit_ppc405_enet(void)
 {
 	unregister_netdev(&ppc405_enet_dev);
+        if( ppc405_enet_dev.priv )
+                kfree(ppc405_enet_dev.priv);
+        ppc405_enet_dev.priv = 0;
 }

 module_init(init_ppc405_enet);

--HcAYCG3uE/tztfnV--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
