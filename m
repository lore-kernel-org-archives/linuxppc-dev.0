To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_4_devel patch: 8xx FEC extensions
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_12791348070"
Date: Fri, 20 Dec 2002 02:05:07 +0100
Message-Id: <20021220010507.E88B6C613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_12791348070
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit


Hi,

this is a patch against linuxppc_2_4_devel BK Changeset 1.1197
(trini@kernel.crashing.org|ChangeSet|20021219180614|11718)

It makes the following modifications to the MPC8xx FEC driver:

- change PHY configuration from #define to kernel config mechanism
- add support for AMD79C874 PHY
- add multicast support
- add PACKETHOOK support


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Remember, Information is not knowledge;  Knowledge  is  not  Wisdom;
Wisdom is not truth; Truth is not beauty; Beauty is not love; Love is
not music; Music is the best."                          - Frank Zappa


--==_Exmh_12791348070
Content-Type: application/x-patch ; name="8xx-fec.patch"
Content-Description: 8xx-fec.patch
Content-Disposition: attachment; filename="8xx-fec.patch"

--- /work/bk_2_4_devel-1.1197/arch/ppc/8xx_io/Config.in	2002-12-20 01:33:01.000000000 +0100
+++ linuxppc_2_4_devel/arch/ppc/8xx_io/Config.in	2002-12-14 13:06:09.000000000 +0100
@@ -11,10 +11,22 @@
   	"SCC1	CONFIG_SCC1_ENET	\
 	 SCC2	CONFIG_SCC2_ENET	\
 	 SCC3	CONFIG_SCC3_ENET"	SCC1
+  else
+    define_bool CONFIG_SCC1_ENET n
+    define_bool CONFIG_SCC2_ENET n
+    define_bool CONFIG_SCC3_ENET n
   fi
   bool '860T FEC Ethernet' CONFIG_FEC_ENET
   if [ "$CONFIG_FEC_ENET" = "y" ]; then
     bool 'Use MDIO for PHY configuration' CONFIG_USE_MDIO
+    if [ "$CONFIG_USE_MDIO" = "y" ]; then
+      bool 'Support AMD79C874 PHY' CONFIG_FEC_AM79C874
+      bool 'Support LXT970    PHY' CONFIG_FEC_LXT970
+      bool 'Support LXT971    PHY' CONFIG_FEC_LXT971
+      bool 'Support QS6612    PHY' CONFIG_FEC_QS6612
+      bool 'Support DP83843   PHY' CONFIG_FEC_DP83843
+      bool 'Support DP83846A  PHY' CONFIG_FEC_DP83846A
+    fi
   fi
   bool 'Use Big CPM Ethernet Buffers' CONFIG_ENET_BIG_BUFFERS
 fi
--- /work/bk_2_4_devel-1.1197/arch/ppc/8xx_io/fec.c	2002-12-20 01:33:14.000000000 +0100
+++ linuxppc_2_4_devel/arch/ppc/8xx_io/fec.c	2002-12-14 13:06:09.000000000 +0100
@@ -25,17 +25,16 @@
  *
  * Make use of MII for PHY control configurable.
  * Some fixes.
- * Copyright (c) 2000 Wolfgang Denk, DENX Software Engineering.
+ * Copyright (c) 2000-2002 Wolfgang Denk, DENX Software Engineering.
+ *
+ * Fixes for tx_full condition and relink when using MII.
+ * Support for AMD AM79C874 added.
+ * Thomas Lange, thomas@corelatus.com
+ *
+ * Added code for Multicast support, Frederic Goddeeris, Paul Geerinckx
+ * Copyright (c) 2002 Siemens Atea
  */

-/* List of PHYs we wish to support.
-*/
-#undef	CONFIG_FEC_LXT970
-#define	CONFIG_FEC_LXT971
-#undef	CONFIG_FEC_QS6612
-#undef	CONFIG_FEC_DP83843
-#undef	CONFIG_FEC_DP83846A
-
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -54,6 +53,9 @@
 #include <linux/spinlock.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#ifdef CONFIG_FEC_PACKETHOOK
+#include <linux/pkthook.h>
+#endif

 #include <asm/8xx_immap.h>
 #include <asm/pgtable.h>
@@ -63,6 +65,14 @@
 #include <asm/uaccess.h>
 #include <asm/commproc.h>

+/* multicast support
+ */
+/* #define DEBUG_MULTICAST */
+
+/* CRC polynomium used by the FEC for the multicast group filtering
+ */
+#define FEC_CRC_POLY   0x04C11DB7
+
 #ifdef	CONFIG_USE_MDIO
 /* Forward declarations of some structures to support different PHYs
 */
@@ -193,6 +203,15 @@
 	int	link;
 	int	old_link;
 	int	full_duplex;
+
+#ifdef CONFIG_FEC_PACKETHOOK
+	unsigned long	ph_lock;
+	fec_ph_func	*ph_rxhandler;
+	fec_ph_func	*ph_txhandler;
+	__u16		ph_proto;
+	volatile __u32	*ph_regaddr;
+	void		*ph_priv;
+#endif
 };

 static int fec_enet_open(struct net_device *dev);
@@ -201,8 +220,13 @@
 static void fec_enet_mii(struct net_device *dev);
 #endif	/* CONFIG_USE_MDIO */
 static void fec_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs);
+#ifndef CONFIG_FEC_PACKETHOOK
 static void  fec_enet_tx(struct net_device *dev);
 static void  fec_enet_rx(struct net_device *dev);
+#else
+static void  fec_enet_tx(struct net_device *dev, __u32 regval);
+static void  fec_enet_rx(struct net_device *dev, __u32 regval);
+#endif
 static int fec_enet_close(struct net_device *dev);
 static struct net_device_stats *fec_enet_get_stats(struct net_device *dev);
 static void set_multicast_list(struct net_device *dev);
@@ -293,6 +317,65 @@
 #define PHY_STAT_100FDX	0x8000  /* 100 Mbit full duplex selected */
 #endif	/* CONFIG_USE_MDIO */

+#ifdef CONFIG_FEC_PACKETHOOK
+int
+fec_register_ph(struct net_device *dev, fec_ph_func *rxfun, fec_ph_func *txfun,
+		__u16 proto, volatile __u32 *regaddr, void *priv)
+{
+	struct fec_enet_private *fep;
+	int retval = 0;
+
+	fep = dev->priv;
+
+	if (test_and_set_bit(0, (void*)&fep->ph_lock) != 0) {
+		/* Someone is messing with the packet hook */
+		return -EAGAIN;
+	}
+	if (fep->ph_rxhandler != NULL || fep->ph_txhandler != NULL) {
+		retval = -EBUSY;
+		goto out;
+	}
+	fep->ph_rxhandler = rxfun;
+	fep->ph_txhandler = txfun;
+	fep->ph_proto = proto;
+	fep->ph_regaddr = regaddr;
+	fep->ph_priv = priv;
+
+out:
+	fep->ph_lock = 0;
+
+	return retval;
+}
+
+
+int
+fec_unregister_ph(struct net_device *dev)
+{
+	struct fec_enet_private *fep;
+	int retval = 0;
+
+	fep = dev->priv;
+
+	if (test_and_set_bit(0, (void*)&fep->ph_lock) != 0) {
+		/* Someone is messing with the packet hook */
+		return -EAGAIN;
+	}
+
+	fep->ph_rxhandler = fep->ph_txhandler = NULL;
+	fep->ph_proto = 0;
+	fep->ph_regaddr = NULL;
+	fep->ph_priv = NULL;
+
+	fep->ph_lock = 0;
+
+	return retval;
+}
+
+EXPORT_SYMBOL(fec_register_ph);
+EXPORT_SYMBOL(fec_unregister_ph);
+
+#endif /* CONFIG_FEC_PACKETHOOK */
+
 static int
 fec_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
@@ -382,43 +465,50 @@
 {
 	struct fec_enet_private *fep = dev->priv;

-	printk("%s: transmit timed out.\n", dev->name);
+	if (fep->link || fep->old_link) {
+		/* Link status changed - print timeout message */
+		printk("%s: transmit timed out.\n", dev->name);
+	}
+
 	fep->stats.tx_errors++;
 #ifndef final_version
-	{
-	int	i;
-	cbd_t	*bdp;
+	if (fep->link) {
+		int	i;
+		cbd_t	*bdp;

-	printk("Ring data dump: cur_tx %lx%s, dirty_tx %lx cur_rx: %lx\n",
-	       (unsigned long)fep->cur_tx, fep->tx_full ? " (full)" : "",
-	       (unsigned long)fep->dirty_tx,
-	       (unsigned long)fep->cur_rx);
+		printk ("Ring data dump: "
+			"cur_tx %p%s dirty_tx %p cur_rx %p\n",
+		       fep->cur_tx,
+		       fep->tx_full ? " (full)" : "",
+		       fep->dirty_tx,
+		       fep->cur_rx);

-	bdp = fep->tx_bd_base;
-	printk(" tx: %u buffers\n",  TX_RING_SIZE);
-	for (i = 0 ; i < TX_RING_SIZE; i++) {
-		printk("  %08x: %04x %04x %08x\n",
-		       (uint) bdp,
-		       bdp->cbd_sc,
-		       bdp->cbd_datlen,
-		       bdp->cbd_bufaddr);
-		bdp++;
-	}
+		bdp = fep->tx_bd_base;
+		printk(" tx: %u buffers\n",  TX_RING_SIZE);
+		for (i = 0 ; i < TX_RING_SIZE; i++) {
+			printk("  %08x: %04x %04x %08x\n",
+			       (uint) bdp,
+			       bdp->cbd_sc,
+			       bdp->cbd_datlen,
+			       bdp->cbd_bufaddr);
+			bdp++;
+		}

-	bdp = fep->rx_bd_base;
-	printk(" rx: %lu buffers\n",  RX_RING_SIZE);
-	for (i = 0 ; i < RX_RING_SIZE; i++) {
-		printk("  %08x: %04x %04x %08x\n",
-		       (uint) bdp,
-		       bdp->cbd_sc,
-		       bdp->cbd_datlen,
-		       bdp->cbd_bufaddr);
-		bdp++;
-	}
+		bdp = fep->rx_bd_base;
+		printk(" rx: %lu buffers\n",  RX_RING_SIZE);
+		for (i = 0 ; i < RX_RING_SIZE; i++) {
+			printk("  %08x: %04x %04x %08x\n",
+			       (uint) bdp,
+			       bdp->cbd_sc,
+			       bdp->cbd_datlen,
+			       bdp->cbd_bufaddr);
+			bdp++;
+		}
 	}
 #endif
-	if (!fep->tx_full)
+	if (!fep->tx_full) {
 		netif_wake_queue(dev);
+	}
 }

 /* The interrupt handler.
@@ -430,6 +520,12 @@
 	struct	net_device *dev = dev_id;
 	volatile fec_t	*fecp;
 	uint	int_events;
+#ifdef CONFIG_FEC_PACKETHOOK
+	struct	fec_enet_private *fep = dev->priv;
+	__u32 regval;
+
+	if (fep->ph_regaddr) regval = *fep->ph_regaddr;
+#endif
 	fecp = (volatile fec_t*)dev->base_addr;

 	/* Get the interrupt events that caused us to be here.
@@ -443,21 +539,32 @@

 		/* Handle receive event in its own function.
 		 */
-		if (int_events & FEC_ENET_RXF)
+		if (int_events & FEC_ENET_RXF) {
+#ifdef CONFIG_FEC_PACKETHOOK
+			fec_enet_rx(dev, regval);
+#else
 			fec_enet_rx(dev);
+#endif
+		}

 		/* Transmit OK, or non-fatal error. Update the buffer
 		   descriptors. FEC handles all errors, we just discover
 		   them as part of the transmit process.
 		*/
-		if (int_events & FEC_ENET_TXF)
+		if (int_events & FEC_ENET_TXF) {
+#ifdef CONFIG_FEC_PACKETHOOK
+			fec_enet_tx(dev, regval);
+#else
 			fec_enet_tx(dev);
+#endif
+		}

 		if (int_events & FEC_ENET_MII) {
 #ifdef	CONFIG_USE_MDIO
 			fec_enet_mii(dev);
 #else
-printk("%s[%d] %s: unexpected FEC_ENET_MII event\n", __FILE__,__LINE__,__FUNCTION__);
+		printk("%s[%d] %s: unexpected FEC_ENET_MII event\n",
+			__FILE__,__LINE__,__FUNCTION__);
 #endif	/* CONFIG_USE_MDIO */
 		}

@@ -466,7 +573,11 @@


 static void
+#ifdef CONFIG_FEC_PACKETHOOK
+fec_enet_tx(struct net_device *dev, __u32 regval)
+#else
 fec_enet_tx(struct net_device *dev)
+#endif
 {
 	struct	fec_enet_private *fep;
 	volatile cbd_t	*bdp;
@@ -495,8 +606,18 @@
 				fep->stats.tx_fifo_errors++;
 			if (bdp->cbd_sc & BD_ENET_TX_CSL) /* Carrier lost */
 				fep->stats.tx_carrier_errors++;
-		} else
+		} else {
+#ifdef CONFIG_FEC_PACKETHOOK
+			/* Packet hook ... */
+			if (fep->ph_txhandler &&
+			    ((struct ethhdr *)skb->data)->h_proto
+			    == fep->ph_proto) {
+				fep->ph_txhandler((__u8*)skb->data, skb->len,
+						regval, fep->ph_priv);
+			}
+#endif
 			fep->stats.tx_packets++;
+		}

 #ifndef final_version
 		if (bdp->cbd_sc & BD_ENET_TX_READY)
@@ -511,7 +632,7 @@
 		/* Free the sk buffer associated with this last transmit.
 		 */
 #if 0
-printk("TXI: %x %x %x\n", bdp, skb, fep->skb_dirty);
+		printk("TXI: %x %x %x\n", bdp, skb, fep->skb_dirty);
 #endif
 		dev_kfree_skb_irq (skb/*, FREE_WRITE*/);
 		fep->tx_skbuff[fep->skb_dirty] = NULL;
@@ -532,6 +653,11 @@
 			if (netif_queue_stopped(dev))
 				netif_wake_queue(dev);
 		}
+#ifdef CONFIG_FEC_PACKETHOOK
+		/* Re-read register. Not exactly guaranteed to be correct,
+		   but... */
+		if (fep->ph_regaddr) regval = *fep->ph_regaddr;
+#endif
 	}
 	fep->dirty_tx = (cbd_t *)bdp;
 	spin_unlock(&fep->lock);
@@ -544,7 +670,11 @@
  * effectively tossing the packet.
  */
 static void
+#ifdef CONFIG_FEC_PACKETHOOK
+fec_enet_rx(struct net_device *dev, __u32 regval)
+#else
 fec_enet_rx(struct net_device *dev)
+#endif
 {
 	struct	fec_enet_private *fep;
 	volatile fec_t	*fecp;
@@ -604,6 +734,27 @@
 	fep->stats.rx_bytes += pkt_len;
 	data = fep->rx_vaddr[bdp - fep->rx_bd_base];

+#ifdef CONFIG_FEC_PACKETHOOK
+	/* Packet hook ... */
+	if (fep->ph_rxhandler) {
+		if (((struct ethhdr *)data)->h_proto == fep->ph_proto) {
+			switch (fep->ph_rxhandler(data, pkt_len, regval,
+						  fep->ph_priv)) {
+			case 1:
+				goto rx_processing_done;
+				break;
+			case 0:
+				break;
+			default:
+				fep->stats.rx_errors++;
+				goto rx_processing_done;
+			}
+		}
+	}
+
+	/* If it wasn't filtered - copy it to an sk buffer. */
+#endif
+
 	/* This does 16 byte alignment, exactly what we need.
 	 * The packet length includes FCS, but we don't want to
 	 * include that when passing upstream as it messes up
@@ -619,9 +770,20 @@
 		skb_put(skb,pkt_len-4);	/* Make room */
 		eth_copy_and_sum(skb, data, pkt_len-4, 0);
 		skb->protocol=eth_type_trans(skb,dev);
+#ifdef DEBUG_MULTICAST
+		if (bdp->cbd_sc & BD_ENET_RX_MC) {
+			printk ("%s: Received Multicast packet DA: "
+				"%2x:%2x:%2x:%2x:%2x:%2x\n",
+				dev->name,
+				(int)data[0], (int)data[1],
+				(int)data[2], (int)data[3],
+				(int)data[4], (int)data[5]
+			);
+		}
+#endif
 		netif_rx(skb);
 	}
-  rx_processing_done:
+rx_processing_done:

 	/* Clear the status flags for this buffer.
 	*/
@@ -645,6 +807,11 @@
 	 */
 	fecp->fec_r_des_active = 0x01000000;
 #endif
+#ifdef CONFIG_FEC_PACKETHOOK
+	/* Re-read register. Not exactly guaranteed to be correct,
+	   but... */
+	if (fep->ph_regaddr) regval = *fep->ph_regaddr;
+#endif
    } /* while (!(bdp->cbd_sc & BD_ENET_RX_EMPTY)) */
 	fep->cur_rx = (cbd_t *)bdp;

@@ -744,52 +911,57 @@

 static void mii_parse_sr(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

-	*s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);
+	s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);

 	if (mii_reg & 0x0004)
-		*s |= PHY_STAT_LINK;
+		s |= PHY_STAT_LINK;
 	if (mii_reg & 0x0010)
-		*s |= PHY_STAT_FAULT;
+		s |= PHY_STAT_FAULT;
 	if (mii_reg & 0x0020)
-		*s |= PHY_STAT_ANC;
+		s |= PHY_STAT_ANC;

-	fep->link = (*s & PHY_STAT_LINK) ? 1 : 0;
+	fep->phy_status = s;
+	fep->link = (s & PHY_STAT_LINK) ? 1 : 0;
 }

 static void mii_parse_cr(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

-	*s &= ~(PHY_CONF_ANE | PHY_CONF_LOOP);
+	s &= ~(PHY_CONF_ANE | PHY_CONF_LOOP);

 	if (mii_reg & 0x1000)
-		*s |= PHY_CONF_ANE;
+		s |= PHY_CONF_ANE;
 	if (mii_reg & 0x4000)
-		*s |= PHY_CONF_LOOP;
+		s |= PHY_CONF_LOOP;
+
+	fep->phy_status = s;
 }

 static void mii_parse_anar(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

-	*s &= ~(PHY_CONF_SPMASK);
+	s &= ~(PHY_CONF_SPMASK);

 	if (mii_reg & 0x0020)
-		*s |= PHY_CONF_10HDX;
+		s |= PHY_CONF_10HDX;
 	if (mii_reg & 0x0040)
-		*s |= PHY_CONF_10FDX;
+		s |= PHY_CONF_10FDX;
 	if (mii_reg & 0x0080)
-		*s |= PHY_CONF_100HDX;
-	if (mii_reg & 0x00100)
-		*s |= PHY_CONF_100FDX;
+		s |= PHY_CONF_100HDX;
+	if (mii_reg & 0x0100)
+		s |= PHY_CONF_100FDX;
+
+	fep->phy_status = s;
 }
 #if 0
-static void mii_disp_reg(uint mii_reg, struct net_device *dev)
+static void mii_disp_reg(uint mii_reg, struct net_device *dev, uint data)
 {
 	printk("reg %u = 0x%04x\n", (mii_reg >> 18) & 0x1f, mii_reg & 0xffff);
 }
@@ -808,23 +980,25 @@

 static void mii_parse_lxt970_csr(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

-	*s &= ~(PHY_STAT_SPMASK);
+	s &= ~(PHY_STAT_SPMASK);

 	if (mii_reg & 0x0800) {
 		if (mii_reg & 0x1000)
-			*s |= PHY_STAT_100FDX;
+			s |= PHY_STAT_100FDX;
 		else
-			*s |= PHY_STAT_100HDX;
+			s |= PHY_STAT_100HDX;
 	}
 	else {
 		if (mii_reg & 0x1000)
-			*s |= PHY_STAT_10FDX;
+			s |= PHY_STAT_10FDX;
 		else
-			*s |= PHY_STAT_10HDX;
+			s |= PHY_STAT_10HDX;
 	}
+
+	fep->phy_status = s;
 }

 static phy_info_t phy_info_lxt970 = {
@@ -890,25 +1064,27 @@

 static void mii_parse_lxt971_sr2(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

-	*s &= ~(PHY_STAT_SPMASK);
+	s &= ~(PHY_STAT_SPMASK);

 	if (mii_reg & 0x4000) {
 		if (mii_reg & 0x0200)
-			*s |= PHY_STAT_100FDX;
+			s |= PHY_STAT_100FDX;
 		else
-			*s |= PHY_STAT_100HDX;
+			s |= PHY_STAT_100HDX;
 	}
 	else {
 		if (mii_reg & 0x0200)
-			*s |= PHY_STAT_10FDX;
+			s |= PHY_STAT_10FDX;
 		else
-			*s |= PHY_STAT_10HDX;
+			s |= PHY_STAT_10HDX;
 	}
 	if (mii_reg & 0x0008)
-		*s |= PHY_STAT_FAULT;
+		s |= PHY_STAT_FAULT;
+
+	fep->phy_status = s;
 }

 static phy_info_t phy_info_lxt971 = {
@@ -949,7 +1125,7 @@
 	},
 };

-#endif /* CONFIG_FEC_LXT970 */
+#endif /* CONFIG_FEC_LXT971 */


 /* ------------------------------------------------------------------------- */
@@ -968,17 +1144,19 @@

 static void mii_parse_qs6612_pcr(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

-	*s &= ~(PHY_STAT_SPMASK);
+	s &= ~(PHY_STAT_SPMASK);

 	switch((mii_reg >> 2) & 7) {
-	case 1: *s |= PHY_STAT_10HDX; break;
-	case 2: *s |= PHY_STAT_100HDX; break;
-	case 5: *s |= PHY_STAT_10FDX; break;
-	case 6: *s |= PHY_STAT_100FDX; break;
+	case 1: s |= PHY_STAT_10HDX;  break;
+	case 2: s |= PHY_STAT_100HDX; break;
+	case 5: s |= PHY_STAT_10FDX;  break;
+	case 6: s |= PHY_STAT_100FDX; break;
 	}
+
+	fep->phy_status = s;
 }

 static phy_info_t phy_info_qs6612 = {
@@ -1024,9 +1202,74 @@
 	},
 };

-
 #endif /* CONFIG_FEC_QS6612 */

+/* ------------------------------------------------------------------------- */
+/* The Advanced Micro Devices AM79C874 is used on the ICU862		     */
+
+#ifdef CONFIG_FEC_AM79C874
+
+/* register definitions for the 79C874 */
+
+#define MII_AM79C874_MFR	16  /* Miscellaneous Features Register      */
+#define MII_AM79C874_ICSR	17  /* Interrupt Control/Status Register    */
+#define MII_AM79C874_DR		18  /* Diagnostic Register		    */
+#define MII_AM79C874_PMLR	19  /* Power Management & Loopback Register */
+#define MII_AM79C874_MCR	21  /* Mode Control Register		    */
+#define MII_AM79C874_DC		23  /* Disconnect Counter		    */
+#define MII_AM79C874_REC	24  /* Receiver Error Counter		    */
+
+static void mii_parse_amd79c874_dr(uint mii_reg, struct net_device *dev, uint data)
+{
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;
+
+	s &= ~(PHY_STAT_SPMASK);
+
+	/* Register 18: Bit 10 is data rate, 11 is Duplex */
+	switch ((mii_reg >> 10) & 3) {
+	case 0:	s |= PHY_STAT_10HDX;	break;
+	case 1:	s |= PHY_STAT_100HDX;	break;
+	case 2:	s |= PHY_STAT_10FDX;	break;
+	case 3:	s |= PHY_STAT_100FDX;	break;
+	}
+
+	fep->phy_status = s;
+}
+
+static phy_info_t phy_info_amd79c874 = {
+	0x00022561,
+	"AM79C874",
+
+	(const phy_cmd_t []) {  /* config */
+//		{ mk_mii_write(MII_REG_ANAR, 0x021), NULL }, /* 10  Mbps, HD */
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {  /* startup - enable interrupts */
+		{ mk_mii_write(MII_AM79C874_ICSR, 0xff00), NULL },
+		{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) { /* ack_int */
+		/* find out the current status */
+
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
+		{ mk_mii_read(MII_AM79C874_DR), mii_parse_amd79c874_dr },
+
+		/* we only need to read ICSR to acknowledge */
+
+		{ mk_mii_read(MII_AM79C874_ICSR), NULL },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {  /* shutdown - disable interrupts */
+		{ mk_mii_write(MII_AM79C874_ICSR, 0x0000), NULL },
+		{ mk_mii_end, }
+	},
+};
+
+#endif /* CONFIG_FEC_AM79C874 */

 /* -------------------------------------------------------------------- */
 /* The National Semiconductor DP83843BVJE is used on a Mediatrix board  */
@@ -1041,32 +1284,34 @@

 static void mii_parse_dp83843_physts(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

-	*s &= ~(PHY_STAT_SPMASK);
+	s &= ~(PHY_STAT_SPMASK);

 	if (mii_reg & 0x0002)
 	{
 		if (mii_reg & 0x0004)
-			*s |= PHY_STAT_10FDX;
+			s |= PHY_STAT_10FDX;
 		else
-			*s |= PHY_STAT_10HDX;
+			s |= PHY_STAT_10HDX;
 	}
 	else
 	{
 		if (mii_reg & 0x0004)
-			*s |= PHY_STAT_100FDX;
+			s |= PHY_STAT_100FDX;
 		else
-			*s |= PHY_STAT_100HDX;
+			s |= PHY_STAT_100HDX;
 	}
+
+	fep->phy_status = s;
 }

 static phy_info_t phy_info_dp83843 = {
 	0x020005c1,
 	"DP83843BVJE",

-	(const phy_cmd_t []) {  /* config */
+	(const phy_cmd_t []) {  /* config */
 		{ mk_mii_write(MII_REG_ANAR, 0x01E1), NULL  }, /* Auto-Negociation Register Control set to    */
 		                                               /* auto-negociate 10/100MBps, Half/Full duplex */
 		{ mk_mii_read(MII_REG_CR),   mii_parse_cr   },
@@ -1107,29 +1352,31 @@

 static void mii_parse_dp83846a_physts(uint mii_reg, struct net_device *dev, uint data)
 {
-	struct fec_enet_private *fep = (struct fec_enet_private *)dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = (struct fec_enet_private *)dev->priv;
+	uint s = fep->phy_status;
 	int link_change_mask;

-	*s &= ~(PHY_STAT_SPMASK);
+	s &= ~(PHY_STAT_SPMASK);

 	if (mii_reg & 0x0002) {
 		if (mii_reg & 0x0004)
-			*s |= PHY_STAT_10FDX;
+			s |= PHY_STAT_10FDX;
 		else
-			*s |= PHY_STAT_10HDX;
+			s |= PHY_STAT_10HDX;
 	}
 	else {
 		if (mii_reg & 0x0004)
-			*s |= PHY_STAT_100FDX;
+			s |= PHY_STAT_100FDX;
 		else
-			*s |= PHY_STAT_100HDX;
+			s |= PHY_STAT_100HDX;
 	}

+	fep->phy_status = s;
+
 	link_change_mask = PHY_STAT_LINK | PHY_STAT_10FDX | PHY_STAT_10HDX | PHY_STAT_100FDX | PHY_STAT_100HDX;
-	if(fep->old_status != (link_change_mask & *s))
+	if(fep->old_status != (link_change_mask & s))
 	{
-		fep->old_status = (link_change_mask & *s);
+		fep->old_status = (link_change_mask & s);
 		mii_queue_relink(mii_reg, dev, 0);
 	}
 }
@@ -1138,7 +1385,7 @@
 	0x020005c2,
 	"DP83846A",

-	(const phy_cmd_t []) {  /* config */
+	(const phy_cmd_t []) {  /* config */
 		{ mk_mii_write(MII_REG_ANAR, 0x01E1), NULL  }, /* Auto-Negociation Register Control set to    */
 		                                               /* auto-negociate 10/100MBps, Half/Full duplex */
 		{ mk_mii_read(MII_REG_CR),   mii_parse_cr   },
@@ -1178,7 +1425,11 @@

 #ifdef CONFIG_FEC_QS6612
 	&phy_info_qs6612,
-#endif /* CONFIG_FEC_LXT971 */
+#endif /* CONFIG_FEC_QS6612 */
+
+#ifdef CONFIG_FEC_AM79C874
+	&phy_info_amd79c874,
+#endif /* CONFIG_FEC_AM79C874 */

 #ifdef CONFIG_FEC_DP83843
 	&phy_info_dp83843,
@@ -1193,8 +1444,8 @@

 static void mii_display_status(struct net_device *dev)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

 	if (!fep->link && !fep->old_link) {
 		/* Link is still down - don't print anything */
@@ -1208,20 +1459,20 @@
 	} else {
 		printk("link up");

-		switch(*s & PHY_STAT_SPMASK) {
+		switch(s & PHY_STAT_SPMASK) {
 		case PHY_STAT_100FDX: printk(", 100 Mbps Full Duplex"); break;
 		case PHY_STAT_100HDX: printk(", 100 Mbps Half Duplex"); break;
-		case PHY_STAT_10FDX: printk(", 10 Mbps Full Duplex"); break;
-		case PHY_STAT_10HDX: printk(", 10 Mbps Half Duplex"); break;
+		case PHY_STAT_10FDX:  printk(", 10 Mbps Full Duplex");  break;
+		case PHY_STAT_10HDX:  printk(", 10 Mbps Half Duplex");  break;
 		default:
 			printk(", Unknown speed/duplex");
 		}

-		if (*s & PHY_STAT_ANC)
+		if (s & PHY_STAT_ANC)
 			printk(", auto-negotiation complete");
 	}

-	if (*s & PHY_STAT_FAULT)
+	if (s & PHY_STAT_FAULT)
 		printk(", remote fault");

 	printk(".\n");
@@ -1229,28 +1480,28 @@

 static void mii_display_config(struct net_device *dev)
 {
-	struct fec_enet_private *fep = dev->priv;
-	volatile uint *s = &(fep->phy_status);
+	volatile struct fec_enet_private *fep = dev->priv;
+	uint s = fep->phy_status;

 	printk("%s: config: auto-negotiation ", dev->name);

-	if (*s & PHY_CONF_ANE)
+	if (s & PHY_CONF_ANE)
 		printk("on");
 	else
 		printk("off");

-	if (*s & PHY_CONF_100FDX)
+	if (s & PHY_CONF_100FDX)
 		printk(", 100FDX");
-	if (*s & PHY_CONF_100HDX)
+	if (s & PHY_CONF_100HDX)
 		printk(", 100HDX");
-	if (*s & PHY_CONF_10FDX)
+	if (s & PHY_CONF_10FDX)
 		printk(", 10FDX");
-	if (*s & PHY_CONF_10HDX)
+	if (s & PHY_CONF_10HDX)
 		printk(", 10HDX");
-	if (!(*s & PHY_CONF_SPMASK))
+	if (!(s & PHY_CONF_SPMASK))
 		printk(", No speed/duplex selected?");

-	if (*s & PHY_CONF_LOOP)
+	if (s & PHY_CONF_LOOP)
 		printk(", loopback enabled");

 	printk(".\n");
@@ -1273,14 +1524,14 @@
 		    & (PHY_STAT_100FDX | PHY_STAT_10FDX))
 			duplex = 1;
 		fec_restart(dev, duplex);
-	}
-	else
-		fec_stop(dev);
-
-#if 0
-	enable_irq(fep->mii_irq);
-#endif

+		if (netif_queue_stopped(dev)) {
+			netif_wake_queue(dev);
+		}
+	} else {
+		netif_stop_queue(dev);
+		fec_stop(dev);
+	}
 }

 static void mii_queue_relink(uint mii_reg, struct net_device *dev, uint data)
@@ -1381,27 +1632,30 @@
 	volatile fec_t *fecp = &(immap->im_cpm.cp_fec);
 	unsigned int ecntrl = fecp->fec_ecntrl;

-	/* We need the FEC enabled to access the MII
-	*/
-	if ((ecntrl & FEC_ECNTRL_ETHER_EN) == 0) {
-		fecp->fec_ecntrl |= FEC_ECNTRL_ETHER_EN;
-	}
-#endif	/* CONFIG_USE_MDIO */
-
-#if 0
-	disable_irq(fep->mii_irq);  /* disable now, enable later */
-#endif
-
+        /*
+         * Acknowledge the interrupt if possible. If we have not
+         * found the PHY yet we can't process or acknowledge the
+         * interrupt now. Instead we ignore this interrupt for now,
+         * which we can do since it is edge triggered. It will be
+         * acknowledged later by fec_enet_open().
+	 */
+	if (fep->phy) {
+		/*
+		 * We need the FEC enabled to access the MII
+		 */
+		if ((ecntrl & FEC_ECNTRL_ETHER_EN) == 0) {
+			fecp->fec_ecntrl |= FEC_ECNTRL_ETHER_EN;
+		}

-#ifdef	CONFIG_USE_MDIO
-	mii_do_cmd(dev, fep->phy->ack_int);
-	mii_do_cmd(dev, phy_cmd_relink);  /* restart and display status */
+		mii_do_cmd(dev, fep->phy->ack_int);
+		mii_do_cmd(dev, phy_cmd_relink);  /* restart and display status */

-	if ((ecntrl & FEC_ECNTRL_ETHER_EN) == 0) {
-		fecp->fec_ecntrl = ecntrl;	/* restore old settings */
+		if ((ecntrl & FEC_ECNTRL_ETHER_EN) == 0) {
+			fecp->fec_ecntrl = ecntrl;	/* restore old settings */
+		}
 	}
 #else
-printk("%s[%d] %s: unexpected Link interrupt\n", __FILE__,__LINE__,__FUNCTION__);
+	printk ("FEC: unexpected Link interrupt\n");
 #endif	/* CONFIG_USE_MDIO */

 }
@@ -1432,7 +1686,7 @@
 		{
 			/* Initializing timers
 			 */
-			init_timer( &fep->phy_timer_list );
+			init_timer( &fep->phy_timer_list );

 			/* Starting timer for periodic link status check
 			 * After 100 milli-seconds, mdio_timer_callback function is called.
@@ -1502,7 +1756,7 @@
 	{
 		fep->phy_timer_list.expires  = jiffies + (1 * HZ); /* Sleep for 1 sec. */
 	}
-	add_timer( &fep->phy_timer_list );
+	add_timer( &fep->phy_timer_list );
 }
 #endif /* CONFIG_FEC_DP83846A */

@@ -1550,22 +1804,22 @@
 	else
 	{
 		switch(cmd)
-		{
+		{
 		case SIOCETHTOOL:
 			return netdev_ethtool_ioctl(dev, (void*)rq->ifr_data);
 			break;

-		case SIOCGMIIPHY:			/* Get address of MII PHY in use. */
+		case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
 		case SIOCDEVPRIVATE:		/* for binary compat, remove in 2.5 */
 			data->phy_id = phy;

-		case SIOCGMIIREG:			/* Read MII PHY register.	*/
+		case SIOCGMIIREG:		/* Read MII PHY register.	*/
 		case SIOCDEVPRIVATE+1:		/* for binary compat, remove in 2.5 */
 			data->val_out = mdio_read(dev, data->phy_id & 0x1f, data->reg_num & 0x1f);
 			retval = 0;
 			break;

-		case SIOCSMIIREG:			/* Write MII PHY register.	*/
+		case SIOCSMIIREG:		/* Write MII PHY register.	*/
 		case SIOCDEVPRIVATE+2:		/* for binary compat, remove in 2.5 */
 			if (!capable(CAP_NET_ADMIN))
 			{
@@ -1581,7 +1835,7 @@
 		default:
 			retval = -EOPNOTSUPP;
 			break;
-		}
+		}
 	}
 	return retval;
 }
@@ -1602,7 +1856,7 @@
 		{
 			struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };
 			strcpy (info.driver, dev->name);
-			strcpy (info.version, "0.2");
+			strcpy (info.version, "0.3");
 			strcpy (info.bus_info, "");
 			if (copy_to_user (useraddr, &info, sizeof (info)))
 				return -EFAULT;
@@ -1617,6 +1871,33 @@

 #endif	/* CONFIG_USE_MDIO */

+
+/* Returns the CRC needed when filling in the hash table for
+ * multicast group filtering
+ * pAddr must point to a MAC address (6 bytes)
+ */
+static u32 fec_mulicast_calc_crc(char *pAddr)
+{
+	u8	byte;
+	int	byte_count;
+	int	bit_count;
+	u32	crc = 0xffffffff;
+	u8	msb;
+
+	for (byte_count=0; byte_count<6; byte_count++) {
+        	byte = pAddr[byte_count];
+		for (bit_count=0; bit_count<8; bit_count++) {
+            		msb = crc >> 31;
+            		crc <<= 1;
+            		if (msb ^ (byte & 0x1)) {
+                		crc ^= FEC_CRC_POLY;
+   	    		}
+            		byte >>= 1;
+		}
+        }
+	return (crc);
+}
+
 /* Set or clear the multicast filter for this adaptor.
  * Skeleton taken from sunlance driver.
  * The CPM Ethernet implementation allows Multicast as well as individual
@@ -1650,6 +1931,58 @@
 			 */
 			ep->fec_hash_table_high = 0xffffffff;
 			ep->fec_hash_table_low = 0xffffffff;
+		} else {
+			struct dev_mc_list *pmc = dev->mc_list;
+
+			/* Clear Hash-Table
+			*/
+			ep->fec_hash_table_high = 0;
+			ep->fec_hash_table_low = 0;
+
+			/* Now populate the hash table
+			*/
+#ifdef DEBUG_MULTICAST
+			if (pmc) {
+				printk ("%s: Recalculating hash-table:\n",
+					dev->name);
+				printk (" MAC Address         high     low\n");
+			}
+#endif
+
+			while (pmc) {
+				u32	crc;
+				int	temp;
+				u32	csrVal;
+				int	hash_index;
+
+				crc = fec_mulicast_calc_crc(pmc->dmi_addr);
+				temp = (crc & 0x3f) >> 1;
+				hash_index = ((temp & 0x01) << 4) |
+					     ((temp & 0x02) << 2) |
+					     ((temp & 0x04))      |
+					     ((temp & 0x08) >> 2) |
+					     ((temp & 0x10) >> 4);
+				csrVal = (1 << hash_index);
+				if (crc & 1) {
+					ep->fec_hash_table_high	|= csrVal;
+				}
+				else {
+					ep->fec_hash_table_low	|= csrVal;
+				}
+#ifdef DEBUG_MULTICAST
+				printk (" %02x:%02x:%02x:%02x:%02x:%02x   %08x %08x\n",
+					(int)pmc->dmi_addr[0],
+					(int)pmc->dmi_addr[1],
+					(int)pmc->dmi_addr[2],
+					(int)pmc->dmi_addr[3],
+					(int)pmc->dmi_addr[4],
+					(int)pmc->dmi_addr[5],
+					ep->fec_hash_table_high,
+					ep->fec_hash_table_low
+				);
+#endif
+				pmc = pmc->next;
+			}
 		}
 #if 0
 		else {
@@ -1747,11 +2080,11 @@

 #ifdef CONFIG_SCC_ENET
 	/*
-         * If a board has Ethernet configured both on a SCC and the
-         * FEC, it needs (at least) 2 MAC addresses (we know that Sun
-         * disagrees, but anyway). For the FEC port, we create
-         * another address by setting one of the address bits above
-         * something that would have (up to now) been allocated.
+	 * If a board has Ethernet configured both on a SCC and the
+	 * FEC, it needs (at least) 2 MAC addresses (we know that Sun
+	 * disagrees, but anyway). For the FEC port, we create
+	 * another address by setting one of the address bits above
+	 * something that would have (up to now) been allocated.
 	 */
 	for (i=0; i<6; i++)
 		tmpaddr[i] = *iap++;
@@ -1806,11 +2139,25 @@
 	bdp--;
 	bdp->cbd_sc |= BD_SC_WRAP;

+#ifdef CONFIG_FEC_PACKETHOOK
+	fep->ph_lock = 0;
+	fep->ph_rxhandler = fep->ph_txhandler = NULL;
+	fep->ph_proto = 0;
+	fep->ph_regaddr = NULL;
+	fep->ph_priv = NULL;
+#endif
 	/* Install our interrupt handler. */
 	if (request_8xxirq(FEC_INTERRUPT, fec_enet_interrupt, 0, "fec", dev) != 0)
 		panic("Could not allocate FEC IRQ!");

+	dev->base_addr = (unsigned long)fecp;
+	dev->priv = fep;
+
 #ifdef CONFIG_RPXCLASSIC
+/* If MDIO is disabled the PHY should not be allowed to
+ * generate interrupts telling us to read the PHY.
+ */
+# ifdef CONFIG_USE_MDIO
 	/* Make Port C, bit 15 an input that causes interrupts.
 	*/
 	immap->im_ioport.iop_pcpar &= ~0x0001;
@@ -1818,19 +2165,23 @@
 	immap->im_ioport.iop_pcso  &= ~0x0001;
 	immap->im_ioport.iop_pcint |=  0x0001;
 	cpm_install_handler(CPMVEC_PIO_PC15, mii_link_interrupt, dev);
+# endif	/* CONFIG_USE_MDIO */

 	/* Make LEDS reflect Link status.
 	*/
 	*((uint *) RPX_CSR_ADDR) &= ~BCSR2_FETHLEDMODE;
-#endif
+#endif	/* CONFIG_RPXCLASSIC */

-#ifdef PHY_INTERRUPT
+#ifdef CONFIG_USE_MDIO
+# ifndef PHY_INTERRUPT
+#  error Want to use MII, but PHY_INTERRUPT not defined!
+# endif
 	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel |=
 		(0x80000000 >> PHY_INTERRUPT);

 	if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) != 0)
 		panic("Could not allocate MII IRQ!");
-#endif
+#endif	/* CONFIG_USE_MDIO */

 	dev->base_addr = (unsigned long)fecp;
 	dev->priv = fep;
@@ -1852,10 +2203,39 @@
 	mii_free = mii_cmds;
 #endif	/* CONFIG_USE_MDIO */

+#ifndef CONFIG_ICU862
 	/* Configure all of port D for MII.
 	*/
 	immap->im_ioport.iop_pdpar = 0x1fff;

+#else	/* CONFIG_ICU862 */
+	/* Configure port A for MII.
+	*/
+
+	/* Has Utopia been configured? */
+	if (immap->im_ioport.iop_pdpar & (0x8000 >> 1)) {
+		/*
+		 * YES - Use MUXED mode for UTOPIA bus.
+		 * This frees Port A for use by MII (see 862UM table 41-6).
+		 */
+		immap->im_ioport.utmode &= ~0x80;
+	} else {
+		/*
+		 * NO - set SPLIT mode for UTOPIA bus.
+		 *
+		 * This doesn't really effect UTOPIA (which isn't
+		 * enabled anyway) but just tells the 862
+		 * to use port A for MII (see 862UM table 41-6).
+		 */
+		immap->im_ioport.utmode |= 0x80;
+	}
+
+# ifdef	CONFIG_USE_MDIO
+	/* Now configure MII_MDC pin */
+	immap->im_ioport.iop_pdpar |= (0x8000 >> 8);
+# endif	/* CONFIG_USE_MDIO */
+#endif  /* CONFIG_ICU862 */
+
 	/* Bits moved from Rev. D onward.
 	*/
 	if ((mfspr(IMMR) & 0xffff) < 0x0501)
@@ -1872,7 +2252,10 @@
 	fecp->fec_mii_speed = 0;	/* turn off MDIO */
 #endif	/* CONFIG_USE_MDIO */

-	printk ("%s: FEC ENET Version 0.2, FEC irq %d"
+	printk ("%s: FEC ENET Version 0.3, FEC irq %d"
+#ifdef	CONFIG_USE_MDIO
+		", with MDIO"
+#endif
 #ifdef PHY_INTERRUPT
 		", MII irq %d"
 #endif
@@ -2012,6 +2395,7 @@
 		fecp->fec_r_cntrl = FEC_RCNTRL_MII_MODE | FEC_RCNTRL_DRT;
 		fecp->fec_x_cntrl = 0;
 	}
+
 	fep->full_duplex = duplex;

 	/* Enable big endian and don't care about SDMA FC.

--==_Exmh_12791348070--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
