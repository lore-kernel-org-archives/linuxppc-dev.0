Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id F12E367A05
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 00:35:45 +1000 (EST)
Message-ID: <4278DDBF.8080705@ru.mvista.com>
Date: Wed, 04 May 2005 18:35:43 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------080000030708060304070100"
Subject: [RFC][PATCH 2.6.12-rc2 3/3] FCC Ethernet PlatformDevice support for
 82xx
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
--------------080000030708060304070100
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This patch contains actual Ethernet driver on platform bus. Currently 
tested on MPC8272ADS  (PQII) board.

Signed-off-by: Vitaly Bordug<vbordug@ru.mvista.com>

-- 
Sincerely, 
Vitaly


--------------080000030708060304070100
Content-Type: text/x-patch;
 name="fcc_pdev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fcc_pdev.patch"

diff -Nru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2005-05-04 17:09:58 +04:00
+++ b/drivers/net/Kconfig	2005-05-04 17:09:58 +04:00
@@ -1761,6 +1761,20 @@
 
 source "drivers/net/fec_8xx/Kconfig"
 
+config CPM2_FCC_ENET
+	tristate "CPM2 Fast Ethernet Controller (FCC)"
+	depends on CPM2 
+	help
+	  This driver supports Fast Ethernet Controller (FCC) on 82xx family.
+
+config USE_MDIO
+	bool "Use MDIO for PHY configuration"
+	depends on CPM2_FCC_ENET
+
+config CPM2_FCC_ENET_NAPI
+	bool "NAPI Support"
+	depends on CPM2_FCC_ENET
+
 endmenu
 
 #
diff -Nru a/drivers/net/Makefile b/drivers/net/Makefile
--- a/drivers/net/Makefile	2005-05-04 17:09:58 +04:00
+++ b/drivers/net/Makefile	2005-05-04 17:09:58 +04:00
@@ -11,9 +11,11 @@
 obj-$(CONFIG_IXGB) += ixgb/
 obj-$(CONFIG_BONDING) += bonding/
 obj-$(CONFIG_GIANFAR) += gianfar_driver.o
+obj-$(CONFIG_CPM2_FCC_ENET)+= cpm2_fcc_driver.o
 
 gianfar_driver-objs := gianfar.o gianfar_ethtool.o gianfar_phy.o
-
+cpm2_fcc_driver-objs:= cpm2_fcc_enet.o cpm2_fcc_ethtool.o cpm2_fcc_phy.o
+ 
 #
 # link order important here
 #
diff -Nru a/drivers/net/cpm2_fcc_enet.c b/drivers/net/cpm2_fcc_enet.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/net/cpm2_fcc_enet.c	2005-05-04 17:09:58 +04:00
@@ -0,0 +1,1673 @@
+/*
+ * drivers/net/cpm2_fcc_enet.c
+ *
+ * Fast Ethernet Controller (FCC) driver for Motorola MPC8260/8560.
+ * Copyright (c) 2000 MontaVista Software, Inc.   Dan Malek (dmalek@jlc.net)
+ *
+ * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
+ * Andy Fleming <afleming@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+ 
+ /*
+ * This driver pulls much of its code from the Gianfar ethernet
+ * driver (for PQ3).
+ *
+ * Theory of operation
+ * This driver is designed for the Ethernet protocol on the FCC
+ * part of the CPM for 82xx and 85xx processors.
+ * 
+ *  The driver is initialized through OCP.  Structures which
+ *  define the configuration needed by the board are defined in a
+ *  board structure in arch/ppc/platforms (though I do not
+ *  discount the possibility that other architectures could one
+ *  day be supported).
+ * 
+ *  The FCC Ethernet Controller uses a ring of buffer
+ *  descriptors.  The beginning is indicated by a register
+ *  pointing to the physical address of the start of the ring. 
+ *  The end is determined by a "wrap" bit being set in the 
+ *  last descriptor of the ring.
+ *
+ *  When a packet is received, the RXF bit in the
+ *  FCCE register is set, triggering an interrupt when the
+ *  corresponding bit in the FCCM register is also set.
+ *  In NAPI, the interrupt handler will signal there is work
+ *  be done, and exit.  Without NAPI, the packet(s) will be
+ *  handled immediately.  Both methods will start at the last known
+ *  empty descriptor, and process every subsequent descriptor until the
+ *  limit is hit.  The data arrives inside a
+ *  pre-allocated skb, and so after the skb is passed up to the
+ *  stack, a new skb must be allocated, and the address field in
+ *  the buffer descriptor must be updated to indicate this new skb.
+ *
+ *  When the kernel requests that a packet be transmitted, the
+ *  driver starts where it left off last time, and points the
+ *  descriptor at the buffer which was passed in.  
+ *  Once the controller is finished transmitting
+ *  the packet, an interrupt may be triggered (under the same
+ *  conditions as for reception, but depending on the TXF bit).
+ *  The driver then cleans up the buffer.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/dma-mapping.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/fsl_devices.h>
+#include <linux/ioport.h>
+
+#include <asm/pgtable.h>
+#include <asm/mpc8260.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/bitops.h>
+#include <asm/uaccess.h>
+#include <asm/cpm2.h>
+#include <asm/ppc_sys.h>
+
+#include "cpm2_fcc_enet.h"
+#include "cpm2_fcc_phy.h"
+
+/* The transmitter timeout */
+#define TX_TIMEOUT	(2*HZ)
+#define SKB_ALLOC_TIMEOUT 1000000
+
+#ifdef CONFIG_CPM2_FCC_ENET_NAPI
+#define RECEIVE(x) netif_receive_skb(x)
+#else
+#define RECEIVE(x) netif_rx(x)
+#endif
+
+const char fcc_driver_name[] = "FCC Ethernet";
+const char fcc_driver_version[] = "0.5";
+
+/* Initialization/Shutdown functions */
+static int fcc_enet_probe(struct device *device);
+static int fcc_enet_remove(struct device *device);
+static int fcc_enet_open(struct net_device *dev);
+static int fcc_enet_close(struct net_device *dev);
+void fcc_stop(struct net_device *dev);
+int fcc_enet_startup(struct net_device *dev);
+static void init_fcc_param(struct net_device *dev);
+static int init_phy(struct net_device *dev);
+
+/* dev functions for kernel API */
+static int fcc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static void fcc_enet_timeout(struct net_device *dev);
+static struct net_device_stats *fcc_enet_get_stats(struct net_device *dev);
+static void fcc_enet_set_multi(struct net_device *dev);
+static int fcc_enet_change_mtu(struct net_device *dev, int new_mtu);
+
+/* Interrupt/Timer Handlers */
+static irqreturn_t fcc_enet_interrupt(int irq, void *dev_id, struct pt_regs *);
+int fcc_enet_rx(struct net_device *dev);
+#ifdef CONFIG_CPM2_FCC_ENET_NAPI
+static int fcc_enet_poll(struct net_device *dev, int *budget);
+#endif
+static void fcc_enet_tx(struct net_device *dev);
+#ifdef CONFIG_USE_MDIO
+static void fcc_phy_startup_timer(unsigned long data);
+static irqreturn_t mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs);
+static void fcc_enet_phy_change(void *data);
+static void fcc_enet_phy_timer(unsigned long data);
+#endif
+
+/* Miscellaneous Helper Functions */
+static int fcc_enet_set_mac_address(struct net_device *dev);
+struct sk_buff * fcc_enet_new_skb(struct net_device *dev, struct rxbd *bdp);
+void free_skb_resources(struct net_device *dev);
+static inline void cpm_write_command(struct fcc_enet_private *priv, u32 op);
+static void adjust_link(struct net_device *dev);
+static inline void count_errors(unsigned short status, struct fcc_enet_private *priv);
+static int fcc_enet_clean_rx_ring(struct net_device *dev, int rx_work_limit);
+static int fcc_enet_process_frame(struct net_device *dev, 
+		struct sk_buff *skb, int length);
+static void fcc_enet_set_hash_for_addr(struct net_device *dev, u8 *addr);
+
+MODULE_AUTHOR("Freescale, Inc");
+MODULE_DESCRIPTION("FCC Ethernet Driver");
+MODULE_LICENSE("GPL");
+
+/* Initialize the I/O pins for the FCC Ethernet. */
+static void init_fcc_ioports(struct fcc_enet_private *priv)
+{
+	struct cpm2_fec_platform_data *fcc_info = priv->fcc_info;
+	/* FCC1 pins are on port A/C.  FCC2/3 are port B/C. */
+	/* Configure port A and C pins for FCC1 Ethernet. */
+	cpm2_pin_program(PORTA,1,
+		PA1_DIRA0|PA1_DIRA1, 	/*par*/
+		0,			/*odr*/
+		PA1_DIRA1,		/*dir*/
+		PA1_PSORA1,		/*sor*/
+		0);			/*dat*/
+	cpm2_pin_program(PORTA,0,
+		0,
+		0,
+		PA1_DIRA0,
+		PA1_PSORA0,
+		0);
+	cpm2_pin_program(PORTB,1,
+		(PB2_DIRB0 | PB2_DIRB1),
+		0,
+		PB2_DIRB1,
+		PB2_PSORB1,
+		0);
+	cpm2_pin_program(PORTB,0,
+		0,
+		0,
+		PB2_DIRB0,
+		PB2_PSORB0,
+		0);
+	/* Port C has clocks...... */
+
+	cpm2_pin_program(PORTC,1,
+		(PC_F1RXCLK | PC_F1TXCLK | PC_F2RXCLK | PC_F2TXCLK),
+		0,
+		0,
+		0,
+		0);
+	cpm2_pin_program(PORTC,0,
+		0,
+		0,
+		(PC_F1RXCLK | PC_F1TXCLK | PC_F2RXCLK | PC_F2TXCLK),
+		(PC_F1RXCLK | PC_F1TXCLK | PC_F2RXCLK | PC_F2TXCLK),
+		0);
+
+
+#ifdef CONFIG_USE_MDIO
+	/* ....and the MII serial clock/data. */
+	cpm2_pin_program(PORTC,1,
+		0,
+		0,
+		(fcc_info->mdio | fcc_info->mdck),
+		0,
+		(fcc_info->mdio | fcc_info->mdck));
+#endif /* CONFIG_USE_MDIO */
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all FCC bits to zero,
+	 * then set the ones we want.
+	 */
+	cpm2_cpmux_alter_fcr(fcc_info->clk_route,fcc_info->clk_mask);
+}
+
+
+/* Called by the PD code to initialize device data structures
+ * required for bringing up the device
+ * returns 0 on success */
+static int fcc_enet_probe(struct device* device)
+{
+	u32 tempval;
+	struct net_device *dev;
+	struct fcc_enet_private *priv;
+	struct platform_device *pdev = to_platform_device(device);
+	struct cpm2_fec_platform_data *fcc_info;
+	struct resource *r;
+	int idx;
+	int err = 0;
+	
+	fcc_info = (struct cpm2_fec_platform_data *) pdev->dev.platform_data;
+	if(fcc_info == NULL) {
+		printk(KERN_ERR "fcc %d: Missing additional data!\n",
+				pdev->id);
+
+		return -ENODEV;
+	}
+
+	/* Create the ethernet device instance */
+	dev = alloc_etherdev(sizeof (*priv));
+
+	if (dev == NULL)
+		return -ENOMEM;
+
+	priv = netdev_priv(dev);
+
+	/* Set the info in the priv to the current info */
+	priv->fcc_info = fcc_info;
+
+	/* fill out IRQ fields */
+	priv->interrupt     = platform_get_irq_byname(pdev,"interrupt");
+	priv->PHYinterrupt  = platform_get_irq_byname(pdev,"phyinterrupt");	
+	
+	/* Make sure the memory for the FCC Parameter RAM is mapped */
+	r = platform_get_resource_byname(pdev,IORESOURCE_MEM,"fcc_pram");
+	priv->regs = (struct fcc_enet *)r->start;
+
+	if (priv->regs == NULL) {
+		err = -ENOMEM;
+		goto regs_fail;
+	}
+
+	dev_set_drvdata(device, dev);
+
+	spin_lock_init(&priv->lock);
+
+	/* Map the FCC registers */
+	r = platform_get_resource_byname(pdev,IORESOURCE_MEM,"fcc_regs");
+	priv->fccregs = (struct fcc *)r->start;
+
+	if (priv->fccregs == NULL) {
+		err = -ENOMEM;
+		goto fcc_fail;
+	}
+
+	/* Map the FCC Internal Memory */
+	r = platform_get_resource_byname(pdev,IORESOURCE_MEM,"fcc_mem");
+	priv->membase = r->start;
+	priv->fccmem = (char *)r->start;
+	
+	if (priv->fccmem == NULL) {
+		err = -ENOMEM;
+		goto fccmem_fail;
+	}
+
+	/* Disable receive and transmit in case someone left it running. */
+	tempval = fcc_enet_read32(&priv->fccregs->fcc_gfmr);
+	tempval &= ~(FCC_GFMR_ENR | FCC_GFMR_ENT);
+	fcc_enet_write32(&priv->fccregs->fcc_gfmr, tempval);
+
+	init_fcc_ioports(priv);
+
+	/* Copy the station address into the dev structure */
+	memcpy(dev->dev_addr, fcc_info->mac_addr, MAC_ADDR_LEN);
+
+	/* Set the dev base_addr to the FCC registers */
+	dev->base_addr = (unsigned long)(priv->regs);
+
+	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, device);
+
+	/* Fill in the dev structure */
+	dev->open = fcc_enet_open;
+	dev->hard_start_xmit = fcc_enet_start_xmit;
+	dev->tx_timeout = fcc_enet_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
+#ifdef CONFIG_CPM2_FCC_ENET_NAPI
+	dev->poll = fcc_enet_poll;
+	dev->weight = FCC_ENET_DEV_WEIGHT;
+#endif
+	dev->stop = fcc_enet_close;
+	dev->get_stats = fcc_enet_get_stats;
+	dev->change_mtu = fcc_enet_change_mtu;
+	dev->mtu = 1500;
+	dev->set_multicast_list = fcc_enet_set_multi;
+
+	dev->ethtool_ops = &fcc_ethtool_ops;
+
+	priv->rx_buffer_size = DEFAULT_RX_BUFFER_SIZE;
+	priv->tx_ring_size = DEFAULT_TX_RING_SIZE;
+	priv->rx_ring_size = DEFAULT_RX_RING_SIZE;
+
+	err = register_netdev(dev);
+
+	if (err) {
+		printk(KERN_ERR "%s: Cannot register net device, aborting.\n",
+				dev->name);
+		goto register_fail;
+	}
+
+	/* Print out the device info */
+	printk(DEVICE_NAME, dev->name);
+	for (idx = 0; idx < 6; idx++)
+		printk("%2.2x%c", dev->dev_addr[idx], idx == 5 ? ' ' : ':');
+	printk("\n");
+
+	/* Even more device info helps when determining which kernel */
+	/* provided which set of benchmarks.  Since this is global for all */
+	/* devices, we only print it once */
+#ifdef CONFIG_CPM2_FCC_ENET_NAPI
+	printk(KERN_INFO "%s: Running with NAPI enabled\n", dev->name);
+#else
+	printk(KERN_INFO "%s: Running with NAPI disabled\n", dev->name);
+#endif
+	printk(KERN_INFO "%s: %d/%d RX/TX BD ring size\n",
+			dev->name, priv->rx_ring_size, priv->tx_ring_size);
+
+	return 0;
+
+register_fail:
+	iounmap((void *) priv->fccmem);
+fccmem_fail:
+	iounmap((void *) priv->fccregs);
+fcc_fail:
+	iounmap((void *) priv->regs);
+regs_fail:
+	free_netdev(dev);
+	return -ENOMEM;
+}
+
+
+static int fcc_enet_remove(struct device *device)
+{
+	struct net_device *dev = dev_get_drvdata(device);
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	dev_set_drvdata(device, NULL);
+
+	iounmap((void *) priv->fccmem);
+	iounmap((void *) priv->fccregs);
+	iounmap((void *) priv->regs);
+	free_netdev(dev);
+	return 0;
+}
+
+static int fcc_enet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	int tempsize;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	int oldsize = priv->rx_buffer_size;
+	int frame_size = new_mtu + 18;
+
+	if ((frame_size < 64) || (frame_size > 1518)) {
+		printk(KERN_ERR "%s: Invalid MTU setting\n", dev->name);
+		return -EINVAL;
+	}
+
+	tempsize = (frame_size & ~(INCREMENTAL_BUFFER_SIZE - 1)) +
+		INCREMENTAL_BUFFER_SIZE;
+
+	/* Only stop and start the controller if it isn't already
+	 * stopped */
+	if ((oldsize != tempsize) && (dev->flags & IFF_UP))
+		fcc_stop(dev);
+
+	priv->rx_buffer_size = tempsize;
+
+	dev->mtu = new_mtu;
+
+	/* Set maximum bytes per receive buffer.
+	 * It must be a multiple of 32. */
+	fcc_enet_write16(&priv->regs->fen_genfcc.fcc_mrblr, priv->rx_buffer_size);
+
+	/* Set maximum frame length register */
+	fcc_enet_write16(&priv->regs->fen_mflr, priv->rx_buffer_size);
+
+	if ((oldsize != tempsize) && (dev->flags & IFF_UP))
+		fcc_enet_startup(dev);
+
+	return 0;
+}
+
+
+static int fcc_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct txbd	*txbdp;
+
+	/* Update transmit stats */
+	priv->stats.tx_bytes += skb->len;
+
+	/* Lock priv now */
+	spin_lock_irq(&priv->lock);
+
+	/* Fill in a Tx ring entry */
+	txbdp = priv->cur_tx;
+
+	/* Clear all but the WRAP status flags */
+	txbdp->status &= TXBD_WRAP;
+
+	/* Set buffer length and buffer pointer. */
+	txbdp->length = skb->len;
+	txbdp->bufPtr = dma_map_single(NULL, skb->data, skb->len, DMA_TO_DEVICE);
+
+	/* Save skb pointer. */
+	priv->tx_skbuff[priv->skb_curtx] = skb;
+
+	priv->skb_curtx = 
+		(priv->skb_curtx + 1) & TX_RING_MOD_MASK(priv->tx_ring_size);
+
+	/* Send it on its way.  Tell CPM its ready, interrupt when done,
+	 * its the last BD of the frame, and to put the CRC on the end. */
+	txbdp->status |= (TXBD_READY | TXBD_INTERRUPT | TXBD_LAST | TXBD_CRC | TXBD_PAD);
+
+	dev->trans_start = jiffies;
+
+	/* If this was the last BD in the ring, start at the beginning again. */
+	if (txbdp->status & TXBD_WRAP)
+		txbdp = priv->tx_bd_base;
+	else
+		txbdp++;
+
+	/* If the next BD still needs to be cleaned up, then the bds
+	   are full.  We need to tell the kernel to stop sending us stuff. */
+	if (txbdp == priv->dirty_tx) {
+		netif_stop_queue(dev);
+
+		priv->stats.tx_fifo_errors++;
+	}
+
+	priv->cur_tx = txbdp;
+
+	spin_unlock_irq(&priv->lock);
+
+	return 0;
+}
+
+
+static void fcc_enet_timeout(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	priv->stats.tx_errors++;
+
+	if (dev->flags & IFF_UP) {
+		fcc_stop(dev);
+		fcc_enet_startup(dev);
+	}
+
+	netif_schedule(dev);
+}
+
+#define RXBUF_ALIGNMENT 64
+struct sk_buff * fcc_enet_new_skb(struct net_device *dev, struct rxbd *bdp)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct sk_buff *skb = NULL;
+	unsigned int timeout = SKB_ALLOC_TIMEOUT;
+
+	/* We have to allocate the skb, so keep trying till we succeed */
+	while ((!skb) && timeout--)
+		skb = dev_alloc_skb(priv->rx_buffer_size + RXBUF_ALIGNMENT);
+
+	if (skb == NULL)
+		return NULL;
+
+	/* We need the data buffer to be aligned properly.  We will reserve
+	 * as many bytes as needed to align the data properly
+	 */
+	skb_reserve(skb,
+			RXBUF_ALIGNMENT -
+			(((unsigned) skb->data) & (RXBUF_ALIGNMENT - 1)));
+
+	skb->dev = dev;
+
+	bdp->bufPtr = dma_map_single(NULL, skb->data,
+			priv->rx_buffer_size + RXBUF_ALIGNMENT,
+			DMA_FROM_DEVICE);
+	bdp->length = 0;
+
+	/* Mark the buffer empty */
+	bdp->status |= (RXBD_EMPTY | RXBD_INTERRUPT);
+
+	return skb;
+}
+
+
+/* The interrupt handler. */
+	static irqreturn_t 
+fcc_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+{
+	struct	net_device *dev = dev_id;
+	struct	fcc_enet_private *priv = netdev_priv(dev);
+	/* Get the interrupt events that caused us to be here.*/
+	u16 events = fcc_enet_read16(&priv->fccregs->fcc_fcce);
+
+	/* Clear the events */
+	fcc_enet_write16(&priv->fccregs->fcc_fcce, events);
+
+	/* Handle receive event in its own function. */
+	if (events & (FCC_ENET_RXF | FCC_ENET_RXB))
+		fcc_enet_rx(dev);
+
+	if (events & (FCC_ENET_TXB | FCC_ENET_TXE)) {
+		fcc_enet_tx(dev);
+	}
+
+	if (events & FCC_ENET_BSY) {
+		priv->stats.rx_errors++;
+		priv->extra_stats.rx_bsy++;
+
+		fcc_enet_rx(dev);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static inline void cpm_write_command(struct fcc_enet_private *priv, u32 op)
+{
+	u32 cmd = mk_cr_cmd(priv->fcc_info->cp_page, 
+			priv->fcc_info->cp_block, 
+			CPM_MCN_ETHERNET, op) | CPM_CR_FLG;
+	cpm2_cmd(cmd);
+}
+
+static void fcc_enet_tx(struct net_device *dev)
+{
+	u32 tempval;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct txbd *bdp;
+	int must_restart = 0;
+
+	spin_lock(&priv->lock);
+	bdp = priv->dirty_tx;
+
+	while ((bdp->status & TXBD_READY) == 0) {
+		if ((bdp == priv->cur_tx) && (netif_queue_stopped(dev) == 0))
+			break;
+
+		priv->stats.tx_packets++;
+
+		/* Deferred means some collisions occurred during transmit, */
+		/* but we eventually sent the packet. */
+		if (bdp->status & TXBD_DEF)
+			priv->stats.collisions++;
+
+
+		if (bdp->status & TXBD_HB)	/* No heartbeat */
+			priv->stats.tx_heartbeat_errors++;
+		if (bdp->status & TXBD_LC)	/* Late collision */
+			priv->stats.tx_window_errors++;
+		if (bdp->status & TXBD_RL)	/* Retrans limit */
+			priv->stats.tx_aborted_errors++;
+		/* Underrun */
+		if (bdp->status & TXBD_UN) {
+			priv->stats.tx_fifo_errors++;
+			priv->extra_stats.tx_underrun++;
+		}
+		if (bdp->status & TXBD_CSL)	/* Carrier lost */
+			priv->stats.tx_carrier_errors++;
+
+
+		/* No heartbeat or Lost carrier are not really bad errors.
+		 * The others require a restart transmit command.
+		 */
+		if (bdp->status & (TXBD_LC | TXBD_RL | TXBD_UN)) {
+			must_restart = 1;
+			priv->stats.tx_errors++;
+		}
+
+		/* Free the sk buffer associated with this last transmit. */
+		dma_unmap_single(NULL, bdp->bufPtr,
+				bdp->length,
+				DMA_TO_DEVICE);
+
+		dev_kfree_skb_irq(priv->tx_skbuff[priv->skb_dirtytx]);
+		priv->tx_skbuff[priv->skb_dirtytx] = NULL;
+		priv->skb_dirtytx = 
+			(priv->skb_dirtytx + 1) & 
+			TX_RING_MOD_MASK(priv->tx_ring_size);
+
+		/* Update pointer to next buffer descriptor 
+		 * to be transmitted. */
+		if (bdp->status & TXBD_WRAP)
+			bdp = priv->tx_bd_base;
+		else
+			bdp++;
+
+		priv->dirty_tx = bdp;
+
+		/* We freed a buffer, so now we can restart transmission */
+		if (netif_queue_stopped(dev))
+			netif_wake_queue(dev);
+	} /* while ((bdp->status & TXBD_READY) == 0) */
+
+	if (must_restart) {
+
+		/* Some transmit errors cause the transmitter to shut
+		 * down.  We now issue a restart transmit.  Since the
+		 * errors close the BD and update the pointers, the restart
+		 * _should_ pick up without having to reset any of our
+		 * pointers either.  Also, To workaround 8260 device erratum
+		 * CPM37, we must disable and then re-enable the transmitter
+		 * following a Late Collision, Underrun, or Retry Limit error.
+		 */
+		tempval = fcc_enet_read32(&priv->fccregs->fcc_gfmr);
+		tempval &= ~FCC_GFMR_ENT;
+		fcc_enet_write32(&priv->fccregs->fcc_gfmr, tempval);
+
+		udelay(10); /* wait a few microseconds just on principle */
+		tempval = fcc_enet_read32(&priv->fccregs->fcc_gfmr);
+		tempval |= FCC_GFMR_ENT;
+		fcc_enet_write32(&priv->fccregs->fcc_gfmr, tempval);
+
+		cpm_write_command(priv, CPM_CR_RESTART_TX);
+	}
+	spin_unlock(&priv->lock);
+}
+
+/* During a receive, the cur_rx points to the current incoming buffer.
+ * When we update through the ring, if the next incoming buffer has
+ * not been given to the system, we just set the empty indicator,
+ * effectively tossing the packet.
+ */
+int fcc_enet_rx(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+#ifdef CONFIG_CPM2_FCC_ENET_NAPI
+	u16 tempval;
+
+	if (netif_rx_schedule_prep(dev)) {
+		tempval = fcc_enet_read16(&priv->fccregs->fcc_fccm);
+		tempval &= FCCM_RX_DISABLED;
+		fcc_enet_write16(&priv->fccregs->fcc_fccm, tempval);
+
+		__netif_rx_schedule(dev);
+	}
+	else {
+#ifdef VERBOSE_FCC_ERRORS
+		printk(KERN_DEBUG "%s: receive called twice\n")
+#endif
+	}
+#else
+	spin_lock(&priv->lock);
+	fcc_enet_clean_rx_ring(dev, priv->rx_ring_size);
+	spin_unlock(&priv->lock);
+#endif
+
+	return 0;
+}
+
+static inline void count_errors(unsigned short status, struct fcc_enet_private *priv)
+{
+	struct net_device_stats *stats = &priv->stats;
+	struct fcc_extra_stats *estats = &priv->extra_stats;
+
+	/* If the packet was truncated, none of the other errors
+	 * matter */
+	if (status & RXBD_TRUNCATED) {
+		stats->rx_length_errors++;
+
+		estats->rx_trunc++;
+
+		return;
+	}
+	/* Count the errors, if there were any */
+	if (status & (RXBD_LARGE | RXBD_SHORT)) {
+		stats->rx_length_errors++;
+
+		if (status & RXBD_LARGE)
+			estats->rx_large++;
+		else
+			estats->rx_short++;
+	}
+	if (status & RXBD_NONOCTET) {
+		stats->rx_frame_errors++;
+		estats->rx_nonoctet++;
+	}
+	if (status & RXBD_CRCERR) {
+		estats->rx_crcerr++;
+		stats->rx_crc_errors++;
+	}
+	if (status & RXBD_OVERRUN) {
+		estats->rx_overrun++;
+		stats->rx_crc_errors++;
+	}
+}
+
+/* fcc_enet_process_frame() -- handle one incoming packet if skb
+ * isn't NULL.*/
+static int fcc_enet_process_frame(struct net_device *dev, struct sk_buff *skb,
+		int length)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	if (skb == NULL) {
+		priv->stats.rx_dropped++;
+		priv->extra_stats.rx_skbmissing++;
+	} else {
+		/* Prep the skb for the packet */
+		skb_put(skb, length);
+
+		/* Tell the skb what kind of packet this is */
+		skb->protocol = eth_type_trans(skb, dev);
+
+		/* Send the packet up the stack */
+		if (netif_rx(skb) == NET_RX_DROP) {
+			priv->extra_stats.kernel_dropped++;
+		}
+	}
+
+	return 0;
+}
+
+
+static int fcc_enet_clean_rx_ring(struct net_device *dev, int rx_work_limit)
+{
+	struct rxbd *bdp;
+	struct sk_buff *skb;
+	u16 pkt_len;
+	int howmany = 0;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	/* Get the first full descriptor */
+	bdp = priv->cur_rx;
+
+	while (!((bdp->status & RXBD_EMPTY) || (--rx_work_limit < 0))) {
+		skb = priv->rx_skbuff[priv->skb_currx];
+
+		if (!(bdp->status &
+					(BD_ENET_RX_LG | BD_ENET_RX_SH 
+					 | BD_ENET_RX_NO | BD_ENET_RX_CR 
+					 | BD_ENET_RX_OV | BD_ENET_RX_CL))) {
+			/* Process the incoming frame. */
+			priv->stats.rx_packets++;
+			howmany++;
+
+			/* Remove the FCS from the packet length. */
+			pkt_len = bdp->length - 4;
+
+			fcc_enet_process_frame(dev, skb, pkt_len);
+
+			priv->stats.rx_bytes += pkt_len;
+		} else {
+			count_errors(bdp->status, priv);
+
+			if (skb)
+				dev_kfree_skb_any(skb);
+
+			priv->rx_skbuff[priv->skb_currx] = NULL;
+		}
+
+		dev->last_rx = jiffies;
+
+		/* Clear the status flags for this buffer. */
+		bdp->status &= ~RXBD_STATS;
+
+		/* Add another skb for the future */
+		skb = fcc_enet_new_skb(dev, bdp);
+		priv->rx_skbuff[priv->skb_currx] = skb;
+
+		/* Update BD pointer to next entry. */
+		if (bdp->status & RXBD_WRAP)
+			bdp = priv->rx_bd_base;
+		else
+			bdp++;
+
+		/* update to point at the next skb */
+		priv->skb_currx =
+			(priv->skb_currx +
+			 1) & RX_RING_MOD_MASK(priv->rx_ring_size);
+	}
+
+	priv->cur_rx = bdp;
+
+	return howmany;
+}
+
+#ifdef CONFIG_CPM2_FCC_ENET_NAPI
+static int fcc_enet_poll(struct net_device *dev, int *budget)
+{
+	int howmany;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	int rx_work_limit = *budget;
+
+	if (rx_work_limit > dev->quota)
+	rx_work_limit = dev->quota;
+
+	howmany = fcc_enet_clean_rx_ring(dev, rx_work_limit);
+
+	dev->quota -= howmany;
+	rx_work_limit -= howmany;
+	*budget -= howmany;
+
+	if (rx_work_limit >= 0) {
+		netif_rx_complete(dev);
+		
+		/* Reenable RX interrupts */
+		fcc_enet_write16(&priv->fccregs->fcc_fccm, FCCM_DEFAULT);
+	}
+
+	return (rx_work_limit < 0) ? 1 : 0;
+}
+#endif
+
+/* Stops the kernel queue, and halts the controller */
+static int fcc_enet_close(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	fcc_stop(dev);
+
+	if(priv->mii_info->phyinfo->close)
+		priv->mii_info->phyinfo->close(priv->mii_info);
+	del_timer_sync(&priv->phy_info_timer);
+	/* Kill the PHY */
+	kfree(priv->mii_info);
+
+	return 0;
+}
+
+/* Returns a net_device_stats structure pointer */
+static struct net_device_stats *fcc_enet_get_stats(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	return &(priv->stats);
+}
+
+
+#ifdef CONFIG_USE_MDIO
+/* This interrupt occurs when the PHY detects a link change. */
+static irqreturn_t mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+{
+	struct	net_device *dev = dev_id;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	/* Clear the interrupt */
+	mii_clear_phy_interrupt(priv->mii_info);
+
+	/* Disable PHY interrupts */
+	mii_configure_phy_interrupt(priv->mii_info, MII_INTERRUPT_DISABLED);
+
+	/* Schedule the PHY change */
+	schedule_work(&priv->tq);
+
+	return IRQ_HANDLED;
+}
+
+/* Scheduled by the mii_link_interrupt/timer to handle PHY changes */
+static void fcc_enet_phy_change(void *data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	int result = 0;
+
+	/* Delay to give the PHY a chance to change the
+	 * register state */
+	msleep(1);
+
+	/* Update the link, speed, duplex */
+	result = priv->mii_info->phyinfo->read_status(priv->mii_info);
+
+	/* Adjust the known status as long as the
+	 * link isn't still coming up */
+	if((0 == result) || (priv->mii_info->link == 0))
+		adjust_link(dev);
+
+	/* Reenable interrupts, if needed */
+	if (priv->fcc_info->device_flags & FSL_CPM2_FEC_BRD_HAS_PHY_INTR)
+		mii_configure_phy_interrupt(priv->mii_info,
+				MII_INTERRUPT_ENABLED);
+}
+
+/* Called every so often on systems that don't interrupt
+ * the core for PHY changes */
+static void fcc_enet_phy_timer(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *) data;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	schedule_work(&priv->tq);
+
+	mod_timer(&priv->phy_info_timer, jiffies + 
+			FCC_PHY_CHANGE_TIME * HZ);
+}
+
+#endif
+/* Called every time the controller might need to be made
+ * aware of new link state.  The PHY code conveys this
+ * information through variables in the priv structure, and this
+ * function converts those variables into the appropriate
+ * register values, and can bring down the device if needed.
+ */
+static void adjust_link(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct fcc *fccregs = priv->fccregs;
+	u32 tempval;
+	struct fcc_mii_info *mii_info = priv->mii_info;
+
+	if (mii_info->link) {
+		/* Now we make sure that we can be in full duplex mode.
+		 * If not, we operate in half-duplex mode. */
+		if (mii_info->duplex != priv->oldduplex) {
+			if (!(mii_info->duplex)) {
+				tempval = fcc_enet_read32(&fccregs->fcc_fpsmr);
+				tempval &= ~(FCC_PSMR_FDE | FCC_PSMR_LPB);
+				fcc_enet_write32(&fccregs->fcc_fpsmr, tempval); 
+				printk(KERN_INFO "%s: Half Duplex\n",
+						dev->name);
+			} else {
+				tempval = fcc_enet_read32(&fccregs->fcc_fpsmr);
+				tempval |= FCC_PSMR_FDE | FCC_PSMR_LPB;
+				fcc_enet_write32(&fccregs->fcc_fpsmr, tempval);
+				printk(KERN_INFO "%s: Full Duplex\n",
+						dev->name);
+			}
+
+			priv->oldduplex = mii_info->duplex;
+		}
+
+		if (mii_info->speed != priv->oldspeed) {
+			switch (mii_info->speed) {
+			case 100:
+			case 10:
+				break;
+			default:
+				printk(KERN_WARNING 
+						"%s: Ack!  Speed (%d) is not 10/100!\n", 
+						dev->name, mii_info->speed);
+				break;
+			}
+
+			printk(KERN_INFO "%s: Speed %dBT\n", dev->name,
+					mii_info->speed);
+
+			priv->oldspeed = mii_info->speed;
+		}
+
+		if (!priv->oldlink) {
+			printk(KERN_INFO "%s: Link is up\n", dev->name);
+			priv->oldlink = 1;
+			netif_carrier_on(dev);
+			netif_schedule(dev);
+		}
+	} else {
+		if (priv->oldlink) {
+			printk(KERN_INFO "%s: Link is down\n", dev->name);
+			priv->oldlink = 0;
+			priv->oldspeed = 0;
+			priv->oldduplex = -1;
+			netif_carrier_off(dev);
+		}
+	}
+}
+
+
+/* Set or clear the multicast filter for this adapter.
+ * Skeleton taken from sunlance driver.
+ */
+static void fcc_enet_set_multi(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct dev_mc_list *mc_ptr;
+	struct fcc_enet *regs = priv->regs;
+	struct fcc *fccregs = priv->fccregs;
+	u32 tempval;
+
+	return;
+
+	if (dev->flags&IFF_PROMISC) {
+		/* Log any net taps. */
+		printk(KERN_INFO "%s: Promiscuous mode enabled.\n", dev->name);
+		tempval = fcc_enet_read32(&fccregs->fcc_fpsmr);
+		tempval |= FCC_PSMR_PRO;
+		fcc_enet_write32(&fccregs->fcc_fpsmr, tempval);
+	} else {
+		tempval = fcc_enet_read32(&fccregs->fcc_fpsmr);
+		tempval &= ~FCC_PSMR_PRO;
+		fcc_enet_write32(&fccregs->fcc_fpsmr, tempval);
+	}
+
+	if (dev->flags & IFF_ALLMULTI) {
+		/* Catch all multicast addresses, so set the
+		 * filter to all 1's. */
+		fcc_enet_write32(&regs->fen_gaddrh, 0xffffffff);
+		fcc_enet_write32(&regs->fen_gaddrl, 0xffffffff);
+	}
+	else {
+		/* Clear filter and add the addresses in the list. */
+		fcc_enet_write32(&regs->fen_gaddrh, 0);
+		fcc_enet_write32(&regs->fen_gaddrl, 0);
+
+		if(dev->mc_count == 0)
+			return;
+
+		for (mc_ptr = dev->mc_list; mc_ptr; mc_ptr = mc_ptr->next) {
+			fcc_enet_set_hash_for_addr(dev, mc_ptr->dmi_addr);
+		}
+	}
+}
+
+/* Set the appropriate hash bit for the given addr */
+/* The algorithm works like so:
+ * 1) Take the Destination Address (ie the multicast address), and
+ * do a CRC on it (little endian), and reverse the bits of the
+ * result.
+ * 2) Use the 6 most significant bits as a hash into a 64-entry
+ * table.  The table is controlled through 2 32-bit registers:
+ * gaddrh and gaddrl.  gaddrh's MSB is entry 0, and gaddrl's LSB is
+ * entry 63. */
+static void fcc_enet_set_hash_for_addr(struct net_device *dev, u8 *addr)
+{
+	u8 *mcptr, *tdptr;
+	int idx;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct fcc_enet *regs = priv->regs;
+
+	/* The address in dmi_addr is LSB first,
+	 * and taddr is MSB first.  We have to
+	 * copy bytes MSB first from dmi_addr.
+	 */
+	mcptr = addr + 5;
+	tdptr = (u8 *)&regs->fen_taddrh;
+	for (idx=0; idx<6; idx++)
+		*tdptr++ = *mcptr--;
+
+	/* Make sure the memory transactions completed */
+	mb();
+
+	/* Ask CPM to run CRC and set bit in filter mask.  */
+	cpm_write_command(priv, CPM_CR_SET_GADDR);
+}
+
+/* Set the individual MAC address. */
+int fcc_enet_set_mac_address(struct net_device *dev)
+{
+	struct fcc_enet_private *priv= netdev_priv(dev);
+	struct fcc_enet *regs = priv->regs;
+	unsigned char *eap;
+	int idx;
+
+	eap = (unsigned char *) &(regs->fen_paddrh);
+
+	/* Copy it into the MAC backwards, cuz, hey, little endian! */
+	for (idx=5; idx>=0; idx--)
+		*eap++ = dev->dev_addr[idx];
+
+	mb();
+
+	return 0;
+}
+
+
+/* Configure the PHY for dev.
+ * returns 0 if success.  -1 if failure */
+static int init_phy(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+#ifdef CONFIG_USE_MDIO
+	int err = 0;
+	struct phy_info *curphy;
+	struct fcc_mii_info *mii_info;
+#endif
+
+#ifdef CONFIG_PQ2ADS
+	/* Enable the PHY.
+	 */
+	*(u32 *)(BCSR_ADDR + 4) &= ~BCSR1_FETHIEN;
+	*(u32 *)(BCSR_ADDR + 12) &= ~BCSR3_FETHIEN2;
+	*(u32 *)(BCSR_ADDR + 4) |= BCSR1_FETH_RST;
+	*(u32 *)(BCSR_ADDR + 12) |= BCSR3_FETH2_RST;
+#endif
+
+	priv->oldlink = 0;
+	priv->oldspeed = 0;
+	priv->oldduplex = -1;
+
+#ifdef CONFIG_USE_MDIO
+	mii_info = kmalloc(sizeof(struct fcc_mii_info),
+			GFP_KERNEL);
+
+	if(NULL == mii_info) {
+		printk(KERN_ERR "%s: Could not allocate mii_info\n",
+				dev->name);
+		return -ENOMEM;
+	}
+
+	mii_info->speed = SPEED_100;
+	mii_info->duplex = DUPLEX_FULL;
+	mii_info->pause = 0;
+	mii_info->link = 1;
+
+	mii_info->advertising = (ADVERTISED_10baseT_Half
+			| ADVERTISED_10baseT_Full
+			| ADVERTISED_100baseT_Half
+			| ADVERTISED_100baseT_Full
+			| ADVERTISED_1000baseT_Full);
+	mii_info->autoneg = 1;
+
+	mii_info->mii_id = priv->fcc_info->phyid;
+
+	mii_info->dev = dev;
+
+	mii_info->mdio_read = &read_phy_reg;
+	mii_info->mdio_write = &write_phy_reg;
+
+	priv->mii_info = mii_info;
+
+	/* get info for this PHY */
+	curphy = get_phy_info(mii_info);
+
+	if (curphy == NULL) {
+		printk(KERN_ERR "%s: No PHY found\n", dev->name);
+		err = -1;
+		goto no_phy;
+	}
+
+	mii_info->phyinfo = curphy;
+
+	/* Run the commands which initialize the PHY */
+	if(curphy->init) {
+		err = curphy->init(priv->mii_info);
+
+		if (err)
+			goto phy_init_fail;
+	}
+#endif
+	return 0;
+
+#ifdef CONFIG_USE_MDIO
+phy_init_fail:
+no_phy:
+	kfree(mii_info);
+
+	return err;
+#endif
+}
+
+
+static void init_fcc_param(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct fcc_enet	*regs = priv->regs;
+
+	/* Zero out all of the FCC parameter RAM.
+	 * For this driver, this means we are zeroing the registers */
+	memset((char *)priv->regs, 0, sizeof(struct fcc_enet));
+
+	/* Set the RX/TX State */
+	fcc_enet_write32(&regs->fen_genfcc.fcc_rstate, (CPMFCR_GBL | CPMFCR_EB) << 24);
+	fcc_enet_write32(&regs->fen_genfcc.fcc_tstate, (CPMFCR_GBL | CPMFCR_EB) << 24);
+
+	/* Set maximum bytes per receive buffer.
+	 * It must be a multiple of 32. */
+	fcc_enet_write16(&regs->fen_genfcc.fcc_mrblr, PKT_MAXBLR_SIZE);
+
+	/* Allocate space in the reserved FCC area of DPRAM for the
+	 * internal buffers. */	
+	/* Set the entire memory region to the ENET pad byte (0x88) */
+	memset(priv->fccmem, ENET_PAD_BYTE, FCC_INTERNAL_LEN);
+
+	/* Give the FCC indices into the internal memory */
+	fcc_enet_write16(&regs->fen_genfcc.fcc_riptr, CPM_FCC_SPECIAL_BASE+128);
+	fcc_enet_write16(&regs->fen_genfcc.fcc_tiptr, CPM_FCC_SPECIAL_BASE+160);
+	fcc_enet_write16(&regs->fen_padptr, CPM_FCC_SPECIAL_BASE+192);
+
+	/* Zero some regs */
+	fcc_enet_write32(&regs->fen_genfcc.fcc_rbptr, 0);
+	fcc_enet_write32(&regs->fen_genfcc.fcc_tbptr, 0);
+	fcc_enet_write32(&regs->fen_genfcc.fcc_rcrc, 0);
+	fcc_enet_write32(&regs->fen_genfcc.fcc_tcrc, 0);
+	fcc_enet_write16(&regs->fen_genfcc.fcc_res1, 0);
+	fcc_enet_write32(&regs->fen_genfcc.fcc_res2, 0);
+	fcc_enet_write32(&regs->fen_camptr, 0);
+
+
+	/* Set CRC preset and mask. */
+	fcc_enet_write32(&regs->fen_cmask, FCC_CRC_MASK);
+	fcc_enet_write32(&regs->fen_cpres, FCC_CRC_PRESET);
+
+	fcc_enet_write32(&regs->fen_crcec, 0);
+	fcc_enet_write32(&regs->fen_alec, 0);
+	fcc_enet_write32(&regs->fen_disfc, 0);
+	fcc_enet_write16(&regs->fen_pper, 0);
+
+	/* Set retry limit threshold */
+	fcc_enet_write16(&regs->fen_retlim, FCC_ENET_RETRYLIM);
+
+	fcc_enet_write32(&regs->fen_gaddrh, 0);
+	fcc_enet_write32(&regs->fen_gaddrl, 0);
+	fcc_enet_write32(&regs->fen_iaddrh, 0);
+	fcc_enet_write32(&regs->fen_iaddrl, 0);
+
+	fcc_enet_write16(&regs->fen_tfcstat, 0);
+	fcc_enet_write16(&regs->fen_tfclen, 0);
+	fcc_enet_write32(&regs->fen_tfcptr, 0);
+
+	/* maximum frame length register */
+	fcc_enet_write16(&regs->fen_mflr, PKT_MAXBUF_SIZE);
+
+	/* minimum frame length register */
+	fcc_enet_write16(&regs->fen_minflr, PKT_MINBUF_SIZE);
+
+	fcc_enet_write16(&regs->fen_taddrh, 0);
+	fcc_enet_write16(&regs->fen_taddrm, 0);
+	fcc_enet_write16(&regs->fen_taddrl, 0);
+
+	/* maximum DMA1 and DMA2 lengths */
+	fcc_enet_write16(&regs->fen_maxd1, PKT_MAXDMA_SIZE);
+	fcc_enet_write16(&regs->fen_maxd2, PKT_MAXDMA_SIZE);
+
+	fcc_enet_write32(&regs->fen_octc, 0);
+	fcc_enet_write32(&regs->fen_colc, 0);
+	fcc_enet_write32(&regs->fen_broc, 0);
+	fcc_enet_write32(&regs->fen_mulc, 0);
+	fcc_enet_write32(&regs->fen_uspc, 0);
+	fcc_enet_write32(&regs->fen_frgc, 0);
+	fcc_enet_write32(&regs->fen_ospc, 0);
+	fcc_enet_write32(&regs->fen_jbrc, 0);
+	fcc_enet_write32(&regs->fen_p64c, 0);
+	fcc_enet_write32(&regs->fen_p65c, 0);
+	fcc_enet_write32(&regs->fen_p128c, 0);
+	fcc_enet_write32(&regs->fen_p256c, 0);
+	fcc_enet_write32(&regs->fen_p512c, 0);
+	fcc_enet_write32(&regs->fen_p1024c, 0);
+
+	fcc_enet_write16(&regs->fen_rfthr, 0);
+	fcc_enet_write16(&regs->fen_rfcnt, 0);
+	fcc_enet_write16(&regs->fen_cftype, 0);
+}
+
+
+/* Let 'er rip. */
+int fcc_enet_startup(struct net_device *dev)
+{
+	dma_addr_t addr;
+	unsigned long vaddr;
+	u32 tempval;
+	int idx;
+	int err;
+	struct txbd *txbdp;
+	struct rxbd *rxbdp;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct fcc_enet *regs = priv->regs;
+	struct fcc_param *fccparam = &regs->fen_genfcc;
+	struct fcc *fccregs = priv->fccregs;
+
+	fcc_enet_write16(&fccregs->fcc_fccm, FCCM_CLEAR);
+
+#if 0
+	/* Allocate space for the buffer descriptors in the DP ram.
+	 * These are relative offsets in the DP ram address space.
+	 * Initialize base addresses for the buffer descriptors. */
+	/* I really want to do this, but for some reason it doesn't
+	 * work with the data cache enabled, so I allocate from the
+	 * main memory instead.
+	 */
+	i = cpm2_dpalloc(sizeof(cbd_t) * RX_RING_SIZE, 8);
+	fcc_enet_write32(&regs->fen_genfcc.fcc_rbase, &immap->im_dprambase[i]);
+	priv->rx_bd_base = (cbd_t *)&immap->im_dprambase[i];
+
+	i = cpm2_dpalloc(sizeof(cbd_t) * TX_RING_SIZE, 8);
+	fcc_enet_write32(&regs->fen_genfcc.fcc_tbase, (u32)&immap->im_dprambase[i]);
+	priv->tx_bd_base = (cbd_t *)&immap->im_dprambase[i];
+#else
+	vaddr = (unsigned long) dma_alloc_coherent(NULL,
+			sizeof (struct txbd) * priv->tx_ring_size +
+			sizeof (struct rxbd) * priv->rx_ring_size,
+			&addr, GFP_KERNEL);
+
+	if (vaddr == 0) {
+		printk(KERN_ERR "%s: Could not allocate buffer descriptors!\n",
+				dev->name);
+		return -ENOMEM;
+	}
+
+	priv->tx_bd_base = (struct txbd *) vaddr;
+	fcc_enet_write32(&fccparam->fcc_tbase, addr);
+
+	addr = addr + sizeof (struct txbd) * priv->tx_ring_size;
+	vaddr = vaddr + sizeof (struct txbd) * priv->tx_ring_size;
+	priv->rx_bd_base = (struct rxbd *) vaddr;
+	fcc_enet_write32(&fccparam->fcc_rbase, addr);
+#endif
+
+	/* Allocate and clear the tx_skbuff array */
+	priv->tx_skbuff = 
+		(struct sk_buff **) kmalloc(sizeof(struct sk_buff *) *
+					priv->tx_ring_size, GFP_KERNEL);
+
+	if (priv->tx_skbuff == NULL) {
+		printk(KERN_ERR "%s: Could not allocate tx_skbuff\n",
+				dev->name);
+		err = -ENOMEM;
+		goto tx_skb_fail;
+	}
+
+	for (idx = 0; idx < priv->tx_ring_size; idx++)
+		priv->tx_skbuff[idx] = NULL;
+
+	/* Allocate and clear the rx_skbuff array */
+	priv->rx_skbuff =
+		(struct sk_buff **) kmalloc(sizeof (struct sk_buff *) *
+					priv->rx_ring_size, GFP_KERNEL);
+
+	if (priv->rx_skbuff == NULL) {
+		printk(KERN_ERR "%s: Could not allocate rx_skbuff\n",
+				dev->name);
+		err = -ENOMEM;
+		goto rx_skb_fail;
+	}
+
+	for (idx = 0; idx < priv->rx_ring_size; idx++)
+		priv->rx_skbuff[idx] = NULL;
+
+	/* Initialize some tracking variables in our priv structure */
+	priv->dirty_tx = priv->cur_tx = priv->tx_bd_base;
+	priv->cur_rx = priv->rx_bd_base;
+	priv->skb_curtx = priv->skb_dirtytx = 0;
+	priv->skb_currx = 0;
+
+	/* Initialize Transmit Descriptor Ring */
+	txbdp = priv->tx_bd_base;
+	for (idx=0; idx<priv->tx_ring_size; idx++) {
+		txbdp->status = 0;
+		txbdp->length = 0;
+		txbdp->bufPtr = 0;
+		txbdp++;
+	}
+
+	/* Set the last descriptor in the ring to indicate wrap */
+	txbdp--;
+	txbdp->status |= TXBD_WRAP;
+
+	rxbdp = priv->rx_bd_base;
+	for (idx = 0; idx < priv->rx_ring_size; idx++) {
+		struct sk_buff *skb = NULL;
+
+		rxbdp->status = 0;
+
+		skb = fcc_enet_new_skb(dev, rxbdp);
+
+		priv->rx_skbuff[idx] = skb;
+
+		rxbdp++;
+	}
+
+	/* Set the last descriptor in the ring to wrap */
+	rxbdp--;
+	rxbdp->status |= RXBD_WRAP;
+
+	/* Reinitialize the channel now */
+	cpm_write_command(priv, CPM_CR_INIT_TRX);
+
+	/* Set GFMR to enable Ethernet operating mode. */
+	fcc_enet_write32(&fccregs->fcc_gfmr, (FCC_GFMR_TCI | FCC_GFMR_MODE_ENET));
+
+	/* Set sync/delimiters.
+	 */
+	fcc_enet_write16(&fccregs->fcc_fdsr, 0xd555);
+
+	/* Set protocol specific processing mode for Ethernet.
+	 * This has to be adjusted for Full Duplex operation after we can
+	 * determine how to detect that.
+	 */
+	fcc_enet_write32(&fccregs->fcc_fpsmr, FCC_PSMR_ENCRC);
+
+	/* Install our interrupt handler. */
+	if (request_irq(priv->interrupt, 
+				fcc_enet_interrupt, 
+				0, "fcc_enet", dev) < 0) {
+		printk(KERN_ERR "%s: Can't get FCC IRQ %d\n", dev->name,
+				priv->interrupt);
+		err = -1;
+		goto irq_fail;
+	}
+
+#ifdef	CONFIG_USE_MDIO
+	/* Set up the PHY change work queue */
+	INIT_WORK(&priv->tq, fcc_enet_phy_change, dev);
+
+	init_timer(&priv->phy_info_timer);
+	priv->phy_info_timer.function = &fcc_phy_startup_timer;
+	priv->phy_info_timer.data = (unsigned long) priv->mii_info;
+	mod_timer(&priv->phy_info_timer, jiffies + HZ);
+
+#endif	/* CONFIG_USE_MDIO */
+	adjust_link(dev);
+	/* Enable transmit/receive in GFMR */
+	tempval = fcc_enet_read32(&fccregs->fcc_gfmr);
+	tempval |= FCC_GFMR_ENR | FCC_GFMR_ENT;
+
+	fcc_enet_write32(&fccregs->fcc_gfmr, tempval);
+
+	fcc_enet_write16(&fccregs->fcc_fcce, FCCE_CLEAR);
+
+	/* Enable interrupts for transmit error, complete frame
+	 * received, and any transmit buffer we have also set the
+	 * interrupt flag. */
+	fcc_enet_write16(&fccregs->fcc_fccm, FCCM_DEFAULT);
+
+	return 0;
+
+irq_fail:
+rx_skb_fail:
+	free_skb_resources(dev);
+tx_skb_fail:
+	dma_free_coherent(NULL,
+			sizeof(struct txbd)*priv->tx_ring_size +
+			sizeof(struct rxbd)*priv->rx_ring_size,
+			priv->tx_bd_base,
+			fcc_enet_read32(&fccparam->fcc_tbase));
+
+	if(priv->mii_info->phyinfo->close)
+		priv->mii_info->phyinfo->close(priv->mii_info);
+
+	kfree(priv->mii_info);
+
+	return err;
+}
+
+#ifdef  CONFIG_USE_MDIO
+/* Keep trying aneg for some time
+ * If, after FCC_AN_TIMEOUT seconds, it has not
+ * finished, we switch to forced.
+ * Either way, once the process has completed, we either
+ * request the interrupt, or switch the timer over to 
+ * using fcc_phy_timer to check status */
+static void fcc_phy_startup_timer(unsigned long data)
+{
+	int result;
+	int secondary = FCC_AN_TIMEOUT;
+	struct fcc_mii_info *mii_info = (struct fcc_mii_info *)data;
+	struct fcc_enet_private *priv = netdev_priv(mii_info->dev);
+	
+	/* Configure the autonegotiation */
+	result = mii_info->phyinfo->config_aneg(mii_info);
+	/* If autonegotiation failed to start, and
+	 * we haven't timed out, reset the timer, and return */
+	if (result && secondary--) {
+		mod_timer(&priv->phy_info_timer, jiffies + HZ);
+		return;
+	} else if (result) {
+		/* Couldn't start autonegotiation
+		 * Try switching to forced */
+		mii_info->autoneg = 0;
+		result = mii_info->phyinfo->config_aneg(mii_info);
+
+		/* Forcing failed!  Give up */
+		if(result) {
+			printk(KERN_ERR "%s: Forcing failed!\n",
+					mii_info->dev->name);
+			return;
+		}
+
+	}
+
+	/* Kill the timer so it can be restarted */
+	del_timer_sync(&priv->phy_info_timer);
+
+	/* Grab the PHY interrupt, if necessary/possible */
+	if (priv->fcc_info->device_flags & FSL_CPM2_FEC_BRD_HAS_PHY_INTR) {
+	if (request_irq(priv->PHYinterrupt, 
+					mii_link_interrupt, 
+					SA_SHIRQ, "fcc_mii", mii_info->dev) < 0) {
+			printk(KERN_ERR "%s: Can't get MII IRQ %d\n", 
+					mii_info->dev->name,
+					priv->PHYinterrupt);
+		} else {
+			mii_configure_phy_interrupt(priv->mii_info,
+					MII_INTERRUPT_ENABLED);
+			return;
+		}
+	}
+	/* Start the timer again, this time in order to
+	 * handle a change in status */
+	init_timer(&priv->phy_info_timer);
+	priv->phy_info_timer.function = &fcc_enet_phy_timer;
+	priv->phy_info_timer.data = (unsigned long) mii_info->dev;
+	mod_timer(&priv->phy_info_timer, jiffies + 
+			FCC_PHY_CHANGE_TIME * HZ);
+
+}
+#endif
+
+void fcc_stop(struct net_device *dev)
+{
+	unsigned long flags;
+	struct fcc_enet_private	*priv = netdev_priv(dev);
+	struct fcc *fccregs = priv->fccregs;
+	struct fcc_param *fccparam = &priv->regs->fen_genfcc;
+	u32 tempval;
+	/* Lock it down */
+	spin_lock_irqsave(&priv->lock, flags);
+
+	priv->mii_info->link = 0;
+
+	adjust_link(dev);
+	/* Mask all interrupts */
+	fcc_enet_write16(&fccregs->fcc_fccm, FCCM_CLEAR);
+
+	/* Clear all interrupts */
+	fcc_enet_write16(&fccregs->fcc_fcce, FCCE_CLEAR);
+
+	/* Disable transmit/receive */
+	tempval =fcc_enet_read32(&fccregs->fcc_gfmr);
+	tempval &= ~(FCC_GFMR_ENR | FCC_GFMR_ENT);
+	fcc_enet_write32(&fccregs->fcc_gfmr, tempval);
+
+	if (priv->fcc_info->device_flags & FSL_CPM2_FEC_BRD_HAS_PHY_INTR) {
+		/* Clear any pending interrupts */
+		mii_clear_phy_interrupt(priv->mii_info);
+
+		/* Disable PHY Interrupts */
+		mii_configure_phy_interrupt(priv->mii_info,
+				MII_INTERRUPT_DISABLED);
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	/* Free the IRQs */
+	free_irq(priv->interrupt, dev);
+
+#ifdef CONFIG_USE_MDIO
+	if(priv->fcc_info->device_flags & FSL_CPM2_FEC_BRD_HAS_PHY_INTR)
+		free_irq(priv->PHYinterrupt, dev);
+	else
+		del_timer_sync(&priv->phy_info_timer);
+#endif
+	free_skb_resources(dev);
+
+	/* Free the buffer descriptors */
+
+	dma_free_coherent(NULL,
+			sizeof(struct txbd)*priv->tx_ring_size +
+			sizeof(struct rxbd)*priv->rx_ring_size,
+			priv->tx_bd_base,
+			fcc_enet_read32(&fccparam->fcc_tbase));
+}
+
+/* If there are any tx skbs or rx skbs still around, free them.
+ * then free tx_skbuff and rx_skbuff */
+void free_skb_resources(struct net_device *dev)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct rxbd *rxbdp;
+	struct txbd *txbdp;
+	int idx;
+
+	/* Go through all the buffer descriptors and free their data buffers */
+	txbdp = priv->tx_bd_base;
+
+	for (idx = 0; idx < priv->tx_ring_size; idx++) {
+
+		if (priv->tx_skbuff[idx]) {
+			dma_unmap_single(NULL, txbdp->bufPtr, txbdp->length, DMA_TO_DEVICE);
+			dev_kfree_skb_any(priv->tx_skbuff[idx]);
+			priv->tx_skbuff[idx] = NULL;
+		}
+
+		txbdp->status = 0;
+		txbdp->length = 0;
+		txbdp->bufPtr = 0;
+
+		txbdp++;
+	}
+
+	kfree(priv->tx_skbuff);
+
+	rxbdp = priv->rx_bd_base;
+
+	/* rx_skbuff is not guaranteed to be allocated, so only
+	 * free it and its contents if it is allocated. (This function
+	 * is used to free tx_skbuff if rx_skbuff fails to allocate) */
+	if(priv->rx_skbuff != NULL) {
+		for (idx = 0; idx < priv->rx_ring_size; idx++) {
+			if (priv->rx_skbuff[idx]) {
+				dma_unmap_single(NULL, rxbdp->bufPtr, priv->rx_buffer_size + RXBUF_ALIGNMENT, DMA_FROM_DEVICE);
+				dev_kfree_skb_any(priv->rx_skbuff[idx]);
+				priv->rx_skbuff[idx] = NULL;
+			}
+
+			rxbdp->status = 0;
+			rxbdp->length = 0;
+			rxbdp->bufPtr = 0;
+
+			rxbdp++;
+		}
+
+		kfree(priv->rx_skbuff);
+	}
+}
+
+
+static int fcc_enet_open(struct net_device *dev)
+{
+	int err;
+
+	init_fcc_param(dev);
+
+	fcc_enet_set_mac_address(dev);
+
+	err = init_phy(dev);
+
+	if (err)
+		return err;
+
+	err = fcc_enet_startup(dev);
+	
+	return err;
+}
+
+
+/* Structure for a device driver */
+static struct device_driver fcc_enet_driver = {
+	.name = "cpm2_fcc",
+	.bus = &platform_bus_type,
+	.probe = fcc_enet_probe,
+	.remove = fcc_enet_remove,
+};
+
+static int __init fcc_enet_init(void)
+{
+	int ret = driver_register(&fcc_enet_driver);
+	
+	return (ret );
+}
+
+static void __exit fcc_enet_exit(void)
+{
+	driver_unregister(&fcc_enet_driver);
+}
+			
+
+module_init(fcc_enet_init);
+module_exit(fcc_enet_exit);
+
+
diff -Nru a/drivers/net/cpm2_fcc_enet.h b/drivers/net/cpm2_fcc_enet.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/net/cpm2_fcc_enet.h	2005-05-04 17:09:58 +04:00
@@ -0,0 +1,340 @@
+/*
+ * /drivers/net/cpm2_fcc_enet.h
+ *
+ * Fast Ethernet Controller (FCC) driver for Motorola MPC8260/8560.
+ * Copyright (c) 2000 MontaVista Software, Inc.   Dan Malek (dmalek@jlc.net)
+ *
+ * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
+ * Andy Fleming <afleming@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#ifndef __FCC_ENET_H
+#define __FCC_ENET_H
+
+/* The number of bytes which composes a unit for the purpose of
+ * allocating data buffers.  ie-for any given MTU, the data
+ * buffer will be the next highest multiple of 512 bytes. */
+#define INCREMENTAL_BUFFER_SIZE 512
+
+#define DEVICE_NAME "%s: FCC ENET Version 0.5, "
+#define DRV_NAME "fcc_enet"
+extern const char fcc_driver_name[];
+extern const char fcc_driver_version[];
+
+#define FCC_PHY_CHANGE_TIME 2
+
+/* CLK12 is receive, CLK11 is transmit.  These are board
+ * specific.
+ * */
+#ifdef CONFIG_ADS8272
+#define PC_F1RXCLK	0x00000400U
+#define PC_F1TXCLK	0x00000200U
+#define CMX1_CLK_ROUTE	0x36000000U
+#define CMX1_CLK_MASK	0xff000000U
+#else
+#define PC_F1RXCLK	0x00000800U
+#define PC_F1TXCLK	0x00000400U
+#define CMX1_CLK_ROUTE	0x3e000000U
+#define CMX1_CLK_MASK	0xff000000U
+#endif
+
+/* CLK13 is receive, CLK14 is transmit.  These are board
+ * dependent.
+ * */
+#ifdef CONFIG_ADS8272
+#define PC_F2RXCLK	0x00004000U
+#define PC_F2TXCLK	0x00008000U
+#define CMX2_CLK_ROUTE	0x00370000U
+#define CMX2_CLK_MASK	0x00ff0000U
+#else
+#define PC_F2RXCLK	0x00001000U
+#define PC_F2TXCLK	0x00002000U
+#define CMX2_CLK_ROUTE	0x00250000U
+#define CMX2_CLK_MASK	0x00ff0000U
+#endif
+
+/* MII status/control serial interface.
+ * */
+#ifdef	CONFIG_TQM8260
+/* TQM8260 has MDIO and MDCK on PC30 and PC31 respectively */
+#define PC_MDIO		0x00000002U
+#define PC_MDCK		0x00000001U
+#elif defined(CONFIG_ADS8272)
+#define PC_MDIO		0x00002000U
+#define PC_MDCK		0x00001000U
+#else
+#define PC_MDIO		0x00000004U
+#define PC_MDCK		0x00000020U
+#endif
+
+/* The number of Tx and Rx buffers.  These are allocated from the page
+ * pool.  The code may assume these are power of two, so it is best
+ * to keep them that size.
+ * We don't need to allocate pages for the transmitter.  We just use
+ * the skbuffer directly.
+ */
+#define TX_RING_MOD_MASK(size) (size-1)
+#define RX_RING_MOD_MASK(size) (size-1)
+
+#define DEFAULT_RX_BUFFER_SIZE 2048
+#define DEFAULT_TX_RING_SIZE 32
+#define DEFAULT_RX_RING_SIZE 32
+
+#define FCC_RX_MAX_RING_SIZE   256
+#define FCC_TX_MAX_RING_SIZE   256
+
+#define FCC_ENET_DEV_WEIGHT	64
+
+#define FCCM_CLEAR 0
+#define FCCM_DEFAULT (FCC_ENET_TXE | FCC_ENET_RXF | FCC_ENET_TXB)
+#define FCCM_RX_DISABLED (FCC_ENET_TXE | FCC_ENET_TXB)
+
+#define FCCE_CLEAR 0xffff
+#define FCC_INTERNAL_LEN 128
+#define MAC_ADDR_LEN 6
+
+#define ENET_PAD_BYTE 0x88
+
+#define FCC_CRC_MASK 0xdebb20e3
+#define FCC_CRC_PRESET 0xffffffff
+#define FCC_ENET_RETRYLIM 15
+/* The FCC stores dest/src/type, data, and checksum for receive packets.
+ */
+#define PKT_MAXBUF_SIZE		1518
+#define PKT_MINBUF_SIZE		64
+
+/* Maximum input DMA size.  Must be a should(?) be a multiple of 4.
+ */
+#define PKT_MAXDMA_SIZE		1520
+
+/* Maximum input buffer size.  Must be a multiple of 32.
+ */
+#define PKT_MAXBLR_SIZE		1536
+
+/* These will be configurable for the FCC choice.
+ * Multiple ports can be configured.  There is little choice among the
+ * I/O pins to the PHY, except the clocks.  We will need some board
+ * dependent clock selection.
+ * Why in the hell did I put these inside #ifdef's?  I dunno, maybe to
+ * help show what pins are used for each device.
+ */
+
+/* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PA1_COL		0x00000001U
+#define PA1_CRS		0x00000002U
+#define PA1_TXER	0x00000004U
+#define PA1_TXEN	0x00000008U
+#define PA1_RXDV	0x00000010U
+#define PA1_RXER	0x00000020U
+#define PA1_TXDAT	0x00003c00U
+#define PA1_RXDAT	0x0003c000U
+#define PA1_PSORA0	(PA1_RXDAT | PA1_TXDAT)
+#define PA1_PSORA1	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
+		PA1_RXDV | PA1_RXER)
+#define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
+#define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
+
+
+/* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB2_TXER	0x00000001U
+#define PB2_RXDV	0x00000002U
+#define PB2_TXEN	0x00000004U
+#define PB2_RXER	0x00000008U
+#define PB2_COL		0x00000010U
+#define PB2_CRS		0x00000020U
+#define PB2_TXDAT	0x000003c0U
+#define PB2_RXDAT	0x00003c00U
+#define PB2_PSORB0	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
+		PB2_RXER | PB2_RXDV | PB2_TXER)
+#define PB2_PSORB1	(PB2_TXEN)
+#define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
+#define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
+
+
+/* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB3_RXDV	0x00004000U
+#define PB3_RXER	0x00008000U
+#define PB3_TXER	0x00010000U
+#define PB3_TXEN	0x00020000U
+#define PB3_COL		0x00040000U
+#define PB3_CRS		0x00080000U
+#define PB3_TXDAT	0x0f000000U
+#define PB3_RXDAT	0x00f00000U
+#define PB3_PSORB0	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
+		PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
+#define PB3_PSORB1	0
+#define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
+#define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
+
+/* CLK15 is receive, CLK16 is transmit.  These are board dependent.
+ */
+#define PC_F3RXCLK	0x00004000U
+#define PC_F3TXCLK	0x00008000U
+#define CMX3_CLK_ROUTE	0x00003700U
+#define CMX3_CLK_MASK	0x0000ff00U
+
+
+struct fcc_extra_stats {
+	u64 kernel_dropped;
+	u64 rx_large;
+	u64 rx_short;
+	u64 rx_nonoctet;
+	u64 rx_crcerr;
+	u64 rx_overrun;
+	u64 rx_bsy;
+	u64 rx_trunc;
+	u64 tx_underrun;
+	u64 rx_skbmissing;
+	u64 tx_timeout;
+};
+
+#define FCC_RMON_LEN (14)
+#define FCC_EXTRA_STATS_LEN (sizeof(struct fcc_extra_stats)/sizeof(u64))
+
+/* Number of stats in the stats structure (ignore car and cam regs)*/
+#define FCC_STATS_LEN (FCC_RMON_LEN + FCC_EXTRA_STATS_LEN)
+
+#define FCC_INFOSTR_LEN 32
+
+struct fcc_stats {
+	u64 extra[FCC_EXTRA_STATS_LEN];
+	u64 rmon[FCC_RMON_LEN];
+};
+
+
+
+/* The FCC buffer descriptors track the ring buffers.  The rx_bd_base and
+ * tx_bd_base always point to the base of the buffer descriptors.  The
+ * cur_rx and cur_tx point to the currently available buffer.
+ * The dirty_tx tracks the current buffer that is being sent by the
+ * controller.  The cur_tx and dirty_tx are equal under both completely
+ * empty and completely full conditions.  The empty/ready indicator in
+ * the buffer descriptor determines the actual condition.
+ */
+struct fcc_enet_private {
+	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
+	struct sk_buff ** tx_skbuff;
+	struct sk_buff ** rx_skbuff;
+	u16 skb_curtx;
+	u16 skb_currx;
+
+	u16 skb_dirtytx;
+
+	/* CPM dual port RAM relative addresses. */
+	struct rxbd	*rx_bd_base;		/* Address of Rx and Tx buffers. */
+	struct txbd	*tx_bd_base;
+	struct rxbd	*cur_rx;
+	struct txbd 	*cur_tx;		/* The next free ring entry */
+	struct txbd	*dirty_tx;	/* The ring entries to be free()ed. */
+	struct fcc_enet *regs;
+	struct fcc	*fccregs;
+	char *fccmem;
+
+	struct net_device_stats stats;
+	struct fcc_extra_stats extra_stats;
+	struct work_struct tq;
+	struct timer_list phy_info_timer;
+	spinlock_t lock;
+
+	unsigned int rx_buffer_size;
+	unsigned int tx_ring_size;
+	unsigned int rx_ring_size;
+	int oldlink;
+	int oldduplex;
+	int oldspeed;
+
+	struct fcc_mii_info *mii_info;
+
+	struct cpm2_fec_platform_data *fcc_info;
+	unsigned int interrupt;
+	unsigned int PHYinterrupt;
+	unsigned int membase;
+};
+
+#define TXBD_READY		0x8000
+#define TXBD_PAD		0x4000
+#define TXBD_WRAP		0x2000
+#define TXBD_INTERRUPT		0x1000
+#define TXBD_LAST		0x0800
+#define TXBD_CRC		0x0400
+#define TXBD_DEF		0x0200
+#define TXBD_HB			0x0100
+#define TXBD_HUGEFRAME		0x0080
+#define TXBD_LC			0x0080
+#define TXBD_RL			0x0040
+#define	TXBD_RETRYCOUNTMASK	0x003c
+#define TXBD_UN			0x0002
+#define TXBD_CSL		0x0001
+
+/* RxBD status field bits */
+#define RXBD_EMPTY		0x8000
+#define RXBD_RO1		0x4000
+#define RXBD_WRAP		0x2000
+#define RXBD_INTERRUPT		0x1000
+#define RXBD_LAST		0x0800
+#define RXBD_FIRST		0x0400
+#define RXBD_MISS		0x0100
+#define RXBD_BROADCAST		0x0080
+#define RXBD_MULTICAST		0x0040
+#define RXBD_LARGE		0x0020
+#define RXBD_NONOCTET		0x0010
+#define RXBD_SHORT		0x0008
+#define RXBD_CRCERR		0x0004
+#define RXBD_OVERRUN		0x0002
+#define RXBD_TRUNCATED		0x0001
+#define RXBD_STATS		0x01ff
+
+struct txbd
+{
+	u16	status;	/* Status Fields */
+	u16	length;	/* Buffer length */
+	u32	bufPtr;	/* Buffer Pointer */
+};
+
+struct rxbd
+{
+	u16	status;	/* Status Fields */
+	u16	length;	/* Buffer Length */
+	u32	bufPtr;	/* Buffer Pointer */
+};
+
+
+#define FCC_ENET_READ(size) \
+extern inline u32 fcc_enet_read##size(volatile u##size *addr) \
+{ \
+	u##size val; \
+		val = in_be##size(addr); \
+		return val; \
+}
+
+FCC_ENET_READ(32);
+FCC_ENET_READ(16);
+
+
+#define FCC_ENET_WRITE(size) \
+extern inline void fcc_enet_write##size(volatile u##size *addr, u##size val) \
+{ \
+	out_be##size(addr, val); \
+}
+
+FCC_ENET_WRITE(32);
+FCC_ENET_WRITE(16);
+
+extern struct ethtool_ops fcc_ethtool_ops;
+
+#endif /* __FCC_ENET_H */
diff -Nru a/drivers/net/cpm2_fcc_ethtool.c b/drivers/net/cpm2_fcc_ethtool.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/net/cpm2_fcc_ethtool.c	2005-05-04 17:09:58 +04:00
@@ -0,0 +1,261 @@
+/*
+ *  arch/ppc/cpm2_io/fcc_ethtool.c
+ *
+ *  FCC Ethernet Driver
+ *  Ethtool support for FCC Enet
+ *  Based on e1000 (and gianfar) ethtool support 
+ *
+ *  Author: Andy Fleming
+ *  Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ *  Copyright (c) 2003,2004 Freescale Semiconductor, Inc.
+ *
+ *  This software may be used and distributed according to 
+ *  the terms of the GNU Public License, Version 2, incorporated herein 
+ *  by reference.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/crc32.h>
+#include <asm/types.h>
+#include <asm/uaccess.h>
+#include <linux/ethtool.h>
+
+#include <asm/cpm2.h>
+
+#include "cpm2_fcc_enet.h"
+#include "cpm2_fcc_phy.h"
+
+#define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))
+
+extern int fcc_enet_startup(struct net_device *dev);
+extern void fcc_stop(struct net_device *dev);
+extern int fcc_enet_rx(struct net_device *dev);
+
+void fcc_fill_stats(struct net_device *dev, struct ethtool_stats *dummy,
+		u64 * buf);
+void fcc_gstrings(struct net_device *dev, u32 stringset, u8 * buf);
+int fcc_gcoalesce(struct net_device *dev, struct ethtool_coalesce *cvals);
+int fcc_scoalesce(struct net_device *dev, struct ethtool_coalesce *cvals);
+void fcc_gringparam(struct net_device *dev, struct ethtool_ringparam *rvals);
+int fcc_sringparam(struct net_device *dev, struct ethtool_ringparam *rvals);
+void fcc_gdrvinfo(struct net_device *dev, struct ethtool_drvinfo *drvinfo);
+
+static char stat_gstrings[][ETH_GSTRING_LEN] = {
+	"rx-dropped-by-kernel",
+	"rx-large-frame-errors",
+	"rx-short-frame-errors",
+	"rx-non-octet-errors",
+	"rx-crc-errors",
+	"rx-overrun-errors",
+	"rx-busy-errors",
+	"rx-truncated-frames",
+	"tx-underrun-errors",
+	"rx-skb-missing-errors",
+	"tx-timeout-errors",
+	"rx-bytes",
+	"total-collisions",
+	"rx-broadcast-packets",
+	"rx-multicast-packets",
+	"rx-undersize-packets",
+	"rx-fragmented-packets",
+	"rx-oversize-packets",
+	"rx-jabber-frames",
+	"rx-64-frames",
+	"rx-65-127-frames",
+	"rx-128-255-frames",
+	"rx-256-511-frames",
+	"rx-512-1023-frames",
+	"rx-1024-1518-frames",
+};
+
+/* Fill in an array of 64-bit statistics from various sources.
+ * This array will be appended to the end of the ethtool_stats
+ * structure, and returned to user space
+ */
+void fcc_fill_stats(struct net_device *dev, struct ethtool_stats *dummy, u64 * buf)
+{
+	int i;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	u32 *rmon = (u32 *) &priv->regs->fen_octc;
+	u64 *extra = (u64 *) &priv->extra_stats;
+	struct fcc_stats *stats = (struct fcc_stats *) buf;
+
+	for (i = 0; i < FCC_RMON_LEN; i++) {
+		stats->rmon[i] = (u64) (rmon[i]);
+	}
+
+	for (i = 0; i < FCC_EXTRA_STATS_LEN; i++) {
+		stats->extra[i] = extra[i];
+	}
+}
+
+/* Returns the number of stats (and their corresponding strings) */
+int fcc_stats_count(struct net_device *dev)
+{
+	return FCC_STATS_LEN;
+}
+
+/* Fills in the drvinfo structure with some basic info */
+void fcc_gdrvinfo(struct net_device *dev, struct
+	 	ethtool_drvinfo *drvinfo)
+{
+	strncpy(drvinfo->driver, DRV_NAME, FCC_INFOSTR_LEN);
+	strncpy(drvinfo->version, fcc_driver_version, FCC_INFOSTR_LEN);
+	strncpy(drvinfo->fw_version, "N/A", FCC_INFOSTR_LEN);
+	strncpy(drvinfo->bus_info, "N/A", FCC_INFOSTR_LEN);
+	drvinfo->n_stats = FCC_STATS_LEN;
+	drvinfo->testinfo_len = 0;
+	drvinfo->regdump_len = 0;
+	drvinfo->eedump_len = 0;
+}
+
+/* Return the current settings in the ethtool_cmd structure */
+int fcc_gsettings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	cmd->supported = (SUPPORTED_10baseT_Half
+			  | SUPPORTED_100baseT_Half
+			  | SUPPORTED_100baseT_Full
+			  | SUPPORTED_Autoneg);
+
+	/* For now, we always advertise everything */
+	cmd->advertising = (ADVERTISED_10baseT_Half
+			    | ADVERTISED_100baseT_Half
+			    | ADVERTISED_100baseT_Full
+			    | ADVERTISED_Autoneg);
+
+	cmd->speed = priv->mii_info->speed;
+	cmd->duplex = priv->mii_info->duplex;
+	cmd->port = PORT_MII;
+	cmd->phy_address = priv->mii_info->mii_id;
+	cmd->transceiver = XCVR_EXTERNAL;
+	cmd->autoneg = AUTONEG_ENABLE;
+
+	return 0;
+}
+
+/* Return the length of the register structure */
+int fcc_reglen(struct net_device *dev)
+{
+	return sizeof (struct fcc_enet);
+}
+
+/* Return a dump of the FCC register space */
+void fcc_get_regs(struct net_device *dev, struct ethtool_regs *regs, void *regbuf)
+{
+	int i;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	u32 *theregs = (u32 *) priv->regs;
+	u32 *buf = (u32 *) regbuf;
+
+	for (i = 0; i < sizeof (struct fcc_enet) / sizeof (u32); i++)
+		buf[i] = theregs[i];
+}
+
+/* Fill in a buffer with the strings which correspond to the
+ * stats */
+void fcc_gstrings(struct net_device *dev, u32 stringset, u8 * buf)
+{
+	memcpy(buf, stat_gstrings, FCC_STATS_LEN * ETH_GSTRING_LEN);
+}
+
+/* Fills in rvals with the current ring parameters.  Currently,
+ * rx, rx_mini, and rx_jumbo rings are the same size, as mini and
+ * jumbo are ignored by the driver */
+void fcc_gringparam(struct net_device *dev, struct ethtool_ringparam *rvals)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+
+	rvals->rx_max_pending = FCC_RX_MAX_RING_SIZE;
+	rvals->rx_mini_max_pending = FCC_RX_MAX_RING_SIZE;
+	rvals->rx_jumbo_max_pending = FCC_RX_MAX_RING_SIZE;
+	rvals->tx_max_pending = FCC_TX_MAX_RING_SIZE;
+
+	/* Values changeable by the user.  The valid values are
+	 * in the range 1 to the "*_max_pending" counterpart above.
+	 */
+	rvals->rx_pending = priv->rx_ring_size;
+	rvals->rx_mini_pending = priv->rx_ring_size;
+	rvals->rx_jumbo_pending = priv->rx_ring_size;
+	rvals->tx_pending = priv->tx_ring_size;
+}
+
+/* Change the current ring parameters, stopping the controller if
+ * necessary so that we don't mess things up while we're in
+ * motion.  We wait for the ring to be clean before reallocating
+ * the rings. */
+int fcc_sringparam(struct net_device *dev, struct ethtool_ringparam *rvals)
+{
+	u32 tempval;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	int err = 0;
+
+	if (rvals->rx_pending > FCC_RX_MAX_RING_SIZE)
+		return -EINVAL;
+
+	if (!is_power_of_2(rvals->rx_pending)) {
+		printk("%s: Ring sizes must be a power of 2\n",
+				dev->name);
+		return -EINVAL;
+	}
+
+	if (rvals->tx_pending > FCC_TX_MAX_RING_SIZE)
+		return -EINVAL;
+
+	if (!is_power_of_2(rvals->tx_pending)) {
+		printk("%s: Ring sizes must be a power of 2\n",
+				dev->name);
+		return -EINVAL;
+	}
+
+	/* Stop the controller so we don't rx or tx any more frames */
+	tempval =fcc_enet_read32(&priv->fccregs->fcc_gfmr);
+	tempval &= ~(FCC_GFMR_ENR | FCC_GFMR_ENT);
+	fcc_enet_write32(&priv->fccregs->fcc_gfmr, tempval);
+
+	/* Stop the controller completely */
+	if (dev->flags & IFF_UP)
+		fcc_stop(dev);
+
+	priv->rx_ring_size = rvals->rx_pending;
+	priv->tx_ring_size = rvals->tx_pending;
+
+	if (dev->flags & IFF_UP)
+		err = fcc_enet_startup(dev);
+
+	return err;
+}
+
+struct ethtool_ops fcc_ethtool_ops = {
+	.get_settings = fcc_gsettings,
+	.get_drvinfo = fcc_gdrvinfo,
+	.get_regs_len = fcc_reglen,
+	.get_regs = fcc_get_regs,
+	.get_link = ethtool_op_get_link,
+	.get_ringparam = fcc_gringparam,
+	.set_ringparam = fcc_sringparam,
+	.get_strings = fcc_gstrings,
+	.get_stats_count = fcc_stats_count,
+	.get_ethtool_stats = fcc_fill_stats,
+};
diff -Nru a/drivers/net/cpm2_fcc_phy.c b/drivers/net/cpm2_fcc_phy.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/net/cpm2_fcc_phy.c	2005-05-04 17:09:58 +04:00
@@ -0,0 +1,776 @@
+/* 
+ * drivers/net/cpm2_fcc_phy.c
+ *
+ * FCC Ethernet Driver -- PHY handling
+ * Driver for FCC for 8xxx CPM
+ * Based on drivers/net/gianfar_phy.c
+ *
+ * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
+ * Andy Fleming <afleming@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc,
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *  
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/ppc_sys.h>
+#include <asm/cpm2.h>
+
+#include "cpm2_fcc_enet.h"
+#include "cpm2_fcc_phy.h"
+
+static inline void fcc_mdio_setdirection(struct fcc_enet_private *priv, 
+		u32 dir);
+static void fcc_mdio_write_preamble(struct fcc_enet_private *priv);
+static inline void fcc_mdio_setclk(struct fcc_enet_private *priv, int bit);
+inline u32 fcc_mdio_readbit(struct fcc_enet_private *priv);
+inline void fcc_mdio_writebit(struct fcc_enet_private *priv, u32 bit);
+u16 phy_read(struct fcc_mii_info *mii_info, u16 regnum);
+void phy_write(struct fcc_mii_info *mii_info, u16 regnum, u16 val);
+static void config_genmii_advert(struct fcc_mii_info *mii_info);
+static void genmii_setup_forced(struct fcc_mii_info *mii_info);
+static void genmii_restart_aneg(struct fcc_mii_info *mii_info);
+static int genmii_config_aneg(struct fcc_mii_info *mii_info);
+static int genmii_update_link(struct fcc_mii_info *mii_info);
+static int genmii_read_status(struct fcc_mii_info *mii_info);
+
+void write_phy_reg(struct net_device *dev, int mii_id, int regnum, int value)
+{
+	int off;
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct cpm2_fec_platform_data *fcc_info = priv->fcc_info;
+	u32 cmd;
+
+	cmd = WRITE_CMD | ((u32)fcc_info->phyid << 23) | ((u32)regnum << 18) | value;
+
+	fcc_mdio_setdirection(priv, FCC_MDIO_W);
+
+	fcc_mdio_write_preamble(priv);
+
+	/* Write data */
+	for (off = 31; off >= 0; --off)
+		fcc_mdio_writebit(priv, ((cmd >> off) & 0x00000001));
+
+	fcc_mdio_write_preamble(priv);
+}
+
+int read_phy_reg(struct net_device *dev, int mii_id, int regnum)
+{
+	struct fcc_enet_private *priv = netdev_priv(dev);
+	struct cpm2_fec_platform_data *fcc_info = priv->fcc_info;
+	u32 cmd;
+	int off;
+	int i;
+	u16 retval = 0;
+
+	cmd = READ_CMD | ((u32)fcc_info->phyid << 23) | ((u32)regnum << 18);
+
+	fcc_mdio_setdirection(priv, FCC_MDIO_W);
+
+	fcc_mdio_write_preamble(priv);
+
+	for (i = 0, off = 31; i < 14; i++, --off) {
+		fcc_mdio_writebit(priv, ((cmd >> off) & 0x00000001));
+	}
+
+	fcc_mdio_setclk(priv, 0);
+
+	fcc_mdio_setdirection(priv, FCC_MDIO_R);
+
+	udelay(1);
+
+	fcc_mdio_setclk(priv, 1);
+	udelay(1);
+	
+	fcc_mdio_setclk(priv, 0);
+	udelay(1);
+
+	for (i = 0; i < 16; i++) {
+		retval <<= 1;
+		retval |= fcc_mdio_readbit(priv);
+	}
+
+	fcc_mdio_setdirection(priv, FCC_MDIO_W);
+	fcc_mdio_write_preamble(priv);
+
+	return retval;
+}
+
+void mii_clear_phy_interrupt(struct fcc_mii_info *mii_info)
+{
+	if(mii_info->phyinfo->ack_interrupt)
+		mii_info->phyinfo->ack_interrupt(mii_info);
+}
+
+
+void mii_configure_phy_interrupt(struct fcc_mii_info *mii_info,
+		u32 interrupts)
+{
+	mii_info->interrupts = interrupts;
+	if(mii_info->phyinfo->config_intr)
+		mii_info->phyinfo->config_intr(mii_info);
+}
+
+
+/* Writes MII_ADVERTISE with the appropriate values, after
+ * sanitizing advertise to make sure only supported features
+ * are advertised 
+ */
+static void config_genmii_advert(struct fcc_mii_info *mii_info)
+{
+	u32 advertise;
+	u16 adv;
+
+	/* Only allow advertising what this PHY supports */
+	mii_info->advertising &= mii_info->phyinfo->features;
+	advertise = mii_info->advertising;
+
+	/* Setup standard advertisement */
+	adv = phy_read(mii_info, MII_ADVERTISE);
+	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+	if (advertise & ADVERTISED_10baseT_Half)
+		adv |= ADVERTISE_10HALF;
+	if (advertise & ADVERTISED_10baseT_Full)
+		adv |= ADVERTISE_10FULL;
+	if (advertise & ADVERTISED_100baseT_Half)
+		adv |= ADVERTISE_100HALF;
+	if (advertise & ADVERTISED_100baseT_Full)
+		adv |= ADVERTISE_100FULL;
+	phy_write(mii_info, MII_ADVERTISE, adv);
+}
+
+/* Configures MII_BMCR to force speed/duplex to the 
+ * values in mii_info */
+static void genmii_setup_forced(struct fcc_mii_info *mii_info)
+{
+	u16 ctrl;
+	u32 features = mii_info->phyinfo->features;
+	
+	ctrl = phy_read(mii_info, MII_BMCR);
+
+	ctrl &= ~(BMCR_FULLDPLX|BMCR_SPEED100|BMCR_SPEED1000|BMCR_ANENABLE);
+	ctrl |= BMCR_RESET;
+
+	switch(mii_info->speed) {
+		case SPEED_1000:
+			if(features & (SUPPORTED_1000baseT_Half
+						| SUPPORTED_1000baseT_Full)) {
+				ctrl |= BMCR_SPEED1000;
+				break;
+			}
+			mii_info->speed = SPEED_100;
+		case SPEED_100:
+			if (features & (SUPPORTED_100baseT_Half
+						| SUPPORTED_100baseT_Full)) {
+				ctrl |= BMCR_SPEED100;
+				break;
+			}
+			mii_info->speed = SPEED_10;
+		case SPEED_10:
+			if (features & (SUPPORTED_10baseT_Half
+						| SUPPORTED_10baseT_Full))
+				break;
+		default: /* Unsupported speed! */
+			printk(KERN_ERR "%s: Bad speed!\n", 
+					mii_info->dev->name);
+			break;
+	}
+
+	phy_write(mii_info, MII_BMCR, ctrl);
+}
+
+
+/* Enable and Restart Autonegotiation */
+static void genmii_restart_aneg(struct fcc_mii_info *mii_info)
+{
+	u16 ctl;
+
+	ctl = phy_read(mii_info, MII_BMCR);
+	ctl |= (BMCR_ANENABLE | BMCR_ANRESTART);
+	phy_write(mii_info, MII_BMCR, ctl);
+}
+
+
+static int genmii_config_aneg(struct fcc_mii_info *mii_info)
+{
+	if (mii_info->autoneg) {
+		config_genmii_advert(mii_info);
+		genmii_restart_aneg(mii_info);
+	} else
+		genmii_setup_forced(mii_info);
+
+	return 0;
+}
+
+
+static int genmii_update_link(struct fcc_mii_info *mii_info)
+{
+	u16 status;
+
+	/* Do a fake read */
+	phy_read(mii_info, MII_BMSR);
+
+	/* Read link and autonegotiation status */
+	status = phy_read(mii_info, MII_BMSR);
+	if ((status & BMSR_LSTATUS) == 0)
+		mii_info->link = 0;
+	else
+		mii_info->link = 1;
+
+	/* If we are autonegotiating, and not done, 
+	 * return an error */
+	if (mii_info->autoneg && !(status & BMSR_ANEGCOMPLETE))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int genmii_read_status(struct fcc_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	if (mii_info->autoneg) {
+		status = phy_read(mii_info, MII_LPA);
+
+		if (status & (LPA_10FULL | LPA_100FULL))
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+		if (status & (LPA_100FULL | LPA_100HALF))
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+		mii_info->pause = 0;
+	}
+	/* On non-aneg, we assume what we put in BMCR is the speed,
+	 * though magic-aneg shouldn't prevent this case from occurring
+	 */
+
+	return 0;
+}
+
+#define DM9161_DELAY 10
+
+static int dm9161_read_status(struct fcc_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_DM9161_SCSR);
+		if (status & (MII_DM9161_SCSR_100F | MII_DM9161_SCSR_100H))
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+
+		if (status & (MII_DM9161_SCSR_100F | MII_DM9161_SCSR_10F))
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+	}
+
+	return 0;
+}
+
+
+static int dm9161_config_aneg(struct fcc_mii_info *mii_info)
+{
+	struct dm9161_private *priv = mii_info->priv;
+	if(0 == priv->resetdone)
+		return -EAGAIN;
+	return 0;
+}
+
+static void dm9161_timer(unsigned long data)
+{
+	struct fcc_mii_info *mii_info = (struct fcc_mii_info *)data;
+	struct dm9161_private *priv = mii_info->priv;
+	u16 status = phy_read(mii_info, MII_BMSR);
+	
+	if (status & BMSR_ANEGCOMPLETE) {
+		priv->resetdone = 1;
+	} else
+		mod_timer(&priv->timer, jiffies + DM9161_DELAY * HZ);
+}
+
+static int dm9161_init(struct fcc_mii_info *mii_info)
+{
+	struct dm9161_private *priv;
+	
+	/* Allocate the private data structure */
+	priv = kmalloc(sizeof(struct dm9161_private), GFP_KERNEL);
+
+	if (NULL == priv)
+		return -ENOMEM;
+
+	mii_info->priv = priv;
+
+	/* Reset is not done yet */
+	priv->resetdone = 0;
+
+	/* Isolate the PHY */
+	phy_write(mii_info, MII_BMCR, BMCR_ISOLATE);
+
+	/* Do not bypass the scrambler/descrambler */
+	phy_write(mii_info, MII_DM9161_SCR, MII_DM9161_SCR_INIT);
+
+	/* Clear 10BTCSR to default */
+	phy_write(mii_info, MII_DM9161_10BTCSR, MII_DM9161_10BTCSR_INIT);
+
+	/* Reconnect the PHY, and enable Autonegotiation */
+	phy_write(mii_info, MII_BMCR, BMCR_ANENABLE);
+	
+	/* Start a timer for DM9161_DELAY seconds to wait
+	 * for the PHY to be ready */
+	init_timer(&priv->timer);
+	priv->timer.function = &dm9161_timer;
+	priv->timer.data = (unsigned long) mii_info;
+	mod_timer(&priv->timer, jiffies + DM9161_DELAY * HZ);
+
+	return 0;
+}
+
+static void dm9161_close(struct fcc_mii_info *mii_info)
+{
+	struct dm9161_private *priv = mii_info->priv;
+	
+	del_timer_sync(&priv->timer);
+	kfree(priv);
+}
+
+static int dm9161_ack_interrupt(struct fcc_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_DM9161_INTR);
+	return 0;
+}
+
+static int lxt970_read_status(struct fcc_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_LXT970_CSR);
+		if (status & MII_LXT970_CSR_DUPLEX)
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+
+		if (status & MII_LXT970_CSR_SPEED)
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+	}
+
+	return 0;
+}
+
+static int lxt970_ack_interrupt(struct fcc_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_BMSR);
+	phy_read(mii_info, MII_LXT970_ISR);
+
+	return 0;
+}
+
+static int lxt970_config_intr(struct fcc_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_LXT970_IER, MII_LXT970_IER_IEN);
+	else
+		phy_write(mii_info, MII_LXT970_IER, 0);
+
+	return 0;
+}
+
+static int lxt970_init(struct fcc_mii_info *mii_info)
+{
+	phy_write(mii_info, MII_LXT970_CONFIG, 0);
+
+	return 0;
+}
+
+
+static int lxt971_read_status(struct fcc_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_LXT971_SR2);
+		if (status & MII_LXT971_SR2_DUPLEX)
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex= DUPLEX_HALF;
+
+		if (status & MII_LXT971_SR2_SPEED)
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+	}
+
+	return 0;
+}
+
+static int lxt971_ack_interrupt(struct fcc_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_LXT971_ISR);
+
+	return 0;
+}
+
+static int lxt971_config_intr(struct fcc_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_LXT971_IER, MII_LXT971_IER_IEN);
+	else
+		phy_write(mii_info, MII_LXT971_IER, 0);
+
+	return 0;
+}
+
+static int qs6612_read_status(struct fcc_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_QS6612_PCR);
+		switch((status >> 2) & 7) {
+			case 1: mii_info->speed = 10;
+				mii_info->duplex = 0;
+				break;
+			case 2: mii_info->speed = 100;
+				mii_info->duplex = 0;
+				break;
+			case 5: mii_info->speed = 10;
+				mii_info->duplex = 1;
+				break;
+			case 6: mii_info->speed = 100;
+				mii_info->duplex = 1;
+				break;
+		}
+	}
+
+	return 0;
+}
+
+int qs6612_init(struct fcc_mii_info *mii_info)
+{
+	/* The PHY powers up isolated on the RPX,
+	 * so send a command to allow operation.
+	 * XXX - I don't have the docs, so for 
+	 * now this constant is "magic" -Andy
+	 */
+	phy_write(mii_info, MII_QS6612_PCR, 0x0dc0);
+
+	return 0;
+}
+
+int qs6612_ack_interrupt(struct fcc_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_QS6612_ISR);
+	phy_read(mii_info, MII_BMSR);
+	phy_read(mii_info, MII_EXPANSION);
+
+	return 0;
+}
+
+int qs6612_config_intr(struct fcc_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_QS6612_IMR,
+				MII_QS6612_IMR_INIT);
+	else
+		phy_write(mii_info, MII_QS6612_IMR, 0);
+
+	return 0;
+
+}
+
+int dm9161_config_intr(struct fcc_mii_info *mii_info)
+{
+	u16 temp;
+
+	temp = phy_read(mii_info, MII_DM9161_INTR);
+
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		temp &= ~(MII_DM9161_INTR_STOP);
+	else
+		temp |= MII_DM9161_INTR_STOP;
+
+	phy_write(mii_info, MII_DM9161_INTR, temp);
+
+	return 0;
+}
+
+
+static struct phy_info phy_info_lxt970 = {
+	.phy_id		= 0x07810000,
+	.name		= "LXT970",
+	.phy_id_mask	= 0x0fffffff,
+	.init		= lxt970_init,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= lxt970_read_status,
+	.ack_interrupt	= lxt970_ack_interrupt,
+	.config_intr	= lxt970_config_intr,
+};
+
+static struct phy_info phy_info_lxt971 = {
+	.phy_id		= 0x0001378e,
+	.name		= "LXT971",
+	.phy_id_mask	= 0x0fffffff,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= lxt971_read_status,
+	.ack_interrupt	= lxt971_ack_interrupt,
+	.config_intr	= lxt971_config_intr,
+};
+
+static struct phy_info phy_info_dm9161 = {
+	.phy_id		= 0x0181b880,
+	.name		= "Davicom DM9161E",
+	.phy_id_mask	= 0x0ffffff0,
+	.init		= dm9161_init,
+	.config_aneg	= dm9161_config_aneg,
+	.read_status	= dm9161_read_status,
+	.ack_interrupt	= dm9161_ack_interrupt,
+	.close		= dm9161_close,
+};
+
+static struct phy_info phy_info_qs6612 = {
+	.phy_id		= 0x00181440,
+	.name		= "QS6612",
+	.phy_id_mask	= 0xfffffff0,
+	.init		= qs6612_init,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= qs6612_read_status,
+	.ack_interrupt	= qs6612_ack_interrupt,
+	.config_intr	= qs6612_config_intr,
+};
+
+static struct phy_info phy_info_genmii= {
+	.phy_id		= 0x00000000,
+	.phy_id_mask	= 0x00000000,
+	.name		= "Generic MII",
+	.features	= MII_BASIC_FEATURES,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= genmii_read_status,
+};
+
+static struct phy_info *phy_info[] = {
+	&phy_info_lxt970,
+	&phy_info_lxt971,
+	&phy_info_dm9161,
+	&phy_info_qs6612,
+	&phy_info_genmii,
+	NULL
+};
+
+inline void fcc_mdio_writebit(struct fcc_enet_private *priv, u32 bit)
+{
+	struct cpm2_fec_platform_data *fcc_info = priv->fcc_info;
+
+	/* Bring the clock down */
+	fcc_mdio_setclk(priv, 0);
+	cpm2_pin_program(PORTC,bit,0,0,0,0,fcc_info->mdio);
+	/* Write the bit to the bus */
+	
+	udelay(1);
+
+	/* Bring the clock up */
+	fcc_mdio_setclk(priv, 1);
+
+	udelay(1);
+}
+
+inline u32 fcc_mdio_readbit(struct fcc_enet_private *priv)
+{
+	u32 retval;
+	u32 tempval;
+
+	struct cpm2_fec_platform_data *fcc_info = priv->fcc_info;
+	s_iop *io = cpm2_pin_read(PORTC);	
+
+	/* Bring the clock up */
+	fcc_mdio_setclk(priv, 1);
+
+	tempval = io->pdat;
+
+	/* Read the bit */
+	if (tempval & fcc_info->mdio)
+		retval = 1;
+	else
+		retval = 0;
+
+	udelay(1);
+
+	/* Bring the clock down */
+	fcc_mdio_setclk(priv, 0);
+
+	udelay(1);
+
+	return retval;
+}
+
+
+static inline void fcc_mdio_setdirection(struct fcc_enet_private *priv, u32 dir)
+{
+	struct cpm2_fec_platform_data *fcc_info = priv->fcc_info;
+	
+	if(dir == FCC_MDIO_W)
+		cpm2_pin_program(PORTC,1,0,0,(fcc_info->mdio | fcc_info->mdck),0,0);
+	else
+		cpm2_pin_program(PORTC,0,0,0,fcc_info->mdio,0,0);
+}
+
+static inline void fcc_mdio_setclk(struct fcc_enet_private *priv, int bit)
+{
+	struct cpm2_fec_platform_data *fcc_info = priv->fcc_info;
+	cpm2_pin_program(PORTC,bit,0,0,0,0,fcc_info->mdck);
+}
+
+
+static void fcc_mdio_write_preamble(struct fcc_enet_private *priv)
+{
+	int i;
+
+	/* Write a bunch of 1s */
+	for (i = 0; i < 32; i++) {
+		fcc_mdio_writebit(priv, 1);
+	}
+}
+
+/* Use the PHY ID registers to determine what type of PHY is
+ * attached to device dev.  return a struct phy_info structure
+ * describing that PHY
+ */
+struct phy_info * get_phy_info(struct fcc_mii_info *mii_info)
+{
+	u16 phy_reg;
+	u32 phy_ID;
+	int i;
+	struct phy_info *theInfo = NULL;
+	struct net_device *dev = mii_info->dev;
+
+	/* Grab the bits from PHYIR1, and put them 
+	 * in the upper half */
+	phy_reg = phy_read(mii_info, MII_PHYSID1);
+	phy_ID = (phy_reg & 0xffff) << 16;
+
+	/* Grab the bits from PHYIR2, and put them in the lower half */
+	phy_reg = phy_read(mii_info, MII_PHYSID2);
+	phy_ID |= (phy_reg & 0xffff);
+
+	/* loop through all the known PHY types, and find
+	 * one that matches the ID we read from the PHY. */
+	for (i = 0; phy_info[i]; i++)
+		if (phy_info[i]->phy_id == 
+				(phy_ID & phy_info[i]->phy_id_mask)) {
+			theInfo = phy_info[i];
+			break;
+		}
+
+	/* This shouldn't happen, as we have generic PHY support */
+	if (theInfo == NULL) {
+		printk("%s: PHY id %x is not supported!\n", dev->name,
+				phy_ID);
+		return NULL;
+	} else {
+		printk("%s: PHY is %s (%x)\n", dev->name,
+				theInfo->name, phy_ID);
+	}
+
+	return theInfo;
+}
+
+u16 phy_read(struct fcc_mii_info *mii_info, u16 regnum)
+{
+	u16 retval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mii_info->mdio_lock, flags);
+	retval = mii_info->mdio_read(mii_info->dev, mii_info->mii_id, regnum);
+	spin_unlock_irqrestore(&mii_info->mdio_lock, flags);
+
+	return retval;
+}
+
+void phy_write(struct fcc_mii_info *mii_info, u16 regnum, u16 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mii_info->mdio_lock, flags);
+	mii_info->mdio_write(mii_info->dev, mii_info->mii_id, regnum, val);
+	spin_unlock_irqrestore(&mii_info->mdio_lock, flags);
+}
diff -Nru a/drivers/net/cpm2_fcc_phy.h b/drivers/net/cpm2_fcc_phy.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/net/cpm2_fcc_phy.h	2005-05-04 17:09:58 +04:00
@@ -0,0 +1,220 @@
+/* 
+ * arch/ppc/cpm2_io/fcc_enet_phy.h
+ *
+ * FCC Ethernet Driver -- PHY handling
+ * Driver for FCC for 8xxx CPM
+ * Based on drivers/net/gianfar_phy.c
+ *
+ * Author: Andy Fleming
+ * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ * Copyright (c) 2002-2004 Freescale Semiconductor, Inc.
+ * Andy Fleming <afleming@freescale.com>
+ * 
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#ifndef __FCC_ENET_PHY_H
+#define __FCC_ENET_PHY_H
+
+#define FCC_MDIO_W 1
+#define FCC_MDIO_R 2
+
+#define READ_CMD 0x60020000
+#define WRITE_CMD 0x50020000
+
+#define FCC_AN_TIMEOUT         2000
+
+/* 1000BT control (Marvell & BCM54xx at least) */
+#define MII_1000BASETCONTROL			0x09
+#define MII_1000BASETCONTROL_FULLDUPLEXCAP	0x0200
+#define MII_1000BASETCONTROL_HALFDUPLEXCAP	0x0100
+
+/* DM9161 SCR */
+#define MII_DM9161_SCR          0x10
+#define MII_DM9161_SCR_INIT     0x0610
+
+/* DM9161 Specified Configuration and Status Register */
+#define MII_DM9161_SCSR	0x11
+#define MII_DM9161_SCSR_100F	0x8000
+#define MII_DM9161_SCSR_100H	0x4000
+#define MII_DM9161_SCSR_10F	0x2000
+#define MII_DM9161_SCSR_10H	0x1000
+
+/* DM9161 Interrupt Register */
+#define MII_DM9161_INTR	0x15
+#define MII_DM9161_INTR_PEND		0x8000
+#define MII_DM9161_INTR_DPLX_MASK	0x0800
+#define MII_DM9161_INTR_SPD_MASK	0x0400
+#define MII_DM9161_INTR_LINK_MASK	0x0200
+#define MII_DM9161_INTR_MASK		0x0100
+#define MII_DM9161_INTR_DPLX_CHANGE	0x0010
+#define MII_DM9161_INTR_SPD_CHANGE	0x0008
+#define MII_DM9161_INTR_LINK_CHANGE	0x0004
+#define MII_DM9161_INTR_INIT 		0x0000
+#define MII_DM9161_INTR_STOP	\
+(MII_DM9161_INTR_DPLX_MASK | MII_DM9161_INTR_SPD_MASK \
+ | MII_DM9161_INTR_LINK_MASK | MII_DM9161_INTR_MASK)
+
+/* DM9161 10BT Configuration/Status */
+#define MII_DM9161_10BTCSR	0x12
+#define MII_DM9161_10BTCSR_INIT	0x7800
+
+struct dm9161_private {
+	struct timer_list timer;
+	int resetdone;
+};
+
+/* The Level one LXT970 is used by many boards				     */
+
+#define MII_LXT970_MIRROR	 16  /* Mirror register           */
+#define MII_LXT970_IER		 17  /* Interrupt Enable Register */
+
+#define MII_LXT970_IER_IEN	 0x0002
+
+#define MII_LXT970_ISR		 18  /* Interrupt Status Register */
+
+#define MII_LXT970_CONFIG	 19  /* Configuration Register    */
+#define MII_LXT970_CSR		 20  /* Chip Status Register      */
+
+#define MII_LXT970_CSR_DUPLEX 0x1000
+#define MII_LXT970_CSR_SPEED 0x0800
+
+/* ------------------------------------------------------------------------- */
+/* The Level one LXT971 is used on some of my custom boards                  */
+
+/* register definitions for the 971 */
+
+#define MII_LXT971_PCR		16  /* Port Control Register     */
+
+#define MII_LXT971_SR2		17  /* Status Register 2         */
+#define MII_LXT971_SR2_DUPLEX	0x0200
+#define MII_LXT971_SR2_SPEED	0x4000
+
+#define MII_LXT971_IER		18  /* Interrupt Enable Register */
+#define MII_LXT971_IER_IEN	0x00f2
+
+#define MII_LXT971_ISR		19  /* Interrupt Status Register */
+
+#define MII_LXT971_LCR		20  /* LED Control Register      */
+
+#define MII_LXT971_TCR		30  /* Transmit Control Register */
+
+
+/* ------------------------------------------------------------------------- */
+/* The Quality Semiconductor QS6612 is used on the RPX CLLF                  */
+
+/* register definitions */
+
+#define MII_QS6612_MCR		17  /* Mode Control Register      */
+#define MII_QS6612_FTR		27  /* Factory Test Register      */
+#define MII_QS6612_MCO		28  /* Misc. Control Register     */
+#define MII_QS6612_ISR		29  /* Interrupt Source Register  */
+#define MII_QS6612_IMR		30  /* Interrupt Mask Register    */
+#define MII_QS6612_IMR_INIT	0x003a
+#define MII_QS6612_PCR		31  /* 100BaseTx PHY Control Reg. */
+
+#define MII_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
+				 SUPPORTED_10baseT_Full | \
+				 SUPPORTED_100baseT_Half | \
+				 SUPPORTED_100baseT_Full | \
+				 SUPPORTED_Autoneg | \
+				 SUPPORTED_TP | \
+				 SUPPORTED_MII)
+
+#define MII_INTERRUPT_DISABLED 0x0
+#define MII_INTERRUPT_ENABLED 0x1
+
+/* Taken from mii_if_info and sungem_phy.h */
+struct fcc_mii_info {
+	/* Information about the PHY type */
+	/* And management functions */
+	struct phy_info *phyinfo;
+
+	/* forced speed & duplex (no autoneg)
+	 * partner speed & duplex & pause (autoneg)
+	 */
+	int speed;
+	int duplex;
+	int pause;
+
+	/* The most recently read link state */
+	int link;
+
+	/* Enabled Interrupts */
+	u32 interrupts;
+
+	u32 advertising;
+	int autoneg;
+	int mii_id;
+
+	/* private data pointer */
+	/* For use by PHYs to maintain extra state */
+	void *priv;
+
+	/* Provided by host chip */
+	struct net_device *dev;
+
+	/* A lock to ensure that only one thing can read/write
+	 * the MDIO bus at a time */
+	spinlock_t mdio_lock;
+
+	/* Provided by ethernet driver */
+	int (*mdio_read) (struct net_device *dev, int mii_id, int reg);
+	void (*mdio_write) (struct net_device *dev, int mii_id, 
+			int reg, int val);
+};
+
+/* struct phy_info: a structure which defines attributes for a PHY
+ *
+ * id will contain a number which represents the PHY.  During
+ * startup, the driver will poll the PHY to find out what its
+ * UID--as defined by registers 2 and 3--is.  The 32-bit result
+ * gotten from the PHY will be ANDed with phy_id_mask to
+ * discard any bits which may change based on revision numbers
+ * unimportant to functionality
+ *
+ * There are 6 commands which take a fcc_mii_info structure.
+ * Each PHY must declare config_aneg, and read_status.
+ */
+struct phy_info {
+	u32 phy_id;
+	char *name;
+	unsigned int phy_id_mask;
+	u32 features;
+
+	/* Called to initialize the PHY */
+	int (*init)(struct fcc_mii_info *mii_info);
+
+	/* Called to suspend the PHY for power */
+	int (*suspend)(struct fcc_mii_info *mii_info);
+
+	/* Reconfigures autonegotiation (or disables it) */
+	int (*config_aneg)(struct fcc_mii_info *mii_info);
+
+	/* Determines the negotiated speed and duplex */
+	int (*read_status)(struct fcc_mii_info *mii_info);
+
+	/* Clears any pending interrupts */
+	int (*ack_interrupt)(struct fcc_mii_info *mii_info);
+
+	/* Enables or disables interrupts */
+	int (*config_intr)(struct fcc_mii_info *mii_info);
+
+	/* Clears up any memory if needed */
+	void (*close)(struct fcc_mii_info *mii_info);
+};
+
+struct phy_info *get_phy_info(struct fcc_mii_info *mii_info);
+int read_phy_reg(struct net_device *dev, int mii_id, int regnum);
+void write_phy_reg(struct net_device *dev, int mii_id, int regnum, int value);
+void mii_clear_phy_interrupt(struct fcc_mii_info *mii_info);
+void mii_configure_phy_interrupt(struct fcc_mii_info *mii_info, u32 interrupts);
+
+#endif /* FCC_ENET_PHY_H */

--------------080000030708060304070100--
