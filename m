Return-Path: <yangbo.lu@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411g7L5XdqzF333
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 19:22:54 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 09/10] dpaa_eth: add support for hardware timestamping
Date: Thu,  7 Jun 2018 17:20:49 +0800
Message-Id: <20180607092050.46128-10-yangbo.lu@nxp.com>
In-Reply-To: <20180607092050.46128-1-yangbo.lu@nxp.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
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
Changes for v2:
	- Removed ifdef for timestamp code.
	- Minor fixes for code style.
Changes for v3:
	- Moved tstamp endianness conversion to fman API.
	- Fixed fm.cmd endianness.
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |   88 ++++++++++++++++++++++--
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h |    3 +
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index fd43f98..6a1c58a 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1168,7 +1168,7 @@ static int dpaa_eth_init_tx_port(struct fman_port *port, struct dpaa_fq *errq,
 	buf_prefix_content.priv_data_size = buf_layout->priv_data_size;
 	buf_prefix_content.pass_prs_result = true;
 	buf_prefix_content.pass_hash_result = true;
-	buf_prefix_content.pass_time_stamp = false;
+	buf_prefix_content.pass_time_stamp = true;
 	buf_prefix_content.data_align = DPAA_FD_DATA_ALIGNMENT;
 
 	params.specific_params.non_rx_params.err_fqid = errq->fqid;
@@ -1210,7 +1210,7 @@ static int dpaa_eth_init_rx_port(struct fman_port *port, struct dpaa_bp **bps,
 	buf_prefix_content.priv_data_size = buf_layout->priv_data_size;
 	buf_prefix_content.pass_prs_result = true;
 	buf_prefix_content.pass_hash_result = true;
-	buf_prefix_content.pass_time_stamp = false;
+	buf_prefix_content.pass_time_stamp = true;
 	buf_prefix_content.data_align = DPAA_FD_DATA_ALIGNMENT;
 
 	rx_p = &params.specific_params.rx_params;
@@ -1607,14 +1607,28 @@ static int dpaa_eth_refill_bpools(struct dpaa_priv *priv)
 {
 	const enum dma_data_direction dma_dir = DMA_TO_DEVICE;
 	struct device *dev = priv->net_dev->dev.parent;
+	struct skb_shared_hwtstamps shhwtstamps;
 	dma_addr_t addr = qm_fd_addr(fd);
 	const struct qm_sg_entry *sgt;
 	struct sk_buff **skbh, *skb;
 	int nr_frags, i;
+	u64 ns;
 
 	skbh = (struct sk_buff **)phys_to_virt(addr);
 	skb = *skbh;
 
+	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
+
+		if (!fman_port_get_tstamp(priv->mac_dev->port[TX], (void *)skbh,
+					  &ns)) {
+			shhwtstamps.hwtstamp = ns_to_ktime(ns);
+			skb_tstamp_tx(skb, &shhwtstamps);
+		} else {
+			dev_warn(dev, "fman_port_get_tstamp failed!\n");
+		}
+	}
+
 	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
 		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) +
@@ -2086,6 +2100,11 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	if (unlikely(err < 0))
 		goto skb_to_fd_failed;
 
+	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
+		fd.cmd |= cpu_to_be32(FM_FD_CMD_UPD);
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	}
+
 	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) == 0))
 		return NETDEV_TX_OK;
 
@@ -2227,6 +2246,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 						struct qman_fq *fq,
 						const struct qm_dqrr_entry *dq)
 {
+	struct skb_shared_hwtstamps *shhwtstamps;
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa_percpu_priv *percpu_priv;
 	const struct qm_fd *fd = &dq->fd;
@@ -2240,6 +2260,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	struct sk_buff *skb;
 	int *count_ptr;
 	void *vaddr;
+	u64 ns;
 
 	fd_status = be32_to_cpu(fd->status);
 	fd_format = qm_fd_get_format(fd);
@@ -2304,6 +2325,16 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	if (!skb)
 		return qman_cb_dqrr_consume;
 
+	if (priv->rx_tstamp) {
+		shhwtstamps = skb_hwtstamps(skb);
+		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
+
+		if (!fman_port_get_tstamp(priv->mac_dev->port[RX], vaddr, &ns))
+			shhwtstamps->hwtstamp = ns_to_ktime(ns);
+		else
+			dev_warn(net_dev->dev.parent, "fman_port_get_tstamp failed!\n");
+	}
+
 	skb->protocol = eth_type_trans(skb, net_dev);
 
 	if (net_dev->features & NETIF_F_RXHASH && priv->keygen_in_use &&
@@ -2523,11 +2554,58 @@ static int dpaa_eth_stop(struct net_device *net_dev)
 	return err;
 }
 
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
+	if (cmd == SIOCSHWTSTAMP)
+		return dpaa_ts_ioctl(net_dev, rq, cmd);
+
+	return ret;
 }
 
 static const struct net_device_ops dpaa_ops = {
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
index bd94220..af320f8 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
@@ -182,6 +182,9 @@ struct dpaa_priv {
 
 	struct dpaa_buffer_layout buf_layout[2];
 	u16 rx_headroom;
+
+	bool tx_tstamp; /* Tx timestamping enabled */
+	bool rx_tstamp; /* Rx timestamping enabled */
 };
 
 /* from dpaa_ethtool.c */
-- 
1.7.1
