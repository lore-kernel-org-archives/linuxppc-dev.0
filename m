Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 020D867A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 17:22:44 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j377QfR7028829
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 7 Apr 2005 10:26:44 +0300 (EEST)
Message-ID: <4254DD16.8000704@intracom.gr>
Date: Thu, 07 Apr 2005 10:11:18 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>, Jeff Garzik <jgarzik@pobox.com>,
	"'kumar.gala@freescale.com'" <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="------------070305010301090601030904"
Subject: [PATCH] Update fec_8xx to new platform device model
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070305010301090601030904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all

The following patch updates the in-tree fec_8xx driver
to use the new platform device model.

Regards

Pantelis


--------------070305010301090601030904
Content-Type: text/x-patch;
 name="fec_8xx-platform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec_8xx-platform.patch"

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/net/Makefile linux-2.5-intracom/drivers/net/Makefile
--- linux-2.5/drivers/net/Makefile	2005-03-28 10:27:10 +03:00
+++ linux-2.5-intracom/drivers/net/Makefile	2005-03-28 13:16:55 +03:00
@@ -194,3 +194,6 @@
 obj-$(CONFIG_ETRAX_ETHERNET) += cris/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+
+obj-$(CONFIG_FEC_8XX) += fec_8xx/ mii.o
+
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/net/fec_8xx/Kconfig linux-2.5-intracom/drivers/net/fec_8xx/Kconfig
--- linux-2.5/drivers/net/fec_8xx/Kconfig	2004-07-08 09:54:06 +03:00
+++ linux-2.5-intracom/drivers/net/fec_8xx/Kconfig	2005-04-07 09:40:15 +03:00
@@ -1,6 +1,6 @@
 config FEC_8XX
 	tristate "Motorola 8xx FEC driver"
-	depends on NET_ETHERNET && 8xx && (NETTA || NETPHONE)
+	depends on NET_ETHERNET && 8xx
 	select MII
 
 config FEC_8XX_GENERIC_PHY
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/net/fec_8xx/Makefile linux-2.5-intracom/drivers/net/fec_8xx/Makefile
--- linux-2.5/drivers/net/fec_8xx/Makefile	2004-07-08 09:54:06 +03:00
+++ linux-2.5-intracom/drivers/net/fec_8xx/Makefile	2005-04-07 09:40:15 +03:00
@@ -5,8 +5,3 @@
 obj-$(CONFIG_FEC_8XX) += fec_8xx.o
 
 fec_8xx-objs := fec_main.o fec_mii.o
-
-# the platform instantatiation objects
-ifeq ($(CONFIG_NETTA),y)
-fec_8xx-objs	+= fec_8xx-netta.o
-endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/net/fec_8xx/fec_8xx-netta.c linux-2.5-intracom/drivers/net/fec_8xx/fec_8xx-netta.c
--- linux-2.5/drivers/net/fec_8xx/fec_8xx-netta.c	2004-10-25 09:50:47 +03:00
+++ linux-2.5-intracom/drivers/net/fec_8xx/fec_8xx-netta.c	1970-01-01 02:00:00 +02:00
@@ -1,153 +0,0 @@
-/*
- * FEC instantatiation file for NETTA
- */
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/ptrace.h>
-#include <linux/errno.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/bitops.h>
-
-#include <asm/8xx_immap.h>
-#include <asm/pgtable.h>
-#include <asm/mpc8xx.h>
-#include <asm/irq.h>
-#include <asm/uaccess.h>
-#include <asm/commproc.h>
-
-#include "fec_8xx.h"
-
-/*************************************************/
-
-static struct fec_platform_info fec1_info = {
-	.fec_no = 0,
-	.use_mdio = 1,
-	.phy_addr = 8,
-	.fec_irq = SIU_LEVEL1,
-	.phy_irq = CPM_IRQ_OFFSET + CPMVEC_PIO_PC6,
-	.rx_ring = 128,
-	.tx_ring = 16,
-	.rx_copybreak = 240,
-	.use_napi = 1,
-	.napi_weight = 17,
-};
-
-static struct fec_platform_info fec2_info = {
-	.fec_no = 1,
-	.use_mdio = 1,
-	.phy_addr = 2,
-	.fec_irq = SIU_LEVEL3,
-	.phy_irq = CPM_IRQ_OFFSET + CPMVEC_PIO_PC7,
-	.rx_ring = 128,
-	.tx_ring = 16,
-	.rx_copybreak = 240,
-	.use_napi = 1,
-	.napi_weight = 17,
-};
-
-static struct net_device *fec1_dev;
-static struct net_device *fec2_dev;
-
-/* XXX custom u-boot & Linux startup needed */
-extern const char *__fw_getenv(const char *var);
-
-/* access ports */
-#define setbits32(_addr, _v) __fec_out32(&(_addr), __fec_in32(&(_addr)) |  (_v))
-#define clrbits32(_addr, _v) __fec_out32(&(_addr), __fec_in32(&(_addr)) & ~(_v))
-
-#define setbits16(_addr, _v) __fec_out16(&(_addr), __fec_in16(&(_addr)) |  (_v))
-#define clrbits16(_addr, _v) __fec_out16(&(_addr), __fec_in16(&(_addr)) & ~(_v))
-
-int fec_8xx_platform_init(void)
-{
-	immap_t *immap = (immap_t *)IMAP_ADDR;
-	bd_t *bd = (bd_t *) __res;
-	const char *s;
-	char *e;
-	int i;
-
-	/* use MDC for MII */
-	setbits16(immap->im_ioport.iop_pdpar, 0x0080);
-	clrbits16(immap->im_ioport.iop_pddir, 0x0080);
-
-	/* configure FEC1 pins */
-	setbits16(immap->im_ioport.iop_papar, 0xe810);
-	setbits16(immap->im_ioport.iop_padir, 0x0810);
-	clrbits16(immap->im_ioport.iop_padir, 0xe000);
-
-	setbits32(immap->im_cpm.cp_pbpar, 0x00000001);
-	clrbits32(immap->im_cpm.cp_pbdir, 0x00000001);
-
-	setbits32(immap->im_cpm.cp_cptr, 0x00000100);
-	clrbits32(immap->im_cpm.cp_cptr, 0x00000050);
-
-	clrbits16(immap->im_ioport.iop_pcpar, 0x0200);
-	clrbits16(immap->im_ioport.iop_pcdir, 0x0200);
-	clrbits16(immap->im_ioport.iop_pcso, 0x0200);
-	setbits16(immap->im_ioport.iop_pcint, 0x0200);
-
-	/* configure FEC2 pins */
-	setbits32(immap->im_cpm.cp_pepar, 0x00039620);
-	setbits32(immap->im_cpm.cp_pedir, 0x00039620);
-	setbits32(immap->im_cpm.cp_peso, 0x00031000);
-	clrbits32(immap->im_cpm.cp_peso, 0x00008620);
-
-	setbits32(immap->im_cpm.cp_cptr, 0x00000080);
-	clrbits32(immap->im_cpm.cp_cptr, 0x00000028);
-
-	clrbits16(immap->im_ioport.iop_pcpar, 0x0200);
-	clrbits16(immap->im_ioport.iop_pcdir, 0x0200);
-	clrbits16(immap->im_ioport.iop_pcso, 0x0200);
-	setbits16(immap->im_ioport.iop_pcint, 0x0200);
-
-	/* fill up */
-	fec1_info.sys_clk = bd->bi_intfreq;
-	fec2_info.sys_clk = bd->bi_intfreq;
-
-	s = __fw_getenv("ethaddr");
-	if (s != NULL) {
-		for (i = 0; i < 6; i++) {
-			fec1_info.macaddr[i] = simple_strtoul(s, &e, 16);
-			if (*e)
-				s = e + 1;
-		}
-	}
-
-	s = __fw_getenv("eth1addr");
-	if (s != NULL) {
-		for (i = 0; i < 6; i++) {
-			fec2_info.macaddr[i] = simple_strtoul(s, &e, 16);
-			if (*e)
-				s = e + 1;
-		}
-	}
-
-	fec_8xx_init_one(&fec1_info, &fec1_dev);
-	fec_8xx_init_one(&fec2_info, &fec2_dev);
-
-	return fec1_dev != NULL && fec2_dev != NULL ? 0 : -1;
-}
-
-void fec_8xx_platform_cleanup(void)
-{
-	if (fec2_dev != NULL)
-		fec_8xx_cleanup_one(fec2_dev);
-
-	if (fec1_dev != NULL)
-		fec_8xx_cleanup_one(fec1_dev);
-}
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/net/fec_8xx/fec_8xx.h linux-2.5-intracom/drivers/net/fec_8xx/fec_8xx.h
--- linux-2.5/drivers/net/fec_8xx/fec_8xx.h	2004-07-08 09:54:06 +03:00
+++ linux-2.5-intracom/drivers/net/fec_8xx/fec_8xx.h	2005-04-07 09:40:15 +03:00
@@ -3,8 +3,8 @@
 
 #include <linux/mii.h>
 #include <linux/netdevice.h>
-
 #include <linux/types.h>
+#include <linux/fec_8xx_pd.h>
 
 /* HW info */
 
@@ -83,21 +83,6 @@
 #define PKT_MAXBLR_SIZE		((PKT_MAXBUF_SIZE+3) & ~3)
 /* This is needed so that invalidate_xxx wont invalidate too much */
 #define ENET_RX_FRSIZE		L1_CACHE_ALIGN(PKT_MAXBUF_SIZE)
-
-/* platform interface */
-
-struct fec_platform_info {
-	int fec_no;		/* FEC index                  */
-	int use_mdio;		/* use external MII           */
-	int phy_addr;		/* the phy address            */
-	int fec_irq, phy_irq;	/* the irq for the controller */
-	int rx_ring, tx_ring;	/* number of buffers on rx    */
-	int sys_clk;		/* system clock               */
-	__u8 macaddr[6];	/* mac address                */
-	int rx_copybreak;	/* limit we copy small frames */
-	int use_napi;		/* use NAPI                   */
-	int napi_weight;	/* NAPI weight                */
-};
 
 /* forward declaration */
 struct fec;
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/net/fec_8xx/fec_main.c linux-2.5-intracom/drivers/net/fec_8xx/fec_main.c
--- linux-2.5/drivers/net/fec_8xx/fec_main.c	2004-10-25 09:50:47 +03:00
+++ linux-2.5-intracom/drivers/net/fec_8xx/fec_main.c	2005-04-07 09:40:15 +03:00
@@ -70,7 +70,7 @@
 
 /*****************************************************************************************/
 
-static void fec_whack_reset(fec_t * fecp)
+static int fec_whack_reset(fec_t * fecp)
 {
 	int i;
 
@@ -78,14 +78,13 @@
 	 * Whack a reset.  We should wait for this.  
 	 */
 	FW(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_RESET);
-	for (i = 0;
-	     (FR(fecp, ecntrl) & FEC_ECNTRL_RESET) != 0 && i < FEC_RESET_DELAY;
-	     i++)
+	for (i = 0; i < FEC_RESET_DELAY; i++) {
+		if ((FR(fecp, ecntrl) & FEC_ECNTRL_RESET) == 0)
+			return 0;	/* OK */
 		udelay(1);
+	}
 
-	if (i == FEC_RESET_DELAY)
-		printk(KERN_WARNING "FEC Reset timeout!\n");
-
+	return -1;
 }
 
 /****************************************************************************/
@@ -246,10 +245,13 @@
 	const struct fec_platform_info *fpi = fep->fpi;
 	cbd_t *bdp;
 	struct sk_buff *skb;
-	int i;
+	int i, r;
 	__u32 addrhi, addrlo;
 
-	fec_whack_reset(fep->fecp);
+	r = fec_whack_reset(fep->fecp);
+	if (r != 0)
+		printk(KERN_ERR DRV_MODULE_NAME
+				": %s FEC Reset FAILED!\n", dev->name);
 
 	/*
 	 * Set station address. 
@@ -478,7 +480,7 @@
 	int received = 0;
 	__u16 pkt_len, sc;
 	int curidx;
-	int rx_work_limit;
+	int rx_work_limit = 0;	/* pacify gcc */
 
 	if (fpi->use_napi) {
 		rx_work_limit = min(dev->quota, *budget);
@@ -1067,20 +1069,19 @@
 	return rc;
 }
 
-int fec_8xx_init_one(const struct fec_platform_info *fpi,
-		     struct net_device **devp)
+int fec_8xx_init_instance(const struct fec_platform_info *fpi, struct net_device **ndevp)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	static int fec_8xx_version_printed = 0;
-	struct net_device *dev = NULL;
+	struct net_device *ndev = NULL;
 	struct fec_enet_private *fep = NULL;
 	fec_t *fecp = NULL;
-	int i;
+	int i, r;
 	int err = 0;
 	int registered = 0;
 	__u32 siel;
 
-	*devp = NULL;
+	*ndevp = NULL;
 
 	switch (fpi->fec_no) {
 	case 0:
@@ -1096,22 +1097,26 @@
 	}
 
 	if (fec_8xx_version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+		printk(KERN_INFO DRV_MODULE_NAME
+				"%s", version);
 
 	i = sizeof(*fep) + (sizeof(struct sk_buff **) *
 			    (fpi->rx_ring + fpi->tx_ring));
 
-	dev = alloc_etherdev(i);
-	if (!dev) {
+	ndev = alloc_etherdev(i);
+	if (!ndev) {
 		err = -ENOMEM;
 		goto err;
 	}
-	SET_MODULE_OWNER(dev);
+	SET_MODULE_OWNER(ndev);
 
-	fep = netdev_priv(dev);
+	fep = netdev_priv(ndev);
 
 	/* partial reset of FEC */
-	fec_whack_reset(fecp);
+	r = fec_whack_reset(fecp);
+	if (r != 0)
+		printk(KERN_ERR DRV_MODULE_NAME
+				": %s FEC Reset FAILED!\n", ndev->name);
 
 	/* point rx_skbuff, tx_skbuff */
 	fep->rx_skbuff = (struct sk_buff **)&fep[1];
@@ -1128,7 +1133,7 @@
 	 * Set the Ethernet address. 
 	 */
 	for (i = 0; i < 6; i++)
-		dev->dev_addr[i] = fpi->macaddr[i];
+		ndev->dev_addr[i] = fpi->macaddr[i];
 
 	fep->ring_base = dma_alloc_coherent(NULL,
 					    (fpi->tx_ring + fpi->rx_ring) *
@@ -1136,7 +1141,7 @@
 					    GFP_KERNEL);
 	if (fep->ring_base == NULL) {
 		printk(KERN_ERR DRV_MODULE_NAME
-		       ": %s dma alloc failed.\n", dev->name);
+		       ": %s dma alloc failed.\n", ndev->name);
 		err = -ENOMEM;
 		goto err;
 	}
@@ -1166,20 +1171,20 @@
 	/*
 	 * The FEC Ethernet specific entries in the device structure. 
 	 */
-	dev->open = fec_enet_open;
-	dev->hard_start_xmit = fec_enet_start_xmit;
-	dev->tx_timeout = fec_timeout;
-	dev->watchdog_timeo = TX_TIMEOUT;
-	dev->stop = fec_enet_close;
-	dev->get_stats = fec_enet_get_stats;
-	dev->set_multicast_list = fec_set_multicast_list;
-	dev->set_mac_address = fec_set_mac_address;
+	ndev->open = fec_enet_open;
+	ndev->hard_start_xmit = fec_enet_start_xmit;
+	ndev->tx_timeout = fec_timeout;
+	ndev->watchdog_timeo = TX_TIMEOUT;
+	ndev->stop = fec_enet_close;
+	ndev->get_stats = fec_enet_get_stats;
+	ndev->set_multicast_list = fec_set_multicast_list;
+	ndev->set_mac_address = fec_set_mac_address;
 	if (fpi->use_napi) {
-		dev->poll = fec_enet_poll;
-		dev->weight = fpi->napi_weight;
+		ndev->poll = fec_enet_poll;
+		ndev->weight = fpi->napi_weight;
 	}
-	dev->ethtool_ops = &fec_ethtool_ops;
-	dev->do_ioctl = fec_ioctl;
+	ndev->ethtool_ops = &fec_ethtool_ops;
+	ndev->do_ioctl = fec_ioctl;
 
 	fep->fec_phy_speed =
 	    ((((fpi->sys_clk + 4999999) / 2500000) / 2) & 0x3F) << 1;
@@ -1194,33 +1199,41 @@
 	FW(fecp, r_cntrl, FEC_RCNTRL_MII_MODE);	/* MII enable */
 	FW(fecp, ecntrl, FEC_ECNTRL_PINMUX | FEC_ECNTRL_ETHER_EN);
 
-	netif_carrier_off(dev);
+	netif_carrier_off(ndev);
 
-	err = register_netdev(dev);
+	err = register_netdev(ndev);
 	if (err != 0)
 		goto err;
 	registered = 1;
 
 	if (fpi->use_mdio) {
-		fep->mii_if.dev = dev;
+		fep->mii_if.dev = ndev;
 		fep->mii_if.mdio_read = fec_mii_read;
 		fep->mii_if.mdio_write = fec_mii_write;
 		fep->mii_if.phy_id_mask = 0x1f;
 		fep->mii_if.reg_num_mask = 0x1f;
-		fep->mii_if.phy_id = fec_mii_phy_id_detect(dev);
+		fep->mii_if.phy_id = fec_mii_phy_id_detect(ndev);
+	} else {
+		spin_lock_irq(&fep->lock);
+		fec_restart(ndev, 1, 100);	/* XXX this sucks */
+		spin_unlock_irq(&fep->lock);
+
+		netif_carrier_on(ndev);
+
+		netif_start_queue(ndev);
 	}
 
-	*devp = dev;
+	*ndevp = ndev;
 
 	return 0;
 
       err:
-	if (dev != NULL) {
+	if (ndev != NULL) {
 		if (fecp != NULL)
 			fec_whack_reset(fecp);
 
 		if (registered)
-			unregister_netdev(dev);
+			unregister_netdev(ndev);
 
 		if (fep != NULL) {
 			if (fep->ring_base)
@@ -1230,25 +1243,29 @@
 						  sizeof(cbd_t), fep->ring_base,
 						  fep->ring_mem_addr);
 		}
-		free_netdev(dev);
+		free_netdev(ndev);
 	}
 	return err;
 }
 
-int fec_8xx_cleanup_one(struct net_device *dev)
+int fec_8xx_cleanup_instance(struct net_device *ndev)
 {
-	struct fec_enet_private *fep = netdev_priv(dev);
+	struct fec_enet_private *fep = netdev_priv(ndev);
 	fec_t *fecp = fep->fecp;
 	const struct fec_platform_info *fpi = fep->fpi;
+	int r;
 
-	fec_whack_reset(fecp);
+	r = fec_whack_reset(fecp);
+	if (r != 0)
+		printk(KERN_ERR DRV_MODULE_NAME
+				": %s FEC Reset FAILED!\n", ndev->name);
 
-	unregister_netdev(dev);
+	unregister_netdev(ndev);
 
 	dma_free_coherent(NULL, (fpi->tx_ring + fpi->rx_ring) * sizeof(cbd_t),
 			  fep->ring_base, fep->ring_mem_addr);
 
-	free_netdev(dev);
+	free_netdev(ndev);
 
 	return 0;
 }
@@ -1257,14 +1274,51 @@
 /**************************************************************************************/
 /**************************************************************************************/
 
+static int __devinit
+mpc8xx_fec_probe(struct device *dev)
+{
+	struct net_device *ndev;
+	int r;
+
+	r = fec_8xx_init_instance(dev->platform_data, &ndev);
+	if (r != 0)
+		return r;
+
+	dev_set_drvdata(dev, ndev);
+	return 0;
+}
+
+static int
+mpc8xx_fec_remove(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+
+	fec_8xx_cleanup_instance(ndev);
+
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct device_driver mpc8xx_fec_driver = {
+	.name	  	= MPC8XX_FEC_NAME,
+	.bus		= &platform_bus_type,
+	.probe		= mpc8xx_fec_probe,
+	.remove		= mpc8xx_fec_remove,
+#ifdef CONFIG_PM
+/*	.suspend	= mpc8xx_fec_suspend,	TODO */
+/*	.resume		= mpc8xx_fec_resume,	TODO */
+#endif
+};
+
 static int __init fec_8xx_init(void)
 {
-	return fec_8xx_platform_init();
+	return driver_register(&mpc8xx_fec_driver);
 }
 
 static void __exit fec_8xx_cleanup(void)
 {
-	fec_8xx_platform_cleanup();
+	driver_unregister(&mpc8xx_fec_driver);
 }
 
 /**************************************************************************************/
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/fec_8xx_pd.h linux-2.5-intracom/include/linux/fec_8xx_pd.h
--- linux-2.5/include/linux/fec_8xx_pd.h	1970-01-01 02:00:00 +02:00
+++ linux-2.5-intracom/include/linux/fec_8xx_pd.h	2005-04-07 09:41:53 +03:00
@@ -0,0 +1,22 @@
+#ifndef FEC_8XX_PD_H
+#define FEC_8XX_PD_H
+
+#include <asm/types.h>
+
+#define MPC8XX_FEC_NAME	"FEC"
+
+/* XXX */
+struct fec_platform_info {
+	int fec_no;		/* FEC index                  */
+	int use_mdio;		/* use external MII           */
+	int phy_addr;		/* the phy address            */
+	int fec_irq, phy_irq;	/* the irq for the controller */
+	int rx_ring, tx_ring;	/* number of buffers on rx    */
+	int sys_clk;		/* system clock               */
+	__u8 macaddr[6];	/* mac address                */
+	int rx_copybreak;	/* limit we copy small frames */
+	int use_napi;		/* use NAPI                   */
+	int napi_weight;	/* NAPI weight                */
+};
+
+#endif

--------------070305010301090601030904--
