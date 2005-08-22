Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 9636B68029
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 05:23:04 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so1056575wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 12:23:02 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 22 Aug 2005 22:21:48 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MXiCDp6CxRz0zaY"
Message-Id: <200508222221.48443.pantelis.antoniou@gmail.com>
Subject: [PATCH 1/3] fs_enet: core
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_MXiCDp6CxRz0zaY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi 

This is a snapshot of the work in progress of the new
fs_enet driver. It's aim is to replace all the various
SCC/FCC/FEC drivers for the Freescale PQs.

Don't expect it to work on your board just yet, just take
a look and comment.

This part contains the core driver files.

Regards

Pantelis

--Boundary-00=_MXiCDp6CxRz0zaY
Content-Type: text/plain;
  charset="us-ascii";
  name="fs_enet-core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="fs_enet-core.patch"

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -527,6 +527,42 @@ config WINCEPT
 
 endchoice
 
+menu "Freescale Ethernet driver platform-specific options"
+	depends on FS_ENET
+	
+	config MPC8xx_SECOND_ETH
+	bool "Second Ethernet channel"
+	depends on (MPC885ADS || MPC86xADS)
+	default y
+	help
+	  This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
+	  The latter will use SCC1, for 885ADS you can select it below.
+	
+	choice 
+		prompt "Second Ethernet channel"
+		depends on MPC8xx_SECOND_ETH
+		default MPC885ADS_SECOND_ETH_FEC2
+				
+		config MPC885ADS_SECOND_ETH_FEC2
+		bool "FEC2"
+		help
+		  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2 
+		  (often 2-nd UART) will not work if this is enabled.
+	  
+		config MPC885ADS_SECOND_ETH_SCC
+		bool "SCC3"
+    		help
+		  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC2 
+		  (often 1-nd UART) will not work if this is enabled.
+	
+	endchoice
+	
+		config MPC885ADS_SCC_ENET_FIXED
+		depends on MPC885ADS_SECOND_ETH_SCC
+		default n
+		bool "Use fixed MII-less mode for SCC Ethernet"
+endmenu
+
 choice
 	prompt "Machine Type"
 	depends on 6xx || POWER3 || POWER4
@@ -759,6 +795,16 @@ config MPC834x
 	bool
 	default y if MPC834x_SYS
 
+config CPM1
+	bool
+	depends on 8xx
+	default y
+	help
+	  The CPM1 (Communications Processor Module) is a coprocessor on
+	  embedded CPUs made by Motorola.  Selecting this option means that
+	  you wish to build a kernel for a machine with a CPM1 coprocessor
+	  on it (8xx, 827x, 8560).
+
 config CPM2
 	bool
 	depends on 8260 || MPC8560 || MPC8555
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1750,6 +1750,7 @@ config NE_H8300
 	  controller on the Renesas H8/300 processor.
 
 source "drivers/net/fec_8xx/Kconfig"
+source "drivers/net/fs_enet/Kconfig"
 
 endmenu
 
--- /dev/null
+++ b/include/linux/fs_enet_pd.h
@@ -0,0 +1,136 @@
+/*
+ * Platform information definitions for the
+ * universal Freescale Ethernet driver.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#ifndef FS_ENET_PD_H
+#define FS_ENET_PD_H
+
+#include <linux/version.h>
+#include <asm/types.h>
+
+#define FS_ENET_NAME	"fs_enet"
+
+enum fs_id {
+	fsid_fec1,
+	fsid_fec2,
+	fsid_fcc1,
+	fsid_fcc2,
+	fsid_fcc3,
+	fsid_scc1,
+	fsid_scc2,
+	fsid_scc3,
+	fsid_scc4,
+};
+
+#define FS_MAX_INDEX	9
+
+static inline int fs_get_fec_index(enum fs_id id)
+{
+	if (id >= fsid_fec1 && id <= fsid_fec2)
+		return id - fsid_fec1;
+	return -1;
+}
+
+static inline int fs_get_fcc_index(enum fs_id id)
+{
+	if (id >= fsid_fcc1 && id <= fsid_fcc3)
+		return id - fsid_fcc1;
+	return -1;
+}
+
+static inline int fs_get_scc_index(enum fs_id id)
+{
+	if (id >= fsid_scc1 && id <= fsid_scc4)
+		return id - fsid_scc1;
+	return -1;
+}
+
+enum fs_mii_method {
+	fsmii_fixed,
+	fsmii_fec,
+	fsmii_bitbang,
+};
+
+enum fs_ioport {
+	fsiop_porta,
+	fsiop_portb,
+	fsiop_portc,
+	fsiop_portd,
+	fsiop_porte,
+};
+
+struct fs_mii_bus_info {
+	int method;		/* mii method                  */
+	int id;			/* the id of the mii_bus       */
+	int disable_aneg;	/* if the controller needs to negothiate speed & duplex */
+	int lpa; 		/* the default board-specific vallues will be applied otherwise */
+
+	union {
+		struct {
+			int duplex;
+			int speed;
+		} fixed;
+
+		struct {
+			/* nothing */
+		} fec;
+		
+		struct {
+			/* nothing */
+		} scc;
+
+		struct {
+			int mdio_port;	/* port & bit for MDIO */
+			int mdio_bit;
+			int mdc_port;	/* port & bit for MDC  */
+			int mdc_bit;
+			int delay;	/* delay in us         */
+		} bitbang;
+	} i;
+};
+
+struct fs_platform_info {
+	
+	void(*init_ioports)(void);
+	/* device specific information */
+	int fs_no;		/* controller index            */
+
+	u32 cp_page;		/* CPM page */
+	u32 cp_block;		/* CPM sblock */
+	
+	u32 clk_trx;		/* some stuff for pins & mux configuration*/
+	u32 clk_route;
+	u32 clk_mask;
+	
+	u32 mem_offset;
+	u32 dpram_offset;
+	u32 fcc_regs_c;
+	
+	u32 device_flags;
+
+	int phy_addr;		/* the phy address (-1 no phy) */
+	int phy_irq;		/* the phy irq (if it exists)  */
+
+	const struct fs_mii_bus_info *bus_info;
+
+	int rx_ring, tx_ring;	/* number of buffers on rx     */
+	__u8 macaddr[6];	/* mac address                 */
+	int rx_copybreak;	/* limit we copy small frames  */
+	int use_napi;		/* use NAPI                    */
+	int napi_weight;	/* NAPI weight                 */
+
+	int use_rmii;		/* use RMII mode 	       */
+};
+
+#endif
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -1088,5 +1088,7 @@ typedef struct im_idma {
 #define SCCR_PCIDF_SHIFT 3
 
 
+
+#define FCC_PSMR_RMII   ((uint)0x00020000)      /* Use RMII interface */ 
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -195,3 +195,6 @@ obj-$(CONFIG_IRDA) += irda/
 obj-$(CONFIG_ETRAX_ETHERNET) += cris/
 
 obj-$(CONFIG_NETCONSOLE) += netconsole.o
+
+obj-$(CONFIG_FS_ENET) += fs_enet/
+
--- /dev/null
+++ b/drivers/net/fs_enet/Kconfig
@@ -0,0 +1,41 @@
+config FS_ENET
+       tristate "Freescale Ethernet Driver"
+       depends on NET_ETHERNET && (CPM1 || CPM2)
+       select MII
+
+config FS_ENET_HAS_SCC
+	bool "Chip has an SCC usable for ethernet"
+	depends on FS_ENET && (CPM1 || CPM2)
+	default y
+
+config FS_ENET_HAS_FCC
+	bool "Chip has an FCC usable for ethernet"
+	depends on FS_ENET && CPM2
+	default y
+
+config FS_ENET_HAS_FEC
+	bool "Chip has an FEC usable for ethernet"
+	depends on FS_ENET && CPM1
+	default y
+
+config SCC_ENET_8XX_FIXED
+        bool "Fixed method for SCC Ethernet PHY access "
+        depends on FS_ENET && (MPC885ADS ||  MPC866ADS)
+        default y
+
+choice
+        prompt "Second Ethernet channel"
+        depends on FS_ENET && MPC885ADS
+        default FEC2
+
+config FEC2
+        bool "FEC2"
+        help
+          Use MPC885 Fast rthernet controller 2 to drive Ethernet.
+
+config SCC_ETHERNET
+        bool "SCC3"
+        help
+          Use MPC8xx serial communications controller 3 to drive Ethernet.
+
+endchoice
--- /dev/null
+++ b/drivers/net/fs_enet/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the Freescale Ethernet controllers
+#
+
+obj-$(CONFIG_FS_ENET) += fs_enet.o
+
+obj-$(CONFIG_8xx) += mac-fec.o mac-scc.o
+obj-$(CONFIG_8260) += mac-fcc.o
+
+fs_enet-objs := fs_enet-main.o fs_enet-mii.o mii-bitbang.o mii-fixed.o
--- /dev/null
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -0,0 +1,1100 @@
+/*
+ * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ * 
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Heavily based on original FEC driver by Dan Malek <dan@embeddededge.com>
+ * and modifications by Joakim Tjernlund <joakim.tjernlund@lumentis.se>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/bitops.h>
+#include <linux/fs.h>
+
+#include <linux/vmalloc.h>
+#include <asm/pgtable.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+
+/*************************************************/
+
+static char version[] __devinitdata =
+    DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")" "\n";
+
+MODULE_AUTHOR("Pantelis Antoniou <panto@intracom.gr>");
+MODULE_DESCRIPTION("Freescale Ethernet Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_MODULE_VERSION);
+
+MODULE_PARM(fs_enet_debug, "i");
+MODULE_PARM_DESC(fs_enet_debug,
+		 "Freescale bitmapped debugging message enable value");
+
+int fs_enet_debug = -1;		/* -1 == use FS_ENET_DEF_MSG_ENABLE as value */
+
+static void fs_set_multicast_list(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	(*fep->ops->set_multicast_list)(dev);
+}
+
+/* common receive function */
+static int fs_enet_rx_common(struct net_device *dev, int *budget)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	cbd_t *bdp;
+	struct sk_buff *skb, *skbn, *skbt;
+	int received = 0;
+	u16 pkt_len, sc;
+	int curidx;
+	int rx_work_limit = 0;	/* pacify gcc */
+
+	if (fpi->use_napi) {
+		rx_work_limit = min(dev->quota, *budget);
+
+		if (!netif_running(dev))
+			return 0;
+	}
+
+	/*
+	 * First, grab all of the stats for the incoming packet.
+	 * These get messed up if we get called due to a busy condition.
+	 */
+	bdp = fep->cur_rx;
+
+	/* clear RX status bits for napi*/
+	if (fpi->use_napi)
+		(*fep->ops->napi_clear_rx_event)(dev);
+
+	while (((sc = CBDR_SC(bdp)) & BD_ENET_RX_EMPTY) == 0) {
+
+		curidx = bdp - fep->rx_bd_base;
+
+		/*
+		 * Since we have allocated space to hold a complete frame,
+		 * the last indicator should be set.
+		 */
+		if ((sc & BD_ENET_RX_LAST) == 0)
+			printk(KERN_WARNING DRV_MODULE_NAME
+			       ": %s rcv is not +last\n",
+			       dev->name);
+
+		/*
+		 * Check for errors. 
+		 */
+		if (sc & (BD_ENET_RX_LG | BD_ENET_RX_SH | BD_ENET_RX_CL |
+			  BD_ENET_RX_NO | BD_ENET_RX_CR | BD_ENET_RX_OV)) {
+			fep->stats.rx_errors++;
+			/* Frame too long or too short. */
+			if (sc & (BD_ENET_RX_LG | BD_ENET_RX_SH))
+				fep->stats.rx_length_errors++;
+			/* Frame alignment */
+			if (sc & (BD_ENET_RX_NO | BD_ENET_RX_CL))
+				fep->stats.rx_frame_errors++;
+			/* CRC Error */
+			if (sc & BD_ENET_RX_CR)
+				fep->stats.rx_crc_errors++;
+			/* FIFO overrun */
+			if (sc & BD_ENET_RX_OV)
+				fep->stats.rx_crc_errors++;
+
+			skb = fep->rx_skbuff[curidx];
+
+			dma_unmap_single(fep->dev, skb->data,
+				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
+				DMA_FROM_DEVICE);
+
+			skbn = skb;
+
+		} else {
+
+			/* napi, got packet but no quota */
+			if (fpi->use_napi && --rx_work_limit < 0)
+				break;
+
+			skb = fep->rx_skbuff[curidx];
+
+			dma_unmap_single(fep->dev, skb->data,
+				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
+				DMA_FROM_DEVICE);
+
+			/*
+			 * Process the incoming frame.
+			 */
+			fep->stats.rx_packets++;
+			pkt_len = CBDR_DATLEN(bdp) - 4;	/* remove CRC */
+			fep->stats.rx_bytes += pkt_len + 4;
+
+			if (pkt_len <= fpi->rx_copybreak) {
+				/* +2 to make IP header L1 cache aligned */
+				skbn = dev_alloc_skb(pkt_len + 2);
+				if (skbn != NULL) {
+					skb_reserve(skbn, 2);	/* align IP header */
+					memcpy(skbn->data, skb->data, pkt_len);
+					/* swap */
+					skbt = skb;
+					skb = skbn;
+					skbn = skbt;
+				}
+			} else
+				skbn = dev_alloc_skb(ENET_RX_FRSIZE);
+
+			if (skbn != NULL) {
+				skb->dev = dev;
+				skb_put(skb, pkt_len);	/* Make room */
+				skb->protocol = eth_type_trans(skb, dev);
+				received++;
+				if (!fpi->use_napi)
+					netif_rx(skb);
+				else
+					netif_receive_skb(skb);
+			} else {
+				printk(KERN_WARNING DRV_MODULE_NAME
+				       ": %s Memory squeeze, dropping packet.\n",
+				       dev->name);
+				fep->stats.rx_dropped++;
+				skbn = skb;
+			}
+		}
+
+		fep->rx_skbuff[curidx] = skbn;
+		CBDW_BUFADDR(bdp, dma_map_single(fep->dev, skbn->data,
+			     L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
+			     DMA_FROM_DEVICE));
+		CBDW_DATLEN(bdp, 0);
+		CBDW_SC(bdp, (sc & ~BD_ENET_RX_STATS) | BD_ENET_RX_EMPTY);
+
+		/*
+		 * Update BD pointer to next entry. 
+		 */
+		if ((sc & BD_ENET_RX_WRAP) == 0)
+			bdp++;
+		else
+			bdp = fep->rx_bd_base;
+
+		(*fep->ops->rx_bd_done)(dev);
+	}
+
+	fep->cur_rx = bdp;
+
+	if (fpi->use_napi) {
+		dev->quota -= received;
+		*budget -= received;
+
+		if (rx_work_limit < 0)
+			return 1;	/* not done */
+
+		/* done */
+		netif_rx_complete(dev);
+
+		(*fep->ops->napi_enable_rx)(dev);
+	}
+
+	return 0;
+}
+
+static void fs_enet_tx(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	cbd_t *bdp;
+	struct sk_buff *skb;
+	int dirtyidx, do_wake, do_restart;
+	u16 sc;
+
+	spin_lock(&fep->lock);
+	bdp = fep->dirty_tx;
+
+	do_wake = do_restart = 0;
+	while (((sc = CBDR_SC(bdp)) & BD_ENET_TX_READY) == 0) {
+
+		dirtyidx = bdp - fep->tx_bd_base;
+
+		if (fep->tx_free == fep->tx_ring)
+			break;
+
+		skb = fep->tx_skbuff[dirtyidx];
+
+		/*
+		 * Check for errors. 
+		 */
+		if (sc & (BD_ENET_TX_HB | BD_ENET_TX_LC |
+			  BD_ENET_TX_RL | BD_ENET_TX_UN | BD_ENET_TX_CSL)) {
+
+			if (sc & BD_ENET_TX_HB)	/* No heartbeat */
+				fep->stats.tx_heartbeat_errors++;
+			if (sc & BD_ENET_TX_LC)	/* Late collision */
+				fep->stats.tx_window_errors++;
+			if (sc & BD_ENET_TX_RL)	/* Retrans limit */
+				fep->stats.tx_aborted_errors++;
+			if (sc & BD_ENET_TX_UN)	/* Underrun */
+				fep->stats.tx_fifo_errors++;
+			if (sc & BD_ENET_TX_CSL)	/* Carrier lost */
+				fep->stats.tx_carrier_errors++;
+
+			if (sc & (BD_ENET_TX_LC | BD_ENET_TX_RL | BD_ENET_TX_UN)) {
+				fep->stats.tx_errors++;
+				do_restart = 1;
+			}
+		} else
+			fep->stats.tx_packets++;
+
+		if (sc & BD_ENET_TX_READY)
+			printk(KERN_WARNING DRV_MODULE_NAME
+			       ": %s HEY! Enet xmit interrupt and TX_READY.\n",
+			       dev->name);
+
+		/*
+		 * Deferred means some collisions occurred during transmit,
+		 * but we eventually sent the packet OK.
+		 */
+		if (sc & BD_ENET_TX_DEF)
+			fep->stats.collisions++;
+
+		/* unmap */
+		dma_unmap_single(fep->dev, skb->data, skb->len, DMA_TO_DEVICE);
+
+		/*
+		 * Free the sk buffer associated with this last transmit. 
+		 */
+		dev_kfree_skb_irq(skb);
+		fep->tx_skbuff[dirtyidx] = NULL;
+
+		/*
+		 * Update pointer to next buffer descriptor to be transmitted. 
+		 */
+		if ((sc & BD_ENET_TX_WRAP) == 0)
+			bdp++;
+		else
+			bdp = fep->tx_bd_base;
+
+		/*
+		 * Since we have freed up a buffer, the ring is no longer
+		 * full.
+		 */
+		if (!fep->tx_free++)
+			do_wake = 1;
+	}
+
+	fep->dirty_tx = bdp;
+
+	if (do_restart)
+		(*fep->ops->tx_restart)(dev);
+
+	spin_unlock(&fep->lock);
+
+	if (do_wake)
+		netif_wake_queue(dev);
+}
+
+/*
+ * The interrupt handler.
+ * This is called from the MPC core interrupt.
+ */
+static irqreturn_t
+fs_enet_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *dev = dev_id;
+	struct fs_enet_private *fep;
+	const struct fs_platform_info *fpi;
+	u32 int_events;
+	u32 int_clr_events;
+	int nr, napi_ok;
+
+	fep = netdev_priv(dev);
+	fpi = fep->fpi;
+
+	nr = 0;
+	while ((int_events = (*fep->ops->get_int_events)(dev)) != 0) {
+
+		nr++;
+
+		int_clr_events = int_events;
+		if (fpi->use_napi)
+			int_clr_events &= ~fep->ev_napi_rx;
+
+		(*fep->ops->clear_int_events)(dev, int_clr_events);
+
+		if (int_events & fep->ev_err)
+			(*fep->ops->ev_error)(dev, int_events);
+
+		if (int_events & fep->ev_rx) {
+			if (!fpi->use_napi)
+				fs_enet_rx_common(dev, NULL);
+			else {
+				napi_ok = netif_rx_schedule_prep(dev);
+
+				(*fep->ops->napi_disable_rx)(dev);
+				(*fep->ops->clear_int_events)(dev, fep->ev_napi_rx);
+
+				/* NOTE: it is possible for FCCs in NAPI mode    */
+				/* to submit an spurious interrupt while in poll */
+				if (napi_ok)
+					__netif_rx_schedule(dev);
+			}
+		}
+
+		if (int_events & fep->ev_tx)
+			fs_enet_tx(dev);
+	}
+
+	if (nr == 0)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+void fs_init_bds(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	cbd_t *bdp;
+	struct sk_buff *skb;
+	int i;
+
+	fs_cleanup_bds(dev);
+
+	fep->dirty_tx = fep->cur_tx = fep->tx_bd_base;
+	fep->tx_free = fep->tx_ring;
+	fep->cur_rx = fep->rx_bd_base;
+
+	/*
+	 * Initialize the receive buffer descriptors. 
+	 */
+	for (i = 0, bdp = fep->rx_bd_base; i < fep->rx_ring; i++, bdp++) {
+		skb = dev_alloc_skb(ENET_RX_FRSIZE);
+		if (skb == NULL) {
+			printk(KERN_WARNING DRV_MODULE_NAME
+			       ": %s Memory squeeze, unable to allocate skb\n",
+			       dev->name);
+			break;
+		}
+		fep->rx_skbuff[i] = skb;
+		skb->dev = dev;
+		CBDW_BUFADDR(bdp,
+			dma_map_single(fep->dev, skb->data,
+				L1_CACHE_ALIGN(PKT_MAXBUF_SIZE),
+				DMA_FROM_DEVICE));
+		CBDW_DATLEN(bdp, 0);	/* zero */
+		CBDW_SC(bdp, BD_ENET_RX_EMPTY |
+			((i < fep->rx_ring - 1) ? 0 : BD_SC_WRAP));
+	}
+	/*
+	 * if we failed, fillup remainder 
+	 */
+	for (; i < fep->rx_ring; i++, bdp++) {
+		fep->rx_skbuff[i] = NULL;
+		CBDW_SC(bdp, (i < fep->rx_ring - 1) ? 0 : BD_SC_WRAP);
+	}
+
+	/*
+	 * ...and the same for transmit.  
+	 */
+	for (i = 0, bdp = fep->tx_bd_base; i < fep->tx_ring; i++, bdp++) {
+		fep->tx_skbuff[i] = NULL;
+		CBDW_BUFADDR(bdp, 0);
+		CBDW_DATLEN(bdp, 0);
+		CBDW_SC(bdp, (i < fep->tx_ring - 1) ? 0 : BD_SC_WRAP);
+	}
+}
+
+void fs_cleanup_bds(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct sk_buff *skb;
+	int i;
+
+	/*
+	 * Reset SKB transmit buffers.  
+	 */
+	for (i = 0; i < fep->tx_ring; i++) {
+		if ((skb = fep->tx_skbuff[i]) == NULL)
+			continue;
+
+		/* unmap */
+		dma_unmap_single(fep->dev, skb->data, skb->len, DMA_TO_DEVICE);
+
+		fep->tx_skbuff[i] = NULL;
+		dev_kfree_skb(skb);
+	}
+
+	/*
+	 * Reset SKB receive buffers 
+	 */
+	for (i = 0; i < fep->rx_ring; i++) {
+		if ((skb = fep->rx_skbuff[i]) == NULL)
+			continue;
+		fep->rx_skbuff[i] = NULL;
+		dev_kfree_skb(skb);
+	}
+}
+
+/**********************************************************************************/
+
+static int fs_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	cbd_t *bdp;
+	int curidx;
+	u16 sc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fep->tx_lock, flags);
+
+	/*
+	 * Fill in a Tx ring entry 
+	 */
+	bdp = fep->cur_tx;
+
+	if (!fep->tx_free || (CBDR_SC(bdp) & BD_ENET_TX_READY)) {
+		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&fep->tx_lock, flags);
+
+		/*
+		 * Ooops.  All transmit buffers are full.  Bail out.
+		 * This should not happen, since the tx queue should be stopped.
+		 */
+		printk(KERN_WARNING DRV_MODULE_NAME
+		       ": %s tx queue full!.\n", dev->name);
+		return NETDEV_TX_BUSY;
+	}
+
+	curidx = bdp - fep->tx_bd_base;
+	/*
+	 * Clear all of the status flags. 
+	 */
+	CBDC_SC(bdp, BD_ENET_TX_STATS);
+
+	/*
+	 * Save skb pointer. 
+	 */
+	fep->tx_skbuff[curidx] = skb;
+
+	fep->stats.tx_bytes += skb->len;
+
+	/*
+	 * Push the data cache so the CPM does not get stale memory data. 
+	 */
+	CBDW_BUFADDR(bdp, dma_map_single(fep->dev,
+				skb->data, skb->len, DMA_TO_DEVICE));
+	CBDW_DATLEN(bdp, skb->len);
+
+	dev->trans_start = jiffies;
+
+	/*
+	 * If this was the last BD in the ring, start at the beginning again. 
+	 */
+	if ((CBDR_SC(bdp) & BD_ENET_TX_WRAP) == 0)
+		fep->cur_tx++;
+	else
+		fep->cur_tx = fep->tx_bd_base;
+
+	if (!--fep->tx_free)
+		netif_stop_queue(dev);
+
+	/* Trigger transmission start */
+	sc = BD_ENET_TX_READY | BD_ENET_TX_INTR |
+	     BD_ENET_TX_LAST | BD_ENET_TX_TC;
+
+	/* note that while FEC does not have this bit
+	 * it marks it as available for software use
+	 * yay for hw reuse :) */
+	if (skb->len <= 60)
+		sc |= BD_ENET_TX_PAD;
+	CBDS_SC(bdp, sc);
+
+	(*fep->ops->tx_kickstart)(dev);
+
+	spin_unlock_irqrestore(&fep->tx_lock, flags);
+
+	return NETDEV_TX_OK;
+}
+
+static int fs_request_irq(struct net_device *dev, int irq, const char *name,
+		irqreturn_t (*irqf)(int irq, void *dev_id, struct pt_regs *regs))
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	(*fep->ops->pre_request_irq)(dev, irq);
+	return request_irq(irq, irqf, SA_SHIRQ, name, dev);
+}
+
+static void fs_free_irq(struct net_device *dev, int irq)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	free_irq(irq, dev);
+	(*fep->ops->post_free_irq)(dev, irq);
+}
+
+/**********************************************************************************/
+
+/* This interrupt occurs when the PHY detects a link change. */
+static irqreturn_t
+fs_mii_link_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *dev = dev_id;
+	struct fs_enet_private *fep;
+	const struct fs_platform_info *fpi;
+
+	fep = netdev_priv(dev);
+	fpi = fep->fpi;
+
+	/*
+	 * Acknowledge the interrupt if possible. If we have not
+	 * found the PHY yet we can't process or acknowledge the
+	 * interrupt now. Instead we ignore this interrupt for now,
+	 * which we can do since it is edge triggered. It will be
+	 * acknowledged later by fs_enet_open().
+	 */
+	if (!fep->phy)
+		return IRQ_NONE;
+
+	fs_mii_ack_int(dev);
+	fs_mii_link_status_change_check(dev, 0);
+
+	return IRQ_HANDLED;
+}
+
+static void fs_timeout(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+
+	fep->stats.tx_errors++;
+
+	if (dev->flags & IFF_UP) {
+		spin_lock_irqsave(&fep->lock, flags);
+		(*fep->ops->stop)(dev);
+		(*fep->ops->restart)(dev);
+		spin_unlock_irqrestore(&fep->lock, flags);
+	}
+
+	netif_schedule(dev);
+}
+
+static int fs_enet_open(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	int r;
+
+	/* Install our interrupt handler. */
+	r = fs_request_irq(dev, fep->interrupt, "fs_enet-mac", fs_enet_interrupt);
+	if (r != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s Could not allocate FEC IRQ!", dev->name);
+		return -EINVAL;
+	}
+
+	/* Install our phy interrupt handler */
+	if (fpi->phy_irq != -1) {
+
+		r = fs_request_irq(dev, fpi->phy_irq, "fs_enet-phy", fs_mii_link_interrupt);
+		if (r != 0) {
+			printk(KERN_ERR DRV_MODULE_NAME
+			       ": %s Could not allocate PHY IRQ!", dev->name);
+			fs_free_irq(dev, fep->interrupt);
+			return -EINVAL;
+		}
+	}
+
+	fs_mii_startup(dev);
+	netif_carrier_off(dev);
+	fs_mii_link_status_change_check(dev, 1);
+
+	return 0;
+}
+
+static int fs_enet_close(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	unsigned long flags;
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	fs_mii_shutdown(dev);
+
+	spin_lock_irqsave(&fep->lock, flags);
+	(*fep->ops->stop)(dev);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	/* release any irqs */
+	if (fpi->phy_irq != -1)
+		fs_free_irq(dev, fpi->phy_irq);
+	fs_free_irq(dev, fep->interrupt);
+
+	return 0;
+}
+
+static struct net_device_stats *fs_enet_get_stats(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	return &fep->stats;
+}
+
+/*************************************************************************/
+
+static void fs_get_drvinfo(struct net_device *dev,
+			    struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, DRV_MODULE_NAME);
+	strcpy(info->version, DRV_MODULE_VERSION);
+}
+
+static int fs_get_regs_len(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	return (*fep->ops->get_regs_len)(dev);
+}
+
+static void fs_get_regs(struct net_device *dev, struct ethtool_regs *regs,
+			 void *p)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+	int r, len;
+
+	len = regs->len;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	r = (*fep->ops->get_regs)(dev, p, &len);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	if (r == 0)
+		regs->version = 0;
+}
+
+static int fs_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	rc = mii_ethtool_gset(&fep->mii_if, cmd);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	return rc;
+}
+
+static int fs_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	rc = mii_ethtool_sset(&fep->mii_if, cmd);
+	spin_unlock_irqrestore(&fep->lock, flags);
+
+	return rc;
+}
+
+static int fs_nway_reset(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	return mii_nway_restart(&fep->mii_if);
+}
+
+static u32 fs_get_msglevel(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	return fep->msg_enable;
+}
+
+static void fs_set_msglevel(struct net_device *dev, u32 value)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	fep->msg_enable = value;
+}
+
+static struct ethtool_ops fs_ethtool_ops = {
+	.get_drvinfo = fs_get_drvinfo,
+	.get_regs_len = fs_get_regs_len,
+	.get_settings = fs_get_settings,
+	.set_settings = fs_set_settings,
+	.nway_reset = fs_nway_reset,
+	.get_link = ethtool_op_get_link,
+	.get_msglevel = fs_get_msglevel,
+	.set_msglevel = fs_set_msglevel,
+	.get_tx_csum = ethtool_op_get_tx_csum,
+	.set_tx_csum = ethtool_op_set_tx_csum,	/* local! */
+	.get_sg = ethtool_op_get_sg,
+	.set_sg = ethtool_op_set_sg,
+	.get_regs = fs_get_regs,
+};
+
+static int fs_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&rq->ifr_data;
+	unsigned long flags;
+	int rc;
+
+	if (!netif_running(dev))
+		return -EINVAL;
+
+	spin_lock_irqsave(&fep->lock, flags);
+	rc = generic_mii_ioctl(&fep->mii_if, mii, cmd, NULL);
+	spin_unlock_irqrestore(&fep->lock, flags);
+	return rc;
+}
+
+extern int fs_mii_connect(struct net_device *dev);
+extern void fs_mii_disconnect(struct net_device *dev);
+
+static struct net_device *fs_init_instance(struct device *dev,
+		const struct fs_platform_info *fpi)
+{
+	struct net_device *ndev = NULL;
+	struct fs_enet_private *fep = NULL;
+	int privsize, i, r, err = 0, registered = 0;
+
+	/* guard */
+	if ((unsigned int)fpi->fs_no >= FS_MAX_INDEX)
+		return ERR_PTR(-EINVAL);
+
+	privsize = sizeof(*fep) + (sizeof(struct sk_buff **) *
+			    (fpi->rx_ring + fpi->tx_ring));
+
+	ndev = alloc_etherdev(privsize);
+	if (!ndev) {
+		err = -ENOMEM;
+		goto err;
+	}
+	SET_MODULE_OWNER(ndev);
+
+	fep = netdev_priv(ndev);
+	memset(fep, 0, privsize);	/* clear everything */
+
+	fep->dev = dev;
+	dev_set_drvdata(dev, ndev);
+	fep->fpi = fpi;
+	if (fpi->init_ioports)
+		fpi->init_ioports();
+
+#ifdef CONFIG_FS_ENET_HAS_FEC
+	if (fs_get_fec_index(fpi->fs_no) >= 0)
+		fep->ops = &fs_fec_ops;
+#endif
+
+#ifdef CONFIG_FS_ENET_HAS_SCC
+	if (fs_get_scc_index(fpi->fs_no) >=0 )
+		fep->ops = &fs_scc_ops;
+#endif
+
+#ifdef CONFIG_FS_ENET_HAS_FCC
+	if (fs_get_fcc_index(fpi->fs_no) >= 0)
+		fep->ops = &fs_fcc_ops;
+#endif
+
+	if (fep->ops == NULL) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s No matching ops found (%d).\n",
+		       ndev->name, fpi->fs_no);
+		err = -EINVAL;
+		goto err;
+	}
+
+	r = (*fep->ops->setup_data)(ndev);
+	if (r != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s setup_data failed\n",
+			ndev->name);
+		err = r;
+		goto err;
+	}
+
+	/* point rx_skbuff, tx_skbuff */
+	fep->rx_skbuff = (struct sk_buff **)&fep[1];
+	fep->tx_skbuff = fep->rx_skbuff + fpi->rx_ring;
+
+	/* init locks */
+	spin_lock_init(&fep->lock);
+	spin_lock_init(&fep->tx_lock);
+
+	/*
+	 * Set the Ethernet address. 
+	 */
+	for (i = 0; i < 6; i++)
+		ndev->dev_addr[i] = fpi->macaddr[i];
+	
+	r = (*fep->ops->allocate_bd)(ndev);
+	
+	if (fep->ring_base == NULL) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s buffer descriptor alloc failed (%d).\n", ndev->name, r);
+		err = r;
+		goto err;
+	}
+
+	/*
+	 * Set receive and transmit descriptor base.
+	 */
+	fep->rx_bd_base = fep->ring_base;
+	fep->tx_bd_base = fep->rx_bd_base + fpi->rx_ring;
+
+	/* initialize ring size variables */
+	fep->tx_ring = fpi->tx_ring;
+	fep->rx_ring = fpi->rx_ring;
+
+	/*
+	 * The FEC Ethernet specific entries in the device structure. 
+	 */
+	ndev->open = fs_enet_open;
+	ndev->hard_start_xmit = fs_enet_start_xmit;
+	ndev->tx_timeout = fs_timeout;
+	ndev->watchdog_timeo = 2 * HZ;
+	ndev->stop = fs_enet_close;
+	ndev->get_stats = fs_enet_get_stats;
+	ndev->set_multicast_list = fs_set_multicast_list;
+	if (fpi->use_napi) {
+		ndev->poll = fs_enet_rx_common;
+		ndev->weight = fpi->napi_weight;
+	}
+	ndev->ethtool_ops = &fs_ethtool_ops;
+	ndev->do_ioctl = fs_ioctl;
+
+	init_timer(&fep->phy_timer_list);
+
+	netif_carrier_off(ndev);
+
+	err = register_netdev(ndev);
+	if (err != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s register_netdev failed.\n", ndev->name);
+		goto err;
+	}
+	registered = 1;
+
+	err = fs_mii_connect(ndev);
+	if (err != 0) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s fs_mii_connect failed.\n", ndev->name);
+		goto err;
+	}
+
+	return ndev;
+
+      err:
+	if (ndev != NULL) {
+
+		if (registered)
+			unregister_netdev(ndev);
+
+		if (fep != NULL) {
+			(*fep->ops->free_bd)(ndev);
+			(*fep->ops->cleanup_data)(ndev);
+		}
+
+		free_netdev(ndev);
+	}
+
+	dev_set_drvdata(dev, NULL);
+
+	return ERR_PTR(err);
+}
+
+static int fs_cleanup_instance(struct net_device *ndev)
+{
+	struct fs_enet_private *fep;
+	const struct fs_platform_info *fpi;
+	struct device *dev;
+
+	if (ndev == NULL)
+		return -EINVAL;
+
+	fep = netdev_priv(ndev);
+	if (fep == NULL)
+		return -EINVAL;
+
+	fpi = fep->fpi;
+
+	fs_mii_disconnect(ndev);
+
+	unregister_netdev(ndev);
+
+	dma_free_coherent(fep->dev, (fpi->tx_ring + fpi->rx_ring) * sizeof(cbd_t),
+			  fep->ring_base, fep->ring_mem_addr);
+
+	/* reset it */
+	(*fep->ops->cleanup_data)(ndev);
+
+	dev = fep->dev;
+	if (dev != NULL) {
+		dev_set_drvdata(dev, NULL);
+		fep->dev = NULL;
+	}
+
+	free_netdev(ndev);
+
+	return 0;
+}
+
+/**************************************************************************************/
+
+/* handy pointer to the immap */
+void *fs_enet_immap = NULL;
+
+static int setup_immap(void)
+{
+	phys_addr_t paddr = 0;
+	unsigned long size = 0;
+
+#ifdef CONFIG_CPM1
+	paddr = IMAP_ADDR;
+	size = 0x10000;	/* map 64K */
+#endif
+
+#ifdef CONFIG_CPM2
+	paddr = CPM_MAP_ADDR;
+	size = 0x40000;	/* map 256 K */
+#endif
+	fs_enet_immap = ioremap(paddr, size);
+	if (fs_enet_immap == NULL)
+		return -EBADF;	/* XXX ahem; maybe just BUG_ON? */
+
+	return 0;
+}
+
+static void cleanup_immap(void)
+{
+	if (fs_enet_immap != NULL) {
+		iounmap(fs_enet_immap);
+		fs_enet_immap = NULL;
+	}
+}
+
+/**************************************************************************************/
+
+static int __devinit fs_enet_probe(struct device *dev)
+{
+	struct net_device *ndev;
+
+	/* no fixup - no device */
+	if (dev->platform_data == NULL) {
+		printk(KERN_INFO "fs_enet: "
+				"probe called with no platform data; "
+				"remove unused devices");
+		return -ENODEV;
+	}
+
+	ndev = fs_init_instance(dev, dev->platform_data);
+	if (IS_ERR(ndev))
+		return PTR_ERR(ndev);
+	return 0;
+}
+
+static int fs_enet_remove(struct device *dev)
+{
+	return fs_cleanup_instance(dev_get_drvdata(dev));
+}
+
+static struct device_driver fs_enet_fec_driver = {
+	.name	  	= "fsl-cpm-fec",
+	.bus		= &platform_bus_type,
+	.probe		= fs_enet_probe,
+	.remove		= fs_enet_remove,
+#ifdef CONFIG_PM
+/*	.suspend	= fs_enet_suspend,	TODO */
+/*	.resume		= fs_enet_resume,	TODO */
+#endif
+};
+
+static struct device_driver fs_enet_scc_driver = {
+	.name	  	= "fsl-cpm-scc",
+	.bus		= &platform_bus_type,
+	.probe		= fs_enet_probe,
+	.remove		= fs_enet_remove,
+#ifdef CONFIG_PM
+/*	.suspend	= fs_enet_suspend,	TODO */
+/*	.resume		= fs_enet_resume,	TODO */
+#endif
+};
+
+static struct device_driver fs_enet_fcc_driver = {
+	.name	  	= "fsl-cpm-fcc",
+	.bus		= &platform_bus_type,
+	.probe		= fs_enet_probe,
+	.remove		= fs_enet_remove,
+#ifdef CONFIG_PM
+/*	.suspend	= fs_enet_suspend,	TODO */
+/*	.resume		= fs_enet_resume,	TODO */
+#endif
+};
+
+static int __init fs_init(void)
+{
+	int r;
+
+	printk(KERN_INFO
+			"%s", version);
+
+	r = setup_immap();
+	if (r != 0)
+		return r;
+	r = driver_register(&fs_enet_fec_driver);
+	if (r != 0)
+		goto err;
+
+	r = driver_register(&fs_enet_fcc_driver);
+	if (r != 0)
+		goto err;
+
+	r = driver_register(&fs_enet_scc_driver);
+	if (r != 0)
+		goto err;
+
+	return 0;
+err:
+	cleanup_immap();
+	return r;
+	
+}
+
+static void __exit fs_cleanup(void)
+{
+	driver_unregister(&fs_enet_fec_driver);
+	driver_unregister(&fs_enet_fcc_driver);
+	driver_unregister(&fs_enet_scc_driver);
+	cleanup_immap();
+}
+
+/**************************************************************************************/
+
+module_init(fs_init);
+module_exit(fs_cleanup);
--- /dev/null
+++ b/drivers/net/fs_enet/fs_enet-mii.c
@@ -0,0 +1,522 @@
+/*
+ * Combined Ethernet driver for Motorola MPC8xx and MPC82xx.
+ *
+ * Copyright (c) 2003 Intracom S.A. 
+ *  by Pantelis Antoniou <panto@intracom.gr>
+ * 
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Heavily based on original FEC driver by Dan Malek <dan@embeddededge.com>
+ * and modifications by Joakim Tjernlund <joakim.tjernlund@lumentis.se>
+ *
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/bitops.h>
+
+#include <asm/pgtable.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+#include "fs_enet.h"
+
+/*************************************************/
+
+/*
+ * Generic PHY support.
+ * Should work for all PHYs, but link change is detected by polling
+ */
+
+static void generic_timer_callback(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fep->phy_timer_list.expires = jiffies + HZ / 2;
+
+	add_timer(&fep->phy_timer_list);
+
+	fs_mii_link_status_change_check(dev, 0);
+}
+
+static void generic_startup(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fep->phy_timer_list.expires = jiffies + HZ / 2;	/* every 500ms */
+	fep->phy_timer_list.data = (unsigned long)dev;
+	fep->phy_timer_list.function = generic_timer_callback;
+	add_timer(&fep->phy_timer_list);
+}
+
+static void generic_shutdown(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	del_timer_sync(&fep->phy_timer_list);
+}
+
+/* ------------------------------------------------------------------------- */
+/* The Davicom DM9161 is used on the NETTA board			     */
+
+/* register definitions */
+
+#define MII_DM9161_ANAR		4	/* Aux. Config Register         */
+#define MII_DM9161_ACR		16	/* Aux. Config Register         */
+#define MII_DM9161_ACSR		17	/* Aux. Config/Status Register  */
+#define MII_DM9161_10TCSR	18	/* 10BaseT Config/Status Reg.   */
+#define MII_DM9161_INTR		21	/* Interrupt Register           */
+#define MII_DM9161_RECR		22	/* Receive Error Counter Reg.   */
+#define MII_DM9161_DISCR	23	/* Disconnect Counter Register  */
+
+static void dm9161_startup(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fs_mii_write(dev, fep->mii_if.phy_id, MII_DM9161_INTR, 0x0000);
+	/* Start autonegotiation */
+	fs_mii_write(dev, fep->mii_if.phy_id, MII_BMCR, 0x1200);
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ*8);
+}
+
+static void dm9161_ack_int(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fs_mii_read(dev, fep->mii_if.phy_id, MII_DM9161_INTR);
+}
+
+static void dm9161_shutdown(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	fs_mii_write(dev, fep->mii_if.phy_id, MII_DM9161_INTR, 0x0f00);
+}
+
+/**********************************************************************************/
+
+static const struct phy_info phy_info[] = {
+	{
+		.id = 0x00181b88,
+		.name = "DM9161",
+		.startup = dm9161_startup,
+		.ack_int = dm9161_ack_int,
+		.shutdown = dm9161_shutdown,
+	}, {
+		.id = 0,
+		.name = "GENERIC",
+		.startup = generic_startup,
+		.shutdown = generic_shutdown,
+	},
+};
+
+/**********************************************************************************/
+
+static int phy_id_detect(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	struct fs_enet_mii_bus *bus = fep->mii_bus;
+	int i, r, start, end, phytype, physubtype;
+	const struct phy_info *phy;
+	int phy_hwid, phy_id;
+
+	phy_hwid = -1;
+	fep->phy = NULL;
+
+	/* auto-detect? */
+	if (fpi->phy_addr == -1) {
+		start = 1;
+		end = 32;
+	} else {		/* direct */
+		start = fpi->phy_addr;
+		end = start + 1;
+	}
+
+	for (phy_id = start; phy_id < end; phy_id++) {
+		/* skip already used phy addresses on this bus */ 
+		if (bus->usage_map & (1 << phy_id))
+			continue;
+		r = fs_mii_read(dev, phy_id, MII_PHYSID1);
+		if (r == -1 || (phytype = (r & 0xffff)) == 0xffff)
+			continue;
+		r = fs_mii_read(dev, phy_id, MII_PHYSID2);
+		if (r == -1 || (physubtype = (r & 0xffff)) == 0xffff)
+			continue;
+		phy_hwid = (phytype << 16) | physubtype;
+		if (phy_hwid != -1)
+			break;
+	}
+
+	if (phy_hwid == -1) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s No PHY detected! range=0x%02x-0x%02x\n",
+			dev->name, start, end);
+		return -1;
+	}
+
+	for (i = 0, phy = phy_info; i < ARRAY_SIZE(phy_info); i++, phy++)
+		if (phy->id == (phy_hwid >> 4) || phy->id == 0)
+			break;
+
+	if (i >= ARRAY_SIZE(phy_info)) {
+		printk(KERN_ERR DRV_MODULE_NAME
+		       ": %s PHY id 0x%08x is not supported!\n",
+		       dev->name, phy_hwid);
+		return -1;
+	}
+
+	fep->phy = phy;
+
+	/* mark this address as used */
+	bus->usage_map |= (1 << phy_id);
+
+	printk(KERN_INFO DRV_MODULE_NAME
+	       ": %s Phy @ 0x%x, type %s (0x%08x)%s\n",
+	       dev->name, phy_id, fep->phy->name, phy_hwid,
+	       fpi->phy_addr == -1 ? " (auto-detected)" : "");
+
+	return phy_id;
+}
+
+void fs_mii_startup(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (fep->phy == NULL)
+		return;
+
+	if (fep->phy->startup == NULL)
+		return;
+
+	(*fep->phy->startup) (dev);
+}
+
+void fs_mii_shutdown(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (fep->phy == NULL)
+		return;
+
+	if (fep->phy->shutdown == NULL)
+		return;
+
+	(*fep->phy->shutdown) (dev);
+}
+
+void fs_mii_ack_int(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+
+	if (fep->phy == NULL)
+		return;
+
+	if (fep->phy->ack_int == NULL)
+		return;
+
+	(*fep->phy->ack_int) (dev);
+}
+
+#define MII_LINK	0x0001
+#define MII_HALF	0x0002
+#define MII_FULL	0x0004
+#define MII_BASE4	0x0008
+#define MII_10M		0x0010
+#define MII_100M	0x0020
+#define MII_1G		0x0040
+#define MII_10G		0x0080
+
+/* return full mii info at one gulp, with a usable form */
+static unsigned int mii_full_status(struct mii_if_info *mii)
+{
+	unsigned int status;
+	int bmsr, adv, lpa, neg;
+	struct fs_enet_private* fep = netdev_priv(mii->dev);
+	
+	/* first, a dummy read, needed to latch some MII phys */
+	(void)mii->mdio_read(mii->dev, mii->phy_id, MII_BMSR);
+	bmsr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMSR);
+
+	/* no link */
+	if ((bmsr & BMSR_LSTATUS) == 0)
+		return 0;
+
+	status = MII_LINK;
+	
+	/* Lets look what ANEG says if it's supported - otherwize we shall
+	   take the right values from the platform info*/
+	if(!mii->force_media) {
+		/* autoneg not completed; don't bother */
+		if ((bmsr & BMSR_ANEGCOMPLETE) == 0)
+			return 0;
+
+		adv = (*mii->mdio_read)(mii->dev, mii->phy_id, MII_ADVERTISE);
+		lpa = (*mii->mdio_read)(mii->dev, mii->phy_id, MII_LPA);
+
+		neg = lpa & adv;
+	} else {
+		neg = fep->fpi->bus_info->lpa;
+	}
+
+	if (neg & LPA_100FULL)
+		status |= MII_FULL | MII_100M;
+	else if (neg & LPA_100BASE4)
+		status |= MII_FULL | MII_BASE4 | MII_100M;
+	else if (neg & LPA_100HALF)
+		status |= MII_HALF | MII_100M;
+	else if (neg & LPA_10FULL)
+		status |= MII_FULL | MII_10M;
+	else
+		status |= MII_HALF | MII_10M;
+	
+	return status;
+}
+
+void fs_mii_link_status_change_check(struct net_device *dev, int init_media)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct mii_if_info *mii = &fep->mii_if;
+	unsigned int mii_status;
+	int ok_to_print, link, duplex, speed;
+	unsigned long flags;
+
+	ok_to_print = netif_msg_link(fep);
+
+	mii_status = mii_full_status(mii);
+
+	if (!init_media && mii_status == fep->last_mii_status)
+		return;
+
+	fep->last_mii_status = mii_status;
+
+	link = !!(mii_status & MII_LINK);
+	duplex = !!(mii_status & MII_FULL);
+	speed = (mii_status & MII_100M) ? 100 : 10;
+
+	if (link == 0) {
+		netif_carrier_off(mii->dev);
+		netif_stop_queue(dev);
+		if (!init_media) {
+			spin_lock_irqsave(&fep->lock, flags);
+			(*fep->ops->stop)(dev);
+			spin_unlock_irqrestore(&fep->lock, flags);
+		}
+
+		if (ok_to_print)
+			printk(KERN_INFO "%s: link down\n", mii->dev->name);
+
+	} else {
+
+		mii->full_duplex = duplex;
+
+		netif_carrier_on(mii->dev);
+
+		spin_lock_irqsave(&fep->lock, flags);
+		fep->duplex = duplex;
+		fep->speed = speed;
+		(*fep->ops->restart)(dev);
+		spin_unlock_irqrestore(&fep->lock, flags);
+
+		netif_start_queue(dev);
+
+		if (ok_to_print)
+			printk(KERN_INFO "%s: link up, %dMbps, %s-duplex\n",
+			       dev->name, speed, duplex ? "full" : "half");
+	}
+}
+
+/**********************************************************************************/
+
+int fs_mii_read(struct net_device *dev, int phy_id, int location)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct fs_enet_mii_bus *bus = fep->mii_bus;
+
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&bus->mii_lock, flags);
+	ret = (*bus->mii_read)(bus, phy_id, location);
+	spin_unlock_irqrestore(&bus->mii_lock, flags);
+
+	return ret;
+}
+
+void fs_mii_write(struct net_device *dev, int phy_id, int location, int value)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct fs_enet_mii_bus *bus = fep->mii_bus;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bus->mii_lock, flags);
+	(*bus->mii_write)(bus, phy_id, location, value);
+	spin_unlock_irqrestore(&bus->mii_lock, flags);
+}
+
+/*****************************************************************************/
+
+/* list of all registered mii buses */
+static LIST_HEAD(fs_mii_bus_list);
+
+static struct fs_enet_mii_bus *lookup_bus(int method, int id)
+{
+	struct list_head *ptr;
+	struct fs_enet_mii_bus *bus;
+
+	list_for_each(ptr, &fs_mii_bus_list) {
+		bus = list_entry(ptr, struct fs_enet_mii_bus, list);
+		if (bus->bus_info->method == method &&
+			bus->bus_info->id == id)
+			return bus;
+	}
+	return NULL;
+}
+
+static struct fs_enet_mii_bus *create_bus(const struct fs_mii_bus_info *bi)
+{
+	struct fs_enet_mii_bus *bus;
+	int ret = 0;
+
+	bus = kmalloc(sizeof(*bus), GFP_KERNEL);
+	if (bus == NULL) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memset(bus, 0, sizeof(*bus));
+	spin_lock_init(&bus->mii_lock);
+	bus->bus_info = bi;
+	bus->refs = 0;
+	bus->usage_map = 0;
+
+	/* perform initialization */
+	switch (bi->method) {
+
+		case fsmii_fixed:
+			ret = fs_mii_fixed_init(bus);
+			if (ret != 0)
+				goto err;
+			break;
+
+		case fsmii_bitbang:
+			ret = fs_mii_bitbang_init(bus);
+			if (ret != 0)
+				goto err;
+			break;
+#ifdef CONFIG_FS_ENET_HAS_FEC
+		case fsmii_fec:
+			ret = fs_mii_fec_init(bus);
+			if (ret != 0)
+				goto err;
+			break;
+#endif
+		default:
+			ret = -EINVAL;
+			goto err;
+	}
+
+	list_add(&bus->list, &fs_mii_bus_list);
+
+	return bus;
+
+err:
+	if (bus)
+		kfree(bus);
+	return ERR_PTR(ret);
+}
+
+static void destroy_bus(struct fs_enet_mii_bus *bus)
+{
+	/* remove from bus list */
+	list_del(&bus->list);
+
+	/* nothing more needed */
+	kfree(bus);
+}
+
+int fs_mii_connect(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	const struct fs_platform_info *fpi = fep->fpi;
+	struct fs_enet_mii_bus *bus = NULL;
+
+	/* check method validity */
+	switch (fpi->bus_info->method) {
+		case fsmii_fixed:
+		case fsmii_bitbang:
+			break;
+#ifdef CONFIG_FS_ENET_HAS_FEC
+		case fsmii_fec:
+			break;
+#endif
+		default:
+			printk(KERN_ERR DRV_MODULE_NAME
+			       ": %s Unknown MII bus method (%d)!\n",
+			       dev->name, fpi->bus_info->method);
+			return -EINVAL; 
+	}
+
+	bus = lookup_bus(fpi->bus_info->method, fpi->bus_info->id);
+
+	/* if not found create new bus */
+	if (bus == NULL) {
+		bus = create_bus(fpi->bus_info);
+		if (IS_ERR(bus)) {
+			printk(KERN_ERR DRV_MODULE_NAME
+			       ": %s MII bus creation failure!\n", dev->name);
+			return PTR_ERR(bus);
+		}
+	}
+
+	bus->refs++;
+
+	fep->mii_bus = bus;
+
+	fep->mii_if.dev = dev;
+	fep->mii_if.phy_id_mask = 0x1f;
+	fep->mii_if.reg_num_mask = 0x1f;
+	fep->mii_if.mdio_read = fs_mii_read;
+	fep->mii_if.mdio_write = fs_mii_write;
+	fep->mii_if.force_media = fpi->bus_info->disable_aneg;
+	fep->mii_if.phy_id = phy_id_detect(dev);
+
+	return 0;
+}
+
+void fs_mii_disconnect(struct net_device *dev)
+{
+	struct fs_enet_private *fep = netdev_priv(dev);
+	struct fs_enet_mii_bus *bus = NULL;
+
+	bus = fep->mii_bus;
+	fep->mii_bus = NULL;
+
+	if (--bus->refs <= 0)
+		destroy_bus(bus);
+}
--- /dev/null
+++ b/drivers/net/fs_enet/fs_enet.h
@@ -0,0 +1,269 @@
+#ifndef FS_ENET_H
+#define FS_ENET_H
+
+#include <linux/mii.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/list.h>
+
+#include <linux/fs_enet_pd.h>
+
+#include <asm/dma-mapping.h>
+
+#ifdef CONFIG_CPM1
+#include <asm/commproc.h>
+#endif
+
+#ifdef CONFIG_CPM2
+#include <asm/cpm2.h>
+#endif
+
+/* hw driver ops */
+struct fs_ops {
+	int (*setup_data)(struct net_device *dev);
+	int (*allocate_bd)(struct net_device *dev);
+	void (*free_bd)(struct net_device *dev);
+	void (*cleanup_data)(struct net_device *dev);
+	void (*set_multicast_list)(struct net_device *dev);
+	void (*restart)(struct net_device *dev);
+	void (*stop)(struct net_device *dev);
+	void (*pre_request_irq)(struct net_device *dev, int irq);
+	void (*post_free_irq)(struct net_device *dev, int irq);
+	void (*napi_clear_rx_event)(struct net_device *dev);
+	void (*napi_enable_rx)(struct net_device *dev);
+	void (*napi_disable_rx)(struct net_device *dev);
+	void (*rx_bd_done)(struct net_device *dev);
+	void (*tx_kickstart)(struct net_device *dev);
+	u32 (*get_int_events)(struct net_device *dev);
+	void (*clear_int_events)(struct net_device *dev, u32 int_events);
+	void (*ev_error)(struct net_device *dev, u32 int_events);
+	int (*get_regs)(struct net_device *dev, void *p, int *sizep);
+	int (*get_regs_len)(struct net_device *dev);
+	void (*tx_restart)(struct net_device *dev);
+};
+
+#define MII_ADVERTISE_HALF	(ADVERTISE_100HALF | \
+				 ADVERTISE_10HALF | ADVERTISE_CSMA)
+#define MII_ADVERTISE_ALL	(ADVERTISE_100FULL | \
+				 ADVERTISE_10FULL | MII_ADVERTISE_HALF)
+
+/* values for MII phy_status */
+
+#define PHY_CONF_ANE	0x0001	/* 1 auto-negotiation enabled     */
+#define PHY_CONF_LOOP	0x0002	/* 1 loopback mode enabled        */
+#define PHY_CONF_SPMASK	0x00f0	/* mask for speed                 */
+#define PHY_CONF_10HDX	0x0010	/* 10 Mbit half duplex supported  */
+#define PHY_CONF_10FDX	0x0020	/* 10 Mbit full duplex supported  */
+#define PHY_CONF_100HDX	0x0040	/* 100 Mbit half duplex supported */
+#define PHY_CONF_100FDX	0x0080	/* 100 Mbit full duplex supported */
+
+#define PHY_STAT_LINK	0x0100	/* 1 up - 0 down                  */
+#define PHY_STAT_FAULT	0x0200	/* 1 remote fault                 */
+#define PHY_STAT_ANC	0x0400	/* 1 auto-negotiation complete    */
+#define PHY_STAT_SPMASK	0xf000	/* mask for speed                 */
+#define PHY_STAT_10HDX	0x1000	/* 10 Mbit half duplex selected   */
+#define PHY_STAT_10FDX	0x2000	/* 10 Mbit full duplex selected   */
+#define PHY_STAT_100HDX	0x4000	/* 100 Mbit half duplex selected  */
+#define PHY_STAT_100FDX	0x8000	/* 100 Mbit full duplex selected  */
+
+struct phy_info {
+	unsigned int id;
+	const char *name;
+	void (*startup) (struct net_device * dev);
+	void (*shutdown) (struct net_device * dev);
+	void (*ack_int) (struct net_device * dev);
+};
+
+/* The FEC stores dest/src/type, data, and checksum for receive packets.
+ */
+#define MAX_MTU 1508		/* Allow fullsized pppoe packets over VLAN */
+#define MIN_MTU 46		/* this is data size */
+#define CRC_LEN 4
+
+#define PKT_MAXBUF_SIZE		(MAX_MTU+ETH_HLEN+CRC_LEN)
+#define PKT_MINBUF_SIZE		(MIN_MTU+ETH_HLEN+CRC_LEN)
+
+/* Must be a multiple of 32 (to cover both FEC & FCC) */
+#define PKT_MAXBLR_SIZE		((PKT_MAXBUF_SIZE + 31) & ~31)
+/* This is needed so that invalidate_xxx wont invalidate too much */
+#define ENET_RX_FRSIZE		L1_CACHE_ALIGN(PKT_MAXBUF_SIZE)
+
+struct fs_enet_mii_bus {
+	struct list_head list;
+	spinlock_t mii_lock;
+	const struct fs_mii_bus_info *bus_info;
+	int refs;
+	u32 usage_map;
+
+	int (*mii_read)(struct fs_enet_mii_bus *bus,
+			int phy_id, int location);
+
+	void (*mii_write)(struct fs_enet_mii_bus *bus,
+			int phy_id, int location, int value);
+
+	union {
+		struct {
+			unsigned int mii_speed;
+			void *fecp;
+		} fec;
+
+		struct {
+			/* note that the actual port size may */
+			/* be different; cpm(s) handle it OK  */
+			u8 mdio_msk;
+			u8 *mdio_dir;
+			u8 *mdio_dat;
+			u8 mdc_msk;
+			u8 *mdc_dir;
+			u8 *mdc_dat;
+		} bitbang;
+
+		struct {
+			u16 lpa;
+		} fixed;
+	};
+};
+
+int fs_mii_bitbang_init(struct fs_enet_mii_bus *bus);
+int fs_mii_fixed_init(struct fs_enet_mii_bus *bus);
+int fs_mii_fec_init(struct fs_enet_mii_bus *bus);
+
+struct fs_enet_private {
+	struct device *dev;	/* pointer back to the device (must be initialized first) */
+	spinlock_t lock;	/* during all ops except TX pckt processing */
+	spinlock_t tx_lock;	/* during fs_start_xmit and fs_tx         */
+	const struct fs_platform_info *fpi;
+	const struct fs_ops *ops;
+	int rx_ring, tx_ring;
+	dma_addr_t ring_mem_addr;
+	void *ring_base;
+	struct sk_buff **rx_skbuff;
+	struct sk_buff **tx_skbuff;
+	cbd_t *rx_bd_base;	/* Address of Rx and Tx buffers.    */
+	cbd_t *tx_bd_base;
+	cbd_t *dirty_tx;	/* ring entries to be free()ed.     */
+	cbd_t *cur_rx;
+	cbd_t *cur_tx;
+	int tx_free;
+	struct net_device_stats stats;
+	struct timer_list phy_timer_list;
+	const struct phy_info *phy;
+	u32 msg_enable;
+	struct mii_if_info mii_if;
+	unsigned int last_mii_status;
+	struct fs_enet_mii_bus *mii_bus;
+	int interrupt;
+
+	int duplex, speed;	/* current settings */
+
+	/* event masks */
+	u32 ev_napi_rx;		/* mask of NAPI rx events */
+	u32 ev_rx;		/* rx event mask          */
+	u32 ev_tx;		/* tx event mask          */
+	u32 ev_err;		/* error event mask       */
+
+	u16 bd_rx_empty;	/* mask of BD rx empty	  */
+	u16 bd_rx_err;		/* mask of BD rx errors   */
+
+	union {
+		struct {
+			int idx;		/* FEC1 = 0, FEC2 = 1  */
+			void *fecp;		/* hw registers        */
+			u32 hthi, htlo;		/* state for multicast */
+		} fec;
+
+		struct {
+			int idx;		/* FCC1-3 = 0-2	       */
+			void *fccp;		/* hw registers	       */
+			void *ep;		/* parameter ram       */
+			void *fcccp;		/* hw registers cont.  */
+			void *mem;		/* FCC DPRAM */
+			u32 gaddrh, gaddrl;	/* group address       */
+		} fcc;
+
+		struct {
+			int idx;		/* FEC1 = 0, FEC2 = 1  */
+			void *sccp;		/* hw registers        */
+			void *ep;		/* parameter ram       */
+			u32 hthi, htlo;		/* state for multicast */
+		} scc;
+
+	};
+};
+
+/***************************************************************************/
+
+int fs_mii_read(struct net_device *dev, int phy_id, int location);
+void fs_mii_write(struct net_device *dev, int phy_id, int location, int value);
+
+void fs_mii_startup(struct net_device *dev);
+void fs_mii_shutdown(struct net_device *dev);
+void fs_mii_ack_int(struct net_device *dev);
+
+void fs_mii_link_status_change_check(struct net_device *dev, int init_media);
+
+void fs_init_bds(struct net_device *dev);
+void fs_cleanup_bds(struct net_device *dev);
+
+/***************************************************************************/
+
+#define DRV_MODULE_NAME		"fs_enet"
+#define PFX DRV_MODULE_NAME	": "
+#define DRV_MODULE_VERSION	"1.0"
+#define DRV_MODULE_RELDATE	"Aug 8, 2005"
+
+/***************************************************************************/
+
+int fs_enet_platform_init(void);
+void fs_enet_platform_cleanup(void);
+
+/***************************************************************************/
+
+/* buffer descriptor access macros */
+
+/* access macros */
+#if defined(CONFIG_CPM1)
+/* for a a CPM1 __raw_xxx's are sufficient */
+#define __cbd_out32(addr, x)	__raw_writel(x, addr)
+#define __cbd_out16(addr, x)	__raw_writew(x, addr)
+#define __cbd_in32(addr)	__raw_readl(addr)
+#define __cbd_in16(addr)	__raw_readw(addr)
+#else
+/* for others play it safe */
+#define __cbd_out32(addr, x)	out_be32(addr, x)
+#define __cbd_out16(addr, x)	out_be16(addr, x)
+#define __cbd_in32(addr)	in_be32(addr)
+#define __cbd_in16(addr)	in_be16(addr)
+#endif
+
+/* write */
+#define CBDW_SC(_cbd, _sc) 		__cbd_out16(&(_cbd)->cbd_sc, (_sc))
+#define CBDW_DATLEN(_cbd, _datlen)	__cbd_out16(&(_cbd)->cbd_datlen, (_datlen))
+#define CBDW_BUFADDR(_cbd, _bufaddr)	__cbd_out32(&(_cbd)->cbd_bufaddr, (_bufaddr))
+
+/* read */
+#define CBDR_SC(_cbd) 			__cbd_in16(&(_cbd)->cbd_sc)
+#define CBDR_DATLEN(_cbd)		__cbd_in16(&(_cbd)->cbd_datlen)
+#define CBDR_BUFADDR(_cbd)		__cbd_in32(&(_cbd)->cbd_bufaddr)
+
+/* set bits */
+#define CBDS_SC(_cbd, _sc) 		CBDW_SC(_cbd, CBDR_SC(_cbd) | (_sc))
+
+/* clear bits */
+#define CBDC_SC(_cbd, _sc) 		CBDW_SC(_cbd, CBDR_SC(_cbd) & ~(_sc))
+
+/*******************************************************************/
+
+extern const struct fs_ops fs_fec_ops;
+extern const struct fs_ops fs_fcc_ops;
+extern const struct fs_ops fs_scc_ops;
+
+/*******************************************************************/
+
+/* handy pointer to the immap */
+extern void *fs_enet_immap;
+
+/*******************************************************************/
+
+#endif

--Boundary-00=_MXiCDp6CxRz0zaY--
