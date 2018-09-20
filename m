Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GGkP0mXmzF3Jd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 22:48:44 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>,
 <wg@grandegger.com>, <mkl@pengutronix.de>, <michal.simek@xilinx.com>,
 <hsweeten@visionengravers.com>, <madalin.bucur@nxp.com>,
 <pantelis.antoniou@gmail.com>, <claudiu.manoil@nxp.com>,
 <leoyang.li@nxp.com>, <linux@armlinux.org.uk>, <sammy@sammy.net>,
 <ralf@linux-mips.org>, <nico@fluxnic.net>, <steve.glendinning@shawell.net>,
 <f.fainelli@gmail.com>, <grygorii.strashko@ti.com>, <w-kwok2@ti.com>,
 <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>, <jreuter@yaina.de>,
 <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu2@citrix.com>,
 <paul.durrant@citrix.com>, <arvid.brodin@alten.se>, <pshelar@ovn.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-can@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
 <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
 <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>, YueHaibing
 <yuehaibing@huawei.com>
Subject: [PATCH net-next 14/22] net: caif: fix return type of ndo_start_xmit
 function
Date: Thu, 20 Sep 2018 20:32:58 +0800
Message-ID: <20180920123306.14772-15-yuehaibing@huawei.com>
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/caif/caif_hsi.c    | 10 +++++-----
 drivers/net/caif/caif_serial.c |  7 +++++--
 drivers/net/caif/caif_spi.c    |  6 +++---
 drivers/net/caif/caif_virtio.c |  2 +-
 net/caif/chnl_net.c            |  3 ++-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/caif/caif_hsi.c b/drivers/net/caif/caif_hsi.c
index 433a14b..70c449e 100644
--- a/drivers/net/caif/caif_hsi.c
+++ b/drivers/net/caif/caif_hsi.c
@@ -1006,7 +1006,7 @@ static void cfhsi_aggregation_tout(struct timer_list *t)
 	cfhsi_start_tx(cfhsi);
 }
 
-static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct cfhsi *cfhsi = NULL;
 	int start_xfer = 0;
@@ -1014,7 +1014,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 	int prio;
 
 	if (!dev)
-		return -EINVAL;
+		return NETDEV_TX_BUSY;
 
 	cfhsi = netdev_priv(dev);
 
@@ -1048,7 +1048,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (WARN_ON(test_bit(CFHSI_SHUTDOWN, &cfhsi->bits))) {
 		spin_unlock_bh(&cfhsi->lock);
 		cfhsi_abort_tx(cfhsi);
-		return -EINVAL;
+		return NETDEV_TX_BUSY;
 	}
 
 	/* Send flow off if number of packets is above high water mark. */
@@ -1072,7 +1072,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 		spin_unlock_bh(&cfhsi->lock);
 		if (aggregate_ready)
 			cfhsi_start_tx(cfhsi);
-		return 0;
+		return NETDEV_TX_OK;
 	}
 
 	/* Delete inactivity timer if started. */
@@ -1102,7 +1102,7 @@ static int cfhsi_xmit(struct sk_buff *skb, struct net_device *dev)
 			queue_work(cfhsi->wq, &cfhsi->wake_up_work);
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 static const struct net_device_ops cfhsi_netdevops;
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index a0f954f..acb3264 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -275,7 +275,7 @@ static int handle_tx(struct ser_device *ser)
 	return tty_wr;
 }
 
-static int caif_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t caif_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ser_device *ser;
 
@@ -290,7 +290,10 @@ static int caif_xmit(struct sk_buff *skb, struct net_device *dev)
 		ser->common.flowctrl(ser->dev, OFF);
 
 	skb_queue_tail(&ser->head, skb);
-	return handle_tx(ser);
+	if (handle_tx(ser))
+		return NETDEV_TX_BUSY;
+
+	return NETDEV_TX_OK;
 }
 
 
diff --git a/drivers/net/caif/caif_spi.c b/drivers/net/caif/caif_spi.c
index d28a139..9040658 100644
--- a/drivers/net/caif/caif_spi.c
+++ b/drivers/net/caif/caif_spi.c
@@ -486,12 +486,12 @@ static void cfspi_xfer_done_cb(struct cfspi_ifc *ifc)
 	complete(&cfspi->comp);
 }
 
-static int cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct cfspi *cfspi = NULL;
 	unsigned long flags;
 	if (!dev)
-		return -EINVAL;
+		return NETDEV_TX_BUSY;
 
 	cfspi = netdev_priv(dev);
 
@@ -512,7 +512,7 @@ static int cfspi_xmit(struct sk_buff *skb, struct net_device *dev)
 		cfspi->cfdev.flowctrl(cfspi->ndev, 0);
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 int cfspi_rxfrm(struct cfspi *cfspi, u8 *buf, size_t len)
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 2814e0d..f5507db 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -519,7 +519,7 @@ static struct buf_info *cfv_alloc_and_copy_to_shm(struct cfv_info *cfv,
 }
 
 /* Put the CAIF packet on the virtio ring and kick the receiver */
-static int cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t cfv_netdev_tx(struct sk_buff *skb, struct net_device *netdev)
 {
 	struct cfv_info *cfv = netdev_priv(netdev);
 	struct buf_info *buf_info;
diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 13e2ae6..30be426 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -211,7 +211,8 @@ static void chnl_flowctrl_cb(struct cflayer *layr, enum caif_ctrlcmd flow,
 	}
 }
 
-static int chnl_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t
+chnl_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct chnl_net *priv;
 	struct cfpkt *pkt = NULL;
-- 
1.8.3.1
