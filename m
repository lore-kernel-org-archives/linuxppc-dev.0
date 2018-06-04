Return-Path: <yangbo.lu@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zmV26yqvzF0tX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 17:17:30 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Date: Mon,  4 Jun 2018 15:08:36 +0800
Message-Id: <20180604070837.19265-10-yangbo.lu@nxp.com>
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to add hardware timestamping support
for dpaa_eth. On Rx, timestamping is enabled for
all frames. On Tx, we only instruct the hardware
to timestamp the frames marked accordingly by the
stack.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/Kconfig    |   12 +++
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  119 +++++++++++++++++++++++-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h |    5 +
 3 files changed, 133 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/Kconfig b/drivers/net/ethernet/freescale/dpaa/Kconfig
index a654736..da34138 100644
--- a/drivers/net/ethernet/freescale/dpaa/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa/Kconfig
@@ -8,3 +8,15 @@ menuconfig FSL_DPAA_ETH
 	  supporting the Freescale QorIQ chips.
 	  Depends on Freescale Buffer Manager and Queue Manager
 	  driver and Frame Manager Driver.
+
+if FSL_DPAA_ETH
+config FSL_DPAA_ETH_TS
+	bool "DPAA hardware timestamping support"
+	select PTP_1588_CLOCK_QORIQ
+	default n
+	help
+	  Enable DPAA hardware timestamping support.
+	  This option is useful for applications to get
+	  hardware time stamps on the Ethernet packets
+	  using the SO_TIMESTAMPING API.
+endif
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index fd43f98..864cfb0 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1168,7 +1168,11 @@ static int dpaa_eth_init_tx_port(struct fman_port *port, struct dpaa_fq *errq,
 	buf_prefix_content.priv_data_size = buf_layout->priv_data_size;
 	buf_prefix_content.pass_prs_result = true;
 	buf_prefix_content.pass_hash_result = true;
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+	buf_prefix_content.pass_time_stamp = true;
+#else
 	buf_prefix_content.pass_time_stamp = false;
+#endif
 	buf_prefix_content.data_align = DPAA_FD_DATA_ALIGNMENT;
 
 	params.specific_params.non_rx_params.err_fqid = errq->fqid;
@@ -1210,7 +1214,11 @@ static int dpaa_eth_init_rx_port(struct fman_port *port, struct dpaa_bp **bps,
 	buf_prefix_content.priv_data_size = buf_layout->priv_data_size;
 	buf_prefix_content.pass_prs_result = true;
 	buf_prefix_content.pass_hash_result = true;
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+	buf_prefix_content.pass_time_stamp = true;
+#else
 	buf_prefix_content.pass_time_stamp = false;
+#endif
 	buf_prefix_content.data_align = DPAA_FD_DATA_ALIGNMENT;
 
 	rx_p = &params.specific_params.rx_params;
@@ -1592,6 +1600,18 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
 	return 0;
 }
 
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+static int dpaa_get_tstamp_ns(struct net_device *net_dev, u64 *ns,
+			      struct fman_port *port, const void *data)
+{
+	if (!fman_port_get_tstamp_field(port, data, ns)) {
+		be64_to_cpus(ns);
+		return 0;
+	}
+	return -EINVAL;
+}
+#endif
+
 /* Cleanup function for outgoing frame descriptors that were built on Tx path,
  * either contiguous frames or scatter/gather ones.
  * Skb freeing is not handled here.
@@ -1615,6 +1635,24 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
 	skbh = (struct sk_buff **)phys_to_virt(addr);
 	skb = *skbh;
 
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+	if (priv->tx_tstamp &&
+	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+		struct skb_shared_hwtstamps shhwtstamps;
+		u64 ns;
+
+		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+
+		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
+					priv->mac_dev->port[TX],
+					(void *)skbh)) {
+			shhwtstamps.hwtstamp = ns_to_ktime(ns);
+			skb_tstamp_tx(skb, &shhwtstamps);
+		} else {
+			dev_warn(dev, "dpaa_get_tstamp_ns failed!\n");
+		}
+	}
+#endif
 	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
 		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) +
@@ -2086,6 +2124,14 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	if (unlikely(err < 0))
 		goto skb_to_fd_failed;
 
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+	if (priv->tx_tstamp &&
+	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+		fd.cmd |= FM_FD_CMD_UPD;
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	}
+#endif
+
 	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) == 0))
 		return NETDEV_TX_OK;
 
@@ -2304,6 +2350,23 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	if (!skb)
 		return qman_cb_dqrr_consume;
 
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+	if (priv->rx_tstamp) {
+		struct skb_shared_hwtstamps *shhwtstamps;
+		u64 ns;
+
+		shhwtstamps = skb_hwtstamps(skb);
+		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+
+		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
+					priv->mac_dev->port[RX],
+					vaddr))
+			shhwtstamps->hwtstamp = ns_to_ktime(ns);
+		else
+			dev_warn(net_dev->dev.parent, "dpaa_get_tstamp_ns failed!\n");
+	}
+#endif
+
 	skb->protocol = eth_type_trans(skb, net_dev);
 
 	if (net_dev->features & NETIF_F_RXHASH && priv->keygen_in_use &&
@@ -2523,11 +2586,61 @@ static int dpaa_eth_stop(struct net_device *net_dev)
 	return err;
 }
 
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+static int dpaa_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+{
+	struct dpaa_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config config;
+
+	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		/* Couldn't disable rx/tx timestamping separately.
+		 * Do nothing here.
+		 */
+		priv->tx_tstamp = false;
+		break;
+	case HWTSTAMP_TX_ON:
+		priv->mac_dev->set_tstamp(priv->mac_dev->fman_mac, true);
+		priv->tx_tstamp = true;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	if (config.rx_filter == HWTSTAMP_FILTER_NONE) {
+		/* Couldn't disable rx/tx timestamping separately.
+		 * Do nothing here.
+		 */
+		priv->rx_tstamp = false;
+	} else {
+		priv->mac_dev->set_tstamp(priv->mac_dev->fman_mac, true);
+		priv->rx_tstamp = true;
+		/* TS is set for all frame types, not only those requested */
+		config.rx_filter = HWTSTAMP_FILTER_ALL;
+	}
+
+	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
+			-EFAULT : 0;
+}
+#endif /* CONFIG_FSL_DPAA_ETH_TS */
+
 static int dpaa_ioctl(struct net_device *net_dev, struct ifreq *rq, int cmd)
 {
-	if (!net_dev->phydev)
-		return -EINVAL;
-	return phy_mii_ioctl(net_dev->phydev, rq, cmd);
+	int ret = -EINVAL;
+
+	if (cmd == SIOCGMIIREG) {
+		if (net_dev->phydev)
+			return phy_mii_ioctl(net_dev->phydev, rq, cmd);
+	}
+
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+	if (cmd == SIOCSHWTSTAMP)
+		return dpaa_ts_ioctl(net_dev, rq, cmd);
+#endif
+	return ret;
 }
 
 static const struct net_device_ops dpaa_ops = {
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
index bd94220..e8214fc 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
@@ -182,6 +182,11 @@ struct dpaa_priv {
 
 	struct dpaa_buffer_layout buf_layout[2];
 	u16 rx_headroom;
+
+#ifdef CONFIG_FSL_DPAA_ETH_TS
+	bool tx_tstamp; /* Tx timestamping enabled */
+	bool rx_tstamp; /* Rx timestamping enabled */
+#endif
 };
 
 /* from dpaa_ethtool.c */
-- 
1.7.1
