Date: Wed, 4 Sep 2002 21:57:12 +0200
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] Driver for xilinx ethernet MAC core
Message-ID: <20020904195712.GI781@mind.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
From: p2@mind.be (Peter 'p2' De Schrijver)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Attached you will find a patch to add support for the xilinx ethernet
MAC core. It was tested on an implementation on a Xilinx Virtex2Pro.

Comments welcome,

Peter.
--

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=xemac-patch

diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/net/Config.in linuxppc_2_4_xseg2.new.clean2/drivers/net/Config.in
--- linuxppc_2_4_clean/drivers/net/Config.in	2002-07-20 12:03:29.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/drivers/net/Config.in	2002-09-04 20:07:43.000000000 +0200
@@ -41,6 +41,9 @@
 	 tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
       fi
    fi
+   if [ "$CONFIG_XSEG2" = "y" ]; then
+   	tristate '  Xilinx ethernet MAC support' CONFIG_XEMAC
+   fi
    if [ "$CONFIG_ZORRO" = "y" ]; then
       tristate '  Ariadne support' CONFIG_ARIADNE
       tristate '  Ariadne II and X-Surf support' CONFIG_NE2K_ZORRO
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/net/Makefile linuxppc_2_4_xseg2.new.clean2/drivers/net/Makefile
--- linuxppc_2_4_clean/drivers/net/Makefile	2002-07-20 12:03:47.000000000 +0200
+++ linuxppc_2_4_xseg2.new.clean2/drivers/net/Makefile	2002-07-21 17:04:11.000000000 +0200
@@ -84,6 +84,7 @@
 obj-$(CONFIG_FEALNX) += fealnx.o mii.o
 obj-$(CONFIG_TC35815) += tc35815.o
 obj-$(CONFIG_TIGON3) += tg3.o
+obj-$(CONFIG_XEMAC) += xemac.o

 ifeq ($(CONFIG_SK98LIN),y)
 obj-y += sk98lin/sk98lin.o
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/net/xemac.c linuxppc_2_4_xseg2.new.clean2/drivers/net/xemac.c
--- linuxppc_2_4_clean/drivers/net/xemac.c	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc_2_4_xseg2.new.clean2/drivers/net/xemac.c	2002-09-04 20:45:14.000000000 +0200
@@ -0,0 +1,838 @@
+/*
+ * xemac.c: A driver for Xilinx 10/100Mbit/s ethernet MAC core
+ *
+ * Copyright 2002 Mind NV
+ *
+ * http://www.mind.be/
+ *
+ * Author : Peter De Schrijver (p2@mind.be)
+ *
+ * This software may be used and distributed according to the terms of
+ * the GNU General Public License (GPL) version 2, incorporated herein by
+ * reference. Drivers based on or derived from this code fall under the GPL
+ * and must retain the authorship, copyright and this license notice. This
+ * file is not a complete program and may only be used when the entire
+ * operating system is licensed under the GPL.
+ *
+ */
+
+
+#include <linux/ioport.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <linux/rtnetlink.h>
+#include <asm/io.h>
+
+#include "xemac.h"
+
+/* RX and TX DMA seem to be broken */
+
+#undef USE_RX_DMA
+#undef USE_TX_DMA
+
+#define XEMAC_BASE 0x60000000
+#define XEMAC_LEN  0x3000
+#define XEMAC_IRQ  28
+
+#define TX_TIMEOUT	(4*HZ)
+
+#define MAX_UNITS 1
+
+static int media[MAX_UNITS] = { -1 };
+
+static int max_interrupt_work = 100;
+
+static inline void xemac_writel(unsigned int v,unsigned int a) {
+
+	 out_be32((volatile unsigned int *)(a),(v));
+
+}
+
+static inline unsigned int xemac_readl(unsigned int a) {
+
+	return in_be32((volatile unsigned int *)(a));
+
+}
+
+static void mdio_write (struct net_device *dev, int phy_id, int location,
+					    int value) {
+
+	unsigned int ioaddr=dev->base_addr;
+
+	xemac_writel(value, ioaddr+MGTDR);
+	xemac_writel(MGTCR_SB | (phy_id << 25) | (location << 20) |
+			     MGTCR_IE, ioaddr+MGTCR);
+
+	while(xemac_readl(ioaddr+MGTCR) & MGTCR_BUSY);
+
+}
+
+static int mdio_read(struct net_device *dev, int phy_id, int location) {
+
+	unsigned int ioaddr=dev->base_addr;
+
+	xemac_writel(MGTCR_SB | MGTCR_RWN | (phy_id << 25) |
+			     (location <<  20) | MGTCR_IE, ioaddr+MGTCR);
+	while(xemac_readl(ioaddr+MGTCR) & MGTCR_BUSY);
+
+	return(xemac_readl(ioaddr+MGTDR) & 0xffff);
+
+}
+
+
+static void xemac_hw_start(struct net_device *dev) {
+
+	struct xemac_priv *xp=dev->priv;
+	unsigned int ioaddr=dev->base_addr;
+	int par,i;
+
+	printk("dev: %p, dev->base_addr: %08lx, xp: %p\n",dev,dev->base_addr,xp);
+	printk("ioaddr: %08x\n",ioaddr);
+
+#ifdef USE_TX_DMA
+	for(i=0;i<NUM_TX_DESCR;i++) {
+		xp->tx_buffer_descr[i].device_status=0;
+		xp->tx_buffer_descr[i].control=DMACR_SG_DISABLE;
+		xp->tx_buffer_descr[i].length=0;
+		xp->tx_buffer_descr[i].status=0;
+		xp->tx_buffer_descr[i].next=
+						virt_to_bus(&xp->tx_buffer_descr[(i+1)%NUM_TX_DESCR]);
+		xp->tx_buffer_descr[i].flags=0;
+		xp->tx_buffer_descr[i].req_length=0;
+		xp->tx_buffer_descr[i].destination=XEMAC_BASE+FIFO_TX_DATA;
+		xp->tx_buffer_descr[i].source=xp->tx_buffer_dma_addr+i*TX_BUF_LEN;
+		xp->tx_buffer_descr[i].buffer=xp->tx_buffer+i*TX_BUF_LEN;
+	}
+#endif
+
+	xemac_writel(ECR_RSTTX | ECR_RSTRX,ioaddr+ECR);
+	udelay(100);
+	xemac_writel(ECR_ENPHY | ECR_TXPAD | ECR_TXFCS | ECR_UA | ECR_BA,
+				 ioaddr+ECR);
+
+	mdio_write(dev, xp->phys[0], 0, 0x8000);
+	while(mdio_read(dev, xp->phys[0],0) & 0x8000);
+
+	xemac_writel((dev->dev_addr[0] << 8) |
+		   (dev->dev_addr[1]), ioaddr+SAH);
+
+	xemac_writel((dev->dev_addr[2] << 24) |
+		   (dev->dev_addr[3] << 16) |
+		   (dev->dev_addr[4] << 8) |
+		   (dev->dev_addr[5]), ioaddr+SAL);
+
+	par=mdio_read(dev, xp->phys[0], 0x11);
+
+	xemac_writel(xemac_readl(ioaddr+ECR) | ((par & (1<<9)) ? (1<<31) : 0), ioaddr+ECR);
+	xemac_writel(xemac_readl(ioaddr+ECR) | ECR_ENTX | ECR_ENRX, ioaddr+ECR);
+
+#ifdef USE_TX_DMA
+	xemac_writel(DMA_IX_PKT_DONE | DMA_IX_DMA_ERROR,
+				 ioaddr + TX_DMA_IEREG);
+#endif
+
+#ifdef USE_RX_DMA
+	xemac_writel(DMA_IX_PKT_DONE | DMA_IX_DMA_ERROR,
+				 ioaddr + RX_DMA_IEREG);
+#endif
+
+	xp->cur_tx=xp->tx_inuse=xp->tx_dirty=0;
+#ifdef USE_TX_DMA
+	xemac_writel(xp->tx_dma_addr,ioaddr+TX_DMA_BDA);
+#endif
+	xp->cur_rx=0;
+
+#ifdef USE_RX_DMA
+	xemac_writel(xp->rx_dma_addr,ioaddr+RX_DMA_BDA);
+#endif
+
+
+	xemac_writel(EMAC_INT    |
+#ifdef USE_RX_DMA
+				 RECV_DMA_INT |
+#endif
+#ifdef USE_TX_DMA
+				 XMIT_DMA_INT |
+#endif
+				 0,ioaddr+INT_MASK);
+
+	xemac_writel(0	|
+#ifndef USE_RX_DMA
+			     RECV_DONE_INT |
+#endif
+#ifndef USE_TX_DMA
+				 TX_DONE_INT |
+#endif
+			     0, ioaddr+IPIF_IE);
+
+
+#ifdef USE_RX_DMA
+	xemac_writel(xemac_readl(ioaddr+RX_DMAC_REG) & ~DMACR_SG_DISABLE,
+				 ioaddr+RX_DMAC_REG);
+	xemac_writel(xemac_readl(ioaddr+RX_SWCR_REG) | SWCR_SG_ENABLE,
+				 ioaddr+RX_SWCR_REG);
+#endif
+
+	xemac_writel(1<<31, ioaddr + INT_GLOBAL);
+
+	netif_start_queue(dev);
+
+}
+
+static void xemac_set_multicast(struct net_device *dev) {
+
+	unsigned int ioaddr=dev->base_addr;
+
+	if(dev->flags & IFF_PROMISC) {
+		printk (KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
+		xemac_writel(xemac_readl(ioaddr+ECR) | ECR_PROMISC,ioaddr + ECR);
+	}
+	if((dev->flags & IFF_ALLMULTI) || dev->mc_count)
+		xemac_writel(xemac_readl(ioaddr+ECR) | ECR_MULTI,ioaddr + ECR);
+
+}
+
+static struct net_device_stats *xemac_get_stats(struct net_device *dev) {
+
+	struct xemac_priv *xp=dev->priv;
+
+	return &xp->stats;
+
+}
+
+static void xemac_tx_timeout(struct net_device *dev) {
+
+	unsigned int ioaddr=dev->base_addr;
+
+	xemac_writel(xemac_readl(ioaddr+TX_SWCR_REG) & ~SWCR_SG_ENABLE,ioaddr+TX_SWCR_REG);
+	xemac_writel(0,ioaddr+TX_RESET_REG);
+	xemac_writel(0, ioaddr+INT_MASK);
+	xemac_writel((xemac_readl(ioaddr+ECR) | ECR_RSTTX | ECR_RSTRX) &
+					~(ECR_ENTX | ECR_ENRX | ECR_ENPHY),
+			ioaddr+ECR);
+
+	xemac_hw_start(dev);
+
+}
+
+#ifndef USE_TX_DMA
+static void inline write_tx_fifo(struct sk_buff *skb,unsigned int ioaddr) {
+
+	int i;
+	unsigned int *data;
+
+	data=(unsigned int *)skb->data;
+
+	for(i=skb->len;i>0;i-=4){
+		*(unsigned int *)(ioaddr+FIFO_TX_DATA)=*(data++);
+	}
+	if(i>1) {
+		*(unsigned short *)(ioaddr+FIFO_TX_DATA)=*((unsigned short *)data++);
+		i-=2;
+	}
+	if(i>0) {
+		*(unsigned char *)(ioaddr+FIFO_TX_DATA)=*(unsigned char *)data;
+	}
+
+}
+#endif
+
+#ifdef USE_TX_DMA
+static int xemac_start_xmit(struct sk_buff *skb, struct net_device *dev) {
+
+	struct xemac_priv *xp=dev->priv;
+	unsigned int ioaddr=dev->base_addr;
+	int entry,len=skb->len;
+
+	spin_lock_irq(&xp->lock);
+
+	entry=xp->cur_tx ;
+
+	if(xp->tx_inuse)
+		xp->tx_buffer_descr[(entry-1)% NUM_TX_DESCR].control&=~DMACR_SG_DISABLE;
+
+	if(likely(len < TX_BUF_LEN)) {
+		skb_copy_and_csum_dev(skb, xp->tx_buffer_descr[entry].buffer);
+		dev_kfree_skb(skb);
+	}
+	else {
+		dev_kfree_skb(skb);
+		xp->stats.tx_dropped++;
+		return 0;
+	}
+
+	xp->tx_buffer_descr[entry].length=len;
+	xp->tx_buffer_descr[entry].req_length=len;
+	xp->tx_buffer_descr[entry].control=DMACR_SOURCE_INCR | DMACR_DEST_LOCAL
+			  						   | DMACR_LAST_BD | DMACR_SG_DISABLE;
+
+#if 0
+	if(!(xemac_readl(ioaddr+TX_DMAS_REG) & DMASR_SG_BUSY)) {
+#endif
+		xemac_writel(xemac_readl(ioaddr+TX_DMAC_REG) & ~DMACR_SG_DISABLE,ioaddr+TX_DMAC_REG);
+		xemac_writel(xemac_readl(ioaddr+TX_SWCR_REG) | SWCR_SG_ENABLE,ioaddr+TX_SWCR_REG);
+#if 0
+	}
+#endif
+
+	xp->cur_tx=(entry + 1) % NUM_TX_DESCR;
+	xp->tx_inuse++;
+	if(xp->tx_inuse >= (NUM_TX_DESCR-1))
+		netif_stop_queue (dev);
+
+	dev->trans_start = jiffies;
+
+	spin_unlock_irq(&xp->lock);
+
+	return 0;
+
+}
+#else
+static int xemac_start_xmit(struct sk_buff *skb, struct net_device *dev) {
+
+	struct xemac_priv *xp=dev->priv;
+	unsigned int ioaddr=dev->base_addr;
+
+	spin_lock_irq(&xp->lock);
+
+	xp->tx_buffers[xp->tx_dirty]=skb;
+
+	if(!xp->tx_inuse) {
+		write_tx_fifo(xp->tx_buffers[xp->cur_tx],ioaddr);
+		xemac_writel(skb->len,ioaddr + TPLR);
+	}
+
+	xp->tx_inuse++;
+	xp->tx_dirty=(xp->tx_dirty+1) % NUM_TX_BUFFERS;
+
+	if(xp->tx_inuse==NUM_TX_BUFFERS)
+		netif_stop_queue (dev);
+
+	dev->trans_start = jiffies;
+
+	spin_unlock_irq(&xp->lock);
+
+	return 0;
+
+}
+#endif
+
+#ifdef USE_RX_DMA
+static inline void xemac_rx_interrupt(struct net_device *dev,
+								struct xemac_priv *xp,
+								unsigned int ioaddr) {
+
+	int bdcount;
+	int cur_rx=xp->cur_rx,len;
+
+	bdcount=xemac_readl(ioaddr + RX_DMA_PKTCNT);
+
+	for(;bdcount;bdcount--) {
+		struct sk_buff *skb=xp->rx_buffer_descr[cur_rx].skb;
+		struct rx_buffer_descr *rxb=&xp->rx_buffer_descr[cur_rx];
+
+		len=rxb->length;
+
+	 	skb_put(skb,len);
+		skb->protocol = eth_type_trans(skb, dev);
+
+		netif_rx(skb);
+
+		skb=dev_alloc_skb(MAX_ETH_FRAME_SIZE);
+		if(skb) {
+			rxb->skb=skb;
+			dma_cache_wback_inv((unsigned long)skb->data,MAX_ETH_FRAME_SIZE);
+			rxb->destination=virt_to_bus(skb->data);
+			rxb->control=DMACR_GEN_BD_INTR|DMACR_DEST_INCR|DMACR_SOURCE_LOCAL;
+			rxb->length=MAX_ETH_FRAME_SIZE;
+			rxb->req_length=MAX_ETH_FRAME_SIZE;
+		}
+		else {
+			panic("FIXME: out of memory\n");
+		}
+
+		cur_rx=(++cur_rx) % NUM_RX_DESCR;
+
+	}
+
+	xp->cur_rx=cur_rx;
+
+	return ;
+
+}
+#else
+static inline void xemac_rx_fifo_interrupt(struct net_device *dev,
+								struct xemac_priv *xp,
+								unsigned int ioaddr) {
+
+		struct sk_buff *skb;
+		unsigned int *data;
+		int len,i;
+
+		len=xemac_readl(ioaddr + RPLR);
+		skb=dev_alloc_skb(len+2);
+		if(skb) {
+			skb->dev = dev;
+			skb_reserve(skb,2);
+			data=(unsigned int *)skb->data;
+			for(i=len;i>0;i-=4) {
+				*(data++)=*(unsigned int *)(ioaddr+FIFO_RX_DATA);
+			}
+			if(i>1) {
+				*((unsigned short *)data++)=*(unsigned short *)(ioaddr+FIFO_RX_DATA);
+				i-=2;
+			}
+			if(i>0) {
+				*(unsigned char *)data=*(unsigned char *)(ioaddr+FIFO_RX_DATA);
+			}
+			skb_put (skb, len);
+			skb->protocol = eth_type_trans (skb, dev);
+
+			netif_rx (skb);
+			dev->last_rx = jiffies;
+		}
+		else {
+			printk (KERN_WARNING
+				"%s: Memory squeeze, dropping packet.\n",
+				dev->name);
+			xp->stats.rx_dropped++;
+			writel(0,ioaddr+ FIFO_RX_RESET);
+		}
+
+}
+#endif
+
+#ifdef USE_TX_DMA
+static inline void xemac_tx_interrupt(struct net_device *dev,
+									  struct xemac_priv *xp,
+									  unsigned int ioaddr) {
+
+	int status;
+	int tx_dirty=xp->tx_dirty;
+
+	status=xemac_readl(ioaddr+TX_DMA_ISREG);
+
+	if(status & DMA_IX_PKT_DONE) {
+		while(tx_dirty!=xp->cur_tx) {
+			xp->tx_buffer_descr[tx_dirty].control=DMACR_SG_DISABLE;
+			tx_dirty=(tx_dirty+1)%NUM_TX_DESCR;
+			xp->tx_inuse--;
+		}
+		xemac_writel(DMA_IX_PKT_DONE, ioaddr+TX_DMA_ISREG);
+	}
+
+	if(status & DMA_IX_DMA_ERROR) {
+		printk(KERN_WARNING "%s: TX DMA error\n", dev->name);
+		xemac_hw_start(dev);
+	}
+
+	xp->tx_dirty=tx_dirty;
+
+	if (netif_queue_stopped (dev))
+		netif_wake_queue (dev);
+
+
+}
+#else
+static inline void xemac_tx_fifo_interrupt(struct net_device *dev,
+									  struct xemac_priv *xp,
+									  unsigned int ioaddr) {
+
+	int status;
+
+	status=xemac_readl(ioaddr+TSR);
+
+	dev_kfree_skb_irq(xp->tx_buffers[xp->cur_tx]);
+	xp->cur_tx=(xp->cur_tx+1) % NUM_TX_BUFFERS;
+	xp->tx_inuse--;
+	if(xp->tx_inuse) {
+		write_tx_fifo(xp->tx_buffers[xp->cur_tx],ioaddr);
+		xemac_writel(xp->tx_buffers[xp->cur_tx]->len,ioaddr + TPLR);
+	}
+
+	if (netif_queue_stopped (dev))
+		netif_wake_queue (dev);
+
+}
+#endif
+
+static inline void xemac_int(struct net_device *dev,
+						     struct xemac_priv *xp,
+							 unsigned int ioaddr) {
+
+	int status;
+
+	status=xemac_readl(ioaddr+IPIF_IS) & (RECV_DONE_INT | TX_DONE_INT);
+
+	if(status & RECV_DONE_INT) {
+		xemac_rx_fifo_interrupt(dev,xp,ioaddr);
+		xemac_writel(RECV_DONE_INT,ioaddr + IPIF_IS);
+	}
+
+	if(status & TX_DONE_INT) {
+		xemac_tx_fifo_interrupt(dev,xp,ioaddr);
+		xemac_writel(TX_DONE_INT,ioaddr + IPIF_IS);
+	}
+
+	return ;
+
+}
+
+static void xemac_interrupt(int irq, void *dev_instance, struct pt_regs *regs) {
+
+	struct net_device *dev = (struct net_device *) dev_instance;
+	struct xemac_priv *xp=dev->priv;
+	unsigned int ioaddr=dev->base_addr;
+	int status,workcount=max_interrupt_work;
+
+	spin_lock(&xp->lock);
+
+	do {
+		status=xemac_readl(ioaddr+INT_PENDING);
+
+#ifdef USE_RX_DMA
+		if(status & RECV_DMA_INT) {
+			xemac_rx_interrupt(dev,xp,ioaddr);
+			xemac_writel(RECV_DMA_INT, ioaddr+INT_STATUS);
+		}
+#endif
+#ifdef USE_TX_DMA
+		if(status & XMIT_DMA_INT) {
+			xemac_tx_interrupt(dev,xp,ioaddr);
+			xemac_writel(XMIT_DMA_INT, ioaddr+INT_STATUS);
+		}
+#endif
+		if(status & EMAC_INT) {
+			xemac_int(dev,xp,ioaddr);
+			xemac_writel(EMAC_INT, ioaddr+INT_STATUS);
+		}
+
+		if(status & ERROR_INT)
+			xemac_writel(ERROR_INT,ioaddr+INT_STATUS);
+
+		workcount--;
+
+	} while(status && (workcount>0));
+
+	if(workcount<= 0) {
+		printk(KERN_WARNING
+			   "%s: Too much work at interrupt, "
+			   "status: %08x.\n", dev->name,status);
+		xemac_writel(0xffffffff, ioaddr+INT_STATUS);
+	}
+
+	spin_unlock (&xp->lock);
+
+}
+static int mii_ioctl (struct net_device *dev, struct ifreq *rq, int cmd) {
+
+	int rc=0;
+	u16 *data = (u16 *) & rq->ifr_data;
+	struct xemac_priv *xp=dev->priv;
+
+	switch (cmd) {
+		case SIOCDEVPRIVATE:    /* Get the address of the PHY in use. */
+			data[0]=xp->phys[0] & 0x3f;
+			/* Fall Through */
+
+		case SIOCDEVPRIVATE + 1:        /* Read the specified MII register. */
+			data[3] = mdio_read (dev, data[0], data[1] & 0x1f);
+			break;
+
+		case SIOCDEVPRIVATE + 2:        /* Write the specified MII register */
+			if (!capable (CAP_NET_ADMIN)) {
+				rc = -EPERM;
+				break;
+			}
+
+			mdio_write (dev, data[0], data[1] & 0x1f, data[2]);
+			break;
+
+		default:
+			rc = -EOPNOTSUPP;
+			break;
+
+	}
+
+	return rc;
+}
+
+static inline void xemac_thread_iter(struct net_device *dev, struct xemac_priv *xp) {
+
+	unsigned int ioaddr=dev->base_addr;
+	int mii_lpa;
+
+	mii_lpa=mdio_read (dev, xp->phys[0], MII_LPA);
+	if (!xp->mii.duplex_lock && mii_lpa != 0xffff) {
+
+		int duplex = (mii_lpa & LPA_100FULL) || (mii_lpa & 0x01C0) == 0x0040;
+
+		if(xp->mii.full_duplex != duplex) {
+
+			unsigned int ctrl;
+
+			xp->mii.full_duplex = duplex;
+
+			if(mii_lpa) {
+				printk (KERN_INFO
+						"%s: Setting %s-duplex based on MII #%d link"
+						" partner ability of %4.4x.\n",
+						dev->name, xp->mii.full_duplex ? "full" : "half",
+						xp->phys[0], mii_lpa);
+			} else {
+				printk(KERN_INFO
+						"%s: media is unconnected, link down, or "
+						"incompatible connection\n", dev->name);
+			}
+			ctrl=xemac_readl(ioaddr+ECR);
+			xemac_writel(ctrl & ~(ECR_ENTX | ECR_ENRX),ioaddr+ECR);
+			ctrl&=~ECR_FD;
+			ctrl|=xp->mii.full_duplex ? ECR_FD : 0;
+			xemac_writel(ctrl,ioaddr+ECR);
+		}
+
+	}
+}
+
+static int xemac_thread (void *data) {
+
+	struct net_device *dev = data;
+	struct xemac_priv *xp=dev->priv;
+	unsigned long timeout;
+
+	daemonize();
+	reparent_to_init();
+	spin_lock_irq(&current->sigmask_lock);
+	sigemptyset(&current->blocked);
+	recalc_sigpending(current);
+	spin_unlock_irq(&current->sigmask_lock);
+
+	strncpy (current->comm, dev->name, sizeof(current->comm) - 1);
+	current->comm[sizeof(current->comm) - 1] = '\0';
+
+	while(1) {
+		timeout = HZ;
+		do {
+			timeout = interruptible_sleep_on_timeout (&xp->thr_wait, timeout);
+		} while (!signal_pending (current) && (timeout > 0));
+
+		if (signal_pending (current)) {
+			spin_lock_irq(&current->sigmask_lock);
+			flush_signals(current);
+			spin_unlock_irq(&current->sigmask_lock);
+		}
+
+		if(xp->time_to_die)
+			break;
+
+		rtnl_lock();
+		xemac_thread_iter(dev, xp);
+		rtnl_unlock();
+	}
+
+	complete_and_exit (&xp->thr_exited, 0);
+}
+
+static int xemac_close(struct net_device *dev) {
+
+	struct xemac_priv *xp=dev->priv;
+	unsigned int ioaddr=dev->base_addr;
+
+	netif_stop_queue (dev);
+
+	spin_lock_irq (&xp->lock);
+
+	xemac_writel(0, ioaddr+INT_MASK);
+	xemac_writel((xemac_readl(ioaddr+ECR) | ECR_RSTTX | ECR_RSTRX) &
+					~(ECR_ENTX | ECR_ENRX | ECR_ENPHY),
+			ioaddr+ECR);
+
+	spin_unlock_irq (&xp->lock);
+
+	synchronize_irq ();
+
+	consistent_free(xp->rx_buffer_descr);
+	consistent_free(xp->tx_buffer);
+#ifdef USE_RX_DMA
+	consistent_free(xp->tx_buffer_descr);
+#endif
+
+	free_irq (dev->irq, dev);
+
+	return 0;
+}
+
+static int xemac_open(struct net_device *dev) {
+
+	struct xemac_priv *xp=dev->priv;
+	struct rx_buffer_descr *rxb;
+	int retval,i;
+
+#ifdef USE_TX_DMA
+	xp->tx_buffer_descr=consistent_alloc(GFP_KERNEL|GFP_DMA,
+					NUM_TX_DESCR * sizeof(struct tx_buffer_descr),
+					&xp->tx_dma_addr);
+
+	if(!xp->tx_buffer_descr)
+		return -ENOMEM;
+
+	xp->tx_buffer=consistent_alloc(GFP_KERNEL|GFP_DMA,
+					NUM_TX_DESCR * TX_BUF_LEN,
+					&xp->tx_buffer_dma_addr);
+
+	if(!xp->tx_buffer)
+		return -ENOMEM;
+#endif
+
+#ifdef USE_RX_DMA
+	rxb=consistent_alloc(GFP_KERNEL|GFP_DMA,
+					NUM_RX_DESCR * sizeof(struct rx_buffer_descr),
+					&xp->rx_dma_addr);
+
+	if(!rxb)
+		return -ENOMEM;
+
+	xp->rx_buffer_descr=rxb;
+
+	for(i=0;i<NUM_RX_DESCR;i++,rxb++) {
+		struct sk_buff *skb;
+
+		rxb->device_status=0;
+		rxb->control=DMACR_DEST_INCR|DMACR_SOURCE_LOCAL| DMACR_SG_DISABLE | DMACR_LAST_BD;
+		rxb->length=MAX_ETH_FRAME_SIZE;
+		rxb->status=0;
+		rxb->next=virt_to_bus(&xp->rx_buffer_descr[(i+1)%NUM_RX_DESCR]);
+		rxb->flags=0;
+		rxb->req_length=MAX_ETH_FRAME_SIZE;
+		rxb->source=XEMAC_BASE+FIFO_RX_DATA;
+
+		skb=dev_alloc_skb(MAX_ETH_FRAME_SIZE);
+		rxb->skb=skb;
+		dma_cache_inv((unsigned long)skb->data,MAX_ETH_FRAME_SIZE);
+		rxb->destination=0x30000000; /* virt_to_bus(skb->data); */
+
+printk("rxb->destination: %08x, skb->data: %08x\n",rxb->destination, skb->data);
+
+	}
+#endif
+
+	retval=request_irq(dev->irq, xemac_interrupt, SA_SHIRQ, dev->name, dev);
+	if (retval) {
+		return retval;
+	}
+
+	xemac_hw_start(dev);
+
+	xp->time_to_die = 0;
+	xp->thr_pid = kernel_thread (xemac_thread, dev, CLONE_FS | CLONE_FILES);
+	if (xp->thr_pid < 0)
+		printk (KERN_WARNING "%s: unable to start kernel thread\n", dev->name);
+
+	return 0;
+
+}
+
+int __devinit xemac_probe(void) {
+
+	unsigned int ioaddr,ver_major,ver_minor,rev_letter;
+	struct net_device *dev;
+	struct xemac_priv *xp;
+	int err;
+
+
+	if(!request_region(XEMAC_BASE, XEMAC_LEN,"Xilinx Ethernet MAC"))
+		return -EBUSY;
+
+	ioaddr=(unsigned int)ioremap(XEMAC_BASE, XEMAC_LEN);
+
+	if(ioaddr==0) {
+		printk(KERN_ERR "cannot remap xemac MMIO range, aborting\n");
+		release_region(XEMAC_BASE, XEMAC_LEN);
+		return -EIO;
+	}
+
+	dev=alloc_etherdev(sizeof(struct xemac_priv));
+	if(dev==NULL) {
+		release_region(XEMAC_BASE, XEMAC_LEN);
+		return -ENOMEM;
+	}
+
+	xp=dev->priv;
+	dev->open=xemac_open;
+	dev->hard_start_xmit=xemac_start_xmit;
+	dev->stop=xemac_close;
+	dev->get_stats=xemac_get_stats;
+	dev->set_multicast_list=xemac_set_multicast;
+	dev->do_ioctl=mii_ioctl;
+	dev->tx_timeout=xemac_tx_timeout;
+	dev->watchdog_timeo = TX_TIMEOUT;
+
+	dev->irq=XEMAC_IRQ;
+
+	dev->base_addr = (unsigned int) ioaddr;
+
+	xp->phys[0]=0;
+
+    spin_lock_init (&xp->lock);
+    init_waitqueue_head (&xp->thr_wait);
+    init_completion (&xp->thr_exited);
+
+	err=register_netdev(dev);
+	if(err) {
+		release_region(XEMAC_BASE, XEMAC_LEN);
+		kfree(dev);
+		return err;
+	}
+
+	dev->dev_addr[0]=0x00;
+	dev->dev_addr[1]=0xE0;
+	dev->dev_addr[2]=0x29;
+	dev->dev_addr[3]=0x30;
+	dev->dev_addr[4]=0xcc;
+	dev->dev_addr[5]=0xe8;
+
+	ver_major=xemac_readl(ioaddr + EMIR) >> 28;
+	ver_minor=(xemac_readl(ioaddr + EMIR) >> 21) & 0x7f;
+	rev_letter=(xemac_readl(ioaddr + EMIR) >> 16) & 0x1f;
+
+	printk(KERN_INFO "%s: Xilinx Ethernet MAC (Rev %d.%d%c) at 0x%x,"
+					 "%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x, "
+					 "IRQ %d\n",
+					 dev->name,
+					 ver_major,ver_minor,'a'+rev_letter,
+					 XEMAC_BASE,
+	                 dev->dev_addr[0], dev->dev_addr[1],
+					 dev->dev_addr[2], dev->dev_addr[3],
+					 dev->dev_addr[4], dev->dev_addr[5],
+					 dev->irq);
+
+	if(media[0] > 0) {
+		xp->medialock=1;
+		xp->duplex=media[0] & 0x20 ? 100 : 10;
+		xp->speed=(media[0] & 0x10) ? 0x0100 : 0;
+
+		printk(KERN_INFO "Forcing %dMbps %s-duplex operation.\n",
+					(xp->speed? 100 : 10),
+					(xp->duplex ? "full" : "half"));
+
+		mdio_write(dev, xp->phys[0], 4, (xp->duplex ? 0x2000 : 0) |
+						(xp->speed ? 0x0100 : 0));
+
+	}
+
+	return 0;
+
+}
+
+module_init(xemac_probe);
+
diff -urN -x CVS -x config -x modules -x mtd -x jffs2 -x jffs linuxppc_2_4_clean/drivers/net/xemac.h linuxppc_2_4_xseg2.new.clean2/drivers/net/xemac.h
--- linuxppc_2_4_clean/drivers/net/xemac.h	1970-01-01 01:00:00.000000000 +0100
+++ linuxppc_2_4_xseg2.new.clean2/drivers/net/xemac.h	2002-09-04 20:57:33.000000000 +0200
@@ -0,0 +1,196 @@
+/*
+ * xemac.h: A driver for Xilinx 10/100Mbit/s ethernet MAC core
+ *
+ * Copyright 2002 Mind NV
+ *
+ * http://www.mind.be/
+ *
+ * Author : Peter De Schrijver (p2@mind.be)
+ *
+ * This software may be used and distributed according to the terms of
+ * the GNU General Public License (GPL) version 2, incorporated herein by
+ * reference. Drivers based on or derived from this code fall under the GPL
+ * and must retain the authorship, copyright and this license notice. This
+ * file is not a complete program and may only be used when the entire
+ * operating system is licensed under the GPL.
+ *
+ */
+
+#ifndef _XEMAC_H
+#define _XEMAC_H
+
+#include <asm/io.h>
+#include <linux/mii.h>
+
+#define NUM_TX_DESCR 32
+#define NUM_TX_BUFFERS 4
+#define NUM_RX_DESCR 1
+
+#define MAX_ETH_FRAME_SIZE  1536
+#define TX_BUF_LEN	MAX_ETH_FRAME_SIZE
+
+/* DMA buffer descriptor */
+
+struct tx_buffer_descr {
+
+	unsigned int device_status;
+	unsigned int control;
+	unsigned int source;
+	unsigned int destination;
+	unsigned int length;
+	unsigned int status;
+	unsigned int next;
+	unsigned char *buffer;
+	unsigned int flags;
+	unsigned int req_length;
+
+};
+
+struct rx_buffer_descr {
+
+	unsigned int device_status;
+	unsigned int control;
+	unsigned int source;
+	unsigned int destination;
+	unsigned int length;
+	unsigned int status;
+	unsigned int next;
+	struct sk_buff *skb;
+	unsigned int flags;
+	unsigned int req_length;
+
+};
+
+struct xemac_priv {
+
+	struct net_device_stats stats;
+	spinlock_t lock;
+	struct tx_buffer_descr *tx_buffer_descr;
+	struct rx_buffer_descr *rx_buffer_descr;
+	struct sk_buff *tx_buffers[NUM_TX_BUFFERS];
+	unsigned char *tx_buffer;
+	unsigned int tx_dma_addr;
+	unsigned int tx_buffer_dma_addr;
+	unsigned int rx_dma_addr;
+	int cur_rx,cur_tx, tx_inuse,tx_dirty;
+	unsigned int medialock:1;
+	unsigned int duplex:1;
+	unsigned int speed:1;
+	struct mii_if_info mii;
+	char phys[1];
+	pid_t thr_pid;
+	wait_queue_head_t thr_wait;
+	struct completion thr_exited;
+	int time_to_die;
+};
+
+
+/* emac core registers */
+
+#define EMIR	0x1100
+
+#define	ECR 	0x1104
+#define ECR_PROMISC	(1<<14)
+#define ECR_MULTI	(1<<16)
+#define ECR_FD		(1<<31)
+#define ECR_RSTTX   (1<<30)
+#define ECR_ENTX	(1<<29)
+#define ECR_RSTRX   (1<<28)
+#define ECR_ENRX	(1<<27)
+#define ECR_ENPHY	(1<<26)
+#define ECR_UA		(1<<17)
+#define ECR_BA		(1<<15)
+#define ECR_TXPAD	(1<<25)
+#define ECR_TXFCS	(1<<24)
+
+#define SAH		0x110c
+#define SAL		0x1110
+
+#define MGTCR	0x1114
+#define MGTCR_SB	(1<<31)
+#define MGTCR_BUSY  (1<<31)
+#define MGTCR_RWN	(1<<30)
+#define MGTCR_IE	(1<<19)
+
+#define MGTDR	0x1118
+
+#define RPLR	0x111C
+
+#define TPLR	0x1120
+
+#define TSR		0x1124
+
+/* emac ipif registers */
+
+#define IPIF_IS	0x20
+#define IPIF_IE	0x28
+
+#define RECV_DONE_INT 0x2
+#define TX_DONE_INT 0x1
+
+/* interrupt registers */
+
+#define INT_STATUS 0
+
+#define INT_PENDING 4
+
+#define INT_MASK 8
+
+#define INT_GLOBAL 0x1c
+
+#define SEND_FIFO_INT	0x00000020
+#define RECV_FIFO_INT	0x00000020
+#define RECV_DMA_INT	0x00000010
+#define XMIT_DMA_INT	0x00000008
+#define EMAC_INT		0x00000004
+#define ERROR_INT		0x00000001
+
+/* TX and RX FIFO registers */
+
+#define FIFO_RX_RESET	0x2010
+
+#define FIFO_TX_DATA	0x2100
+#define FIFO_RX_DATA	0x2200
+
+/* TX and RX DMA registers */
+
+#define TX_RESET_REG 0x2300
+
+#define TX_SWCR_REG	0x231c
+#define RX_SWCR_REG	0x235c
+#define SWCR_SG_ENABLE 0x80000000
+
+#define TX_DMAC_REG	0x2304
+#define RX_DMAC_REG	0x2344
+#define DMACR_SOURCE_INCR	0x80000000
+#define DMACR_DEST_INCR		0x40000000
+#define DMACR_SOURCE_LOCAL	0x20000000
+#define DMACR_DEST_LOCAL	0x10000000
+#define DMACR_SG_DISABLE 	0x08000000
+#define DMACR_GEN_BD_INTR 	0x04000000
+#define DMACR_LAST_BD	  	0x02000000
+
+#define TX_DMAS_REG 0x2314
+#define RX_DMAS_REG 0x2354
+#define DMASR_SG_BUSY 0x08000000
+
+#define TX_DMA_BDA	0x2318
+#define RX_DMA_BDA	0x2358
+
+#define TX_DMA_ISREG 0x232C
+#define RX_DMA_ISREG 0x236C
+#define TX_DMA_IEREG 0x2330
+#define RX_DMA_IEREG 0x2370
+
+#define DMA_IX_DMA_DONE	 		1
+#define DMA_IX_DMA_ERROR	 	2
+#define DMA_IX_PKT_DONE	 		4
+#define DMA_IX_PKT_THRESHOLD	8
+#define DMA_IX_PKT_WAITBOUND	16
+#define DMA_IX_SG_DISABLE_ACK	32
+#define DMA_IX_SG_END			64
+#define DMA_IX_BD_DONE			128
+
+#define RX_DMA_PKTCNT 0x2360
+
+#endif

--FCuugMFkClbJLl1L--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
